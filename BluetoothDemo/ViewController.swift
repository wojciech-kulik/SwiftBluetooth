//
//  ViewController.swift
//  BluetoothDemo
//
//  Created by Wojciech Kulik on 21/07/2018.
//  Copyright © 2018 Wojciech Kulik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    let bluetoothService = BluetoothService()
    lazy var pairingFlow = PairingFlow(bluetoothSerivce: self.bluetoothService)
    
    override func viewDidLoad() {
        self.bluetoothService.flowController = self.pairingFlow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkBluetoothState()
    }
    
    private func checkBluetoothState() {
        self.statusLabel.text = "Status: bluetooth is \(bluetoothService.bluetoothState == .poweredOn ? "ON" : "OFF")"
        
        if self.bluetoothService.bluetoothState != .poweredOn {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { self.checkBluetoothState() }
        }
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        guard self.bluetoothService.bluetoothState == .poweredOn else { return }

        self.statusLabel.text = "Status: waiting for peripheral..."
        self.pairingFlow.waitForPeripheral {
            self.statusLabel.text = "Status: connecting..."
            
            self.pairingFlow.pair { result in
                self.statusLabel.text = "Status: pairing \(result ? "successful" : "failed")"
            }
        }
    }
}
