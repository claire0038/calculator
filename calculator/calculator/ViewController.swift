//
//  ViewController.swift
//  test
//
//  Created by pingu on 2022/1/16.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet var field: UITextField!
    @IBOutlet var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        field.returnKeyType = .done
        field.autocorrectionType = .no
    }
    @IBAction func buttonTapped(){
        if field.text?.isEmpty == true{
            let controller = UIAlertController(title: "未填寫姓名", message: "請填寫姓名", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
    }
}
