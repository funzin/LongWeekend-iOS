//
//  AdBannerView.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/22.
//

import Foundation
import GoogleMobileAds
import Keys
import SwiftUI

struct AdBannerViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let adBannerView = GADBannerView(adSize: kGADAdSizeBanner)
        let viewController = UIViewController()
        adBannerView.adUnitID = LongWeekendKeys().adUnitID
        adBannerView.rootViewController = viewController
        adBannerView.load(GADRequest())
        adBannerView.frame.size = AdBannerViewController.bannerSize
        viewController.view.addSubview(adBannerView)
        viewController.view.frame = CGRect(origin: .zero, size: AdBannerViewController.bannerSize)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AdBannerViewController>) {}
}

extension AdBannerViewController {
    static var bannerSize: CGSize {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return CGSize(width: kGADAdSizeBanner.size.width,
                          height: kGADAdSizeBanner.size.height)
        case .pad:
            return CGSize(width: kGADAdSizeLargeBanner.size.width,
                          height: kGADAdSizeLargeBanner.size.height)
        case .unspecified, .tv, .carPlay:
            return .zero
        @unknown default:
            return .zero
        }
    }
}
