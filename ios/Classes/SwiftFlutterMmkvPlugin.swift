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
        case "encodeBool":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            
            let aBool = NSNumber(value: args["aBool"]!) as! Bool
            
            result(mmkv.set(aBool, forKey: key))
            break
        case "decodeBool":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            result(mmkv.bool(forKey: key))
            break
        case "encodeInt":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            guard let aInt:Int32 = Int32(args["aInt"]!) else {
                fatalError("unable to parse \(args["aInt"]!) as Int32")
            }
            result(mmkv.set(aInt, forKey: key))
            break
        case "decodeInt":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            result(mmkv.int32(forKey: key))
            break
        case "encodeLong":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            guard let aLong:Int64 = Int64(args["aLong"]!) else {
                fatalError("unable to parse \(args["aLong"]!) as Int64")
            }
            result(mmkv.set(aLong, forKey: key))
            break
        case "decodeLong":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            result(mmkv.int64(forKey: key))
            break
        case "encodeDouble":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            guard let aDouble:Double = Double(args["aDouble"]!) else {
                fatalError("unable to parse \(args["aDouble"]!) as Double")
            }
            result(mmkv.set(aDouble, forKey: key))
            break
        case "decodeDouble":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            result(mmkv.double(forKey: key))
            break
        case "encodeString":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            let aString = args["aString"]!
            result(mmkv.set(aString, forKey: key))
            break
        case "decodeString":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            result(mmkv.object(of: NSString.self, forKey: key))
            break
        case "encodeUint8List":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            guard let aUInt8:UInt8 = UInt8(args["aBytes"]!) else {
                fatalError("unable to parse \(args["aBytes"]!) as UInt8")
            }
            result(mmkv.set(aUInt8, forKey: key))
            break
        case "decodeUint8List":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            let retrievedValue = mmkv.object(of: NSData.self ,forKey: key) as? Data
            result(FlutterStandardTypedData(bytes: retrievedValue!))
            break
        case "containsKey":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            result(mmkv.contains(key: key))
            break
        case "removeValueForKey":
            guard let args = call.arguments as? [String:String] else {
                fatalError("unable to parse arguments")
            }
            let key = args["key"]!
            mmkv.removeValue(forKey: key)
            break
        case "removeAll":
            mmkv.clearAll()
            break
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
