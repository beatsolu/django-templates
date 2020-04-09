import json
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

with open(os.path.join(BASE_DIR, 'package.json')) as f:
    package = json.load(f)

__version__ = package['version']
