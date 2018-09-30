package com.st.rbac.mapper;

import java.util.HashMap;
import java.util.List;

import com.st.rbac.pojo.Returnuser;
import com.st.rbac.util.Page;

public interface ReturnuserMapper {

	Integer selectRows(Returnuser returnuser, String uname);

	List<HashMap<String, Object>> selectReturn(Page page2, Returnuser returnuser, String uname);

	Integer xiugaihuifang(Returnuser returnuser);

}
