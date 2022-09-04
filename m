Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B05AC36C
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiIDIZr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 04:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDIZq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 04:25:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095402ED75
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 01:25:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d12so5828281plr.6
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Sep 2022 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HQAoQoG4JfETB9EGmyMzsPsQ7BBzLoooAKmSadnz2A4=;
        b=lAHbl1PPni6xsyU2PX2V2jhXNQE96m0KsEl008RgkELv2Iuk75CmWPKaSK7RiOI9q/
         gN2aRqoLgWK/NNB6BlCb9krEg4LdF2XrI3mai71jLtxbM4DPklJbJr/S+Br0+Jun1WmZ
         +SQHo1i2BescS2h62Mg6XR410o6S7Cl3HGJ7Dc1eOR07/k2uWrszNjwx8ViFPyrZhwMn
         Gp1W5BWox/5yN+G2tamLvbD6IOUpUz28D9AtAj0jP4MQ6UdjBa2gfyLY28lm/hEwBXT6
         a0kUQjbILBrVBbQeNR92V6TaaarE5olnHzLKSVgZhFkTV1YC8oYS3z38ANf1cxH+icER
         0B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HQAoQoG4JfETB9EGmyMzsPsQ7BBzLoooAKmSadnz2A4=;
        b=ONkhEIM90DA6IFT5+YCqLgs9LbGGeytWWaF5BQ1BIVdrnGCxmW8oL3iXAYCBpxRL7o
         b/3sqDFeEa1kX7064cs9CTInmAaVic5WJf4R9Z/M0CY0nlKC6JE+WVPqEDSzJIvyLOFy
         bmtJIMwNQgTHtlhTMigzrZl9Jq8fUqCHFvMTbp69m/jutsLTN7LBKFCiQvW2M45E1jhB
         dbHohHrBpDNfq7lS+L05D4Axpd/x8ijjdEZmdncKQmY1cYKDrw5jBjxcgpc/cGtCkOno
         UgoG6rSTXWjSwZZGK6wBp+Eycke3pzN+pIPSU8N+cqzR6C/XSY2IoIh47k6LLtXm/HMe
         xCmQ==
X-Gm-Message-State: ACgBeo0k9K18jkDawKlfSIhDHcXn5zDOMD2vLypxSKQUTE1GUsVAgNSH
        zmmoGyrz+BfmU2pXvHIvvAlmC/3AkNFEmg==
X-Google-Smtp-Source: AA6agR7vKlELVLv5ISMsM9sEQL0Wzrr36ioS/T7suBDE9N1wnAjrRH4n5UB7iUgLvvLTxII5U3PLyg==
X-Received: by 2002:a17:902:8d8c:b0:172:e237:9a4e with SMTP id v12-20020a1709028d8c00b00172e2379a4emr43763487plo.158.1662279943199;
        Sun, 04 Sep 2022 01:25:43 -0700 (PDT)
Received: from zllke.localdomain ([219.137.141.186])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b0016f975be2e7sm4943542plh.139.2022.09.04.01.25.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Sep 2022 01:25:42 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH V4] btrfs-progs: Make btrfs_prepare_device parallel during mkfs.btrfs
Date:   Sun,  4 Sep 2022 16:24:23 +0800
Message-Id: <1662279863-17114-1-git-send-email-zhanglikernel@gmail.com>
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

Use tcmu-runner emulation to simulate two devices for testing.
Each device is 2000G (about 19.53 TiB), the region size is 4MB,
Use the following parameters for targetcli
create name=zbc0 size=20000G cfgstring=model-HM/zsize-4/conv-100@~/zbc0.raw

Call difftime to calculate the running time of the function btrfs_prepare_device.
Calculate the time from thread creation to completion of all threads after
patching (time calculation is not included in patch submission)
The test results are as follows.

