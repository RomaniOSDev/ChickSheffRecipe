//
//  TimerManager.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import Foundation
import Combine
import UserNotifications
import AVFoundation

class TimerManager: ObservableObject {
    @Published var isRunning = false
    @Published var timeRemaining: TimeInterval = 0
    @Published var totalTime: TimeInterval = 0
    @Published var timerName: String = ""
    @Published var showCompletionAlert = false
    @Published var isPaused = false
    
    private var timer: Timer?
    private var startTime: Date?
    private var audioPlayer: AVAudioPlayer?
    private let notificationCenter = UNUserNotificationCenter.current()
    
    var progress: Double {
        guard totalTime > 0 else { return 0 }
        return max(0, min(1, (totalTime - timeRemaining) / totalTime))
    }
    
    var formattedTime: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer(duration: TimeInterval, name: String) {
        stopTimer()
        
        totalTime = duration
        timeRemaining = duration
        timerName = name
        isRunning = true
        isPaused = false
        startTime = Date()
        
        // Запрашиваем разрешение на уведомления
        requestNotificationPermission()
        
        // Планируем уведомление
        scheduleNotification(for: duration, name: name)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isPaused = true
        
        // Отменяем уведомление при паузе
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func resumeTimer() {
        guard timeRemaining > 0 else { return }
        
        isRunning = true
        isPaused = false
        startTime = Date()
        
        // Планируем новое уведомление
        scheduleNotification(for: timeRemaining, name: timerName)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isPaused = false
        timeRemaining = 0
        totalTime = 0
        timerName = ""
        startTime = nil
        
        // Отменяем все уведомления
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    private func updateTimer() {
        guard let startTime = startTime else { return }
        
        let elapsed = Date().timeIntervalSince(startTime)
        timeRemaining = max(0, totalTime - elapsed)
        
        if timeRemaining <= 0 {
            stopTimer()
            showCompletionAlert = true
            playCompletionSound()
        }
    }
    
    // MARK: - Notifications
    private func requestNotificationPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error)")
            }
        }
    }
    
    private func scheduleNotification(for duration: TimeInterval, name: String) {
        let content = UNMutableNotificationContent()
        content.title = "Timer completed! 🎉"
        content.body = "Cooking time for '\(name)' has expired"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: duration, repeats: false)
        let request = UNNotificationRequest(identifier: "timer-completion", content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    // MARK: - Sound
    private func playCompletionSound() {
        // Create system completion sound
        AudioServicesPlaySystemSound(1005) // Звук завершения
        
        // Additionally can play custom sound
        if let soundURL = Bundle.main.url(forResource: "timer_complete", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error)")
            }
        }
    }
}
