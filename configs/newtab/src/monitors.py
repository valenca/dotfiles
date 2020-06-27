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

def getEmpty():
	return HTML.replace("{{}}", "<body bgcolor='#7s87878'></body>")

def getJenkinsBoard(radiator):
	jobs = requests.get('https://jenkins-product.feedzai.com/view/{}/api/json'.format(radiator), auth=JENKINS_AUTH).json()["jobs"]

 	order = {"red": 1, "yellow": 2, "blue": 3, "disabled": 4, "aborted": 4}
	colors = {"red": "critical", "yellow": "warning", "blue": "stable", "disabled": "unknown", "aborted": "unknown"}

	for job in jobs:
		if "anime" in job["color"]:
			job["running"] = "..."
			job["color"] = job["color"][:-6]
		else:
			job["running"] = ""
		job["order"] = order[job["color"]]
		job["color"] = colors[job["color"]]

	lines = "<body bgcolor='#e8e8e8'><div id='nagios_placeholder'><table width='90%' border='0' class='boldtable' align='center'><tbody>"
	jobs.sort(key=lambda x: x["order"])
	for i,job in enumerate(jobs):
		if job["order"] != 3:
			if (i == 0 or job["order"] != jobs[i-1]["order"]):
				lines += "<tr height='5px'><td colspan='6'></td></tr>"
			lines +="<tr class='{} widget'><td class='widget'><a target='_parent' href={}>{}</a></td><td class='widget' colspan=5>{}</td>\n".format(job["color"], job["url"], job["name"], job["running"])
			
	lines +="</div>"
	lines +="<meta http-equiv='refresh' content='60'/>"

	return HTML.replace("{{}}", lines)

def getInfo(board, radiator):
	try:
		if board == "jenkins":
			return getJenkinsBoard(radiator)
		else:
			return getEmpty()
	except requests.ConnectionError:
		return getEmpty()

class HelloWorld(object):
    @cherrypy.expose
    def index(self, board = None, radiator = None):
        return getInfo(board, radiator)

if __name__ == "__main__":
	from cherrypy.process.plugins import Daemonizer
  	d = Daemonizer(cherrypy.engine)
  	d.subscribe()
  	
  	cherrypy.config.update({'server.socket_port': PORT})
	cherrypy.quickstart(HelloWorld())