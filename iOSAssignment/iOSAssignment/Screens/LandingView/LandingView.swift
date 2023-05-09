//
//  LandingView.swift
//  iOSAssignment
//
//  Created by MUhammad Sadiq on 08/05/2023.
//

import SwiftUI
import Combine

struct LandingView: View {
    
    @ObservedObject var viewModel = LandingViewModel(nyTimesApiManager: NYTimesApiManager())
    
    @State private var showingAlert = true
    
    @State private var selectedSegment = "7"
    private let periods = ["1", "7", "30"]
    
    var body: some View {
        
        ZStack {
            NavigationView {
                VStack {
                    Picker("Periods", selection: $selectedSegment) {
                        ForEach(periods, id: \.self) { period in
                            Text(period)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    .onChange(of: selectedSegment) { newValue in
                        viewModel.getPopularNYTimesNews(period: newValue)
                    }
                    
                    List(viewModel.articles, id: \.id) { article in
                        NavigationLink(destination: SecondScreenView(article: article)) {
                            ArticleRow(article: article)
                                .padding(5.0)
                                .listRowBackground(Color.clear)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listStyle(PlainListStyle())
                    .navigationTitle("NYTimes Articles")
                    .navigationBarTitleDisplayMode(.inline)
                }
                
            }
            if viewModel.showProgress == true {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            if let error = viewModel.error {
                VStack() {}
                    .alert(error.desc, isPresented: $showingAlert) {
                        Button("Ok") {
                            viewModel.resetError()
                            showingAlert = true
                        }
                    }
            }
        }.background(Color.black)
        
    }
    
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
