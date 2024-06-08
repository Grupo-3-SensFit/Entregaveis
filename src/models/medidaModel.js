var database = require("../database/config");

function buscarManutencao(fkAcademia) {

    var instrucaoSql = `select equip.tipo,
    sum(lei.atividade) as soma
    from leitura as lei
    inner join sensor as sens on lei.fkSensor = sens.idSensor
    inner join equipamento as equip on sens.fkEquipamento = equip.idEquipamento
    where equip.dataManutencao <= lei.dataLeitura and fkAcademia = ${fkAcademia}
    group by fkSensor
    having soma >= 6
    order by soma desc
    limit 3;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// function buscarMedidasEmTempoReal(idAquario) {

//     var instrucaoSql = `SELECT 
//         dht11_temperatura as temperatura, 
//         dht11_umidade as umidade,
//                         DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
//                         fk_aquario 
//                         FROM medida WHERE fk_aquario = ${idAquario} 
//                     ORDER BY id DESC LIMIT 1`;

//     console.log("Executando a instrução SQL: \n" + instrucaoSql);
//     return database.executar(instrucaoSql);
// }

module.exports = {
    buscarManutencao,
    // buscarMedidasEmTempoReal
}
