//
//  ViewController.swift
//  Homework
//
//  Created by Denis Bystruev on 17.07.2020.
//  Copyright © 2020 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagField: UITextField!
    
    // MARK: - Properties
    var rate: Double? {
        didSet {
            updateUI()
        }
    }
    var tag: String = ""

    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: - IB Actions
extension ViewController {
    
    @IBAction func getRateButton() {
        guard let tag = tagField.text?.uppercased(), !tag.isEmpty else {
            return
        }
        
        NetworkManager.shared.getRate(tag: tag) { rate in
            self.rate = rate
            self.tag = tag
        }
    }
}

// MARK: - UIResponder
extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>,
                      with event: UIEvent?) {
        tagField.resignFirstResponder()
    }
}


// MARK: - UI Methods
extension ViewController {
    func updateUI() {
        guard let rate = rate else { return }
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 4
        
        guard let formattedRate = formatter.string(from: NSNumber(value: rate)) else { return }
        
        DispatchQueue.main.async {
            self.tagLabel.text = "1 \(self.tag) is \(formattedRate) USD"
        }
    }
}
