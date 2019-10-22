Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF62DFED7
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 09:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfJVH6S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 03:58:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:48352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388026AbfJVH6S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 03:58:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B301BB86F;
        Tue, 22 Oct 2019 07:58:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fstests: btrfs: dm-logwrites test for fstrim and fsstress workload
Date:   Tue, 22 Oct 2019 15:58:06 +0800
Message-Id: <20191022075806.16616-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022075806.16616-1-wqu@suse.com>
References: <20191022075806.16616-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a fs corruption report of a tree block in use get trimmed, and
cause fs corruption.

Although I haven't found the cause from the source code, it won't hurt
to add such test case.

The test case is limited to btrfs due to the replay-log --check|--fsck
hack to reduce runtime.
Other fs can't go with the replay-log --check|--fsck hack as their fsck
will report dirty journal as error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Due to recent change in btrfs side, already trimmed tree blocks won't
get trimmed again until new data is written.

This makes things safer, and I'm not sure if it's the reason why the
test never fails on latest kernel.
---
 tests/btrfs/197     | 131 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/197.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 134 insertions(+)
 create mode 100755 tests/btrfs/197
 create mode 100644 tests/btrfs/197.out

diff --git a/tests/btrfs/197 b/tests/btrfs/197
new file mode 100755
index 00000000..c86af7b6
--- /dev/null
+++ b/tests/btrfs/197
@@ -0,0 +1,131 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+
+# FS QA Test 197
+#
+# Test btrfs consistency after each DISCARD for a workload with fstrim and
+# fsstress.
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
+	kill -q $fstrim_pid &> /dev/null
+	"$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
+	wait
+	_log_writes_cleanup &> /dev/null
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
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
+_require_command "$KILLALL_PROG" killall
+_require_command "$BLKDISCARD_PROG" blkdiscard
+_require_btrfs_fs_feature "no_holes"
+_require_btrfs_mkfs_feature "no-holes"
+_require_fstrim
+_require_log_writes
+_require_scratch
+
+runtime=30
+nr_cpus=$("$here/src/feature" -o)
+# cap nr_cpus to 8 to avoid spending too much time on hosts with many cpus
+if [ $nr_cpus -gt 8 ]; then
+	nr_cpus=8
+fi
+fsstress_args=$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 99999 -p $nr_cpus \
+		$FSSTRESS_AVOID)
+
+fstrim_workload()
+{
+	trap "wait; exit" SIGTERM
+
+	while  true; do
+		$FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full
+	done
+}
+
+# Replay and check each fua/flush (specified by $2) point.
+#
+# Since dm-log-writes records bio sequentially, even just replaying a range
+# still needs to iterate all records before the end point.
+# When number of records grows, it will be unacceptably slow, thus we need
+# to use relay-log itself to trigger fsck, avoid unnecessary seek.
+log_writes_fast_replay_check()
+{
+	local check_point=$1
+	local blkdev=$2
+	local fsck_command="$BTRFS_UTIL_PROG check $blkdev"
+	local ret
+
+	[ -z "$check_point" -o -z "$blkdev" ] && _fail \
+	"check_point and blkdev must be specified for log_writes_fast_replay_check"
+
+	# Replay to first mark
+	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
+		--replay $blkdev --end-mark prepare
+	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
+		--replay $blkdev --start-mark prepare \
+		--check $check_point --fsck "$fsck_command" \
+		&> $tmp.full_fsck
+	ret=$?
+	tail -n 150 $tmp.full_fsck > $seqres.full
+	[ $ret -ne 0 ] && _fail "fsck failed during replay"
+}
+
+_log_writes_init $SCRATCH_DEV
+
+# Discard the whole devices so when some tree pointer is wrong, it won't point
+# to some older valid tree blocks, so we can detect it.
+$BLKDISCARD_PROG $LOGWRITES_DMDEV > /dev/null 2>&1
+
+# The regular workaround to avoid false alert on unexpected holes
+_log_writes_mkfs -O no-holes >> $seqres.full
+_log_writes_mount
+
+$FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full || _notrun "FSTRIM not supported"
+
+_log_writes_mark prepare
+
+fstrim_workload &
+fstrim_pid=$!
+
+"$FSSTRESS_PROG" $fsstress_args > /dev/null &
+sleep $runtime
+
+"$KILLALL_PROG" -q "$FSSTRESS_PROG" &> /dev/null
+kill $fstrim_pid
+wait
+
+_log_writes_unmount
+_log_writes_remove
+
+# The best checkpoint is discard, however since there are a lot of
+# discard, using discard check point is too time consuming.
+# Here trade coverage for a much shorter runtime
+log_writes_fast_replay_check flush "$SCRATCH_DEV"
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/197.out b/tests/btrfs/197.out
new file mode 100644
index 00000000..3bbd3143
--- /dev/null
+++ b/tests/btrfs/197.out
@@ -0,0 +1,2 @@
+QA output created by 197
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index c2ab3e7d..ee35fa59 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -199,3 +199,4 @@
 194 auto volume
 195 auto volume
 196 auto metadata log volume
+197 auto replay trim
-- 
2.23.0

