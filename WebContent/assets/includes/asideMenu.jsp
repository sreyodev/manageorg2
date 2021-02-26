<%@page import="org.json.JSONObject" session="true" %>
<%@page import="org.json.JSONArray"%>

<%! 
	JSONObject jsonObj = null; 
	JSONArray urlAccessList ;
%>
<div class="aside aside-left aside-fixed d-flex flex-column flex-row-auto" id="kt_aside">
	<!--begin::Brand-->
	<div class="brand flex-column-auto" id="kt_brand">
		<!--begin::Logo-->
		<a href="index.html" class="brand-logo">
			<img alt="Logo" src="assets/media/logos/logo.png" />
		</a>
		<!--end::Logo-->
		<!--begin::Toggle-->
		<button class="brand-toggle btn btn-sm px-0" id="kt_aside_toggle">
			<span class="svg-icon svg-icon svg-icon-xl">
				<!--begin::Svg Icon | path:assets/media/svg/icons/Navigation/Angle-double-left.svg-->
				<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
					<g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
						<polygon points="0 0 24 0 24 24 0 24" />
						<path d="M5.29288961,6.70710318 C4.90236532,6.31657888 4.90236532,5.68341391 5.29288961,5.29288961 C5.68341391,4.90236532 6.31657888,4.90236532 6.70710318,5.29288961 L12.7071032,11.2928896 C13.0856821,11.6714686 13.0989277,12.281055 12.7371505,12.675721 L7.23715054,18.675721 C6.86395813,19.08284 6.23139076,19.1103429 5.82427177,18.7371505 C5.41715278,18.3639581 5.38964985,17.7313908 5.76284226,17.3242718 L10.6158586,12.0300721 L5.29288961,6.70710318 Z" fill="#000000" fill-rule="nonzero" transform="translate(8.999997, 11.999999) scale(-1, 1) translate(-8.999997, -11.999999)" />
						<path d="M10.7071009,15.7071068 C10.3165766,16.0976311 9.68341162,16.0976311 9.29288733,15.7071068 C8.90236304,15.3165825 8.90236304,14.6834175 9.29288733,14.2928932 L15.2928873,8.29289322 C15.6714663,7.91431428 16.2810527,7.90106866 16.6757187,8.26284586 L22.6757187,13.7628459 C23.0828377,14.1360383 23.1103407,14.7686056 22.7371482,15.1757246 C22.3639558,15.5828436 21.7313885,15.6103465 21.3242695,15.2371541 L16.0300699,10.3841378 L10.7071009,15.7071068 Z" fill="#000000" fill-rule="nonzero" opacity="0.3" transform="translate(15.999997, 11.999999) scale(-1, 1) rotate(-270.000000) translate(-15.999997, -11.999999)" />
					</g>
				</svg>
				<!--end::Svg Icon-->
			</span>
		</button>
		<!--end::Toolbar-->
	</div>
	<!--end::Brand-->
	<!--begin::Aside Menu-->
	<div class="kt-aside-menu-wrapper kt-grid__item kt-grid__item--fluid" id="kt_aside_menu_wrapper">
    <div id="kt_aside_menu" class="kt-aside-menu  kt-aside-menu--dropdown " data-ktmenu-vertical="1"
        data-ktmenu-dropdown="1" data-ktmenu-scroll="0">
        <ul class="kt-menu__nav ">
            <%
            	urlAccessList = (JSONArray)session.getAttribute("urlAccessList");
            	int count				= urlAccessList.length();

               for(int i=0; i<count; i++){
            	    jsonObj = new JSONObject(urlAccessList.get(i).toString());
                    int id = jsonObj.getInt("id");
                    if(jsonObj.getString("type").equalsIgnoreCase("SINGLE")){ 
             %>
                            <li  style="margin-bottom: 20px;" class="cs_kt-menu__item kt-menu__item" aria-haspopup="true">
                                <a class="cs_kt-menu__link  kt-menu__link"  href="<% out.print(jsonObj.getString("functionName")+".jsp"); %>">
                                    <span style="margin-top: 4%;"><% out.print(jsonObj.getString("logo")); %></span>
                                    <span class="kt-menu__link-text mobileLinks"> <% out.print(jsonObj.getString("displayName")); %></span>
                                </a>
                            </li>
                    <% } else if (jsonObj.getString("type").equalsIgnoreCase("ONE_BRANCH_HEAD")) { %>
                        <li class="cs_kt-menu__item kt-menu__item kt-menu__item--submenu" aria-haspopup="true" data-ktmenu-submenu-toggle="hover">
                            <a href="javascript:;" class="cs_kt-menu__link  kt-menu__link kt-menu__toggle" >
                            <i class="kt-menu__link-icon fa fa-tasks"></i><span class="kt-menu__link-text"><% out.print(jsonObj.getString("displayName")); %></span></a>
                            <div class="kt-menu__submenu "><span class="kt-menu__arrow"></span>
                                <ul class="kt-menu__subnav">
                                <% 
                                    for(int j=0; j<count; j++){
                                    	JSONObject jsonObjJ = new JSONObject(urlAccessList.get(j).toString());
                                        if(jsonObjJ.getInt("parentId") == jsonObj.getInt("id")){
                                        %>
                                        <li class="kt-menu__item " aria-haspopup="true">
                                            <a class="kt-menu__link" href="<% out.print(jsonObj.getString("functionName")+".jsp"); %>">
                                                <i class="kt-menu__link-bullet kt-menu__link-bullet--dot"><span></span></i>
                                                <span class="kt-menu__link-text "><% out.print(jsonObj.getString("displayName")); %></span>
                                            </a>
                                        </li>
                                        <% 
                                        }
                                    }
                                %>
                                </ul>
                            </div>
                        </li>
                    <% } else if (jsonObj.getString("type").equalsIgnoreCase("MULTI_BRANCH_HEAD")) { %>
                        <li style="margin-bottom: 20px;" class="cs_kt-menu__item kt-menu__item  kt-menu__item--submenu kt-menu__item--submenu-fullheight" aria-haspopup="true" data-ktmenu-submenu-toggle="click" data-ktmenu-dropdown-toggle-class="kt-aside-menu-overlay--on"><a href="javascript:;" class="cs_kt-menu__link kt-menu__link kt-menu__toggle"><span style="margin-top: 4%;"><% out.print(jsonObj.getString("logo")); %></span><span class="kt-menu__link-text mobileLinks"><% out.print(jsonObj.getString("displayName")); %></span><i class="kt-menu__ver-arrow kt-menu__ver-arrow1 la la-angle-right"></i></a>
                            <div class="kt-menu__submenu "><span class="kt-menu__arrow"></span>
                                <div class="kt-menu__wrapper">
                                    <ul class="kt-menu__subnav">
                                        <% for(int k=0; k< count; k++){
                                        	JSONObject jsonObjK = new JSONObject(urlAccessList.get(k).toString());
                                            if(jsonObjK.getInt("parentId") == jsonObj.getInt("id")){
                                                if (jsonObjK.getString("type").equalsIgnoreCase("MULTI_SUBBRANCH_HEAD")) { %>
                                                    <li class="kt-menu__item  kt-menu__item--submenu kt-menu__item--open kt-menu__item--here" aria-haspopup="true" data-ktmenu-submenu-toggle="click" data-ktmenu-submenu-mode="accordion"><a href="javascript:;" class="custom-head1 kt-menu__link kt-menu__toggle"><span class="kt-menu__link-text" style="margin:0 auto;"><% out.print(jsonObjK.getString("displayName")); %></span><i class="kt-menu__ver-arrow  kt-menu__ver-arrow la la-angle-right"></i></a>
                                                        <div class="kt-menu__submenu "><span class="kt-menu__arrow"></span>
                                                            <%  
                                                            	for(int l=0;l<count;l++){
                                                            		JSONObject jsonObjL = new JSONObject(urlAccessList.get(l).toString());
                                                                	if(jsonObjL.getInt("parentId") == jsonObjK.getInt("id")){
                                                                    	if (jsonObjL.getString("type").equalsIgnoreCase("MULTI_SUBBRANCH_ITEM")) { 
                                                             %>
                                                                        <ul class="kt-menu__subnav">
                                                                            <li class="kt-menu__item" aria-haspopup="true"><a  href="<% out.print(jsonObjL.getString("functionName")+".jsp"); %>" class="kt-menu__link custom-head1"><span class="kt-menu__link-text"><% out.print(jsonObjL.getString("displayName")); %></span></a></li>
                                                                        </ul>
                                                             <% }
                                                                }
                                                            } %>
                                                        </div>
                                                    </li>
                                                <%  }
                                            }
                                        } %>
                                    </ul>
                                </div>
                            </div>
                        </li> 
                    <%  }
                } %>
        </ul>
    </div>
</div>
	<!--end::Aside Menu-->
</div>