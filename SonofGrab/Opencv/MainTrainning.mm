//
//  MainTrainning.m
//  SonOfGrab
//
//  Created by liuxiang on 2018/2/2.
//

#import "MainTrainning.h"


@implementation RecognizedResult
@end



#define DRAW_RESULT 1


#if DRAW_RESULT
#include <opencv2/highgui/highgui_c.h>
#endif

//
//using namespace cv;
//using namespace std;
//string testPic[] =
//{
//    "test1.jpg", "test2.jpg",  "test3.jpg",  "test4.jpg",
//    "test5.jpg", "test6.jpg",  "test7.jpg",  "test8.jpg",
//    "test9.jpg", "test10.jpg", "test11.png", "test12.png"
//};
//
//typedef enum
//{
//    SupportCharacter_0 = 0,
//    SupportCharacter_1,
//    SupportCharacter_2,
//    SupportCharacter_3,
//    SupportCharacter_4,
//    SupportCharacter_5,
//    SupportCharacter_6,
//    SupportCharacter_7,
//    SupportCharacter_8,
//    SupportCharacter_9,
//    SupportCharacter_Point,
//    SupportCharacter_RMB,
//
//    SupportCharacter_Count
//}SupportCharacter;
//int n_min = 80;       //识别数字轮廓长度的下限 单位（像素）
//int n_max = 1400;     //识别数字轮廓长度的上限
//// 数组成员之间的距离小于一个阀值视为一个数
//int n_width_n_min = 1, n_width_n_max = 100;
//
//CvRect moneyRect;//  = (CvRect){280, 260, 710, 130};
//CvRect remarkRect;// = (CvRect){310, 450, 710, 60};
//CvRect countRect;//  = (CvRect){450, 520, 120, 60};
//
//int thres = 140;      //二值化阀值
//int k_match_type = CV_CONTOURS_MATCH_I3;
//
@implementation MainTrainning
//
//
//#define SHOW_VERSOBE 1
//
//#if SHOW_VERSOBE
//#define SHOW_IMG(wn, img)                       \
//cvNamedWindow((wn), CV_WINDOW_AUTOSIZE);    \
//cvShowImage((wn), (img))
//#else
//#define SHOW_IMG(wn, img)
//#endif
//bool IsContourValid(int x, int y, int width, int height, CvRect outterRect)
//{
//    if (x >= outterRect.x &&
//        y >= outterRect.y &&
//        x + width <= outterRect.x + outterRect.width &&
//        y + height <= outterRect.y + outterRect.height)
//    {
//        return true;
//    }
//    return false;
//}
//bool IsContourValid(CvRect innerRect, CvRect outterRect)
//{
//    return IsContourValid(innerRect.x, innerRect.y, innerRect.width, innerRect.height, outterRect);
//}
//// 对比学习集合-储存白底黑子的数字图片
//string base_path = "/Users/liuxiang/Documents/opencv-workspace/opencvReadNu/";
//string picture[SupportCharacter_Count] =
//{
//    "0.jpg", "1.jpg", "2.jpg", "3.jpg", "4.jpg",
//    "5.png", "6.png", "7.png", "8.png", "9.png",
//    "point.png", "rmb.png"
//};
//CvSeq *pic[SupportCharacter_Count];  //储存数字图片轮廓
//CvSeq* GetImageContour(IplImage* srcIn, int flag = 0, string* imgName = NULL)
//{
//    CvSeq* seq = NULL;   //储存图片轮廓信息
//    int total = 1;          //轮廓总数
//    IplImage* src = srcIn;  //cvCreateImage(img_size, IPL_DEPTH_8U, 1);
//
//    //创建空间
//    CvMemStorage* mem = cvCreateMemStorage(0);
//    if(!mem)
//    {
//        printf("mem is NULL!");
//    }
//    // 2. 二值化
//    cvThreshold(src, src, thres, 255, CV_THRESH_BINARY_INV);
//    //SHOW_IMG("cvThreshold", src);
//
//    // 3. 计算图像轮廓  0-只获取最外部轮廓  1-获取全部轮廓
//    if(flag == 0)
//    {
//#if 0
//        // 1. 平滑处理
//        cvSmooth(src, src, CV_GAUSSIAN, 5, 0);
//
//        // 瘦化处理
//        //    cvThin(src, src, 5);
//
//        // 图像腐蚀
//        cvErode(src, src, NULL, 1);
//        SHOW_IMG("cvErode", src);
//
//        // 图像膨胀
//        IplConvKernel *iplele = cvCreateStructuringElementEx(3, 3, 0, 0, CV_SHAPE_RECT);
//        cvDilate(src, src, iplele, 1);
//        cvReleaseStructuringElement(&iplele);
//        SHOW_IMG((*imgName + "cvDilate").c_str(), src);
//#endif
//
//        total = cvFindContours(src, mem, &seq, sizeof(CvContour),
//                               CV_RETR_EXTERNAL,
//                               CV_CHAIN_APPROX_NONE,
//                               cvPoint(0,0));
//    }
//    else if(flag == 1)
//    {
//        total = cvFindContours(src, mem, &seq, sizeof(CvContour),
//                               CV_RETR_CCOMP,
//                               CV_CHAIN_APPROX_NONE,
//                               cvPoint(0,0));
//    }
//    //printf("total = %d\n", total);
//    //返回轮廓迭代器
//    return seq;
//}
////数字图片轮廓计算
//void Init(void)
//{
//    IplImage *src0;
//    for(int i = 0; i < SupportCharacter_Count; i++)
//    {
//        src0 = cvLoadImage((base_path + picture[i]).c_str(), CV_LOAD_IMAGE_GRAYSCALE);
//        if(!src0)
//        {
//            printf("Couldn't load %s\n", picture[i].c_str());
//            exit(1);
//        }
//        pic[i] = GetImageContour(src0, 0, &picture[i]);;
//        cvReleaseImage(&src0);
//    }
//}
//
//int ReadNumber(CvSeq* contoursTemp, double& matchedRate)
//{
//    int matchestIndex = -1;
//    double matchedValue = 1000000;
//
//    //CvRect rect = cvBoundingRect(contoursTemp, 1);
//    for(int i = 0; i < SupportCharacter_Count; i++)
//    {
//        double tmp = cvMatchShapes(contoursTemp, pic[i], k_match_type);
//        if(tmp < matchedValue)
//        {
//            matchedValue = tmp;
//            matchestIndex = i;
//        }
//
//        if (i == 5 && fabs(tmp - 2.62) <= 0.1)
//        {
//            matchestIndex = 5;
//            break;
//        }
//        if (i == 6 && fabs(tmp - 0.24) <= 0.01)
//        {
//            matchestIndex = 6;
//            break;
//        }
//        if (i == 8 && fabs(tmp - 0.21) <= 0.01)
//        {
//            matchestIndex = 8;
//            break;
//        }
//        if (i == 9 && fabs(tmp - 0.2108) <= 0.01)
//        {
//            matchestIndex = 9;
//            break;
//        }
//        //if (1)//rect.x == 558 && rect.y == 466)
//        //{
//        //    printf("'6' --  %i:%.4f\n", i, tmp);
//        //}
//    }
//    matchedRate = matchedValue;
//    return matchestIndex;
//}
//void GetResult(int numList[100][5], int count, double &money, char** remark, int& index)
//{
//    int moneyList[100]  = {0};
//    int remarkList[100] = {0};
//    int indexList[100]  = {0};
//    int moneyNumCount = 0, remarkNumCount = 0, indexNumCount = 0;
//    double moneyValue = 0.f;
//    int    indexValue = 0;
//    char   remarkValue[100]; memset(remarkValue, 0, 100);
//
//    for (int i = count - 1; i >= 0; i--)
//    {
//        if (numList[i][0] > 9 || numList[i][0] < 0)
//        {
//            printf("ERROR number:%i, index:%i\n", numList[i][0], i);
//        }
//
//        int lastX = 0;
//        // 笔数提取
//        if (IsContourValid(numList[i][1], numList[i][2], numList[i][3], numList[i][4], countRect))
//        {
//            if (lastX == 0 || numList[i][1] - lastX < 40)
//            {
//                indexList[indexNumCount] = numList[i][0];
//                indexNumCount++;
//            }
//            lastX = numList[i][1];
//        }
//        // 备注提取
//        else if (IsContourValid(numList[i][1], numList[i][2], numList[i][3], numList[i][4], remarkRect))
//        {
//            remarkList[remarkNumCount] = numList[i][0];
//            remarkNumCount++;
//        }
//        // 金额提取
//        else if (IsContourValid(numList[i][1], numList[i][2], numList[i][3], numList[i][4], moneyRect))
//        {
//
//            moneyList[moneyNumCount] = numList[i][0];
//            moneyNumCount++;
//        }
//        else
//        {
//            printf("\n\nERROR! Unhandle number!!\n\n");
//        }
//    }
//    // 组合笔数
//    for (int i = 0; i < indexNumCount; i++)
//    {
//        indexValue = indexValue * 10 + indexList[i];
//    }
//
//    int diff = '1' - 1;
//    // 组合备注
//    for (int i = 0; i < remarkNumCount; i++)
//    {
//        remarkValue[i] = diff + remarkList[i];
//    }
//
//    // 3. 组合金额
//    // 3.1 找出是否有小数点及小数点位置
//    int pointIndex = -1;
//    for (int i = 0; i < moneyNumCount; i++)
//    {
//        if (moneyList[i] == SupportCharacter_Point)
//        {
//            pointIndex = i;
//            break;
//        }
//    }
//    // 3.2 计算金额
//    for (int i = 0; i < moneyNumCount; i++)
//    {
//        // Find whether there was '.'
//        if (moneyList[i] != SupportCharacter_Point)
//        {
//            moneyValue = moneyValue * 10 + moneyList[i];
//        }
//    }
//    // 3.3 如果有小数点，假定为2位小数
//    if (pointIndex >= 0)
//    {
//        moneyValue *= 0.01f;
//    }
//
//    money = moneyValue;
//    *remark = remarkValue;
//    index = indexValue;
//    printf("\n--Result:\n--金额: %.2f\n--备注: %s\n--笔数: %i\n", moneyValue, remarkValue, indexValue);
//}
//
//int RecognizeImage(IplImage* src, double &money, char** remark, int& index)
//{
//
//    int count = 0;    //数字轮廓个数
//    int num   = -1;   //识别一幅图像中的一个数字
//    int numList[100][5];  //一幅图像中的数字序列  一维是数字，二维是数字所在坐标
//    CvPoint pt1, pt2;
//    CvRect ins;
//    bool shouldDraw = false;
//
//    CvSeq *contours = 0, *contoursTemp = 0;
//    contours = GetImageContour(src, 1);   //获取轮廓信息
//    contoursTemp = contours ;
//
//#if DRAW_RESULT
//    IplImage* imgColor      = cvCreateImage(cvGetSize(src), 8, 3);
//    IplImage* contoursImage = cvCreateImage(cvSize(src->width, src->height), 8, 1);
//    cvZero(contoursImage);
//#endif
//
//    //对轮廓进行循环
//    for(; contoursTemp != 0; contoursTemp = contoursTemp->h_next)
//    {
//        shouldDraw = false; num = -1;
//        CvRect rect = cvBoundingRect(contoursTemp, 1);  //根据序列，返回轮廓外围矩形
//
//        // 只处理金额/备注/笔数区域
//        if ((IsContourValid(rect, moneyRect) ||
//             IsContourValid(rect, remarkRect)||
//             IsContourValid(rect, countRect)))
//        {
//            printf("Matched: {%03i, %03i} {%02i, %02i}", rect.x, rect.y, rect.width, rect.height);
//            double matchedRate = 0;
//            // 数字 & ¥
//            if (((1.f * rect.width) / (1.f * rect.height)) < .76f &&
//                contoursTemp->total > n_min && contoursTemp->total < n_max)
//            {
//                //匹配该轮廓数字
//                num = ReadNumber(contoursTemp, matchedRate);
//                printf(" mr:%2.2lf", matchedRate);
//
//                //计算矩形顶点
//                pt1.x = rect.x;
//                pt1.y = rect.y;
//                pt2.x = rect.x + rect.width;
//                pt2.y = rect.y + rect.height;
//
//                if(num >= 0 && num <= 9)
//                {
//                    numList[count][0] = num;
//                    numList[count][1] = rect.x;
//                    numList[count][2] = rect.y;
//                    numList[count][3] = rect.width;
//                    numList[count][4] = rect.height;
//
//                    // 数字轮廓+1
//                    count++;
//                    printf(" num:%i ", num);
//                }
//                else if (num == SupportCharacter_RMB)
//                {
//                    // Ignore '¥'
//                    printf(" num:¥ ");
//                }
//                shouldDraw = true;
//            }
//            // 金额区域小数点 '.'
//            else if (abs(rect.width - rect.height) <= 1 &&
//                     abs(rect.width - 14) <= 2)
//            {
//                num = ReadNumber(contoursTemp, matchedRate);
//                if (num == SupportCharacter_Point)
//                {
//                    numList[count][0] = num;
//                    numList[count][1] = rect.x;
//                    numList[count][2] = rect.y;
//                    numList[count][3] = rect.width;
//                    numList[count][4] = rect.height;
//
//                    count++;
//                    printf(" mr:%2.2lf, '.'", matchedRate);
//                }
//                shouldDraw = true;
//            }
//            printf("\n");
//        }
//
//#if DRAW_RESULT
//        // 2. 绘制
//        if (shouldDraw)
//        {
//            // 2.1 在原图上绘制轮廓外矩形
//            cvRectangle(imgColor, pt1, pt2, CV_RGB(0,255,0), 2);
//            // 2.2 提取外轮廓上的所有坐标点
//            for(int i = 0; i < contoursTemp->total; i++)
//            {
//                CvPoint *pt = (CvPoint*)cvGetSeqElem(contoursTemp, i); // 读出第i个点。
//                cvSetReal2D(contoursImage , pt->y , pt->x , 255.0);
//                cvSet2D(imgColor, pt->y, pt->x, cvScalar(0,0,255,0));
//            }
//        }
//#endif
//    }
//
//    GetResult(numList, count, money, remark, index);
//
//#if DRAW_RESULT
//    cvNamedWindow("image", 1);
//    cvShowImage("image", imgColor);
//
//    cvNamedWindow("contours");
//    cvShowImage("contours", contoursImage);
//#endif
//    return 0;
//}
- (int)recognize:(char *)path money:(int *)money remaork:(char **)remark index:(int)index
//int RecognizeImage(char *path, double &money, char** remark, int& index)
{
    IplImage* img = cvLoadImage(path, CV_LOAD_IMAGE_GRAYSCALE);
    
//    RecognizeImage(img, *money, remark, index);
    return 0;
}


@end
