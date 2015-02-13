using System;

namespace ThaiNum.Library.Provider
{
    public class BaseNameProvider : INameProvider
    {
        private readonly String[] _names;

        public BaseNameProvider(params String[] names)
        {
            this._names = names;
        }

        public String this[int i] {
            get
            {
                return _names[i];
            }
        }
    }
}
