using System;

using ThaiNum.Library.Provider;

namespace ThaiNum.Library.Digitizer
{
    public interface IDigitizer
    {
        byte[] Digitize(long l);
        String[] Digitize(long l, IDigitNameProvider nameProvider);
        String[] Digitize(String s, IDigitNameProvider nameProvider);
    }
}
