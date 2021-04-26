const STATUS_CODES = {
    OK: 200,
    CREATED: 201,
    BAD_REQUEST: 400,
    UNAUTHORIZED: 401,
    FORBIDDEN: 403,
    NOT_FOUND: 404,
    DUPLICATED: 409,
    SERVER_ERROR: 500,
}
module.exports = {
    Success: {
        success: true,
        statusCode: STATUS_CODES.OK
    },
    UnknownError: {
        data: null,
        success: false,
        statusCode: STATUS_CODES.SERVER_ERROR
    },
    BadRequest: {
        data: null,
        success: false,
        statusCode: STATUS_CODES.BAD_REQUEST
    },
    DbError: {
        data: null,
        success: false,
        statusCode: STATUS_CODES.SERVER_ERROR
    },
    NotFound: {
        data: null,
        success: false,
        statusCode: STATUS_CODES.NOT_FOUND
    },


}