import os

__CSL = None
def symlink(source, link_name):
    '''symlink(source, link_name)
       Creates a symbolic link pointing to source named link_name'''
    global __CSL
    if __CSL is None:
        import ctypes
        csl = ctypes.windll.kernel32.CreateSymbolicLinkW
        csl.argtypes = (ctypes.c_wchar_p, ctypes.c_wchar_p, ctypes.c_uint32)
        csl.restype = ctypes.c_ubyte
        __CSL = csl
    flags = 0
    if source is not None and os.path.isdir(source):
        flags = 1
    if __CSL(link_name, source, flags) == 0:
        raise ctypes.WinError()

os.symlink = symlink

dst = 'D:/Cloud/OneDrive/Programming/Projects/web_development/ExtendVoyager/packages/SD/voyager/publishable/assets'
src = 'D:/Cloud/OneDrive/Programming/Projects/web_development/ExtendVoyager/public/vendor/tcg/voyager/assets'
os.symlink(src, dst)
