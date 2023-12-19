Return-Path: <linux-btrfs+bounces-1062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876B818FD6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 19:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA181F21C11
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F373381AE;
	Tue, 19 Dec 2023 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="f7wb24ZK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0EB37D1D
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6da5250357fso3645071a34.2
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 10:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1703010889; x=1703615689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8wzkEAhwnyy07xLvpcm93W4I1DVlBneU1+LkbDvD3A=;
        b=f7wb24ZKZjGbbLV7BKGS+cNTrHmoPKaXYwCCM1EO/yLEXTge0zZjxwvDFFW/4DDIlH
         +aCctb/HdDy1gN8l7d0ZVz5KfSmNVjD9P8VWQ5Vfdb4+ZNmamwMLh644v2ybAnkkG2OQ
         A42Xe8PvJMpz1H/LSciWbcA7AJfHAi3URIphs0QR/eMrv+vijHejbTVrUajSg4kNrr2I
         2pxLh1NJhc6RYOYlOOHGoHun8YBY3tFXDDOO34RqphD4eeiJCoj9fHEqFasAVFEucffC
         VOQEsYqrKV/e0tEl37wihSz9GCUiimfogyfGAdJGYKqS2d61deXeIeu0iqN5wWmHFP/a
         /tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010889; x=1703615689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8wzkEAhwnyy07xLvpcm93W4I1DVlBneU1+LkbDvD3A=;
        b=bkIgfjyo6yDp7JWMkJku+QS3+V2avN5WrmUt6EMS06vbXqOgjMdJTWkt3QShROLYz6
         eLbAGdWqBzcWAgSMCyWU4poHx59YFy8vs1FeFEMS/c+JLjGybn/e9OoN0iZEctY07xal
         QAqbRCFvaNd3UVPp8e41ONx+JsSe+FtXNVWOiKHdeQuZ4SLKXPpEI3ONqi+qIjNQV5CJ
         VofgRTzYeVH7FPWSeif/BrbU86YYu7Cm92TrRgKgGVFDZjWCRVsphfSbE61roQgaRkdy
         a0pL3qxIgCQqdqN3TV/x/a+4oLTbS+RjLzTLWLkakSeVedkt3oGxdesag5+sKNnsZpRN
         3uLg==
X-Gm-Message-State: AOJu0YxiU6WkzibK47vBsWcWuncXvMlD/isBssdYuOfzOABWtSD5pBc/
	qVTe7hp27ZENq3O73TZZpjJW6xHbW+82zEZAm3E=
X-Google-Smtp-Source: AGHT+IFaIZ224gUPMZpzJ1d8WM/wJBxVb6SKiX+S0sA0DHxQB59QpyR9jsvxHn9CYaKza9fmcMxNVQ==
X-Received: by 2002:a05:6358:7e48:b0:170:f17f:7070 with SMTP id p8-20020a0563587e4800b00170f17f7070mr10068900rwm.33.1703010889104;
        Tue, 19 Dec 2023 10:34:49 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2620:10d:c090:400::4:649a])
        by smtp.gmail.com with ESMTPSA id o8-20020a056a001b4800b006d93c8d0c3esm1090679pfv.183.2023.12.19.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:34:48 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH fstests] btrfs: test snapshotting a deleted subvolume
Date: Tue, 19 Dec 2023 10:34:37 -0800
Message-ID: <62415ffc97ff2db4fa65cdd6f9db6ddead8105cd.1703010806.git.osandov@osandov.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <068014bd3e90668525c295660862db2932e25087.1703010314.git.osandov@fb.com>
References: <068014bd3e90668525c295660862db2932e25087.1703010314.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression test for patch "btrfs: don't abort filesystem when
attempting to snapshot deleted subvolume". Without the fix, the
filesystem goes read-only and prints a warning. With the fix, it should
fail gracefully with ENOENT.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
---
Note that the kernel fix was just sent and isn't yet merged.

Thanks!

 .gitignore                         |   1 +
 src/Makefile                       |   2 +-
 src/t_snapshot_deleted_subvolume.c | 102 +++++++++++++++++++++++++++++
 tests/btrfs/304                    |  26 ++++++++
 tests/btrfs/304.out                |   2 +
 5 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 src/t_snapshot_deleted_subvolume.c
 create mode 100755 tests/btrfs/304
 create mode 100644 tests/btrfs/304.out

diff --git a/.gitignore b/.gitignore
index 4c32ac42..b9bf708b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -165,6 +165,7 @@ tags
 /src/t_readdir_2
 /src/t_readdir_3
 /src/t_rename_overwrite
+/src/t_snapshot_deleted_subvolume
 /src/t_stripealign
 /src/t_truncate_cmtime
 /src/t_truncate_self
