Return-Path: <linux-btrfs+bounces-3471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BD388136E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 15:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A511F22418
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E34AECF;
	Wed, 20 Mar 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Gq7ZDr+S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DB482DB
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945410; cv=none; b=pdG1hz12QSVTqtts50LfP8TFU/Wcau5dohApaAXC5+AEdWGSnWS6Ms6RW5vmDDBBmmtzsF/fcu36B7el9cdBGQm2s5TCv0pHHbQ/dCrLOfH6E2ABr9Vc0QEaPP+ucsU+b4jp228/7jvD2AEQ2fCwOJWR83UoB/5KIZOxpvrCgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945410; c=relaxed/simple;
	bh=0dzmvSNXDEjI7bO13sJavVyxPJ+BMK8j7eQSjbkgiC0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y1588NFBsIxkYPjE+4cCKjn0mOYIVeEIGqQH7FSaVpbrrHTXfozxpg+LPA40xS4oiXRnMUeCibJF3RB1c9pPNwXNkU99wyX7k+ScvGi/mKFteV0/8Ec9FY14e2hrmE3vGF+2hLvcR2Ir2/NjMOVCE7I/W06T4a2IEYr87dVYAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Gq7ZDr+S; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c3a4101721so317912b6e.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710945407; x=1711550207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3KWocK4KNuC3im4RVRinIZdPR5x/tqHwwO2pPUGXNV8=;
        b=Gq7ZDr+Sgk3Nz0zGyWPcogQzxWGeZPZo7XBeEqiHLwOArCzjsKtFA9zaNfq6Cf74fz
         +QhRb2NEHHYfLK1L1VpRRRccT3XdqhSBjP8pe3IobUz4SCXMYAQk/Znb2Kdm4E/tvxuN
         WH5Tr85WCMBw+WS/DWQXHyQTwdybsXCMD3lZnCbGwtkQgeyskUCK0BnFNLbMwYWAXC05
         BQ1WaHL6er/f8e6vPZ8eHymlpab5Pj2MokbE0b44X8VX4v+80hJ6PIqIAkanM2TiYqZS
         P1LUTCXXZkPUZLcM1X2ppeXiu85gV8kUhKysOBOYs+sf+wipGFZhRlHjOCquGdk8RKMz
         Fs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945407; x=1711550207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KWocK4KNuC3im4RVRinIZdPR5x/tqHwwO2pPUGXNV8=;
        b=OGUdRkvhpxxv0xQ9ombvfIcPXC+rytpjenifwnf6rve1K8px9fiVRKmbXKJYV70xsT
         U5ALWf70QajhKgtRbSdLzA4Qb4Wo2XpfK1iEO4hvV6IgpBF30guo1ujF2IwiwCo6rMDV
         Cpg7n839TiPhV5mTgz9r2Wh5d6t2DmRtcI9uLzfYJQpJWxE9nLygLKZIrqlBBf+wxiGL
         +VgjCMsOJ3QPo7Zs8WnxwlHw2ff6bHQCkYp/SmYJsGVAhChMtG6My7L0omfpd+vz5ypQ
         XhbdywPfkg/psBpjVAp6FkbwoViVwQcHNPXon7mlTbek7YDaxh23xu1AIoNzoBNsbXXP
         2/pg==
X-Forwarded-Encrypted: i=1; AJvYcCUvargYnL49Byd0RmlYGMx+sgNvR/v7cPhqiHZTTAND9f0aFnfTFhpGJR13jAyYRYUVuEMMqABD9HO4boaEJ/+cteAJxHvq8vMeJNI=
X-Gm-Message-State: AOJu0Yw6pk+5e7CVPL7KFH6CQRRYgjrthTbzk4K6GrTUJtTXJV5RluTJ
	cbELNg1WnPshbvbI8yLXj5KIlqGOt/Mvigl04RYlvvjjv2tIlbqILyUC6GJhNE8=
X-Google-Smtp-Source: AGHT+IFgxi7O2L2yBwP9rAFdXFOi0JAX/OnP3OsP0BbowtXmdKHTeeTAUJMZZOtQBxscFY29LXcOcQ==
X-Received: by 2002:a05:6808:140f:b0:3c2:60cb:5bb4 with SMTP id w15-20020a056808140f00b003c260cb5bb4mr6866176oiv.6.1710945407333;
        Wed, 20 Mar 2024 07:36:47 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bq23-20020a05622a1c1700b00430d1c9bfebsm3805409qtb.43.2024.03.20.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:36:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3] generic/808: add a regression test for fiemap into an mmap range
