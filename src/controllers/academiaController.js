var academiaModel = require("../models/academiaModel");

function cadastrar(req, res) {
    var nome = req.body.nomeServer;
    var cnpj = req.body.cnpjServer;
    var cep = req.body.cepServer;
    var fkUsuario = req.body.fkUsuarioServer;


    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } 
    else if (cnpj == undefined) {
        res.status(400).send("Seu CNPJ está undefined!");
    } else if (cep == undefined) {
        res.status(400).send("Seu CEP está undefined!");
    } else if (fkUsuario == undefined) {
        res.status(400).send("Sua fkUsuario está undefined!");
    } 
    else {
        academiaModel.cadastrar(nome, cnpj, cep, fkUsuario)
            .then(function (resultado) {
                res.json(resultado);
            }).catch(function (erro) {
                console.log(erro);
                console.log("\nHouve um erro ao realizar o cadastro! Erro: ", erro.sqlMessage || erro);
                res.status(500).json(erro.sqlMessage || erro);
            });
    }
}

module.exports = {
    cadastrar
};
