package controllers

import (
	"encoding/json"
	// "fmt"
	"io/ioutil"
	"log"
	// "net/http"

	"github.com/beego/beego/v2/client/httplib"
	beego "github.com/beego/beego/v2/server/web"
)

type MainController struct {
	beego.Controller
}

type CatController struct {
	beego.Controller
}

type CatData[] struct {
	Id string `json:"id"`
	Url string `json:"url"`
	Height int `json:"height"`
	Width int `json:"width"`
}

func (c *MainController) Get() {
	c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"
	c.TplName = "index.tpl"
}

func (c *CatController) Get() {
	//response, err := http.Get(`https://jsonplaceholder.typicode.com/posts`)

	req := httplib.Get(`https://api.thecatapi.com/v1/images/search`)
	req.Header("x-api-key","880a5248-54b0-4ba7-a7cd-cc8b89a979d8")
	req.Param("limit","10")

	response, err := req.Response()

	if err != nil {
		log.Fatal(err)
	}

	// fmt.Println(response)

	bytes, errRead := ioutil.ReadAll(response.Body)

	// defer func() {
	// 	e := response.Body.Close()
	// 	if e != nil {
	// 		log.Fatal(e)
	// 	}
	// }()

	if errRead != nil {
		log.Fatal(errRead)
	}
	// log.Print(string(bytes))

	var catdata CatData

	errUnmarshal := json.Unmarshal(bytes, &catdata)

	if errUnmarshal != nil {
		log.Fatal(errUnmarshal)
	}

	// log.Printf("%+v", catdata)

	// c.Data["id"] = catdata
	// c.Data["url"] = catdata
	// c.Data["height"] = catdata
	// c.Data["width"] = catdata

	c.Data["catdata"] = &catdata

	log.Printf("%+v", &catdata)
 
	c.TplName = "cat.tpl"
}

