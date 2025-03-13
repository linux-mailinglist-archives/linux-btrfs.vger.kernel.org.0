Return-Path: <linux-btrfs+bounces-12277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB304A5FF61
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 19:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84CC7A3C98
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 18:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42191EFFB5;
	Thu, 13 Mar 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1PogE58"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E0B1EF393
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890925; cv=none; b=NxuCa6oY/8Oa3VQOOgycQ0cY6bykZHRkyI7dBu0Yp4OLQirmFymhzC9MP5DosxBLxydfmZ7fASzXVdHEZo34yfV2/X9DfjYXhezbf5civZEKHkFhsUUKkSH2TNL8w7PsRz8FVWnavkAdD8befhXrxyAJkeYcwq4r4tjhRiec45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890925; c=relaxed/simple;
	bh=5zEeqcNsdp0uD+HqLN4rASayZb0uT1xQViHjdOtjjRw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ehNYzVSIYiKGS9VmZaDW4DZIYqjZc1zSfblPe6u6JtQf8r1TJLjZSWSoSlVNauQldrX5DSzJN3GY4Fik9mVnv50lISvuiLLVB2RsVkDlORcnRJBoVxfUjlLaaLr1v80dVZsmW/NSD1FF5x/KA18u77GqYqF7DsOpu1uHeqvuQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1PogE58; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-71fbb0d035dso903469a34.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741890922; x=1742495722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJJRFyJCGqV6on6CmJZyRHGBzE9zAxZ1MgAj7jqZTfo=;
        b=K1PogE58N0gwP9AisM8ItzAnFuByZSf5Jr9VCj//XuYyEVYvD08dz68oc0zGKlkBvN
         P5DNDYoq6LAZAYFG5F77Ahb/6zg+mrUg6ZiB7iCs/N+t29LREIpD6GoMBy9G6t5mItaE
         gQLBjngOmBW3pX7RYiaG0V9Er52LOKvZ+HqD6+V5I7AiDKnJbc16IMq8UW/WkadBZvrE
         5A3MjPF5QethQPbkhfrg9XvESR2SUMtxjyqfnnjQdcnGczNDftvuh+kRDfBsMjM17w3+
         dZNcJX8kldOxmh5h5tZU51KNpWi0RwDSXxUY39lr1uIvCK5Y2dGx1Oar8yfaSG2fAWAB
         Cp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890922; x=1742495722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJJRFyJCGqV6on6CmJZyRHGBzE9zAxZ1MgAj7jqZTfo=;
        b=Lf7TLunWvLNqkaPZMPl6vr98NOp+55ShRNTJwbA1qzq78Kpuq4Q14EKqs//BXxEfPw
         xerrMIJZ2Qh99bmexU9wp0Y7LRomUsm1j6FmXQF7dEge1S5AGRQ6USxkfvzybMQ9eQoQ
         PYti+6ZzLIbAIZQ6lWnixX3JRfAeVZGnnQsmPplCN2+8z3PTpUsbxtaSZ3cz9CjrO5Js
         Ywx5PLNT1K5GJA+iPt+T6PQ1utVdZZmPQXcfQ0tDYib1oJ7YKZ1Y49N9asDobyJDJ0em
         H8BO975sPtKeygxSnjuvN70OJXAePIsoBmLsFOghgUHBztXjnzpst+wSB9fF7Muv3TO8
         KmHQ==
X-Gm-Message-State: AOJu0Yxdsvb304IGwU1STu0XkX701yMY40arbFFeY329wvssMhilfzW3
	dl4jLshW5XOzKFjoAawpC1yd8o5uAVrhQXOi2feKAgf8GMbwY5fxJ/Lz7Utx
X-Gm-Gg: ASbGncvRG7A7FLuKTcPMD18kgVuscHq3xTDD7PBsQp/rDH5qApMy6b5qLjdbApG9AR7
	LS91xV1mirzDsTcUiD48D0DKt3/lMN/e5EOKAac9kRoKxk+KPReo4ocKg2LSoEGcE45v5gb/g+N
	7rITRjT0ti8BMoGzkMXwfeY8IkhYw7SFSG5Vq77yKlHud85bacqS/Y1ydRx/Kc/MI4JmTy9VLxZ
	Wv2rBtThK/o4sAtD6n8njE4iAyKS4BFGh4T/TZl8q0ySouOJAn50IewHzOV3ZWILiC7tD2GZcYR
	9m3FGrT+CzHJ3XgDaj6IJPNSSg2UTcSvLBQb0LIBuyZkpMzIQUk=
X-Google-Smtp-Source: AGHT+IG+5K1XpEVvmAe33j3QDI27K6QzpLOIJ5C1bOvNV3RMo2XAolJuIoufpWCvFl2xJkv/ZbRAdg==
X-Received: by 2002:a05:6830:b88:b0:727:439c:d18b with SMTP id 46e09a7af769-72bb9631b9amr514439a34.15.1741890922073;
        Thu, 13 Mar 2025 11:35:22 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb267b1acsm309466a34.4.2025.03.13.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:35:21 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 1/1] btrfs-progs: add slack space for mkfs --shrink
Date: Thu, 13 Mar 2025 11:35:19 -0700
Message-ID: <121133b547f15980bd02280328bb04017c495ec9.1741890798.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a flag `--shrink-slack-size SIZE` to the mkfs.btrfs
allowing users to specify slack when shrinking the filesystem.
Previously if you wanted to use --shrink and include extra space in the
filesystem you would need to use btrfs resize, however, this requires
mounting the filesystem which requires CAP_SYS_ADMIN.

