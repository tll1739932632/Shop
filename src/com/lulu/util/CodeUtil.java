package com.lulu.util;

import java.util.UUID;

public class CodeUtil {

	/**
	 * 随机生成激活码
	 * @return
	 */
	public static String getActiveCode() {
		UUID uuid=UUID.randomUUID();
		return uuid.toString().replace("-", "");
	}
}
