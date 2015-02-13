namespace ThaiNum.Library.Provider
{
    public class DefaultDigitNameProvider : BaseNameProvider, IDigitNameProvider
    {
        public DefaultDigitNameProvider() 
            : base("ศูนย์", "หนึ่ง", "สอง", "สาม", "สี่", "ห้า", "หก", "เจ็ด", "แปด", "เก้า")
        {
            
        }
    }
}
