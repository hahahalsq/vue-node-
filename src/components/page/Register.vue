<template>
    <div>

        <div style="text-align:center;margin-top:3rem;margin-bottom:3rem;font-size:2rem;">填写注册信息</div>
        <div style="display:flex;justify-content:center;">
            <div class="container">
                <div class="form-box">

                    <el-form ref="form" :model="form" label-width="80px">
                        <el-form-item prop="username" label="用户名">
                            <el-input v-model="form.name" placeholder="username" style="width:65%;">
                                <el-button slot="prepend" icon="el-icon-lx-people"></el-button>
                            </el-input>
                        </el-form-item>
                        <el-form-item prop="password" label="密码">
                            <el-input
                                type="password"
                                placeholder="password"
                                v-model="form.password" style="width:65%;"
                            >
                                <el-button slot="prepend" icon="el-icon-lx-lock"></el-button>
                            </el-input>
                        </el-form-item>

                        <el-form-item label="身份">
                            <el-select v-model="form.level" placeholder="请选择">
                                <el-option key="fd" label="我是出租房" value='2'></el-option>
                                <el-option key="zk" label="我是租房" value="3"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-form>
                    <div style="text-align:center;margin-top:3rem;">
                        <el-button type="primary" @click="onSubmit">提交注册</el-button>
                        <el-button>取消</el-button>
                    </div>
                </div>
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
                password: '',
                level: '',
            }

        };
    },
    methods: {
        onSubmit() {


            const that = this
            var name = this.form.name
            var pwd = this.form.password
            var level =this.form.level
            if (name == "" || pwd == "" || level == "") {
                that.$message.error('请补全注册信息！');
            } else {
                //向服务器提交数据
                axios.post('http://127.0.0.1:3000/register', {
                        name: name,
                        pwd: pwd,
                        level:parseInt(level)
                    })
                    .then(function(response) {
                        //成功时服务器返回 response 数据
                        if(response.status == 200){
                            that.$router.push({
                              path:'/login',
                            })
                        }else{
                            that.$message.error('注册失败');
                            return false
                        }
                    })
                    .catch(function(error) {
                        console.log(error);
                    });
            }

            this.$message.success('提交成功！');
        }
    }
};
</script>