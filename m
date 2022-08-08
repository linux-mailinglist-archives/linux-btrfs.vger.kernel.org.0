Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD058C76C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbiHHLVE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 07:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHHLVD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 07:21:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE19FE80;
        Mon,  8 Aug 2022 04:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DE1EB803F6;
        Mon,  8 Aug 2022 11:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543D5C433D6;
        Mon,  8 Aug 2022 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659957660;
        bh=W+M9uGv2Jn1unWmblGLLj0WmGrqV36rpg6ZAhtclXxg=;
        h=From:To:Cc:Subject:Date:From;
        b=O5IcvuATPi12mt8ogfKDLZ4VzhBLwlWh9CTy+ueIwRK4INzETNZ3UEIGWuZ/MmmMm
         SsH91CEbqB6rhgCeRcbzXcC60CfYElYQYZmNXWH+HEIuWzx/SmKmOPmYtHbPKcRIKa
         ZykFdT0rxKEC2SdwK2MTLCS9KJ74U1YWGa7qD/lnpePMDPwXaqWKw0qiAejssdKHSU
         ZJXM+hpT/f3xLte5UGvN5ll4XT2EHK7Me+OBKWdTwC6eT0BvjYuF/rAlcLLRI3UXsa
         2UfaUhgrXjYEJMC3zbVpb9kpU0EOvLp+/Yp7smbirwpz7LriQGEftNCBip8oBKYgOS
         dY3FkpIrNjVug==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test fsync after punching hole adjacent to an existing hole
Date:   Mon,  8 Aug 2022 12:18:58 +0100
Message-Id: <83a74ba89e9e4ee1060b7dfa1f190d4b51691909.1659957268.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we punch a hole adjacent to an existing hole, fsync the file
and then power fail, the new hole exists after mounting again the
filesystem.

This currently fails on btrfs with kernels 5.18 and 5.19 when not using
the "no-holes" feature. The "no-holes" feature is enabled by default at
mkfs time starting with btrfs-progs 5.15, so to trigger the issue with
btrfs-progs 5.15+ and kernel 5.18 or kernel 5.19, one must set
"-O ^no-holes" in the MKFS_OPTIONS environment variable (part of the
btrfs test matrix).

The issue is fixed for btrfs with the following kernel patch:

  "btrfs: update generation of hole file extent item when merging holes"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/694     | 85 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/694.out | 15 ++++++++
 2 files changed, 100 insertions(+)
 create mode 100755 tests/generic/694
 create mode 100644 tests/generic/694.out

diff --git a/tests/generic/694 b/tests/generic/694
new file mode 100755
index 00000000..c034f914
--- /dev/null
+++ b/tests/generic/694
@@ -0,0 +1,85 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 694
+#
+# Test that if we punch a hole adjacent to an existing hole, fsync the file and
+# then power fail, the new hole exists after mounting again the filesystem.
+#
+. ./common/preamble
+_begin_fstest quick log punch
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/dmflakey
+. ./common/punch
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_scratch
+_require_dm_target flakey
+_require_xfs_io_command "fpunch"
+_require_xfs_io_command "fiemap"
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test file with the following layout:
+#
+# [0, 2M)    - hole
+# [2M, 10M)  - extent
+# [10M, 12M) - hole
+$XFS_IO_PROG -f -c "truncate 12M" \
+	     -c "pwrite -S 0xab 2M 8M" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Persist everything, commit the filesystem's transaction.
+sync
+
+# Now punch two holes in the file:
+#
+# 1) For the range [2M, 4M), which is adjacent to the existing hole in the range
+#    [0, 2M);
+# 2) For the range [8M, 10M), which is adjacent to the existing hole in the
+#    range [10M, 12M).
+#
+# These operations start a new filesystem transaction.
+# Then finally fsync the file.
+$XFS_IO_PROG -c "fpunch 2M 2M" \
+	     -c "fpunch 8M 2M" \
+	     -c "fsync" $SCRATCH_MNT/foobar
+
+# Simulate a power failure and mount the filesystem to check that everything
+# is in the same state as before the power failure.
+_flakey_drop_and_remount
+
+# We expect the following file layout:
+#
+# [0, 4M)    - hole
+# [4M, 8M)   - extent
+# [8M, 12M)  - hole
+echo "File layout after power failure:"
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar | _filter_fiemap
+
+# When reading the file we expect to get the range [4M, 8M) filled with bytes
+# that have a value of 0xab and 0x00 for anything outside that range.
+echo "File content after power failure:"
+od -A d -t x1 $SCRATCH_MNT/foobar
+
+_unmount_flakey
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/694.out b/tests/generic/694.out
new file mode 100644
index 00000000..f55212f3
--- /dev/null
+++ b/tests/generic/694.out
@@ -0,0 +1,15 @@
+QA output created by 694
+wrote 8388608/8388608 bytes at offset 2097152
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File layout after power failure:
+0: [0..8191]: hole
+1: [8192..16383]: data
+2: [16384..24575]: hole
+File content after power failure:
+0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+4194304 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+8388608 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+12582912
-- 
2.35.1

