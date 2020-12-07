Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423FA2D15D5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgLGQTt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 11:19:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGQTt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Dec 2020 11:19:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607357942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjhpiQIww6cHdM89Lhdss+fgViV341z4VwO2D3FuemY=;
        b=OeSDTpipnYUwvv0oG4yh8I+XNRPcg+jSWqyHrXzskL3SSoFf6phs52ABKjVGqNi2oI0R44
        l0jXSE02YzUsgGcNiAISczwwEorEmPcRQ/KMBLalF25AglKWKEc17FvQpOrHk7NxGZdRTI
        W8BPSg1q9gPyAb40KAibgB6gLTnyk0E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 686CEACBA;
        Mon,  7 Dec 2020 16:19:02 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [RESEND PATCH] btrfs: Add test 154
Date:   Mon,  7 Dec 2020 18:19:00 +0200
Message-Id: <20201207161900.1079190-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207153237.1073887-1-nborisov@suse.com>
References: <20201207153237.1073887-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test verifies btrfs' free objectid management. I.e it ensures that
the first objectid is always 256 in an fs tree.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Resend it as I fudged btrfs' mailing list address so the patch didn't get to it.
 tests/btrfs/154     | 80 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/154.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 83 insertions(+)
 create mode 100755 tests/btrfs/154
 create mode 100644 tests/btrfs/154.out

diff --git a/tests/btrfs/154 b/tests/btrfs/154
new file mode 100755
index 000000000000..6aee204e05cb
--- /dev/null
+++ b/tests/btrfs/154
@@ -0,0 +1,80 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 154
+#
+# Test correct operation of free objectid related functionality
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
+_require_scratch
+
+
+_scratch_mkfs > /dev/null
+_scratch_mount
+
+# create a new subvolume to validate its objectid is initialized accordingly
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/newvol >> $seqres.full 2>&1 \
+	|| _fail "couldn't create subvol"
+
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t1 $SCRATCH_DEV \
+	| grep -q "256 ROOT_ITEM"  ||	_fail "First subvol with id 256 doesn't exist"
+
+# create new file in the new subvolume to validate its objectid is set as
+# expected
+touch $SCRATCH_MNT/newvol/file1
+
+# ensure we have consistent view on-disk
+sync
+
+# get output related to the new root's dir entry
+output=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t5 $SCRATCH_DEV | grep -A2 "256 DIR_ITEM 1903355334")
+
+# get the objectid of the new root
+new_root_id=$(echo "$output" | awk '/location key/{printf $3}' | tr -d  '(')
+[ $new_root_id -eq 256 ] || _fail "New root id not equal to 256"
+
+# the given root should always be item number 2, since it's the only item
+item_seq=$(echo "$output" | awk '/item/ {printf $2}')
+[ $item_seq -eq 2 ] || _fail "New root not at item idx 2"
+
+# now parse the structure of the new subvol's tree
+output=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t256 $SCRATCH_DEV)
+
+# this is the subvol's own ino
+first_ino=$(echo "$output" | awk '/item 0/{printf $4}' | tr -d '(')
+[ $first_ino -eq 256 ] || _fail "First ino objectid in subvol not 256"
+
+# this is ino of first file in subvol
+second_ino=$(echo "$output" | awk '/item 4/{printf $4}' | tr -d '(')
+[ $second_ino -eq 257 ] || _fail "Second ino objectid in subvol not 257"
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/154.out b/tests/btrfs/154.out
new file mode 100644
index 000000000000..a18c304305c4
--- /dev/null
+++ b/tests/btrfs/154.out
@@ -0,0 +1,2 @@
+QA output created by 154
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index d18450c7552e..44d33222def0 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -156,6 +156,7 @@
 151 auto quick volume
 152 auto quick metadata qgroup send
 153 auto quick qgroup limit
+154 auto quick
 155 auto quick send
 156 auto quick trim balance
 157 auto quick raid
--
2.17.1

