Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148AD254883
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgH0PG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 11:06:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:44540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgH0PEb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 11:04:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73233B03B;
        Thu, 27 Aug 2020 15:05:01 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs/218: Test for i_nlink tracking
Date:   Thu, 27 Aug 2020 18:04:24 +0300
Message-Id: <20200827150426.23842-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827150426.23842-1-nborisov@suse.com>
References: <20200827150426.23842-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/218     | 170 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/218.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 173 insertions(+)
 create mode 100755 tests/btrfs/218
 create mode 100644 tests/btrfs/218.out

diff --git a/tests/btrfs/218 b/tests/btrfs/218
new file mode 100755
index 000000000000..571eca8a20e2
--- /dev/null
+++ b/tests/btrfs/218
@@ -0,0 +1,170 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 218
+#
+# Test that btrfs is correctly keeping track of link count for directories.
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
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_test
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+# Ensure we have sane start value of 1
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 1 ]; then
+	echo "Unexpected default link count: $linkcount expected: 1"
+fi
+
+# moving/copying/deleting files shouldn't affect link count
+touch $SCRATCH_MNT/foo
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 1 ]; then
+	echo "Unexpected link count after file creation: $linkcount expected: 1"
+fi
+
+cp $SCRATCH_MNT/foo $SCRATCH_MNT/bar
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 1 ]; then
+	echo "Unexpected link count after file copy: $linkcount expected: 1"
+fi
+
+rm $SCRATCH_MNT/bar
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 1 ]; then
+	echo "Unexpected link count after file delete: $linkcount expected: 1"
+fi
+
+# move the file to oblivion
+mv $SCRATCH_MNT/foo /dev/null
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 1 ]; then
+	echo "Unexpected link count after file move: $linkcount expected: 1"
+fi
+
+# Add a dir and verify link count is incremented
+mkdir $SCRATCH_MNT/foo
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 2 ]; then
+	echo "Unexpected link count after dir create: $linkcount expected: 2"
+fi
+
+# Check if copy also increments the link count
+cp -r $SCRATCH_MNT/foo $SCRATCH_MNT/bar
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 3 ]; then
+	echo "Unexpected link count after dir copy: $linkcount expected: 3"
+fi
+
+# Now see if rename decrements the count of the src and increments the count 
+# of the dst
+mv $SCRATCH_MNT/bar $SCRATCH_MNT/foo/
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 2 ]; then
+	echo "Unexpected link count at src after dir move: $linkcount expected: 2"
+fi
+
+
+linkcount=$(stat -c %h $SCRATCH_MNT/foo)
+if [ $linkcount != 2 ]; then
+	echo "Unexpected link count at dst after dir move: $linkcount expected: 2"
+fi
+
+# Now delete a directory and see if count is correctly decremented
+mkdir $SCRATCH_MNT/bar
+rmdir $SCRATCH_MNT/bar
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 2 ]; then
+	echo "Unexpected link count after dir removal: $linkcount expected: 2"
+fi
+
+# Now create a subvolume, it's also a dir
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol > /dev/null
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 3 ]; then
+	echo "Unexpected link count after subvol create: $linkcount expected: 3"
+fi
+
+mv $SCRATCH_MNT/subvol $SCRATCH_MNT/subvol1
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 3 ]; then
+	echo "Unexpected link count after subvol move in same dir: $linkcount expected: 3"
+fi
+
+# Move subvolume and see if src/dest counts are updated accordingly
+mv $SCRATCH_MNT/subvol1 $SCRATCH_MNT/foo/
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 2 ]; then
+	echo "Unexpected link count at src after subvol move: $linkcount expected: 2"
+fi
+
+linkcount=$(stat -c %h $SCRATCH_MNT/foo)
+if [ $linkcount != 3 ]; then
+	echo "Unexpected link count at dst after subvol move: $linkcount expected: 3"
+fi
+
+# Now delete it
+$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/foo/subvol1 > /dev/null
+linkcount=$(stat -c %h $SCRATCH_MNT/foo)
+if [ $linkcount != 2 ]; then
+	echo "Unexpected link count after subvol delete: $linkcount expected: 2"
+fi
+
+# snapshots are created in a different path
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snapshot1 > /dev/null
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 3 ]; then
+	echo "Unexpected link count after snapshot create: $linkcount expected: 3"
+fi
+
+# move snapshot 
+mv $SCRATCH_MNT/snapshot1 $SCRATCH_MNT/foo
+linkcount=$(stat -c %h $SCRATCH_MNT)
+if [ $linkcount != 2 ]; then 
+	echo "Unexpected link count after at src after snapshot move: $linkcount expected: 2"
+fi
+
+linkcount=$(stat -c %h $SCRATCH_MNT/foo)
+if [ $linkcount != 3 ]; then 
+	echo "Unexpected link count after at dst after snapshot move: $linkcount expected: 2"
+fi
+
+# delete snapshot
+$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/foo/snapshot1 > /dev/null
+linkcount=$(stat -c %h $SCRATCH_MNT/foo)
+if [ $linkcount != 2 ]; then 
+	echo "Unexpected link count after after snapshot delete: $linkcount expected: 2"
+fi
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/218.out b/tests/btrfs/218.out
new file mode 100644
index 000000000000..1ef372a2a24b
--- /dev/null
+++ b/tests/btrfs/218.out
@@ -0,0 +1,2 @@
+QA output created by 218
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 8dcb23156236..94c1ec2806dc 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -220,3 +220,4 @@
 215 auto quick
 216 auto quick seed
 217 auto quick trim dangerous
+218 auto quick subvol
-- 
2.17.1

