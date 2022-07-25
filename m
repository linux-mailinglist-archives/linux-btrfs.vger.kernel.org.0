Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF90580311
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiGYQq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 12:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGYQq1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 12:46:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AABBE21
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 09:46:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gn24so11010794pjb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4zh0SQetwnjoYdYI62t/84plvMRr+VwCO79KczlrBu0=;
        b=OIAoDlk4j6N5gRUSsMImI8Ud/ju5cxZ+t5AZAsvh0U3xAQOOBS0wzZamfPkLRLG/eu
         SJWlvS16s684cNte8ZYKCqK2ckOJ+jJr+N6vGgVmBLUnjRyW/bWFxkKOyXwSerzDvCNE
         VhxOK4Lsyp56hySYYDLSgd20Y+7T2WKShhmjttLCdnhYFFFGYW8xXg5GlGmo3x+P352H
         Mrwt/qd0Wi1ifA3TBl9aPR9yzBRvItSt4H2hPsOA4/NNFwTpPCoMFRJ3si1Ujd44BBIA
         9gKgDpwzGsMQYxOSWeSQn3IHJIyuoNpKf6wdB1vR4E8TfdlBSwugOgbiErIRBoRvvL8Z
         jUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4zh0SQetwnjoYdYI62t/84plvMRr+VwCO79KczlrBu0=;
        b=zDvP6cfmFJXZdDfgHN6zJnUMAlml85tXOjtnl3uQ44VthPCb9qSodvKssswB0evxKx
         BL6c2sRfX3nSti2rX4B7VStdTb9fABqQz0L85ktQWkKSr4dnbAEz0bz4DPsoq8Vm9Jaj
         2m5e0RF8gcw7sVAi2rFUg4TUspz9Z4tUsakzxsJy3G0Y7OCI17KWr1/Ly3eIymE+HJxN
         vhKAoGaMoWHFP2w6/K5EAL04nOlE7GWRRfr5q1hiTIo5ZZbLLXtlp507IhyPxy1gmuI/
         VWq888Idu4V5bmMQpjHvJxbmAdkpTOfo7WHwyHvlD7TjdeBVhzjbd9FZKdwY4tb7t1vO
         XVgQ==
X-Gm-Message-State: AJIora/AcxoQU6SzmGjrnf92trBXd7hOpVLxWFxrm5U0m0lklP5rrZaD
        qKijhUu5Wr9ThYL7IG2GtIdNPk3XpFCQZw==
X-Google-Smtp-Source: AGRyM1t34QZq5Tjsy/3AlGM+R4Pl5Xu945MVntw+VPdscBLWiP7fzI0RVogTHzT29K/EGbi8lRXCiA==
X-Received: by 2002:a17:90b:4c52:b0:1f2:c763:5303 with SMTP id np18-20020a17090b4c5200b001f2c7635303mr3861519pjb.21.1658767585909;
        Mon, 25 Jul 2022 09:46:25 -0700 (PDT)
Received: from zllke.localdomain ([219.137.143.85])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b0016d05661f00sm9708989plh.189.2022.07.25.09.46.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:46:25 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH V4] btrfs-progs: fix btrfs resize failed.
Date:   Tue, 26 Jul 2022 00:46:14 +0800
Message-Id: <1658767574-16160-1-git-send-email-zhanglikernel@gmail.com>
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

Issue: 470

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
V1:
 * Automatically add devid if device is not specific

V2:
 * resize fails if filesystem has multiple devices

V3:
 * Fix incorrect behavior of function check_resize_args

 * Updated resize help information

V4:
 * Update man pages
 Documentation/btrfs-filesystem.rst | 22 ++++++++++++------
 cmds/filesystem.c                  | 47 ++++++++++++++++++++++++++++++++------
 2 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/Documentation/btrfs-filesystem.rst b/Documentation/btrfs-filesystem.rst
index fe98597..5b3f2e2 100644
--- a/Documentation/btrfs-filesystem.rst
+++ b/Documentation/btrfs-filesystem.rst
@@ -197,8 +197,11 @@ resize [options] [<devid>:][+/-]<size>[kKmMgGtTpPeE]|[<devid>:]max <path>
                 as expected and does not resize the image. This would resize the underlying
                 filesystem instead.
 
-        The *devid* can be found in the output of **btrfs filesystem show** and
-        defaults to 1 if not specified.
+        The *devid* can be found in the output of **btrfs filesystem show**.
+
+        If the filesystem contains only one device, it can be
+        resized without specifying a specific device.
+
         The *size* parameter specifies the new size of the filesystem.
         If the prefix *+* or *-* is present the size is increased or decreased
         by the quantity *size*.
@@ -208,7 +211,7 @@ resize [options] [<devid>:][+/-]<size>[kKmMgGtTpPeE]|[<devid>:]max <path>
         KiB, MiB, GiB, TiB, PiB, or EiB, respectively (case does not matter).
 
         If *max* is passed, the filesystem will occupy all available space on the
-        device respecting *devid* (remember, devid 1 by default).
+        device respecting *devid*.
 
         The resize command does not manipulate the size of underlying
         partition.  If you wish to enlarge/reduce a filesystem, you must make sure you
@@ -413,14 +416,19 @@ even if run repeatedly.
 
 **$ btrfs filesystem resize -1G /path**
 
+Let's assume that filesystem contains only one device.
+Shrink size of the filesystem's single-device by 1GiB.
+
+
 **$ btrfs filesystem resize 1:-1G /path**
 
-Shrink size of the filesystem's device id 1 by 1GiB. The first syntax expects a
-device with id 1 to exist, otherwise fails. The second is equivalent and more
-explicit. For a single-device filesystem it's typically not necessary to
-specify the devid though.
+Shrink size of the filesystem's device id 1 by 1GiB. This command expects a
+device with id 1 to exist, otherwise fails.
 
 **$ btrfs filesystem resize max /path**
+Let's assume that filesystem contains only one device and the filesystem
+does not occupy the whole block device,By simply using *max* as size we
+will achieve that.
 
 **$ btrfs filesystem resize 1:max /path**
 
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

