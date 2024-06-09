var medidaModel = require("../models/medidaModel");

function buscarManutencao(req, res) {
    var fkAcademia = req.body.fkAcademiaServer;


    medidaModel.buscarManutencao(fkAcademia).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function buscarPico(req, res) {
    var fkSensor = req.body.fkSensorServer;
    var dataPico = req.body.dataAtualServer;

    medidaModel.buscarPico(fkSensor, dataPico).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarMaisUsados(req, res) {
    var fkAcademia = req.body.fkAcademiaServer;


    medidaModel.buscarMaisUsados(fkAcademia).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function listarData(req, res) {
    var fkAcademia = req.body.fkAcademiaServer;

    if (fkAcademia == undefined) {
        console.log('Usuario undefined')
    } else {

        medidaModel.listarData(fkAcademia).then((resultado) => {
            res.status(200).json(resultado);
        });
    }

}

function listarEquip(req, res) {
    var fkAcademia = req.body.fkAcademiaServer;

    if (fkAcademia == undefined) {
        console.log('Usuario undefined')
    } else {

        medidaModel.listarEquip(fkAcademia).then((resultado) => {
            res.status(200).json(resultado);
        });
    }

}

module.exports = {
    buscarManutencao,
    buscarPico,
    buscarMaisUsados,
    listarData,
    listarEquip,
}