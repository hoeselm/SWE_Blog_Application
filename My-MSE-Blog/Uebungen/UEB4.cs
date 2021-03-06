﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Autofac;
using MSE.SWE.Interfaces;
using MyMSEBlog.Controllers;
using MyMSEBlog.Core.BL;
using MyMSEBlog.Core.Interfaces;

namespace MyMSEBlog.Uebungen
{
    public class UEB4 : IUEB4
    {
        public void HelloWorld()
        {
        }


        public void SetupContainer(Autofac.ContainerBuilder builder)
        {
            builder.RegisterType<BL>()
                .As<MyIBL>()
                .As<IBL>()
                .InstancePerLifetimeScope();

            builder.RegisterType<AdminUserController>()
                .As<IAdminUserController>()
                .InstancePerDependency();

            builder.RegisterType<BlogPostsController>()
                .As<IBlogPostsController>()
                .InstancePerDependency();
        }
    }
}
