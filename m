Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1565A3E0C
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Aug 2022 16:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiH1Oax (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Aug 2022 10:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH1Oav (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Aug 2022 10:30:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C816E1D31A
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Aug 2022 07:30:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bh13so5569547pgb.4
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Aug 2022 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=YCFcCM8t98NXuzQnTTx+PghMeYY7mXWRQT6NmMT9a2Y=;
        b=kwuFhuPqlDy2dEegPFMN5HfFzPjJoq0PAOlCvRgbogWM6aFOjfuGeSnarY31hwREki
         X3qa2TpfOYEUJewdr/7/xdyUFJm7ijRnyLor6lOISFdcyjfHBugGWt4mySPeOI7bCR21
         AWDX/VQj79ZkScPEVfenHJqel6rIfxNDuCcsS+QMnSTYnISewcHIIEeVUpFw4ub5FBEI
         ZV/JgI2Af6fTVIkSdMgMLjp0Bq32Viomx2fNLJuL3dI1GlPSABa2ZCZXGsgX/iB/Xwlh
         08Worin/IyULPItPnHTq+7daEbs5bAs4n0LChJ+0zg6cNaBrw5HBA13APxFO3b67I0Jg
         WHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YCFcCM8t98NXuzQnTTx+PghMeYY7mXWRQT6NmMT9a2Y=;
        b=a9/p7irnkLjgZbxOfQiK7qZPE36Q5yvJvofESvhppB1EZcW96I2yUoJq/TZfxF0JIx
         a9YY9LljHcUHNJdALqqKMapnQxxWEZit23B2mFozBG41YS316yJviHgFfwsY9x8HE5n0
         Ga8IYnPhzSpy1+8n0/ejABbM2PC6y7wCcdhzU7oPSb8OfLhRnTnHG73ZKB5+qfeRTS9a
         snzC9wu8rHvMjiDffc0dRVmpzTMZ7IcaK3Z2/fUYh2URzgOxqg7VD9sF0fVWziUJQrJS
         7B+kYnRl6gpDr3dG/7HmBgblLpvIS5ddzxlFGz8/AqQiDwaeJZ2qGTrvx4sRyk4nv6kA
         Gr3A==
X-Gm-Message-State: ACgBeo2LdKjbGq169/TKqezXsOyFf1fPKe/mNC/jdciKyA1TS0TNy/HK
        u7hTM8BuQAmS6r9g0IzSaDOdBIOmEN/sHg==
X-Google-Smtp-Source: AA6agR7M8U7L4d5gPdjcefXp0rG6Tp1y8c/DqsIVnOC+wZThM7DSUT+Fhc7kOUsNpPbvLU4u7/6U/Q==
X-Received: by 2002:a05:6a00:13a7:b0:538:39fc:ddc0 with SMTP id t39-20020a056a0013a700b0053839fcddc0mr1075219pfg.8.1661697049022;
        Sun, 28 Aug 2022 07:30:49 -0700 (PDT)
Received: from zllke.localdomain ([113.99.5.102])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b001709b9d292esm5398336plg.268.2022.08.28.07.30.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:30:48 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH V2] Make btrfs_prepare_device parallel during mkfs.btrfs
Date:   Sun, 28 Aug 2022 22:30:00 +0800
Message-Id: <1661697000-18809-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[enhancement]
When a disk is formatted as btrfs, it calls
btrfs_prepare_device for each device, which takes too much time.

[implementation]
Put each btrfs_prepare_device into a thread,
wait for the first thread to complete to mkfs.btrfs,
and wait for other threads to complete before adding
other devices to the file system.

[test]
Using the btrfs-progs test case mkfs-tests, mkfs.btrfs works fine.

But I don't have an actual zoed device,
so I don't know how much time it saves, If you guys
have a way to test it, please let me know.

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
Issue: 496

V1:
* Put btrfs_prepare_device into threads and make them parallel

V2:
* Set the 4 variables used by btrfs_prepare_device as global variables.
* Use pthread_mutex to ensure error messages are not messed up.
* Correct the error message
* Wait for all threads to exit in a loop

 mkfs/main.c | 132 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 95 insertions(+), 37 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index ce096d3..b111f12 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -31,6 +31,7 @@
 #include <uuid/uuid.h>
 #include <ctype.h>
 #include <blkid/blkid.h>
+#include <pthread.h>
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/free-space-tree.h"
@@ -60,6 +61,20 @@ struct mkfs_allocation {
 	u64 system;
 };
 
+static bool zero_end;
+static bool discard;
+static bool zoned;
+static int oflags;
+
+static pthread_mutex_t prepare_mutex;
+
+struct prepare_device_progress {
+	char *file;
+	u64 dev_block_count;
+	u64 block_count;
+	int ret;
+};
+
 static int create_metadata_block_groups(struct btrfs_root *root, bool mixed,
 				struct mkfs_allocation *allocation)
 {
@@ -969,6 +984,30 @@ fail:
 	return ret;
 }
 
+static void *prepare_one_dev(void *ctx)
+{
+	struct prepare_device_progress *prepare_ctx = ctx;
+	int fd;
+
+	fd = open(prepare_ctx->file, oflags);
+	if (fd < 0) {
+		pthread_mutex_lock(&prepare_mutex);
+		error("unable to open %s: %m", prepare_ctx->file);
+		pthread_mutex_unlock(&prepare_mutex);
+		prepare_ctx->ret = fd;
+		return NULL;
+	}
+	prepare_ctx->ret = btrfs_prepare_device(fd,
+		prepare_ctx->file, &prepare_ctx->dev_block_count,
+		prepare_ctx->block_count,
+		(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
+		(zero_end ? PREP_DEVICE_ZERO_END : 0) |
+		(discard ? PREP_DEVICE_DISCARD : 0) |
+		(zoned ? PREP_DEVICE_ZONED : 0));
+	close(fd);
+	return NULL;
+}
+
 int BOX_MAIN(mkfs)(int argc, char **argv)
 {
 	char *file;
@@ -984,7 +1023,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u32 nodesize = 0;
 	u32 sectorsize = 0;
 	u32 stripesize = 4096;
-	bool zero_end = true;
+	zero_end = true;
 	int fd = -1;
 	int ret = 0;
 	int close_ret;
@@ -993,11 +1032,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	bool nodesize_forced = false;
 	bool data_profile_opt = false;
 	bool metadata_profile_opt = false;
-	bool discard = true;
+	discard = true;
 	bool ssd = false;
-	bool zoned = false;
+	zoned = false;
 	bool force_overwrite = false;
-	int oflags;
 	char *source_dir = NULL;
 	bool source_dir_set = false;
 	bool shrink_rootdir = false;
@@ -1006,6 +1044,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 shrink_size;
 	int dev_cnt = 0;
 	int saved_optind;
+	pthread_t *t_prepare = NULL;
+	struct prepare_device_progress *prepare_ctx = NULL;
 	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
 	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
 	u64 runtime_features = BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
@@ -1428,29 +1468,49 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	dev_cnt--;
+	t_prepare = calloc(dev_cnt, sizeof(*t_prepare));
+	prepare_ctx = calloc(dev_cnt, sizeof(*prepare_ctx));
+
+	if (!t_prepare || !prepare_ctx) {
+		error("unable to alloc thread for preparing dev");
+		goto error;
+	}
 
+	pthread_mutex_init(&prepare_mutex, NULL);
+	zero_end = zero_end;
+	discard = discard;
+	zoned = zoned;
 	oflags = O_RDWR;
-	if (zoned && zoned_model(file) == ZONED_HOST_MANAGED)
-		oflags |= O_DIRECT;
+	for (i = 0; i < dev_cnt; i++) {
+		if (zoned && zoned_model(argv[optind + i - 1]) ==
+			ZONED_HOST_MANAGED) {
+			oflags |= O_DIRECT;
+			break;
+		}
+	}
+	for (i = 0; i < dev_cnt; i++) {
+		prepare_ctx[i].file = argv[optind + i - 1];
+		prepare_ctx[i].block_count = block_count;
+		prepare_ctx[i].dev_block_count = block_count;
+		ret = pthread_create(&t_prepare[i], NULL,
+			prepare_one_dev, &prepare_ctx[i]);
+		if (ret) {
+			error("create thread for prepare devices failed, errno:%d", ret);
+			goto error;
+		}
+	}
+	for (i = 0; i < dev_cnt; i++)
+		pthread_join(t_prepare[i], NULL);
+	ret = prepare_ctx[0].ret;
 
-	/*
-	 * Open without O_EXCL so that the problem should not occur by the
-	 * following operation in kernel:
-	 * (btrfs_register_one_device() fails if O_EXCL is on)
-	 */
-	fd = open(file, oflags);
-	if (fd < 0) {
-		error("unable to open %s: %m", file);
+	if (ret) {
+		error("unable prepare device:%s.\n", prepare_ctx[0].file);
 		goto error;
 	}
-	ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
-			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
-			(discard ? PREP_DEVICE_DISCARD : 0) |
-			(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
-			(zoned ? PREP_DEVICE_ZONED : 0));
-	if (ret)
-		goto error;
+
+	dev_cnt--;
+	fd = open(file, oflags);
+	dev_block_count = prepare_ctx[0].dev_block_count;
 	if (block_count && block_count > dev_block_count) {
 		error("%s is smaller than requested size, expected %llu, found %llu",
 		      file, (unsigned long long)block_count,
@@ -1459,7 +1519,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	/* To create the first block group and chunk 0 in make_btrfs */
-	system_group_size = zoned ?  zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+	system_group_size = zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
 	if (dev_block_count < system_group_size) {
 		error("device is too small to make filesystem, must be at least %llu",
 				(unsigned long long)system_group_size);
@@ -1558,14 +1618,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto raid_groups;
 
 	while (dev_cnt-- > 0) {
+		int dev_index = argc - saved_optind - dev_cnt - 1;
 		file = argv[optind++];
 
-		/*
-		 * open without O_EXCL so that the problem should not
-		 * occur by the following processing.
-		 * (btrfs_register_one_device() fails if O_EXCL is on)
-		 */
-		fd = open(file, O_RDWR);
+		fd = open(file, oflags);
 		if (fd < 0) {
 			error("unable to open %s: %m", file);
 			goto error;
@@ -1578,13 +1634,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			close(fd);
 			continue;
 		}
-		ret = btrfs_prepare_device(fd, file, &dev_block_count,
-				block_count,
-				(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
-				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
-				(discard ? PREP_DEVICE_DISCARD : 0) |
-				(zoned ? PREP_DEVICE_ZONED : 0));
-		if (ret) {
+		dev_block_count = prepare_ctx[dev_index]
+			.dev_block_count;
+
+		if (prepare_ctx[dev_index].ret) {
+			error("unable prepare device:%s.\n", prepare_ctx[dev_index].file);
 			goto error;
 		}
 
@@ -1763,12 +1817,16 @@ out:
 
 	btrfs_close_all_devices();
 	free(label);
-
+	free(t_prepare);
+	free(prepare_ctx);
 	return !!ret;
+
 error:
 	if (fd > 0)
 		close(fd);
 
+	free(t_prepare);
+	free(prepare_ctx);
 	free(label);
 	exit(1);
 success:
-- 
1.8.3.1

