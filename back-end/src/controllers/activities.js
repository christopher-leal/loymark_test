const models = require('./../config/db').models();
const { STATUS_CODES, defaultResponses } = require('../utils/defaultResponses');
const utils = require('./../utils/utils');

const getActivities = async (req, res) => {
    const data = await utils.getItemsWithPagination(models.Activity, req.body, {}, 'user');
    return res.status(data.statusCode).json(data);
};

const getActivitiesByUser = async (req, res) => {
    const { userId } = req.body;
    if (!userId) return res.status(STATUS_CODES.BAD_REQUEST).json(defaultResponses.BadRequest);
    let orderKey = req.body['order'] || model.primaryKeyAttributes[0];

    try {
        const items = await models.Activity.findAll({
            where: { userId },
            order: [[orderKey, 'DESC']]

        })
        return res.status(STATUS_CODES.OK).json({ ...defaultResponses.Success, data: { items } });
    } catch (error) {
        console.log(error)
        return res.status(STATUS_CODES.SERVER_ERROR).json(defaultResponses.DbError)

    }
};

module.exports = {
    getActivities,
    getActivitiesByUser
};
