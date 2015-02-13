package com.vittee.thainum.provider;

public class BaseNameProvider implements NameProvider {

    private final String[] names;

    public BaseNameProvider(String... names) {
        this.names = names;
    }

    @Override
    public String getName(int i) {
        return names[i];
    }
}
