from flask import Flask, render_template, request
from flask_mongoengine import MongoEngine

app = Flask(__name__ , template_folder = 'common', static_folder = 'common', static_url_path = '')

db = MongoEngine()

app.config['MONGODB_SETTINGS'] = {
	'db' : 'test',
	'host' : 'localhost',
	'port' : 27017

}

db.init_app(app)

class Messages(db.Document):
	message = db.StringField(required = True)

@app.route('/')
def renderIndex():
	return render_template('index.html')


@app.route('/save', methods = ['POST'])
def saveToDb():

	data  = request.form

	print data
	if data.get('message'):
		new_message = Messages(message = data['message'])
		new_message.save()
	
	return render_template('index.html', status = 'Message saved successfuly !')


if __name__ == "__main__":
	app.run(host='0.0.0.0', debug = True)