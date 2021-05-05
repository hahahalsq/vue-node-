<template>
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>
                    <i class="el-icon-lx-calendar"></i> 房源信息上传
                </el-breadcrumb-item>
                <el-breadcrumb-item>房源信息上传</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="form-box">
                <el-form ref="form" :model="form" label-width="80px">
                    <el-form-item label="位置">
                        <el-input v-model="form.name"></el-input>
                    </el-form-item>
                    <el-form-item label="租金(￥)">
                        <el-input v-model="form.price"></el-input>
                    </el-form-item>
                    <el-form-item label="面积(m²)">
                        <el-input v-model="form.number"></el-input>
                    </el-form-item>

                    <el-form-item label="房型">
                        <el-radio-group v-model="form.type">
                            <el-radio label="aaa">一室一厅</el-radio>
                            <el-radio label="bbb">两室一厅</el-radio>
                            <el-radio label="ccc">三室一厅</el-radio>
                            <el-radio label="ddd">三室两厅</el-radio>
                        </el-radio-group>
                    </el-form-item>


                    <el-form-item label="详情">
                        <el-input type="textarea" rows="5" v-model="form.desc"></el-input>
                    </el-form-item>

                    <div>上传图片</div>
                    <el-upload
                      action="http://localhost:3000/uploadImg"
                      list-type="picture-card"
                      :on-preview="handlePictureCardPreview"
                      :before-upload="beforeUpload"
                      :on-remove="handleRemove"
                      :on-progress="sendIng"
                      :on-error="sendErr"
                      :on-success="sendSuccess"
                       style="width:140%;padding-left:70px;margin-bottom:40px;" ref="upload">
                      <i class="el-icon-plus"></i>
                    </el-upload>
                    <el-dialog :visible.sync="dialogVisible" size="tiny">
                        <img width="100%" :src="dialogImageUrl" alt="">
                    </el-dialog>


                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">表单提交</el-button>
                        <el-button>取消</el-button>
                    </el-form-item>
                </el-form>
            </div>
        </div>
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
                price:'',
                number:'',
                desc:'',
                type:'',
            },
            dialogImageUrl: '', // 接口返回的图片地址
            returnImgUrl: [], // 用来存放图片地址
            returnImgUrlAll:[], // 整合全部路径
            imglist:'',
            dialogVisible: false,
        };
    },
    methods: {
        onSubmit() {
            const that = this
            var location = this.form.name
            var price = this.form.price
            var number = (this.form.number)
            var desc = this.form.desc
            var username = localStorage.getItem('ms_username')
            var type = this.form.type

            console.log('>>>>>>>>>')
            console.log(this.returnImgUrl)



                // 整合图片信息
            this.imglist= ''

            if(this.returnImgUrl.length > 0 && this.returnImgUrl.length < 6){
                for(var i=0;i<this.returnImgUrl.length;i++){
                    console.log(this.returnImgUrl[i])
                    var temp = this.returnImgUrl[i]
                    this.imglist = this.imglist +'+'+ temp
                }
            }
            var imgs = this.imglist

            if(this.returnImgUrl.length > 5){
                this.$message.error('上传图片数量不要超过5张！');
                return
            }
            if(this.returnImgUrl.length == 0){
                this.$message.error('请上传房屋图片信息！');
                return
            }else{
                if (location=="" || price =="" || number=="" ) {
                    this.$message.error('请将数据补充完整！');
                } else {

                    that.$refs.upload.clearFiles();

                    //向服务器提交数据
                    axios.post('http://127.0.0.1:3000/submitgoodsform', {
                            location: location,
                            price:price,
                            amount:number,
                            describe:desc,
                            username:username,
                            state:1,
                            imgs:imgs,
                            type:type,
                        })
                        .then(function(response) {
                            //成功时服务器返回 response 数据
                            if(response.status == 200){
                                that.$message.success('提交成功！');
                                that.$router.push({
                                  path:'/goodsHold',
                                })
                                that.form.name = ''
                                that.form.price = ''
                                that.form.number = ''
                                that.form.desc = ''
                                that.form.type = ''


                                that.dialogImageUrl =  ''
                                that.returnImgUrl = []
                                that.returnImgUrlAll = []
                                

                            }
                        })
                        .catch(function(error) {
                            console.log(error);
                        });
                }
            }

        },

      // 下面这些方法获得不同上传信息，打印出来值，看需要哪个参数，就保留哪个方法。
      handleRemove (file, fileList) {
        // console.log('4444444444444444')
        // console.log(file.response.filename)
        // console.log(fileList)
        var tempIndex = 0
        for(var i=0;i<this.returnImgUrl.length;i++){
          if(this.returnImgUrl[i] == file.response.filename){
              tempIndex = i
              break
          }
        }
        this.returnImgUrl.splice(tempIndex, 1)
        // console.log(this.returnImgUrl)
      },
      handlePictureCardPreview (file) {
        this.dialogImageUrl = file.url
        // console.log('!!!!!!!!!!!!!')
        // console.log(file.url)
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
          // console.log('333333333')
          // console.log(response)
          // console.log(response.filename)
          this.returnImgUrl.push(response.filename)
          // console.log(this.returnImgUrl)
      },
      // 图片路径
      beforeUpload (file) {
        //   console.log('22222')
        // console.log(file)
        // console.log(this.dialogImageUrl)
      },


    }
};
</script>