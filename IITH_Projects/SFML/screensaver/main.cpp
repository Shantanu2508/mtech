#include <iostream>
#include <cstdlib>
#include <SFML/Graphics.hpp>
using namespace std;

int main() {
	int width = 1028;
	int height = 720;
	sf::RenderWindow window(sf::VideoMode(width, height), "Screensaver");
	window.setFramerateLimit(20);

	sf::Image image;
	image.loadFromFile("screensaver-wall.jpg");
	sf::Texture texture;
	texture.loadFromImage(image);
	sf::Sprite sprite;
	sprite.setTexture(texture);

	sf::RectangleShape rect;
	sf::Vector2f rectanglePosition;
	sf::Vector2f rectangleSize;
	rectanglePosition.x = width / 2;
	rectanglePosition.y = height / 2;
	rectangleSize.x = 100;
	rectangleSize.y = 100;
	rect.setPosition(rectanglePosition);
	rect.setSize(rectangleSize);
	rect.setFillColor(sf::Color::Blue);

	float xVelocity = 30;
	float yVelocity = 30;

	while (window.isOpen()) {
		sf::Event event;
		while (window.pollEvent(event)) {
			if (event.type == sf::Event::Closed) window.close();
		}
		if (rectanglePosition.x < 0 || rectanglePosition.x + 100>= width) xVelocity *= -1;
		if (rectanglePosition.y < 0 || rectanglePosition.y + 100 >= height) yVelocity *= -1;
		rectanglePosition.x += xVelocity;
		rectanglePosition.y += yVelocity;

		rect.setPosition(rectanglePosition);
		window.clear();
		window.draw(sprite);
		window.draw(rect);
		window.display();
	}
	return 0;
}