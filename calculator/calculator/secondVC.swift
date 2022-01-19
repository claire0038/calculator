//
//  secondVC.swift
//  test
//
//  Created by pingu on 2022/1/16.
//

import UIKit
class secondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lable.text = String(Int(0))
        lable.adjustsFontSizeToFitWidth = true
    }
    
    @IBOutlet weak var lable: UILabel!
    var num1:Double? //第一次的值
    var num2:Double? //按運算符號後的值
    var operationSign:String? //運算符號
    var result:Double? //結果
    var typing:Bool = false // 是否正在輸入（沒有點選其他功能鍵）
    var equal:Bool? //是否按下等於
    var typeOperation = false //判斷正負號，false代表沒有輸入需要變負號的值
    
    var input: Double{
        get{// 將使用者輸入的值傳回
            return Double(lable.text!)!
        }
        set{//於lable顯示
            lable.text = "\(formatDecimal(num: newValue))"
            typing = false
        }
    }
    
    // 計算小數格式化
    func formatDecimal(num: Double) -> String{
        var formatNum = ""
        if num != 0{
            if num.truncatingRemainder(dividingBy: 1.0)==0.0{
                formatNum = String(format: "%.0f",num)
            }else if (num*10).truncatingRemainder(dividingBy: 1.0)==0.0{
                formatNum = String(format: "%.1f",num)
            }else if (num*100).truncatingRemainder(dividingBy: 1.0)==0.0{
                formatNum = String(format: "%.2f",num)
            }else if (num * 1000).truncatingRemainder(dividingBy: 1.0)==0.0{
                formatNum = String(format: "%.3f",num)
            }else if (num * -1).truncatingRemainder(dividingBy: 1.0)==0.0{
                formatNum = String(format: "%.0f",num)
            }else if (num * -10).truncatingRemainder(dividingBy: 1.0)==0.0{
                formatNum = String(format: "%.1f",num)
            }else if (num * -100).truncatingRemainder(dividingBy: 1.0)==0.0{
                formatNum = String(format: "%.2f",num)
            }else if (num * -1000).truncatingRemainder(dividingBy: 1.0)==0.0{
                formatNum = String(format: "%.3f",num)
            }else{
                formatNum = String(format: "%.10f", num)
            }
        }else{
            formatNum = "0"
        }
        return formatNum
    }
    
    //按數字
    @IBAction func numberbtn(_ sender: UIButton){
        if let number = sender.titleLabel?.text
        {//如果已輸入其他數字則串起來
            if typing{
                lable.text = lable.text! + number
            }
            //第一次輸入
            else{
                if number != "0"{
                    if number == "."{
                        lable.text = "0."
                        typing = true
                    }else{
                        lable.text = number
                        typing = true
                    }
                }
                //如果第一次輸入0，依然顯示0
                else{
                    lable.text = "0"
                    typing = false
                }
            }
            typeOperation = false
        }
    }
    
    //算式 + - * /
    func operation (num1: Double,num2: Double)->Double{
        switch operationSign{
        case "+":
            result = num1+num2
        case "-":
            result = num1-num2
        case "*":
            result = num1*num2
        case "/":
            result = num1/num2
        default:
            break
        }
        return result!
    }
    //算式 !
    func fac (num1: Double)->Double{
        var sum:Double = 1
        for n in 1...Int(num1){
            sum = sum*Double(n)
        }
        result = sum
        return result!
    }
    
    //  運算符號點選
    @IBAction func operationBtnPressed(_ sender: UIButton) {
        //  若沒有按過等於，進入計算
        if equal == false {
            //  之前沒有點選過運算符號
            if operationSign == nil{
                //  抓出運算符號
                operationSign = sender.titleLabel?.text
                //  將值計入至畫面上label
                num1 = input
                // 若使用者點選！
                if operationSign == "!"{
                    //  結果暫存檔
                    var tempResult:Double = 0
                    //  運算
                    tempResult = fac(num1: num1 ?? 0)
                    //  顯示於畫面上
                    input = tempResult
                    //  設定使用者點選過 = 鍵計算過結果
                    equal = true
                }
                //  上一次的輸入已經結束
                typing = false
            }//  之前有點選過運算符號
            else{
                //  抓出運算符號
                operationSign = sender.titleLabel?.text
                //  將結果放回第一個值
                num1 = input
                // 若使用者點選！
                if operationSign == "!"{
                    //  結果暫存檔
                    var tempResult:Double = 0
                    //  運算
                    tempResult = fac(num1: num1 ?? 0)
                    //  顯示於畫面上
                    input = tempResult
                    //  設定使用者點選過=鍵計算過結果
                    equal = true
                }
                //  上一次的輸入已經結束
                typing = false
            }
        //  已按過 = ，將結果放到第一個值，等待按下一次的運算符號
        }
        else{//  抓出運算符號
            operationSign = sender.titleLabel?.text
            //  將結果放回第一個值
            num1 = input
            //若使用者點選！，不用按=直接跳出結果
            if operationSign == "!"{
                //  結果暫存
                var tempResult:Double = 0
                //  運算
                tempResult = fac(num1: num1 ?? 0)
                //  顯示於畫面上
                input = tempResult
                //  設定點選過 = 鍵
                equal = true
            }// 其他運算符
            else{
                //  重新計算，設定沒按過 =
                equal = false
            }
            //  上一次的輸入已經結束
            typing = false
        }
    }
    
    //  等於
    @IBAction func equality(_ sender: UIButton) {
        //  認為使用者輸入完畢
        typing = false
        //  結果暫存
        var tempResult:Double = 0
        //  若沒有按過等於
        if equal == false {
            //  若抓到運算符號
            if operationSign != nil {
                //  抓取第二個值
                num2 = input
                //  運算
                tempResult = operation(num1: num1 ?? 0, num2: num2 ?? 0)
                //  顯示於畫面上
                input = tempResult
                //  設定使用者點選過=鍵計算過結果
                equal = true
            }
        //  若有按過等於
        } else {
            //將畫面上的結果丟給第一個值
            num1 = input
            //清除num2
            num2 = nil
        }
        typeOperation = false
    }
    
    //clear 全部清除
    @IBAction func clearbtn(_ sender:UIButton){
        input = 0
        result = nil
        num1 = nil
        num2 = nil
        operationSign = nil
        equal = false
        typing = false
        typeOperation = false
    }
}
