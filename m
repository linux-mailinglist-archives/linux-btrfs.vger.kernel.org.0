Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34975F323A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Oct 2022 16:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJCO6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Oct 2022 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJCO6c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Oct 2022 10:58:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAC43C15B;
        Mon,  3 Oct 2022 07:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9917B8117A;
        Mon,  3 Oct 2022 14:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A993CC433D7;
        Mon,  3 Oct 2022 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664809106;
        bh=tkvcnmn0rzId1765Ob53Fa9jAy+ddPjtOc7y0am5s1s=;
        h=From:To:Cc:Subject:Date:From;
        b=S41jda3kXk55XqNPD7TYFR9kXf9+Sa72o5SSmOAjdzMnCyYIE2VpJrOuIR0LPBb/F
         /0srTe6AN1cEtQQVejKku2H6smqgiP8uhFpDan6cvzGUTcfszL3/NW2f4DGpn9Ml9u
         zrDAaS59W3SeSnYD0fo/B+L4lrWMpVu4GxG4LV0vNZ0XYVcLeHJX4h2pEUpMjeU8hB
         hF+aVWP9+UlhJUv2VgArhlDhB/5p7wTNSm1bWleDygziIf/JpV6oGGiy18za5gL1Ni
         /u4TZmuJutsbSVxpVQ5e4+2ubUC0tKh/ZDKMaADOTU029k4ox9RzuGRQoSkf/jVVuV
         fP+c/4THbOY0g==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test fiemap on large file with extents shared through a snapshot
Date:   Mon,  3 Oct 2022 15:58:17 +0100
Message-Id: <d4bf2bc47e3be1437d5693a0b728e199acb549fd.1664808949.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Verify that fiemap correctly reports the sharedness of extents for a file
with a very large number of extents, spanning many b+tree leaves in the fs
tree, and when the file's subvolume was snapshoted.

Currently this passes on all kernel releases and its purpose is to prevent
and detect regressions in the future, as this actually happened during
recent development on the btrfs' fiemap related code. With this test we
now have better coverage for fiemap when a file is shared through a
snapshot.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 doc/group-names.txt |   1 +
 tests/btrfs/276     | 123 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/276.out |  16 ++++++
 3 files changed, 140 insertions(+)
 create mode 100755 tests/btrfs/276
 create mode 100644 tests/btrfs/276.out

diff --git a/doc/group-names.txt b/doc/group-names.txt
index ef411b5e..6cc9af78 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -47,6 +47,7 @@ eio			IO error reporting
 encrypt			encrypted file contents
 enospc			ENOSPC error reporting
 exportfs		file handles
+fiemap			fiemap ioctl
 filestreams		XFS filestreams allocator
 freeze			filesystem freeze tests
 fsck			general fsck tests
