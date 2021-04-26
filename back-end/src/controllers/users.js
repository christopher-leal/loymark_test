const models = require('./../config/db').models();
const { STATUS_CODES, defaultResponses } = require('../utils/defaultResponses');
const utils = require('./../utils/utils');
const { Op } = require("sequelize");


const getUsers = async (req, res) => {
    const data = await utils.getItemsWithPagination(models.User, req.body, { status: true })
    return res.status(data.statusCode).json(data);
};

const searchUser = async (req, res) => {
    const { find } = req.body
    if (!find) return res.status(STATUS_CODES.BAD_REQUEST).json(defaultResponses.BadRequest)
    const term = `%${find}%`
    try {

        const data = await models.User.findAll({
            where: {
                [Op.or]: [
                    { email: { [Op.like]: term } },
                    { name: { [Op.like]: term } },
                    { lastName: { [Op.like]: term } },
                    { country: { [Op.like]: term } },
                ]
            }
        })
        return res.status(STATUS_CODES.OK).json({ ...defaultResponses.Success, data });
    } catch (error) {
        return res.status(STATUS_CODES.SERVER_ERROR).json(defaultResponses.DbError)

    }
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
        const { id } = req.params;
        const deletedUser = await models.User.findByPk(id);
        if (!deletedUser) return res.status(STATUS_CODES.NOT_FOUND).json(defaultResponses.NotFound);
        deletedUser.status = false;
        await deletedUser.save();
        const activity = { userId: deletedUser['id'], activity: 'User deleted' }
        await models.Activity.create(activity)

        return res.status(STATUS_CODES.OK).json(defaultResponses.Success)
    } catch (error) {
        console.log(error)
        return res.status(STATUS_CODES.SERVER_ERROR).json(defaultResponses.DbError)
    }
};

module.exports = {
    getUsers,
    searchUser,
    upsertUser,
    deleteUser
};