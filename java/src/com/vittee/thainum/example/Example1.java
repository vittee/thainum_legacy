package com.vittee.thainum.example;

import com.vittee.thainum.ThaiNum;

public class Example1 {
    public static void main(String[] args) {
        ThaiNum thaiNum = new ThaiNum();

        System.out.println(thaiNum.text(1234.00002));

        double[] values = new double[] { 121.25650, -51.595013, 111.80 };
        for (double v : values) {
            System.out.println(thaiNum.bahtText(v));
        }
    }
}