diff --git a/src/Makefile b/src/Makefile
index 8160a0e8..53a32370 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -33,7 +33,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
-	uuid_ioctl
+	uuid_ioctl t_snapshot_deleted_subvolume
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/t_snapshot_deleted_subvolume.c b/src/t_snapshot_deleted_subvolume.c
new file mode 100644
index 00000000..c3adb1c4
--- /dev/null
+++ b/src/t_snapshot_deleted_subvolume.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Meta Platforms, Inc. and affiliates.
+
+#include "global.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include <linux/types.h>
+#ifdef HAVE_STRUCT_BTRFS_IOCTL_VOL_ARGS_V2
+#include <linux/btrfs.h>
+#else
+#ifndef BTRFS_IOCTL_MAGIC
+#define BTRFS_IOCTL_MAGIC 0x94
+#endif
+
+#ifndef BTRFS_IOC_SNAP_DESTROY_V2
+#define BTRFS_IOC_SNAP_DESTROY_V2 \
+	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
+#endif
+
+#ifndef BTRFS_IOC_SNAP_CREATE_V2
+#define BTRFS_IOC_SNAP_CREATE_V2 \
+	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
+#endif
+
+#ifndef BTRFS_IOC_SUBVOL_CREATE_V2
+#define BTRFS_IOC_SUBVOL_CREATE_V2 \
+	_IOW(BTRFS_IOCTL_MAGIC, 24, struct btrfs_ioctl_vol_args_v2)
+#endif
+
+#ifndef BTRFS_SUBVOL_NAME_MAX
+#define BTRFS_SUBVOL_NAME_MAX 4039
+#endif
+
+struct btrfs_ioctl_vol_args_v2 {
+	__s64 fd;
+	__u64 transid;
+	__u64 flags;
+	union {
+		struct {
+			__u64 size;
+			struct btrfs_qgroup_inherit *qgroup_inherit;
+		};
+		__u64 unused[4];
+	};
+	union {
+		char name[BTRFS_SUBVOL_NAME_MAX + 1];
+		__u64 devid;
+		__u64 subvolid;
+	};
+};
+#endif
+
+int main(int argc, char **argv)
+{
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s PATH\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	int dirfd = open(argv[1], O_RDONLY | O_DIRECTORY);
+	if (dirfd < 0) {
+		perror(argv[1]);
+		return EXIT_FAILURE;
+	}
+
+	struct btrfs_ioctl_vol_args_v2 subvol_args = {};
+	strcpy(subvol_args.name, "subvol");
+	if (ioctl(dirfd, BTRFS_IOC_SUBVOL_CREATE_V2, &subvol_args) < 0) {
+		perror("BTRFS_IOC_SUBVOL_CREATE_V2");
+		return EXIT_FAILURE;
+	}
+
+	int subvolfd = openat(dirfd, "subvol", O_RDONLY | O_DIRECTORY);
+	if (subvolfd < 0) {
+		perror("openat");
+		return EXIT_FAILURE;
+	}
+
+	if (ioctl(dirfd, BTRFS_IOC_SNAP_DESTROY_V2, &subvol_args) < 0) {
+		perror("BTRFS_IOC_SNAP_DESTROY_V2");
+		return EXIT_FAILURE;
+	}
+
+	struct btrfs_ioctl_vol_args_v2 snap_args = { .fd = subvolfd };
+	strcpy(snap_args.name, "snap");
+	if (ioctl(dirfd, BTRFS_IOC_SNAP_CREATE_V2, &snap_args) < 0) {
+		if (errno == ENOENT)
+			return EXIT_SUCCESS;
+		perror("BTRFS_IOC_SNAP_CREATE_V2");
+		return EXIT_FAILURE;
+	}
+	fprintf(stderr, "BTRFS_IOC_SNAP_CREATE_V2 should've failed\n");
+	return EXIT_FAILURE;
+}
diff --git a/tests/btrfs/304 b/tests/btrfs/304
new file mode 100755
index 00000000..65f54b95
--- /dev/null
+++ b/tests/btrfs/304
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+#
+# FS QA Test 304
+#
+# Try to snapshot a deleted subvolume.
+#
+. ./common/preamble
+_begin_fstest auto quick snapshot subvol
+
+_supported_fs btrfs
+_require_scratch
+_require_test_program t_snapshot_deleted_subvolume
+_fixed_by_kernel_commit XXXXXXXXXXXX "btrfs: don't abort filesystem when attempting to snapshot deleted subvolume"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+"$here/src/t_snapshot_deleted_subvolume" "$SCRATCH_MNT"
+# Make sure the filesystem didn't go read-only.
+touch "$SCRATCH_MNT/foo"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
new file mode 100644
index 00000000..c504111c
--- /dev/null
+++ b/tests/btrfs/304.out
@@ -0,0 +1,2 @@
+QA output created by 304
+Silence is golden
-- 
2.43.0


