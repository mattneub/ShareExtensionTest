import UIKit
import os.log

let logger = Logger(subsystem: "MyCoolClass", category: "debugging")

@objc(MyCoolClass)
class MyCoolClass: UIViewController /*, NSExtensionRequestHandling */ {
    override func beginRequest(with context: NSExtensionContext) {
        print(#function)
        context.completeRequest(returningItems: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        self.openURL(URL(string: "mycooltest://")!)
    }

    @objc @discardableResult private func openURL(_ url: URL) -> Bool {
        print(#function)
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                if #available(iOS 18.0, *) {
                    application.open(url, options: [:], completionHandler: nil)
                    return true
                } else {
                    return application.perform(#selector(openURL(_:)), with: url) != nil
                }
            }
            responder = responder?.next
        }
        return false
    }

}
