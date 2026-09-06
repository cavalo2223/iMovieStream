import SwiftUI
struct FeaturedCard: View {
    let item: MediaDisplayable
    var body: some View {
        ZStack(alignment:.bottomLeading) {
            AsyncImage(url: item.posterURL) { phase in
                if let image = phase.image { image.resizable().aspectRatio(contentMode:.fill) }
                else { Color.gray.opacity(0.3) }
            }.frame(height:220).clipShape(RoundedRectangle(cornerRadius:16))
            .overlay(LinearGradient(gradient:Gradient(colors:[.clear,.black.opacity(0.7)]), startPoint:.center, endPoint:.bottom))
            VStack(alignment:.leading, spacing:4) {
                Text(item.title.uppercased()).font(.title2).fontWeight(.bold).foregroundColor(.white).shadow(radius:4)
                HStack {
                    if let rating = item.rating {
                        Image(systemName:"star.fill").foregroundColor(.yellow).font(.caption)
                        Text(String(format:"%.1f", rating)).foregroundColor(.white).font(.caption)
                    }
                    Text("•").foregroundColor(.gray)
                    Text(item.year).foregroundColor(.white.opacity(0.8)).font(.caption)
                    Text("• \(item.mediaType.uppercased())").foregroundColor(.blue).font(.caption)
                }.padding(.top,2)
            }.padding(.leading,16).padding(.bottom,16)
        }.frame(height:220).shadow(radius:8)
    }
}
