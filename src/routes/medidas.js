var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.post("/manutencao1", function (req, res) {
    medidaController.buscarManutencao(req, res);
});

router.post("/pico", function (req, res) {
    medidaController.buscarPico(req, res);
});

router.post("/listardata", function (req, res) {
    medidaController.listarData(req, res);
});

// router.get("/tempo-real/:idAquario", function (req, res) {
//     medidaController.buscarMedidasEmTempoReal(req, res);
// })

module.exports = router;