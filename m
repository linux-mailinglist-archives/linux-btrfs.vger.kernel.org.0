Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15BF5854D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbiG2R4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiG2R4J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 13:56:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB51C88F08
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 10:56:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e16so5236625pfm.11
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=iIn6JmStjkrAWkQ1uvY3OmtDvbOFtqEOu3lFPOf7hHs=;
        b=gBNlAiwYu+m6LiYxklw5gVBcfvqsE84YaBbk4NC2j9gb8ujfT1tJNtnGaMldL3grk6
         EdYe4fjJoyPVoSGOe4lyugDyCvxi9gA45rVCwFsf0SNmziUh5GIsH71RtSZKunbotVrT
         O/Hir7vmILtOBztkfS1sfOqy7fK3/YAEYifJsz6KvD6jY1oOvyfoSB4v05vR7uH2uvSY
         BJ2Hz8Rz3UZnmwiOMPaT9fQT1nxSLN8CQpO9ly2wf3B/0SGkRj+X4y1sEhMQhdzBmx4t
         /uKpehwomyHUp65si8Cco3iJYG6WBO0rpHcqjzilzAkouQ8M08ZAFz80pamnyv7hIIoP
         T9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iIn6JmStjkrAWkQ1uvY3OmtDvbOFtqEOu3lFPOf7hHs=;
        b=RYW5ija6Xf9zkQdY4yH9WT+JWiL2Dd7AUb2MKD9lveKHWrkmyj6rbe1yvAmN+hgdNZ
         XASx253fpRmiNDQ+FEgc40sPV1Qh2E4JQORT5mp/dkMOhZGytXXQbDQk1l0hReNrMAuD
         GW+Wo7Umv3MQZaTQ62z5kLuo8udLiUAcj6l2sr6X9lEf3thcOXXHcdCzfDmBJC1PoKtq
         qfZNeRtKoRfgKt56IQ097GP+rPnIPyWskCmRxMEmwwK4qA5rgMK1bq64DuE8VtBkes2H
         sm/yZSxtOfYf4BdJet3NXFW+b9DarGbwMaVdDHzwMfoD3PxWvCwItLJgiB6W2mA916/B
         jfag==
X-Gm-Message-State: AJIora+nxZFjn1RQYTp378IZEizNFrnxecoFjagcgi+bI0m1mF4krOA7
        YmsEUXG/MTElIgNumJz0xwUBgVGzt3aQVieK
X-Google-Smtp-Source: AGRyM1vqWDUzYgjB2kHMtQ431y8Jv1pI37BWIzKl1IkN7LIlDzFLFf5D1tEld+4SraGl5d82zWY/xQ==
X-Received: by 2002:a63:ed07:0:b0:419:9872:62 with SMTP id d7-20020a63ed07000000b0041998720062mr3925746pgi.53.1659117367093;
        Fri, 29 Jul 2022 10:56:07 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([113.119.166.198])
        by smtp.gmail.com with ESMTPSA id f16-20020aa79690000000b00529bd84d7bcsm3134936pfk.156.2022.07.29.10.56.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 10:56:06 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH V5] btrfs-progs: fix btrfs resize failed.
Date:   Sat, 30 Jul 2022 01:55:50 +0800
Message-Id: <1659117350-3211-1-git-send-email-zhanglikernel@gmail.com>
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
btrfs will use the default devid 1, so it will report an
error when dev 1 is missing.

2. The last line of the function check_resize_args is return 0.

[FIX]
1. If the file system contains multiple devices, output an
error message to the user. If the filesystem has only one device,
resize should automatically add the unique devid.

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
ERROR: To view detailed device information, use the subcommand filesystem show.

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
Issue: 470

V1:
 * Automatically add devid if device is not specific

V2:
 * resize fails if filesystem has multiple devices

V3:
 * Fix incorrect behavior of function check_resize_args

 * Updated resize help information

V4:
 * Update man pages

V5:
 * Use safe strcpy function

 * Reduced error messages when resizing filesystems containing multiple devices

 * Use stack variable buffer

 Documentation/btrfs-filesystem.rst | 22 +++++++++++++++-------
 cmds/filesystem.c                  | 29 ++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/Documentation/btrfs-filesystem.rst b/Documentation/btrfs-filesystem.rst
index fe98597..f187f73 100644
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
index 7cd08fc..e6bc93f 100644
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
@@ -1133,6 +1138,17 @@ static int check_resize_args(const char *amount, const char *path) {
 			ret = 1;
 			goto out;
 		}
+	} else if (fi_args.num_devices != 1) {
+		error("The file system has multiple devices, please specify devid exactly.");
+		error("To view detailed device information, use the subcommand filesystem show.");
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
@@ -1200,10 +1216,11 @@ static int check_resize_args(const char *amount, const char *path) {
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
@@ -1213,9 +1230,10 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	int	fd, res, len, e;
 	char	*amount, *path;
 	DIR	*dirstream = NULL;
-	int ret;
+	int ret = 0;
 	bool enqueue = false;
 	bool cancel = false;
+	char amountbuf[BTRFS_VOL_NAME_MAX];
 
 	/*
 	 * Simplified option parser, accept only long options, the resize value
@@ -1277,6 +1295,11 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		}
 	}
 
+	memset(amountbuf, 0, BTRFS_VOL_NAME_MAX);
+	amount = amountbuf;
+
+	strncpy(amount, argv[optind], BTRFS_VOL_NAME_MAX);
+
 	ret = check_resize_args(amount, path);
 	if (ret != 0) {
 		close_file_or_dir(fd, dirstream);
-- 
1.8.3.1

