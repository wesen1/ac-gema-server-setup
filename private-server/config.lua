---
-- @author wesen
-- @copyright 2020-2021 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

---
-- Private server configuration.
--
return {
  waitMillisecondsBeforeDatabaseConnection = 5000,

  LuaORM = {
    connection = "LuaSQL/MySQL",
    database = {
      databaseName = os.getenv("DATABASE_NAME"),
      host = "database",
      portNumber = 3306,
      userName = os.getenv("DATABASE_USER"),
      password = os.getenv("DATABASE_PASSWORD")
    },
    logger = { isEnabled = true, isDebugEnabled = false }
  },

  ClientOutputFactory = {
    fontConfigFileName = "FontDefault",
    defaultConfiguration = {
      maximumLineWidth = 3900
    }
  },

  colorConfigurationFileName = "colors",

  extensions = {

    -- Core extensions
    "AC-LuaServer.Extensions.GameModeManager.GameModeManager",
    "GemaMode",
    [ "GemaScoreManager.GemaScoreManager" ] = {
      {
        mergeScoresByPlayerName = true,
        contexts = {
          "main", "knife", "pistol", "assault-rifle", "submachine-gun", "sniper-rifle", "shotgun", "carbine"
        }
      },
      {
        mergeScoresByPlayerName = true,
        contexts = {
          "main", "knife", "pistol", "assault-rifle", "submachine-gun", "sniper-rifle", "shotgun", "carbine"
        }
      }
    },
    "Extensions.GemaMapManager",
    "Extensions.MapStatisticsPrinter",
    "Extensions.GemaMapRotationManager",

    "CommandManager.CommandManager",
    "Commands.CmdsCommand",
    "Commands.HelpCommand",
    ["Commands.ExtendTimeCommand"] = { 20 },
    ["Commands.MapTopCommand"] = { 10 },
    "Commands.RulesCommand",
    "Commands.MapScoreCommand",
    ["Commands.ServerTopCommand"] = { 10 },
    "Commands.ServerScoreCommand",
    "Commands.ScoreContextsCommand",
    "Commands.ResetCommand",
    "Commands.LatestMapsCommand",

    -- Optional extensions
    "Extensions.AutoFlagReset",
    "Extensions.AdditionalServerInfos",
    ["Extensions.ConnectionAmountLimiter"] = { 2 },
    "Extensions.UnplayableGemaMapsRemover",
    "Extensions.GlobalVoicecom",
    "Extensions.ItemReset"
  }
}
