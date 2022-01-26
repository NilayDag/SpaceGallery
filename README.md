# SpaceGallery
An iOS Application written in Swift. This app has a photo gallery with images retrieved from NASA API. Filtering option is available. For more information about the API, kindly visit: https://api.nasa.gov/

This project uses swift package manager. Hence, after you clone the repository or download the zip to open the project, you may need to run *"Resolve Swift Packages"* command in order to install package dependencies.

### Used Packages:

1. *Alamofire*: for network requests
    
    For more information, kindly visit: https://github.com/Alamofire/Alamofire
    
2. *SDWebImage*: for image caching

    For more information, kindly visit: https://github.com/SDWebImage/SDWebImage
    
3. *OHHTTPStubs*: for stubbing network requests

    For more information, kindly visit: https://github.com/AliSoftware/OHHTTPStubs

Also *SwiftLint* installed to the project in order to standardize the code base. Consequently, if you don't have SwiftLint locally installed:

  1. You can either disable *SwiftLint* by removing SwiftLint Run Script Phase from *Targets > Build Phases*

  2. Or you can install *SwiftLint* using *Homebrew*. In order to install SwiftLint run below command via terminal:
    
           `brew install swiftlint`
        
  *For more information about *SwiftLint*, kindly visit: https://github.com/realm/SwiftLint*

### Environment Info:
**Xcode version: 13.2.1**

**Swift version:5.5**

**This project uses *VIPER* as an architecture model.**

### Mock Data:
- You may run the project with mock data. For this, simply add "*-DMOCK_ENABLED*" flag as an other swift flags in Build Configuration.
    - If you are running the project using mock data, you can alter the mock JSON responses placed in "Resources > MockJSONs > Dashboard > curiosityPhotos.json",
           "Resources > MockJSONs > Dashboard > opportunityPhotos.json" or
           "Resources > MockJSONs > Dashboard > spiritPhotos.json"
