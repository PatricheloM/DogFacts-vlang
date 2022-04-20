import vweb
import time
import net.http
import json

const (
	port = 8082
)

struct App {
	vweb.Context
mut:
	state shared State
}

struct State {
mut:
	cnt int
}

struct Fact {
	fact string
}

struct Form {
	number string
}

fn main() {
	vweb.run(&App{}, port)
}

pub fn (mut app App) index() vweb.Result {
	lock app.state {
		app.state.cnt++
		println('Someone visited at: $time.now().str()')
	}
	
	return $vweb.html()
}


['/facts'; post]
pub fn (mut app App) facts() vweb.Result {
	
	lock app.state {
		app.state.cnt++
		println('Someone visited at: $time.now().str()')
	}
	mut returnvals := []string{}
	mut errorb := false
	
	if app.form['number'] == '0' {
		returnvals << 'Fact number should not be null'
		return $vweb.html()
	}
	
	resp := http.get('https://dog-facts-api.herokuapp.com/api/v1/resources/dogs?number=' + app.form['number']) or {
		returnvals << 'Failed to fetch data from the server'
		return $vweb.html()
	}
	r := resp.text
	
	mut facts := json.decode([]Fact, r) or {
        returnvals << 'Failed to parse json'
		return $vweb.html()
    }
	
	for fact in facts {
		returnvals << fact.fact
	}
	
	if  returnvals[0] != 'Failed to parse json' || returnvals[0] != 'Failed to fetch data from the server' {
		errorb = true
	}
	
	return $vweb.html()
}