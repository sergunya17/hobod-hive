#!/usr/bin/env python3

import sys

prev_userInn = ''
prev_kktRegId = ''
opened = False
lawbreaker = False

for line in sys.stdin:
    line = line.strip()
    (userInn, kktRegId, time, subtype) = line.split('\t')

    if userInn != prev_userInn:
        lawbreaker = False
        opened = False
        prev_userInn = userInn

    if kktRegId != prev_kktRegId:
        opened = False
        prev_kktRegId = kktRegId

    if subtype == 'openShift':
        opened = True

    if subtype == 'closeShift':
        opened = False

    if subtype == 'receipt' and not opened and not lawbreaker:
        lawbreaker = True
        sys.stdout.write(userInn + '\n')

