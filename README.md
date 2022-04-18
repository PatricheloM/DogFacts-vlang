# Dog Facts API implementation in V language
##### Simple UI and Console application getting your daily dose of dog fact no matter the number of them!
###### Both codes are using the same Dog Facts API. Its documentation is [available on this link](https://dukengn.github.io/Dog-facts-API/).

## Written in V language
These codes were written in V: a powerful, simple, fast, safe, compiled language with its compilation time close to zero second.
V's **net** and **json** library makes it possible to write the API getting method and JSON deserialization in 10 lines!
```go
struct Fact {
	fact string
}
```
```go
// getting the JSON containing the facts
resp := http.get('https://dog-facts-api.herokuapp.com/api/v1/resources/dogs?number=1' + number.str()) or {
	eprintln('Failed to fetch data from the server')
	return
}
	
// deserializing the JSON with the []Fact structure, giving back a []Fact structure
mut facts := json.decode([]Fact, resp.text) or {
	eprintln('Failed to parse json')
	return
}
```
###### Yout can find V language [here](https://vlang.io/).

## Compling and running
Since V is a compiled language, it produces a binary file for your OS to run.
V translates to C and then compiles the C code.
###### Yout can clone the compiler's repository [from this link](https://github.com/vlang/v/).
###### For the UI code to be compiled, get the UI library [from this link](https://github.com/vlang/ui/).

## Dog Facts in the console
Simply compile and run the code then enter the number of facts you want to get.
```go
// reads the number from console then adds it to the end of the API url
number := input('Enter the number of facts: ') 
```
```go
// then it prints out every fact to the console
for fact in facts {
	println((facts.index(fact) + 1).str() + ':\n$fact.fact\n')
}
```
![Console](https://i.imgur.com/ZbhdNcm.jpg)

## Dog Facts UI
Same as the console one, compile and run the code then enter the number of facts you want to get to the text box then click the button.
```go
struct App {
	mut:
	window &ui.Window
	number string
}
```
```go
// stores the number in the UI's struct
ui.textbox(
	max_len: 20
	placeholder: 'Number of facts'
	text: &app.number
	is_focused: true
)
```
```go
ui.button(
	text: 'GIVE ME A FACT'
	onclick: btn_fact_click
)
```
```go
// calls for this function on button click getting th UI's struct with its variables 
// and gives you the fact in a message box
fn btn_fact_click(mut app App, b voidptr) {

	...
    
	for fact in facts {
		ui.message_box((facts.index(fact) + 1).str() + ':\n$fact.fact')
	}
}
```
![UI](https://i.imgur.com/3Fnl2g5.jpg)
