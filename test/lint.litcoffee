# module lint tests
a place for things that should be true of every module

	fs = require "fs"
	PJV = require("package-json-validator").PJV

	module.exports =
		"package.json":
			"should exist": (done) ->
				fs.exists "package.json", (exists) ->
					if exists
						done()
					else
						done new Error "but it doesn't"
			"should satisfy PJV": (done) ->
				pkg = fs.readFileSync "package.json", "utf-8"
				result = PJV.validate pkg, "npm",
					warnings: true
					recommendations: true

				if result.valid
					done()
				else
					done new Error result.critical
