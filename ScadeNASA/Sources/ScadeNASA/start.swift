import ScadeKit

class ScadeNASA: SCDApplication {

  let window = SCDLatticeWindow()
  let mainAdapter = MainPageAdapter()
  
  override func onFinishLaunching() {
    mainAdapter.load("main.page")
    mainAdapter.show(view: window)
  }
}