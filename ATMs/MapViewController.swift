//
//  MapViewController.swift
//  ATMs
//
//  Created by Karina Kovaleva on 27.12.22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    private let network = NetworkAPI()
    private var ATMs: [ATM] = []

    private lazy var mapView: MKMapView = {
        var mapView = MKMapView()
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.mapView)
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                          span: MKCoordinateSpan(latitudeDelta: 0.7,
                                                                                 longitudeDelta: 0.7))
                strongSelf.mapView.setRegion(coordinateRegion, animated: true)
            }
        }
//        network.getATMsList { ATMs in
//            self.ATMs = ATMs
//            self.fetchATMsOnMap(ATMs)
//        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func fetchATMsOnMap(_ ATMs: [ATM]) {
        for ATM in ATMs {
            let annotations = MKPointAnnotation()
            guard let latitude = CLLocationDegrees(ATM.gpsX),
                  let longitude = CLLocationDegrees(ATM.gpsY) else { return }
            annotations.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapView.addAnnotation(annotations)
        }
    }

}

//extension MapViewController: CLLocationManagerDelegate {
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch locationManager.authorizationStatus {
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
//            self.present(alert, animated: true)
//        case .authorizedAlways, .authorizedWhenInUse:
//            locationManager.startUpdatingLocation()
//
//            print("Access")
//        @unknown default:
//            break
//        }
//    }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//
//        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
//                                                  latitudinalMeters: 500,
//                                                  longitudinalMeters: 500)
//
//        mapView.setRegion(coordinateRegion, animated: true)
//        locationManager.stopUpdatingLocation()
//    }
//
//    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        print("Failed to initialize GPS: ", error.description)
//    }
//}
