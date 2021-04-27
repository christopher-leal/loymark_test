const { defaultResponses } = require('./defaultResponses');

const getItemsWithPagination = async (model, query, where = {}, include = '') => {
    let limit = 20;
    let offset = 0;
    if (query['limit']) limit = Number(query['limit']);
    if (query['offset']) offset = Number(query['offset']);
    let orderKey = query['order'] || model.primaryKeyAttributes[0];
    try {
        const { count, rows } = await model.findAndCountAll({
            where,
            limit,
            offset,
            include,
            order: [[orderKey, 'DESC']]
        });
        return {
            ...defaultResponses.Success,
            data: {
                items: rows,
                totalItems: count,
            }
        };
    } catch (e) {
        console.log(e);
        return defaultResponses.BadRequest;
    }
};

const getUpdateHistory = (newJson, oldJson) => {
    newJson = removeNulls(newJson)
    const keys = Object.keys(newJson)
    let updated = {}
    for (let i = 0; i < keys.length; i++) {
        if (newJson[keys[i]] !== oldJson[keys[i]])
            updated = {
                new: {
                    ...updated.new,
                    [keys[i]]: newJson[keys[i]]
                },
                old: {
                    ...updated.old,
                    [keys[i]]: oldJson[keys[i]]
                }
            }
    }
    if (Object.keys(updated).length === 0)
        return null
    return updated

}
const removeNulls = (json) => {
    const keys = Object.keys(json)
    let nullValues = []
    for (let i = 0; i < keys.length; i++)
        if (!json[keys[i]] && typeof json[keys[i]] !== 'boolean' && json[keys[i]] !== '')
            nullValues.push(keys[i])
    for (let i = 0; i < nullValues.length; i++)
        delete json[nullValues[i]]
    return json
}
module.exports = {
    getUpdateHistory,
    getItemsWithPagination
}