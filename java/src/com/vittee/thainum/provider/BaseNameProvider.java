package com.vittee.thainum.provider;

public class BaseNameProvider implements NameProvider {

    private final String[] strings;

    public BaseNameProvider(String... strings) {
        this.strings = strings;
    }

    @Override
    public String getName(int i) {
        return strings[i];
    }
}
