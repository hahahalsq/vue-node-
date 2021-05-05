<template>
    <div>
      <!-- <img src="../../assets/img/img.jpg" class="user-avator" alt /> -->
       <!-- <img src="../../assets/img/img.jpg" /> -->
        <div>列表</div>
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
        <el-button @click="showImg()">点击显示</el-button>
        <div style="display:flex;align-items:center;"> 
          <div v-for="item in returnImgUrlAll">
            <img :src="require('../../assets/upload/'+item)" style="width:15rem;height:15rem;" />
          </div>
        </div>

        <!-- <img :src="require('../../assets/upload/1619750149224.png')" /> -->

        <!-- <img src="../../upload/1619747584507.png" />  -->
        <!-- <img src="../../assets/img/img.jpg" class="user-avator" alt /> -->

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
            returnImgUrlAll:[], // 整合全部路径
            dialogVisible: false
        };
    },
    computed:{
        // returnImgUrlAll(){
        //   var tempList = []
        //   for(var i=0;i<this.returnImgUrl.length;i++){
        //     var tempitem = "../../upload" + this.returnImgUrl[i]
        //     tempList.push(tempitem) 
        //   }
        //   return tempList
        // }
    },
    methods: {
      showImg(){
        var tempList = []
        for(var i=0;i<this.returnImgUrl.length;i++){
          // 1619750417212.png
          var tempitem = this.returnImgUrl[i]
          // var tempitem = require("../../assets/upload/" + this.returnImgUrl[i])
          var requUrl = (tempitem)
          tempList.push(tempitem) 
        }
        this.returnImgUrlAll = tempList
        console.log('??????')
        console.log(this.returnImgUrlAll)
        // 1619750149224
        // this.testa = require('../../assets/upload/1619750149224.png')
        // console.log(this.testa)

      },
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