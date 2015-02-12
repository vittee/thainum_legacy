package com.vittee.thainum.digitizer;

import com.vittee.thainum.provider.DigitNameProvider;

/**
 * @author vittee
 */
public interface Digitizer {
    int[] digitize(long l);
    String[] digitize(long l, DigitNameProvider nameProvider);
    String[] digitize(String s, DigitNameProvider nameProvider);
}