The new syntax is:
`mkfs.btrfs --shrink --shrink-slack-size SIZE`

Where slack size is an argument specifying the desired
free space to add to a shrunk fs. If not provided, the default
slack size is 0.

I have not added any upper bounds checking on SIZE as I'm not sure
it's necessary.

The following command will succeed without warning even if `$DEVICE` is
a block device smaller than 10T. However, mounting `$DEVICE` will fail.

`mkfs.btrfs -f $DEVICE --root $ROOT --shrink --shrink-slack-size 10T`

I don't know if this would be considered incorrect because $DEVICE could
also be a regular file that can ftruncate up to the appropriate size.
Should I add a warning message, or leave it to mount time to indicate
that something is wrong?

V2:
- change --shrink[=SLACK SIZE] to --shrink-slack-size SIZE
- check for slack size alignment
- fix formatting
- remove new_size > device size warning message


Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 mkfs/main.c    | 25 ++++++++++++++++++++++++-
 mkfs/rootdir.c | 11 ++++++++++-
 mkfs/rootdir.h |  2 +-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index dc73de47..ab5a1ced 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -461,6 +461,7 @@ static const char * const mkfs_usage[] = {
 	OPTLINE("", "- default - the SUBDIR will be a subvolume and also set as default (can be specified only once)"),
 	OPTLINE("", "- default-ro - like 'default' and is created as read-only subvolume (can be specified only once)"),
 	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to minimal size"),
+	OPTLINE("--shrink-slack-size SIZE", "(with --shrink) include extra slack space after shrinking (default 0)"),
 	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
 	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
 	"",
@@ -1173,6 +1174,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	int i;
 	bool ssd = false;
 	bool shrink_rootdir = false;
+	u64 shrink_slack_size = 0;
 	u64 source_dir_size = 0;
 	u64 min_dev_size;
 	u64 shrink_size;
@@ -1217,6 +1219,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		int c;
 		enum {
 			GETOPT_VAL_SHRINK = GETOPT_VAL_FIRST,
+			GETOPT_VAL_SHRINK_SLACK_SIZE,
 			GETOPT_VAL_CHECKSUM,
 			GETOPT_VAL_GLOBAL_ROOTS,
 			GETOPT_VAL_DEVICE_UUID,
@@ -1247,6 +1250,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "quiet", 0, NULL, 'q' },
 			{ "verbose", 0, NULL, 'v' },
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
+			{ "shrink-slack-size", required_argument, NULL,
+			  GETOPT_VAL_SHRINK_SLACK_SIZE },
 			{ "compress", required_argument, NULL,
 				GETOPT_VAL_COMPRESS },
 #if EXPERIMENTAL
@@ -1383,6 +1388,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case GETOPT_VAL_SHRINK:
 				shrink_rootdir = true;
 				break;
+			case GETOPT_VAL_SHRINK_SLACK_SIZE:
+				shrink_slack_size = arg_strtou64_with_suffix(optarg);
+				break;
 			case GETOPT_VAL_CHECKSUM:
 				csum_type = parse_csum_type(optarg);
 				break;
@@ -1430,6 +1438,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		ret = 1;
 		goto error;
 	}
+	if (shrink_slack_size > 0 && !shrink_rootdir) {
+		error("the option --shrink-slack-size must be used with --shrink");
+		ret = 1;
+		goto error;
+
+	}
 	if (!list_empty(&subvols) && source_dir == NULL) {
 		error("option --subvol must be used with --rootdir");
 		ret = 1;
@@ -2108,8 +2122,17 @@ raid_groups:
 
 		if (shrink_rootdir) {
 			pr_verbose(LOG_DEFAULT, "  Shrink:           yes\n");
+			if (shrink_slack_size > 0) {
+				pr_verbose(
+					LOG_DEFAULT,
+					"  Shrink slack:           %llu (%s)\n",
+					shrink_slack_size,
+					pretty_size(shrink_slack_size));
+			}
 			ret = btrfs_mkfs_shrink_fs(fs_info, &shrink_size,
-						   shrink_rootdir);
+						   shrink_rootdir,
+						   shrink_slack_size);
+
 			if (ret < 0) {
 				errno = -ret;
 				error("error while shrinking filesystem: %m");
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 19273947..c14546b6 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -48,6 +48,7 @@
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/utils.h"
+#include "common/units.h"
 #include "common/extent-tree-utils.h"
 #include "common/root-tree-utils.h"
 #include "common/path-utils.h"
@@ -1924,7 +1925,7 @@ err:
 }
 
 int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
-			 bool shrink_file_size)
+			 bool shrink_file_size, u64 slack_size)
 {
 	u64 new_size;
 	struct btrfs_device *device;
@@ -1954,6 +1955,14 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
 		return -EUCLEAN;
 	}
 
+	if (!IS_ALIGNED(slack_size, fs_info->sectorsize)) {
+		error("slack size %llu not aligned to %u",
+				slack_size, fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+
+	new_size += slack_size;
+
 	device = list_entry(fs_info->fs_devices->devices.next,
 			   struct btrfs_device, dev_list);
 	ret = set_device_size(fs_info, device, new_size);
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index b32fda5b..1eee3824 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -52,6 +52,6 @@ int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir
 u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
 			u64 meta_profile, u64 data_profile);
 int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
-			 bool shrink_file_size);
+			 bool shrink_file_size, u64 slack_size);
 
 #endif
-- 
2.47.1


