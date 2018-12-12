import Flutter
import UIKit
import MMKV
    
public class SwiftFlutterMmkvPlugin: NSObject, FlutterPlugin {
    private var channel:FlutterMethodChannel;
    private var kv:MMKV;
    
    init(channel:FlutterMethodChannel) {
        self.channel = channel
        kv = MMKV.default()
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_mmkv", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMmkvPlugin(channel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//    guard let args = call.arguments as? [String:String] else {
//        fatalError("unable to parse arguments")
//    }
    switch call.method {
        case "getRootDir":
            result("adadsdas")
            break
//        case "encodeString":
//            let key = args["key"]!
//            let aString =  args["aString"]!
//            kv.setValue(aString, forKey: key)
//            break
//        case "decodeString":
//            let key = args["key"]!;
//            result("asdad");
//            break
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
