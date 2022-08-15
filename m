Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D18592F01
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 14:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiHOMh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 08:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiHOMhZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 08:37:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0783D1A3BC
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 05:37:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q16so6399727pgq.6
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mSG5zqeu+4W/1RnHG20ATdyQoFygr8VMjwClO1UiZIY=;
        b=B2x/w3+ZyBO3gN6+NcYO13L94qro/uykoF1xt7yP/YebHKrrOqey0dJ+YVjd1kUy39
         66F4Jn90N3OfO1WW2tJsub1JvUkSX3Av6oz9lErm7fcHsvUUJHrstW0PtucpXcqQhpGQ
         CaCK41gkq1FRSz2/nnChj61Nu3wjm8U5LAzbcw1a2y3S4Ukk3ZOflJUil1XQrvTvkvZF
         ZhHAatEEEeYq/KEsyZCPmYjRu5/y7rozZXNzjbI0TJb8ID10igWZ/NmDlvMZuydUYsEk
         8Bfqp3002Ke1M2o82zbmncZ8I67UppcsrTgm2ihDR8uCxG6TEh6gdX5ohZaa05xf8Kbt
         BZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mSG5zqeu+4W/1RnHG20ATdyQoFygr8VMjwClO1UiZIY=;
        b=xMNx0vM69YjsGpzaetk0jjEm23Mnsy9hhJfQPxgl6ih0cr5p3Q2nN9jNUr8wld4U+3
         nNgNq6dj55uIrD+7aKq/+4VsJ6rwdWAPaTDBKNmymuuqVmwxhzsOCdDxCr8VVniV2Z7G
         +agAc77zEMAK9z2H3qhr71FEKKB8GSumPB0nCZr5W8x9M3pugAz014NZ3mqhXKZYunij
         BKsIwv41/6grcjZ+9YTc2+ojw4KbnXqbm4DK59a7qlBur2nHfusM4mgSxS3q08LkcCFh
         piR5+k2TOB7KA60A7uZsRdq+yi61GGi3oCitOuwVysHydp/w29eHk5cailQTX3Y+zm6B
         6OCw==
X-Gm-Message-State: ACgBeo0mdSa+YBQVvSY9t6+zBwK0DSd/qykuVIfVtmDXAB7ggBEsRlKz
        N3L2uE7PSJ/fI0WTwkIDmyDizzFBfZc=
X-Google-Smtp-Source: AA6agR7YeJCJkiIGz3gO4XtIQ6whRecWmkb11HKPHy3WwfDfRko19fqli1VgGvuVIkSGyw2tVhFPZg==
X-Received: by 2002:a63:cc42:0:b0:41d:c915:ffd with SMTP id q2-20020a63cc42000000b0041dc9150ffdmr13304936pgi.161.1660567042874;
        Mon, 15 Aug 2022 05:37:22 -0700 (PDT)
Received: from realwakka-vm.. ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id i17-20020aa796f1000000b0052d46b43006sm6485533pfq.156.2022.08.15.05.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 05:37:22 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [RFC PATCH 2/2] btrfs-progs: fi resize: support all option for resize
Date:   Mon, 15 Aug 2022 12:36:52 +0000
Message-Id: <20220815123652.52314-3-realwakka@gmail.com>
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

This patch make resize command support "all" option. Also, it resolves
github issue #471. If user sets device as "all", it iterates all devices
with resizing for each device. For that, this patch make a function
do_resize_with_args() for avoiding duplicated code that call ioctl() and
handling an error.

Issue: #471

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/filesystem.c | 91 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 33 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index ea1b0c84..9ce84f8f 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1150,14 +1150,47 @@ out:
 	return ret;
 }
 
+static int do_resize_with_args(int fd, const char *amount, const char *path) {
+	int ret, e;
+	struct btrfs_ioctl_vol_args	args;
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
+		}
+		return 1;
+	} else if (ret > 0) {
+		const char *err_str = btrfs_err_str(ret);
+
+		if (err_str) {
+			error("resizing of '%s' failed: %s", path, err_str);
+		} else {
+			error("resizing of '%s' failed: unknown error %d",
+				  path, ret);
+		}
+		return 1;
+	}
+
+	return 0;
+}
+
 static int resize_with_args(const char *amount, const char *path, int fd) {
 	struct btrfs_ioctl_fs_info_args fi_args;
 	struct btrfs_ioctl_dev_info_args *di_args = NULL;
-	int ret, i, e, dev_idx = -1;
+	int ret, i, dev_idx = -1;
 	u64 devid = 1;
 	char *devstr = NULL, *sizestr = NULL;
 	char amount_dup[BTRFS_VOL_NAME_MAX];
-	struct btrfs_ioctl_vol_args	args;
 	ret = get_fs_info(path, &fi_args, &di_args);
 
 	if (ret) {
@@ -1185,13 +1218,29 @@ static int resize_with_args(const char *amount, const char *path, int fd) {
 		*devstr = 0;
 		devstr = amount_dup;
 
-		errno = 0;
-		devid = strtoull(devstr, NULL, 10);
+		if (strncmp(devstr, "all", 3) == 0) {
+			for(i = 0; i < fi_args.num_devices; i++) {
+				char amount_tmp[BTRFS_VOL_NAME_MAX];
+				devid = di_args[i].devid;
+				ret = check_resize_args_sizestr(sizestr, devid, i, di_args, &fi_args);
+				if (ret)
+					return 1;
 
-		if (errno) {
-			error("failed to parse devid %s: %m", devstr);
-			ret = 1;
-			goto out;
+				snprintf(amount_tmp, BTRFS_VOL_NAME_MAX, "%llu:%s", devid, sizestr);
+				if (do_resize_with_args(fd, amount_tmp, path))
+					return 1;
+			}
+
+			return 0;
+		} else {
+			errno = 0;
+			devid = strtoull(devstr, NULL, 10);
+
+			if (errno) {
+				error("failed to parse devid %s: %m", devstr);
+				ret = 1;
+				goto out;
+			}
 		}
 	}
 
@@ -1213,32 +1262,8 @@ static int resize_with_args(const char *amount, const char *path, int fd) {
 	if (ret)
 		return 1;
 
-	memset(&args, 0, sizeof(args));
-	strncpy_null(args.name, amount);
-	ret = ioctl(fd, BTRFS_IOC_RESIZE, &args);
-	e = errno;
-	if(ret < 0){
-		switch (e) {
-		case EFBIG:
-			error("unable to resize '%s': no enough free space",
-				  path);
-			break;
-		default:
-			error("unable to resize '%s': %m", path);
-			break;
-		}
-		return 1;
-	} else if (ret > 0) {
-		const char *err_str = btrfs_err_str(ret);
-
-		if (err_str) {
-			error("resizing of '%s' failed: %s", path, err_str);
-		} else {
-			error("resizing of '%s' failed: unknown error %d",
-				  path, ret);
-		}
+	if (do_resize_with_args(fd, amount, path))
 		return 1;
-	}
 
 out:
 	free(di_args);
-- 
2.34.1

