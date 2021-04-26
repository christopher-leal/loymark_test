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
    const data = await utils.getItemsWithPagination(models.Activity, req.body, { userId });
    return res.status(data.statusCode).json(data);
};

module.exports = {
    getActivities,
    getActivitiesByUser
};
