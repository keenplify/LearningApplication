using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearningApplication.Helpers
{
    public class Cookie
    {
        /// <summary>
        /// Stores a value in a user Cookie, creating it if it doesn't exists yet.
        /// </summary>
        /// <param name="cookieName">Cookie name</param>
        /// <param name="cookieDomain">Cookie domain (or NULL to use default domain value)</param>
        /// <param name="keyName">Cookie key name (if the cookie is a keyvalue pair): if NULL or EMPTY, the cookie will be treated as a single variable.</param>
        /// <param name="value">Value to store into the cookie</param>
        /// <param name="expirationDate">Expiration Date (set it to NULL to leave default expiration date)</param>
        /// <param name="httpOnly">set it to TRUE to enable HttpOnly, FALSE otherwise (default: false)</param>
        /// <param name="sameSite">set it to 'None', 'Lax', 'Strict' or '(-1)' to not add it (default: '(-1)').</param>
        /// <param name="secure">set it to TRUE to enable Secure (HTTPS only), FALSE otherwise</param>
        public static void StoreInCookie(
            string cookieName,
            string cookieDomain,
            string keyName,
            string value,
            DateTime? expirationDate,
            bool httpOnly = false,
            SameSiteMode sameSite = (SameSiteMode)(-1),
            bool secure = false)
        {
            // NOTE: we have to look first in the response, and then in the request.
            // This is required when we update multiple keys inside the cookie.
            HttpCookie cookie = HttpContext.Current.Response.Cookies.AllKeys.Contains(cookieName)
                ? HttpContext.Current.Response.Cookies[cookieName]
                : HttpContext.Current.Request.Cookies[cookieName];

            if (cookie == null) cookie = new HttpCookie(cookieName);
            if (!String.IsNullOrEmpty(keyName)) cookie.Values.Set(keyName, value);
            else cookie.Value = value;
            if (expirationDate.HasValue) cookie.Expires = expirationDate.Value;
            if (!String.IsNullOrEmpty(cookieDomain)) cookie.Domain = cookieDomain;
            if (httpOnly) cookie.HttpOnly = true;
            cookie.Secure = secure;
            cookie.SameSite = sameSite;
            HttpContext.Current.Response.Cookies.Set(cookie);
        }

        /// <summary>
        /// Stores multiple values in a Cookie using a key-value dictionary, creating the cookie (and/or the key) if it doesn't exists yet.
        /// </summary>
        /// <param name="cookieName">Cookie name</param>
        /// <param name="cookieDomain">Cookie domain (or NULL to use default domain value)</param>
        /// <param name="keyName">Cookie key name (if the cookie is a keyvalue pair): if NULL or EMPTY, this method will raise an exception since it's required when inserting multiple values.</param>
        /// <param name="values">Values to store into the cookie</param>
        /// <param name="expirationDate">Expiration Date (set it to NULL to leave default expiration date)</param>
        /// <param name="httpOnly">set it to TRUE to enable HttpOnly, FALSE otherwise (default: false)</param>
        /// <param name="sameSite">set it to 'None', 'Lax', 'Strict' or '(-1)' to not add it (default: '(-1)').</param>
        /// <param name="secure">set it to TRUE to enable Secure (HTTPS only), FALSE otherwise</param>
        public static void StoreInCookieDictionary(
            string cookieName,
            string cookieDomain,
            Dictionary<string, string> keyValueDictionary,
            DateTime? expirationDate,
            bool httpOnly = false,
            SameSiteMode sameSite = (SameSiteMode)(-1),
            bool secure = false)
        {
            // NOTE: we have to look first in the response, and then in the request.
            // This is required when we update multiple keys inside the cookie.
            HttpCookie cookie = HttpContext.Current.Response.Cookies.AllKeys.Contains(cookieName)
                ? HttpContext.Current.Response.Cookies[cookieName]
                : HttpContext.Current.Request.Cookies[cookieName];

            if (cookie == null) cookie = new HttpCookie(cookieName);
            if (keyValueDictionary == null || keyValueDictionary.Count == 0)
                cookie.Value = null;
            else
                foreach (var kvp in keyValueDictionary)
                    cookie.Values.Set(kvp.Key, kvp.Value);
            if (expirationDate.HasValue) cookie.Expires = expirationDate.Value;
            if (!String.IsNullOrEmpty(cookieDomain)) cookie.Domain = cookieDomain;
            if (httpOnly) cookie.HttpOnly = true;
            cookie.Secure = secure;
            cookie.SameSite = sameSite;
            HttpContext.Current.Response.Cookies.Set(cookie);
        }
        public static string GetFromCookie(string cookieName, string keyName)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];
            if (cookie != null)
            {
                string val = (!String.IsNullOrEmpty(keyName)) ? cookie[keyName] : cookie.Value;
                if (!String.IsNullOrEmpty(val)) return Uri.UnescapeDataString(val);
            }
            return null;
        }

        public static void RemoveCookie(string cookieName, string keyName, string domain)
        {
            if (HttpContext.Current.Request.Cookies[cookieName] != null)
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];

                // SameSite.None Cookies won't be accepted by Google Chrome and other modern browsers if they're not secure, which would lead in a "non-deletion" bug.
                // in this specific scenario, we need to avoid emitting the SameSite attribute to ensure that the cookie will be deleted.
                if (cookie.SameSite == SameSiteMode.None && !cookie.Secure)
                    cookie.SameSite = (SameSiteMode)(-1);

                if (String.IsNullOrEmpty(keyName))
                {
                    cookie.Expires = DateTime.UtcNow.AddYears(-1);
                    if (!String.IsNullOrEmpty(domain)) cookie.Domain = domain;
                    HttpContext.Current.Response.Cookies.Add(cookie);
                    HttpContext.Current.Request.Cookies.Remove(cookieName);
                }
                else
                {
                    cookie.Values.Remove(keyName);
                    if (!String.IsNullOrEmpty(domain)) cookie.Domain = domain;
                    HttpContext.Current.Response.Cookies.Add(cookie);
                }
            }
        }

        /// <summary>
        /// Checks if a cookie / key exists in the current HttpContext.
        /// </summary>
        public static bool CookieExist(string cookieName, string keyName)
        {
            HttpCookieCollection cookies = HttpContext.Current.Request.Cookies;
            return (String.IsNullOrEmpty(keyName))
                ? cookies[cookieName] != null
                : cookies[cookieName] != null && cookies[cookieName][keyName] != null;
        }
    }
}