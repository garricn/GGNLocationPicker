//
//  LocationPickerViewController.swift
//  Pods
//
//  Created by Garric Nahapetian on 8/20/16.
//
//

import UIKit
import MapKit

public final class LocationPickerVC: UIViewController {
    public weak var pickerDelegate: LocationPickerDelegate?
    public var didPick: ((MKAnnotation) -> Void)?

    private let viewModel = LocationPickerVM()
    private let mapView = MKMapView()
    private var userLocation: MKUserLocation { return mapView.userLocation }
    private var annotationToShowOnLoad: MKAnnotation? = nil

    public init(annotationToShowOnLoad: MKAnnotation? = nil) {
        self.annotationToShowOnLoad = annotationToShowOnLoad
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func loadView() {
        view = mapView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.toolbarHidden = false

        if presentingViewController != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .Cancel,
                target: self,
                action: #selector(cancelButtonTapped)
            )
        }

        setupToolbarItems()
        setupObservers()

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handle))
        mapView.addGestureRecognizer(longPressGesture)
        mapView.showsUserLocation = viewModel.shouldShowUserLocation
        mapView.delegate = self

        if let annotation = annotationToShowOnLoad {
            mapView.addAnnotation(annotation)
            mapView.showAnnotations([annotation], animated: true)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }

    private func setupToolbarItems() {
        let userLocationButton = UIBarButtonItem(
            title: "◉",
            style: .Plain,
            target: self,
            action: #selector(userLocationButtonTapped)
        )

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .FlexibleSpace,
            target: nil,
            action: nil
        )

        let searchButton = UIBarButtonItem(
            barButtonSystemItem: .Search,
            target: self,
            action: #selector(searchButtonTapped)
        )

        let items = [
            userLocationButton,
            flexSpace,
            searchButton
        ]

        setToolbarItems(
            items,
            animated: false
        )
    }

    private func setupObservers() {
        viewModel.output.onNext { [weak self] annotation in
            self?.didPick?(annotation)
            self?.pickerDelegate?.didPick(annotation)
        }

        viewModel.searchResultsOutput.onNext { [weak self] annotations in
            guard let _self = self else { return }
            dispatch_async(dispatch_get_main_queue()) {
                _self.mapView.removeAnnotations(_self.mapView.annotations)
                _self.mapView.addAnnotations(annotations)
                _self.mapView.showAnnotations(annotations, animated: false)
                _self.mapView.selectAnnotation(annotations.last!, animated: true)
            }
        }

        viewModel.longPressOutput.onNext { [weak self] annotation in
            guard let _self = self else { return }
            dispatch_async(dispatch_get_main_queue()) {
                _self.mapView.removeAnnotations(_self.mapView.annotations)
                _self.mapView.addAnnotation(annotation)
                _self.mapView.showAnnotations([annotation], animated: true)
                _self.mapView.selectAnnotation(annotation, animated: true)
            }
        }

        viewModel.showUserLocationOutput.onNext { [weak self] _ in
            self?.mapView.setUserTrackingMode(.Follow, animated: true)
        }

        viewModel.alertOutput.onNext { [weak self] alert in
            self?.presentViewController(alert, animated: true, completion: nil)
        }

        viewModel.viewControllerOutput.onNext { [weak self] viewController in
            self?.presentViewController(viewController, animated: true, completion: nil)
        }
    }
}

// MARK: - Map View delegate
extension LocationPickerVC: MKMapViewDelegate {
    public func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        return viewModel.annotationView(fore: annotation, of: mapView)
    }

    public func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        viewModel.didSelect(view, of: mapView)
    }

    public func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        viewModel.didAdd(views, to: mapView)
    }

    public func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        viewModel.didTap(control, of: view, of: mapView)
    }
}

// MARK: - Search bar
extension LocationPickerVC: UISearchBarDelegate {
    @objc private func searchButtonTapped() {
        viewModel.searchButtonTapped(from: self)
    }

    public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        viewModel.didTapSearchButton(of: searchBar, of: mapView)
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - Interactivity
extension LocationPickerVC {
    @objc private func userLocationButtonTapped() {
        viewModel.userLocationButtonTapped()
    }

    func handle(longPress: UILongPressGestureRecognizer) {
        viewModel.handle(longPress, on: mapView)
    }

    func cancelButtonTapped(sender: UIBarButtonItem) {
        parentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
