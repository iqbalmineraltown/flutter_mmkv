import Flutter
import UIKit
import MMKV
    
public class SwiftFlutterMmkvPlugin: NSObject, FlutterPlugin {
    private var channel:FlutterMethodChannel;
    private var mmkv:MMKV;
    
    init(channel:FlutterMethodChannel) {
        self.channel = channel
        mmkv = MMKV.default()
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_mmkv", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMmkvPlugin(channel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "getRootDir":
            // TODO do nothing?
            result("unable to get root dir on iOS?")
            break
        case "encodeString":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            let aString =  args["aString"]!
            result(mmkv.set(aString, forKey: key))
            break
        case "decodeString":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!;
            result(mmkv.object(of: NSString.self, forKey: key));
            break
        case "containsKey":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!;
            print("Check cache with key: \(key)")
            result(mmkv.contains(key: key))
            break
        case "removeValueForKey":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!;
            print("Removing cache with key: \(key)")
            mmkv.removeValue(forKey: key);
            break
        case "removeAll":
            print("Removing all cache!")
            mmkv.clearAll()
            break
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
