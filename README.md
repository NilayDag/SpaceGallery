# SpaceGallery
An iOS Application written in Swift. This app has a photo gallery with images retrieved from NASA API. Filtering option is available. For more information about the API, kindly visit: https://api.nasa.gov/

This project uses swift package manager. Hence, after you clone the repository or download the zip to open the project, you may need to run *"Resolve Swift Packages"* command in order to install package dependencies.

**Used packages:**

1. *Alamofire* (for network requests)
    For more information, kindly visit: https://github.com/Alamofire/Alamofire
2. *SDWebImage* (for image caching)
    For more information, kindly visit: https://github.com/SDWebImage/SDWebImage
3. *OHHTTPStubs* (for stubbing network requests)
    For more information, kindly visit: https://github.com/AliSoftware/OHHTTPStubs

Also *SwiftLint* installed to the project in order to standardize the code base.

- This project uses *VIPER* as an architecture model. 
- I created a template in order to simplify the creation process of the VIPER modules. If you want to create new VIPER module in the project, you can simply use the VIPER files template I created. (By clicking File > New > File > VIPER Native Files or ⌘+N > VIPER Native Files)
- You may run the project with using mock data. For this, simply add "*-DMOCK_ENABLED*" flag as an other swift flags in Build Configuration.
    - If you are running the project using mock data, you can alter the mock JSON responses placed in "Resources > MockJSONs > Dashboard > curiosityPhotos.json",
           "Resources > MockJSONs > Dashboard > opportunityPhotos.json" or
           "Resources > MockJSONs > Dashboard > spiritPhotos.json"
