"""Convert image to RGB(565)"""
from PIL import Image

def resize(file_id, resolution):
    "resize image to 256x144"
    img = Image.open(file_id)
    img = img.resize(resolution, Image.ANTIALIAS)
    dot = file_id.find(".")
    ext = file_id[dot+1:]
    img.save(file_id[:-dot] + "_resized." + ext, ext)
    return img

def convert(img):
    "convert to rgb"
    rgb_img = img.convert('RGB')
    rgb = list(rgb_img.getdata())
    return rgb

def tohex(rgb888):
    "convert rgb888 to rgb565 colormap"
    rgb565 = []
    for i, value in enumerate(rgb888):
        rgb565.insert(i, ((int(value[0] * 31 / 255) << 11) |
                          (int(value[1] * 63 / 255) << 5) |
                          (int(value[2] * 31 / 255))))
    return rgb565

def save_to_file(img_hex, file_id):
    "print list to file"
    dot = file_id.find(".")
    fid = open((file_id[:-dot]+".h"), 'w')
    fid.write("unsigned int image[] = \n{\n")
    for i, value in enumerate(img_hex):
        fid.write("0x")
        fid.write(format(value, '04X'))
        fid.write(",")
        if i%10 == 9:
            fid.write("\n")
    fid.write("0x0000")
    fid.write(" };")


#TEST PROGRAM

FID = "test.png"
RES = (256, 144)
RES0 = resize(FID, RES)
RES1 = convert(RES0)
RES2 = tohex(RES1)
save_to_file(RES2, FID)
