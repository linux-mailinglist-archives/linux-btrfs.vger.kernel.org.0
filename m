Return-Path: <linux-btrfs+bounces-12702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E3A7715C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 01:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D25C16766A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 23:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B0215779;
	Mon, 31 Mar 2025 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTRu0PPr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386938F80
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743463626; cv=none; b=JxAnqeRVcebYfhzGsLjcqeX5TFrtVuEi3tChzfT4Ov2xYbGpvIeCP9/lj706d9lbGpQyiZsUjw8q8+h9IrpcYLGH5/OHcz6xWxVTjOhswdxpOBiFczKBXxgLPv91BORF19rSD8eG4ymotLxYdTgwMkwoYlfUzTc7Zd67OaIwLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743463626; c=relaxed/simple;
	bh=vJ76PwQ7zJMj8zh2pKGWqjOH1KrukO0DtrOVrgxmRWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEe1kusuA8XF2XpweBHY4+d2NHrRP0DO/s0Hr+PO0VM/Jh8Nubco4Ny5jE+gbzHw2qLKLOPPrZF+6Gi7/tEkXXzVcm31QSCD2BOVM4/04E5nqYqY3eRL40ryvhuajT6nLhUgT4QHRa2hsQHonTkVUTQxKlYZ/gaK1fXntpm7DXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTRu0PPr; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-2b38896c534so2470048fac.0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 16:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743463622; x=1744068422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcGEdKUkKjyg7J+sOKf2aQeuoH4NidXfpDDoBNV0JKk=;
        b=KTRu0PPro+DzLHBGS+7fk5eE9LDHzpPF14lcdSpBJtPiMoTJ/pfXLU5aC/QqorhI7n
         ZdBt05mP5Ut2qRYetplahKntykSssgUBX86AG+BvPRpOjPvp7cWn9LmneRB4l+nTNnaH
         Cf+Krziixsfy8zzX7uuQmB/8Sx5/7NfA4sVsORSonMCYb95Nna82gL6vItb2e0cG/IqZ
         s7t7+DrstC7iCuLj7FtKLAPaOj79Sd74ZDk6ZTYV6hqVL+18GuPQycv96kRAlmqX/10+
         kFrc8M6Bf3GVibDSqy88o/3tZ6MQRenZJY6asxoay0+NoCAEkfyiArjOngl3y6eLpmXN
         59cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743463622; x=1744068422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcGEdKUkKjyg7J+sOKf2aQeuoH4NidXfpDDoBNV0JKk=;
        b=ViWVtLlDP61X5seq0Jbl2ApsgS55J/Xs4gV/BkEQ+4iPxbEh74VDIVvLEFIH7kCNC/
         ZtJE5E0frd9s41NQzLySTfsnUTL4KXk4tVfA1MaV+VHFxnJivBgGVbsyY1kgekyTGazQ
         URdUjc2kVfeR6U1szA0CG2o6f0M4AUm5AcptNYXl0GWwkKTP32dHtKqrANvzyN+NojEb
         NKv5lSK+2Al9l5KLnmG/t609S9LRJ6A+maigZFcJ7vPnqGS35eG98HzIDwmOcHcI0J8q
         eJkVKft4HrbsCPbuDz/02F8HR0ZJCEnIhJxUyPg/A0I6E2iWQr1q943Muj0iUFz2Lj3D
         GmPg==
X-Gm-Message-State: AOJu0YzG3eQbuIkXK6lhxhA2bxXjbCSdJLpv88/PboNoXu8stQOq9Xxe
	/MidLhPH8enXsb1NT5CP2ePKHSzLeHCzZsoKAap52U4HRmpBkv/QXAnV6MXn
X-Gm-Gg: ASbGncuH4v2Ei4cSOUqqR8+mhUMVfhhTJSTlWGMHDAjDwtVo4zpNGcX48Dau59lulyP
	1NlWonywtaa9CTab9n54J+mqaVJcOxikCOSm+yI8T1JGKuQuAN8btiftedV5bCIO6Mt+1peThzg
	8mDu+CSRj/FdDswzzd2beFZSV5tALZCSR0nMlcSz8YIELf0kVfSvZh604wPoFmenA+ZOm5W1H2n
	ZjJhb0WikkCNB9+zfQvZAAbK+VCdoIAQ+VfzikXHg6lIAQUwi+gabVhkvfn+rmmj8Z6POqGYdPr
	SKuwXcK5Vcl4qfmGjxAjGmEapz8kUIOVjmTifFA=
X-Google-Smtp-Source: AGHT+IGRB8AOehQUwbvUD/XPhrIhdmhm7Iyrtryun/osh3V0AUEUE1kihR/s4UtDv/rUwyCRQfuhaQ==
X-Received: by 2002:a05:6870:468c:b0:2b8:78c0:2592 with SMTP id 586e51a60fabf-2cbcf59cd08mr5728541fac.23.1743463622538;
        Mon, 31 Mar 2025 16:27:02 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:5::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a40336fsm2063998fac.3.2025.03.31.16.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 16:27:01 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v3] btrfs-progs: add slack space for mkfs --shrink
Date: Mon, 31 Mar 2025 16:26:55 -0700
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


