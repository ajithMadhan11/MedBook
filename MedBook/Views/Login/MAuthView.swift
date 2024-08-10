//
//  MLoginView.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 08/08/24.
//

import SwiftUI

struct MAuthView: View {
    
    @Environment(\.modelContext) var context
    @StateObject var vm: AuthViewModel = AuthViewModel()
    
    @State private var showCountryList: Bool = false
    
    //TODO: keyboard scroll position should be handled properly
    //TODO: TextField type auto suggestions can be handled
    var body: some View {
        VStack(alignment: .center) {
            Image(.medBanner)
                .resizable()
                .frame(height: 300)
                .aspectRatio(contentMode: .fit)
            if vm.authState == .login {
                LoginView()
            } else {
                SignupView()
            }
            
            Spacer()
            
        }
        .ignoresSafeArea()
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    @ViewBuilder
    private func LoginView() -> some View {
        VStack(alignment: .leading) {
            Text("Ready to Turn the Page? Log In to Continue.")
                .font(MFont.MBold(22))
            MTextField(title: "Enter your email id", imageName: "at", value: $vm.userEmail)
            MTextField(isPassword: true ,title: "Enter your password", imageName: "key", value: $vm.userPassword)
            
                .padding(.vertical, 10)
            if let error = vm.error {
                Text(error.rawValue)
                    .font(MFont.MRegular(14))
                    .foregroundStyle(Color.red)
                    .transition(.slide)
            }
            MFillButton(title: "Sign In") {
                vm.signin(context: context)
            }
        }
        .transition(.move(edge: .leading))
        .padding()
        HStack(spacing: 5) {
            Text("new here?")
                .font(MFont.MRegular(16))
                .foregroundColor(.gray)
            
            Button(action: {
                withAnimation(.bouncy) {
                    vm.error = nil
                    vm.userEmail = ""
                    vm.userPassword = ""
                    vm.authState = .signup
                }
            }) {
                Text("Signup")
                    .font(MFont.MBold(16))
                    .foregroundColor(.black)
            }
        }
    }
    
    @ViewBuilder
    private func SignupView() -> some View {
        VStack(alignment: .leading) {
            Text("Unlock Your World of Stories...")
                .font(MFont.MBold(22))
            MTextField(title: "Enter your email id", imageName: "at", value: $vm.userEmail)
            MTextField(isPassword: true ,title: "Enter your password", imageName: "key", value: $vm.userPassword)
                .padding(.top, 10)
            MCountrySelect(value: $vm.userCountry)
                .onTapGesture {
                    self.showCountryList.toggle()
                }
                .padding(.vertical, 10)
            if let error = vm.error {
                Text(error.rawValue)
                    .font(MFont.MRegular(14))
                    .foregroundStyle(Color.red)
                    .transition(.slide)
            }
            MFillButton(title: "Sign up") {
                vm.signup(context: context)
            }
        }
        .transition(AnyTransition.move(edge: .trailing))
        .padding()
        HStack(spacing: 5) {
            Text("Already a member?")
                .font(MFont.MRegular(16))
                .foregroundColor(.gray)
            
            Button(action: {
                withAnimation(.bouncy) {
                    vm.error = nil
                    vm.userEmail = ""
                    vm.userPassword = ""
                    vm.userCountry = nil
                    vm.authState = .login
                }
            }) {
                Text("SignIn")
                    .font(MFont.MBold(16))
                    .foregroundColor(.black)
            }
        }
        .sheet(isPresented: $showCountryList, content: {
            VStack {
                if vm.errorInCountriesList {
                    Text("Something went wrong 😕⁉️")
                        .font(MFont.MRegular(16))
                } else if vm.fetchingCountriesList {
                    VStack(spacing: 10) {
                        ProgressView()
                        Text("Getting countries list...")
                            .font(MFont.MRegular(16))
                    }
                } else {
                    List {
                        if let countriesList = vm.countriesList {
                            ForEach(Array(countriesList), id: \.key) { key, country in
                                if vm.userCountry == country.country {
                                    MCountriesListCell(title: country.country, isSelected: true)
                                } else {
                                    MCountriesListCell(title: country.country)
                                        .onTapGesture {
                                            vm.userCountry = country.country
                                            showCountryList.toggle()
                                        }
                                }
                            }
                        } else {
                            Text("No countries found")
                                .font(MFont.MRegular(16))
                        }
                    }
                }
            }
            .padding(.top, 20)
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        })
        .onAppear {
            vm.getCurrentCountry()
            vm.getCountriesList()
        }
    }
}
