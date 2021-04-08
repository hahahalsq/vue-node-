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
                    <el-form-item label="详情">
                        <el-input type="textarea" rows="5" v-model="form.desc"></el-input>
                    </el-form-item>
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
            }
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
            if (location=="" || price =="" || number=="" ) {
                this.$message.error('请将数据补充完整！');
            } else {
                //向服务器提交数据
                axios.post('http://127.0.0.1:3000/submitgoodsform', {
                        location: location,
                        price:price,
                        amount:number,
                        describe:desc,
                        username:username,
                        state:1,
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
                        }
                    })
                    .catch(function(error) {
                        console.log(error);
                    });
            }
        }
    }
};
</script>