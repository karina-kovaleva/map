//
//  LocationManager.swift
//  ATMs
//
//  Created by Karina Kovaleva on 3.01.23.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject {
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    private var completion: ((CLLocation) -> Void)?
}

extension LocationManager: CLLocationManagerDelegate {
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .notDetermined, .restricted:
//            print("No access")
//        case .denied:
//            let alert = UIAlertController(title: "Карты не знают, где вы находитесь",
//                                          message: """
//                                            Разрешите им определять Ваше местоположение:
//                                            это делается в настройках устройства
//                                            """,
//                                          preferredStyle: .alert)
//            let cancel = UIAlertAction(title: "Отменить", style: .cancel)
//            alert.addAction(cancel)
//            if let settings = URL(string: UIApplication.openSettingsURLString),
//               UIApplication.shared.canOpenURL(settings) {
//                alert.addAction(UIAlertAction(title: "Настройки", style: .default) { _ in
//                    UIApplication.shared.open(settings)
//                })
//            }
//            present(alert, animated: true)
//        case .authorizedAlways, .authorizedWhenInUse:
//            print("Access")
//        @unknown default:
//            break
//        }
//    }

    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            completion?(location)
            manager.stopUpdatingLocation()
        }
    }
}
