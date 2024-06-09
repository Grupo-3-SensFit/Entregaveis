var express = require("express");
var router = express.Router();

var academiaController = require("../controllers/academiaController");

//Recebendo os dados do html e direcionando para a função cadastrar de academiaController.js
router.post("/cadastrar", function (req, res) {
    academiaController.cadastrar(req, res);
})



module.exports = router;