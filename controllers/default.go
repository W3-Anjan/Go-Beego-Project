package controllers

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"

	beego "github.com/beego/beego/v2/server/web"
)

type MainController struct {
	beego.Controller
}

type CatController struct {
	Title string `json:"name"`
	Body string `json:"body"`
	beego.Controller
}

func (c *MainController) Get() {
	c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"
	c.TplName = "index.tpl"
}

func (c *CatController) Get() {
	response, err := http.Get(`https://jsonplaceholder.typicode.com/posts`)

	if err != nil {
		log.Fatal(err)
	}

	bytes, errRead := ioutil.ReadAll(response.Body)

	defer func() {
		e := response.Body.Close()
		if e != nil {
			log.Fatal(e)
		}
	}()

	if errRead != nil {
		log.Fatal(errRead)
	}
	log.Print(string(bytes))

	var catController CatController

	errUnmarshal := json.Unmarshal(bytes, &catController)

	if errUnmarshal != nil {
		log.Fatal(errUnmarshal)
	}

	log.Printf("%+v", catController)
}

