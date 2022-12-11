header - #include <SFML/Graphics.hpp>

Create a window
---------------
set width and height of window, (100,800). use sf::RenderWindow(sf::VideoMode(w,h),<name of window>)
-Open window
-handle events - close, key pressed

Create image/ sprite
--------------------
create image using sf::Image image; image.create(w,h);
each pixel of image can be set using image.setPixel(i,j,sf::Color(r,g,b));
create sprite sf::Sprite sprite;

Create rectangle
-----------------
Use own class
-(int)width
-(int)height
-(sf::Color)
-(int)xLocation
-(int)yLocation

Build rectangles
----------------
Fn to draw rectanges on image - image.setPixel((int)x,(int)y,sf::Color(r,g,b))
This fn takes rectangle object and image
Create rectangle with random height and fixed width and store in rectangleHolder
Do proper xoffset and height



Draw rectangles on image
------------------------
Fn to paint rectangles on Image - arg:(sf::Image, vector<rectangle>)

Bubblesort
----------
Runs when user presses "space" key
Sort on the basis of height
arg: vector<rectangle>
  
<img width="491" alt="init_recBars" src="https://user-images.githubusercontent.com/70562197/188501611-4a254d7f-c5f4-46ef-a311-5c14b4af4f3f.png">
  
<img width="494" alt="sorted-recBars" src="https://user-images.githubusercontent.com/70562197/188501644-dc8b1a86-b0fc-4c6d-ba03-f901d7c22727.png">
