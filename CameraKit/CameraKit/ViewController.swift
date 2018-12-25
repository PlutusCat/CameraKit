//
//  ViewController.swift
//  CameraKit
//
//  Created by PlutusCat on 2018/12/24.
//  Copyright © 2018 CameraKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(imageView)

        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10,
                                                             left: 10,
                                                             bottom: 10,
                                                             right: 10))
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let vc = CameraViewController.viewController { (image) in
            self.imageView.image = image
        }
        present(vc, animated: true) {
            print("**** 弹出相机界面 ****")
        }
    }


}

