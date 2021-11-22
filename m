Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611CA458DF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 13:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbhKVMI1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 07:08:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhKVMI0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 07:08:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D09E604DA;
        Mon, 22 Nov 2021 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637582720;
        bh=k7L7kJTtZWjzS42F/4DqwluBTvlVU3tFCHPcEMev10U=;
        h=From:To:Cc:Subject:Date:From;
        b=XQl3T7Spz4gJwgtQ4O3+wCOPACPTPX94G5J9ygnkYpS1U4wFt5Z1lzOOCRa5HLkNE
         KI/e/Vip1nH2C0BXkF6jRaag/kx3QIkN3tu7y6MN8KpA4h0cvRTkhQtyFg9i/ScwyA
         IbKf39Nxx4TDxsVNOdQNQ49qJcp99BdNPcDzPhpXY6C6qZV1zx8vTnqEoW1hRXdVEA
         Q5J7gdJi6ZiaUCo0iaFy/TcyjjDwmiVVGsEHWFUqj3BIlPie3ItQF5+lMRqVvPE0ip
         JVkfh5tXSAnF9IiD1cJRTg7K5opu59FB+gIkebxCPuqe4XFzW7Y494wACluMjHDDt3
         iL1JA62l2sNmQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test balance and send running in parallel
Date:   Mon, 22 Nov 2021 12:04:58 +0000
Message-Id: <f0bab9b2c90444bcb2612d8e6d6d71c447c01179.1637582346.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that send and balance can run in parallel, without failures and
producing correct results.

