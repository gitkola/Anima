import SwiftUI

struct SpinTable: View {
    @State private var spinVelocity: Double = 0
    @State private var size: CGSize = .zero
    @State private var radius: Double = 0
    @State private var angle: Angle = Angle(degrees: 0)
    @State private var startDragAngle: Angle? = nil
    @State private var lastTurntableAngle: Angle? = nil
    @State private var rotationDecelerationTimer: Timer? = nil
    @State private var isFingerStationary: Bool = false
    @State private var stationaryTimer: DispatchSourceTimer? = nil
    @State private var wheelRotation: Double = 0
    @State private var isRotating: Bool = true
    
    func stopRotation() {
        resetRotationDecelerationTimer()
        spinVelocity = 0
    }

    func isPointInCircle(point: CGPoint) -> Bool {
        let distanceSquared = (point.x - radius) * (point.x - radius) + (point.y - radius) * (point.y - radius)
        let radiusSquared = radius * radius
        return distanceSquared <= radiusSquared
    }
    
    func handleChangeAngle(point: CGPoint, isOnEnded: Bool) -> Void {
        if (rotationDecelerationTimer != nil) {
            resetRotationDecelerationTimer()
        }
        if (isPointInCircle(point: point) || isOnEnded) {
            let adjustedX = point.x - radius
            let adjustedY = point.y - radius
            let pointAngle = Angle(radians: atan2(adjustedY, adjustedX))
            var pointAngleNormalized = pointAngle.degrees < 0 ? Angle(degrees: pointAngle.degrees + 360) : pointAngle
            pointAngleNormalized = pointAngle.degrees > 180 ? Angle(degrees: pointAngle.degrees.modulus(180)) : pointAngle
            if (lastTurntableAngle == nil) {
                lastTurntableAngle = angle
            }
            
            if (startDragAngle == nil) {
                startDragAngle = pointAngleNormalized
            }
            
            let diffAngle = startDragAngle!.degrees - pointAngleNormalized.degrees
            
            var diffAngleNormalized = diffAngle
            if diffAngleNormalized > 360 {
                diffAngleNormalized = diffAngleNormalized - 360
            } else if diffAngleNormalized < -360 {
                diffAngleNormalized = diffAngleNormalized + 360
            }
            
            let nextAngle = Angle(degrees: (lastTurntableAngle!.degrees - diffAngleNormalized).modulus(360))
            angle = nextAngle
            if (isOnEnded) {
                spinVelocity = diffAngleNormalized / 100
                startDragAngle = nil
                lastTurntableAngle = nil
                startRotationDeceleration()
            }
        }
    }
    
    func resetRotationDecelerationTimer() {
        rotationDecelerationTimer?.invalidate()
        rotationDecelerationTimer = nil
    }
    
    func startRotationDeceleration() {
        resetRotationDecelerationTimer()
        rotationDecelerationTimer = Timer.scheduledTimer(withTimeInterval: 0.0016, repeats: true) { _ in
            spinVelocity *= 0.9993
            angle = Angle(degrees: (angle.degrees - spinVelocity * 1.009).modulus(360))
            if abs(spinVelocity) < 0.001 {
                spinVelocity = 0
                resetRotationDecelerationTimer()
            }
        }
    }
    
    func checkValue(value: Angle) {
        if (value.degrees >= 135 && value.degrees <= 145){
            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
            impactMed.impactOccurred()
        }
    }
    
    var body: some View {
        ZStack {
            Image("wheel")
                .clipShape(.circle)
                .rotationEffect(.degrees(angle.degrees))
                .background(GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            size = geometry.size
                            radius = geometry.size.width / 2
                        }
                })
                .onChange(of: angle) { newValue in
                    checkValue(value: newValue)
                }
                .gesture(
                    LongPressGesture(minimumDuration: 0.01)
                        .onEnded { _ in
                            stopRotation()
                        }
                        .simultaneously(with: DragGesture()
                            .onChanged { value in
                                isFingerStationary = false
                                stationaryTimer?.cancel() // Отменяем предыдущий таймер
                                let timer = DispatchSource.makeTimerSource()
                                timer.schedule(deadline: .now() + 0.1) // Задержка перед считыванием фиксации
                                timer.setEventHandler {
                                    self.isFingerStationary = true
                                }
                                timer.resume()
                                stationaryTimer = timer
                                handleChangeAngle(point: value.location, isOnEnded: false)
                            }
                            .onEnded { value in
                                stationaryTimer?.cancel() // Отменяем таймер при завершении жеста
                                if !isFingerStationary {
                                    handleChangeAngle(point: value.location, isOnEnded: true)
                                }
                                isFingerStationary = false
                            })
                )
                .rotationEffect(.degrees(wheelRotation))
                .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false), value: wheelRotation)
                .onAppear {
                    wheelRotation = 360
                }
            SpinTableArrow()
                .position(x: size.width / 2, y: 4)
        }
        .frame(width: size.width, height: size.height)
    }
    
}


extension Double {
    func modulus(_ n: Double) -> Double {
        let remainder = self.truncatingRemainder(dividingBy: n)
        return remainder >= 0 ? remainder : remainder + n
    }
}


#Preview {
    SpinTable()
}
