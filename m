Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE759FF10
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbiHXQFf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 12:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbiHXQFe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 12:05:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE057E028
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 09:05:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c2so16069955plo.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=vIUxegVXpOdPZMqlNzbCESVzc/7/UqsExQK+66MjeJE=;
        b=f7W5+9xeHF9RuTYR20/en8I7XN7CZwA/3Sl/SvK8CDatw2vTyOe8puErt3aJp0B1af
         nGiLve9hT07tr8v+e1WT+ie7PmcTEPsvS5pOEmvRDqY+DFPf24kvDcLurYH8FWogjvP0
         WiS0Tfat5NL5CxGRYFN2M452vndJ/Qg0t91wQWz+lRDQy6JR1tFB7OcWIykeMxb+0VvF
         6Bg4+Ep53+om5/d4qnQYQpuQj/IDH9LAxtvyOhsQnnlmukoLD6oe+Zvtxhn1fNfNZbO4
         5ekkWVOqWEImtxvcyGHcyRlQC8sFngPAA2HNhHvaWXkIbVmYkaa8jYgdOUbDOzlJiBqe
         FJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vIUxegVXpOdPZMqlNzbCESVzc/7/UqsExQK+66MjeJE=;
        b=l6QcYFox3Rir3CEl2WgKRMR3orfuiP+LPV8rCMB37jED0rzgjXV7kwVmrxFi7x+q6+
         AUB2lCbAkqUT1TU/TMRQuTgKcMwFYV3L71gM1YIxP42FgMP8JHglVun3JOGIovViDkQD
         OGx86N/jZjVFkN+HFWublN2UsO5rvC3qkPeAdON6AoXxEfETCi7l67owcLul3MV2C+ZV
         nAKW/CGeBk6Pm/Bg61lYqNpdDJMyL+B6yiCpwWiIJX7eFPhNtJh2DDlgZZdBg33Iym0B
         QU3tI4YnVkgvUeHcneWPawTuqIIx7GOm9zJJ9Je0MtwgllH4kxMTS4NsFeSgLA+PAy7P
         u/+A==
X-Gm-Message-State: ACgBeo2r31mYCtNowjGhZY+nIcppD/qL/xvA03itFfvZDjE1tv66C7+c
        pqvmSLqtNXu00iGzFK4jcjDR887+NCIboA==
X-Google-Smtp-Source: AA6agR7w+pK8hj5CG/TURrfBFpmEMn+eSjJHFqno/sGCwaJjp3z8kPggIpdZDODjOGybvb1cBiLM5w==
X-Received: by 2002:a17:902:8643:b0:172:e067:d7ac with SMTP id y3-20020a170902864300b00172e067d7acmr16598511plt.164.1661357132623;
        Wed, 24 Aug 2022 09:05:32 -0700 (PDT)
Received: from zllke.localdomain ([219.137.95.129])
        by smtp.gmail.com with ESMTPSA id f184-20020a6238c1000000b00536b3fe1300sm6527130pfa.13.2022.08.24.09.05.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2022 09:05:32 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
Date:   Thu, 25 Aug 2022 00:05:03 +0800
Message-Id: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
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

 mkfs/main.c | 113 +++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 86 insertions(+), 27 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index ce096d3..35fefe2 100644
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
@@ -60,6 +61,18 @@ struct mkfs_allocation {
 	u64 system;
 };
 
+
+struct prepare_device_progress {
+	char *file;
+	u64 dev_block_count;
+	u64 block_count;
+	bool zero_end;
+	bool discard;
+	bool zoned;
+	int oflags;
+	int ret;
+};
+
 static int create_metadata_block_groups(struct btrfs_root *root, bool mixed,
 				struct mkfs_allocation *allocation)
 {
@@ -969,6 +982,28 @@ fail:
 	return ret;
 }
 
