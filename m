Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A161D688395
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Feb 2023 17:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjBBQAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Feb 2023 11:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjBBP7y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Feb 2023 10:59:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFA37CC9C;
        Thu,  2 Feb 2023 07:59:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2300CB826E2;
        Thu,  2 Feb 2023 15:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF9C4339B;
        Thu,  2 Feb 2023 15:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353502;
        bh=+8LnBVPqA2WlC5KWWkno390nC+tOtVMD5YZ6HZcYVOU=;
        h=From:To:Cc:Subject:Date:From;
        b=Thi7nBHN3BKz932Mjq1t0vAehz2X8TtrDWVRV2Jo096QClbLvooUjXmq+De0+EChX
         GMCOtkMxt23ikd2+LwMVgWGvPchDS4rlWau9NWh5qbyP55eCvGQoSZyKiRiY1aPSc/
         bLuvc/aV7r3qHs+MRFRiS4A3LXzwP0qU+lAtdNvah/4N7MoLFW5xg5PwjA3HP1xrs/
         RoPGFKqqD+LXxrbbkmm/NavwyqK/fPpM9EHlFu1GkwhP1UhyUxI9L4s0pOo5cLFFWP
         lcDkVd923D3cNfYohrcVB6IL4jBJIhDdPoGXE+/GNesKmJlr0znsuy8t4hgr9FB3W6
         sNJqt611oe/WQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: add a stress test for send v2 streams
Date:   Thu,  2 Feb 2023 15:58:09 +0000
Message-Id: <a2a5700b744bca710ff0721f1d1fa268d76430fc.1675353192.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently we don't have any test case in fstests to do randomized and
stress testing of the send stream v2, added in kernel 6.0 and support for
it in btrfs-progs v5.19. For the send v2 stream, we only have btrfs/281
that exercises a specific scenario which used to trigger a bug.

So add a test that uses fsstress to generate a filesystem and exercise
both full and incremental send operations using the v2 send stream with
compressed extents, and then receive the streams without and with
decompression, to verify they work and produce the same results as in
the original filesystem. This is the same base idea as btrfs/007, but
for the send v2 stream with compressed data.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/284     | 133 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/284.out |   2 +
 2 files changed, 135 insertions(+)
 create mode 100755 tests/btrfs/284
 create mode 100644 tests/btrfs/284.out

