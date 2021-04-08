<template>
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>
                    <i class="el-icon-lx-cascades">房屋市场</i> 
                </el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <el-table
                :data="tempData"
                border
                class="table"
                ref="multipleTable"
                header-cell-class-name="table-header"
                @selection-change=""
            >
                <el-table-column prop="location" label="位置" align="center"></el-table-column>
                <el-table-column prop="price" label="租金(￥)" align="center"></el-table-column>
                <el-table-column prop="amount" label="面积(m²)" align="center"></el-table-column>
                <el-table-column label="详情">
                    <template slot-scope="scope">
                        {{scope.row.content}}
                    </template>
                </el-table-column>

                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button
                            type="text"
                            icon="el-icon-edit"
                            @click="handleAdd(scope.$index, scope.row)" v-show="scope.row.carFlag != true"
                        >加入收藏</el-button>
                        <el-button
                            type="text"
                            icon="el-icon-edit"
                            @click="handleDel(scope.$index, scope.row)" v-show="scope.row.carFlag == true"
                        >取消收藏</el-button>
                    </template>
                </el-table-column>

            </el-table>
        </div>
        <!-- 编辑弹出框 -->
        <el-dialog title="编辑" :visible.sync="editVisible" width="30%">
            <div style="display:flex;align-items:center;justify-content:space-around;">
                <div style="font-size:2rem;color:#E56151;">确定收藏？</div>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="cancel">取 消</el-button>
                <el-button type="primary" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import { fetchData } from '../../api/index';
import axios from 'axios'
export default {
    name: 'basetable',
    data() {
        return {
            query: {
                address: '',
                name: '',
                pageIndex: 1,
                pageSize: 10
            },
            tableData: [],
            tempData:[],
            multipleSelection: [],
            delList: [],
            editVisible: false,
            pageTotal: 0,
            form: {},
            idx: -1,
            id: -1,
            username:'',
            tempRow:null,
            num:0,
        };
    },
    created() {
        this.getListData();
    },
    mounted(){
        console.log('~~~~~')
    },

    watch: {
      // 如果路由发生变化，再次执行该方法
      "$route": "getListData"
    },
    methods: {
        getListData() {
            console.log('111111')
            //向服务器提交数据
            const that = this
            that.username = localStorage.getItem('ms_username')
            var name = that.username
            axios.post('http://127.0.0.1:3000/getMarketList', {
            }).then(function(response) {
                    //成功时服务器返回 response 数据
                    if(response.data.length){
                        that.tableData = []
                        for(var j=0;j<response.data.length;j++){
                            if(response.data[j].state == 1){
                                that.tableData.push(response.data[j])
                            }
                        }
                        that.getCarInfo()

                    }else{
                        that.$message.error('没有数据')
                        return false
                    }
                })
                .catch(function(error) {
                    console.log(error);
                });
        },

        getCarInfo() {
            var that = this

            // 获取本账户购物车数据信息
            var username = localStorage.getItem('ms_username')
            axios.post('http://127.0.0.1:3000/getCarList', {
                username:username
            }).then(function(response) {
                    that.$nextTick(() => {
                        //成功时服务器返回 response 数据
                        if(response.data.length){
                            for(var i=0;i<that.tableData.length;i++){
                                for(var j=0;j<response.data.length;j++){
                                    if(that.tableData[i].id == response.data[j].id){
                                        that.tableData[i].carFlag = true
                                        break
                                    }
                                }
                            }
                        }
                        that.tempData = JSON.parse(JSON.stringify(that.tableData))
                    })

                })
                .catch(function(error) {
                    console.log(error);
                });
        },
        // 删除操作
        handleDel(index, row) {
            var id = row.id
            var that = this
            var username = localStorage.getItem('ms_username')
            axios.post('http://127.0.0.1:3000/delCar', {
                username:username,
                id:id,
            }).then(function(response) {
                    if(response.status == 200)
                    {
                        that.getListData();
                    }else{
                        that.$message.error('错误')
                        return false
                    }
                })
                .catch(function(error) {
                    console.log(error);
                }); 
        },
       // 添加操作
        handleAdd(index, row) {
            this.tempRow = row
            this.editVisible = true
        },
        // 保存编辑
        cancel(){
            this.editVisible = false
            this.num = 1
        },
        saveEdit() {
            var row = this.tempRow
            var id = row.id
            var that = this
            var location = row.location
            var price = row.price
            var amount = row.amount
            var username = localStorage.getItem('ms_username')
            var sellname = row.username
            var content = row.content
            this.editVisible = false;
            axios.post('http://127.0.0.1:3000/addCar', {
                username:username,
                id:id,
                amount:amount,
                location:location,
                price:price,
                sellname:sellname,
                content:content,
            }).then(function(response) {
                    if(response.status == 200)
                    {
                        that.getListData();
                    }else{
                        that.$message.error('错误')
                        return false
                    }
                })
                .catch(function(error) {
                    console.log(error);
                });
        },
        handleChange(value) {
            console.log(value);
        },
    }
};
</script>

<style scoped>
.handle-box {
    margin-bottom: 20px;
}

.handle-select {
    width: 120px;
}

.handle-input {
    width: 300px;
    display: inline-block;
}
.table {
    width: 100%;
    font-size: 14px;
}
.red {
    color: #ff0000;
}
.mr10 {
    margin-right: 10px;
}
.table-td-thumb {
    display: block;
    margin: auto;
    width: 40px;
    height: 40px;
}
</style>
