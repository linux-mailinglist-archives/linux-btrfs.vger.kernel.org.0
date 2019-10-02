Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B4BC9100
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 20:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfJBSli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 14:41:38 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:32800 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBSli (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 14:41:38 -0400
Received: by mail-qk1-f174.google.com with SMTP id x134so16110059qkb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2019 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lIVT3jFPw6k+aNp9uTRpNgvLeVg+3uvDlpVSa/R+fEE=;
        b=B73xyAt7MtyZxC2VKf831r4uBQTyS2qRFV6Q7feHDRlOA2ydnco8WMmbDnGF+cKeYR
         bQbqJpWZ4iMyr8oG5AsBjJG413kteIbYs4AsJ/MPZ8V5VTTiFLdi2YtpjCX7vnRQUx3B
         1Eg+EKI3AlGBhl0gT/ftCcuULdKkyrMr/pTolzLwSLj0kHb/iVHXDY9w3KB/aokoWMyU
         yH5R6WbwHvvcp5OzHh6HaMNDKgTwdpfdSTl9+0I2DAKs9UJQGajaOjJG/DzLqK/XR3Wz
         UGJvefL/eF/zp+hDbZIAszRII9szDkU47ml7IQwzOSbAqohGpJytlS5szHtRYZXv8nog
         vgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lIVT3jFPw6k+aNp9uTRpNgvLeVg+3uvDlpVSa/R+fEE=;
        b=ilxeRLDYmsF9bJcpcqqZtcwjB2TjpxPU70EHiHkVCVrhLXzIuwqPqSBiWqXAE1SEve
         FshXQXgUUvU8SDgsJDlSaxcyEN9hh5r1yTsFm8BCEAEUU2l05xUexkK8NLki/dtn+793
         zKIE1joM4tg7stHlACCB5658x9V7EcG+nn+sbnMBIj+Awy7G2NHa+R4n9fUF2YUOIfah
         VasziKAvjxcTvEryijY7jDzxAyTov52CChoF7kSqDGX57MHaU8VEvDtsX4dvImpQz8A3
         NPhXe4OV9J4gFCeV/62butVksmv+yUNtxUuT5ycvaKGEXaIEfvJHTstYnpYoSY5OwBeW
         dniQ==
X-Gm-Message-State: APjAAAWPxwQMRL+5UyIlo8hIOTuNOp5CSrFeII8cg9A54GeygBonMCVW
        Jf3s8H4biVmFoehJVUBIJsZgZkcP3KrxWA==
X-Google-Smtp-Source: APXvYqy/FEDPTl7JBDCsOYEzpNTgwB7ohRu1qopl/ntGoS7dQtjaB/x2vOKNSNYnmRAE/cssF4psZA==
X-Received: by 2002:a37:6156:: with SMTP id v83mr261565qkb.80.1570041695612;
        Wed, 02 Oct 2019 11:41:35 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q64sm16224qkb.32.2019.10.02.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 11:41:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH][v2] btrfs/194: add a test for multi-subvolume fsyncing
Date:   Wed,  2 Oct 2019 14:41:33 -0400
Message-Id: <20191002184133.21099-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I discovered a problem in btrfs where we'd end up pointing at a block we
hadn't written out yet.  This is triggered by a race when two different
files on two different subvolumes fsync.  This test exercises this path
with dm-log-writes, and then replays the log at every FUA to verify the
file system is still mountable and the log is replayable.

This test is to verify the fix

btrfs: fix incorrect updating of log root tree

actually fixed the problem.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- added the patchname related to this test in the comments and changelog.
- running fio makes it use 400mib of shared memory, so running 50 of them is
  impossible on boxes that don't have hundreds of gib of RAM.  Fixed this to
  just generate a fio config so we can run 1 fio instance with 50 threads which
  makes it not OOM boxes with tiny amounts of RAM.
- fixed some formatting things that Filipe pointed out.

 tests/btrfs/194     | 111 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/194.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 114 insertions(+)
 create mode 100755 tests/btrfs/194
 create mode 100644 tests/btrfs/194.out

diff --git a/tests/btrfs/194 b/tests/btrfs/194
new file mode 100755
index 00000000..b98064e2
--- /dev/null
+++ b/tests/btrfs/194
@@ -0,0 +1,111 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Facebook.  All Rights Reserved.
+#
+# FS QA Test 194
+#
+# Test multi subvolume fsync to test a bug where we'd end up pointing at a block
+# we haven't written.  This was fixed by the patch
+#
+# btrfs: fix incorrect updating of log root tree
+#
+# Will do log replay and check the filesystem.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+fio_config=$tmp.fio
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	_log_writes_cleanup &> /dev/null
+	_dmthin_cleanup
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmthin
+. ./common/dmlogwrites
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+
+# Use thin device as replay device, which requires $SCRATCH_DEV
+_require_scratch_nocheck
+# and we need extra device as log device
+_require_log_writes
+_require_dm_target thin-pool
+
+cat >$fio_config <<EOF
+[global]
+readwrite=write
+fallocate=none
+bs=4k
+fsync=1
+size=128k
+EOF
+
+for i in $(seq 0 49); do
+	echo "[foo$i]" >> $fio_config
+	echo "filename=$SCRATCH_MNT/$i/file" >> $fio_config
+done
+
+_require_fio $fio_config
+
+cat $fio_config >> $seqres.full
+
+# Use a thin device to provide deterministic discard behavior. Discards are used
+# by the log replay tool for fast zeroing to prevent out-of-order replay issues.
+_test_unmount
+_dmthin_init $devsize $devsize $csize $lowspace
+_log_writes_init $DMTHIN_VOL_DEV
+_log_writes_mkfs >> $seqres.full 2>&1
+_log_writes_mark mkfs
+
+_log_writes_mount
+
+# First create all the subvolumes
+for i in $(seq 0 49); do
+	$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/$i" > /dev/null
+done
+
+$FIO_PROG $fio_config > /dev/null 2>&1
+_log_writes_unmount
+
+_log_writes_remove
+prev=$(_log_writes_mark_to_entry_number mkfs)
+[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
+cur=$(_log_writes_find_next_fua $prev)
+[ -z "$cur" ] && _fail "failed to locate next FUA write"
+
+while [ ! -z "$cur" ]; do
+	_log_writes_replay_log_range $cur $DMTHIN_VOL_DEV >> $seqres.full
+
+	# We need to mount the fs because btrfsck won't bother checking the log.
+	_dmthin_mount
+	_dmthin_check_fs
+
+	prev=$cur
+	cur=$(_log_writes_find_next_fua $(($cur + 1)))
+	[ -z "$cur" ] && break
+done
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
new file mode 100644
index 00000000..7bfd50ff
--- /dev/null
+++ b/tests/btrfs/194.out
@@ -0,0 +1,2 @@
+QA output created by 194
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index b92cb12c..0d0e1bba 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -196,3 +196,4 @@
 191 auto quick send dedupe
 192 auto replay snapshot stress
 193 auto quick qgroup enospc limit
+194 auto metadata log volume
-- 
2.21.0

