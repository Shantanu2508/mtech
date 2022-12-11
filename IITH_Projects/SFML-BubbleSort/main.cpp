#include <iostream>
#include <cstdlib>
#include <SFML/Graphics.hpp>
using namespace std;

class Rectangle {
	int width;
public:
	int xLocation = 0;
	int yLocation = 0;
	int height = 0;
	Rectangle() {
		this->width = 5;	
	}
};

vector<Rectangle> rectHolder;
void fillImage(sf::Image &image, int width, int height, int noRectangles) {
	int xOffset = 10;
	int xLocation = 0;
	for (int i = 0; i < noRectangles; i++) {
		Rectangle rect;
		xLocation += xOffset;
		if (xLocation >= width) return;
		rect.height = rand() % 526;
		for (int i = 0; i < rect.height; i++) {
			image.setPixel(xLocation, height - 1 - i, sf::Color::Magenta);
		}
		rect.xLocation = xLocation;
		rectHolder.push_back(rect);
	}
}
void clearImage(sf::Image& image, int width, int height) {
	for (int i = 0; i < width; i++) {
		for (int j = 0; j < height; j++) {
			image.setPixel(i, j, sf::Color::White);
		}
	}
}
void drawImage(sf::Image  &image, int height) {
	for (auto rect : rectHolder) {
		for (int i = 0; i < rect.height; i++) {
			image.setPixel(rect.xLocation, height - 1 - i, sf::Color::Magenta);
		}
	}
}
void bubbleSort() {
	for (int i = 0; i < rectHolder.size() - 1; i++) {
		for (int j = 0; j < rectHolder.size()-i-1; j++) {
			if (rectHolder[j].height >= rectHolder[j+1].height) {
				int temp = rectHolder[j].xLocation;
				rectHolder[j].xLocation = rectHolder[j+1].xLocation;
				rectHolder[j+1].xLocation = temp;
				Rectangle tempRect = rectHolder[j];
				rectHolder[j] = rectHolder[j+1];
				rectHolder[j + 1] = tempRect;
			}
		}
	}
}

int main() {
int width = 1028;
int height = 526;
sf::RenderWindow window(sf::VideoMode(width, height), "Bubblesort");
sf::Image image;
image.create(width, height, sf::Color::White);
sf::Texture texture;
sf::Sprite sprite;

fillImage(image, width, height, 1000);

while (window.isOpen()) {
	sf::Event ev;
	while (window.pollEvent(ev)) {
		if (ev.type == sf::Event::Closed) {
			window.close();
		}
		if (ev.type == sf::Event::KeyReleased) {
			if (ev.key.code == sf::Keyboard::Space) {
				bubbleSort();
				clearImage(image, width, height);
				drawImage(image, height);
				break;
			}
		}
	}

	texture.loadFromImage(image);
	sprite.setTexture(texture);

	window.clear();
	window.draw(sprite);
	window.display();
}

return 0;
}