Before kernel 5.3 it was possible to run both operations in parallel,
however it was buggy and caused sporadic failures due to races, so it was
disabled in kernel 5.3 by commit 9e967495e0e0ae ("Btrfs: prevent send
failures and crashes due to concurrent relocation"). There is a now a
patch that enables both operations to safely run in parallel, and it has
the following subject:

    "btrfs: make send work with concurrent block group relocation"

This also serves the purpose of testing a succession of incremental send
operations, where we have a bunch of snapshots of the same subvolume and
we keep doing an incremental send using the previous snapshot as the
parent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/251     | 159 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/251.out |   2 +
 2 files changed, 161 insertions(+)
 create mode 100755 tests/btrfs/251
 create mode 100644 tests/btrfs/251.out

diff --git a/tests/btrfs/251 b/tests/btrfs/251
new file mode 100755
index 00000000..11dce424
--- /dev/null
+++ b/tests/btrfs/251
@@ -0,0 +1,159 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 251
+#
+# Test that send and balance can run in parallel, without failures and producing
+# correct results.
+#
+# Before kernel 5.3 it was possible to run both operations in parallel, however
+# it was buggy and caused sporadic failures due to races, so it was disabled in
+# kernel 5.3 by commit 9e967495e0e0ae ("Btrfs: prevent send failures and crashes
+# due to concurrent relocation"). There is a now a patch that enables both
+# operations to safely run in parallel, and it has the following subject:
+#
+#      "btrfs: make send work with concurrent block group relocation"
+#
+# This also serves the purpose of testing a succession of incremental send
+# operations, where we have a bunch of snapshots of the same subvolume and we
+# keep doing an incremental send using the previous snapshot as the parent.
+#
+. ./common/preamble
+_begin_fstest auto send balance
+
+_cleanup()
+{
+	if [ ! -z $balance_pid ]; then
+		kill $balance_pid &> /dev/null
+		wait $balance_pid
+	fi
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs btrfs
+# The size needed is variable as it depends on the specific randomized
+# operations from fsstress and on the value of $LOAD_FACTOR. But require
+# at least $LOAD_FACTOR * 6G, as we do the receive operations to the same
+# filesystem, do relocation and store snapshot checksums from fssum in the
+# filesystem as well (can be hundreds of megabytes for $LOAD_FACTOR > 3).
+_require_scratch_size $(($LOAD_FACTOR * 6 * 1024 * 1024))
+_require_fssum
+
+balance_loop()
+{
+	trap "wait; exit" SIGTERM
+
+	while true; do
+		_run_btrfs_balance_start $SCRATCH_MNT > /dev/null
+		[ $? -eq 0 ] || echo "Balance failed: $?"
+	done
+}
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+num_snapshots=$((10 + $LOAD_FACTOR * 2))
+avg_ops_per_snapshot=$((1000 * LOAD_FACTOR))
+total_fsstress_ops=$((num_snapshots * avg_ops_per_snapshot))
+
+data_subvol="$SCRATCH_MNT/data"
+snapshots_dir="$SCRATCH_MNT/snapshots"
+dest_dir="$SCRATCH_MNT/received"
+fssum_dir="$SCRATCH_MNT/fssum"
+
+mkdir -p "$snapshots_dir"
+mkdir -p "$dest_dir"
+mkdir -p "$fssum_dir"
+$BTRFS_UTIL_PROG subvolume create "$data_subvol" >> $seqres.full
+
+snapshot_cmd="$BTRFS_UTIL_PROG subvolume snapshot -r \"$data_subvol\""
+snapshot_cmd="$snapshot_cmd \"$snapshots_dir/snap_\`date +'%s%N'\`\""
+
+# Use a single fsstress process so that in case of a failure we can grab the seed
+# number from the .full log file and deterministically reproduce a failure.
+# Also disable subvolume and snapshot creation, since send is not recursive, so
+# it's pointless to have them.
+#
+echo "Running fsstress..." >> $seqres.full
+$FSSTRESS_PROG $FSSTRESS_AVOID -d "$data_subvol" -p 1 -w \
+	       -f subvol_create=0 -f subvol_delete=0 -f snapshot=0 \
+	       -x "$snapshot_cmd" -X $num_snapshots \
+	       -n $total_fsstress_ops >> $seqres.full
+
+snapshots=(`IFS=$'\n' ls -1 "$snapshots_dir"`)
+
+# Compute the checksums for every snapshot.
+for i in "${!snapshots[@]}"; do
+	snap="${snapshots_dir}/${snapshots[$i]}"
+	echo "Computing checksum for snapshot: ${snapshots[$i]}" >> $seqres.full
+	$FSSUM_PROG -A -f -w "${fssum_dir}/${i}.fssum" "$snap"
+done
+
+# Now leave a process constantly running balance.
+balance_loop &
+balance_pid=$!
+
+# Now send and receive all snapshots to our destination directory.
+# We send and receive from/to the same same filesystem using a pipe, because
+# this is the most stressful scenario and it could lead (and has lead to during
+# development) to deadlocks - the sending task blocking on a full pipe while
+# holding some lock, while the receiving side was not reading from the pipe
+# because it was waiting for a transaction commit, which could not happen due
+# to the lock held by the sending task.
+#
+for i in "${!snapshots[@]}"; do
+	snap="${snapshots_dir}/${snapshots[$i]}"
+
+	# For first snapshot we do a full incremental send, for all the others
+	# we do an incremental send, using the previous snapshot as the parent.
+	if [ $i -eq 0 ]; then
+		echo "Full send of the snapshot at: $snap" >> $seqres.full
+		$BTRFS_UTIL_PROG --quiet send "$snap" | \
+			$BTRFS_UTIL_PROG --quiet receive "$dest_dir"
+	else
+		echo "Incremental send of the snapshot at: $snap" >> $seqres.full
+		prev_snap="${snapshots_dir}/${snapshots[$i - 1]}"
+		$BTRFS_UTIL_PROG --quiet send -p "$prev_snap" "$snap" | \
+			$BTRFS_UTIL_PROG --quiet receive "$dest_dir"
+
+		# We don't need the previous snapshot anymore, so delete it.
+		# This makes balance not so slow and triggers the cleaner kthread
+		# to run and delete the snapshot tree in parallel, while we are
+		# also running balance and send/receive, adding additional test
+		# coverage and stress.
+		$BTRFS_UTIL_PROG subvolume delete "$prev_snap" >> $seqres.full
+	fi
+done
+
+# We are done with send/receive, send a signal to the balance job and verify
+# the snapshot checksums while it terminates. We do the wait at _cleanup() so
+# that we do some useful work while it terminates.
+kill $balance_pid
+
+# Now verify that received snapshots have the expected checksums.
+for i in "${!snapshots[@]}"; do
+	snap_csum="${fssum_dir}/${i}.fssum"
+	snap_copy="${dest_dir}/${snapshots[$i]}"
+
+	echo "Verifying checksum for snapshot at: $snap_copy" >> $seqres.full
+	# On success, fssum outputs only a single line with "OK" to stdout, and
+	# on error it outputs several lines to stdout. Since the number of
+	# snapshots in the test depends on $LOAD_FACTOR, filter out the success
+	# case, so we don't have a mismatch with the golden output in case we
+	# run with a non default $LOAD_FACTOR (default is 1). We only want the
+	# mismatch with the golden output in case there's a checksum failure.
+	$FSSUM_PROG -r "$snap_csum" "$snap_copy" | egrep -v '^OK$'
+done
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/251.out b/tests/btrfs/251.out
new file mode 100644
index 00000000..e5cd36a9
--- /dev/null
+++ b/tests/btrfs/251.out
@@ -0,0 +1,2 @@
+QA output created by 251
+Silence is golden
-- 
2.33.0

