//
//  ThaiNumTests.swift
//  ThaiNumTests
//
//  Created by Wittawas Nakkasem on 2/14/2558 BE.
//  Copyright (c) 2558 vittee. All rights reserved.
//

import Cocoa
import XCTest

import ThaiNum

class ThaiNumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testText() {
        XCTAssertEqual(ThaiNum.text(0), "ศูนย์", "อ่านเลขโดด 0")
        XCTAssertEqual(ThaiNum.text(-2), "ลบสอง", "อ่านเลขโดดติดลบ -2")
        XCTAssertEqual(ThaiNum.text(10), "สิบ", "ต้องไม่มี หนึ่ง หรือ ศูนย์ อ่านเฉพาะหลักว่า สิบ")
        XCTAssertEqual(ThaiNum.text(11), "สิบเอ็ด", "ต้องอ่านเลข 1 หลักหน่วยว่า เอ็ด")
        XCTAssertEqual(ThaiNum.text(20), "ยี่สิบ", "ต้องอ่านเลข 2 ในหลักสิบว่า ยี่")
        XCTAssertEqual(ThaiNum.text(21), "ยี่สิบเอ็ด", "ต้องอ่านเลข 2 ในหลักสิบว่า ยี่ และเลข 1 ในหลักหน่วยว่า เอ็ด")
        XCTAssertEqual(ThaiNum.text(123), "หนึ่งร้อยยี่สิบสาม", "เลข 1 ในหลักอื่นๆต้องอ่านว่า หนึ่ง")
        XCTAssertEqual(ThaiNum.text(101), "หนึ่งร้อยหนึ่ง", "เลข 1 ในหลักหน่วยว่า หนึ่ง ถ้าหลักสิบเป็นศูนย์")
        XCTAssertEqual(ThaiNum.text(100), "หนึ่งร้อย", "ต้องไม่อ่านแค่หลัก ต้องอ่านโดยบอกจำนวนด้วย")
    }
    
    func testTextDecimal() {
        XCTAssertEqual(ThaiNum.text(0.123), "ศูนย์จุดหนึ่งสองสาม", "อ่านทศนิยม")
        XCTAssertEqual(ThaiNum.text(0.000987), "ศูนย์จุดศูนย์ศูนย์ศูนย์เก้าแปดเจ็ด", "อ่านทศนิยมที่มี 0 นำหน้า")
    }
    
    func testBahtText() {
        XCTAssertEqual(ThaiNum.bahtText(0), "ศูนย์บาท", "เลขโดด")
        XCTAssertEqual(ThaiNum.bahtText(-2), "ลบสองบาท", "เลขโดดติดลบ")
        XCTAssertEqual(ThaiNum.bahtText(10.25), "สิบบาทยี่สิบห้าสตางค์", "อ่านหน่วยสตางค์")
        XCTAssertEqual(ThaiNum.bahtText(21.2), "ยี่สิบเอ็ดบาทยี่สิบสตางค์", "อ่านหน่วยสตางค์ที่ไม่มี 0 ลงท้าย")
        XCTAssertEqual(ThaiNum.bahtText(300.75), "สามร้อยบาทเจ็ดสิบห้าสตางค์", "อ่านหน่วยสตางค์ที่ไม่มี 0 ลงท้าย")
    }
}
