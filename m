Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5058363A801
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 13:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiK1MQr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 07:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiK1MQQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 07:16:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACA11DF13;
        Mon, 28 Nov 2022 04:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87EC1B80D55;
        Mon, 28 Nov 2022 12:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF43C433B5;
        Mon, 28 Nov 2022 12:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669637265;
        bh=Mayz6YUzXptx474MX1b3WUzZd7TOzD01BlV7EIIAcK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uexm3YGTv2ohWmySNC5xflEQic4PLqbcCuN1rXA0KYjJizcDQlfxpeXzSZCqu7v62
         O+pPVHTwdWTCSoFWIx/LER10o3gdNcIeOFM5XWJ/OX9U5vbtebN4qNyprYi3fSgDM8
         jyovnb95/AlSGAqy9DHUYllOeUBDVE7XysLAZyJaNlvIyphaWRAjfaUBG3hGEC5I3+
         QYG4DhAMnGSkHvdduLSVbwugOmYbp2PsGY4rTGooqEbqYWzoxKJtAFZ1F/5xwopiPK
         meuHuJ2gDB+3PGB22LuD7v9IZi/34njxFV7cpQYxPhtRf2GnM0W34Vek1jxAo5sXOH
         JPrt3ZUs8N0Yg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 4/4] btrfs: test a case with compressed send stream and a shared extent
Date:   Mon, 28 Nov 2022 12:07:24 +0000
Message-Id: <a56cba17186e15f473ed7315b229d288d90c0a7c.1669636339.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669636339.git.fdmanana@suse.com>
References: <cover.1669636339.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we have a snapshot with a compressed extent that is partially
shared between two files, one of them has a size that is not sector size
aligned, we create a v2 send stream for the snapshot with compressed data,
and then apply that stream to another filesystem, the operation succeeds
and no data is missing. Also check that the file that had a reference to
the whole extent gets two compressed extents in the new filesystem, with
only one of them being shared (reflinked).

This tests a recent patch that landed in kernel 6.1-rc7:

  a11452a3709e ("btrfs: send: avoid unaligned encoded writes when attempting to clone range")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/281     | 89 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/281.out | 17 +++++++++
 2 files changed, 106 insertions(+)
 create mode 100755 tests/btrfs/281
 create mode 100644 tests/btrfs/281.out

diff --git a/tests/btrfs/281 b/tests/btrfs/281
new file mode 100755
index 00000000..63fb89ea
--- /dev/null
+++ b/tests/btrfs/281
@@ -0,0 +1,89 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 281
+#
+# Test that if we have a snapshot with a compressed extent that is partially
+# shared between two files, one of them has a size that is not sector size
+# aligned, we create a v2 send stream for the snapshot with compressed data,
+# and then apply that stream to another filesystem, the operation succeeds and
+# no data is missing. Also check that the file that had a reference to the whole
+# extent gets two compressed extents in the new filesystem, with only one of
+# them being shared (reflinked).
+#
+. ./common/preamble
+_begin_fstest auto quick send compress clone fiemap
+
+. ./common/filter
+. ./common/reflink
+. ./common/punch # for _filter_fiemap_flags
+
+_supported_fs btrfs
+_require_test
+_require_scratch_reflink
+_require_btrfs_send_v2
+_require_xfs_io_command "fiemap"
+_require_fssum
+
+_fixed_by_kernel_commit a11452a3709e \
+	"btrfs: send: avoid unaligned encoded writes when attempting to clone range"
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+send_stream=$send_files_dir/snap.stream
+snap_fssum=$send_files_dir/snap.fssum
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount -o compress
+
+# File foo has a size of 65K, which is not sector size aligned for any
+# supported sector size on btrfs.
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 65K" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# File bar has a compressed extent (and its size is sector size aligned).
+$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 128K" $SCRATCH_MNT/bar | _filter_xfs_io
+
+# Now clone only half of bar's extent into foo.
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 0 64K" $SCRATCH_MNT/foo \
+	| _filter_xfs_io
+
+echo "Creating snapshot and a send stream for it..."
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
+	| _filter_scratch
+$BTRFS_UTIL_PROG send --compressed-data -f $send_stream $SCRATCH_MNT/snap 2>&1 \
+	| _filter_scratch
+
+$FSSUM_PROG -A -f -w $snap_fssum $SCRATCH_MNT/snap
+
+echo "Creating a new filesystem to receive the send stream..."
+_scratch_unmount
+_scratch_mkfs >> $seqres.full 2>&1
+# Mount without compression, we created the stream with data compression enabled
+# so we want to verify that applying the stream preserves the compression.
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_stream $SCRATCH_MNT
+
+echo "Verifying data matches the original filesystem..."
+$FSSUM_PROG -r $snap_fssum $SCRATCH_MNT/snap
+
+# Now check that fiemap reports two extents for file bar:
+#
+# 1) The first extent should be encoded, because compression was enabled in the
+#    original filesystem, and should also be flagged as shared, since that file
+#    range was reflinked with file foo in the original filesystem;
+#
+# 2) The second extent should also be encoded (compression was enabled in the
+#    original filesystem), but not shared since that file range was not
+#    reflinked in the original filesystem. It should also have the "last" flag
+#    set, as it's the last extent in the file.
+#
+echo "File bar fiemap output in the new filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_flags 1
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
new file mode 100644
index 00000000..2585e3e5
--- /dev/null
+++ b/tests/btrfs/281.out
@@ -0,0 +1,17 @@
+QA output created by 281
+wrote 66560/66560 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating snapshot and a send stream for it...
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+At subvol SCRATCH_MNT/snap
+Creating a new filesystem to receive the send stream...
+At subvol snap
+Verifying data matches the original filesystem...
+OK
+File bar fiemap output in the new filesystem:
+0: [0..127]: shared|encoded
+1: [128..255]: encoded|last
-- 
2.35.1

