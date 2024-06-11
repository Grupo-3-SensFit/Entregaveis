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

router.get("/qtdAparelhosMaisUsado", async (req, res) => {
    try {
        const quantidade = await medidaController.quantidadeAparelhosMais();
        res.status(200).json({ quantidade });
    } catch (error) {
        res.status(500).json({ message: "Erro ao obter quantidade de aparelhos." });
    }
});


router.get("/aparelhosSubUso", async (req, res) => {
    try {
        const quantidade = await medidaController.quantidadeAparelhosSub();
        res.status(200).json({ quantidade });
    } catch (error) {
        res.status(500).json({ message: "Erro ao obter quantidade de aparelhos." });
    }
});

router.post("/kpimais", function (req, res) {
    medidaController.kpisMaisUsados(req, res);
});

module.exports = router;