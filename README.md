# Assignment
This project processes banner campaign data from CSV files and displays banners based on revenue and clicks for a given campaign. The assignment is presented in the [assignment.pdf](https://github.com/duplamatyi/banners/blob/master/assignment/test%20assingment.pdf).

# Solution
Here you can read about the technical details of the solution.

## Analysis
A working solution of the problem consists of the following:
* processing the CSV files
* storing the top banner ids for each campaign id
* tracking the users
* displaying the banners
* testing the code
* isolating the environment

## Code stack choice
* *Rails* - Sinatra or other lightweight Ruby MVC frameworks would have been an equally good choice,
as I needed minimal request routing and view display functionalities.
* *Rake* - For processing the data I implemented a Rake task. As the data is processed only once,
it makes perfect sense. Also the CSV parsing and data processing logic is separated in other library
classes. So it would be easy to switch for another task management tool.
* *Redis* - I only needed to store list and hash data structures corresponding to
campaign ids. Redis is a lightweight, fast key-value store that supports these data structures.
* *Minitest* - Minitest is used for unit testing the controllers and library classes and also for the integration tests.
* *Docker* - For isolation I chose Docker over Vagrant because it's more lightweight. While Vagrant is a virtual box
management tool, Docker isolates application containers at Linux kernel level. Unless development is done in a
non-Linux environment from a Linux machine, Docker seems to be always a better choice.

# Acceptance
The lines below assume you don't need sudo for the docker or docker-compose commands. If you do need,
use either sudo or [add your user to the docker group]
(https://docs.docker.com/engine/installation/linux/ubuntulinux/#/manage-docker-as-a-non-root-user).

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
The application is already running in development mode in the *banners-web* container. To process the data and load it into Redis run:
```bash
docker exec banners-web rake campaign:process_data
```
View [campaign 11](http://localhost:3000/campaigns/11).
