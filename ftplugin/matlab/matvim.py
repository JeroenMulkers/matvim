import matlab.engine
import vim
import StringIO
from os import remove

engine = None

def startMatlab():
    global engine
    if engine: quitMatlab()
    engine = matlab.engine.start_matlab()

def connectMatlab(sessionID):
    global engine
    if engine: quitMatlab()
    engine = matlab.engine.connect_matlab(sessionID)

def findMatlab():
    runningEnginesList = list(matlab.engine.find_matlab())
    vim.command("return %s"%runningEnginesList)

def quitMatlab():
    global engine
    if type(engine)== matlab.engine.matlabengine.MatlabEngine:
        engine.quit()
    engine = None

def execute(lines):
    if type(engine)!=matlab.engine.matlabengine.MatlabEngine:
        print "I do not find a matlab engine"
        return
    fscript = 'tmpscriptAZWKL.m'
    with open(fscript,'w') as script:
        for line in lines:
            script.write(line+'\n')
    result = StringIO.StringIO()
    engine.tmpscriptAZWKL(nargout=0,stdout=result,stderr=result)
    remove(fscript)
    print result.getvalue()

def runLine():
    row,_ = vim.current.window.cursor
    lines = [vim.current.buffer[row-1]]
    execute(lines)

def runFile():
    lines = vim.current.buffer
    execute(lines)

def runSelection():
    row1,_ = vim.current.buffer.mark('<')
    row2,_ = vim.current.buffer.mark('>')
    lines = vim.current.buffer[row1-1:row2]
    execute(lines)

def runSection():
    row,_ = vim.current.window.cursor
    lengthbuffer = len(vim.current.buffer)
    for rowfirst in range(row,0,-1):
        if vim.current.buffer[rowfirst-1][0:2] == '%%':
            break
    rowlast = lengthbuffer
    for rowlast in range(row+1,len(vim.current.buffer)+1):
        if vim.current.buffer[rowlast-1][0:2] == '%%':
            rowlast-=1 # do not include next section line
            break
    lines = vim.current.buffer[rowfirst-1:rowlast]
    execute(lines)

def showVariable():
    varName = vim.eval('expand("<cword>")')
    lines = ["disp(%s)"%varName]
    execute(lines)
