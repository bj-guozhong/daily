package com.gz.portal.video.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;

public class VideoInfoServices {
    /**
     * 根据JSON数据解析返回一个List<HashMap<String, Object>>集合
     * @param JSON格式视频数据
     * @return ArrayList 类型的视频信息
     * @author gz 20201210
     */
    public static List<HashMap<String, Object>> getJsonList(String json) {
        List<HashMap<String, Object>> dataList;
        dataList = (List<HashMap<String, Object>>)new ArrayList<HashMap<String, Object>>();
        try {
        	//所接收的字符串解析成json对象进行操作
        	JSONObject rootObject = JSONObject.parseObject(json);
        	//将cardgroups节点数据转换为数组
        	JSONArray cardgroup = (JSONArray)rootObject.get("cardgroups");
            Iterator<Object> iterator = cardgroup.iterator();
            HashMap<String, Object> map = new HashMap<String, Object>();
            String videoSrc = "";//视频Url地址
            String desc = "";//视频说明
            while(iterator.hasNext()){
            	JSONObject groupObj = (JSONObject)iterator.next();
            	//cardgroups数组中包含card数组
            	JSONArray cardArray = (JSONArray)groupObj.get("cards");
            	Iterator<Object> it = cardArray.iterator();
            	while(it.hasNext()){
            		JSONObject obj = (JSONObject)it.next();
                    map.put("date", obj.get("date"));
                    map.put("title", obj.get("title"));
                    //截取视频内容信息基中的视频地址：
                    if(obj.get("content")!=null && !"".equals(obj.get("content"))){
                    	 int videoSrcBegin = obj.get("content").toString().indexOf("<video>")+7;
                         int videoSrcEnd = obj.get("content").toString().indexOf("</video>");
                         videoSrc = obj.get("content").toString().substring(videoSrcBegin,videoSrcEnd);
                         
                         //System.out.println(Thread.currentThread().getStackTrace()[1].getClassName()+" Get video videoSrc is :"+videoSrc);
                         int videoSingleUrl = videoSrc.indexOf(",");
                         if(videoSingleUrl>0){
                        	 videoSrc = videoSrc.substring(0, videoSingleUrl);
                         }
                         System.out.println(Thread.currentThread().getStackTrace()[1].getClassName()+" Get video videoSrc.subString is :"+videoSrc);
                         //https://vodzst.cctv.cn/upload/photoAlbum/page/performance/img/2020/11/10/1604980491468_756.mp4,https://vodzst.cctv.cn/upload/photoAlbum/page/performance/img/2020/11/10/1604980491468_756.mp4,https://vodzst.cctv.cn/upload/photoAlbum/page/performance/img/2020/11/10/1604980491468_756.mp4,/export/apache/htdocs/upload/photoAlbum/page/performance/img/2020/11/10/1604980491468_756.mp4
                         //截取视频下方说明部分
	                     int descContentBegin = obj.get("content").toString().indexOf("</video>")+8;
	                     int descContentEnd = obj.get("content").toString().length();
	                     desc = obj.get("content").toString().substring(descContentBegin,descContentEnd);
	                     //System.out.println(Thread.currentThread().getStackTrace()[1].getClassName()+" Get videoDesc is :"+desc);
                    }
                    map.put("videoSrc", videoSrc);
                    //map.put("videoSrc", "https://vodzst.cctv.cn/upload/photoAlbum/page/performance/img/2020/11/10/1604980491468_756.mp4");
                    map.put("desc", desc);
                    JSONObject photoArray = (JSONObject)obj.get("photo");
                    map.put("thumb", photoArray.get("thumb"));
                    
                    
                    dataList.add(map);
            		//System.out.println("date:"+obj.get("date")+"title:"+obj.get("title")+"desc:"+desc+"videoSrc:"+videoSrc);
            	}
            }
            return dataList;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
    
  //读取json数据,返回一个字符串形式的json数据
	public String getDataByJson() {
		String path = getRequest().getSession().getServletContext().getRealPath("/videoInfo/cms_content.json"); 
		//System.out.println("cms_content.json path:"+path);
		File file=new File(path);
		StringBuffer buffer=new StringBuffer();
		if(file.exists()){
			BufferedReader bufferedReader=null;
			try {
				bufferedReader=new BufferedReader(new InputStreamReader(new FileInputStream(file),"UTF-8"));
				String read;
				while ((read = bufferedReader.readLine())!=null){
					buffer.append(read+"\n");
                }
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(bufferedReader!=null){
					try {
						bufferedReader.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		return buffer.toString();
	}
}
