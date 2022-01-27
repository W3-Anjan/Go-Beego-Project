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

type FrontController struct {
	beego.Controller
}

type CatData[] struct {
	Id string `json:"id"`
	Url string `json:"url"`
	Height int `json:"height"`
	Width int `json:"width"`
}

type FormData[] struct {
	breed_id string
}

type CategoryData[] struct {
	Id int `json:"id"`
	Name string `json:"name"`
}

type BreedData[] struct {
	Id string `json:"id"`
	Name string `json:"name"`
}

func (c *MainController) Get() {
	c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"
	c.TplName = "index.tpl"
}

func (c *FrontController) Get() {
	breed := c.GetString("breed")
	order := c.GetString("order")
	cate := c.GetString("category")
	// limit := c.GetString("limit")
	mime_types := c.GetString("mime_types")

	log.Println(breed)
	log.Println(order)
	log.Println(cate)
	log.Println(mime_types)

	req := httplib.Get(`https://api.thecatapi.com/v1/images/search`)
	req.Header("x-api-key","880a5248-54b0-4ba7-a7cd-cc8b89a979d8")
	req.Param("breed_id",breed)
	req.Param("order",order) 
	req.Param("category_ids",cate)
	req.Param("limit","9")
	req.Param("mime_types",mime_types)

	category_req := httplib.Get(`https://api.thecatapi.com/v1/categories`)
	breed_req := httplib.Get(`https://api.thecatapi.com/v1/breeds`)

	response, err := req.Response()
	category_response, _ := category_req.Response()
	breed_response, _ := breed_req.Response()

	if err != nil {
		log.Fatal(err)
	}


	bytes, errRead := ioutil.ReadAll(response.Body)
	category_bytes, _ := ioutil.ReadAll(category_response.Body)
	breed_bytes, _ := ioutil.ReadAll(breed_response.Body)

	if errRead != nil {
		log.Fatal(errRead)
	}

	var catdata CatData
	var category CategoryData
	var breeddata BreedData

	errUnmarshal := json.Unmarshal(bytes, &catdata)
	category_errUnmarshal := json.Unmarshal(category_bytes, &category)
	breed_errUnmarshal := json.Unmarshal(breed_bytes, &breeddata)

	if errUnmarshal != nil {
		log.Fatal(errUnmarshal)
	}

	if category_errUnmarshal != nil {
		log.Fatal(category_errUnmarshal)
	}

	if breed_errUnmarshal != nil {
		log.Fatal(breed_errUnmarshal)
	}


	c.Data["catdata"] = catdata
	c.Data["category"] = category
	c.Data["breeddata"] = breeddata

	log.Printf("%+v", &catdata)
	log.Printf("%+v", &category)
	log.Printf("%+v", &breeddata)

	c.TplName = "cat.html"
}

func (c *CatController) Get() {
	//response, err := http.Get(`https://jsonplaceholder.typicode.com/posts`)

	// log.Println("---------------")
	// log.Println(c.GetString("breed"))
	// log.Println(c.GetString("order"))

	breed := c.GetString("breed")
	order := c.GetString("order")
	cate := c.GetString("category")
	limit := c.GetString("limit")
	mime_types := c.GetString("mime_types")
	page := c.GetString("page")

	// breed := "sfol"
	// order := "asc"

	log.Println(breed)
	log.Println(order)
	log.Println(cate)
	log.Println(limit)
	log.Println(mime_types)
	log.Println(page)

	req := httplib.Get(`https://api.thecatapi.com/v1/images/search`)
	req.Header("x-api-key","880a5248-54b0-4ba7-a7cd-cc8b89a979d8")
	req.Param("breed_id",breed)
	req.Param("order",order)
	req.Param("category_ids",cate)
	req.Param("limit",limit)
	req.Param("mime_types",mime_types)
	req.Param("page",page)

	response, err := req.Response()

	if err != nil {
		log.Fatal(err)
	}

	// fmt.Println(response)

	bytes, errRead := ioutil.ReadAll(response.Body)
	

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

	c.Data["catdata"] = catdata

	log.Printf("%+v", &catdata)

	c.Data["json"] = &catdata
	c.TplName = "cat.html"

	c.ServeJSON()

	
}

