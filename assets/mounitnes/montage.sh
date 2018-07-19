#!/bin/bash

# filename with variable name
    # -tile reflects the organization of steps. 4×2 means that it has 4 columns and 2 rows, 8×1 would mean 8 columns and 1 row, etc.
    # -geometry gives the size and position of each step. 128×128 means that the images are 128 pixels wide and 128 pixels tall. +0+0 means that the origin of the image is in the top-left of the image.
    # -background provides the color (or lack of it) for the background of the final image. In our case we use the keyword transparent to make use of the transparency of the animation.
montage frame_0000[1-2].png -tile 2x1 -geometry 1920x500+0+0 -background transparent spritesheet.png
