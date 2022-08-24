Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF8659F7F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiHXKmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiHXKmX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 06:42:23 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928C981B24;
        Wed, 24 Aug 2022 03:42:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 8624232AB456C;
        Wed, 24 Aug 2022 18:42:19 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1661337740; bh=4fgiF98jEpXdHvxtiUEuAAA7pGBn99bSC1JCKZg9/2c=;
        h=From:To:Cc:Subject:Date;
        b=lilGtVp8xPV/OYurw6HzImXhGGtR6YLvyg8vsdR0FUwNzevnIL0L+9wuQQdPNWGbG
         oTNQ/XO0STyi9B64Avp5BE/6rGg5329C6rirKfDPW4OegRtw+S8aVJxnS94au5Hz4r
         kVHT2KL+bypRoL4irQcEV5cFMQk8iEfG6uhq5/uc=
From:   bingjingc <bingjingc@synology.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     fdmanana@kernel.org, zlang@redhat.com, bingjingc@synology.com,
        bxxxjxxg@gmail.com
Subject: [PATCH v3] fstests: btrfs: test incremental send for changed reference paths
Date:   Wed, 24 Aug 2022 18:42:02 +0800
Message-Id: <20220824104202.2505-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Normally btrfs stores file paths in an array of ref items. However, items
for the same parent directory can not exceed the size of a leaf. So btrfs
also store the rest of them in extended ref items alternatively.

In this test, it creates a large number of links under a directory causing
the file paths stored in these two ways to be the parent snapshot. And it
deletes and recreates just an amount of them that can be stored within an
array of ref items to be the send snapshot. Test that an incremental send
operation correctly issues link/unlink operations only against new/deleted
paths, or the receive operation will fail due to a link on an existed path.

This currently fails on btrfs but is fixed by a kernel patch with the
commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
existing file paths")

Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 tests/btrfs/272     | 91 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/272.out |  3 ++
 2 files changed, 94 insertions(+)
 create mode 100755 tests/btrfs/272
 create mode 100644 tests/btrfs/272.out

diff --git a/tests/btrfs/272 b/tests/btrfs/272
new file mode 100755
index 00000000..57dd065c
--- /dev/null
+++ b/tests/btrfs/272
@@ -0,0 +1,91 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 BingJing Chang.
+#
+# FS QA Test No. btrfs/272
+#
+# Regression test for btrfs incremental send issue where a link instruction
+# is sent against an existing path, causing btrfs receive to fail.
+#
+# This issue is fixed by the following linux kernel btrfs patch:
+#
+#   commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
+#   existing file paths")
+#
+. ./common/preamble
+_begin_fstest auto quick send
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs btrfs
+_fixed_by_kernel_commit 3aa5bd367fa5a3 \
+	"btrfs: send: fix sending link commands for existing file paths"
+_require_test
+_require_scratch
+_require_fssum
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Create a file and 2000 hard links to the same inode
+_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
+touch $SCRATCH_MNT/vol/foo
+for i in {1..2000}; do
+	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
+done
+
+# Create a snapshot for a full send operation
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
+
+# Remove 2000 hard links and re-create the last 1000 links
+for i in {1..2000}; do
+	rm $SCRATCH_MNT/vol/$i
+done
+for i in {1001..2000}; do
+	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
+done
+
+# Create another snapshot for an incremental send operation
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap2
+_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+		     $SCRATCH_MNT/snap2
+
+$FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/snap1
+$FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
+	-x $SCRATCH_MNT/snap2/snap1 $SCRATCH_MNT/snap2
+
+# Recreate the filesystem by receiving both send streams and verify we get
+# the same content that the original filesystem had.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Add the first snapshot to the new filesystem by applying the first send
+# stream.
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+
+# The incremental receive operation below used to fail with the following
+# error:
+#
+#    ERROR: link 1238 -> foo failed: File exists
+#
+# This is because the path "1238" was stored as an extended ref item in the
+# original snapshot but as a normal ref item in the next snapshot. The send
+# operation cannot handle the duplicated paths, which are stored in
+# different ways, well, so it decides to issue a link operation for the
+# existing path. This results in the receiver to fail with the above error.
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/snap1
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/snap2
+
+status=0
+exit
diff --git a/tests/btrfs/272.out b/tests/btrfs/272.out
new file mode 100644
index 00000000..b009b87a
--- /dev/null
+++ b/tests/btrfs/272.out
@@ -0,0 +1,3 @@
+QA output created by 272
+OK
+OK
-- 
2.37.1

