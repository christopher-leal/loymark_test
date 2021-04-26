var DataTypes = require("sequelize").DataTypes;
var _Activity = require("./activity");
var _User = require("./user");

function initModels(sequelize) {
  var Activity = _Activity(sequelize, DataTypes);
  var User = _User(sequelize, DataTypes);

  Activity.belongsTo(User, { as: "user", foreignKey: "userId" });
  User.hasMany(Activity, { as: "activities", foreignKey: "userId" });

  return {
    Activity,
    User,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
