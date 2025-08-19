//
//  ViewController3.swift
//  OCTemp
//
//  Created by jingwei on 2025/6/12.
//

import UIKit

class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

class ViewController4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
class ViewController5: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}


extension ViewController3: @preconcurrency WJRouterProtocol {
    @objc static func pageName() -> String! {
        return "Main"
    }
    
    static func create(withParameters parameters: [AnyHashable : Any]!, object: Any!) -> (any UIViewController & WJRouterProtocol)! {
        let vc = ViewController3()
        vc.view.backgroundColor = .gray
        return vc
    }
}
