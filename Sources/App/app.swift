import Vapor
import Dispatch

let timer = DispatchSource.makeTimerSource()

/// Creates an instance of Application. This is called from main.swift in the run target.
public func app(_ env: Environment) throws -> Application {
    var config = Config.default()
    var env = env
    var services = Services.default()
    try configure(&config, &env, &services)
    let app = try Application(config: config, environment: env, services: services)
    try boot(app)
    registerTimer()
    return app
}

func registerTimer() {
    
    timer.schedule(deadline: .now() + .seconds(60), repeating: .seconds(60), leeway: .seconds(30))
    timer.setEventHandler() {
        print("Timer fired")
    }
    timer.resume()
}

