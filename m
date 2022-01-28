Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97B49EFA3
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 01:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbiA1A2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 19:28:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54128 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344985AbiA1A1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 19:27:22 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4344D1F385;
        Fri, 28 Jan 2022 00:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643329641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10Ij3d7KYP62gCYiX+SIsQd2/6yMD/1U85EwuNMzEds=;
        b=VEDr1glWq6afTqVVhUf1eQH52COyL3pHEuQu8DTCC3T8wNmjp8HuRDy1xaEzNWBJH/gczQ
        ok5mRuSURBFaehFmRcXdLF4Q9dJMU7DZqyDbCH8f6upetDtE9rfNj8dBFxnmmDvkHxUOB4
        lv5cv1B0WfPIB/hEamVKQqXL9YhYU7k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67A0C139F7;
        Fri, 28 Jan 2022 00:27:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mBw0DWg482FQQAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 28 Jan 2022 00:27:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: test autodefrag with regular and hole extents
Date:   Fri, 28 Jan 2022 08:27:00 +0800
Message-Id: <20220128002701.11971-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128002701.11971-1-wqu@suse.com>
References: <20220128002701.11971-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In v5.11~v5.15 kernels, there is a regression in autodefrag that if a
cluster (up to 256K in size) has even a single hole, the whole cluster
will be rejected.

This will greatly reduce the efficiency of autodefrag.

The behavior is fixed in v5.16 by a full rework, although the rework
itself has other problems, it at least solves the problem.

Here we add a test case to reproduce the case, where we have a 128K
cluster, the first half is fragmented extents which can be defragged.
The second half is hole.

Make sure autodefrag can defrag the 64K part.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use the previously define _get_file_extent_sector() helper
  This also removed some out-of-sync error messages

- Trigger autodefrag using commit=1 mount option
  No need for special purpose patch any more.

- Use xfs_io -s to skip several sync calls

- Shorten the subject of the commit
---
 tests/btrfs/256     | 80 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/256.out |  2 ++
 2 files changed, 82 insertions(+)
 create mode 100755 tests/btrfs/256
 create mode 100644 tests/btrfs/256.out

diff --git a/tests/btrfs/256 b/tests/btrfs/256
new file mode 100755
index 00000000..def83a15
--- /dev/null
+++ b/tests/btrfs/256
@@ -0,0 +1,80 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 256
+#
+# Make sure btrfs auto defrag can properly defrag clusters which has hole
+# in the middle
+#
+. ./common/preamble
+_begin_fstest auto defrag quick
+
+. ./common/btrfs
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_scratch
+
+# Needs 4K sectorsize, as larger sectorsize can change the file layout.
+_require_btrfs_support_sectorsize 4096
+
+_scratch_mkfs >> $seqres.full
+
+# Need datacow to show which range is defragged, and we're testing
+# autodefrag
+_scratch_mount -o datacow,autodefrag
+
+# Create a layout where we have fragmented extents at [0, 64k) (sync write in
+# reserve order), then a hole at [64k, 128k)
+$XFS_IO_PROG -f -s -c "pwrite 48k 16k" -c "pwrite 32k 16k" \
+		-c "pwrite 16k 16k" -c "pwrite 0 16k" \
+		$SCRATCH_MNT/foobar >> $seqres.full
+truncate -s 128k $SCRATCH_MNT/foobar
+
+old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
+echo "=== File extent layout before autodefrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+echo "old md5=$old_csum" >> $seqres.full
+
+old_regular=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
+old_hole=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 64k)
+
+# Now trigger autodefrag, autodefrag is triggered in the cleaner thread,
+# which will be woken up by commit thread
+_scratch_remount commit=1
+sleep 3
+sync
+
+new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
+new_regular=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
+new_hole=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 64k)
+
+echo "=== File extent layout after autodefrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+echo "new md5=$new_csum" >> $seqres.full
+
+# In v5.11~v5.15 kernels, regular extents won't get defragged, and would trigger
+# the following output
+if [ $new_regular == $old_regular ]; then
+	echo "regular extents didn't get defragged"
+fi
+
+# In v5.10 and earlier kernel, autodefrag may choose to defrag holes,
+# which should be avoided.
+if [ "$new_hole" != "$old_hole" ]; then
+	echo "hole extents got defragged"
+fi
+
+# Defrag should not change file content
+if [ "$new_csum" != "$old_csum" ]; then
+	echo "file content changed"
+fi
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/256.out b/tests/btrfs/256.out
new file mode 100644
index 00000000..7ee8e2e5
--- /dev/null
+++ b/tests/btrfs/256.out
@@ -0,0 +1,2 @@
+QA output created by 256
+Silence is golden
-- 
2.34.1

