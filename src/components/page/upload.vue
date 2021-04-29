<template>
    <div>
        <div>文件列表</div>
        <el-upload
          action="http://localhost:3000/uploadImg"
          list-type="picture-card"
          :on-preview="handlePictureCardPreview"
          :before-upload="beforeUpload"
          :on-remove="handleRemove"
          :on-progress="sendIng"
          :on-error="sendErr"
          :on-success="sendSuccess"
          >
          <i class="el-icon-plus"></i>
        </el-upload>
        <el-dialog :visible.sync="dialogVisible" size="tiny">
            <img width="100%" :src="dialogImageUrl" alt="">
        </el-dialog>


        <el-button @click="showImgUrl()">点击查询</el-button>

        <!-- <img src="../../upload/b1cd629bf246af0fe5660a1997f45270.png" />  -->

<!-- 
        <div @click=""></div> -->
    </div>
</template>

<script>
 import axios from 'axios'
export default {
    name: 'baseform',
    data() {
        return {
            form: {
                name: '',
                password: '',
                level: '',
            },
            dialogImageUrl: '', // 接口返回的图片地址
            returnImgUrl: [], // 用来存放图片地址
            dialogVisible: false
        };
    },
    methods: {
      showImgUrl(){
        console.log('^^^^^^^^^^^^^^^')
        console.log(this.returnImgUrl)
        console.log('^^^^^^^^^^^^^^^')
      },
      // 下面这些方法获得不同上传信息，打印出来值，看需要哪个参数，就保留哪个方法。
      handleRemove (file, fileList) {
        console.log('4444444444444444')
        console.log(file.response.filename)
        console.log(fileList)
        var tempIndex = 0
        for(var i=0;i<this.returnImgUrl.length;i++){
          if(this.returnImgUrl[i] == file.response.filename){
              tempIndex = i
              break
          }
        }
        this.returnImgUrl.splice(tempIndex, 1)
        console.log(this.returnImgUrl)
      },
      handlePictureCardPreview (file) {
        this.dialogImageUrl = file.url
        console.log('!!!!!!!!!!!!!')
        console.log(file.url)
        this.dialogVisible = true
      },
      sendIng (event, file) {
        // console.log(event)
        // console.log(file)
      },
      sendErr (err) {
        // console.log(err)
      },
      sendSuccess(response){
          console.log('333333333')
          console.log(response)
          console.log(response.filename)
          this.returnImgUrl.push(response.filename)
          console.log(this.returnImgUrl)
      },
      // 图片路径
      beforeUpload (file) {
          console.log('22222')
        console.log(file)
        console.log(this.dialogImageUrl)
      },
      ///////////////////////////////////////////////////////////////
    }
};
</script>