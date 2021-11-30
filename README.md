# Air-Quality-Monitoring
This is an POC for showing current Air Quality of different Cities in graphical format using webSocket.

It Used danielgindi/Charts to show Bar graph chart from https://github.com/danielgindi/Charts.

**CocoaPods Install**
Add pod 'Charts' to your Podfile. "Charts" is the name of the library.

**Architectural Design Pattern** -  MVVM (Model-View-ViewModel)

**Project**

**WebSocket.swift** - A WebSocket is a network protocol that allows two-way communication between a server and client. Unlike HTTP, which uses a request and response pattern, WebSocket peers can send messages in either direction at any point in time.

**CityAQIModel.swift** - Data model class

**AQIViewModel.swift** - ViewModel for buisness Logic

**ViewController.swift** - View Controller Class contains UI Logic to display the data

**AQICustomTableViewCell.swift** - Custom Cell


<img width="490" alt="Screenshot 2021-12-01 at 1 13 47 AM" src="https://user-images.githubusercontent.com/62983984/144135015-97d3612d-11e2-446c-8253-b536793a38c3.png">

<img width="490" alt="Screenshot 2021-12-01 at 1 10 33 AM" src="https://user-images.githubusercontent.com/62983984/144135037-adb3c83f-3688-4278-b797-f280fa50539e.png">



**Known Issues:**
The App doesnot use CoreData, so data is not persistant for now. The time to get the Data is set for 10sec interval that user can feel the updates happening in real time. User can update the timeToRefresh variable in WebSocket.swift class to increase/decrease refresh time
