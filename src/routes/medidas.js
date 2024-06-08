var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.post("/manutencao1", function (req, res) {
    medidaController.buscarManutencao(req, res);
});

// router.get("/tempo-real/:idAquario", function (req, res) {
//     medidaController.buscarMedidasEmTempoReal(req, res);
// })

module.exports = router;