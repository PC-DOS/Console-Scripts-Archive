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
    sInputDirectory = UniformPathString("G:/StableDiffusion/LoRA/LancetDois/TrainData/", True)
    sOutputDirectory = UniformPathString("G:/StableDiffusion/LoRA/LancetDois/TrainDataPreparedDetailedTagging/", True)

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
            TagFile.write("Lancet Dois,")
            #TagFile.write("Pony,")
            #TagFile.write("Pegasus,")
            #TagFile.write("Blue hair,")
            #TagFile.write("Single colored hair,")
            #TagFile.write("Blue tail,")
            #TagFile.write("Light white cyan body color,")
            #TagFile.write("Full body,")
            #TagFile.write("Stallion,")
            #TagFile.write("Femboy,")
            TagFile.write("Simple background,")

            # Tagging by filename
            if IsSubStringInString(str(PicFile), "By手中玺_兰斯_") :
                TagFile.write("Standing,")
                TagFile.write("Rear view,")
                TagFile.write("Full body,")
            #End If
            if IsSubStringInString(str(PicFile), "By手中玺_兰斯2_") :
                TagFile.write("Side view,")
                TagFile.write("Full body,")
            #End If
            if IsSubStringInString(str(PicFile), "全身") :
                TagFile.write("Full body,")
            #End If
            if IsSubStringInString(str(PicFile), "头像") :
                TagFile.write("Avatar,")
                TagFile.write("Portrait,")
            #End If
            if IsSubStringInString(str(PicFile), "仅白大褂_") :
                TagFile.write("Labcoat,")
            #End If
            if IsSubStringInString(str(PicFile), "乳胶黑色服袜_") :
                TagFile.write("Labcoat,")
                TagFile.write("Latex,")
                TagFile.write("Latex socks,")
                TagFile.write("Latex stockings,")
            #End If
            if IsSubStringInString(str(PicFile), "乳胶黑色裤_") :
                TagFile.write("Latex,")
                TagFile.write("Latex panties,")
                TagFile.write("Latex underwear,")
            #End If
            if IsSubStringInString(str(PicFile), "乳胶黑色裤袜_") :
                TagFile.write("Latex,")
                TagFile.write("Latex panties,")
                TagFile.write("Latex underwear,")
                TagFile.write("Latex socks,")
                TagFile.write("Latex stockings,")
            #End If
            if IsSubStringInString(str(PicFile), "蓝白条服袜_") :
                TagFile.write("Labcoat,")
                TagFile.write("Blue and white striped socks,")
                TagFile.write("Blue and white striped stockings,")
            #End If
            if IsSubStringInString(str(PicFile), "蓝白条裤_") :
                TagFile.write("Blue and white striped bikini,")
                TagFile.write("Blue and white striped panties,")
                TagFile.write("Blue and white striped underwear,")
            #End If
            if IsSubStringInString(str(PicFile), "蓝白条裤袜_") :
                TagFile.write("Blue and white striped socks,")
                TagFile.write("Blue and white striped stockings,")
                TagFile.write("Blue and white striped bikini,")
                TagFile.write("Blue and white striped panties,")
                TagFile.write("Blue and white striped underwear,")
            #End If
            if IsSubStringInString(str(PicFile), "正常表情") :
                TagFile.write("Open eyes,")
            #End If
            if IsSubStringInString(str(PicFile), "痛苦表情") :
                TagFile.write("Closed eyes,")
                TagFile.write("Painful look,")
            #End If
            if IsSubStringInString(str(PicFile), "红晕") :
                TagFile.write("Blushing,")
            #End If
            if IsSubStringInString(str(PicFile), "眼泪") :
                TagFile.write("Teardrop,")
            #End If
            if IsSubStringInString(str(PicFile), "流汗") :
                TagFile.write("Sweating,")
            #End If
            if IsSubStringInString(str(PicFile), "喘气") :
                TagFile.write("Breathing,")
                TagFile.write("Huffing,")
            #End If
            if IsSubStringInString(str(PicFile), "抖动") :
                TagFile.write("Trembling,")
                TagFile.write("Shivering,")
            #End If
            if IsSubStringInString(str(PicFile), "SM") :
                TagFile.write("Ballgag,")
                TagFile.write("Egg vibrator,")
                TagFile.write("Vibrator in panties,")
                TagFile.write("BDSM,")
            #End If
            if IsSubStringInString(str(PicFile), "+") :
                TagFile.write("Wet panties,")
            #End If
            if IsSubStringInString(str(PicFile), "触手") :
                TagFile.write("Tentacles,")
                TagFile.write("Tentacle porn,")
                TagFile.write("Tentacle sex,")
                TagFile.write("Tentacle blowjob,")
                TagFile.write("Tentacle on male,")
                TagFile.write("Cumming in mouth,")
                TagFile.write("Wet panties,")
            #End If
        #End With

        iCurrentID = iCurrentID + 1
    #Next
#End If