import ScadeKit

extension MainPageAdapter {
  var container: SCDWidgetsContainer {
    return self.page?.getWidgetByName("container") as! SCDWidgetsContainer
  }
}