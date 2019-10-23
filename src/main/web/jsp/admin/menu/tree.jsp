
        <%--
          Created by IntelliJ IDEA.
          User: Administrator
          Date: 2019/10/14
          Time: 15:52
          To change this template use File | Settings | File Templates.
        --%>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
        <html>
        <head>
        <meta charset="UTF-8">
        <title>系统菜单</title>
        <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
        </head>
        <body>
        <div id="app">
            <el-row :gutter="20">
            <el-col :span="8"><div class="grid-content bg-purple">
                <el-tree :data="data" :props="defaultProps" @node-click="handleNodeClick" :highlight-current="true" default-expand-all>
                <span class="custom-tree-node" slot-scope="{node, data}">
                <i :class="data.menuIco"></i>
                {{ node.label }}
                </span>
                </el-tree>
            </div></el-col>
                <el-col :span="10"><div class="grid-content bg-purple">
                <el-form :model="menu" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                <el-form-item label="菜单名称" prop="menuTitle">
                <el-input v-model="menu.menuTitle"></el-input>
                </el-form-item>
            <el-form-item label="菜单链接" prop="menuLink">
            <el-input v-model="menu.menuLink"></el-input>
            </el-form-item>
            <el-form-item label="菜单图标" prop="menuIco">
            <el-input v-model="menu.menuIco"></el-input>
            </el-form-item>
            <el-form-item label="父级菜单" prop="pmenutitle">
            <el-input v-model="menu.pmenutitle" :disabled="true"></el-input>
            <input type="text" v-model="menu.menuPid" style="display: none">
            </el-form-item>
            <el-form-item label="菜单描述" prop="menuAlt">
            <el-input v-model="menu.menuAlt"></el-input>
            </el-form-item>
            <el-form-item label="菜单排序" prop="menu_order">
            <el-input v-model="menu.menu_order"></el-input>
            </el-form-item>
            <el-form-item label="是否顶级菜单" prop="istop">
            <el-switch v-model="menu.istop" @change="istop"></el-switch>
            </el-form-item>
            <el-form-item label="添加/修改" prop="istop">
                <el-select v-model="menu.isnew" placeholder="请选择" @change="changesave">
                <el-option
                label="修改"
                value="update">
                </el-option>
                <el-option
                label="新增"
                value="insert">
                </el-option>
                </el-select>
            </el-form-item>

                <el-form-item>
                <el-button type="primary" @click="submitForm('ruleForm')">立即保存</el-button>
                <el-button @click="resetForm('ruleForm')">重置</el-button>
                </el-form-item>
                </el-form>
            </div></el-col>
            </el-row>



        </div>





        <script src="https://unpkg.com/vue/dist/vue.js"></script>
        <script src="https://unpkg.com/element-ui/lib/index.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
        <script src="https://cdn.bootcss.com/qs/6.5.1/qs.min.js"></script>

        <script >
        new Vue({
        el:'#app',
        data:function() {

        return {
        data:[],


        defaultProps: {
        children: 'list',
        label: 'menuTitle'
        },
            menu:{},
            rules:{
            menuTitle:[
            {required:true,message:'请输入菜单名',trigger:'blur'},
            {min:2,max:50,message:'长度在2到50个字符',trigger:'blur'}
            ],
            menuLink:[
            {required:true,message:'请输入菜单链接',trigger:'blur'},
            {min:1,max:50,message:'长度在1到50个字符',trigger:'blur'}
            ],
            menuIco:[
            {required:true,message:'请输入菜单图标',trigger:'blur'},
            {min:1,max:50,message:'长度在1到50个字符',trigger:'blur'}
            ],
            menuAlt:[
            {required:true,message:'请输入菜单描述',trigger:'blur'},
            {min:1,max:50,message:'长度在1到50个字符',trigger:'blur'}
            ],
            menu_order:[
            {required:true,message:'请输入菜单排序',trigger:'blur'},
            {min:1,max:50,message:'长度在1到50个字符',trigger:'blur'}
            ],
            },
            backmenu:{},
        }
        },
        created:function() {
        this.inittree();
        },
        methods:{
            istop(value){
                if(value){
            this.backmenu=this.menu;
            this.menu={}
            this.menu.menuPid=0;
            this.menu.pmenutitle='顶级目录';
            this.menu.isnew='insert'

            }else{
            this.menu=this.backmenu;
            this.menu.isnew='update'
            }
            this.menu.istop=value;

            },
            changesave(){
                if(this.menu.isnew=='insert')
            {
                var pid=this.menu.menuPid;
                var ptitile=this.menu.pmenutitle;
                this.backmenu=this.menu;
                this.menu={};
                this.menu.menuPid=pid;
                this.menu.pmenutitle=ptitile;
            this.menu.isnew='insert'

            }else {
            this.menu=this.backmenu;
            this.menu.isnew='update'
            }
            },
            submitForm(formName) {


            this.saveorupdate();


                },
            resetForm(formName) {
            this.$refs[formName].resetFields();
            },

            saveorupdate(){
                var self=this;

                axios.get("<%=basePath%>admin/menu/saveOrupdate",{
                    params:self.menu
            }).
                then(function (response) {
                if (response.data.code=='10000')
                {

                    self.$message({
                    type: 'success',
                    message: '保存成功!'
                    });
                 // self.data=response.data.obj;
                        self.inittree();
                }else {
                self.$message({
                type: 'error',
                message: '加载失败!'
                });
                }
                }).catch(function (error) {
                console.log(error);
                self.$message({
                type: 'error',
                message: '网络异常!'
                });
                });
            },
        inittree(){
        var self=this;

        axios.get("<%=basePath%>admin/menu/list").
        then(function (response) {
        if (response.data.code=='10000')
        {

        self.data=response.data.obj;
        }else {
        self.$message({
        type: 'error',
        message: '加载失败!'
        });
        }
        }).catch(function (error) {
        console.log(error);
        self.$message({
        type: 'error',
        message: '网络异常!'
        });
        });
        },

        handleNodeClick(data,node,dom) {
            this.menu=data;
            if(this.menu.menuPid==0)
            {
            this.menu.pmenutitle="顶级目录";
            }
            else{
            this.menu.pmenutitle=node.parent.label;
            }
            console.log(data);
            console.log(node);
        }

        }
        })

        </script>

        </body>
        </html>
