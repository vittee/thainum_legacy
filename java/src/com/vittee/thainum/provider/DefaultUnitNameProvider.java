package com.vittee.thainum.provider;

public class DefaultUnitNameProvider extends BaseNameProvider implements UnitNameProvider {

    public DefaultUnitNameProvider() {
        super("", "สิบ", "ร้อย", "พัน", "หมื่น", "แสน", "ล้าน");
    }
}
