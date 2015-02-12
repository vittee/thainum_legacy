package com.vittee.thainum.provider;

public class DefaultDigitNameProvider extends BaseNameProvider implements DigitNameProvider {

    public DefaultDigitNameProvider() {
        super("ศูนย์", "หนึ่ง", "สอง", "สาม", "สี่", "ห้า", "หก", "เจ็ด", "แปด", "เก้า");
    }
}
