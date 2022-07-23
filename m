Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1471557EF1B
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jul 2022 14:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiGWMCY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 08:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiGWMCY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 08:02:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2185F9FE3
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jul 2022 05:02:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ku18so6451600pjb.2
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jul 2022 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=yZDSjFlBqTyPgDDSYyOzpwaAh0DhKD46dx/+k62ky0E=;
        b=hQ0FzeOdzAybutiFBsV00UYzs9TQz3kCbKYQbapMHNNVcQ+KrVjnRom3k/PBGf4gSn
         xbvJ4TcYAGMhf1qahSFj28SmfZ3qdMMAUnAfelswSfm9ZZPzxTavopxX6yLGFwNiBwny
         9A1Y3+8IZH97SGABqoJoURM71q+X4jY6XoBZIoMEhRTyG37Mi8TvyczzGJBxod0bG7yK
         PKbxczm+tYwU86rJ0gnM0veNjd1dZ6gcOcJHo2oUUieBZEVasLy5/8/xyASHFeknu4R0
         gdlJs729MtYGEaZ55IepaYyp1mp/bkzsMBs8Kck/2DA8K5/UNu8/waM+vHfPfyA7K9jw
         8FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yZDSjFlBqTyPgDDSYyOzpwaAh0DhKD46dx/+k62ky0E=;
        b=r4VCQmqlNVWFzm3gyavmgANXOsKZyrZjOA2PY1UJ27v2QNHrfcG+fqcN9VimvAug2g
         JNEimfH8DSu4rUlkSIr7yXGjwztp+FMMjzaEMQcB32UgN7yv/oAWfail48X+qsc2IeuO
         LnfzApsjMrvSP7Pby0ned8p2EwkpGKjXO5pmwly8Kjex7SUTC5TOyCnCsl7mPHAzQxhU
         o/a5GJqBgAxKgdJw2HsCNqy3RxU6rRBdMfkyuBLzTFC0z6dO/rIe30hITewJ3mlEi7kp
         r7u0KkwqaYRln7v6YZe6t5eF+96lLYVPVZDsukWiGKYL6S5pat0m46xyQZMKWT8PrbDs
         HFig==
X-Gm-Message-State: AJIora866JRmHB/R1/kCmNMkMMNLcxlumsIqQMb+vFHRKwrN3gb0IXd/
        aQpYBwyxRYLfKXp+QVAZe0rQJfKIXGttzUGO/lY=
X-Google-Smtp-Source: AGRyM1uSJ88g23G4vRKFFVXLANH3H0NOTUxXTaMLOVCWdwzVHh6pBq80n8Hg5FzyonkvcMPhH0nIWA==
X-Received: by 2002:a17:90b:4b49:b0:1ef:a03e:b671 with SMTP id mi9-20020a17090b4b4900b001efa03eb671mr21996934pjb.108.1658577741960;
        Sat, 23 Jul 2022 05:02:21 -0700 (PDT)
Received: from zllke.localdomain ([219.137.142.59])
        by smtp.gmail.com with ESMTPSA id d30-20020a631d1e000000b0041a6638b357sm4943037pgd.72.2022.07.23.05.02.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jul 2022 05:02:21 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH] btrfs-progs: fix btrfs resize failed.
Date:   Sat, 23 Jul 2022 20:02:10 +0800
Message-Id: <1658577730-11447-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

related issuse:
https://github.com/kdave/btrfs-progs/issues/470

V1 link:
https://www.spinics.net/lists/linux-btrfs/msg126661.html

[BUG]
If there is no devid=1, when the user uses the btrfs file system tool, 
the following error will be reported,

$ sudo btrfs filesystem show /mnt/1
Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
    Total devices 2 FS bytes used 704.00KiB
    devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
    devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
$ sudo btrfs filesystem resize -1G /mnt/1
ERROR: cannot find devid: 1
ERROR: unable to resize '/mnt/1': No such device

[CAUSE]
If the user does not specify the devid id explicitly,
btrfs will use the default devid 1, so it will report an error when dev 1 is missing.

[FIX]
If the file system contains multiple devices, output an error message to the user.

If the filesystem has only one device, resize should automatically add the unique devid.

[RESULT]

$ sudo btrfs filesystem show /mnt/1/
Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
	Total devices 2 FS bytes used 144.00KiB
	devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
	devid    3 size 15.00GiB used 1.16GiB path /dev/loop3

$ sudo btrfs filesystem resize -1G /mnt/1
ERROR: The file system has multiple devices, please specify devid exactly.
ERROR: The device information list is as follows.
	devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
	devid    3 size 15.00GiB used 1.16GiB path /dev/loop3

$ sudo btrfs device delete 2 /mnt/1/

$ sudo btrfs filesystem show /mnt/1/
Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
	Total devices 1 FS bytes used 144.00KiB
	devid    3 size 15.00GiB used 1.28GiB path /dev/loop3

