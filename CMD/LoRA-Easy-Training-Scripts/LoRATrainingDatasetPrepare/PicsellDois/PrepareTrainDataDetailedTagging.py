# Public libraries
import os
import sys
import array
import math
import datetime
import itertools
import glob
import shutil

# PIL
from PIL import Image

# Check if a given substring is present in another string
def IsSubStringInString(sParentString : str, sSubString : str) -> bool :
    return (str(sParentString).find(sSubString) != -1)
#End Function

# Uniforming path strings
def UniformPathString(sPathString : str, IsPathToDirectory : bool = False) -> str :
    # Replace backslashes ("\") with slashes ("/") for compatibility with UNIX-like systems
    sUniformedPath = sPathString.replace("\\", "/")

    # add a slash if it's path to a directory
    if IsPathToDirectory :
        if not sUniformedPath.endswith("/") :
            sUniformedPath = sUniformedPath + "/"
        #End If
    #End If

    return sUniformedPath
#End Function

# Enumerate files and directories under specified directory
def EnumerateFilesAndDirectories(sEnumerateTerm : str, sRootPath : str = None, DoRecursiveEnumerate : bool = False, IncludeHiddenItems : bool = False) -> list :
    return glob.glob(sEnumerateTerm, root_dir=sRootPath, recursive=DoRecursiveEnumerate, include_hidden=IncludeHiddenItems)
#End Function

# Get current script's working directory
# Ref. https://blog.csdn.net/nixiang_888/article/details/109174340
def GetCurrentScriptWorkingDir(sTarget : str = "") -> str :
    sTarget = sTarget.upper()

    if sTarget == "CMDLINE" :
        sPath = os.getcwd()
        return UniformPathString(sPathString=sPath, IsPathToDirectory=True)
    elif sTarget == "ROOTSCRIPT" :
        sPath = sys.path[0]
        return UniformPathString(sPathString=sPath, IsPathToDirectory=True)
    elif sTarget == "THISSCRIPT" :
        sPath = os.path.split(os.path.realpath(__file__))[0]
        return UniformPathString(sPathString=sPath, IsPathToDirectory=True)
    else :
        sPath = os.getcwd()
        return UniformPathString(sPathString=sPath, IsPathToDirectory=True)
    #End If
#End Function

# Check existence of file or directory
def IsFileOrDirectoryExists(sPath : str) :
    return os.path.exists(sPath)
#End Function

# Create nested directories
def CreateDirectory(sPath : str) :
    if not IsFileOrDirectoryExists(sPath) :
        os.makedirs(sPath, exist_ok=True)
    #End If
#End Sub

# Remove extension name from path
def RemoveExtensionNameFromPath(sPath : str) -> str :
    return os.path.splitext(sPath)[0]
#End If

# Uniform image to square
def UniformImageToSquare(sSourceFile : str, sOutputFile : str = None, 
    iUniformedImageSize : int = 512, IsSimpleStretchingUsed : bool = False) -> Image.Image :

    # Opening file
    imgSrc = Image.open(sSourceFile)
    iSourceWidth = imgSrc.width
    iSourceHeight = imgSrc.height
    iSourceMaxScale = max(iSourceWidth, iSourceHeight)

    # Uniforming image
    if IsSimpleStretchingUsed :
        imgOpt = imgSrc.resize((iUniformedImageSize,iUniformedImageSize), Image.Resampling.BICUBIC)
    else :
        imgOpt = Image.new("RGBA", (iSourceMaxScale,iSourceMaxScale))
        tplPastePos = (int((iSourceMaxScale - iSourceWidth) / 2), int((iSourceMaxScale - iSourceHeight) / 2))
        imgOpt.paste(imgSrc, tplPastePos)
        imgOpt = imgOpt.resize((iUniformedImageSize,iUniformedImageSize), Image.Resampling.BICUBIC)
    #End If

    # Saving uniformed image
    if not (sOutputFile is None) :
        imgOpt.save(sOutputFile)
    #End If

    return imgOpt
#End Function

# Main entry point
if __name__ == "__main__" : 
    sInputDirectory = UniformPathString("G:/StableDiffusion/LoRA/PicsellDois/TrainData/", True)
    sOutputDirectory = UniformPathString("G:/StableDiffusion/LoRA/PicsellDois/TrainDataPreparedDetailedTagging/", True)

    if not IsFileOrDirectoryExists(sOutputDirectory) :
        CreateDirectory(sOutputDirectory)
    #End If

    iCurrentID = 0

    for PicFile in EnumerateFilesAndDirectories("*.png", sInputDirectory) :
        sFileFullPath = sInputDirectory + PicFile
        sIndexedFileName = format(iCurrentID, "0>5")
        sFileOutputPath = sOutputDirectory + sIndexedFileName + ".png"
        print(sFileFullPath + " -> " + sFileOutputPath)

        #shutil.copy(sFileFullPath, sFileOutputPath)
        UniformImageToSquare(sFileFullPath, sFileOutputPath, 512, False)

        sTagFilePath = sOutputDirectory + sIndexedFileName + ".txt"
        with open(sTagFilePath, "w") as TagFile :
            # Public tags
            TagFile.write("Picsell Dois,")
            #TagFile.write("Pony,")
            #TagFile.write("Pegasus,")
            #TagFile.write("Purple hair,")
            #TagFile.write("Single colored hair,")
            #TagFile.write("Teal tail,")
            #TagFile.write("Blue eyes,")
            #TagFile.write("Light white cyan body color,")
            TagFile.write("Round glasses,")
            TagFile.write("Simple background,")

            if IsSubStringInString(PicFile, "半身") :
                TagFile.write("Half body,")
            elif IsSubStringInString(PicFile, "头像") :
                TagFile.write("Avatar,")
                TagFile.write("Portrait,")
            else :
                TagFile.write("Standing,")
                TagFile.write("Fullbody,")
            #End If
            
            if IsSubStringInString(PicFile, "毕业照_") :
                TagFile.write("Bachelor degree academic costume,")
            elif IsSubStringInString(PicFile, "毕业照（2024硕士版）_") :
                TagFile.write("Master degree academic costume,")
            else :
                TagFile.write("Labcoat,")
            #End If

        iCurrentID = iCurrentID + 1
    #End If
#End If