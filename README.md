# Lab 2 CIU - Solid of revolution

This lab consists in the implementation of a solid of revolution using Processing.

Author - Pablo Ortigosa


## Implementation

There are 3 files, the main class (pr2.pde) which is both the view and the controller, and 2 objects classes which are the model, these are Palette.pde and Figure.pde. Inside pr1.pde the loop (draw) function has 2 parts:
* logic() which is the controller, but is useless because the application relies heavily on the user's input.
* show() this is the view method, it displays each thing on the screen.
As said before, the application relies heavily on the user's input, as such there are 4 input components which are the main logic of the application:
* keyReleased()
* mouseClicked()
* mouseDragged()
* mouseWheel()

All of the previously mentioned methods have a switch sentence which detects the state of the application and does what is supposed to do according to that state (printing in screen what it needs to be printed and detecting the neccesary inputs)

Finally the application has 3 states, the introduction screen, the figure input screen and the figure screen. In each of these you can interact in multiple ways:
* Introduction screen: 
  * Press SPACE to go to the next screen
* Figure input screen:
  * Press SPACE to create a solid of revolution (needs at least 3 points on screen)
  * Click to create a new point on the screen (can only be created on the right side of the screen)
  * Press R to delete all points
  * Press U to undo
* Figure screen:
  * Press UP or DOWN to change the number of meridians that define the solid of revolution (minimum of 3 and maximum of 30)
  * Use the WHEEL to zoom
  * DRAG to rotate
  * Press R to create a new shape
* Any screen:
  * Press the RIGHT or LEFT to change the palette.


## Choices

Inside all of the main functions there is a switch sentence whis is supposed to represent the current state of the application, I though this was a good idea because the application is small. I also decided to leave all the states of each of these methods even if they did nothing, because they are supposed to not do anything, it is also a future proofing feature in case something needs to be added.

There are only 2 palettes, I plan to add one more on each of the applications of this subject so I can have an extensive list of palettes. For the moment the Night and the Day palettes are the only ones. To make the palettes I used Coolors. Each palette consists of 3 colors: background, text and extra, also each one has an alternative version, which brings it to a total of 6 colors in each palette.


## References

https://coolors.co/ used to make the palettes.

The class material made by the teachers - @otsedom and Daniel.

Processing API.

Java API.

## Final view

TODO
