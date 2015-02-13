using System;
using System.Collections.Generic;

using ThaiNum.Library.Provider;

namespace ThaiNum.Library.Digitizer
{
    public class DefaultDigitizer : IDigitizer
    {
        public byte[] Digitize(long l)
        {
            char[] chars = l.ToString().ToCharArray();
            List<byte> digitized = new List<byte>();

            foreach (char c in chars)
            {
                if (Char.IsDigit(c))
                {
                    digitized.Add(Byte.Parse(c.ToString()));
                }
            }

            return digitized.ToArray();
        }

        public String[] Digitize(long l, IDigitNameProvider nameProvider)
        {
            byte[] digits = Digitize(l);
            String[] result = new String[digits.Length];

            for (int i = 0; i < result.Length; i++)
            {
                result[i] = nameProvider[digits[i]];
            }

            return result;
        }

        public String[] Digitize(String s, IDigitNameProvider nameProvider)
        {
            char[] chars = s.ToCharArray();

            List<String> result = new List<String>();

            foreach (char c in chars)
            {
                if (Char.IsDigit(c))
                {
                    result.Add(nameProvider[Byte.Parse(c.ToString())]);
                }
            }

            return result.ToArray();
        }
    }
}
