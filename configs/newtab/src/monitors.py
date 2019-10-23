#!/usr/bin/env python2

import requests
import cherrypy

PORT = 3030
HTML = """
<html>
	<head>
		<title>QA NAGIOS DASHBOARD</title>
		<style type='text/css'>
		* {
			margin: 0;
			padding: 0;
		}
		a {
  			color: black;
  			text-decoration: none; /* no underline */
		}
		body {
			font-family: sans-serif;
			line-height: 1.3em;
			overflow-x: hidden;
			font-size: 1.2em;
		}

		table {
			border-collapse: collapse;
			width: 100%;
		}

		td {
			padding: .1em 1em;
			text-align: center;
		}

		h1 {
			display: inline-block;
			margin-left: 10px;
		}

		.head {
			background: lightGray;
			color: black;
			text-align: center;
			font-size: large;
		}

		.head th {
			border-right: 2px solid #a8a8a8;
			padding: .2em 10px;
			align: center;
		}

		.critical {
			background: #a42102;
			color: white;
			font-size: 3em !important;
			line-height: 1.2em;
		}

		.critical td {
			border: 2px solid #7f0000;
			padding: .1em 10px;
		}

		.critical a{
			color: white;
		}

		.warning {
			background: #fdc700;
			color: black;
			font-size: 3em !important;
			line-height: 1.2em;
		}
		.warning td{
			border: 2px solid #a66300;
			padding: .1em 10px;
		}

		.aborted {
			background: #656565;
			color: white;
			font-size: 3em !important;
			line-height: 1.2em;
		}
		.aborted td{
			border: 2px solid #323232;
			padding: .1em 10px;
		}
		.aborted a{
			color: white;
		}

		.disabled {
			background: #dadada;
			color: black;
  			text-decoration: line-through;
			font-size: 3em !important;
			line-height: 1.2em;
		}
		.disabled td{
			border: 2px solid #656565;
			padding: .1em 10px;
		}

		.stable {
			background: #4d8c3a;
			color: black;
			font-size: 3em !important;
			line-height: 1.2em;
		}
		.stable td{
			border: 2px solid #264715;
			padding: .1em 10px;
		}

		.widget {
			line-height: 1em;
			font-size: small;
		}
		.statusinfo {
			font-size: 30px !important;
		}
		#nagios_placeholder {
		}
		#loading {
			background: transparent url(throbber.gif) no-repeat center center;
			width: 214px;
			height: 13px;
			display: inline-block;
		}
		#refreshing {
			color: gray;
			display: inline-block;
			font-family: monospace;
		}
		#refreshing_countdown {
			display: inline-block;
			width: 15px;
			text-align: center;
		}
		#refreshing, #loading, h1 {
			line-height: 50px;
			font-size: 1em;
		}
		</style>
	</head>
	{{}}
	</body>
</html>
"""
JENKINS_AUTH = ('jenkins-product-radiators','23b2715e0be36a3c49f9e8106c7afc06')
NODE_KEY = {'jenkins-master':'master','jenkins-node-win': 'jenkins-node-win','jenkins-node10': 'fat-10','jenkins-node11': 'fat-11','jenkins-node15': 'fat-15','jenkins-node16': 'fat-16','jenkins-node17': 'cloud-17','jenkins-node18': 'fat-18','jenkins-node19': 'fat-19','jenkins-node30': 'cloud-30','jenkins-node31': 'slim-31','jenkins-node32': 'slim-32','jenkins-node33': 'tiny-33','jenkins-node35': 'fat-35','jenkins-node36': 'fat-36','jenkins-node37': 'fat-37','jenkins-node38': 'fat-38','jenkins-node44': 'slim-44','jenkins-node45': 'slim-45','jenkins-node46': 'slim-46','jenkins-node47': 'slim-47','jenkins-node48': 'slim-48','jenkins-node5': 'fat-5','jenkins-node52': 'fat-52','jenkins-node53': 'fat-53','jenkins-node55': 'fat-55','jenkins-node56': 'fat-56','jenkins-node57': 'fat-57','jenkins-node58': 'fat-58','jenkins-node59': 'slim-59','jenkins-node60': 'slim-60','jenkins-node61': 'slim-61','jenkins-node62': 'slim-62','jenkins-node63': 'slim-63','jenkins-node64': 'slim-64','jenkins-node65': 'slim-65','jenkins-node66': 'slim-66','jenkins-node67': 'slim-67','jenkins-node68': 'slim-68','jenkins-node69': 'slim-69','jenkins-node7': 'fat-7','jenkins-node70': 'slim-70','jenkins-node71': 'chubby-71','jenkins-node73': 'chubby-73','jenkins-node74': 'chubby-74','jenkins-node75': 'chubby-75','jenkins-node77': 'chubby-77','jenkins-node78': 'chubby-78'}

def getEmpty():
	return HTML.replace("{{}}", "<body bgcolor='#7s87878'></body>")

def getExecutors(text):
	for key,value in NODE_KEY.items():
		text.replace(key, value)
	return text


def getJenkinsBoard(radiator, green):
	jobs = requests.get('https://jenkins-product.feedzai.com/view/{}/api/json'.format(radiator), auth=JENKINS_AUTH).json()["jobs"]

 	order = {"red": 1, "yellow": 2, "blue": 3, "disabled": 4, "aborted": 4, "notbuilt": 4}
	colors = {"red": "critical", "yellow": "warning", "blue": "stable", "disabled": "disabled", "aborted": "aborted", "notbuilt": "disabled"}

	for job in jobs:
		if "anime" in job["color"]:
			job["running"] = ">>>"
			job["color"] = job["color"][:-6]
		else:
			job["running"] = ""
		job["order"] = order[job["color"]]
		job["color"] = colors[job["color"]]

	lines = "<body bgcolor='#e8e8e8'><div id='nagios_placeholder'><table width='90%' border='0' class='boldtable' align='center'><tbody>"
	jobs.sort(key=lambda x: x["order"])
	for i,job in enumerate(jobs):
		if job["order"] != 3 or green == "true":
			if (i == 0 or job["order"] != jobs[i-1]["order"]):
				lines += "<tr height='5px'><td colspan='2'></td></tr>"
			lines +="<tr class='{0:} widget'><td class='widget'><a target='_parent' href={1:}>{2:}</a></td><td class='widget'>{3:}</td></tr>\n".format(job["color"], job["url"], job["name"], job["running"])
			
	lines +="</div>"
	lines +="<meta http-equiv='refresh' content='60'/>"

	return HTML.replace("{{}}", lines)

def getNagiosBoard():
	return getExecutors(requests.get('https://jenkins-monitoring.feedzai.com/monitor?widget=true&bgcolor=%23e8e8e8').text)

def getInfo(board, radiator, green):
	try:
		if board == "jenkins":
			return getJenkinsBoard(radiator, green)
		elif board == "nagios":
			return getNagiosBoard()
		else:
			return getEmpty()
	except requests.ConnectionError:
		return getEmpty()

class HelloWorld(object):
    @cherrypy.expose
    def index(self, board = None, radiator = None, green = None):
        return getInfo(board, radiator, green)

if __name__ == "__main__":
	from cherrypy.process.plugins import Daemonizer
  	d = Daemonizer(cherrypy.engine)
  	d.subscribe()
  	
  	cherrypy.config.update({'server.socket_port': PORT})
	cherrypy.quickstart(HelloWorld())