diff --git a/tests/btrfs/276 b/tests/btrfs/276
new file mode 100755
index 00000000..5946dad9
--- /dev/null
+++ b/tests/btrfs/276
@@ -0,0 +1,123 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 276
+#
+# Verify that fiemap correctly reports the sharedness of extents for a file with
+# a very large number of extents, spanning many b+tree leaves in the fs tree,
+# and when the file's subvolume was snapshoted.
+#
+. ./common/preamble
+_begin_fstest auto snapshot compress fiemap
+
+. ./common/filter
+
+_supported_fs btrfs
+_require_scratch
+_require_xfs_io_command "fiemap" "ranged"
+
+_scratch_mkfs >> $seqres.full 2>&1
+# We use compression because it's a very quick way to create a file with a very
+# large number of extents (compression limits the maximum extent size to 128K)
+# and while using very little disk space.
+_scratch_mount -o compress
+
+fiemap_test_file()
+{
+	local offset=$1
+	local len=$2
+
+	# Skip the first two lines of xfs_io's fiemap output (file path and
+	# header describing the output columns).
+	$XFS_IO_PROG -c "fiemap -v $offset $len" $SCRATCH_MNT/foo | tail -n +3
+}
+
+# Count the number of shared extents for the whole test file or just for a given
+# range.
+count_shared_extents()
+{
+	local offset=$1
+	local len=$2
+
+	# Column 5 (from xfs_io's "fiemap -v" command) is the flags (hex field).
+	# 0x2000 is the value for the FIEMAP_EXTENT_SHARED flag.
+	fiemap_test_file $offset $len | \
+		$AWK_PROG --source 'BEGIN { cnt = 0 }' \
+			  --source '{ if (and(strtonum($5), 0x2000)) cnt++ }' \
+			  --source 'END { print cnt }'
+}
+
+# Count the number of non shared extents for the whole test file or just for a
+# given range.
+count_not_shared_extents()
+{
+	local offset=$1
+	local len=$2
+
+	# Column 5 (from xfs_io's "fiemap -v" command) is the flags (hex field).
+	# 0x2000 is the value for the FIEMAP_EXTENT_SHARED flag.
+	fiemap_test_file $offset $len | \
+		$AWK_PROG --source 'BEGIN { cnt = 0 }' \
+			  --source '{ if (!and(strtonum($5), 0x2000)) cnt++ }' \
+			  --source 'END { print cnt }'
+}
+
+# Create a 16G file as that results in 131072 extents, all with a size of 128K
+# (due to compression), and a fs tree with a height of 3 (root node at level 2).
+# We want to verify later that fiemap correctly reports the sharedness of each
+# extent, even when it needs to switch from one leaf to the next one and from a
+# node at level 1 to the next node at level 1.
+#
+$XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Sync to flush delalloc and commit the current transaction, so fiemap will see
+# all extents in the fs tree and extent trees and not look at delalloc.
+sync
+
+echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
+
+# Creating a snapshot.
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+
+# We have a snapshot, so now all extents should be reported as shared.
+echo "Number of shared extents in the whole file: $(count_shared_extents)"
+
+# Now COW two files ranges, of 1M each, in the snapshot's file.
+# So 16 extents should become non-shared after this.
+#
+$XFS_IO_PROG -c "pwrite -b 1M 8M 1M" \
+	     -c "pwrite -b 1M 12G 1M" \
+	     $SCRATCH_MNT/snap/foo | _filter_xfs_io
+
+# Sync to flush delalloc and commit the current transaction, so fiemap will see
+# all extents in the fs tree and extent trees and not look at delalloc.
+sync
+
+# Now we should have 16 non-shared extents and 131056 (131072 - 16) shared
+# extents.
+echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
+echo "Number of shared extents in the whole file: $(count_shared_extents)"
+
+# Check that the non-shared extents are indeed in the expected file ranges (each
+# with 8 extents).
+echo "Number of non-shared extents in range [8M, 9M): $(count_not_shared_extents 8M 1M)"
+echo "Number of non-shared extents in range [12G, 12G + 1M): $(count_not_shared_extents 12G 1M)"
+
+# Now delete the snapshot.
+$BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap | _filter_scratch
+
+# We deleted the snapshot and committed the transaction used to delete it (-c),
+# but all its extents (both metadata and data) are actually only deleted in the
+# background, by the cleaner kthread. So remount, which wakes up the cleaner
+# kthread, with a commit interval of 1 second and sleep for 1.1 seconds - after
+# this we are guaranteed all extents of the snapshot were deleted.
+_scratch_remount commit=1
+sleep 1.1
+
+# Now all extents should be reported as not shared (131072 extents).
+echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
new file mode 100644
index 00000000..3bf5a5e6
--- /dev/null
+++ b/tests/btrfs/276.out
@@ -0,0 +1,16 @@
+QA output created by 276
+wrote 17179869184/17179869184 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Number of non-shared extents in the whole file: 131072
+Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+Number of shared extents in the whole file: 131072
+wrote 1048576/1048576 bytes at offset 8388608
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 12884901888
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Number of non-shared extents in the whole file: 16
+Number of shared extents in the whole file: 131056
+Number of non-shared extents in range [8M, 9M): 8
+Number of non-shared extents in range [12G, 12G + 1M): 8
+Delete subvolume (commit): 'SCRATCH_MNT/snap'
+Number of non-shared extents in the whole file: 131072
-- 
2.35.1

