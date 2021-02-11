//
//  RingtonePlayer.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-02-10
//
// EasySwiftUIKit Version - '1.0.3.03'
//  Version - '1.0.3.03'


import Foundation
import AVFoundation

public class RingtonePlayer {
    public var audioPlayer: AVAudioPlayer?
    var isKeepBuzzing: Bool = false
//    var isKeepBuzzing: Bool = true
    private var buzzingTotalTime = 30
    var buzzingCount = 0
    //
    private var timeInterval: TimeInterval!
    private var pauseInterval: UInt32!
    private var localSoundFile: String!
    private var sysSoundFile: String!
    private var sysSoundId: SystemSoundID!
    //
    public init() {
        timeInterval = 1
        pauseInterval = 1000
        sysSoundId = 0
    }
    public func withInterval(withTimeInterval: TimeInterval = 1) -> RingtonePlayer {
        timeInterval = withTimeInterval
        return self
    }
    public func withSoundFile(soundFile: String) -> RingtonePlayer {
        localSoundFile = soundFile
        return self
    }
    public func withSystemSound(soundFile: String) -> RingtonePlayer {
        sysSoundFile = soundFile
        return self
    }
    public func withSystemSound(systemSoundId: SystemSoundID) -> RingtonePlayer {
        sysSoundId = systemSoundId
        return self
    }
    public func withBuzzingTime(buzzingTime: Int) -> RingtonePlayer {
        buzzingTotalTime = buzzingTime
        return self
    }
    public func onPlay(completion: @escaping (Bool, Int) -> Void) {
        isKeepBuzzing = true
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {timer in
//            var randomNumber = self.buzzingCount
            if self.isKeepBuzzing == false {
                self.buzzingCount += 1
            }
            //
            if self.buzzingCount >= self.buzzingTotalTime {
                timer.invalidate()
//                self.onTapBtnDecline(UIButton())
                completion(true, self.buzzingCount)
                return
            } else {
                if self.sysSoundId > 0 {
                    self.playSystemSound(soundFile: self.sysSoundId, pauseTime: self.pauseInterval)
                } else if self.localSoundFile != nil {
                    self.playSound(soundFile: self.localSoundFile, pauseTime: self.pauseInterval)
                }
                completion(false, self.buzzingCount)
            }
            self.buzzingCount += 1
            print("========\(self.buzzingCount)")
        }
    }
    
//    public func play(soundFile: String) {
////        var audioPlayer: AVAudioPlayer?
//        //        let path = Bundle.main.path(forResource: "example.mp3", ofType:nil)!
//        let path = Bundle.main.path(forResource: soundFile, ofType:nil)!
//        let url = URL(fileURLWithPath: path)
//
//        do {
//            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
//            self.audioPlayer?.play()
//        } catch {
//            // couldn't load file :(
//        }
//    }
    private func playSound(soundFile: String, pauseTime: UInt32 = 1000) {
        DispatchQueue.global(qos: .utility).async {
//            var audioPlayer: AVAudioPlayer?
            //        let path = Bundle.main.path(forResource: "example.mp3", ofType:nil)!
            let path = Bundle.main.path(forResource: soundFile, ofType:nil)!
            let url = URL(fileURLWithPath: path)
            usleep(pauseTime)
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                self.audioPlayer?.play()
            } catch {
                // couldn't load file :(
            }
        }
    }
    //    public static func playSystemSound(soundFile: SystemSoundID = 1016) {
    private func playSystemSound(soundFile: SystemSoundID = 1016, pauseTime: UInt32 = 1000) {
        DispatchQueue.global(qos: .utility).async {
            // create a sound ID, in this case its the tweet sound.
            let systemSoundID: SystemSoundID = soundFile
            AudioServicesPlaySystemSound(systemSoundID)
            //Vibrate the device
            //                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            //                self.incrementalCount += 1
            //                usleep(800000) // if you don't want, remove this line.
            usleep(pauseTime)
            //            do {
            //                if isBuzzing {
            //                    try vibrateTheDeviceContinuously()
            //                }
            //                else {
            //                    return
            //                }
            //            } catch  {
            //                //Exception handle
            //                print("exception")
            //            }
        }
    }
}
