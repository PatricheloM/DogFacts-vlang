import os { input }
import net.http
import json

struct Fact {
	fact string
}

fn main() {
	number := input('Enter the number of facts: ')
	resp := http.get('https://dog-facts-api.herokuapp.com/api/v1/resources/dogs?number=' + number.str()) or {
		eprintln('Failed to fetch data from the server')
		return
	}
	r := resp.text
	
	mut facts := json.decode([]Fact, r) or {
        eprintln('Failed to parse json')
        return
    }

	for fact in facts {
		println((facts.index(fact) + 1).str() + ':\n$fact.fact\n')
	}
}