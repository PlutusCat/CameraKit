//
//  CameraClipViewController.swift
//  CameraKit
//
//  Created by PlutusCat on 2018/12/25.
//  Copyright © 2018 CameraKit. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class CameraClipViewController: UIViewController {

    var photo: AVCapturePhoto!
    var finishBlock: (() -> ())!

    private var finishBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Complete_icon"), for: .normal)
        button.addTarget(self, action: #selector(finishAction), for: .touchUpInside)
        return button
    }()

    private var remakeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Remake_icon"), for: .normal)
        button.addTarget(self, action: #selector(remakeAction), for: .touchUpInside)
        return button
    }()

    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var cameraClipView: CameraClipView = {
        let clip = CameraClipView()
        return clip
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

//        imageView.image = UIImage(data: photo.fileDataRepresentation()!)
//        view.addSubview(imageView)

        cameraClipView.image = UIImage(data: photo.fileDataRepresentation()!)
        view.addSubview(cameraClipView)

        view.addSubview(finishBtn)
        view.addSubview(remakeBtn)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        imageView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }

        cameraClipView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        remakeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.bottom.equalToSuperview().inset(SafeLayout.getSafeArea().bottom+20)
        }
        finishBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.size.equalTo(CGSize(width: 54, height: 40))
            make.centerY.equalTo(remakeBtn)
        }
    }

    @objc private func finishAction() {
        let object = ["data": photo]
        NotificationCenter.default.post(name: NotificationName.cameraFinish, object: object)
        dismiss(animated: true) {
            if let call = self.finishBlock {
                call()
            }
        }
    }

    @objc private func remakeAction() {
        dismiss(animated: true, completion: nil)
    }

    deinit {
        print("*** CameraClipViewController - deinit ***")
    }
}
