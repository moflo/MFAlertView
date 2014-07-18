MFAlertView
===========

Custom alert view, rewrite of UIAlertView with blocks, optional spinner and custom styles


Description
-----------

Highly stylized UIAlertView with several useful options.

GIF Screencapture 
![walk-thru](https://s3.amazonaws.com/img0.recordit.co/gifs/sDiCILiScN.gif?AWSAccessKeyId=AKIAJ6C24MUFYLHXOTTQ&Expires=1405720972&Signature=5uYhx6e2SUHBgD8XPXfVYnu1Oq4%3D)


Installation
------------

Copy the `MF_UIAlertView.h` and `MF_UIAlertView.m` files to you project.


Usage
-----

Simplest usage is to display an alert with a single button using blocks.

    // Simple Alert
    [MF_UIAlertView showWithTitle:@"Hello!" message:@"Test of a single button" cancelButtonTitle:@"Cancel" defaultButtonTitle:nil otherButtonTitle:nil withBlock:^(int selectedButton) {
        // Button selected
        NSLog(@"Simple alert, button selected: %d",selectedButton);
    }];

You can use the same method to display a cancelable activity alert.

    // Simple Alert - spinner
    [MF_UIAlertView showSpinnerWithTitle:@"Hello!" cancelButtonTitle:@"Cancel" withBlock:^(int selectedButton) {
        // Button selected
        NSLog(@"Simple alert, button selected: %d",selectedButton);
    }];


License
-------

The MIT License (MIT)

Copyright (c) 2014 Mobile FLow LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

