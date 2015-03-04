# banished_utils
Utilities and scripts for improving gameplay in [Banished](http://www.shiningrocksoftware.com/game/).

## [banished_improved_camera_control.ahk](banished_improved_camera_control.ahk)
![banished_zoom](https://cloud.githubusercontent.com/assets/1087670/6482850/e5f6331e-c26a-11e4-8fa0-305ae30d6563.jpg)

[AutoHotkey](http://en.wikipedia.org/wiki/AutoHotkey) script to improve camera / main map control in fullscreen mode.

* drag terrain with right mouse button (like on google maps)
* zoom towards screen edges with mouse wheel
* tilt camera with middle mouse button

### Usage
* download and install [AutoHotkey](http://ahkscript.org/)
* download the [banished_improved_camera_control.ahk](https://raw.githubusercontent.com/Aprillion/banished_utils/master/banished_improved_camera_control.ahk) file (e.g. right click on the link > `Save Link As...`)
* execute (double click) the downloaded *.ahk file
* inside the game, try to drag the map with right mouse button across a large portion of the screen
 * if the map moves too slowly, decrease `x_moved_during_sleep` and `y_moved_during_sleep` variables
 * if the map moves too quickly, increase `x_moved_during_sleep` and `y_moved_during_sleep` variables
 * if you want to drag the map with left button instead of right, replace BOTH occurences of <br> `RButton` to `LButton`
 * make other adjustments as needed
* after SAVING your changes, you will have to `Reload This Script` from the context menu of the AHK notification icon on the Windows task-bar
