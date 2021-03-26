Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A695E34A6F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 13:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCZMQB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 08:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhCZMPi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 08:15:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0891561A2A;
        Fri, 26 Mar 2021 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616760937;
        bh=9unSVZEWklMLC1Rthx0NCd0ZWcdkijPJcDodpAMh8wo=;
        h=From:To:Cc:Subject:Date:From;
        b=WIJ8v6XdYpTxkvtdvBJKEgFuRrDlPO+v/aGTqbGTwh41ugYrUi2nurGPEKmlM9C6v
         3xbO5uAOPcc0sH73owreffNkvoC+R9Pyq6dgY+Iva34UIrYA31ane0xUdIa7ACK8lA
         bWfH5zr/QPk9eRlzAQYxWNbD6jAeM3IP+KYWMUcKpAf32Cfrx22r0thLxBuROJzQBv
         Vmcl0vxD46yEOtMMeIU0qY7T6J0/9PVjC41af3oEDLf60LGG3v83FSK81F1QAkStjm
         sg2RJzpG1qg/JmDYkkXLFhTLOLzF8SZX52ZcBDNAqNShgm8FC3zbR1hJFM0rnj9neT
         o7AMMfX7ijvQw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: add test for send/receive with file capabilities set
Date:   Fri, 26 Mar 2021 12:15:32 +0000
Message-Id: <5732398041302370543ae1ca008645c15147ceae.1616760875.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we set a capability on a file but not on the next files we
create, send/receive operations only apply the capability to the first
file, the one for which we have set a capability.

This is motivated by a regression that started to happen with kernel 5.8,
caused by an incompatibility between kernel commit 89efda52e6b693
("btrfs: send: emit file capabilities after chown") and a workaround for
send/receive added to btrfs-progs several years ago by btrfs-progs
commit 123a2a085027e ("btrfs-progs: receive: restore capabilities after
chown"). That workaround in btrfs-progs was added in btrfs-progs 4.1.

That kernel commit ended up fixing the bugs the btrfs-progs commit
targeted, as well as other bugs around btrfs send and capabilities.
However it did not play nice with the btrfs-progs workaround.
The kernel fix was backported to all stable kernels and the btrfs-progs
workaround was later removed from btrfs-progs by commit 81d8ea9346c6ee
("btrfs-progs: receive: remove workaround for setting capabilities"),
introduced in btrfs-progs 5.11.

The test currently fails on any environment using kernel 5.8+ and a
btrfs-progs version between 4.1 and 5.10. Updating btrfs-progs to
version 5.11 makes the test pass.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/235     | 113 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/235.out |  17 +++++++
 tests/btrfs/group   |   1 +
 3 files changed, 131 insertions(+)
 create mode 100755 tests/btrfs/235
 create mode 100644 tests/btrfs/235.out

diff --git a/tests/btrfs/235 b/tests/btrfs/235
new file mode 100755
index 00000000..600dad95
--- /dev/null
+++ b/tests/btrfs/235
@@ -0,0 +1,113 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. btrfs/235
+#
+# Test that if we set a capability on a file but not on the next files we create,
+# send/receive operations only apply the capability to the first file, the one
+# for which we have set a capability.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -fr $send_files_dir
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs btrfs
+_require_test
+_require_scratch
+_require_command "$SETCAP_PROG" setcap
+_require_command "$GETCAP_PROG" getcap
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -f $seqres.full
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+touch $SCRATCH_MNT/foo
+touch $SCRATCH_MNT/bar
+touch $SCRATCH_MNT/baz
+
+# Set a capability only on file foo. Note that file foo has a lower inode number
+# then files bar and baz - we want to test that if a file with a lower inode
+# number has a capability set, after a send/receive, the capability is not set
+# on the next files that have higher inode numbers.
+$SETCAP_PROG cap_net_raw=p $SCRATCH_MNT/foo
+
+# Now create the base snapshot, which is going to be the parent snapshot for
+# a later incremental send.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/mysnap1 > /dev/null
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+
+# Now do something similar as before, but this time to test incremental
+# send/receive instead.
+
+touch $SCRATCH_MNT/foo2
+touch $SCRATCH_MNT/bar2
+touch $SCRATCH_MNT/baz2
+
+# Add a capability to file bar now. We want to check later that the capability
+# is not added to file baz or any of the new files foo2, bar2 and baz2.
+$SETCAP_PROG cap_net_raw=p $SCRATCH_MNT/bar
+
+# Add a capability to the new file foo2, we want to check later that it is not
+# incorrectly propagated to the new files bar2 and baz2.
+$SETCAP_PROG cap_sys_nice=ep $SCRATCH_MNT/foo2
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+		 $SCRATCH_MNT/mysnap2 > /dev/null
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+		 $SCRATCH_MNT/mysnap2 2>&1 1>/dev/null | _filter_scratch
+
+# Now recreate the filesystem by receiving both send streams.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
+
+echo "File mysnap1/foo capabilities:"
+_getcap $SCRATCH_MNT/mysnap1/foo | _filter_scratch
+echo "File mysnap1/bar capabilities:"
+_getcap $SCRATCH_MNT/mysnap1/bar | _filter_scratch
+echo "File mysnap1/baz capabilities:"
+_getcap $SCRATCH_MNT/mysnap1/baz | _filter_scratch
+
+echo "File mysnap2/foo capabilities:"
+_getcap $SCRATCH_MNT/mysnap2/foo | _filter_scratch
+echo "File mysnap2/bar capabilities:"
+_getcap $SCRATCH_MNT/mysnap2/bar | _filter_scratch
+echo "File mysnap2/baz capabilities:"
+_getcap $SCRATCH_MNT/mysnap2/baz | _filter_scratch
+echo "File mysnap2/foo2 capabilities:"
+_getcap $SCRATCH_MNT/mysnap2/foo2 | _filter_scratch
+echo "File mysnap2/bar2 capabilities:"
+_getcap $SCRATCH_MNT/mysnap2/bar2 | _filter_scratch
+echo "File mysnap2/baz2 capabilities:"
+_getcap $SCRATCH_MNT/mysnap2/baz2 | _filter_scratch
+
+status=0
+exit
diff --git a/tests/btrfs/235.out b/tests/btrfs/235.out
new file mode 100644
index 00000000..953c69bc
--- /dev/null
+++ b/tests/btrfs/235.out
@@ -0,0 +1,17 @@
+QA output created by 235
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+File mysnap1/foo capabilities:
+SCRATCH_MNT/mysnap1/foo cap_net_raw=p
+File mysnap1/bar capabilities:
+File mysnap1/baz capabilities:
+File mysnap2/foo capabilities:
+SCRATCH_MNT/mysnap2/foo cap_net_raw=p
+File mysnap2/bar capabilities:
+SCRATCH_MNT/mysnap2/bar cap_net_raw=p
+File mysnap2/baz capabilities:
+File mysnap2/foo2 capabilities:
+SCRATCH_MNT/mysnap2/foo2 cap_sys_nice=ep
+File mysnap2/bar2 capabilities:
+File mysnap2/baz2 capabilities:
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 6d0c70c0..331dd432 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -237,3 +237,4 @@
 232 auto quick qgroup limit
 233 auto quick subvolume
 234 auto quick compress rw
+235 auto quick send
-- 
2.28.0

