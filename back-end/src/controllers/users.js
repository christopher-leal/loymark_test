const models = require('./../config/db').models();
const { STATUS_CODES, defaultResponses } = require('../utils/defaultResponses');
const utils = require('./../utils/utils');


const getUsers = async (req, res) => {
    const data = await utils.getItemsWithPagination(models.User, req.body, { status: true })
    return res.status(data.statusCode).json(data);
};

const upsertUser = async (req, res) => {
    try {
        let data;
        if (req.body.id)
            data = await models.User.findByPk(req.body.id)
        if (data) {
            updateHistory = utils.getUpdateHistory(req.body, data['dataValues'])
            if (!updateHistory)
                return res.status(STATUS_CODES.BAD_REQUEST).json(defaultResponses.BadRequest)

            await data.update(updateHistory.new)
            const keys = Object.keys(updateHistory.old)
            const activity = { userId: data['id'], activity: `User updated fields ${keys.join(', ')}` }
            await models.Activity.create(activity)

            return res.status(STATUS_CODES.OK).json({ ...defaultResponses.Success, data })

        } else {
            updateHistory = utils.getUpdateHistory(req.body, {})
            if (!updateHistory)
                return res.status(STATUS_CODES.BAD_REQUEST).json(defaultResponses.BadRequest)

            data = await models.User.create(updateHistory.new)
            const activity = { userId: data['id'], activity: 'User created' }
            await models.Activity.create(activity)
            return res.status(STATUS_CODES.OK).json({ ...defaultResponses.Success, data })

        }

    } catch (error) {
        console.log(error)
        return res.status(STATUS_CODES.BAD_REQUEST).json(defaultResponses.BadRequest)
    }
};


const deleteUser = async (req, res) => {
    try {
        const { id } = req.body;
        const deletedUser = await User.findByPk(id);
        if (!deletedUser) return res.status(STATUS_CODES.NOT_FOUND).json(defaultResponses.NotFound);
        deletedUser.status = false;
        await deletedUser.save();
        return res.status(STATUS_CODES.OK).json(defaultResponses.Success)
    } catch (error) {
        return res.status(STATUS_CODES.SERVER_ERROR).json(defaultResponses.DbError)
    }
};

module.exports = {
    getUsers,
    upsertUser,
    deleteUser
};