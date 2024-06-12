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

router.post("/listarequip", function (req, res) {
    medidaController.listarEquip(req, res);
});

router.post("/maisusados", function (req, res) {
    medidaController.buscarMaisUsados(req, res);
});

router.post("/qtdAparelhosMaisUsado", function (req, res){
    medidaController.quantidadeAparelhosMais(req, res);
});


router.post("/qtdAparelhosSubUso", async (req, res) => {
    medidaController.quantidadeAparelhosSub(req, res);

});

router.post("/kpimais", function (req, res) {
    medidaController.kpisMaisUsados(req, res);
});

router.post("/kpimenos", function (req, res) {
    medidaController.kpisMenosUsados(req, res);
});

module.exports = router;