// IMPORTS
// Express
const express = require('express');
const app = express();
// DotEnv
require('dotenv').config();
//BodyParser
const bodyParser = require('body-parser') 
//Cors
const cors = require('cors')

// Routes
const cestas = require('./Routes/cestas');
    

// CONFIGURE     
// Cors
app.use(cors());    

 // BodyParser
 app.use(bodyParser.json())
 app.use(bodyParser.urlencoded({ extended: true }))


// ROTAS
app.get('/', (req, res) => {
    res.send('Hello World');
});

// Cestas
app.use('/cestas', cestas);



// Port
const PORT = process.env.PORT || 2333;
app.listen(PORT, () => {
    console.log('Server Running !')
})







