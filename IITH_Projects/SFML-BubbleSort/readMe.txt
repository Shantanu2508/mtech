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

