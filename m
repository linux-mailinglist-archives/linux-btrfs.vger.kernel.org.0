Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03C067B09D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 12:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjAYLIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 06:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbjAYLIG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 06:08:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A894D22A17;
        Wed, 25 Jan 2023 03:08:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92FF7614B5;
        Wed, 25 Jan 2023 11:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344E1C433D2;
        Wed, 25 Jan 2023 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674644881;
        bh=BqM6pwBT3qaksPoWn23fgZS/TJQ8/uHUnNnf+67WA+0=;
        h=From:To:Cc:Subject:Date:From;
        b=eVOY5lpsl5r0PPvz0jSDh+C2zltJ8Jq4zxyXjVoUHKkx2/sLT2ngxx5OqNFUM8XhX
         DS4jmKagUnqPAn0PrnaZInctLIxesgxcRD+UEW7BjtZM/G4l/w4I62O7uZNs8s3Yvp
         ztDeXxJNAZxqE++C/+f1WaoL8nKaDJK1fm5sc1CmIcwxCc9jcdjaMif/KFyUNne5Tv
         GrIH445hk6d4Zuqr7Mgad829DmFG9sBuhwEEUBT7oAHBwQBKrY3cvNXqxR72wnxLZ4
         2NK0XcQtOJhXY30EN2AuXOlikJ0HzaYqyoqgZzmz236Px99d/P0eJ4+XlyVPxtKOQc
         OeN8goTRA3Nuw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test send optimal cloning behaviour
Date:   Wed, 25 Jan 2023 11:07:54 +0000
Message-Id: <49e01810eff8d5ddd7d3c99796a66b997faaaf84.1674644814.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that send operations do the best cloning decisions when we have
extents that are shared but some files refer to the full extent while
others refer to only a section of the extent.

This exercises an optimization that was added to kernel 6.2, by the
following commit:

  c7499a64dcf6 ("btrfs: send: optimize clone detection to increase extent sharing")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/283     | 88 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/283.out | 26 ++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100755 tests/btrfs/283
 create mode 100644 tests/btrfs/283.out

diff --git a/tests/btrfs/283 b/tests/btrfs/283
new file mode 100755
index 00000000..c1f6007d
--- /dev/null
+++ b/tests/btrfs/283
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 283
+#
+# Test that send operations do the best cloning decisions when we have extents
+# that are shared but some files refer to the full extent while others refer to
+# only a section of the extent.
+#
+. ./common/preamble
+_begin_fstest auto quick send clone fiemap
+
+. ./common/filter
+. ./common/reflink
+. ./common/punch # for _filter_fiemap_flags
+
+_supported_fs btrfs
+_require_test
+_require_scratch_reflink
+_require_cp_reflink
+_require_xfs_io_command "fiemap"
+_require_fssum
+
+_wants_kernel_commit c7499a64dcf6 \
+	     "btrfs: send: optimize clone detection to increase extent sharing"
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+send_stream=$send_files_dir/snap.stream
+snap_fssum=$send_files_dir/snap.fssum
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+# When using compression, btrfs limits the extent size to 128K, so do not do
+# larger writes and then expect larger extents, as that would break the test
+# if we are run with compression enabled through $MOUNT_OPTIONS (resulting in
+# mismatch with the golden output).
+$XFS_IO_PROG -f -c "pwrite -S 0xab -b 128K 0 128K" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Now clone file foo twice, which will make the 128K extent shared 3 times.
+_cp_reflink $SCRATCH_MNT/foo $SCRATCH_MNT/bar
+_cp_reflink $SCRATCH_MNT/foo $SCRATCH_MNT/baz
+
+# Overwrite the second half of file foo.
+$XFS_IO_PROG -c "pwrite -S 0xcd -b 64K 64K 64K" $SCRATCH_MNT/foo | _filter_xfs_io
+
+echo "Creating snapshot and a send stream for it..."
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap 2>&1 | _filter_scratch
+
+$FSSUM_PROG -A -f -w $snap_fssum $SCRATCH_MNT/snap
+
+echo "Creating a new filesystem to receive the send stream..."
+_scratch_unmount
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_stream $SCRATCH_MNT
+
+echo "Verifying data matches the original filesystem..."
+$FSSUM_PROG -r $snap_fssum $SCRATCH_MNT/snap
+
+# Now verify that all extents, for all files, are shared.
+
+# File 'foo' should have a single 128K extent, which is shared because its first
+# half is referred by files 'bar' and 'baz'.
+echo -e "\nfiemap of file foo:\n"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/foo | _filter_fiemap_flags
+
+# File 'bar' should have two 64K shared extents. The first one is shared with
+# files 'foo' and 'baz', while the second one is only shared with file 'baz'.
+echo -e "\nfiemap of file bar:\n"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_flags
+
+# File 'baz' should have two 64K shared extents. The first one is shared with
+# files 'foo' and 'bar', while the second one is only shared with file 'bar'.
+echo -e "\nfiemap of file baz:\n"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/baz | _filter_fiemap_flags
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
new file mode 100644
index 00000000..286dae33
--- /dev/null
+++ b/tests/btrfs/283.out
@@ -0,0 +1,26 @@
+QA output created by 283
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating snapshot and a send stream for it...
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+At subvol SCRATCH_MNT/snap
+Creating a new filesystem to receive the send stream...
+At subvol snap
+Verifying data matches the original filesystem...
+OK
+
+fiemap of file foo:
+
+0: [0..255]: shared|last
+
+fiemap of file bar:
+
+0: [0..127]: shared
+1: [128..255]: shared|last
+
+fiemap of file baz:
+
+0: [0..127]: shared
+1: [128..255]: shared|last
-- 
2.35.1

