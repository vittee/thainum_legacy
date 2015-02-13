using System;
using System.Text;
using System.Text.RegularExpressions;
using ThaiNum.Library.Digitizer;
using ThaiNum.Library.Provider;

namespace ThaiNum.Library
{
    public class ThaiNumConverter
    {
        private IDigitizer digitizer;
        private IDigitNameProvider digitNameProvider;
        private IUnitNameProvider unitNameProvider;

        public ThaiNumConverter() 
            : this(new DefaultDigitizer())
        {
            
        }

        public ThaiNumConverter(IDigitizer digitizer) 
            : this(digitizer, new DefaultDigitNameProvider())
        {

        }

        public ThaiNumConverter(IDigitizer digitizer, IDigitNameProvider digitNameProvider)
            : this(digitizer, digitNameProvider, new DefaultUnitNameProvider())
        {

        }

        public ThaiNumConverter(IDigitizer digitizer, IDigitNameProvider digitNameProvider, IUnitNameProvider unitNameProvider)
        {
            this.digitizer = digitizer;
            this.digitNameProvider = digitNameProvider;
            this.unitNameProvider = unitNameProvider;
        }

        public String Convert(long l)
        {
            byte[] digits = digitizer.Digitize(l);

            if (digits.Length == 1)
            {
                return digitNameProvider[digits[0]];
            }

            bool t = false;
            StringBuilder sb = new StringBuilder();

            if (l < 0)
            {
                sb.Append("ลบ");
            }

            for (int i = 0; i < digits.Length; i++)
            {
                int d = digits[i];
                int c = (digits.Length - i - 1) % 6;

                if (d == 2 && c == 1)
                {
                    sb.Append("ยี่");
                }
                else if (d == 1 && c == 0 && t)
                {
                    sb.Append("เอ็ด");
                }
                else if ((d != 1 || c != 1) && (d != 0))
                {
                    sb.Append(digitNameProvider[d]);
                }

                if (c != 0 && d != 0)
                {
                    sb.Append(unitNameProvider[c]);
                }

                if (c == 0 && i != digits.Length - 1)
                {
                    sb.Append(unitNameProvider[6]);
                }

                if (c == 1)
                {
                    t = d != 0;
                }
            }

            return sb.ToString();
        }

        public String Text(double d)
        {
            Part p = new Part(d);

            StringBuilder sb = new StringBuilder();
            sb.Append(Convert(p.i));

            if (p.f != 0)
            {               
                String[] pp = String.Format("{0:F20}", d).Split(new char[] { '.' }, 2);
                String fs = new Regex("0*$").Replace(pp[pp.Length - 1], "");

                if (fs.Length != 0)
                {
                    sb.Append("จุด");

                    String[] digitized = digitizer.Digitize(fs, digitNameProvider);

                    foreach (String ds in digitized)
                    {
                        sb.Append(ds);
                    }
                }
            }

            return sb.ToString();
        }

        public String BahtText(double d)
        {
            Part p = new Part(d);

            StringBuilder sb = new StringBuilder();
            sb.Append(Convert(p.i));
            sb.Append("บาท");

            if (p.f != 0)
            {
                String[] pp = String.Format("{0:F20}", d).Split(new char[] { '.' }, 2);
                String fs = pp[pp.Length - 1];

                long satang = Int64.Parse(fs.Substring(0, Math.Min(fs.Length, 2)));

                sb.Append(Convert(satang));
                sb.Append("สตางค์");
            }

            return sb.ToString();
        }

        private class Part
        {
            internal long i;
            internal double f;

            internal Part(double d)
            {
                if (d < 1e20)
                {
                    i = (long)d;
                    f = d - i;
                }
            }
        }
    }
}
