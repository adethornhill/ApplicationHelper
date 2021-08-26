//
//  DropDownMenuView.swift
//  ApplicationHelper
//
//  Created by Ade Thornhill on 8/25/21.
//

import SwiftUI

struct FilterDropDownView: View {
    let title : String
    let items : [FilterCommand]
    @State var showItems = false //show items in menu
    @State var selectedItem : FilterCommand = NoneFilter()
    @EnvironmentObject var viewModel : JobAppViewModel

    var body: some View {
        
        VStack{
            Text("\(title) :")
                .bold()
                .padding(.bottom, -10)
                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
            DisclosureGroup(selectedItem.title, isExpanded: $showItems){
                ScrollView{
                    VStack{
                        ForEach(items.indices) { index in
                            Text(items[index].title)
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, 3)
                                .onTapGesture {
                                    selectedItem = items[index]
                                    
                                    //use filter on whatever item is chosen
                                    viewModel.useFilter(inFilter: items[index])
                                    withAnimation{
                                        showItems.toggle()
                                }
                            }
                            Divider()
                        }
                    }
                }
                .frame(height:150)
            }
            .accentColor(.black)
            .padding()
            .frame(width: showItems ? 250 : 150 , height: showItems ? 200 : 25)
            .background(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
            .cornerRadius(10)
            
        }
    }
}

struct DropDownMenuView_Previews: PreviewProvider {
    static var vm = JobAppViewModel()
    static var previews: some View {
        FilterDropDownView(title: "Filter" ,items:vm.filters)
            .environmentObject(JobAppViewModel())
            
    }
}
