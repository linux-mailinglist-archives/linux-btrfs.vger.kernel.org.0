Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20B457F51B
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiGXMoi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jul 2022 08:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGXMoh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jul 2022 08:44:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B281208C
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 05:44:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gn24so8052533pjb.3
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bE1vYZZrL/6tt/QT4P7QqH8kPScDNOSw8iR2KLfx6wM=;
        b=M+c9atXXuTRnk8L0jxaF+ItNdAi1YeuuJex6zeGbj0Ng4Go/6S5Ip21XC33yqMxIFS
         sbh5YhYOA2zN6cs1jIeF9h1u0/uRWVyeofzsBSXcOD7l89IC05x7GaGo3JcBW4lRIt46
         xJRZmrhd2pULP1ge257ctB3JevlQD0gyusxHVty30dBH9xeOKeNuOf6gcQ/Ep9hz3EAZ
         3Y2MzS2+uUPGiuSgfJDQeQfgRRTCz0wGUeb+V/Y4m1SJTyGmfIwMXZlYCAJJbHD9StMv
         MIiwkTdbUfm+6XfjNWvHa9nnZwoDsOnuTPi/7dmvt/FA9Pn7M3+mXeNfAZmS9nP/T+6y
         3yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bE1vYZZrL/6tt/QT4P7QqH8kPScDNOSw8iR2KLfx6wM=;
        b=tltVxZ0wO2p5MuqXuFVPz+n/oOlWFdUpeYpks4Up3PQEJ2HjF0PAYzjj6sSbIeYZ/y
         flVOhZZsUslzW8NqBx1Qu8f0dglv1vkjOG6IevDxt3kp84Ouol/Z07k+GUc8xCefCojW
         H/qI2/EpEGVt6XnXw23M5Xub3FWWm5PLvoxd4sU0RK6QZgFIKXM5Dp1Rjl86EdtnCRxv
         kCetGySMTwx8V1TJ9xgV1HBAKKodEKcz3ARlkNIHBUH08IlNYOEvOlZ0kkinqRFalHWm
         mqnOXnHoeIECnBYE5OaHbxqSEOV5pACIUOrPUUNryqefPL3Eju0h4AaBuguD1WzrPhjo
         gptA==
X-Gm-Message-State: AJIora+NpSyGIEDKhjWPNBp2v+WaVBdWZJ6B+nw5mpk0RXOB3Pokydul
        FCHZpf8uYVumZrrKTAVEhu23NVeohzaQAg==
X-Google-Smtp-Source: AGRyM1sfCoaECyelvrH3vIl9OV2FMerAg2IT/i0jKUqZFZh5q1idgBtOZg0/Izp0o9Y6OT1iIj2pdA==
X-Received: by 2002:a17:902:6bcb:b0:16c:e9b7:347 with SMTP id m11-20020a1709026bcb00b0016ce9b70347mr8011522plt.150.1658666675501;
        Sun, 24 Jul 2022 05:44:35 -0700 (PDT)
Received: from zllke.localdomain ([219.137.142.59])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b0016d6c38d37bsm931193plf.156.2022.07.24.05.44.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2022 05:44:35 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH v3] btrfs-progs: fix btrfs resize failed.
Date:   Sun, 24 Jul 2022 20:43:47 +0800
Message-Id: <1658666627-27889-1-git-send-email-zhanglikernel@gmail.com>
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

V2 link:
https://www.spinics.net/lists/linux-btrfs/msg126853.html

[BUG]
1. If there is no devid=1, when the user uses the btrfs file system tool,
the following error will be reported,

$ sudo btrfs filesystem show /mnt/1
Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
    Total devices 2 FS bytes used 704.00KiB
    devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
    devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
$ sudo btrfs filesystem resize -1G /mnt/1
ERROR: cannot find devid: 1
ERROR: unable to resize '/mnt/1': No such device

2. Function check_resize_args, if get_fs_info is successful,
check_resize_args always returns 0, Even if the parameter
passed to kernel space is longer than the size allowed to
be passed to kernel space (BTRFS_VOL_NAME_MAX).

[CAUSE]
1. If the user does not specify the devid id explicitly,
btrfs will use the default devid 1, so it will report an error when dev 1 is missing.

2. The last line of the function check_resize_args is return 0.

[FIX]
1. If the file system contains multiple devices, output an error message to the user.
If the filesystem has only one device, resize should automatically add the unique devid.

2. The function check_resize_args should not return 0 on the last line,
it should return ret representing the return value.

3. Update the "btrfs-filesystem" man page

[RESULT]

$ sudo btrfs filesystem resize --help
usage: btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>

    Resize a filesystem

    If the filesystem contains only one device, devid can be ignored.
    If 'max' is passed, the filesystem will occupy all available space
    on the device 'devid'.
    [kK] means KiB, which denotes 1KiB = 1024B, 1MiB = 1024KiB, etc.

    --enqueue         wait if there's another exclusive operation running,
                      otherwise continue

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

$ sudo btrfs filesystem show /mnt/1/
Label: none  uuid: cc6e1beb-255b-431f-baf5-02e8056fd0b6
	Total devices 1 FS bytes used 144.00KiB
	devid    3 size 14.00GiB used 1.28GiB path /dev/loop3

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 cmds/filesystem.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 7cd08fc..e641fcb 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1078,6 +1078,7 @@ static DEFINE_SIMPLE_COMMAND(filesystem_defrag, "defragment");
 static const char * const cmd_filesystem_resize_usage[] = {
 	"btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>",
 	"Resize a filesystem",
+	"If the filesystem contains only one device, devid can be ignored.",
 	"If 'max' is passed, the filesystem will occupy all available space",
 	"on the device 'devid'.",
 	"[kK] means KiB, which denotes 1KiB = 1024B, 1MiB = 1024KiB, etc.",
@@ -1087,7 +1088,8 @@ static const char * const cmd_filesystem_resize_usage[] = {
 	NULL
 };
 
-static int check_resize_args(const char *amount, const char *path) {
+static int check_resize_args(char * const amount, const char *path)
+{
 	struct btrfs_ioctl_fs_info_args fi_args;
 	struct btrfs_ioctl_dev_info_args *di_args = NULL;
 	int ret, i, dev_idx = -1;
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
+	ret = 0;
 
 out:
 	free(di_args);
-	return 0;
+	return ret;
 }
 
 static int cmd_filesystem_resize(const struct cmd_struct *cmd,
@@ -1213,7 +1237,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	int	fd, res, len, e;
 	char	*amount, *path;
 	DIR	*dirstream = NULL;
-	int ret;
+	int ret = 0;
 	bool enqueue = false;
 	bool cancel = false;
 
@@ -1277,10 +1301,17 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		}
 	}
 
+	amount = (char *)malloc(BTRFS_VOL_NAME_MAX);
+	if (!amount)
+		return -ENOMEM;
+
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
@@ -1298,7 +1329,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 			error("unable to resize '%s': %m", path);
 			break;
 		}
-		return 1;
+		ret = 1;
 	} else if (res > 0) {
 		const char *err_str = btrfs_err_str(res);
 
@@ -1308,9 +1339,11 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 			error("resizing of '%s' failed: unknown error %d",
 				path, res);
 		}
-		return 1;
+		ret = 1;
 	}
-	return 0;
+free_amount:
+	free(amount);
+	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
 
-- 
1.8.3.1

