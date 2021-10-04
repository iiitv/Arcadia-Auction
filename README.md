# CS:GO Tournament App

An App where all the details about a tournament can be found.

## Features

- User Side

  - Players can Register for the tournament through the App itself.
  - Users can Sign-in Anonymously.
  - Users can see the Match Schedule on the App.
  - Users can watch Match details (including time, score, winner team, MVP etc)
  - Users can see the points table on the App.
  - Users will get announcements from Organisers in case of match rescheduling or any important update on the App.
  - Many Features which can't be explained through a README. You can see the demo video below.

- Admin Side
  - Admin can add teams on the App which are registered for the tournament.
  - Admin can organise Live Auction for the teams and players on the App inself.
  - Admin gets live updates about the Auction during live Auction.
  - Admin can add match schedule on the App which will be displayed to the users.
  - Admin can announce any updates throught the App itself.


<!-- GETTING STARTED -->
## Getting Started

Start working on this Project and getting started with Prerequisties.have a overview of this app on [wiki](https://github.com/iiitv/Arcadia-Auction/wiki)

### Prerequisites

you should have Flutter SDK installed in your environment.
* flutter
  ```sh
  git clone https://github.com/flutter/flutter.git -b stable
  ```

### Installation

1. Fork this repo
2. Clone the repo
   ```sh
   git clone https://github.com/<your-username>/Arcadia-Auction
   ```
3. Install pubspec Dependencies
   ```sh
   flutter pub get
   ```
4. Create your Feature Branch 
   ```sh
   git branch (Feature name)
   ```
5. Start working on issue/feature

### Note
 - If you are not able to debug your app, that's maybe because you need to configure SHA1 in Firebase, just copy the code below and paste it in your terminal (if asked password use "android") and set it up on firebase.[Admin access](https://github.com/iiitv/Arcadia-Auction/issues/9).
 ```sh
  keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore
   ```
 

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.
Read guidelines and getting started [here](https://github.com/iiitv/Arcadia-Auction/blob/main/CONTRIBUTION.md). Start working on the [issue](https://github.com/iiitv/Arcadia-Auction/issues).

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

## Tech Stack

- Flutter
- Firebase
- Provider
