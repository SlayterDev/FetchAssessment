### Steps to Run the App
1. Clone the repository
2. Open the .xcodeproj and allow the packages to install
3. Run the app
4. List can be refreshed via "pull to refresh"
5. There is a floating action button (with the bug on it) that will allow you to switch to the malformed data or empty data endpoints

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
**Architecture:** I wanted to focus on the MVVM architecture which compliments SwiftUI well. To aid in development and testing I also set up the ViewModel to allow dependency injection
for the source of the API. This way I had the normal live API, a preview implementation which only returns static data for SwiftUI previews, and a Mock implementation for unit tests which I
could modify to return anything including error states.

**Concurrency:** Modern Swift allows us to use async/await to handle asynchronous tasks with ease. I made use of this particualarly with API calls. When the app first loads the list of recipes
or when the user requests a refresh we do this in the background to not block the UI. In SwiftUI the former is done using `onAppear` which is a synchronus process. We use `Task` to run our
async fetch method, we then tag the fetch method of the ViewModel with the `@MainActor` macro to ensure any view updates happen on the main thread (avoiding crashes).

**UI/UX:** My expertise is not in design but I made use of SwiftUI's built in functionality to ensure the app looks good in light and dark appearances. Using named or system colors keeps the
look and feel consistent. While not the prettiest on the iPad, using SwiftUI's layout APIs the app looks consistent and usable across device size classes.

**Performance Optimization:** To ensure the app remains scalable no matter how many recipes we throw at it I utilized `LazyVStack` to display the recipes. This ensures we only render recipes
as needed and won't bother drawing ones we haven't seen yet. It also provides more customization over `List` for the look of our elements. In addition since image caching was a requirement,
it made since to go with an existing library rather than roll my own solution for development ease but also performace. Kingfisher provides image caching and has integration for SwiftUI. This
ensures our images are loaded efficiently and caches them for later.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
- About 4 hours of active development
- First I broke down the requirements into a task list for myself. I highlited focus areas as important and added "nice to haves"
- After setting up the project I focused on the data model and API. I defined my model and created a protocol to represent the API and created the default implementation.
- From here I moved on to the ViewModel and defined the interactions between the view and the data and how they will be managed
- Then I created my views and laid everything out nicely
- Once I was happy with this I wrote my tests to ensure the ViewModel ends in the correct state based on outside factors

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I did not require major trade offs when completing this project compared to my goals. The requirements were straightforward and I was able to complete them in the time allotted.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The visual appeal of the app is probably the weakest point. I can translate any design to code but I need help with the vision.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
As mentioned above I used the Kingfisher library for image caching. Caching is a deep subject and seemed to be the area a lot of time could be wasted if I did it myself. This library is
heavily optimized for this task and offered a great way to add performance to the app at low development cost.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
When adding my debug menu for switching endpoints I at first encountered an issue where calls to the other endpoints would give this error: `Error Domain=NSURLErrorDomain Code=-999 "cancelled"`.
After playing around with it for a while I wasn't able to recreate the issue anymore so I'm unable to point to the root cause.
