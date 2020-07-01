# pihole-raspi

1. Flash Raspbian onto your SD card

First we need to flash Raspbian onto an SD card. (16GB or 32GB).
Raspbian Lite or Raspian Full can be used.
Use Raspberry PI Imager for Win and Mac (Also install bonjour service for Win, nothing to install for Mac)

2. Edit config.txt on the boot partition 

With Raspbian installed on the SD card (and the SD card still mounted on your computer), you can use Finder or a shell to navigate to the boot directory. Now edit the file called config.txt, and append the following:

dtoverlay=dwc2

Save and exit.

3. Enable SSH

We can SSH by simply adding an empty file called ssh directly in the boot directory.

On the command line, you can navigate to the boot directory and run:

touch ssh

Note: The file must be called "ssh" not "SSH" or "ssh.txt" or anything other than "ssh".

4. 	Edit cmdline.txt

Now, edit the file called cmdline.txt. Look for rootwait, and add modules-load=dwc2,g_ether immediately after. 

Note the formatting of cmdline.txt is very strict. Commands are separated by spaces, and newlines are not allowed.

Here's an example of what my cmdline.txt file looks like, but you should not copy this. Simply add the required command mentioned above.

console=serial0,115200 console=tty1 root=PARTUUID=6c586e13-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait modules-load=dwc2,g_ether quiet init=/usr/lib/raspi-config/init_resize.sh

Save and exit.

5. Connect over USB and boot the Pi

That's it for configuration! Now you can eject the SD card, and insert it into the the Pi. Using a USB cable, connect to the Raspberry Pi from your computer.

After the Pi boots up (this will take a while initially), the Pi should appear as a USB Ethernet device, and you can SSH into it using:

ssh pi@raspberrypi.local


After the connecting to SSH use following tutorials
6. Enable different options in sudo raspi-config
    Enable Wireless
    			a. sudo raspi-config
    			b. Select Networking options
    			c. Select Wireless
    			d. Select country for th Wireless (US can be selected)
    			e. Enter SSID
    			f. Enter password

    Enable Localisation Options
    			a. sudo raspi-config
    			b. Select Localisation Options
    			c. In the list on the Left handside, remove en_GB.UTF-8 (click space key to select or deselct)
    			d. In the list on the Left handside, select en_US.UTF-8 
    			e. click Ok, select default as en_US again and let the installtion finish

    Enable SPI
    			a. sudo raspi-config
    			b. select Interfacing Options
    			c. Select SPI
    			d. Enable and click Ok
    Enable I2C
    			a. sudo raspi-config
    			b. select Interfacing Options
    			c. Select I2C
    			d. Enable and click Ok

   	Use this command for verifying the settings - ls /dev/i2c* /dev/spi*
   	You should see the response - /dev/i2c-1 /dev/spidev0.0 /dev/spidev0.1
   	If you dont see the above response, try the steps from 1 till 6.

7. Update the OS and install pip3 for python
    sudo apt update -y
    sudo apt-get update -y
    sudo apt-get upgrade -y
	
	sudo apt-get install python3-pip
	sudo pip3 install --upgrade setuptools

8. Install Libraries for the Display

	sudo pip3 install adafruit-circuitpython-rgb-display
	sudo pip3 install --upgrade --force-reinstall spidev

	Font - sudo apt-get install ttf-dejavu
	Pillow Library -  sudo apt-get install python3-pil
	NumPy Library - sudo apt-get install python3-numpy

9. Testing the buttons in the PiTFT module

	Downloading this file 
	wget https://raw.githubusercontent.com/adafruit/Adafruit_CircuitPython_RGB_Display/master/examples/rgb_display_minipitfttest.py

	and execcute the file - sudo python3 rgb_display_minipitfttest.py

	Once it is running, push the buttons. The top button should make the display light up Red, the bottom Blue, and pressing both at the same time should make it Green.

10. PiTFT libraries for display for SPI and I2C

	pip3 install RPI.GPIO
	pip3 install adafruit-blinka

	To verify - Use the following code - use nano to copy and paste the following cade
	nano blinkatest.py
	--------------------------------------------------------
	import board
	import digitalio
	import busio

	print("Hello blinka!")

	# Try to great a Digital input
	pin = digitalio.DigitalInOut(board.D4)
	print("Digital IO ok!")

	# Try to create an I2C device
	i2c = busio.I2C(board.SCL, board.SDA)
	print("I2C ok!")

	# Try to create an SPI device
	spi = busio.SPI(board.SCLK, board.MOSI, board.MISO)
	print("SPI ok!")

	print("done!")
	-------------------------------------------------------

	execute with - python3 blinkatest.py