$ lsscsi -p
[10:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdb   -          none
[11:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdc   -          none

$ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
....
time for prepare devices:4.000000.
....

$ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
...
time for prepare devices:2.000000.
...

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

V3:
* Add prefix opt to the global variables
* Format code
* Add error handler for open

V4:
* initialize the global options

 mkfs/main.c | 154 +++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 107 insertions(+), 47 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index ce096d3..3e16a0e 100644
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
 
+static bool opt_zero_end = true;
+static bool opt_discard = true;
+static bool opt_zoned = true;
+static int opt_oflags = O_RDONLY;
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
@@ -969,6 +984,31 @@ fail:
 	return ret;
 }
 
+static void *prepare_one_dev(void *ctx)
+{
+	struct prepare_device_progress *prepare_ctx = ctx;
+	int fd;
+
+	fd = open(prepare_ctx->file, opt_oflags);
+	if (fd < 0) {
+		pthread_mutex_lock(&prepare_mutex);
+		error("unable to open %s: %m", prepare_ctx->file);
+		pthread_mutex_unlock(&prepare_mutex);
+		prepare_ctx->ret = fd;
+		return NULL;
+	}
+	prepare_ctx->ret = btrfs_prepare_device(fd,
+			prepare_ctx->file,
+			&prepare_ctx->dev_block_count,
+			prepare_ctx->block_count,
+			(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
+			(opt_zero_end ? PREP_DEVICE_ZERO_END : 0) |
+			(opt_discard ? PREP_DEVICE_DISCARD : 0) |
+			(opt_zoned ? PREP_DEVICE_ZONED : 0));
+	close(fd);
+	return NULL;
+}
+
 int BOX_MAIN(mkfs)(int argc, char **argv)
 {
 	char *file;
@@ -984,7 +1024,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u32 nodesize = 0;
 	u32 sectorsize = 0;
 	u32 stripesize = 4096;
-	bool zero_end = true;
 	int fd = -1;
 	int ret = 0;
 	int close_ret;
@@ -993,11 +1032,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	bool nodesize_forced = false;
 	bool data_profile_opt = false;
 	bool metadata_profile_opt = false;
-	bool discard = true;
 	bool ssd = false;
-	bool zoned = false;
 	bool force_overwrite = false;
-	int oflags;
 	char *source_dir = NULL;
 	bool source_dir_set = false;
 	bool shrink_rootdir = false;
@@ -1006,6 +1042,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 shrink_size;
 	int dev_cnt = 0;
 	int saved_optind;
+	pthread_t *t_prepare = NULL;
+	struct prepare_device_progress *prepare_ctx = NULL;
 	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
 	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
 	u64 runtime_features = BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
@@ -1126,7 +1164,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				break;
 			case 'b':
 				block_count = parse_size_from_string(optarg);
-				zero_end = false;
+				opt_zero_end = false;
 				break;
 			case 'v':
 				bconf_be_verbose();
@@ -1144,7 +1182,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					BTRFS_UUID_UNPARSED_SIZE - 1);
 				break;
 			case 'K':
-				discard = false;
+				opt_discard = false;
 				break;
 			case 'q':
 				bconf_be_quiet();
@@ -1183,7 +1221,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (dev_cnt == 0)
 		print_usage(1);
 
-	zoned = !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
+	opt_zoned = !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
 
 	if (source_dir_set && dev_cnt > 1) {
 		error("the option -r is limited to a single device");
@@ -1225,7 +1263,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	file = argv[optind++];
 	ssd = is_ssd(file);
-	if (zoned) {
+	if (opt_zoned) {
 		if (!zone_size(file)) {
 			error("zoned: %s: zone size undefined", file);
 			exit(1);
@@ -1235,7 +1273,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			printf(
 	"Zoned: %s: host-managed device detected, setting zoned feature\n",
 			       file);
-		zoned = true;
+		opt_zoned = true;
 		features |= BTRFS_FEATURE_INCOMPAT_ZONED;
 	}
 
@@ -1302,7 +1340,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
-	if (zoned) {
+	if (opt_zoned) {
 		if (source_dir_set) {
 			error("the option -r and zoned mode are incompatible");
 			exit(1);
@@ -1392,7 +1430,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	 * 1 zone for a metadata block group
 	 * 1 zone for a data block group
 	 */
-	if (zoned && block_count && block_count < 5 * zone_size(file)) {
+	if (opt_zoned && block_count && block_count < 5 * zone_size(file)) {
 		error("size %llu is too small to make a usable filesystem",
 			block_count);
 		error("minimum size for a zoned btrfs filesystem is %llu",
@@ -1422,35 +1460,58 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (ret)
 		goto error;
 
-	if (zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA | metadata_profile) ||
+	if (opt_zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA | metadata_profile) ||
 		      !zoned_profile_supported(BTRFS_BLOCK_GROUP_DATA | data_profile))) {
 		error("zoned mode does not yet support RAID/DUP profiles, please specify '-d single -m single' manually");
 		goto error;
 	}
 
-	dev_cnt--;
+	t_prepare = calloc(dev_cnt, sizeof(*t_prepare));
+	prepare_ctx = calloc(dev_cnt, sizeof(*prepare_ctx));
 
-	oflags = O_RDWR;
-	if (zoned && zoned_model(file) == ZONED_HOST_MANAGED)
-		oflags |= O_DIRECT;
+	if (!t_prepare || !prepare_ctx) {
+		error("unable to alloc thread for preparing dev");
+		goto error;
+	}
 
-	/*
-	 * Open without O_EXCL so that the problem should not occur by the
-	 * following operation in kernel:
-	 * (btrfs_register_one_device() fails if O_EXCL is on)
-	 */
-	fd = open(file, oflags);
+	pthread_mutex_init(&prepare_mutex, NULL);
+	opt_oflags = O_RDWR;
+	for (i = 0; i < dev_cnt; i++) {
+		if (opt_zoned && zoned_model(argv[optind + i - 1]) ==
+			ZONED_HOST_MANAGED) {
+			opt_oflags |= O_DIRECT;
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
+			error("create thread for prepare devices: %s failed, "
+					"errno: %d",
+					prepare_ctx[i].file, ret);
+			goto error;
+		}
+	}
+	for (i = 0; i < dev_cnt; i++)
+		pthread_join(t_prepare[i], NULL);
+	ret = prepare_ctx[0].ret;
+
+	if (ret) {
+		error("unable prepare device: %s\n", prepare_ctx[0].file);
+		goto error;
+	}
+
+	dev_cnt--;
+	fd = open(file, opt_oflags);
 	if (fd < 0) {
 		error("unable to open %s: %m", file);
 		goto error;
 	}
-	ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
-			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
-			(discard ? PREP_DEVICE_DISCARD : 0) |
-			(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
-			(zoned ? PREP_DEVICE_ZONED : 0));
-	if (ret)
-		goto error;
+	dev_block_count = prepare_ctx[0].dev_block_count;
 	if (block_count && block_count > dev_block_count) {
 		error("%s is smaller than requested size, expected %llu, found %llu",
 		      file, (unsigned long long)block_count,
@@ -1459,7 +1520,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	/* To create the first block group and chunk 0 in make_btrfs */
-	system_group_size = zoned ?  zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+	system_group_size = opt_zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
 	if (dev_block_count < system_group_size) {
 		error("device is too small to make filesystem, must be at least %llu",
 				(unsigned long long)system_group_size);
@@ -1487,7 +1548,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.runtime_features = runtime_features;
 	mkfs_cfg.csum_type = csum_type;
 	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
-	if (zoned)
+	if (opt_zoned)
 		mkfs_cfg.zone_size = zone_size(file);
 	else
 		mkfs_cfg.zone_size = 0;
@@ -1558,14 +1619,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
+		fd = open(file, opt_oflags);
 		if (fd < 0) {
 			error("unable to open %s: %m", file);
 			goto error;
@@ -1578,13 +1635,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
+			error("unable prepare device: %s.\n",
+					prepare_ctx[dev_index].file);
 			goto error;
 		}
 
@@ -1714,8 +1770,8 @@ raid_groups:
 			btrfs_group_profile_str(metadata_profile),
 			pretty_size(allocation.system));
 		printf("SSD detected:       %s\n", ssd ? "yes" : "no");
-		printf("Zoned device:       %s\n", zoned ? "yes" : "no");
-		if (zoned)
+		printf("Zoned device:       %s\n", opt_zoned ? "yes" : "no");
+		if (opt_zoned)
 			printf("  Zone size:        %s\n",
 			       pretty_size(fs_info->zone_size));
 		btrfs_parse_fs_features_to_string(features_buf, features);
@@ -1763,12 +1819,16 @@ out:
 
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

