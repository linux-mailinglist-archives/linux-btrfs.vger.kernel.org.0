Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4864546142D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 12:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhK2LyI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 06:54:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46936 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhK2LwH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 06:52:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B29961280;
        Mon, 29 Nov 2021 11:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99307C004E1;
        Mon, 29 Nov 2021 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638186529;
        bh=/ZGlqKGhsPnzKKXCeM4uauxcdRDDmIIZC3WLflrza2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqpcSOJP5wQOX1J8lcQ4voIO1oGulpkujHzzyGJQVMyycwzuxwe/tNR0VqSerTpTz
         FIsswhVUkbCutlNEJMiE0bTs5oE8e7v6oGKTdzqthcgu7qZSduO4uMEaLCE6KVnNg/
         Z0ZB5yDlLNoKOi2mK7fe4tFMVM9v4BBNqLGevkmwHj7HyySaXNqGLTxl4OqwiJegNm
         60XzOPly9mckvyqHM7wYH4rJQEJPm0od1dmwCCppH/h3iADzmVl8XfdYOmX+dLPU0D
         w07wndsiueHRzmz0zDjeooVBkoDax2B0m6/R9Hr/PPJ1NtFtsSXqmOr4K1NgJosTmX
         lesECa/FxChAg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: test balance and send running in parallel
Date:   Mon, 29 Nov 2021 11:48:41 +0000
Message-Id: <d46eb004e53abf3558635a45999549d7a90f41a7.1638186251.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <f0bab9b2c90444bcb2612d8e6d6d71c447c01179.1637582346.git.fdmanana@suse.com>
References: <f0bab9b2c90444bcb2612d8e6d6d71c447c01179.1637582346.git.fdmanana@suse.com>
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

V2: Add the test to the stress group as well.
    Make the test work with older versions of btrfs-progs that don't
    have the --quiet global option for the btrfs command.

 tests/btrfs/252     | 189 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/252.out |   2 +
 2 files changed, 191 insertions(+)
 create mode 100755 tests/btrfs/252
 create mode 100644 tests/btrfs/252.out

diff --git a/tests/btrfs/252 b/tests/btrfs/252
new file mode 100755
index 00000000..f733ee6d
--- /dev/null
+++ b/tests/btrfs/252
@@ -0,0 +1,189 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 252
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
+_begin_fstest auto send balance stress
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
+	prev_snap="${snapshots_dir}/${snapshots[$i - 1]}"
+
+	# For the first snapshot we do a full incremental send, for all the
+	# others we do an incremental send, using the previous snapshot as the
+	# parent.
+	#
+	# We redirect stderr of the send command because the commands prints to
+	# stderr a message like "At subvol ...", and the number of snapshots and
+	# snapshot names we have depends on LOAD_FACTOR and timestamps, so we
+	# don't use them in the golden output. Recent versions of btrfs-progs
+	# have the --quiet option to eliminate these messages.
+	#
+	# We also redirect stderr and stdout of the receive command. Note that
+	# when receiving a full stream, the command prints a message like
+	# "At subvol ..." to stderr, but when receiving an incremental stream it
+	# prints a message to stdout like "At snapshot ...". Just like for the
+	# send command, new versions of btrfs-progs have the --quiet option to
+	# eliminate these messages.
+	#
+	# Further the send command prints the messages with a full snapshot path,
+	# while receive prints only the snapshot name.
+	#
+	# We redirect all these messages to $seqres.full and then manually check
+	# if the commands succeeded. This is just so that the test is able to
+	# run with older versions of btrfs-progs.
+	#
+	if [ $i -eq 0 ]; then
+		echo "Full send of the snapshot at: $snap" >>$seqres.full
+		$BTRFS_UTIL_PROG send "$snap" 2>>$seqres.full | \
+			$BTRFS_UTIL_PROG receive "$dest_dir" 2>>$seqres.full
+	else
+		echo "Incremental send of the snapshot at: $snap" >>$seqres.full
+		$BTRFS_UTIL_PROG send -p "$prev_snap" "$snap" 2>>$seqres.full | \
+			$BTRFS_UTIL_PROG receive "$dest_dir" >>$seqres.full
+	fi
+
+	send_ret=${PIPESTATUS[0]}
+	recv_ret=$?
+
+	[ $send_ret -eq 0 ] || echo "Send of snapshot $snap failed: $send_ret"
+	[ $recv_ret -eq 0 ] || echo "Receive of snapshot $snap failed: $recv_ret"
+
+	if [ $i -gt 0 ]; then
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
diff --git a/tests/btrfs/252.out b/tests/btrfs/252.out
new file mode 100644
index 00000000..ddfa3e02
--- /dev/null
+++ b/tests/btrfs/252.out
@@ -0,0 +1,2 @@
+QA output created by 252
+Silence is golden
-- 
2.33.0

