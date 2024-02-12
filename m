Return-Path: <linux-btrfs+bounces-2333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A358519D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 17:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38C71C220B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB43FE4B;
	Mon, 12 Feb 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1jlBndVv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65F3FE27
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756085; cv=none; b=OCH0DwkxoVLhh0qfptuDiQ/2O5myBK1+x9EvHvTgbZ+VmH6E7N0BV4Vm5bTEdR8Nu8O0J5i++REY36VWm8KEw1H2W7A1iAFDaeuWXCfWz8tFo0+318Un+AzFahpkDR0JcK4R6Z22o1LnfmxUynPA3TZSXfuosDaVHacy1ffmSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756085; c=relaxed/simple;
	bh=epb3ZE2pUj0rsJc3jMNm/fEFDJj0VcoWz//9c7aeeUk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=umyEHgsChhY6uzuixs350UizrwU75vJupiNB2Y5XOC2ckf4ez0fRVdWVCSyKwxaOXmXN0HZwEAI0kFBTUG3lOH8/rBKvkvsQgVfJ5peS9nNkaq71JsJMQCd7rYkq3etO4DybazgqDvM2F/LpBVCgzsUgfcP4lvzRI/4SrgOXN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=1jlBndVv; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so3040352276.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 08:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1707756081; x=1708360881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pWmP8cD1oppmQWPDKNHc83Xf0dy07rnfCWlaGApWMFE=;
        b=1jlBndVvvWUtTs++885/M4SpI2oaD1vkiKVrNrWmxMbHaY0l2TNvuR1RdcXKaea2Rm
         TxcWB88z/PHuHLPPRDmLe7gRa1o1ZURE7QgwG/ofwGAl1CViiElNapXXlMdli8bsiJNu
         6yyWnbodFKGMROJQrCtPFija4CfixSo7/kxUmDq0iTn+nphOblZp8iZ4CqCBXK776vob
         Bqv36heJFIXLi7iRLLsa1ehWWuWfrseYqOkEmh0if6T+ICAuweA1MVksE/9V1vGnEI2i
         uhzhMCfdXI3HBUpzqKW5n/F6bmXBRbc3Sf99jRjG4eGuSb/E/StEt2CA5LxheAeMcEZj
         bCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756081; x=1708360881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWmP8cD1oppmQWPDKNHc83Xf0dy07rnfCWlaGApWMFE=;
        b=m4qvhkO2Cpc1l/EG5g0YyIuXXYSDP+L3jB08ZU7avMKcxT4VpfDUUSDQFN1DTyR3G7
         M7+5AQ0RwVW2JLep/EGDDA14GpIOtIsZ+lWUB8K9JRgSljPx6irXxXBrDohhwJ14bQmy
         N7TSvSkTM6XN1XpkD0ZFuSL4MxuunBXe8N3h4w63JyjxnnUvP6AZRXld7GDin9Wdilbx
         6hvMw0FGdYm9YrfHx1aTNDCuV9eLkVHvvmNGq9JJsqGPCDIUCmXxmA+douK271nXxPLW
         e4W/ZxJQo3sK2vRSeq/sF6s8GO/09gYISLxX3YFclRLwOmXlVVnPvMqEbEZ0NzhSiT68
         TsRA==
X-Gm-Message-State: AOJu0YyK18ScP3uaVndUEHfItGgHBth+gJE0mzREBflxG6eHtexLX10A
	2S2plnKyMl4sqw0Gek0k+rICiJPOq+CREkUd13L4Q8ABS0zB21pbjhzsbJQifnOBRTdA6xZJpjm
	V
X-Google-Smtp-Source: AGHT+IE+blzFUGEhic/nfeQt8OJoNtbfMw0fRwkfkseHRndHpcFgyM1btmnx/6vbfyI7HKamsL4zFg==
X-Received: by 2002:a05:6902:208a:b0:dc7:4800:c758 with SMTP id di10-20020a056902208a00b00dc74800c758mr6679573ybb.10.1707756081056;
        Mon, 12 Feb 2024 08:41:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbXRD5oOq7lYwoY/Y+rbstI80PBMIablq7ZLoTT35U95FaiqU94tCwBBKi8PaGjhLnWHCKmN+sVgPgy6CHqaOysRhpxOURwbihcU4=
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u61-20020a25ab43000000b00dc6e1cc7f9bsm1293367ybi.53.2024.02.12.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:41:20 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: add a regression test for fiemap into an mmap range
Date: Mon, 12 Feb 2024 11:41:14 -0500
Message-ID: <b8160b6dbaf4899ff95928a7af006a126baa8f9c.1707756045.git.josef@toxicpanda.com>
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
v1->v2:
- Add the fiemap group to the test.
- Actually include the reproducer helper program.

 src/Makefile          |  2 +-
 src/fiemap-fault.c    | 73 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/740     | 41 ++++++++++++++++++++++++
 tests/generic/740.out |  2 ++
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 src/fiemap-fault.c
 create mode 100644 tests/generic/740
 create mode 100644 tests/generic/740.out

diff --git a/src/Makefile b/src/Makefile
index d79015ce..916f6755 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
-	uuid_ioctl
+	uuid_ioctl fiemap-fault
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/fiemap-fault.c b/src/fiemap-fault.c
new file mode 100644
index 00000000..27081188
--- /dev/null
+++ b/src/fiemap-fault.c
@@ -0,0 +1,73 @@
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
+			err(1, "fiemap failed %d (%s)", errno, strerror(errno));
+		for (i = 0; i < fiemap->fm_mapped_extents; i++)
+		       last = fiemap->fm_extents[i].fe_logical +
+			       fiemap->fm_extents[i].fe_length;
+	}
+
+	close(fd);
+	return 0;
+}
diff --git a/tests/generic/740 b/tests/generic/740
new file mode 100644
index 00000000..30ace1dd
--- /dev/null
+++ b/tests/generic/740
@@ -0,0 +1,41 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 708
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
+	_fixed_by_kernel_commit xxxxxxxxxxxx \
+		"btrfs: fix deadlock with fiemap and extent locking"
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_odirect
+_require_test_program fiemap-fault
+dst=$TEST_DIR/fiemap-fault-$seq
+
+echo "Silence is golden"
+
+for i in $(seq 0 2 1000)
+do
+	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
+done
+
+$here/src/fiemap-fault $dst > /dev/null || _fail "failed doing fiemap"
+
+rm -f $dst
+
+# success, all done
+status=$?
+exit
+
diff --git a/tests/generic/740.out b/tests/generic/740.out
new file mode 100644
index 00000000..3f841e60
--- /dev/null
+++ b/tests/generic/740.out
@@ -0,0 +1,2 @@
+QA output created by 740
+Silence is golden
-- 
2.43.0


