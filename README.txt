

#Amazon Login (without Alexa)
[amazon iOS documentation](http://login.amazon.com/ios)


##Register Application with Amazon
1) Sign into amazon login [console](http://login.amazon.com/manageApps) 

2) Register new application (this is step 3 from [amazon iOS documentation](http://login.amazon.com/ios) )



##Update iOS project based on your amazon app information  
Update the below on your project  (this is step 4 from [amazon iOS documentation](http://login.amazon.com/ios) )
	API Key
	URL scheme
	Transport Security Exceptions




#Alexa Amazon Login 
[Alexa Voice Service](https://developer.amazon.com/alexa-voice-service)

##Setup Amazon Login
Follow all the steps above for Amazon Login

##Create Alexa Voice Service App
1) register an Alexa Voice Service app on the [alexa developer website](https://developer.amazon.com/home.html)

2) make sure that on app settings (app settings > Security profile > iOS Settings) you add the below:
API Key name
Bundle ID (of your project)
**If the bundle ID its correct, it would automatically create a new API Key Value. 
**(VERY IMPORTANT!)**Update your iOS Project plist with this new API Key value.

3)
Update the iOS project  with your product ID (device Type ID ) that is located on your app settings (app settings > Device Type Info ) found in amazon developer website


