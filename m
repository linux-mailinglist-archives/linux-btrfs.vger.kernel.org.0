Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15DBCECDC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfJGTdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 15:33:43 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:43994 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfJGTdn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 15:33:43 -0400
Received: by mail-qt1-f182.google.com with SMTP id c4so8226842qtn.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCrDiFIy/8kr0/sCxfCpQIxG631Ehcjx2HxXxScXlWU=;
        b=b9D9yic2tFPsBjbAf8JOzRSyrxZTS3D7NLHiJDdSbYwLT/sB0gWtR84u6A4iDDkSdK
         wOEYfIipuM7FxgQatWTOm2ylxzsi0S158CnW8u/dTXF2s2XVEilrJ2nyDkEu5jORxwGC
         bT7+U20ApMPNeJZvoP0Ws0/6/9aBUnxnWLwWyiwRllSkERVFaHBPIubquWxZd0UxBtC6
         YNFHjwtRPn4UkCjvEXOPWrjN4faoZqsWVvCwuLjcfNzXETcME4B58gh+9B8enS7bMmaL
         e+6AX23i7YepxcAAPHSy0ZWUd0GwEyPs8wR8a5Wb+HVL29ZuRbhh65VadGSZA78t01xj
         +Siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCrDiFIy/8kr0/sCxfCpQIxG631Ehcjx2HxXxScXlWU=;
        b=QxKJfH7zfWK0lGvuuE/v2GPwjFbTABYSr7uhgeACooNOorhkg9qBE0kXkuA01RXlvB
         dacXFzNgDUmVNi4bnYxAaXeFHYd8wUM2zFDKDD9hcuyeta0EqL2B2QLyoodZ2YlMCxrT
         VOR1DZky+VYQV0LoLJinAlFHTaDRgY1uHxauvU+Ep//dXjxOA6Z/Qh3cihrjGekcTYRf
         qwNmf8J4ntb67z4eW4/6KbD1eVjVG8wL6DRi9sQTrF5IwkQRq7lmQl0GdoPoJfx8H61K
         zWm7Wy0/CXPieHL1JPGkNyJLTt42kqvjtjj+o6ruvY3hYNuFYOn2nojWHDT9f1ccBSzN
         4Uzg==
X-Gm-Message-State: APjAAAXSY1Ly+mspnS3mt7PrrFZ5QVvY3j6HAo+5NSZPDJRrrkEWSt3C
        t6e67lcybIDDvSKIG2QOMPGSZA==
X-Google-Smtp-Source: APXvYqwZo6hUSHEeXFjo+073gFzhEZnVwlB9bqXpTaP8t+36L1ukTQLwmaCb35qgGLz3oOy9zVI+JQ==
X-Received: by 2002:aed:3576:: with SMTP id b51mr32357621qte.378.1570476821413;
        Mon, 07 Oct 2019 12:33:41 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y26sm10056673qtk.22.2019.10.07.12.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 12:33:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH][v3] btrfs/194: add a test for multi-subvolume fsyncing
Date:   Mon,  7 Oct 2019 15:33:39 -0400
Message-Id: <20191007193339.4054-1-josef@toxicpanda.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v2->v3:
- cleaned up various bits that were leftover from the original test I copied
  from.
- added Filipe's reviewed-by.

 tests/btrfs/194     | 110 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/194.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 113 insertions(+)
 create mode 100755 tests/btrfs/194
 create mode 100644 tests/btrfs/194.out

diff --git a/tests/btrfs/194 b/tests/btrfs/194
new file mode 100755
index 00000000..b7ab3a66
--- /dev/null
+++ b/tests/btrfs/194
@@ -0,0 +1,110 @@
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
+_supported_fs btrfs
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
+_dmthin_init
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

