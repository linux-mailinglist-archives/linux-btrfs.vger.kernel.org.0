Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283525A65E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 16:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiH3OHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 10:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiH3OHV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 10:07:21 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BC7F72C6;
        Tue, 30 Aug 2022 07:07:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 835B235801DA1;
        Tue, 30 Aug 2022 22:07:16 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1661868437; bh=I5OogS8AePXVMG6sy9je9+8B6xup/wXIg9XDBn2p7VQ=;
        h=From:To:Cc:Subject:Date;
        b=deCgJjKKYWeIl54ZLySwKANGpkXM/aIVn7KieXPvVUYf9kWyogFKjFtX55h1FbdyX
         HPu5KTzFY+RlRyA22HAJafQeburzMakWJ+pkxPSZ2GDYzQ0L1iJ5MQnf77lG38AanN
         hKUnE0Thx1R/XMY2xFXDOSZfyP+1koUHHTwKKSQY=
From:   bingjingc <bingjingc@synology.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     fdmanana@kernel.org, zlang@redhat.com, bingjingc@synology.com,
        bxxxjxxg@gmail.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4] fstests: btrfs: test incremental send for changed reference paths
Date:   Tue, 30 Aug 2022 22:06:59 +0800
Message-Id: <20220830140659.47757-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
Changelog:

V3->V4:
  1. Remove the redundant import of common/filter.

V2->V3:
  1. Use _fixed_by_kernel_commit tag.
  2. Fix a bug creating the snapshot on a wrong path.
  3. Remove the unnecessary cleanup of temp files.
  4. Always keep the _scratch_mkfs output in $seqres.full.

V1->V2:
  1. Fix several typos.
  2. Create a temp folder as btrfs/241 to store the send streams.
  3. Use fssum utility to verify the results.
---
 tests/btrfs/272     | 88 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/272.out |  3 ++
 2 files changed, 91 insertions(+)
 create mode 100755 tests/btrfs/272
 create mode 100644 tests/btrfs/272.out

diff --git a/tests/btrfs/272 b/tests/btrfs/272
new file mode 100755
index 00000000..a49ec076
--- /dev/null
+++ b/tests/btrfs/272
@@ -0,0 +1,88 @@
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

