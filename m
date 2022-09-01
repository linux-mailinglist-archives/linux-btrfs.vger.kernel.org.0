Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7095A5A9CB2
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiIAQKp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 12:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiIAQKk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 12:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258A432A9F;
        Thu,  1 Sep 2022 09:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87C861F69;
        Thu,  1 Sep 2022 16:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4073FC433D6;
        Thu,  1 Sep 2022 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662048635;
        bh=lFQ7Y/eCSF3He4PUTwuqymxubf7JzTOuanMETZJH4SE=;
        h=From:To:Cc:Subject:Date:From;
        b=n58a+OmYHMRTy4g1g5SOLId2EkuSt/+exd+attIyg/uUeQ1GzM/wtYSxvhZloahMV
         VE03HvNwapGyYWxNVCtAFwooKkey+WmyBCjhrRUoYfD2J5hCUoBWr0mQhPHJVY69Zz
         Bz33EqOVdwB/NjYjYsI3FcTwG7WFuqEUU/nCmZOSOENPG06zE3z4yrIaUV2SUkF08h
         CRGzrmSbKL6lm5V5GdhJQGZ5+8Eowq4QOsSrXhhnNfK09rZyvFiGRsoDUEOQh+5z90
         d07GHfaoiyXXFS5cU2zE0dq9ytDOWQRxPy3/8oUK7W3NlOpkI3dYHYIn8+VlyDcXbG
         3mFS+jcE/N6lw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] generic: test fsync after punching hole adjacent to an existing hole
Date:   Thu,  1 Sep 2022 17:10:09 +0100
Message-Id: <176a9103bc2a3fe5cc8d9306c3a7c50d5cdc1568.1662048436.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v2: Added kernel commit tag (now that's merged in Linus' tree),
    added auto group, added the new odd _require_congruent_file_oplen
    requirement.

 tests/generic/695     | 91 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/695.out | 15 +++++++
 2 files changed, 106 insertions(+)
 create mode 100755 tests/generic/695
 create mode 100644 tests/generic/695.out

diff --git a/tests/generic/695 b/tests/generic/695
new file mode 100755
index 00000000..b46e35cf
--- /dev/null
+++ b/tests/generic/695
@@ -0,0 +1,91 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 695
+#
+# Test that if we punch a hole adjacent to an existing hole, fsync the file and
+# then power fail, the new hole exists after mounting again the filesystem.
+#
+# This is motivated by a regression on btrfs, fixed by the commit mentioned
+# below, when not using the no-holes feature (which is enabled by default since
+# btrfs-progs 5.15).
+#
+. ./common/preamble
+_begin_fstest auto quick log punch
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -r -f $tmp.*
+}
+
+. ./common/filter
+. ./common/dmflakey
+. ./common/punch
+
+_supported_fs generic
+_fixed_by_kernel_commit e6e3dec6c3c288 \
+        "btrfs: update generation of hole file extent item when merging holes"
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
+# We punch 2M holes and require extent allocations to align to 2M in fiemap
+# results.
+_require_congruent_file_oplen $SCRATCH_MNT $((2 * 1024 * 1024))
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
+_hexdump $SCRATCH_MNT/foobar
+
+_unmount_flakey
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/695.out b/tests/generic/695.out
new file mode 100644
index 00000000..447ef5cf
--- /dev/null
+++ b/tests/generic/695.out
@@ -0,0 +1,15 @@
+QA output created by 695
+wrote 8388608/8388608 bytes at offset 2097152
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File layout after power failure:
+0: [0..8191]: hole
+1: [8192..16383]: data
+2: [16384..24575]: hole
+File content after power failure:
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+400000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >................<
+*
+800000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+c00000
-- 
2.35.1

