Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10462F290D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 08:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbhALHlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 02:41:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:35648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbhALHlQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 02:41:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610437229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=l+17Z8U17hn65EbMyeS56FVSsrCwYzu5MR5vEvORGN8=;
        b=OvG2OkYtSDMeir66Y+UoD3lzyL8mIx92kqV7iX6zEZ32ZhLQnk+eZsDYovDHQYgA6EDgfK
        7y7WwM+gsq8ZXMzMEZEaby91IjHIBwBT1y/OBVJWIB1B/TcGes1y4DO4ic3DU/pjluqpaJ
        j+iVUfc8XvpN3UXjZ/ngCIpjiv1pmYE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22E36AB92;
        Tue, 12 Jan 2021 07:40:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] fstests: btrfs: check qgroup doesn't crash when beyond limit
Date:   Tue, 12 Jan 2021 15:40:24 +0800
Message-Id: <20210112074024.85020-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug that, when btrfs is beyond qgroup limit, touching a file
could crash btrfs.

Such beyond limit situation needs to be intentionally created, e.g.
writing 1GiB file, then limit the subvolume to 512 MiB.
As current qgroup works pretty well at preventing us from reaching the
limit.

This makes existing qgroup test cases unable to detect it.

The regression is introduced by commit c53e9653605d ("btrfs: qgroup: try
to flush qgroup space when we get -EDQUOT"), and the fix is titled
"btrfs: qgroup: don't commit transaction when we have already
 hold a transaction handler"

Link: https://bugzilla.suse.com/show_bug.cgi?id=1178634
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use "0/5" to replace the double "$SCRATCH_MNT" in btrfs qgroup command
  To reduce confusion.
---
 tests/btrfs/228     | 59 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/228.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 62 insertions(+)
 create mode 100755 tests/btrfs/228
 create mode 100644 tests/btrfs/228.out

diff --git a/tests/btrfs/228 b/tests/btrfs/228
new file mode 100755
index 00000000..ecca3181
--- /dev/null
+++ b/tests/btrfs/228
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 228
+#
+# Test if btrfs qgroup would crash if we're modifying the fs
+# after exceeding the limit
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs btrfs
+
+# Need at least 2GiB
+_require_scratch_size $((2 * 1024 * 1024))
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+_pwrite_byte 0xcd 0 1G $SCRATCH_MNT/file >> $seqres.full
+# Make sure the data reach disk so later qgroup scan can see it
+sync
+
+$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
+$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+
+# Set the limit to just 512MiB, which is way below the existing usage
+$BTRFS_UTIL_PROG qgroup limit  512M 0/5 $SCRATCH_MNT
+
+# Touch above file, if kernel not patched, it will trigger an ASSERT()
+#
+# Even for patched kernel, we will still get EDQUOT error, but that
+# is expected behavior.
+touch $SCRATCH_MNT/file 2>&1 | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/228.out b/tests/btrfs/228.out
new file mode 100644
index 00000000..9c250148
--- /dev/null
+++ b/tests/btrfs/228.out
@@ -0,0 +1,2 @@
+QA output created by 228
+touch: setting times of 'SCRATCH_MNT/file': Disk quota exceeded
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 1868208e..9b0dc5ca 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -230,3 +230,4 @@
 225 auto quick volume seed
 226 auto quick rw snapshot clone prealloc punch
 227 auto quick send
+228 auto quick qgroup limit
-- 
2.28.0

