Return-Path: <linux-btrfs+bounces-14085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB70ABA1EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 19:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366DB1C00250
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B27A247293;
	Fri, 16 May 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRS9zYlP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E199318D656
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747416941; cv=none; b=RAllAhKC/yNdMUQp7Yy71/aktgCuB2BqwIf/hLZfqjCmLmiaU+G0EPgNAENAvkT63DRRyfOkF8ErdFre1o2VRtpCXNmA+M6h7YfkfOifPE/FDkQum8u8yPj6fTljcfT+UHsqgw0m8CJ/Z88II+0WoYu9rcsJwKBeoHbJNO6mWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747416941; c=relaxed/simple;
	bh=vJ76PwQ7zJMj8zh2pKGWqjOH1KrukO0DtrOVrgxmRWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=So2Bfd754kHNJsgOJZFdJCLFiZLSh8JuyKL0XPDn5t/9o7AVHt0eL/iiEU9wkdpxzkxxCSn0U8sWZ/AUiJvkbcoVgn67ey7FhCwImh5x+bLCsy3d1lJ8JomGIQr5mol5HXqUJrN62WUlhTCmTJyLnmn+B/av4loKTt6W11wnuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRS9zYlP; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-3da8e1259dfso16257215ab.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747416938; x=1748021738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcGEdKUkKjyg7J+sOKf2aQeuoH4NidXfpDDoBNV0JKk=;
        b=LRS9zYlPbqevraUo3MouWOFpeH1EAGRQV4D1OLJeAqgh3S59/WkUdeznu/IBp9/9EP
         ZQEfx2npC9zL+J/Nl1l7Q+NjQQw0bjh+/Y4BDRMLgJxi5JTxutjhXUrkTM8V9nHHU+bo
         Q8BZ4EeP8geNrKsazJyAmp/lS5CDMZAj7GnRCWAazdE+Yg60IbVB/FG44MQa4aKkzZLG
         MLhPOuxSs7tjhLhOATkfxMaQuuSFHmxIWE6Ij75lpEq1flwXuOkJWzCFQvsMafEL6//O
         TFM2tjdUF5EmUMBI88GS9noN6FYhpGHuuEP3ILoh/76QmCpZw/Hg6dPt/TPixMMmAEZO
         6rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747416938; x=1748021738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcGEdKUkKjyg7J+sOKf2aQeuoH4NidXfpDDoBNV0JKk=;
        b=IoQAGyXUu6+zwGpbUesMnvKyOvvRu1Du4M+yyz1IjcUpn5JVKzxTnkWcYHNNhJBZ0V
         fUYwNoKfvmtGEMI0UMAiNHYlHvLEMPPG+Tj1xDxqITn5E8cVzT+tchz4upKC+mtwuzan
         sgmuZzgfIFYVNpbgSy3luj6w5IQ+HHzbAI9mD/4VFI1Q79peUmdvl4Z+/UOqVcFBb/ZA
         +f0ljLacEZdmiKHVAJyNlF0eAeO11MpXOf3eaSPc3tlp1NbKqewDq9fIcoigdRRsk/BG
         cYCD7XHPLnT+e236a9FloOC6TxIcQl4Cs3c5qveP/6x2oj0GETqXGQPGfa/mi51laWAZ
         j1Pg==
X-Gm-Message-State: AOJu0YyTy6qDybkEIryYqnAJzyyd/8n1w/pfYlw68Tdtr3wBRa1+v/bH
	233ffMOZhq/IR0x2GymDJWR8MU5jGrArbDUiXbkASXLJyhWMomW+sWlrHVTfszws
X-Gm-Gg: ASbGncvAs7H8yRXzKz9oKqHH2wdZ6fpV5iZANtmFJo6N0vG64gpcDq7IPO+TLwtjyxy
	0d9sgetZKVzYk7qXPbipq0heXRcb7C+zaG3UoVyBPUdW0yN28bj+tqNr7C0tcZ4YmaX/KGu0Ovh
	vGtt7kvByp/+bNvT9ArnTEgJIqeSIzqIuA4xg3OMyZcQiGpvLb1LX1cTZOlHvT0pgPM1I/6BKlG
	lJzATbiOc3NFthz6hBaBiJDLGSYSLqsQ2F0cFNquxpYO+QO8InqsKz1fv0Oa+FgDWNG8d3bTZCZ
	T4rEGDSOjYIMuRYUQgvus5Tha7vqAzZvsV++7FKNm5IQugc=
