Return-Path: <linux-btrfs+bounces-3478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F58814D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54581C21298
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D71B53392;
	Wed, 20 Mar 2024 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Ba2gh0LA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841084207B
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949620; cv=none; b=nS8xTwefNMYpKeE+c64IYuPGRUT1bM+6shZD06ilR6CiROjnAbrydQWmCuViCsSLbn1Mxh2bG59j54DhfhnMb66d8Sp5xLwI6NcAkDCRem9Imb3vlZT4XePenBpv7eAxPugnqtD8u/4K4fMGxkahS6moxLjUUsDjoWZC732g6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949620; c=relaxed/simple;
	bh=ROG10aiKRy8abe8GAm8jiMxc0m/XHGH+I0quzf48alw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kRiK8mvK1/vXqwJx1MK1ACNrVMA2hw1tkLPfVeO39HdtUpsKQNYqNrxyPICqUyutJLJVXkljf/brZwhleiyOFFarnjgHzfymOH/7mig+fzzqBnul4vXU4U8ZpRu7qcosgBDU/i4yhiQQb/n6QRTJBMvuHhJI0e1iszrc9vo/lgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Ba2gh0LA; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430b6ff2a20so4871cf.2
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710949617; x=1711554417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNbiwTWnXcJz/ElivDi7+5EciYwqMNlLpxDWUe4IuCo=;
        b=Ba2gh0LAUkaQ73cv/l68/BUYDNrO7/TsosVE5Kj+K3ZVXsCTlQbk+84ZieyJkIlOW+
         tivhMvnF28NrJVt191gFP6nvb1IGWyNrkRW/LEL8swmq4H5uYxYZa9gjf2Ny7lu983mP
         5Hj3U+o1Vh4No0d5TMs+L4hNoDSezbnmGW0DarbfLkHRMRMTEog6TYue9ycB9ckxHdk8
         xsxNE2qer+HngaJ7WTA7CG/CE6a7phl0P23J+XUIBKlUE9edoJm6JjyZ1GKbh1qOgzCx
         /Hk/8j0JA2hrpmfnUVd8hqWmGgzHV60Z2bG9yLLYQH4HU79PdU2SPY0K3nLCzLHp9XwH
         G5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710949617; x=1711554417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNbiwTWnXcJz/ElivDi7+5EciYwqMNlLpxDWUe4IuCo=;
        b=oK5HbBFWvTDLj3r+iuZlEcDYo3mY++PR4hVg0fesLXHRxB3ac3npIBq7DyMSULl7u4
         th2ip4+YKHbICj9ZvwQJG+6DBg9+lfKO79Pl0zWILAUyQVVqTM0c8YOrkRICoyvCI644
         1Ka2QEpXBimrKcEMusMx+9cW69g0jz2JPYf/sUQ0H6C3UfWZI9K5/+tE51nYzjwS7EUD
         fm2nTk+i2oEN9FMufWHtbLAuqToVeFEtx7Kasy/gsi8LhPGKZGghVjJeNWO8Ges/zQVr
         25aT5HXXZ6EEBrtLfmCV2FZqtgIxp4J+pp5t9PATknEOA/mozUVEYFb8/Ir+2NqGJXg6
         I5ow==
X-Gm-Message-State: AOJu0Yzp2NB0e50prOMM9waQd2T2lH1vryVtk72VY8ZF94b2F171Agdy
	Bp42OEeDUaJ1D0fI1Kk0ko93z8e0DDnfvYGqtWcHkU1b1L9Sp84e08QaVgS1kwfj9DjvRk8G4hy
	d
X-Google-Smtp-Source: AGHT+IG2av7u4uf7JwabO0TD69Lkw5YhoyDzhw9YseeVwplqQLFjUFxYNZdPOl+Tg+SpYrzAkiDsJg==
X-Received: by 2002:ac8:5889:0:b0:42e:d581:f735 with SMTP id t9-20020ac85889000000b0042ed581f735mr2752886qta.17.1710949617197;
        Wed, 20 Mar 2024 08:46:57 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w15-20020ac8718f000000b0042ee2920298sm6896963qto.61.2024.03.20.08.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:46:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v4] generic/808: add a regression test for fiemap into an mmap range
Date: Wed, 20 Mar 2024 11:46:50 -0400
Message-ID: <dc1a90179b8de25340bd45f4e54cda8c3ab66398.1710949564.git.josef@toxicpanda.com>
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
v3->v4:
- Rework this to use punch-alternating to generate a fragmented file.
- Rework the _require's to reflect the new mode of fragmenting a file.

 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/fiemap-fault.c    | 74 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/808     | 51 +++++++++++++++++++++++++++++
 tests/generic/808.out |  2 ++
 5 files changed, 129 insertions(+), 1 deletion(-)
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
index 00000000..a3570076
--- /dev/null
+++ b/tests/generic/808
@@ -0,0 +1,51 @@
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
+_require_test_program "fiemap-fault"
+_require_test_program "punch-alternating"
+_require_xfs_io_command "fpunch"
+
+dst=$TEST_DIR/$seq/fiemap-fault
+
+mkdir -p $TEST_DIR/$seq
+
+echo "Silence is golden"
+
+# Generate a file with lots of extents
+blksz=$(_get_file_block_size $TEST_DIR)
+$XFS_IO_PROG -f -c "pwrite -q 0 $((blksz * 10000))" $dst
+$here/src/punch-alternating $dst
+
+# Now run the reproducer
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


