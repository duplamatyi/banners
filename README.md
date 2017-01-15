# Assignment
This project processes ad campaign data from CSV files and displays banners based on revenue and clicks for a given campaign. The assignment is presented in [assignment.pdf](https://github.com/duplamatyi/banners/blob/master/assignment/test%20assingment.pdf).
# Solution
Here you can read about the technical details of the solution.
## Analysis
A working solution of the problem consists of the following:
* processing the data
* storing the data
* tracking the users
* displaying the banners
* testing the solution
* isolating the environment
## Code stack choice explanation
* *Rails*, Sinatra or any other MVC Ruby framework would have been an equally good choice.
I chose Rails, because of it's convention over configuration approach and the quickness of
the development process when generating and starting up a new project. It's also highly configurable
if needed. For example this project was generated with the skip-activerecord flag and does not
make use of models at all. Basically this solution makes use only of the Virew and Controller components of Rails.
* For processing the data I use a *Rake* task. As the data is processed only ones it makes perfect sense.
* For storing the data I chose *Redis*. I only needed to store list and hash data structures corresponding to
campaign ids. *Redis* is a lightweight and fast key value store that supports these data structures.
* For testing the default *Minitest* is used. There are unit tests for the controllers, lib classes
and functional tests.
* For isolation I used *Docker* beacuse it's more lightweight. While Vagrant is a virtual box management tool,
*Docker* isolates application containers at Linux Kernel level. Unless I have to develop in a non-Linux environment
from a Linux machine, I always would chose *Docker* over Vagrant.
# How to check acceptance
The lines below assume you don't need sudo for the docker or docker-compose commands. If you do need, use either sudo or [add your user to the docker group](https://docs.docker.com/engine/installation/linux/ubuntulinux/#/manage-docker-as-a-non-root-user).
Cloning the repository:
```bash
git clone git@github.com:duplamatyi/banners.git .
```
Bringing up the environment:
```bash
docker-compose build && docker-compose up -d
```
Running the tests:
```bash
docker exec banners-web rake test
```
Application already running in web container. To process the data and load it into redis run:
```bash
docker exec banners-web rake campaign:process_data
```
