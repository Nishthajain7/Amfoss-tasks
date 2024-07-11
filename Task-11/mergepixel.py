import cv2
import numpy as np
from PIL import Image, ImageDraw
import os

# Function to detect the dot in the image
def detect_dot(image_path):
    # Read the image using OpenCV
    image = cv2.imread(image_path)
    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    # Threshold the image to create a binary image
    _, thresh = cv2.threshold(gray, 240, 255, cv2.THRESH_BINARY_INV)
    # Find contours in the binary image
    contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    for contour in contours:
        if cv2.contourArea(contour) > 10:  # Assuming the dot is the largest contour
            # Get the moments to calculate the centroid
            M = cv2.moments(contour)
            if M["m00"] != 0:
                cX = int(M["m10"] / M["m00"])
                cY = int(M["m01"] / M["m00"])
                # Get the color of the dot
                color = image[cY, cX]  # OpenCV uses (y, x) instead of (x, y)
                return (cX, cY), (color[2], color[1], color[0])  # Convert BGR to RGB
    return None, None

# Function to check if an image is completely white
def is_white_image(image_path):
    image = cv2.imread(image_path)
    if np.all(image == 255):
        return True
    return False

# Function to draw lines between dots in a single image
def draw_lines_single_image(image_paths, output_path):
    dots = []
    images = []
    # Load images and detect dots
    for image_path in image_paths:
        if is_white_image(image_path):
            if dots:  # If there are previous dots, create a new image layer
                images.append(dots)
                dots = []
        else:
            dot, color = detect_dot(image_path)
            dots.append((dot, color))
    if dots:  # Append the last set of dots if any
        images.append(dots)
    
    # Create a composite image and draw lines
    if images:
        composite_image = Image.open(image_paths[0])  # Start with the first image as base
        draw = ImageDraw.Draw(composite_image)
        for dots in images:
            for i in range(len(dots) - 1):
                if dots[i] is not None and dots[i + 1] is not None:
                    draw.line([dots[i][0], dots[i + 1][0]], fill=dots[i][1], width=3)
        
        # Save the composite image
        composite_image.save(output_path)

# Path to the images
image_paths = [f"Layer {i}.png" for i in range (1,60)] + [f"Layer {i}.png" for i in range (71,98)]
output_path = /home/nishtha/Documents

draw_lines_single_image(image_paths, output_path)
