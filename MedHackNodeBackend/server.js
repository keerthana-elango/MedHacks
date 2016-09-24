// Require the Express Module
var express = require('express');
var mongoose = require('mongoose');
var fs = require('fs')
// Create an Express App
var app = express();
// Require body-parser (to receive post data from clients)
var bodyParser = require('body-parser');
// Integrate body-parser with our App
app.use(bodyParser.urlencoded({ extended: true }));

//IBM Watson 
var watson = require('watson-developer-cloud');
//tone analyser 
var tone_analyzer = watson.tone_analyzer({
  username: "e5d8ec72-7e99-4593-be5b-e9e4bbb959a6",
  password: "ei8dkZPfmyi0",
  version: 'v3',
  version_date: '2016-05-19'
});
// Database
var toneSchema = new mongoose.Schema({
 day: String,
 angry: Number,
 disgust: Number,
 fear: Number,
 joy: Number,
 sadness: Number
})

mongoose.model('User', toneSchema); 
var User = mongoose.model('User')
mongoose.connect('mongodb://localhost/basic_mongoose');


// Require path
var path = require('path');

// Setting our Static Folder Directory
app.use(express.static(path.join(__dirname, './static')));
// Setting our Views Folder Directory
app.set('views', path.join(__dirname, './views'));
// Setting our View Engine set to EJS
app.set('view engine', 'ejs');
// Routes
// Root Request
app.get('/ashish', function(req, res) {
    // res.render('index');
      tone_analyzer.tone({ text: "I am testing and i am happy"},
  function(err, tone) {
    if (err)
      console.log(err);
    else
      console.log(JSON.stringify(tone, null, 2));

});

})


app.get('/',function(req,res){
  res.render("index")
})


app.get('/data',function(req,res){
  tone_analyzer.tone({ text: "I am testing and i am happy"},
  function(err, tone) {
    if (err)
      console.log(err);
    else
      console.log(JSON.stringify(tone, null, 2));
})
})

// Post  data  intially to save in database 
app.post('/post', function(req, res) {
 console.log("Message: " + req.body.message)
 
 tone_analyzer.tone(
  { text: req.body.message },
  function(err, tone) {
    if (err)
    {
      console.log(err);
    }
    
    else
    {
      console.log(JSON.stringify(tone, null, 1));
      fs.writeFile('tmp/helloworld.txt', tone, function (err) {
      if (err) 
        return console.log(err);
    }
  }

  
});
// Write to text file



 //var tone = tone["tone_categories"]
 console.log("... End of POST operation...")

  //Saving later
  // Try to save that new user to the database (this is the method that actually inserts into the db) and run a callback function with an error (if any) from the operation.
  // user.save(function(err) {
  //   // if there is an error console.log that something went wrong!
  //   if(err) {
  //     console.log('something went wrong', err);
  //   } else { // else console.log that we did well and then redirect to the root route
  //     console.log('successfully added a user!');
  //     res.redirect('/');
  //   }
  // })
})


 app.get('/find', function (req, res) {
    User.find({}, function (err, users){
      res.render('index', {users:users});  
    });
  })






// Setting our Server to Listen on Port: 8000
app.listen(8000, function(){
  console.log('Server Running');
});

