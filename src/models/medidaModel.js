var database = require("../database/config");

function buscarManutencao(fkAcademia) {

    var instrucaoSql = `select equip.tipo,
    sum(lei.atividade) as soma
    from leitura as lei
    inner join sensor as sens on lei.fkSensor = sens.idSensor
    inner join equipamento as equip on sens.fkEquipamento = equip.idEquipamento
    where equip.dataManutencao <= lei.dataLeitura and fkAcademia = ${fkAcademia}
    group by fkSensor
    order by soma desc
    limit 3;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function buscarPico(fkSensor,dataPico) {

    var instrucaoSql = `select hour(hora) as hora,
    sum(atividade) as pico
    from leitura
    where fkSensor = ${fkSensor}
    and dataLeitura = '${dataPico}'
    group by hour(hora)
    order by hora;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarData(fkAcademia) {

    var instrucaoSql = `select distinct 
    DATE_FORMAT(dataLeitura,'%Y-%m-%d') as dataLeitura,
    DATE_FORMAT(dataLeitura,'%d/%m/%Y') as data
    from leitura
    inner join sensor on fkSensor = idSensor
    inner join equipamento on fkEquipamento = idEquipamento
    where dataLeitura >= DATE_ADD(CURDATE(),INTERVAL -7 DAY)
    and fkAcademia = ${fkAcademia}
    order by dataLeitura desc;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function listarEquip(fkAcademia) {

    var instrucaoSql = `select equip.idEquipamento,
	equip.tipo
    from equipamento as equip 
    inner join sensor as sens on sens.fkEquipamento = equip.idEquipamento
    inner join leitura as lei on lei.fkSensor = sens.idSensor
    where fkAcademia = ${fkAcademia}
    group by equip.idEquipamento;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarManutencao,
    buscarPico,
    listarData,
    listarEquip,
}
