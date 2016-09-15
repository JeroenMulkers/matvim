import matlab.engine
import vim
import StringIO
from os import remove

engine = None

def startMatlab():
    global engine
    if engine: quitMatlab()
    engine = matlab.engine.start_matlab()

def connectMatlab(sessionID=None):
    global engine
    if engine: quitMatlab()
    runningEngines = list(matlab.engine.find_matlab())
    if not sessionID:
        if runningEngines:
            engine = matlab.engine.connect_matlab(runningEngines[0])
        else:
            print "No active Matlab engines found"
    if sessionID:
        if sessionID not in runningEngines:
            print "No matlab engine named %s is active"%sessionID
        else:
            engine = matlab.engine.connect_matlab(sessionID)

def connectOrStartMatlab():
    runningEngines = list(matlab.engine.find_matlab())
    if runningEngines:
        engine = matlab.engine.connect_matlab(runningEngines[0])
    else:
        engine = matlab.engine.start_matlab()

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
    oldworkingdir = engine.pwd()
    workingdir = vim.eval("expand('%:p:h')")
    fscript = workingdir+'/tmpscriptAZWKL.m'
    with open(fscript,'w') as script:
        for line in lines:
            script.write(line+'\n')
    result = StringIO.StringIO()
    engine.cd(workingdir,nargout=0)
    try:
        engine.tmpscriptAZWKL(nargout=0,stdout=result,stderr=result)
    except matlab.engine.MatlabExecutionError:
        pass
    engine.cd(oldworkingdir,nargout=0)
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

def runCommand(commandstr):
    execute([commandstr])

def showVariable():
    varName = vim.eval('expand("<cword>")')
    lines = ["disp(%s)"%varName]
    execute(lines)
