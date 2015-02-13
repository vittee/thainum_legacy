package com.vittee.thainum;

import com.vittee.thainum.digitizer.DefaultDigitizer;
import com.vittee.thainum.digitizer.Digitizer;
import com.vittee.thainum.provider.DefaultDigitNameProvider;
import com.vittee.thainum.provider.DefaultUnitNameProvider;
import com.vittee.thainum.provider.DigitNameProvider;
import com.vittee.thainum.provider.UnitNameProvider;

/**
 * @author vittee
 */
public class ThaiNum {
    private Digitizer digitizer;
    private DigitNameProvider digitNameProvider;
    private UnitNameProvider unitNameProvider;

    public ThaiNum() {
        this(new DefaultDigitizer());
    }

    public ThaiNum(Digitizer digitizer) {
        this(digitizer, new DefaultDigitNameProvider());
    }

    public ThaiNum(Digitizer digitizer, DigitNameProvider digitNameProvider) {
        this(digitizer, digitNameProvider, new DefaultUnitNameProvider());
    }

    public ThaiNum(Digitizer digitizer, DigitNameProvider digitNameProvider, UnitNameProvider unitNameProvider) {
        this.digitizer = digitizer;
        this.digitNameProvider = digitNameProvider;
        this.unitNameProvider = unitNameProvider;
    }

    private String convert(long l) {
        int[] digits = digitizer.digitize(l);

        if (digits.length == 1) {
            return digitNameProvider.getName(digits[0]);
        }

        boolean t = false;
        StringBuilder sb = new StringBuilder();

        if (l < 0) {
            sb.append("ลบ");
        }

        for (int i = 0; i < digits.length; i++) {
            int d = digits[i];
            int c = (digits.length - i - 1) % 6;

            if (d == 2 && c == 1) {
                sb.append("ยี่");
            } else if (d == 1 && c == 0 && t) {
                sb.append("เอ็ด");
            } else if ((d != 1 || c != 1) && (d != 0)) {
                sb.append(digitNameProvider.getName(d));
            }

            if (c != 0 && d != 0) {
                sb.append(unitNameProvider.getName(c));
            }

            if (c == 0 && i != digits.length - 1) {
                sb.append(unitNameProvider.getName(6));
            }

            if (c == 1) {
                t = d != 0;
            }
        }

        return sb.toString();
    }

    public String text(double d) {
        Part p = new Part(d);

        StringBuilder sb = new StringBuilder();
        sb.append(convert(p.i));

        if (p.f != 0) {
            sb.append("จุด");

            String[] pp = String.format("%f", d).split("\\.");
            String fs = pp[pp.length - 1].replaceAll("0*$", "");

            String[] digitized = digitizer.digitize(fs, digitNameProvider);

            for (String ds : digitized) {
                sb.append(ds);
            }
        }

        return sb.toString();
    }

    public String bahtText(double d) {
        Part p = new Part(d);

        StringBuilder sb = new StringBuilder();
        sb.append(convert(p.i));
        sb.append("บาท");

        if (p.f != 0) {
            String[] pp = String.format("%f", d).split("\\.");
            String fs = pp[pp.length - 1];

            long satang = Long.parseLong(fs.substring(0, Math.min(fs.length(), 2)));

            sb.append(convert(satang));
            sb.append("สตางค์");
        }

        return sb.toString();
    }

    private static class Part {

        private int i;
        private double f;

        public Part(double d) {
            i = (int) d;
            f = d - i;
        }


        @Override
        public String toString() {
            return String.format("[Part i:%d, f:%f]", i, f);
        }
    }
}
