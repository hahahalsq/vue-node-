<template>
    <div class="login-wrap">
        <div class="ms-login">
            <div class="ms-title">房屋出租管理系统</div>
            <el-form :model="param" :rules="rules" ref="login" label-width="0px" class="ms-content">
                <el-form-item prop="username">
                    <el-input v-model="param.username" placeholder="username">
                        <el-button slot="prepend" icon="el-icon-lx-people"></el-button>
                    </el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input
                        type="password"
                        placeholder="password"
                        v-model="param.password"
                        @keyup.enter.native="submitForm()"
                    >
                        <el-button slot="prepend" icon="el-icon-lx-lock"></el-button>
                    </el-input>
                </el-form-item>
                <div class="login-btn">
                    <el-button type="primary" @click="submitForm()">登录</el-button>
                </div>
                <div class="login-btn">
                    <el-button type="primary" @click="registeForm()">注册</el-button>
                </div>

                <p class="login-tips">Tips : 请输入正确的账号和密码~</p>
            </el-form>
        </div>
    </div>
</template>

<script>
 import axios from 'axios'
export default {
    data: function() {
        return {
            param: {
                username: '',
                password: '',
            },
            rules: {
                username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
                password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
            },
        };
    },
    methods: {
        registeForm(){
            var tokenStr = window.sessionStorage.getItem('token') 
            console.log(tokenStr)

            this.$router.push({
              path:'/register',
            })
        },
        submitForm() {
            localStorage.clear()    // 清空所有数据
            const that = this
            var name = this.param.username
            var pwd = this.param.password
            if (name == "" || pwd == "") {
                alert("帐号和密码不能为空")
            } else {
                //向服务器提交数据
                axios.post('http://127.0.0.1:3000/login', {
                        name: name,
                        pwd: pwd
                    })
                    .then(function(response) {
                        //成功时服务器返回 response 数据
                        // console.log('~~~~~~~~~~~')
                        // console.log(response.data)
                        if(response.data.length){
                            localStorage.setItem('ms_username', name);
                            localStorage.setItem('ms_level',response.data[0].level);
                            if(response.data[0].state == 0){
                                that.$message.error('账号已下线，请联系管理员！');
                            }else{
                                that.$router.push({
                                  path:'/',
                                })
                            }
                        }else{
                            that.$message.error('账号或密码不正确');
                            return false
                        }
                    })
                    .catch(function(error) {
                        console.log(error);
                    });
            }
        },

    },
};
</script>

<style >
.login-wrap {
    position: relative;
    width: 100%;
    height: 100%;
    /*background-image: url(../../assets/img/login-bg.jpg);*/
    background-size: 100%;
}
.ms-title {
    width: 100%;
    line-height: 50px;
    text-align: center;
    font-size: 20px;
    color: #fff;
    border-bottom: 1px solid #ddd;
}
.ms-login {
    position: absolute;
    left: 50%;
    top: 50%;
    width: 350px;
    margin: -190px 0 0 -175px;
    border-radius: 5px;
    background: rgba(255, 255, 255, 0.3);
    overflow: hidden;
}
.ms-content {
    padding: 30px 30px;
}
.login-btn {
    text-align: center;
}
.login-btn button {
    width: 100%;
    height: 36px;
    margin-bottom: 10px;
}
.login-tips {
    font-size: 12px;
    line-height: 30px;
    color: #fff;
}

.el-input__inner{
    height:3.4rem !important;
}
</style>