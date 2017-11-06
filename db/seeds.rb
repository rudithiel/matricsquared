# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
afr = Subject.create(name: "Afrikaans Huistaal", papers: 3, code: "AFHT");
afr.save

it = Subject.create(name: "Information Technology", papers: 2, code: "INFT");
it.save

bio = Subject.create(name: "Life Sciences", papers: 2, code: "LFSC")
bio.save

maths = Subject.create(name: "Maths", papers: 2, code: "MATH");
maths.save;

science = Subject.create(name: "Physical Sciences", papers: 2, code: "PHSC");
science.save

