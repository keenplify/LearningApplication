using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearningApplication.Helpers
{
    public class Strings
    {
        public static string GetColumnName(int index)
        {
            const string letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

            var value = "";

            if (index >= letters.Length)
                value += letters[index / letters.Length - 1];

            value += letters[index % letters.Length];

            return value;
        }
    }
}