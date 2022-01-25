package routers

import (
	"myproject/controllers"
	beego "github.com/beego/beego/v2/server/web"
)

func init() {
    beego.Router("/", &controllers.MainController{})
	beego.Router("/cat", &controllers.CatController{})
	beego.Router("/front", &controllers.FrontController{})
}
