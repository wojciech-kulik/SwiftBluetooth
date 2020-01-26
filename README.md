<a href="https://www.buymeacoffee.com/WojciechKulik" target="_blank"><img src="https://bmc-cdn.nyc3.digitaloceanspaces.com/BMC-button-images/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>

# SwiftBluetooth
Implementation of Bluetooth Low Energy communication using Flow Controllers to make asynchronous code clean. 

You can read more in this article: [Swift – Bluetooth Low Energy communication using Flow Controllers](https://wojciechkulik.pl/ios/swift-bluetooth-low-energy-communication-using-flow-controllers)

## Structure

**BluetoothService:**  
* **BluetoothService.swift**  
Only very basic operations - state, connect, disconnect, startScan, stopScan and property to assign FlowController.
* **BluetoothConnectionHandler.swift**  
Extension to handle delegate methods related with connection like didConnect, didDisconnectPeripheral, didDiscover etc.
* **BluetoothEventsHandler.swift**  
Extension to handle delegate methods related with Bluetooth events like didDiscoverServices, didUpdateValueFor etc.
* **BluetoothCommands.swift**  
Extension to wrap preparing requests like binary payloads.


**Flows implementation:**
* FlowController.swift
* PairingFlow.swift
* SynchronizationFlow.swift (example - not implemented)
* ConfigurationFlow.swift (example - not implemented)
