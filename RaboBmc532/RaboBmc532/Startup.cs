using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(RaboBmc532.Startup))]
namespace RaboBmc532
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
