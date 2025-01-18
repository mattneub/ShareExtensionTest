import UIKit
import UniformTypeIdentifiers


@objc(MyCoolClass)
class MyCoolClass: UIViewController {
    var context: NSExtensionContext?

    override func beginRequest(with context: NSExtensionContext) {
        logger.log(#function)
        self.context = context
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: group) else {
            return
        }
        if let files = try? FileManager.default.contentsOfDirectory(atPath: containerURL.path) {
            for file in files {
                if file.hasPrefix(".") { continue }
                try? FileManager.default.removeItem(at: containerURL.appending(path: file))
            }
        }
        for item in context.inputItems {
            if let item = item as? NSExtensionItem {
                for provider in (item.attachments ?? []) {
                    _ = provider.loadDataRepresentation(for: .image) { data, error in
                        if let data {
                            let file = UUID().uuidString
                            do {
                                try data.write(to: containerURL.appending(path: file))
                                logger.log("wrote \(file, privacy: .public)")
                            } catch {
                            }
                        }
                    }
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logger.log(#function)
        context?.completeRequest(returningItems: nil) { [weak self] _ in
            self?.openURL(URL(string: "mycooltest://")!)
        }
    }

    func openURL(_ url: URL) {
        logger.log(#function)
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                application.open(url, options: [:], completionHandler: nil)
                return
            }
            responder = responder?.next
        }
    }
}
