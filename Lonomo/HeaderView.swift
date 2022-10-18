//
//  HeaderView.swift
//  SM_A_ios
//
//  Created by Anton Alley on 10/3/22.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(){
            HStack{
                //                Color.orange.ignoresSafeArea()
                Image("Lonomo header-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                
                
            }.frame(height:65)
//                .background(RoundedRectangle(cornerRadius: 0)
//                    .fill(Color.white)
//                )
//                .compositingGroup()
//                .shadow(radius:4,x:0,y:1)
            
            Spacer()
        }
    }
    
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
