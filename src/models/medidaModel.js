var database = require("../database/config");

function buscarManutencao(fkAcademia) {

    var instrucaoSql = `select equip.idEquipamento,
    equip.tipo,
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


function buscarPico(equip, dataPico, fkAcademia) {

    var instrucaoSql = `select  equipamento.tipo,
	hour(hora) as hora,
    count(equipamento.tipo) as qtd,
    (select count(idSensor)
	from sensor 
	inner join equipamento on fkEquipamento = idEquipamento
	where equipamento.tipo = '${equip}') as qtdTotal
    from sensor
    left join leitura on fkSensor = idSensor
    left join equipamento on fkEquipamento = idEquipamento
    where equipamento.tipo = '${equip}' and fkAcademia = ${fkAcademia}
    and dataLeitura = '${dataPico}'
    group by hour(hora)
    order by hora;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMaisUsados(fkAcademia) {

    var instrucaoSql = `select equip.tipo,
	sum(lei.atividade)as soma
    from leitura as lei
    inner join sensor as sens on lei.fkSensor = sens.idSensor
    inner join equipamento as equip on sens.fkEquipamento = equip.idEquipamento
    where fkAcademia = ${fkAcademia}  and  dataLeitura >= DATE_ADD(CURDATE(),INTERVAL -7 DAY)
    group by equip.tipo
    order by soma desc;`;

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

    var instrucaoSql = `select distinct equip.tipo
    from equipamento as equip 
    inner join sensor as sens on sens.fkEquipamento = equip.idEquipamento
    inner join leitura as lei on lei.fkSensor = sens.idSensor
    where fkAcademia = ${fkAcademia};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

async function quantidadeAparelhosSub(fkAcademia) {
    var instrucaoSql = `
            select count(*) as quantidade
            from (
                select e.idEquipamento
                from equipamento e
                join sensor s on e.idEquipamento = s.fkEquipamento
                join leitura l on s.idSensor = l.fkSensor
                where fkAcademia = ${fkAcademia}
                group by e.idEquipamento
                having sum(l.atividade) < 5
            ) as subquery;`;
            console.log("Executando a instrução SQL: \n" + instrucaoSql);
            return database.executar(instrucaoSql);
        }
        

function quantidadeAparelhosMais(fkAcademia) {
    var instrucaoSql = `select count(*) as quantidade
            from (
                select e.idEquipamento
                from equipamento e
                join sensor s on e.idEquipamento = s.fkEquipamento
                join leitura l on s.idSensor = l.fkSensor
                where fkAcademia = ${fkAcademia}
                group by e.idEquipamento
                having sum(l.atividade) > 40
            ) as subquery;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function kpisMaisUsados(fkAcademia) {
    var instrucaoSql = `select e.idEquipamento, e.tipo, sum(l.atividade)as soma
    from equipamento e
    join sensor s on e.idEquipamento = s.fkEquipamento
    join leitura l on s.idSensor = l.fkSensor
    where fkAcademia = ${fkAcademia} and  dataLeitura >= DATE_ADD(CURDATE(),INTERVAL -7 DAY)
    group by e.idEquipamento
    having sum(l.atividade) > 40
    order by soma desc`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function kpisMenosUsados(fkAcademia) {
    var instrucaoSql = `select e.idEquipamento, e.tipo, sum(l.atividade)as soma
    from equipamento e
    join sensor s on e.idEquipamento = s.fkEquipamento
    join leitura l on s.idSensor = l.fkSensor
    where fkAcademia = ${fkAcademia} and  dataLeitura >= DATE_ADD(CURDATE(),INTERVAL -7 DAY)
    group by e.idEquipamento
    having sum(l.atividade) < 5
    order by soma desc`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function nomeAcademia(fkAcademia) {
    var instrucaoSql = `select nome
        from academia
        where idAcademia = ${fkAcademia};
        `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}
module.exports = {
    buscarManutencao,
    buscarPico,
    buscarMaisUsados,
    listarData,
    listarEquip,
    quantidadeAparelhosSub,
    quantidadeAparelhosMais,
    kpisMaisUsados,
    kpisMenosUsados,
    nomeAcademia,
}