Date: Wed, 20 Mar 2024 10:36:42 -0400
Message-ID: <076b7d22d653a046bf3710c4fa04cc155b6cf07b.1710945314.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Btrfs had a deadlock that you could trigger by mmap'ing a large file and
using that as the buffer for fiemap.  This test adds a c program to do
this, and the fstest creates a large enough file and then runs the
reproducer on the file.  Without the fix btrfs deadlocks, with the fix
we pass fine.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v2->v3:
- Add fiemap-fault to .gitignore
- Added a _cleanup() helper
- Just let the output of fiemap-fault go instead of using || _fail
- Added the munmap
- Moved $dst to $TEST_DIR/$seq

 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/fiemap-fault.c    | 74 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/808     | 48 ++++++++++++++++++++++++++++
 tests/generic/808.out |  2 ++
 5 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 src/fiemap-fault.c
 create mode 100755 tests/generic/808
 create mode 100644 tests/generic/808.out

diff --git a/.gitignore b/.gitignore
index 3b160209..f0fb72bd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -205,6 +205,7 @@ tags
 /src/vfs/mount-idmapped
 /src/log-writes/replay-log
 /src/perf/*.pyc
+/src/filemap-fault
 
 # Symlinked files
 /tests/generic/035.out
diff --git a/src/Makefile b/src/Makefile
index e7442487..ab98a06f 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
-	uuid_ioctl t_snapshot_deleted_subvolume
+	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/fiemap-fault.c b/src/fiemap-fault.c
new file mode 100644
index 00000000..73260068
--- /dev/null
+++ b/src/fiemap-fault.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+ */
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <linux/fs.h>
+#include <linux/types.h>
+#include <linux/fiemap.h>
+#include <err.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+int prep_mmap_buffer(int fd, void **addr)
+{
+	struct stat st;
+	int ret;
+
+	ret = fstat(fd, &st);
+	if (ret)
+		err(1, "failed to stat %d", fd);
+
+	*addr = mmap(NULL, st.st_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (*addr == MAP_FAILED)
+		err(1, "failed to mmap %d", fd);
+
+	return st.st_size;
+}
+
+int main(int argc, char *argv[])
+{
+	struct fiemap *fiemap;
+	size_t sz, last = 0;
+	void *buf = NULL;
+	int ret, fd;
+
+	if (argc != 2)
+		errx(1, "no in and out file name arguments given");
+
+	fd = open(argv[1], O_RDWR, 0666);
+	if (fd == -1)
+		err(1, "failed to open %s", argv[1]);
+
+	sz = prep_mmap_buffer(fd, &buf);
+
+	fiemap = (struct fiemap *)buf;
+	fiemap->fm_flags = 0;
+	fiemap->fm_extent_count = (sz - sizeof(struct fiemap)) /
+				  sizeof(struct fiemap_extent);
+
+	while (last < sz) {
+		int i;
+
+		fiemap->fm_start = last;
+		fiemap->fm_length = sz - last;
+
+		ret = ioctl(fd, FS_IOC_FIEMAP, (unsigned long)fiemap);
+		if (ret < 0)
+			err(1, "fiemap failed %d", errno);
+		for (i = 0; i < fiemap->fm_mapped_extents; i++)
+		       last = fiemap->fm_extents[i].fe_logical +
+			       fiemap->fm_extents[i].fe_length;
+	}
+
+	munmap(buf, sz);
+	close(fd);
+	return 0;
+}
diff --git a/tests/generic/808 b/tests/generic/808
new file mode 100755
index 00000000..36015f35
--- /dev/null
+++ b/tests/generic/808
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 808
+#
+# Test fiemap into an mmaped buffer of the same file
+#
+# Create a reasonably large file, then run a program which mmaps it and uses
+# that as a buffer for an fiemap call.  This is a regression test for btrfs
+# where we used to hold a lock for the duration of the fiemap call which would
+# result in a deadlock if we page faulted.
+#
+. ./common/preamble
+_begin_fstest quick auto fiemap
+[ $FSTYP == "btrfs" ] && \
+	_fixed_by_kernel_commit b0ad381fa769 \
+		"btrfs: fix deadlock with fiemap and extent locking"
+
+_cleanup()
+{
+	rm -f $dst
+	cd /
+	rm -r -f $tmp.*
+}
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_odirect
+_require_test_program fiemap-fault
+dst=$TEST_DIR/$seq/fiemap-fault
+
+mkdir -p $TEST_DIR/$seq
+
+echo "Silence is golden"
+
+for i in $(seq 0 2 1000)
+do
+	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
+done
+
+$here/src/fiemap-fault $dst
+
+# success, all done
+status=$?
+exit
+
diff --git a/tests/generic/808.out b/tests/generic/808.out
new file mode 100644
index 00000000..88253428
--- /dev/null
+++ b/tests/generic/808.out
@@ -0,0 +1,2 @@
+QA output created by 808
+Silence is golden
-- 
2.43.0


