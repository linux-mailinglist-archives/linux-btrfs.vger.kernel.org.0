Return-Path: <linux-btrfs+bounces-12168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B79DA5B18C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 01:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E4D3AE30F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B88D259C;
	Tue, 11 Mar 2025 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/AG2Ked"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6C29A1
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651843; cv=none; b=kQiYELAmu7k+IBfqTv2C0WLbeVhzdZZ2lP6onAMWRi+4mbLWA7LYwUCjMLhep7lV9WWVHD3dDGiOGDTLU64Jgvdk7dqirXFnp0IRjhjYNU3QzEMhqd/zHInF8/f2eSo/njKnP8GYzligok+Cy6rXZbdte52TeZfkwh6fLTTIYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651843; c=relaxed/simple;
	bh=tr+465YhIRpYcne3cRQM8ubxyUZhRsWvoCwvbYTAEA8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JtvuIC8ZRBq7uK4YHqEyP8U3gABmImXBKTYwdhS58gzoLBB0kl/mXUqJEjU/1xL3P9iorZ1Ut8/E3fEcnm+qLmmZjWO8MZKGQMXf2YTpP8Wnke3NFz9DZsex9spbjg9H2fZYE0vFSXUxSSxegRHvYUSf2Bdu8hRagRmi+iB7MuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/AG2Ked; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-2bcbfad2f8cso2632452fac.1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 17:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741651840; x=1742256640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCgP9/j4M8HG6wodfa/ZuJIWqoF9N7Q57g3IJH4WlhQ=;
        b=B/AG2KedUXgBRizkAae4f+4AGqxIkjIIZPrTAICpFDuycbdHJwQ0DNqR6s6gTXeiUd
         SoGXC3iTXge3VgwpoKSFP1y+OYJrdzueZIKqfiXiJ2ypzu7huw0DI7rVG/wEK50C2qad
         ShEwsueLjLWK5Sc37oCgSncCSj0Uqyrk/MqFW3dvizB9zRuJFO8NhqqN5sSlJgyL5c1P
         eZkUgSuS8c1D3hnlTwsdnQKG44c/HcsIT17wkeCuyWf9sIomz4KPvRnnOrih+haGe2dO
         K8PE1aAP5OCsGQm4VCQfnKMNACHbuYK1oz7akaRkzuTBxcEvet0BH6mCp5IOWK2tpiYC
         Dyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741651840; x=1742256640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCgP9/j4M8HG6wodfa/ZuJIWqoF9N7Q57g3IJH4WlhQ=;
        b=lTWWkjnKgN5qG7LKmq8l9GWQFz3iYl+mNz5qr1ohsKUC1vlF0vsmip6dJ0wmX7Z737
         owpKsU0N9x2lMzPfThE2OeuheNd9CfeqQPtH0uysOK7aRomUmrmPrABHtHP66jZ0+KjP
         KTnrnbJ9pSfckqZMRYSbJRKod8mqwwvChCbZiY/W8Ogjjy0SPkIfAXy6S3heDHIWuMBO
         mAaUAMqQVQtrmn31GFSIonrAYpi1Mob8j5vNAaCIPeBweQuYMgdJIWon4cU8RHn3dIna
         RjKZRCX8iQJlQ/jvg1CoBk9wQVmwd07MqI+uRv1LRwm4/i/vq1IwUUI5s/U0ysMfzSZI
         FjEA==
X-Gm-Message-State: AOJu0YyHqip3QHwHeDp8wBkehxbR9B9TW1Yy1JpGu9XTIGfJz/u38s08
	UC2hg7p0BJC7Q2l8bLKqtdvH3FsVlVUADGkQgz1E2TtE0NgJapylqdzrTqYO
X-Gm-Gg: ASbGncuSqjKptULYg9s3IeuLejQHlR+1GLsfOlxHezTyx2a/Udi8LKBwHOfrJXjLaOC
	gWxwbcimIbmYapi2OZFbRgXd4CGKRtz11/UMuhnWM5EtxjJaUGHmlFR6T+H8LGBDZrtSTTfEc3M
	14uMlqqgI9QH/NgCsUQgnjqkY7NPLODi0YH8rjo1vR70/S+WnR7j4L2I31uZQUp6QKVy/dSfNLn
	r0P/8nK6FRC5+9Sj1SQs2+o7VJWIaVbyh4Qotzh60pSPx8Yt7L+lFpVPgL+RQ28o3PPuGPpFDjl
	inaAGVXyYJ/HIEVx2iN+qcgZSjnyXli7G/U4CljAiUWfeDkf7A==
