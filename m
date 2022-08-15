Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B485B592F00
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiHOMhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 08:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiHOMhW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 08:37:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E271A3BC
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 05:37:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so6651061pjk.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PTAErVy3cEtV52pb6vt99I1GWIE900EBu8lncqBcMFM=;
        b=SZULXhkeV5HrF6oG3MqnDIJBd0AfEcoa1Gp4tmhUtwsuS1/U6oZ5zagr3UYq0HOxtC
         /jN7UDuXm8kUXwX89GZYKMcikqjlz7+BTHyV+RKBx1g5zJS5dMen9KADjWXX7NISBAqI
         auGmdXrOH5h7hemAyGmxT/9fU8zkn0zbJUShWbmbrcszlunSnGK62qGFzMDzrwAtbjea
         HJHeMfOvfg7mu52Q2YXf9dnFeguUQ/EMhsOpVAUb1yT9E/Uo3L6KIGEJ62Fpl22doH5Y
         GNaQfJTNjxHcYTcIuI5njX4d6krCFl9WwPfV/D3rHdZloWCGSy4RLOHu5G/8mr9YmAfj
         mo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PTAErVy3cEtV52pb6vt99I1GWIE900EBu8lncqBcMFM=;
        b=PKbzvR52OORtwoNU7d7E+fZGEBXW2XMSreafUAKmD8WcKcANaQ/YLXuK9jiCqmNRow
         RtBfdP8oE2Zosf/DQzmNUS4cb1u0XMzTdeJLCIOHmN+jjGkHl4i2OjcblqQvZdvpvOKS
         wccbsKLPlXEYbWfTJhjzVKD+4NletaYCYPgNJUHjG2TXUyiAIcGuKFODfXrr8RnrQIYU
         tiJ8O42lLxuJ9g31Hy745x3LDJqNdz5eum3hBNidSNJkN2wK3XqkVYQOGXwZ2lowgXXL
         OUTOr+PmTED6tatTsxp7Z064XN0AkgGjiL2xoJkD1rlsttapFu98qXaVJ/zxmd/PLvC3
         GPuQ==
X-Gm-Message-State: ACgBeo0p7kvP30//RnTCygJ4127CqhF21kYCgHq0sdPA5kPdKSRg650P
        7zCl7zIFB0H0zthEU+h9Vl7SgaOON2k=
X-Google-Smtp-Source: AA6agR7V3wJhBX0MXX9VmsVLW853E91AZBnXG6CD2iCrUnH9xLyfrxI8wE/xvnPZlGlC8WhhdocrEg==
X-Received: by 2002:a17:90a:a4d:b0:1f5:5293:6abb with SMTP id o71-20020a17090a0a4d00b001f552936abbmr28021004pjo.236.1660567040160;
        Mon, 15 Aug 2022 05:37:20 -0700 (PDT)
Received: from realwakka-vm.. ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id i17-20020aa796f1000000b0052d46b43006sm6485533pfq.156.2022.08.15.05.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 05:37:19 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [RFC PATCH 1/2] btrfs-progs: fi resize: refactor function check_resize_args()
Date:   Mon, 15 Aug 2022 12:36:51 +0000
Message-Id: <20220815123652.52314-2-realwakka@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220815123652.52314-1-realwakka@gmail.com>
References: <20220815123652.52314-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch removes check_resize_args() and makes resize_with_args() for
supporting "all" option for resize function. The old code checks user
arguments and execute resizing with ioctl call. For new option, we
need to check user arguments and make new arguments if it needs multiple
ioctl calls. So it needs a function that checks argument and resize at
once. In a new function resize_with_args(), we will need to check each
sizestr for each device in "all" option. This patch also make
check_resize_args_sizestr() for checking sizestr.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/filesystem.c | 177 ++++++++++++++++++++++++----------------------
 1 file changed, 94 insertions(+), 83 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 7cd08fcd..ea1b0c84 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1087,17 +1087,77 @@ static const char * const cmd_filesystem_resize_usage[] = {
 	NULL
 };
 
