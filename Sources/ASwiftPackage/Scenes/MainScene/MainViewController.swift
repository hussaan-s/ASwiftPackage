//
//  File.swift
//  
//
//  Created by Hussaan S on 16/08/2021.
//

import UIKit

public class MainViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
    
}