diff --git a/tests/btrfs/284 b/tests/btrfs/284
new file mode 100755
index 00000000..0d31e5d9
--- /dev/null
+++ b/tests/btrfs/284
@@ -0,0 +1,133 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 284
+#
+# Test btrfs send stream v2, sending and receiving compressed data without
+# decompression at the sending side.
+#
+. ./common/preamble
+_begin_fstest auto quick send compress snapshot
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_btrfs_send_v2
+_require_test
+# The size needed is variable as it depends on the specific randomized
+# operations from fsstress and on the value of $LOAD_FACTOR. But require at
+# least $LOAD_FACTOR * 1G, just to be on the safe side.
+_require_scratch_size $(($LOAD_FACTOR * 1 * 1024 * 1024))
+_require_fssum
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+# Redirect stdout to the .full file and make it not part of the golden output.
+# This is because the number of available compression algorithms may vary across
+# kernel versions, so the number of times we are running this function is
+# variable.
+run_send_test()
+{
+	local algo=$1
+	local snapshot_cmd
+	local first_stream="$send_files_dir/snap1.stream"
+	local second_stream="$send_files_dir/snap2.stream"
+	local first_fssum="$send_files_dir/snap1.fssum"
+	local second_fssum="$send_files_dir/snap2.fssum"
+
+	_scratch_mkfs >> $seqres.full 2>&1
+	_scratch_mount -o compress=$algo
+
+	snapshot_cmd="$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT"
+	snapshot_cmd="$snapshot_cmd $SCRATCH_MNT/snap1"
+
+	# Use a single process so that in case of failure it's easier to
+	# reproduce by using the same seed (logged in $seqres.full).
+	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -p 1 -n $((LOAD_FACTOR * 200)) \
+		  -w $FSSTRESS_AVOID -x "$snapshot_cmd" >> $seqres.full
+
+	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
+			 >> $seqres.full
+
+	echo "Creating full and incremental send streams..." >> $seqres.full
+
+	$BTRFS_UTIL_PROG send --compressed-data -q -f $first_stream \
+			 $SCRATCH_MNT/snap1 2>&1 | tee -a $seqres.full
+	$BTRFS_UTIL_PROG send --compressed-data -q -f $second_stream \
+			 -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2 2>&1 | \
+			 tee -a $seqres.full
+
+	echo "Computing the checksums for each snapshot..." >> $seqres.full
+
+	$FSSUM_PROG -A -f -w $first_fssum $SCRATCH_MNT/snap1 2>&1 | \
+		tee -a $seqres.full
+	$FSSUM_PROG -A -f -w $second_fssum -x $SCRATCH_MNT/snap2/snap1 \
+		    $SCRATCH_MNT/snap2 2>&1 | tee -a $seqres.full
+
+	echo "Creating a new fs to receive the streams..." >> $seqres.full
+
+	_scratch_unmount
+	_scratch_mkfs >> $seqres.full 2>&1
+	_scratch_mount
+
+	echo "Receiving the streams..." >> $seqres.full
+
+	$BTRFS_UTIL_PROG receive -q -f $first_stream $SCRATCH_MNT 2>&1 | \
+		tee -a $seqres.full
+	$BTRFS_UTIL_PROG receive -q -f $second_stream $SCRATCH_MNT 2>&1 | \
+		tee -a $seqres.full
+
+	echo "Verifying the checksums for each snapshot..." >> $seqres.full
+
+	# On success, fssum outputs only a single line with "OK" to stdout, and
+	# on error it outputs several lines to stdout telling about each file
+	# with data or metadata mismatches. Since the number of times we run
+	# fssum depends on the available compression algorithms for the running
+	# kernel, filter out the success case, so we don't have a mismatch with
+	# the golden output. We only want the mismatch with the golden output in
+	# case there's a checksum failure.
+	$FSSUM_PROG -r $first_fssum $SCRATCH_MNT/snap1 | grep -Ev '^OK$' | \
+		tee -a $seqres.full
+	$FSSUM_PROG -r $second_fssum $SCRATCH_MNT/snap2 | grep -Ev '^OK$' | \
+		tee -a $seqres.full
+
+	# Now receive again the streams in a new filesystem, but this time use
+	# the option --force-decompress of the receiver to verify that it works
+	# as expected.
+	echo "Creating a new fs to receive the streams with decompression..." >> $seqres.full
+
+	_scratch_unmount
+	_scratch_mkfs >> $seqres.full 2>&1
+	_scratch_mount
+
+	echo "Receiving the streams with decompression..." >> $seqres.full
+
+	$BTRFS_UTIL_PROG receive -q --force-decompress -f $first_stream $SCRATCH_MNT 2>&1 \
+		| tee -a $seqres.full
+	$BTRFS_UTIL_PROG receive -q --force-decompress -f $second_stream $SCRATCH_MNT 2>&1 \
+		| tee -a $seqres.full
+
+	echo "Verifying the checksums for each snapshot..." >> $seqres.full
+
+	$FSSUM_PROG -r $first_fssum $SCRATCH_MNT/snap1 | grep -Ev '^OK$' | \
+		tee -a $seqres.full
+	$FSSUM_PROG -r $second_fssum $SCRATCH_MNT/snap2 | grep -Ev '^OK$' | \
+		tee -a $seqres.full
+
+	_scratch_unmount
+	rm -f $send_files_dir/*
+}
+
+algo_list=($(_btrfs_compression_algos))
+for algo in ${algo_list[@]}; do
+	echo -e "\nTesting with $algo...\n" >> $seqres.full
+	run_send_test $algo
+done
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/284.out b/tests/btrfs/284.out
new file mode 100644
index 00000000..931839fe
--- /dev/null
+++ b/tests/btrfs/284.out
@@ -0,0 +1,2 @@
+QA output created by 284
+Silence is golden
-- 
2.35.1