-static int check_resize_args(const char *amount, const char *path) {
+static int check_resize_args_sizestr(const char *sizestr, u64 devid, int dev_idx,
+									 struct btrfs_ioctl_dev_info_args *di_args,
+									 struct btrfs_ioctl_fs_info_args *fi_args) {
+	const char *res_str;
+	int ret;
+
+	if (strcmp(sizestr, "max") == 0) {
+		res_str = "max";
+	} else if (strcmp(sizestr, "cancel") == 0) {
+		/* Different format, print and exit */
+		printf("Request to cancel resize\n");
+		ret = 0;
+	} else {
+		int mod = 0;
+		u64 diff = 0, old_size = 0, new_size = 0;
+		if (sizestr[0] == '-') {
+			mod = -1;
+			sizestr++;
+		} else if (sizestr[0] == '+') {
+			mod = 1;
+			sizestr++;
+		}
+		diff = parse_size_from_string(sizestr);
+		if (!diff) {
+			error("failed to parse size %s", sizestr);
+			ret = 1;
+			goto out;
+		}
+		old_size = di_args[dev_idx].total_bytes;
+
+		/* For target sizes without +/- sign prefix (e.g. 1:150g) */
+		if (mod == 0) {
+			new_size = diff;
+		} else if (mod < 0) {
+			if (diff > old_size) {
+				error("current size is %s which is smaller than %s",
+				      pretty_size_mode(old_size, UNITS_DEFAULT),
+				      pretty_size_mode(diff, UNITS_DEFAULT));
+				ret = 1;
+				goto out;
+			}
+			new_size = old_size - diff;
+		} else if (mod > 0) {
+			if (diff > ULLONG_MAX - old_size) {
+				error("increasing %s is out of range",
+				      pretty_size_mode(diff, UNITS_DEFAULT));
+				ret = 1;
+				goto out;
+			}
+			new_size = old_size + diff;
+		}
+		new_size = round_down(new_size, fi_args->sectorsize);
+		res_str = pretty_size_mode(new_size, UNITS_DEFAULT);
+	}
+
+	printf("Resize device id %lld (%s) from %s to %s\n", devid,
+		di_args[dev_idx].path,
+		pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
+		res_str);
+out:
+	return ret;
+}
+
+static int resize_with_args(const char *amount, const char *path, int fd) {
 	struct btrfs_ioctl_fs_info_args fi_args;
 	struct btrfs_ioctl_dev_info_args *di_args = NULL;
-	int ret, i, dev_idx = -1;
+	int ret, i, e, dev_idx = -1;
 	u64 devid = 1;
-	const char *res_str = NULL;
 	char *devstr = NULL, *sizestr = NULL;
-	u64 new_size = 0, old_size = 0, diff = 0;
-	int mod = 0;
 	char amount_dup[BTRFS_VOL_NAME_MAX];
-
+	struct btrfs_ioctl_vol_args	args;
 	ret = get_fs_info(path, &fi_args, &di_args);
 
 	if (ret) {
@@ -1149,58 +1209,37 @@ static int check_resize_args(const char *amount, const char *path) {
 		goto out;
 	}
 
-	if (strcmp(sizestr, "max") == 0) {
-		res_str = "max";
-	} else if (strcmp(sizestr, "cancel") == 0) {
-		/* Different format, print and exit */
-		printf("Request to cancel resize\n");
-		goto out;
-	} else {
-		if (sizestr[0] == '-') {
-			mod = -1;
-			sizestr++;
-		} else if (sizestr[0] == '+') {
-			mod = 1;
-			sizestr++;
-		}
-		diff = parse_size_from_string(sizestr);
-		if (!diff) {
-			error("failed to parse size %s", sizestr);
-			ret = 1;
-			goto out;
+	ret = check_resize_args_sizestr(sizestr, devid, dev_idx, di_args, &fi_args);
+	if (ret)
+		return 1;
+
+	memset(&args, 0, sizeof(args));
+	strncpy_null(args.name, amount);
+	ret = ioctl(fd, BTRFS_IOC_RESIZE, &args);
+	e = errno;
+	if(ret < 0){
+		switch (e) {
+		case EFBIG:
+			error("unable to resize '%s': no enough free space",
+				  path);
+			break;
+		default:
+			error("unable to resize '%s': %m", path);
+			break;
 		}
-		old_size = di_args[dev_idx].total_bytes;
+		return 1;
+	} else if (ret > 0) {
+		const char *err_str = btrfs_err_str(ret);
 
-		/* For target sizes without +/- sign prefix (e.g. 1:150g) */
-		if (mod == 0) {
-			new_size = diff;
-		} else if (mod < 0) {
-			if (diff > old_size) {
-				error("current size is %s which is smaller than %s",
-				      pretty_size_mode(old_size, UNITS_DEFAULT),
-				      pretty_size_mode(diff, UNITS_DEFAULT));
-				ret = 1;
-				goto out;
-			}
-			new_size = old_size - diff;
-		} else if (mod > 0) {
-			if (diff > ULLONG_MAX - old_size) {
-				error("increasing %s is out of range",
-				      pretty_size_mode(diff, UNITS_DEFAULT));
-				ret = 1;
-				goto out;
-			}
-			new_size = old_size + diff;
+		if (err_str) {
+			error("resizing of '%s' failed: %s", path, err_str);
+		} else {
+			error("resizing of '%s' failed: unknown error %d",
+				  path, ret);
 		}
-		new_size = round_down(new_size, fi_args.sectorsize);
-		res_str = pretty_size_mode(new_size, UNITS_DEFAULT);
+		return 1;
 	}
 
-	printf("Resize device id %lld (%s) from %s to %s\n", devid,
-		di_args[dev_idx].path,
-		pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
-		res_str);
-
 out:
 	free(di_args);
 	return 0;
@@ -1209,8 +1248,7 @@ out:
 static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 				 int argc, char **argv)
 {
-	struct btrfs_ioctl_vol_args	args;
-	int	fd, res, len, e;
+	int	fd, len;
 	char	*amount, *path;
 	DIR	*dirstream = NULL;
 	int ret;
@@ -1277,39 +1315,12 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		}
 	}
 
-	ret = check_resize_args(amount, path);
+	ret = resize_with_args(amount, path, fd);
 	if (ret != 0) {
 		close_file_or_dir(fd, dirstream);
 		return 1;
 	}
-
-	memset(&args, 0, sizeof(args));
-	strncpy_null(args.name, amount);
-	res = ioctl(fd, BTRFS_IOC_RESIZE, &args);
-	e = errno;
 	close_file_or_dir(fd, dirstream);
-	if( res < 0 ){
-		switch (e) {
-		case EFBIG:
-			error("unable to resize '%s': no enough free space",
-				path);
-			break;
-		default:
-			error("unable to resize '%s': %m", path);
-			break;
-		}
-		return 1;
-	} else if (res > 0) {
-		const char *err_str = btrfs_err_str(res);
-
-		if (err_str) {
-			error("resizing of '%s' failed: %s", path, err_str);
-		} else {
-			error("resizing of '%s' failed: unknown error %d",
-				path, res);
-		}
-		return 1;
-	}
 	return 0;
 }
 static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
-- 
2.34.1

