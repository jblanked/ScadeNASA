import ScadeKit
import EasySCADE
import Foundation
import Dispatch
  
class MainPageAdapter: SCDLatticePageAdapter {

	private var apiKey: String = "DEMO_KEY"
  
  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)
    
    
    Task 
    { 
    	await self.createImages()  
    }
      
    
  }
  
  	func createImages() async
	{
		EasySpinner(true, "Loading")
		Task
		{
			let json: NASA = await self.getMarsData()
			
			DispatchQueue.main.async
			{
			
			let imageURLs: [String] = self.getImageList(json)
			
			var widgetList: [SCDWidgetsWidget] = []
			
			// append items to list
			//for index in 0..<(imageURLs.count-1)
			for index in 0..<100
			{
				widgetList.append(
					EasySCDImageURL(imageURLs[index])
				)
			}
			
			// set container
			self.container.children.append(EasySCDVStack(widgetList))
			
			self.container.location.y = Int(screenInfo.statusBarsize.height)
			self.container.location.x = 0
			}
		}
		EasySpinner(false, "Finished")
	}
  
  func getMarsData() async -> NASA
	{
	  guard let url = URL(string:"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=\(self.apiKey)") else { return NASA(photos: [Photos(id: 0, img_src: "")]) }
	  
	   do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let images = try decoder.decode(NASA.self, from: data)
            return  images
 
        } catch {
            print("Error loading image: \(error)")
            return NASA(photos: [Photos(id: 0, img_src: "")])
        }
	}
	
	func getImageList(_ jsonData: NASA) -> [String]
	{
		var temp: [String] = []
		
		
		for index in 0..<(jsonData.photos.count-1)
		{
			temp.append(jsonData.photos[index].img_src)
		}

		return temp
	}
	
	struct NASA: Codable
{
	var photos: [Photos]
}

struct Photos: Codable
{
	var id: Int
	var img_src: String
}
	
	

}

