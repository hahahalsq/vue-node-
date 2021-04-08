import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);

export default new Router({
    routes: [
        {
            path: '/',
            redirect: '/dashboard'
        },
        {
            path: '/',
            component: () => import(/* webpackChunkName: "home" */ '../components/common/Home.vue'),
            meta: { title: '自述文件' },
            children: [
                {
                    path: '/dashboard',
                    component: () => import(/* webpackChunkName: "dashboard" */ '../components/page/Dashboard.vue'),
                    meta: { title: '系统首页' }
                },
                {
                    path: '/404',
                    component: () => import(/* webpackChunkName: "404" */ '../components/page/404.vue'),
                    meta: { title: '404' }
                },
                {
                    path: '/adminInfo',
                    component: () => import(/* webpackChunkName: "form" */ '../components/page/adminInfo.vue'),
                    meta: { title: '用户列表' }
                },
                {
                    path: '/goodsHold',
                    component: () => import(/* webpackChunkName: "form" */ '../components/page/goodsHold.vue'),
                    meta: { title: '房屋持有列表' }
                },
                {
                    path: '/goodsEdit',
                    component: () => import(/* webpackChunkName: "form" */ '../components/page/goodsEdit.vue'),
                    meta: { title: '房屋信息编辑' }
                },
                {
                    path: '/marketList',
                    component: () => import(/* webpackChunkName: "form" */ '../components/page/marketList.vue'),
                    meta: { title: '房屋市场' }
                },
                {
                    path: '/myCollection',
                    component: () => import(/* webpackChunkName: "form" */ '../components/page/myCollection.vue'),
                    meta: { title: '收藏夹' }
                },
            ]
        },
        {
            path: '/login',
            component: () => import(/* webpackChunkName: "login" */ '../components/page/Login.vue'),
            meta: { title: '登录' }
        },
        {
            path: '/register',
            component: () => import(/* webpackChunkName: "login" */ '../components/page/Register.vue'),
            meta: { title: '注册' }
        },
        {
            path: '/address',
            component: () => import(/* webpackChunkName: "login" */ '../components/page/BaseForm.vue'),
            meta: { title: '三级联动' }
        },
        {
            path: '*',
            redirect: '/404'
        },

    ]
});
