import net.http
import ui
import gx
import json

struct Fact {
	fact string
}

fn btn_fact_click(mut app App, b voidptr) {
	resp := http.get('https://dog-facts-api.herokuapp.com/api/v1/resources/dogs?number=' + app.number) or {
		eprintln('Failed to fetch data from the server')
		return
	}
	r := resp.text

	mut facts := json.decode([]Fact, r) or {
        eprintln('Failed to parse json')
        return
    }
	
	for fact in facts {
		ui.message_box((facts.index(fact) + 1).str() + ':\n$fact.fact')
	}
}

struct App {
	mut:
		window &ui.Window
		number string
}

fn test() {

}

fn main() {
	mut app := &App{
		window: 0
		number: ''
	}
	
	app.window = ui.window(
		height: 50,
		width: 300,
		state: app,
		title: 'Dog Facts',
		bg_color: gx.light_blue
		children: [
			ui.row(
				margin: ui.Margin{10, 10, 10, 10}
				widths: [140.0, ui.stretch]
				spacing: 10

				children: [
					ui.column(
						spacing: 10
						children:[
							ui.textbox(
								max_len: 20
								placeholder: 'Number of facts'
								text: &app.number
								is_focused: true
							)
						]
					),
					ui.column(
						spacing: 10
						children:[
							ui.button(
								text: 'GIVE ME A FACT'
								onclick: btn_fact_click
							)
						]
					)
				]
			)
		]
	)
	ui.run(app.window)
}