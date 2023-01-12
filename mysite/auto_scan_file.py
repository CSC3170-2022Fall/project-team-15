import os
import pymysql
import time
import copy
import os
import cv2


def scan_files(directory):
    files_list = []

    for root, sub_dirs, files in os.walk(directory):
        for special_file in files:
            tmp = []
            if (special_file.split('_')[0] != 'aizou0629'):

                #判断文件完全写入才进行后续操作
                if (isFinished(os.path.join(root, special_file))):

                    #判断文件是否出现重名
                    if ('aizou0629_' + special_file in files):
                        tmpname = copy.deepcopy(special_file)
                        flag=1
                        while 1:
                            if('aizou0629_' +special_file.replace('.', '('+str(flag)+').') not in files):
                                special_file=special_file.replace('.', '('+str(flag)+').')
                                os.rename(os.path.join(root, tmpname), os.path.join(root, special_file))
                                break
                            else:
                                flag+=1

                    #开始搜集需入库的文件列表
                    tmp.append(special_file)
                    tmp.append(cal_size(os.path.join(root, special_file)))
                    timearray = time.localtime(os.path.getctime(os.path.join(root, special_file)))
                    tmp.append(time.strftime("%Y-%m-%d %H:%M:%S", timearray))
                    tmp.append(getMediaInfo(os.path.join(root, special_file)))
                    files_list.append(tmp)

    if (len(files_list) == 0):
        return 0

    conn = pymysql.connect(host='localhost',
                           user='root',
                           password='ChenzroyI.*?',
                           database='test')
    cursor = conn.cursor()
    for each in files_list:
        path = str(os.path.join(root, 'aizou0629_' + each[0]))
        NewPath = ""
        for each_1 in path.split("\\"):
            NewPath += each_1 + "\\\\"
        NewPath = NewPath[:len(NewPath) - 2]
        sql="insert into myapp_content_media (create_time,name,size,path,duration) values ('{}','{}','{}','{}','{}')".format(each[2],each[0],each[1],NewPath,each[3])
        cursor.execute(sql)
        file_rename(root, each[0])
    conn.commit()
    cursor.close()
    conn.close()
    return files_list


# 修改文件大小格式，使其更符合阅读习惯
def cal_size(path):
    flag = 1
    unit_dict = {1: 'B', 2: 'KB', 3: 'MB', 4: 'GB', 5: 'TB'}
    size = os.path.getsize(path)
    while 1:
        if (size > 1024):
            size = size / 1024
            flag += 1
        else:
            return str(round(size, 2)) + unit_dict[flag]


# 判断外来文件是否已完全拷贝到存储中
def isFinished(path):
    tmp = []
    while 1:
        size = os.path.getsize(path)
        if (size in tmp):
            tmp.append(size)
        else:
            del tmp
            tmp = [size]
        if (len(tmp) == 3):
            return True
        time.sleep(10)


def file_rename(root, filename):
    filename_new = 'aizou0629_' + filename
    os.rename(os.path.join(root, filename), os.path.join(root, filename_new))

#获取视频的时长
def getMediaInfo(path):
    cap = cv2.VideoCapture(path)  #打开视频文件
    n_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))  #视频的帧数
    fps = cap.get(cv2.CAP_PROP_FPS)  #视频的帧率
    media_f = int(n_frames % fps)  #视频时长的帧部分
    media_s = int(n_frames // fps % 60) #视频时长的秒部分
    media_m = int(n_frames // fps // 60 % 60) #视频时长的分钟部分
    media_h = int(n_frames // fps // 60 // 60) #视频时长的小时部分

    def int2str(media_x):
        media_x=str(media_x)
        if(len(media_x)==1):
            return '0'+media_x
        else:
            return media_x

    media_f=int2str(media_f)
    media_s=int2str(media_s)
    media_m=int2str(media_m)
    media_h=int2str(media_h)

    return media_h+':'+media_m+':'+media_s+':'+media_f


if __name__ == "__main__":
    path = r'D:\PythonWorkspace\MyFirstDjango\mysite\content_media\origin'
    while 1:
        scan_files(path)

        time.sleep(5)