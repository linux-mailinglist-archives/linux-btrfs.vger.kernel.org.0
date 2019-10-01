Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A243C418A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 22:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfJAUFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 16:05:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42802 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfJAUFy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Oct 2019 16:05:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so23248009qto.9
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2019 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDToH36jGrSgUXlhVovm1t2tVCj5/o7XLeE1yAcWNV4=;
        b=wKwmSJK2Xo9blIHVQN+8tRRGs4c8M/iCTM06VFp511+9Eg7n3M/TbTu7DZERArPphu
         ++iA8KgJHiQTAGUDV3JvcQaF6fjjKP8DezAx4TgDX886mUZ1KtxaY4f7O0UWrV++srUX
         FMeVmXr0N3yD3g8aEB1nyPOHkOuUer3yQH0VRka/gA3W7cDB7piSZFQfcNrPLiIuguGR
         t+czq5r6/aW1CBMnwoopWGi7zgdhRHi7dGlHH9SpCMc7MFwrZZ1iQdEVc4866TAGBJ7j
         Fks6MP3SbxEg7PC7ajSMijkvPIP4lNl4uTKbp0OReC7qIczUWRMrofTFgsi62eBN1RUV
         DaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDToH36jGrSgUXlhVovm1t2tVCj5/o7XLeE1yAcWNV4=;
        b=lhcujRkL2FMH1Oi+/DBXnWC6LYTLXFtEDPmEoxEKygoE2s1icA1A1CA4bOQ/4kq6Nj
         96iRY5ZiUoseV5DCjjOTJhrN/BRLBr0grENNFM2b540ETWh8owqZ6EptvuNx9e+0V61t
         GtoqUSBpTsfahZ02vu5yD7pTQXB5v+xQE7oQwIEsvSeQhG+5Pev3hO7ME9zmiWCBk1VW
         uxTjCLptyQTiR1pH6yc6czbOk3wXeRJLnZlMiKzuHB0av5pPdyz142Kszgo5ShtebrWi
         yZWyPx41/p92rsjZpSCasZLkvJl8XnV9nDZTf/1hVJQCsrVIXKD+olEseoYIZ+PVkNGH
         gfLQ==
X-Gm-Message-State: APjAAAVuHgyvMcbsLWTyqmJRyy1Gga620S5Qvm0xCsUOLRErnVIzZDLd
        5rzfc12RENqUENEUJ1OkkTKOuxbIqgvE0g==
X-Google-Smtp-Source: APXvYqz7ZQsQRXb0LfObvCx3O4iwO27roc866AiE/TUsasbf8IXk5iTCWr+bI6bn8eczkHvEpx1YiA==
X-Received: by 2002:ac8:2bf7:: with SMTP id n52mr54244qtn.310.1569960353244;
        Tue, 01 Oct 2019 13:05:53 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y26sm11919157qtk.22.2019.10.01.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 13:05:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH] btrfs/194: add a test for multi-subvolume fsyncing
Date:   Tue,  1 Oct 2019 16:05:51 -0400
Message-Id: <20191001200551.1513-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

I discovered a problem in btrfs where we'd end up pointing at a block we
hadn't written out yet.  This is triggered by a race when two different
files on two different subvolumes fsync.  This test exercises this path
with dm-log-writes, and then replays the log at every FUA to verify the
file system is still mountable and the log is replayable.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/194     | 102 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/194.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 105 insertions(+)
 create mode 100755 tests/btrfs/194
 create mode 100644 tests/btrfs/194.out

diff --git a/tests/btrfs/194 b/tests/btrfs/194
new file mode 100755
index 00000000..d5edb313
--- /dev/null
+++ b/tests/btrfs/194
@@ -0,0 +1,102 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Facebook.  All Rights Reserved.
+#
+# FS QA Test 194
+#
+# Test multi subvolume fsync to test a bug where we'd end up pointing at a block
+# we haven't written.
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
+	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
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
+_require_fio
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
+for i in $(seq 0 49)
+do
+	$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/sub$i" > /dev/null
+done
+
+# Then run 100 fio jobs in parallel
+for i in $(seq 0 49)
+do
+	fio --name=seq --readwrite=write --fallocate=none --bs=4k --fsync=1 \
+		--size=64k --filename="$SCRATCH_MNT/sub$i/file" \
+		> /dev/null 2>&1 &
+done
+wait
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

