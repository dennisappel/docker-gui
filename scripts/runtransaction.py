#!/usr/bin/env python3

import sys
import json
import subprocess


class _CMD:
    TRANS = 'xdotool key "ctrl+t"'
    BACK = 'xdotool key "F3"'
    RUN = 'xdotool key "F8"'
    TAB = 'xdotool key "Tab"'
    GROUPTAB = 'xdotool key "shift+Tab"'
    RETURN = 'xdotool key "Return"'
    SPACE = 'xdotool key "space"'
    PROGNAV = 'xdotool key "shift+F5"'
    MENU = 'xdotool key "F10"'
    UP = 'xdotool key "Up"'
    RIGHT = 'xdotool key "Right"'
    DOWN = 'xdotool key "Down"'
    LEFT = 'xdotool key "Left"'
    CLIPBOARD = 'xclip -selection clipboard -o'

    def sleep(self, time):
        return 'sleep "{}"'.format(time)

    def type(self, text):
        return 'xdotool type --delay 100 "{}"'.format(text)


CMD = _CMD()


class Command:
    _commands = []

    def add(self, command, sleep=CMD.sleep(5), delay=None, reps=1):
        for i in range(reps):
            self._commands.append(command)
            if delay:
                self._commands.append(delay)

        if sleep:
            self._commands.append(sleep)

    def sleep(self, time=5):
        self._commands.append(CMD.sleep(time))

    def parse(self):
        return '; '.join(self._commands)


commands = Command()


def create_entrypoint():
    commands.add(CMD.TRANS, sleep=CMD.sleep(1))
    commands.add(CMD.type(data['transaction']), sleep=CMD.sleep('0.50s'))
    commands.add(CMD.RETURN, sleep=CMD.sleep(10))
    commands.add(CMD.PROGNAV)
    commands.add(CMD.type(data['program']), sleep=CMD.sleep('0.50s'))
    commands.add(CMD.RETURN)
    commands.add(CMD.RUN)


def create_save_sequence():
    commands.add(CMD.MENU, sleep=CMD.sleep(1))
    commands.add(CMD.DOWN, delay=CMD.sleep('0.10s'),
                 reps=2, sleep=CMD.sleep('0.10s'))
    commands.add(CMD.RIGHT, sleep=CMD.sleep('0.10s'))
    commands.add(CMD.DOWN, sleep=CMD.sleep('0.10s'))
    commands.add(CMD.RETURN)
    commands.add(CMD.DOWN, delay=CMD.sleep('0.10s'),
                 reps=4, sleep=CMD.sleep('0.10s'))
    commands.add(CMD.RETURN, sleep=CMD.sleep(1))
    commands.add(CMD.CLIPBOARD)
    commands.add(CMD.BACK, delay=CMD.sleep(3), reps=2, sleep=None)


def input_key(input):
    key = input['input']
    key = key.upper()
    _reps = input['reps']
    _delay = None

    if _reps > 1:
        _delay = '0.50s'

    cmd = getattr(CMD, key)
    commands.add(cmd, reps=_reps, delay=_delay, sleep=CMD.sleep(1))


def input_select(input):
    key = input['input']
    key = key.upper()
    _reps = input['option']
    if _reps > 0:
        _reps = _reps - 1
    cmd = getattr(CMD, key)
    commands.add(cmd, sleep=CMD.sleep(1), delay=CMD.sleep('0.50s'), reps=_reps)
    commands.add(CMD.TAB, sleep=CMD.sleep(1))


def input_text(input):
    text = input['input']
    commands.add(CMD.type(text), sleep=CMD.sleep(1))
    commands.add(CMD.RETURN, sleep=CMD.sleep(1))
    commands.add(CMD.DOWN, sleep=CMD.sleep(1))


def parse_input(input):
    if input['type'] == 'key':
        input_key(input)
    elif input['type'] == 'select':
        input_select(input)
    elif input['type'] == 'text':
        input_text(input)
    else:
        sys.exit(1)


def create_inputs():
    if len(data['inputs']) == 0:
        pass
    for sequence in data['inputs']:
        for input in sequence:
            parse_input(input)
        commands.add(CMD.RUN)


def run_transaction(bash):
    print('Starting transaction...')
    return subprocess.check_output(bash, shell=True)


def parse_data():
    create_entrypoint()
    create_inputs()
    create_save_sequence()
    bash = commands.parse()
    return run_transaction(bash)


with open('transaction.json') as json_file:
    data = json.load(json_file)
    result = parse_data()
    result = str(result, 'utf-8')

with open('result.json', 'w') as result_file:
    print('Transaction complete, writing results...')
    data['result'] = result
    json.dump(data, result_file)
