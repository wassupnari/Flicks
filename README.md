# Flicks

# Project 1 - *Flicks*

**Flicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [ ] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [ ] Implement segmented control to switch between list view and grid view.
- [ ] Add a search bar.
- [ ] All images fade in.
- [ ] For the large poster, load the low-res image first, switch to high-res when complete.
- [ ] Customize the highlight and selection effect of the cell.
- [ ] Customize the navigation bar.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.makeagif.com/media/10-18-2016/vY8N1j.gif' />

![](http://i.makeagif.com/media/10-18-2016/vY8N1j.gif)

Click [here](http://i.makeagif.com/media/10-18-2016/vY8N1j.gif) in case gif animation doesn't show up.

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- For me there was a big learning curve to finish this project, because I wasn’t familiar with Swift language, iOS platform, and Xcode tool. I started building stuff after the group lab session without watching any video materials, but in retrospect, I would have been better if I have watched the video first before I start building things.
- At first, I tried building tableview cells with separate .xib file, but for some reason the Segue didn’t open the detail page. So I had to move my UI components into the storyboard, and then it worked as expected. After doing some research, I realized that I needed to put some code to connect .xib with storyboard, and I think I was missing that part.
- I used Alamofire as my HTTP library, and I really liked it. For this project, I didn’t do much with Alamofire, but I think it can be really powerful if I need to build things with rest adapter, header/cookie interceptors, or etc. Also, I have built retry method on Android with Retrofit in the past, and I remember it was pretty complicated, but Alamofire has retry function as a built-in feature, and I think it’s a really nice addition.
- For the JSON parser, I used SwiftyJSON, and I wonder if it has similar ability as Gson on Android, like converting JSON data into a data object class. In this project, I had to traverse JSON data key by key, but it would be easier if I can just create a data model from the JSON response, so that I can just reference that data model to populate the view and also pass it as parameter for other viewControllers.
- I didn’t have much time to build additional features, but overall, this was very good first project and I think I learned a lot!

## License

    Copyright 2016 Nari Shin

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
