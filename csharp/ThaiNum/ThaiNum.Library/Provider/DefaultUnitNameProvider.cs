namespace ThaiNum.Library.Provider
{
    class DefaultUnitNameProvider : BaseNameProvider, IUnitNameProvider
    {
        public DefaultUnitNameProvider()
            : base("", "สิบ", "ร้อย", "พัน", "หมื่น", "แสน", "ล้าน")
        {

        }
    }
}