+static void *prepare_one_dev(void *ctx)
+{
+	struct prepare_device_progress *prepare_ctx = ctx;
+	int fd;
+
+	fd = open(prepare_ctx->file, prepare_ctx->oflags);
+	if (fd < 0) {
+		error("unable to open %s: %m", prepare_ctx->file);
+		prepare_ctx->ret = fd;
+		return NULL;
+	}
+	prepare_ctx->ret = btrfs_prepare_device(fd,
+		prepare_ctx->file, &prepare_ctx->dev_block_count,
+		prepare_ctx->block_count,
+		(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
+		(prepare_ctx->zero_end ? PREP_DEVICE_ZERO_END : 0) |
+		(prepare_ctx->discard ? PREP_DEVICE_DISCARD : 0) |
+		(prepare_ctx->zoned ? PREP_DEVICE_ZONED : 0));
+	close(fd);
+	return NULL;
+}
+
 int BOX_MAIN(mkfs)(int argc, char **argv)
 {
 	char *file;
@@ -997,7 +1032,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	bool ssd = false;
 	bool zoned = false;
 	bool force_overwrite = false;
-	int oflags;
 	char *source_dir = NULL;
 	bool source_dir_set = false;
 	bool shrink_rootdir = false;
@@ -1006,6 +1040,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 shrink_size;
 	int dev_cnt = 0;
 	int saved_optind;
+	pthread_t *t_prepare = NULL;
+	struct prepare_device_progress *prepare_ctx = NULL;
 	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
 	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
 	u64 runtime_features = BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
@@ -1428,29 +1464,45 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	dev_cnt--;
-
-	oflags = O_RDWR;
-	if (zoned && zoned_model(file) == ZONED_HOST_MANAGED)
-		oflags |= O_DIRECT;
+	t_prepare = malloc(dev_cnt * sizeof(*t_prepare));
+	prepare_ctx = malloc(dev_cnt * sizeof(*prepare_ctx));
 
-	/*
-	 * Open without O_EXCL so that the problem should not occur by the
-	 * following operation in kernel:
-	 * (btrfs_register_one_device() fails if O_EXCL is on)
-	 */
-	fd = open(file, oflags);
-	if (fd < 0) {
-		error("unable to open %s: %m", file);
+	if (!t_prepare || !prepare_ctx) {
+		error("unable to prepare dev");
 		goto error;
 	}
-	ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
-			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
-			(discard ? PREP_DEVICE_DISCARD : 0) |
-			(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
-			(zoned ? PREP_DEVICE_ZONED : 0));
+
+	for (i = 0; i < dev_cnt; i++) {
+		prepare_ctx[i].file = argv[optind + i - 1];
+		prepare_ctx[i].block_count = block_count;
+		prepare_ctx[i].dev_block_count = block_count;
+		prepare_ctx[i].zero_end = zero_end;
+		prepare_ctx[i].discard = discard;
+		prepare_ctx[i].zoned = zoned;
+		if (i == 0) {
+			prepare_ctx[i].oflags = O_RDWR;
+			/*
+			 * Open without O_EXCL so that the problem should
+			 * not occur by the following operation in kernel:
+			 * (btrfs_register_one_device() fails if O_EXCL is on)
+			 */
+			if (zoned && zoned_model(file) == ZONED_HOST_MANAGED)
+				prepare_ctx[i].oflags = O_RDWR | O_DIRECT;
+		} else {
+			prepare_ctx[i].oflags = O_RDWR;
+		}
+		ret = pthread_create(&t_prepare[i], NULL,
+			prepare_one_dev, &prepare_ctx[i]);
+	}
+	pthread_join(t_prepare[0], NULL);
+	ret = prepare_ctx[0].ret;
+
 	if (ret)
 		goto error;
+
+	dev_cnt--;
+	fd = open(file, prepare_ctx[0].oflags);
+	dev_block_count = prepare_ctx[0].dev_block_count;
 	if (block_count && block_count > dev_block_count) {
 		error("%s is smaller than requested size, expected %llu, found %llu",
 		      file, (unsigned long long)block_count,
@@ -1459,7 +1511,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	/* To create the first block group and chunk 0 in make_btrfs */
-	system_group_size = zoned ?  zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+	system_group_size = zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
 	if (dev_block_count < system_group_size) {
 		error("device is too small to make filesystem, must be at least %llu",
 				(unsigned long long)system_group_size);
@@ -1557,6 +1609,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (dev_cnt == 0)
 		goto raid_groups;
 
+	for (i = 0 ; i < dev_cnt; i++) {
+		pthread_join(t_prepare[i+1], NULL);
+		if (prepare_ctx[i+1].ret) {
+			goto error;
+		}
+	}
 	while (dev_cnt-- > 0) {
 		file = argv[optind++];
 
@@ -1578,12 +1636,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			close(fd);
 			continue;
 		}
-		ret = btrfs_prepare_device(fd, file, &dev_block_count,
-				block_count,
-				(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
-				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
-				(discard ? PREP_DEVICE_DISCARD : 0) |
-				(zoned ? PREP_DEVICE_ZONED : 0));
+		dev_block_count = prepare_ctx[argc - saved_optind - dev_cnt - 1]
+			.dev_block_count;
+
 		if (ret) {
 			goto error;
 		}
@@ -1763,12 +1818,16 @@ out:
 
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