X-Google-Smtp-Source: AGHT+IGHAEXmwjCW+2oInh5SgEm+xqj+d85XYpi5Qw50zxcAUCRz8/zSDnUO5dsx9BsUh8VA09jKMw==
X-Received: by 2002:a05:6871:53c9:b0:2d6:1437:476d with SMTP id 586e51a60fabf-2e3c8203f07mr2181330fac.14.1747416927674;
        Fri, 16 May 2025 10:35:27 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c06baba2sm529341fac.20.2025.05.16.10.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:35:26 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v3] [RESEND] btrfs-progs: add slack space for mkfs --shrink
Date: Fri, 16 May 2025 10:35:15 -0700
Message-ID: <60e0cc5d215e79ba47b2484aad89a726812049b6.1743463442.git.loemra.dev@gmail.com>
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

V3:
- warn if block device size < fs size
V2:
- change --shrink[=SLACK SIZE] to --shrink-slack-size SIZE
- check for slack size alignment
- fix formatting
- remove new_size > device size warning message


Signed-off-by: Leo Martins <loemra.dev@gmail.com>
Reviewed-by: Mark Harmstone <maharmstone@fb.com>
---
 mkfs/main.c    | 26 +++++++++++++++++++++++++-
 mkfs/rootdir.c | 23 ++++++++++++++++++++++-
 mkfs/rootdir.h |  2 +-
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index dc73de47..715e939c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -461,6 +461,8 @@ static const char * const mkfs_usage[] = {
 	OPTLINE("", "- default - the SUBDIR will be a subvolume and also set as default (can be specified only once)"),
 	OPTLINE("", "- default-ro - like 'default' and is created as read-only subvolume (can be specified only once)"),
 	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to minimal size"),
+	OPTLINE("--shrink-slack-size SIZE",
+		"(with --shrink) include extra slack space after shrinking (default 0)"),
 	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
 	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
 	"",
@@ -1173,6 +1175,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	int i;
 	bool ssd = false;
 	bool shrink_rootdir = false;
+	u64 shrink_slack_size = 0;
 	u64 source_dir_size = 0;
 	u64 min_dev_size;
 	u64 shrink_size;
@@ -1217,6 +1220,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		int c;
 		enum {
 			GETOPT_VAL_SHRINK = GETOPT_VAL_FIRST,
+			GETOPT_VAL_SHRINK_SLACK_SIZE,
 			GETOPT_VAL_CHECKSUM,
 			GETOPT_VAL_GLOBAL_ROOTS,
 			GETOPT_VAL_DEVICE_UUID,
@@ -1247,6 +1251,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "quiet", 0, NULL, 'q' },
 			{ "verbose", 0, NULL, 'v' },
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
+			{ "shrink-slack-size", required_argument, NULL,
+			  GETOPT_VAL_SHRINK_SLACK_SIZE },
 			{ "compress", required_argument, NULL,
 				GETOPT_VAL_COMPRESS },
 #if EXPERIMENTAL
@@ -1383,6 +1389,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case GETOPT_VAL_SHRINK:
 				shrink_rootdir = true;
 				break;
+			case GETOPT_VAL_SHRINK_SLACK_SIZE:
+				shrink_slack_size = arg_strtou64_with_suffix(optarg);
+				break;
 			case GETOPT_VAL_CHECKSUM:
 				csum_type = parse_csum_type(optarg);
 				break;
@@ -1430,6 +1439,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
@@ -2108,8 +2123,17 @@ raid_groups:
 
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
index 19273947..5634d8c2 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -17,6 +17,8 @@
  */
 
 #include "kerncompat.h"
+#include <linux/fs.h>
+#include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/xattr.h>
 #include <dirent.h>
@@ -52,6 +54,7 @@
 #include "common/root-tree-utils.h"
 #include "common/path-utils.h"
 #include "common/rbtree-utils.h"
+#include "common/units.h"
 #include "mkfs/rootdir.h"
 
 #define LZO_LEN 4
@@ -1924,9 +1927,10 @@ err:
 }
 
 int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
-			 bool shrink_file_size)
+			 bool shrink_file_size, u64 slack_size)
 {
 	u64 new_size;
+	u64 blk_device_size;
 	struct btrfs_device *device;
 	struct list_head *cur;
 	struct stat file_stat;
@@ -1954,6 +1958,14 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
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
@@ -1968,6 +1980,15 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
 			error("failed to stat devid %llu: %m", device->devid);
 			return ret;
 		}
+		if (S_ISBLK(file_stat.st_mode)) {
+			ioctl(device->fd, BLKGETSIZE64, &blk_device_size);
+			if (blk_device_size < new_size) {
+				warning("blkdev size %llu (%s) is smaller than fs size %llu (%s)",
+					blk_device_size,
+					pretty_size(blk_device_size), new_size,
+					pretty_size(new_size));
+			}
+		}
 		if (!S_ISREG(file_stat.st_mode))
 			return ret;
 		ret = ftruncate(device->fd, new_size);
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


