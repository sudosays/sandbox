# Julius Stopforth
# STPJUL004

def stringSplosion(s):
    astr = ""
    for i in range(0,len(s)):
        astr += s[:i+1]
    return astr