X-Google-Smtp-Source: AGHT+IGeKzDdppWQ7jjboUJbqEFgOHuhsqg7r7sI2miMp3S4k/uJlMIOVzb4gW+S5gP35uOZf+6gKQ==
X-Received: by 2002:a05:6870:6c06:b0:296:e491:b244 with SMTP id 586e51a60fabf-2c261386d55mr7794474fac.32.1741651839785;
        Mon, 10 Mar 2025 17:10:39 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a45cd470asm1469937a34.55.2025.03.10.17.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 17:10:38 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs-progs: add slack space for mkfs --shrink
Date: Mon, 10 Mar 2025 17:10:31 -0700
Message-ID: <fbe3a75e21a89d8fb3013c55468de7fd03b5027e.1741651032.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds an optional argument to the 'mkfs --shrink' option
allowing users to specify slack when shrinking the filesystem.
Previously if you wanted to use --shrink and include extra space in the
filesystem you would need to use btrfs resize, however, this requires
mounting the filesystem which requires CAP_SYS_ADMIN.

The new syntax is:
mkfs.btrfs --shrink[=SLACK SIZE]

Where [SLACK SIZE] is an optional argument specifying the desired
slack size. If not provided, the default slack size is 0.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 mkfs/main.c    | 15 +++++++++++----
 mkfs/rootdir.c | 15 ++++++++++++---
 mkfs/rootdir.h |  2 +-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index dc73de47..11a5a4a9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -460,7 +460,7 @@ static const char * const mkfs_usage[] = {
 	OPTLINE("", "- ro - create the subvolume as read-only"),
 	OPTLINE("", "- default - the SUBDIR will be a subvolume and also set as default (can be specified only once)"),
 	OPTLINE("", "- default-ro - like 'default' and is created as read-only subvolume (can be specified only once)"),
-	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to minimal size"),
+	OPTLINE("--shrink[=SLACK SIZE]", "(with --rootdir) shrink the filled filesystem to minimal size, optionally include extra slack space after shrinking (default 0)"),
 	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
 	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
 	"",
@@ -1176,6 +1176,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 source_dir_size = 0;
 	u64 min_dev_size;
 	u64 shrink_size;
+	u64 shrink_slack_size = 0;
 	int device_count = 0;
 	int saved_optind;
 	pthread_t *t_prepare = NULL;
@@ -1246,7 +1247,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				GETOPT_VAL_DEVICE_UUID },
 			{ "quiet", 0, NULL, 'q' },
 			{ "verbose", 0, NULL, 'v' },
-			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
+			{ "shrink", optional_argument, NULL, GETOPT_VAL_SHRINK },
 			{ "compress", required_argument, NULL,
 				GETOPT_VAL_COMPRESS },
 #if EXPERIMENTAL
@@ -1381,6 +1382,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				strncpy_null(dev_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
 				break;
 			case GETOPT_VAL_SHRINK:
+				shrink_slack_size = optarg == NULL ? 0 : arg_strtou64_with_suffix(optarg);
 				shrink_rootdir = true;
 				break;
 			case GETOPT_VAL_CHECKSUM:
@@ -2107,9 +2109,14 @@ raid_groups:
 		}
 
 		if (shrink_rootdir) {
-			pr_verbose(LOG_DEFAULT, "  Shrink:           yes\n");
+			pr_verbose(
+				LOG_DEFAULT,
+				"  Shrink:           yes          (slack size: %s)\n",
+				pretty_size(shrink_slack_size));
 			ret = btrfs_mkfs_shrink_fs(fs_info, &shrink_size,
-						   shrink_rootdir);
+						   shrink_rootdir,
+						   shrink_slack_size);
+
 			if (ret < 0) {
 				errno = -ret;
 				error("error while shrinking filesystem: %m");
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 19273947..176e6528 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -1924,7 +1924,7 @@ err:
 }
 
 int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
-			 bool shrink_file_size)
+			 bool shrink_file_size, u64 slack_size)
 {
 	u64 new_size;
 	struct btrfs_device *device;
@@ -1948,14 +1948,23 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
 		return ret;
 	}
 
+	device = list_entry(fs_info->fs_devices->devices.next,
+			   struct btrfs_device, dev_list);
+
+	new_size += slack_size;
+	if (new_size > device->total_bytes) {
+		warning("fs size with slack: %llu (%s) is larger than device size: %llu (%s)\n"
+			"         consider decreasing slack size or increasing device size",
+			new_size, pretty_size(new_size), device->total_bytes,
+			pretty_size(device->total_bytes));
+	}
+
 	if (!IS_ALIGNED(new_size, fs_info->sectorsize)) {
 		error("shrunk filesystem size %llu not aligned to %u",
 				new_size, fs_info->sectorsize);
 		return -EUCLEAN;
 	}
 
-	device = list_entry(fs_info->fs_devices->devices.next,
-			   struct btrfs_device, dev_list);
 	ret = set_device_size(fs_info, device, new_size);
 	if (ret < 0)
 		return ret;
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


