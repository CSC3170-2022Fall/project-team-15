from django.shortcuts import render
import pymysql
from django.http import HttpResponse
import json
from django.views.decorators.csrf import csrf_exempt
import time
from mainbody.models import *

from wsgiref.util import FileWrapper
from django.http import StreamingHttpResponse
import mimetypes
import os
import re

# Create your views here.
def index(request):
    return render(request, 'index.html')
def login(request):
    return render(request,'login.html')
def finish(request):
    return render(request,'fannish.html')



#返回内容库页面
def content_storage(request):
    return render(request,'content_storage.html')

#返回内容库数据库
def get_content_media(request):
    myDict = {'data': []}
    conn=pymysql.connect(host='localhost',
                     user='root',
                     password='ChenzroyI.*?',
                     database='test')
    cursor=conn.cursor()
    sql="select * from mainbody_content_media order by create_time DESC"
    cursor.execute(sql)
    result=cursor.fetchall()
    html=''
    for each in result:
        html=html+"<tr>" \
             "<th>{}</th>" \
             "<td>{}</td>" \
             "<td>{}</td>" \
             "<td>{}</td>" \
             "<td><i class=\"fas fa-check-circle\" style=\"color:lawngreen;\"></i></td>" \
             "<td><a href=\"/check_video?id={}\">查看详情</a></td></tr>".format(each[0],each[1],each[2],each[3],each[0])
    myDict['data']=html
    return HttpResponse(json.dumps(myDict), content_type='application/json')


def ai_cut(request):
    return render(request, 'ai_cut.html')

@csrf_exempt
def ai_cut_taskCreate(request):
    try:
        if request.method == 'POST':
            task_name = request.POST.get("task_name")
            choose_pack = request.POST.get("choose_pack")
            create_time=time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
            task=task_stream()
            task.create_time=create_time
            task.name=task_name
            task.pack=choose_pack
            task.save()
            return HttpResponse(json.dumps({"data": "成功"}), content_type='application/json')
    except:
        return HttpResponse(json.dumps({"data": "失败"}), content_type='application/json')

def check_video(request):
    if(request.method=='GET'):
        video_id=int(request.GET['id'])
        video_info=content_media.objects.filter(id__exact=video_id)
        video_name=video_info[0].name
        video_size=video_info[0].size
        video_dur=video_info[0].duration
        video_ctime=video_info[0].create_time
        video_path="/stream_video/?video_path=content_media\\origin\\aizou0629_"+video_name
        data={
            'video_name':video_name,
            'video_size':video_size,
            'video_dur':video_dur,
            'video_ctime':video_ctime,
            'video_path':video_path
        }
    return render(request, 'check_video.html',data)

def file_iterator(file_name, chunk_size=8192, offset=0, length=None):
    with open(file_name, "rb") as f:
        f.seek(offset, os.SEEK_SET)
        remaining = length
        while True:
            bytes_length = chunk_size if remaining is None else min(remaining, chunk_size)
            data = f.read(bytes_length)
            if not data:
                break
            if remaining:
                remaining -= len(data)
            yield data
def stream_video(request):
    path=request.GET['video_path']
    range_header = request.META.get('HTTP_RANGE', '').strip()
    range_re = re.compile(r'bytes\s*=\s*(\d+)\s*-\s*(\d*)', re.I)
    range_match = range_re.match(range_header)
    size = os.path.getsize(path)
    content_type, encoding = mimetypes.guess_type(path)
    content_type = content_type or 'application/octet-stream'
    if range_match:
        first_byte, last_byte = range_match.groups()
        if first_byte:
            first_byte = int(first_byte)
        else:
             first_byte = 0
        last_byte = first_byte + 1024 * 1024 * 8 # 8M per piece, the maximum volume of the response body
        if last_byte > size:
            last_byte = size - 1
        length = last_byte - first_byte + 1
        resp = StreamingHttpResponse(file_iterator(path, offset=first_byte, length=length), status=206, content_type=content_type)
        resp['Content-Length'] = str(length)
        resp['Content-Range'] = 'bytes %s-%s/%s' % (first_byte, last_byte, size)
    else:
        resp = StreamingHttpResponse(FileWrapper(open(path, 'rb')), content_type=content_type)
        resp['Content-Length'] = str(size)
    resp['Accept-Ranges'] = 'bytes'
    return resp

def get_ai_cut_taskflow_list(request):
    myDict = {'data': []}
    conn = pymysql.connect(host='localhost',
                           user='root',
                           password='ChenzroyI.*?',
                           database='test')
    cursor = conn.cursor()
    sql = "select * from mainbody_task_stream order by create_time DESC"
    cursor.execute(sql)
    result = cursor.fetchall()
    html = ''
    for each in result:
        html = html + "<tr>" \
                      "<th>{}</th>" \
                      "<td>{}</td>" \
                      "<td>{}</td>" \
                      "<td>{}</td>" \
                      "<td><i class=\"fas fa-check-circle\" style=\"color:lawngreen;\"></i></td>" \
                      "<td><a href=\"#\">查看详情</a></td></tr>".format(each[0], each[1], each[2], each[3])
    myDict['data'] = html
    return HttpResponse(json.dumps(myDict), content_type='application/json')