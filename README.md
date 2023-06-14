# Movie Watchlist

An entertainment app which allows user to get infomation about the movies and create their own watchlist.


<img width="400" alt="Screen Shot 2021-06-18 at 14 19 13" src="app/assets/images/Screenshot 2023-06-12 at 19.10.32.png">
App home: https://jap-watchlist.herokuapp.com/


## Getting Started
### Setup

Install gems
```
bundle install
```
Install JS packages
```
yarn install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
MAPBOX_API_KEY=your_own_mapbox_api_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Acknowledgements
Inspired by Airbnb

## Team Members
- [Juan Bernal](https://github.com/mesieou)
- [Rika Saito](https://github.com/arki-s)
- [Xuemei Huang](https://github.com/meifruit)
- [Jun Ukemori](https://github.com/jukemori)


## License
This project is licensed under the MIT License