$ sudo btrfs filesystem resize -1G /mnt/1
Resize device id 3 (/dev/loop3) from 15.00GiB to 14.00GiB

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 cmds/filesystem.c | 63 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 7cd08fc..c26ba2b 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1087,7 +1087,8 @@ static const char * const cmd_filesystem_resize_usage[] = {
 	NULL
 };
 
-static int check_resize_args(const char *amount, const char *path) {
+static int check_resize_args(char * const amount, const char *path)
+{
 	struct btrfs_ioctl_fs_info_args fi_args;
 	struct btrfs_ioctl_dev_info_args *di_args = NULL;
 	int ret, i, dev_idx = -1;
@@ -1102,7 +1103,8 @@ static int check_resize_args(const char *amount, const char *path) {
 
 	if (ret) {
 		error("unable to retrieve fs info");
-		return 1;
+		ret = 1;
+		goto out;
 	}
 
 	if (!fi_args.num_devices) {
@@ -1112,11 +1114,14 @@ static int check_resize_args(const char *amount, const char *path) {
 	}
 
 	ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount);
+check:
 	if (strlen(amount) != ret) {
 		error("newsize argument is too long");
 		ret = 1;
 		goto out;
 	}
+	if (strcmp(amount, amount_dup) != 0)
+		strcpy(amount, amount_dup);
 
 	sizestr = amount_dup;
 	devstr = strchr(sizestr, ':');
@@ -1133,6 +1138,24 @@ static int check_resize_args(const char *amount, const char *path) {
 			ret = 1;
 			goto out;
 		}
+	} else if (fi_args.num_devices != 1) {
+		error("The file system has multiple devices, please specify devid exactly.");
+		error("The device information list is as follows.");
+		for (i = 0; i < fi_args.num_devices; i++) {
+			fprintf(stderr, "\tdevid %4llu size %s used %s path %s\n",
+				di_args[i].devid,
+				pretty_size_mode(di_args[i].total_bytes, UNITS_DEFAULT),
+				pretty_size_mode(di_args[i].bytes_used, UNITS_DEFAULT),
+				di_args[i].path);
+		}
+		ret = 1;
+		goto out;
+	} else {
+		memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
+		ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu:", di_args[0].devid);
+		ret = snprintf(amount_dup + strlen(amount_dup),
+			BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", amount);
+		goto check;
 	}
 
 	dev_idx = -1;
@@ -1200,10 +1223,11 @@ static int check_resize_args(const char *amount, const char *path) {
 		di_args[dev_idx].path,
 		pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
 		res_str);
+	ret = 1;
 
 out:
 	free(di_args);
-	return 0;
+	return ret;
 }
 
 static int cmd_filesystem_resize(const struct cmd_struct *cmd,
@@ -1235,8 +1259,10 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		}
 	}
 
-	if (check_argc_exact(argc - optind, 2))
-		return 1;
+	if (check_argc_exact(argc - optind, 2)) {
+		ret = 1;
+		goto out;
+	}
 
 	amount = argv[optind];
 	path = argv[optind + 1];
@@ -1244,7 +1270,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	len = strlen(amount);
 	if (len == 0 || len >= BTRFS_VOL_NAME_MAX) {
 		error("resize value too long (%s)", amount);
-		return 1;
+		ret = 1;
+		goto out;
 	}
 
 	cancel = (strcmp("cancel", amount) == 0);
@@ -1258,7 +1285,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		"directories as argument. Passing file containing a btrfs image\n"
 		"would resize the underlying filesystem instead of the image.\n");
 		}
-		return 1;
+		ret = 1;
+		goto out;
 	}
 
 	/*
@@ -1273,14 +1301,22 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 				error(
 			"unable to check status of exclusive operation: %m");
 			close_file_or_dir(fd, dirstream);
-			return 1;
+			goto out;
 		}
 	}
 
+	amount = (char *)malloc(BTRFS_VOL_NAME_MAX);
+	if (!amount) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	strcpy(amount, argv[optind]);
+
 	ret = check_resize_args(amount, path);
 	if (ret != 0) {
 		close_file_or_dir(fd, dirstream);
-		return 1;
+		ret = 1;
+		goto free_amount;
 	}
 
 	memset(&args, 0, sizeof(args));
@@ -1298,7 +1334,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 			error("unable to resize '%s': %m", path);
 			break;
 		}
-		return 1;
+		ret = 1;
 	} else if (res > 0) {
 		const char *err_str = btrfs_err_str(res);
 
@@ -1308,9 +1344,12 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 			error("resizing of '%s' failed: unknown error %d",
 				path, res);
 		}
-		return 1;
+		ret = 1;
 	}
-	return 0;
+free_amount:
+	free(amount);
+out:
+	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
 
-- 
1.8.3.1

