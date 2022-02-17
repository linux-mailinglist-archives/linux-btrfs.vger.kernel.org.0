Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1B4B9FE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 13:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbiBQMOz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 07:14:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbiBQMOv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 07:14:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00BF2A415C;
        Thu, 17 Feb 2022 04:14:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D4E361841;
        Thu, 17 Feb 2022 12:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17125C340EF;
        Thu, 17 Feb 2022 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645100076;
        bh=UI/c2nBsz4de9WVyPBOeW45FXWa8u0QnnhBKRJ3Ry3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=ENdKX19gEspXpPzQK545EneyG0NPrymOdBZxH+og1H/ccIsNgVEgntub4s1n5N5P/
         IAWd2RNjk4Z2WFC4reL4k5wEALo7SuwHXFXQq0SSsZRhR7fThko4p2mvcGXoh+uT4S
         3Xt58l/zDu96ZzndXFLDacYyGetJjYGW4jBFwz1LEWqXud1HLbDVPOl1n5odmylS4r
         4jtOhwDPIzemchZPVvpbCEhl2zpH5rE6i9FQtxAHtrLK0N8HGtrnKGE24lvxWmbjja
         /9hYbwveQ1Nq/H9gfc5JfOW0kLSyM5GbKWbv3F2sYHEtALD+S7W/53UPnJ5IRFH31D
         p+76Qh8SVspyA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test log replay after fsync of file with prealloc extents beyond eof
Date:   Thu, 17 Feb 2022 12:14:21 +0000
Message-Id: <abbc821350c8ef515e0a0317b5cbd64e3c5b81ab.1645099449.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that after a full fsync of a file with preallocated extents beyond
the file's size, if a power failure happens, the preallocated extents
still exist after we mount the filesystem.

This test currently fails and there is a patch for btrfs that fixes this
issue and has the following subject:

  "btrfs: fix lost prealloc extents beyond eof after full fsync"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/261     | 79 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/261.out | 10 ++++++
 2 files changed, 89 insertions(+)
 create mode 100755 tests/btrfs/261
 create mode 100644 tests/btrfs/261.out

diff --git a/tests/btrfs/261 b/tests/btrfs/261
new file mode 100755
index 00000000..8275e6a5
--- /dev/null
+++ b/tests/btrfs/261
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 261
+#
+# Test that after a full fsync of a file with preallocated extents beyond the
+# file's size, if a power failure happens, the preallocated extents still exist
+# after we mount the filesystem.
+#
+. ./common/preamble
+_begin_fstest auto quick log prealloc
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -r -f $tmp.*
+}
+
+. ./common/rc
+. ./common/filter
+. ./common/dmflakey
+. ./common/punch
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch
+_require_dm_target flakey
+_require_xfs_io_command "falloc" "-k"
+_require_xfs_io_command "fiemap"
+_require_odirect
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test file with many file extent items, so that they span several
+# leaves of metadata, even if the node/page size is 64K. We use direct IO and
+# not fsync/O_SYNC because it's both faster and it avoids clearing the full sync
+# flag from the inode - we want the fsync below to trigger the slow full sync
+# code path.
+$XFS_IO_PROG -f -d -c "pwrite -b 4K 0 16M" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Now add two preallocated extents to our file without extending the file's size.
+# One right at i_size, and another further beyond, leaving a gap between the two
+# prealloc extents.
+$XFS_IO_PROG -c "falloc -k 16M 1M" $SCRATCH_MNT/foo
+$XFS_IO_PROG -c "falloc -k 20M 1M" $SCRATCH_MNT/foo
+
+# Make sure everything is durably persisted and the transaction is committed.
+# This makes all created extents to have a generation lower than the generation
+# of the transaction used by the next write and fsync.
+sync
+
+# Now overwrite only the first extent, which will result in modifying only the
+# first leaf of metadata for our inode. Then fsync it. This fsync will use the
+# slow code path (inode full sync bit is set) because it's the first fsync since
+# the inode was created/loaded.
+$XFS_IO_PROG -c "pwrite 0 4K" -c "fsync" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Simulate a power failure and then mount again the filesystem to replay the log
+# tree.
+_flakey_drop_and_remount
+
+# After the power failure we expect that the preallocated extents, beyond the
+# inode's i_size, still exist.
+echo "List of extents after power failure:"
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap
+
+_unmount_flakey
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
new file mode 100644
index 00000000..e9cfe1e8
--- /dev/null
+++ b/tests/btrfs/261.out
@@ -0,0 +1,10 @@
+QA output created by 261
+wrote 16777216/16777216 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+List of extents after power failure:
+0: [0..32767]: data
+1: [32768..34815]: unwritten
+2: [34816..40959]: hole
+3: [40960..43007]: unwritten
-- 
2.33.0

