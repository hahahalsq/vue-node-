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


            <div style="margin-bottom:10px;display:flex;align-items:center;">
                <div style="color:#999999;margin-right:30px;font-size:14px;">房型快速筛选</div>
                <el-button style="width:100px;" type="success" plain @click="typeSort('aaa')">一室一厅</el-button>
                <el-button style="width:100px;" type="success" plain @click="typeSort('bbb')">两室一厅</el-button>
                <el-button style="width:100px;" type="success" plain @click="typeSort('ccc')">三室一厅</el-button>
                <el-button style="width:100px;" type="success" plain @click="typeSort('ddd')">三室两厅</el-button>
                <el-button style="width:100px;" type="success" plain @click="typeSort('all')">全部</el-button>
            </div>
            <div style="margin-bottom:10px;display:flex;align-items:center;">
                <div style="color:#999999;margin-right:30px;font-size:14px;">租金范围筛选</div>
                <el-button style="width:100px;" type="success" plain @click="moneySort('aaa')">0~1500</el-button>
                <el-button style="width:100px;" type="success" plain @click="moneySort('bbb')">1500~2500</el-button>
                <el-button style="width:100px;" type="success" plain @click="moneySort('ccc')">2500~4000</el-button>
                <el-button style="width:100px;" type="success" plain @click="moneySort('ddd')">4000+</el-button>
                <el-button style="width:100px;" type="success" plain @click="moneySort('all')">全部</el-button>
            </div>
            <div style="margin-bottom:10px;display:flex;align-items:center;">
                <div style="color:#999999;margin-right:30px;font-size:14px;">距离范围筛选</div>
                <el-button style="width:100px;" type="success" plain @click="disSort('aaa')">0km-3km</el-button>
                <el-button style="width:100px;" type="success" plain @click="disSort('bbb')">3km-5km</el-button>
                <el-button style="width:100px;" type="success" plain @click="disSort('ccc')">5km-8km</el-button>
                <el-button style="width:100px;" type="success" plain @click="disSort('ddd')">8km+</el-button>
                <el-button style="width:100px;" type="success" plain @click="disSort('all')">全部</el-button>
            </div>

            <div style="height:30px;margin-bottom:20px;margin-top:10px;display:flex;align-items:center;">
                <div style="color:#999999;margin-right:56px;font-size:14px;">筛选条件</div>
                <el-tag style="margin-right:10px;"
                    :key="tag.type"
                    v-for="tag in dynamicTags"
                    
                    :disable-transitions="false"
                   >
                    {{tag.name}}
                </el-tag>
            </div>





            <el-table
                :data="finalData"
                border
                class="table"
                ref="multipleTable"
                header-cell-class-name="table-header"
                @selection-change=""
            >

                <el-table-column width="280" label="房屋图片" align="center">
                    <template slot-scope="scope">
                        <div style="text-align:center;">
                        <img @click="showMoreImg(scope.row)" :src="require('../../assets/upload/'+scope.row.firstImg)" style="width:200px;height:180px;" />
                        </div>
                    </template>
                </el-table-column>

                <el-table-column prop="location" label="位置" align="center"></el-table-column>
                <el-table-column prop="price" label="租金(￥)" align="center" sortable></el-table-column>
                <el-table-column prop="amount" label="面积(m²)" align="center" sortable></el-table-column>
                <el-table-column prop="distance" label="距您位置(km)" align="center" sortable></el-table-column>
                <el-table-column label="房型" align="center">
                    <template slot-scope="scope">
                        <div v-show="scope.row.type == 'aaa'"
                        >一室一厅</div>
                        <div v-show="scope.row.type == 'bbb'"
                        >两室一厅</div>
                        <div v-show="scope.row.type == 'ccc'"
                        >三室一厅</div>
                        <div v-show="scope.row.type == 'ddd'"
                        >三室两厅</div>
                    </template>
                </el-table-column>


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

        <!-- 图片弹出框 -->
        <el-dialog title="房屋图片" :visible.sync="imgVisible" width="50%" style="text-align:center;">
            <div style="display:flex;align-items:center;flex-wrap:wrap;">
              <div v-for="item in returnImgUrlAll">
                <img :src="require('../../assets/upload/'+item)" style="width:20rem;height:20rem;margin:20px;" />
              </div>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button type="primary" @click="confirmImg">确 定</el-button>
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
            imgVisible:false,
            pageTotal: 0,
            form: {},
            idx: -1,
            id: -1,
            username:'',
            tempRow:null,
            num:0,
            returnImgUrlAll:[],
            dynamicTags:[],
            sortTypeFlag:'all',
            sortMoneyFlag:'all',
            sortDisFlag:'all'
        };
    },
    created() {
        this.getListData();
    },
    mounted(){
        console.log('~~~~~')
    },
    computed: {
        finalData() {
            var that = this
            var temData = that.tempData
            // 房源距离使用随机距离，在1-10之间
            // if(temData.length){
            //     for(var i=0;i<temData.length;i++){
            //         var num = (Math.floor(Math.random()*10 + 1))

            //         temData[i].distance = num

            //     }
            // }
            // console.log(temData)
            var firstData = []
            var secondData = []
            var thirdData = []
            if(this.sortTypeFlag == 'all'){
                firstData = temData
                if(this.sortMoneyFlag == 'all'){
                    secondData = firstData
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'aaa'){
                    secondData = firstData.filter(item =>  item.price > 0 && item.price <= 1500 )
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'bbb'){
                    secondData = firstData.filter(item =>  item.price > 1500 && item.price <= 2500 )
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'ccc'){
                    secondData = firstData.filter(item =>  item.price > 2500 && item.price <= 4000 )
                    thirdData = this.filterDis(secondData)
                }else if(this.sortMoneyFlag == 'ddd'){
                    secondData = firstData.filter(item =>  item.price > 4000 )
                    thirdData = this.filterDis(secondData)
                }
            }else if(this.sortTypeFlag == 'aaa'){
                firstData = temData.filter(item => item.type== 'aaa' )
                if(this.sortMoneyFlag == 'all'){
                    secondData = firstData
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'aaa'){
                    secondData = firstData.filter(item =>  item.price > 0 && item.price <= 1500 )
                    thirdData = this.filterDis(secondData)
                }else if(this.sortMoneyFlag == 'bbb'){
                    secondData = firstData.filter(item =>  item.price > 1500 && item.price <= 2500 )
                    thirdData = this.filterDis(secondData)
                }else if(this.sortMoneyFlag == 'ccc'){
                    secondData = firstData.filter(item =>  item.price > 2500 && item.price <= 4000 )
                    thirdData = this.filterDis(secondData)
                }else if(this.sortMoneyFlag == 'ddd'){
                    secondData = firstData.filter(item =>  item.price > 4000 )
                    thirdData = this.filterDis(secondData)
                }
            }else if(this.sortTypeFlag == 'bbb'){
                firstData = temData.filter(item => item.type== 'bbb' )
                if(this.sortMoneyFlag == 'all'){
                    secondData = firstData
                    thirdData = this.filterDis(secondData)
                }else if(this.sortMoneyFlag == 'aaa'){
                    secondData = firstData.filter(item =>  item.price > 0 && item.price <= 1500 )
                    thirdData = this.filterDis(secondData)
                }else if(this.sortMoneyFlag == 'bbb'){
                    secondData = firstData.filter(item =>  item.price > 1500 && item.price <= 2500 )
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'ccc'){
                    secondData = firstData.filter(item =>  item.price > 2500 && item.price <= 4000 )
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'ddd'){
                    secondData = firstData.filter(item =>  item.price > 4000 )
                    thirdData = this.filterDis(secondData)
                }

            }else if(this.sortTypeFlag == 'ccc'){
                firstData = temData.filter(item => item.type== 'ccc' )
                if(this.sortMoneyFlag == 'all'){
                    secondData = firstData
                    thirdData = this.filterDis(secondData)
                }else if(this.sortMoneyFlag == 'aaa'){
                    secondData = firstData.filter(item =>  item.price > 0 && item.price <= 1500 )
                    thirdData = this.filterDis(secondData)
                }else if(this.sortMoneyFlag == 'bbb'){
                    secondData = firstData.filter(item =>  item.price > 1500 && item.price <= 2500 )
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'ccc'){
                    secondData = firstData.filter(item =>  item.price > 2500 && item.price <= 4000 )
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'ddd'){
                    secondData = firstData.filter(item =>  item.price > 4000 )
                    thirdData = this.filterDis(secondData)
                }

            }else if(this.sortTypeFlag == 'ddd'){
                firstData = temData.filter(item => item.type== 'ddd' )
                if(this.sortMoneyFlag == 'all'){
                    secondData = firstData
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'aaa'){
                    secondData = firstData.filter(item =>  item.price > 0 && item.price <= 1500 )
                    thirdData = this.filterDis(secondData)
                }else if(this.sortMoneyFlag == 'bbb'){
                    secondData = firstData.filter(item =>  item.price > 1500 && item.price <= 2500 )
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'ccc'){
                    secondData = firstData.filter(item =>  item.price > 2500 && item.price <= 4000 )
                    thirdData = this.filterDis(secondData)

                }else if(this.sortMoneyFlag == 'ddd'){
                    secondData = firstData.filter(item =>  item.price > 4000 )
                    thirdData = this.filterDis(secondData)
                }


            }
            return thirdData


            // return temData
        }
    },
    watch: {
      // 如果路由发生变化，再次执行该方法
      "$route": "getListData"
    },
    methods: {
        filterDis(secondData){
            var thirdData = []

            if(this.sortDisFlag == 'all'){
                thirdData = secondData
            }else if(this.sortDisFlag == 'aaa'){
                thirdData = secondData.filter(item =>  item.distance > 0 && item.distance <= 3 )
            }else if(this.sortDisFlag == 'bbb'){
                thirdData = secondData.filter(item =>  item.distance > 3 && item.distance <= 5 )
            }else if(this.sortDisFlag == 'ccc'){
                thirdData = secondData.filter(item =>  item.distance > 5 && item.distance <= 8 )
            }else if(this.sortDisFlag == 'ddd'){
                thirdData = secondData.filter(item =>  item.distance > 8  )
            }
            return thirdData

        },
        typeSort(flag){
            this.sortTypeFlag = flag
            var closeFlag = false
            var closeIndex = 0
            var hasFlag = false
            if(this.dynamicTags.length){
                for(var i=0;i<this.dynamicTags.length;i++){
                    if(this.dynamicTags[i].type == 'type'){
                        hasFlag = true
                        if(flag == 'aaa'){
                            this.dynamicTags[i].name = '一室一厅'
                        }else if(flag == 'bbb'){
                            this.dynamicTags[i].name = '两室一厅'
                        }else if(flag == 'ccc'){
                            this.dynamicTags[i].name = '三室一厅'
                        }else if(flag == 'ddd'){
                            this.dynamicTags[i].name = '三室两厅'
                        }else if(flag == 'all'){
                            closeFlag = true
                            closeIndex = i
                        }
                        break
                    }
                }
                if(closeFlag){
                    this.dynamicTags.splice(closeIndex, 1);
                }
            }else{
                hasFlag = true
                var item = {}
                item.type = 'type'
                if(flag == 'aaa'){
                    item.name = '一室一厅'
                }else if(flag == 'bbb'){
                    item.name = '两室一厅'
                }else if(flag == 'ccc'){
                    item.name = '三室一厅'
                }else if(flag == 'ddd'){
                    item.name = '三室两厅'
                }else if(flag == 'all'){

                }
                if(flag == 'all'){

                }else{
                    this.dynamicTags.push(item)
                }
            }
            if(!hasFlag){
                var item = {}
                item.type = 'type'
                if(flag == 'aaa'){
                    item.name = '一室一厅'
                }else if(flag == 'bbb'){
                    item.name = '两室一厅'
                }else if(flag == 'ccc'){
                    item.name = '三室一厅'
                }else if(flag == 'ddd'){
                    item.name = '三室两厅'
                }else if(flag == 'all'){

                }
                if(flag == 'all'){

                }else{
                    this.dynamicTags.push(item)
                }  
            }
            // console.log('-----------------------------')
            // console.log(this.dynamicTags)
        },
        moneySort(flag){
            this.sortMoneyFlag = flag
            // console.log('money')
            var closeFlag = false
            var closeIndex = 0
            var hasFlag = false
            if(this.dynamicTags.length){
                for(var i=0;i<this.dynamicTags.length;i++){
                    if(this.dynamicTags[i].type == 'money'){
                        hasFlag = true

                        if(flag == 'aaa'){
                            this.dynamicTags[i].name = '0~1500'
                        }else if(flag == 'bbb'){
                            this.dynamicTags[i].name = '1500~2500'
                        }else if(flag == 'ccc'){
                            this.dynamicTags[i].name = '2500~4000'
                        }else if(flag == 'ddd'){
                            this.dynamicTags[i].name = '4000+'
                        }else if(flag == 'all'){
                            closeFlag = true
                            closeIndex = i
                        }
                        break

                    }
                }
                if(closeFlag){
                    this.dynamicTags.splice(closeIndex, 1);
                }
            }else{
                hasFlag = true
                var item = {}
                item.type = 'money'
                if(flag == 'aaa'){
                    item.name = '0~1500'
                }else if(flag == 'bbb'){
                    item.name = '1500~2500'
                }else if(flag == 'ccc'){
                    item.name = '2500~4000'
                }else if(flag == 'ddd'){
                    item.name = '4000+'
                }else if(flag == 'all'){

                }
                if(flag == 'all'){

                }else{
                    this.dynamicTags.push(item)
                }
            }
            if(!hasFlag){
                var item = {}
                item.type = 'money'
                if(flag == 'aaa'){
                    item.name = '0~1500'
                }else if(flag == 'bbb'){
                    item.name = '1500~2500'
                }else if(flag == 'ccc'){
                    item.name = '2500~4000'
                }else if(flag == 'ddd'){
                    item.name = '4000+'
                }else if(flag == 'all'){

                }
                if(flag == 'all'){

                }else{
                    this.dynamicTags.push(item)
                }          
            }
            // console.log('-----------------------------')
            // console.log(this.dynamicTags)
        },
        disSort(flag){
            this.sortDisFlag = flag
            // console.log('distance')
            var closeFlag = false
            var closeIndex = 0
            var hasFlag = false
            if(this.dynamicTags.length){
                for(var i=0;i<this.dynamicTags.length;i++){
                    if(this.dynamicTags[i].type == 'dis'){
                        hasFlag = true

                        if(flag == 'aaa'){
                            this.dynamicTags[i].name = '0km-3km'
                        }else if(flag == 'bbb'){
                            this.dynamicTags[i].name = '3km-5km'
                        }else if(flag == 'ccc'){
                            this.dynamicTags[i].name = '5km~8km'
                        }else if(flag == 'ddd'){
                            this.dynamicTags[i].name = '8km+'
                        }else if(flag == 'all'){
                            closeFlag = true
                            closeIndex = i
                        }
                        break

                    }
                }
                if(closeFlag){
                    this.dynamicTags.splice(closeIndex, 1);
                }
            }else{
                hasFlag = true
                var item = {}
                item.type = 'dis'
                if(flag == 'aaa'){
                    item.name = '0km-3km'
                }else if(flag == 'bbb'){
                    item.name = '3km-5km'
                }else if(flag == 'ccc'){
                    item.name = '5km~8km'
                }else if(flag == 'ddd'){
                    item.name = '8km+'
                }else if(flag == 'all'){

                }
                if(flag == 'all'){

                }else{
                    this.dynamicTags.push(item)
                }
            }
            if(!hasFlag){
                var item = {}
                item.type = 'dis'
                if(flag == 'aaa'){
                    item.name = '0km-3km'
                }else if(flag == 'bbb'){
                    item.name = '3km-5km'
                }else if(flag == 'ccc'){
                    item.name = '5km~8km'
                }else if(flag == 'ddd'){
                    item.name = '8km+'
                }else if(flag == 'all'){

                }
                if(flag == 'all'){

                }else{
                    this.dynamicTags.push(item)
                }          
            }

        },


        showMoreImg(item){
            this.imgVisible = true
            var tempList = []
            var tempArr = item.imgs.split('+')
            for(var i=1;i<tempArr.length;i++){
                tempList.push(tempArr[i])
            }

            this.returnImgUrlAll = tempList

        },
        confirmImg(){
            this.imgVisible = false
            this.returnImgUrlAll = []
        },
        getListData() {
            // console.log('111111')
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

                        for(var i=0;i<that.tempData.length;i++){
                            var temparr = that.tempData[i].imgs
                            var firstImg = temparr.split('+')[1]
                            that.tempData[i].firstImg = firstImg
                        }

                        if(that.tempData.length){
                            for(var i=0;i<that.tempData.length;i++){
                                var num = (Math.floor(Math.random()*10 + 1))
                                that.tempData[i].distance = num
                            }
                        }



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
            var imgs = row.imgs
            var type = row.type
            this.editVisible = false;
            axios.post('http://127.0.0.1:3000/addCar', {
                username:username,
                id:id,
                amount:amount,
                location:location,
                price:price,
                sellname:sellname,
                content:content,
                imgs:imgs,
                type:type,
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
