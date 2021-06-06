//
//  LongWeekendList.swift
//  LongWeekend
//
//  Created by funzin on 2019/10/21.
//

import GoogleMobileAds
import SwiftUI

struct LongWeekendList: View {
    @ObservedObject var viewModel: LongWeekendListViewModel
    @State var isPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.longWeekends) { longWeekend in
                    LongWeekendRow(longWeekend: longWeekend)
                }
                AdBannerViewController()
                    .frame(width: AdBannerViewController.bannerSize.width,
                           height: AdBannerViewController.bannerSize.height)
            }
            .navigationBarTitle(L10n.longWeekend)
            .navigationBarItems(trailing:
                HStack {
                    Button(action: { self.isPresented.toggle() }) {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .sheet(isPresented: $isPresented,
                           content: {
                               SettingView()
                                   .onDisappear(perform: {
                                       self.viewModel.loadLongWeekend()
                                   })
                           })
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: { self.viewModel.loadLongWeekend() })
    }
}
