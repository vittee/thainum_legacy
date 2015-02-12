package com.vittee.thainum.digitizer;

import com.vittee.thainum.provider.DigitNameProvider;

import java.util.ArrayList;
import java.util.List;

/**
 * @author vittee
 */
public class DefaultDigitizer implements Digitizer {

    public DefaultDigitizer() {

    }

    public int[] digitize(long l) {
        char[] chars = String.format("%.0f", (double) l).toCharArray();
        List<Integer> digitized = new ArrayList<Integer>();

        for (char c : chars) {
            if (Character.isDigit(c)) {
                digitized.add(Character.digit(c, 10));
            }
        }

        int[] result = new int[digitized.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = digitized.get(i);
        }

        return result;
    }

    public String[] digitize(long l, DigitNameProvider nameProvider) {
        int[] digits = digitize(l);
        String[] result = new String[digits.length];

        for (int i = 0; i < result.length; i++) {
            result[i] = nameProvider.getName(digits[i]);
        }

        return result;
    }

    @Override
    public String[] digitize(String s, DigitNameProvider nameProvider) {
        char[] chars = s.toCharArray();

        List<Integer> digitized = new ArrayList<Integer>();

        for (char c : chars) {
            if (Character.isDigit(c)) {
                digitized.add(Character.digit(c, 10));
            }
        }

        String[] result = new String[digitized.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = nameProvider.getName(digitized.get(i));
        }

        return result;
    }
}
