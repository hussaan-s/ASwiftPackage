//
//  File.swift
//  
//
//  Created by Hussaan S on 16/08/2021.
//

import UIKit

public class MainViewController: UIViewController {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Welcome To Swift Package"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
        
        let coreDataStack = CoreDataStack()
        let dataStore = CDEntityCoreDataStore(coreDataStack: coreDataStack)
        
        dataStore.changeObserver = { [weak dataStore, weak self] in
            do {
                let entities = try dataStore?.fetchCDEntities()
                self?.label.text = entities?.first?.test
            } catch {
                
            }
        }
        
        let cdEntity = dataStore.createCDEntity()
        cdEntity.test = "Core Data test"
        dataStore.saveCDEntity(cdEntity)

    }
    
}
