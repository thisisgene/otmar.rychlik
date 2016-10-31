// modules =================================================
var express        = require('express');
var app            = express();
var path           = require('path');
var favicon 			 = require('serve-favicon');
var logger 				 = require('morgan');
var mongoose       = require('mongoose');
var cookieParser 	 = require('cookie-parser');
var bodyParser     = require('body-parser');
var methodOverride = require('method-override');
var passport 			 = require('passport');
var LocalStrategy  = require('passport-local').Strategy;


// configuration ===========================================

// config files
var db = require('./config/db');

var port = process.env.PORT || 30666; // set our port
// mongoose.connect(db.url); // connect to our mongoDB database (commented out after you enter in your own credentials)

// get all data/stuff of the body (POST) parameters
app.use(bodyParser.json()); // parse application/json
app.use(bodyParser.json({ type: 'application/vnd.api+json' })); // parse application/vnd.api+json as json
app.use(bodyParser.urlencoded({ extended: true })); // parse application/x-www-form-urlencoded
// app.use(cookieParser());

// app.use(require('express-session')({
//     secret: 'keyboard cat',
//     resave: false,
//     saveUninitialized: false
// }));
// app.use(passport.initialize());
// app.use(passport.session());
// app.use(express.static(path.join(__dirname, 'public')));

app.use(methodOverride('X-HTTP-Method-Override')); // override with the X-HTTP-Method-Override header in the request. simulate DELETE/PUT
app.use(express.static(__dirname + '/public')); // set the static files location /public/img will be /img for users

app.set('views', path.join(__dirname, '/views'));
app.set('view engine', 'pug');

// routes ==================================================
require('./app/routes')(app); // pass our application into our routes
// 
// var Account = require('./app/models/account');
// passport.use(new LocalStrategy(Account.authenticate()));
// passport.serializeUser(Account.serializeUser());
// passport.deserializeUser(Account.deserializeUser());



// start app ===============================================
app.listen(port);
console.log('Magic happens on port ' + port); 			// shoutout to the user
exports = module.exports = app; 						// expose app
