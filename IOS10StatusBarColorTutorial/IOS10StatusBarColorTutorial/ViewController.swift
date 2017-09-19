//
//  ViewController.swift
//  IOS10StatusBarColorTutorial
//
//  Created by xubojoy on 2017/6/5.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        class aClass{
            var value = 1
        }
        
        let c1 = aClass()
        let c2 = aClass()
        
        let fSpec = {
            [unowned c1, weak c2] in
            c1.value = 42
            if let c2o = c2 {
                c2o.value = 42
            }
        }
        
        class bClass{
            var n = 2
        }
        
        fSpec()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

