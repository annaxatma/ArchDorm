//
//  Home.swift
//  ArchDorm
//
//  Created by MacBook Pro on 31/05/22.
//

import SwiftUI
import MapKit

struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.black,
        textSize: CGFloat = 14,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}

enum DormType: String {
    case dormitories = "Dormitories"
    case residence_halls = "Residence Halls"
    case special_interest_housing = "special Interest Housing"
    case off_campus_housing = "Off-Campus Housing"
}

struct RadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
        VStack {
            radiodormitoriesMajority
            radioresidence_hallsMajority
            radiospecial_interest_housingMajority
            radiooff_campus_housingMajority
        }
    }
    
    var radiodormitoriesMajority: some View {
        RadioButtonField(
            id: DormType.dormitories.rawValue,
            label: DormType.dormitories.rawValue,
            isMarked: selectedId == DormType.dormitories.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioresidence_hallsMajority: some View {
        RadioButtonField(
            id: DormType.residence_halls.rawValue,
            label: DormType.residence_halls.rawValue,
            isMarked: selectedId == DormType.residence_halls.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radiospecial_interest_housingMajority: some View {
        RadioButtonField(
            id: DormType.residence_halls.rawValue,
            label: DormType.residence_halls.rawValue,
            isMarked: selectedId == DormType.residence_halls.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radiooff_campus_housingMajority: some View {
        RadioButtonField(
            id: DormType.residence_halls.rawValue,
            label: DormType.residence_halls.rawValue,
            isMarked: selectedId == DormType.residence_halls.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.yellow.opacity(0.3), radius: 40, x: 0, y: 0)
            .cornerRadius(11)
            .padding(.bottom, 330)
    }
    
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.541162, longitude: 114.023840),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct DetailView: View {
    
    var body: some View {
        NavigationView {
        ScrollView{
        Image("chuangDorm")
            .frame(width: UIScreen.main.bounds.width)
            .offset(y: -100)
            .padding(.bottom, -100)
        VStack(alignment: .leading){
           HStack{
                VStack (alignment: .leading){
                    Text("Chuang 2020 Dorm")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 1)
                    NavigationLink(destination: MapView()) {
                        Text("Overseas Chinese City, East of Shenzhen")
                            .font(.caption)
                    }
                }
                Spacer()
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading){
                HStack{
                    Text("Facilities")
                        .font(.caption)
                        .fontWeight(.bold)
                    Spacer()
                }
                VStack(alignment: .leading){
                    Text("‣ 5 Dance Room")
                        .font(.caption)
                    Text("‣ Flower Garden")
                        .font(.caption)
                    Text("‣ 2 Singing Hall")
                        .font(.caption)
                    Text("‣ Cafeteria")
                        .font(.caption)
                    Text("‣ Gym")
                        .font(.caption)
                }
                .padding(.leading)
            }
            .padding(3)
            
            VStack(alignment: .leading){
                HStack{
                    Text("Details")
                        .font(.caption)
                        .fontWeight(.bold)
                    Spacer()
                }
                VStack(alignment: .leading){
                    Text("Behind the fog lies a place with a fairy tail :3")
                        .font(.caption)
                }
                .padding(.leading)
            }
            .padding(3)
            
            VStack(alignment: .leading){
                HStack{
                    Text("Dorm Type")
                        .font(.caption)
                        .fontWeight(.bold)
                    Spacer()
                }
                HStack(){
                    Text("Dormitories")
                        .font(.caption)
                }
                .padding(.leading)
            }
            .padding(3)
        }
    }
    .navigationTitle("")
    .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

struct Home: View {
    @State var showModal: Bool = false
    @State var showWelcomeView: Bool = false
    @State var dormPhoto: String = ""
    @State var dormName: String = ""
    @State var dormAddress: String = ""
    @State var note: String = ""
    var listOfDorm:[DormData] = []

    var body: some View {
        NavigationView {
            NavigationLink(destination: DetailView()) {
                VStack{
                        HStack(alignment: .center) {
                            Image("chuangDorm")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80)
                                .padding(.all, 15)
                            VStack(alignment: .leading) {
                                Text("Chuang 2020 Dorm")
                                    .font(.system(size: 14, weight: .bold, design: .default))
                                    .foregroundColor(.mint)
                                    .padding(.bottom, 1)
                                Text("Overseas Chinese City, East of Shenzhen")
                                    .font(.system(size: 12, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                            }.padding(.trailing, 20)
                        }
                }
              .frame(maxWidth: .infinity, alignment: .center)
              .background(Color(red: 255/255, green: 183/255, blue: 197/255))
              .modifier(CardModifier())
              .padding(.all, 10)
                .navigationBarTitle("Arch Dorm")
                .navigationBarItems(trailing: Button(action: {self.showModal = true}) {
                  Image(systemName: "plus")
                    .imageScale(.large)
                    .frame(width: 44, height: 44, alignment: .trailing)
                }
                .sheet(isPresented: self.$showModal){
                  NavigationView {
                    Form {
                        Section{
                            TextField("Dorm Name",
                                      text: $dormName)
                            TextField("Dorm Address",
                                      text: $dormAddress)
                            TextField("Note",
                                      text: $note)
                            VStack {
                                    Text("Dorm Type")
                                    RadioButtonGroups { selected in
                                        print("Selected Dorm Type is: \(selected)")
                                    }
                            }.padding()
                        }
                    }
                      .navigationBarTitle("Add New Dorm")
                      .navigationBarItems(leading:
                        Button(action: {
                          self.showModal = false
                        }){
                          Text("Dismiss")
                        }
                    )
                  }
                    Section{
                        Button(action: {
                            
                        }, label: {
                            Text("SAVE").frame(width: 300, height: 40, alignment: .center).background(Color.blue).foregroundColor(.white).cornerRadius(8)
                        })
                        Spacer()
                    }
                }
              )
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
