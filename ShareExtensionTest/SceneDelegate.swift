import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        openURLContexts contexts: Set<UIOpenURLContext>
    ) {
        print(#function)
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: group) else {
            logger.log("no container URL")
            return
        }
        if let files = try? FileManager.default.contentsOfDirectory(atPath: containerURL.path) {
            for file in files {
                if file.hasPrefix(".") { continue }
                logger.log("found \(file, privacy: .public)")
                if let data = try? Data(contentsOf: containerURL.appending(path: file)) {
                    if let _ = UIImage(data: data) {
                        print("it's an image")
                    }
                }
            }
        }
    }
}

