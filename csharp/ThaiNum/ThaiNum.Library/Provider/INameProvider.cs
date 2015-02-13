using System;

namespace ThaiNum.Library.Provider
{
    public interface INameProvider
    {
        String this[int i]
        {
            get;
        }
    }
}
