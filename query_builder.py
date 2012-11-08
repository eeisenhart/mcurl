#! /usr/bin/env python

import sys
import datetime
import time
import os
import re
from ConfigParser import ConfigParser

# ***********************************
# Runtime Variables
# ***********************************

PARENT_DIR = os.path.dirname(os.path.realpath(__file__))
QUERY_DIR = os.path.join(PARENT_DIR, "templates")

if len(sys.argv) <= 1:
  INI = "site_variables.ini"
elif len(sys.argv) <= 2: 
  INI = sys.argv[1] 
else:
  print "Please enter only one argument, a settings file."
  sys.exit(1)

# ***********************************
# INI Settings Import
# ***********************************

CONFIG_FILE = os.path.join(PARENT_DIR, INI)

config = ConfigParser()
config.read(CONFIG_FILE)

VERSION = config.get('settings', 'VERSION')
OUTPUT_DIR = config.get('settings', 'OUTPUT_DIR')
TIME_STAMP = datetime.datetime.now().strftime('%Y-%m-%d_%Hh%Mm%Ss')
OUTPUT_DIR = os.path.join(PARENT_DIR, OUTPUT_DIR + '_' + TIME_STAMP)

print "Writing Queries to: " + OUTPUT_DIR

os.mkdir(OUTPUT_DIR)

if VERSION == 'moodle1':
  QUERY_DIR = os.path.join(QUERY_DIR, 'moodle1')
else: 
  QUERY_DIR = os.path.join(QUERY_DIR, 'moodle2')


tokens = dict(config.items('site_variables'))

def find_replace(f):
  template = open(f, 'r')
  output = []
  for line in template:
    for token in tokens.keys():
      value = tokens[token]
      line = line.replace(token.upper(), value)
    output.append(line)
  template.close()
  return output

def write_query(f, query):
  o = open(os.path.join(OUTPUT_DIR, f), 'w')
  for l in query: 
    o.write(l)

#MAIN 
  
for root,dirs,files in os.walk(QUERY_DIR):
  for f in files:
    q = find_replace(os.path.join(root, f))
    write_query(f, q)

 
