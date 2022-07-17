Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92F5776ED
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jul 2022 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiGQPIh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jul 2022 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiGQPIf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jul 2022 11:08:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3A113E1E
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 08:08:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 70so8678260pfx.1
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=x41O2YQTUidIJPD6vjmArbQMTurSRidNsY7+Db3pL5c=;
        b=MZ78eaRT8xDTg5AAuvtejVMhvZ8+Y/Ds0fF5qWfzp/+x8bei0dZVgcG3SXVs+GPQue
         3GDIzqB7oXY2jBeem7OBjKJCZZLAURUW44nVCm35vABxca20ixa9CTp9h6dph6jk8zYV
         8Ir41Q4J//vVK2Mj/aCJT2wrxodwJWub8/bIZOALUtIvUYydl3/HIKHb5m34ec3ZSWxn
         aHjgHmMQcYKTo8kWetvc1++LE5QtI2d1BMjeyUlKWVt6xPCDzaj6pZQu1lNB/C1kfKMn
         GEUvVGwC7t0GnGWRvt5nGuVkVXLu7rPJbcz0J0zZSU3Z8mL5NBFdy9fHI2mUvyakTELN
         0r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x41O2YQTUidIJPD6vjmArbQMTurSRidNsY7+Db3pL5c=;
        b=2usL1xTVTrCLSf3uMRfNDP2bkdH1LuRwkr7JAsd0CeiI074Pmn//NQtbFO71+Q1UQy
         Y1sC6o0/oBQVx25CJKg2ZraGVR01us1lxleP0OjjRPjARTbhSq2jpyzESHW601oiAJY5
         6d6Q/sPBaVIuwyE5s85Q7DFvvF3VlGj3gdwmw9/vDaUgj6txrWW4Fz9GFVYizSP7kgVX
         7ReNmgbaJVLzB1YRlHta9xSM3fyBjkgph341wEe5Xl9ciu6d5hKruHQa+U5Du/By/+Nu
         QStwtUZ2wpJ0g+w7mOOEU3+1ebpHCCZcSCTzPryqtZn+vsKySeO+JvZvRFVLD8K9OQfE
         nAnw==
X-Gm-Message-State: AJIora//G+K57GuHwREU5P03zAXdb+HJdlADr2dVdOebKlRJ1OtxoUKi
        14pL9YiLuj2D0t6z74Q1nuiHI9m/3S3nM4/fNI2W1A==
X-Google-Smtp-Source: AGRyM1sdmlBpeEUxrH6gubPuqm8rBDzmaW+jfHggZA+vZsvI9kaWWQd4uvuHjyJRKF/EA98tNCSfTw==
X-Received: by 2002:a05:6a00:238c:b0:52a:dcad:7847 with SMTP id f12-20020a056a00238c00b0052adcad7847mr24316677pfc.8.1658070513901;
        Sun, 17 Jul 2022 08:08:33 -0700 (PDT)
Received: from zllke.localdomain ([219.137.95.159])
        by smtp.gmail.com with ESMTPSA id mm18-20020a17090b359200b001efa35356besm9440874pjb.28.2022.07.17.08.08.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 08:08:33 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH] btrfs-progs: resize: automatically add devid if device is not specifically
Date:   Sun, 17 Jul 2022 23:08:23 +0800
Message-Id: <1658070503-25238-1-git-send-email-zhanglikernel@gmail.com>
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

related issues:
https://github.com/kdave/btrfs-progs/issues/470

[BUG]
If there is no devid=1, when the user uses the btrfs file system tool, the following error will be reported,

$ sudo btrfs filesystem show /mnt/1
Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
    Total devices 2 FS bytes used 704.00KiB
    devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
    devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
$ sudo btrfs filesystem resize -1G /mnt/1
ERROR: cannot find devid: 1
ERROR: unable to resize '/mnt/1': No such device

[CAUSE]
If the user does not specify the devid id explicitly, btrfs will use the default devid 1, so it will report an error when dev 1 is missing.

[FIX]
If there is no special devid, the first devid is added automatically and check the maximum length of args passed to kernel space.
After patch, when resize filesystem without specified, it would resize the first device, the result is list as following.

$ sudo btrfs filesystem show /mnt/1/
Label: none  uuid: 7b4827da-bc6e-42aa-b03d-52c2533dfe94
    Total devices 2 FS bytes used 144.00KiB
    devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
    devid    3 size 15.00GiB used 1.16GiB path /dev/loop3

$ sudo btrfs filesystem resize -1G /mnt/1
Resize device id 2 (/dev/loop2) from 15.00GiB to 14.00GiB
$ sudo btrfs filesystem show /mnt/1/
Label: none  uuid: 7b4827da-bc6e-42aa-b03d-52c2533dfe94
    Total devices 2 FS bytes used 144.00KiB
    devid    2 size 14.00GiB used 1.16GiB path /dev/loop2
    devid    3 size 15.00GiB used 1.16GiB path /dev/loop3

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 cmds/filesystem.c | 49 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 7cd08fc..2e2414d 100644
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
@@ -1137,6 +1142,13 @@ static int check_resize_args(const char *amount, const char *path) {
 
 	dev_idx = -1;
 	for(i = 0; i < fi_args.num_devices; i++) {
+		if (!devstr) {
+			memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
+			ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu:", di_args[i].devid);
+			ret = snprintf(amount_dup + strlen(amount_dup),
+				BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", amount);
+			goto check;
+		}
 		if (di_args[i].devid == devid) {
 			dev_idx = i;
 			break;
@@ -1235,8 +1247,10 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
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
@@ -1244,7 +1258,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	len = strlen(amount);
 	if (len == 0 || len >= BTRFS_VOL_NAME_MAX) {
 		error("resize value too long (%s)", amount);
-		return 1;
+		ret = 1;
+		goto out;
 	}
 
 	cancel = (strcmp("cancel", amount) == 0);
@@ -1258,7 +1273,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		"directories as argument. Passing file containing a btrfs image\n"
 		"would resize the underlying filesystem instead of the image.\n");
 		}
-		return 1;
+		ret = 1;
+		goto out;
 	}
 
 	/*
@@ -1273,14 +1289,22 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
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
@@ -1298,7 +1322,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 			error("unable to resize '%s': %m", path);
 			break;
 		}
-		return 1;
+		ret = 1;
 	} else if (res > 0) {
 		const char *err_str = btrfs_err_str(res);
 
@@ -1308,9 +1332,12 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
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

