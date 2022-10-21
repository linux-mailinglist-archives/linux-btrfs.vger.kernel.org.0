Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85962606D04
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 03:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJUB2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 21:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJUB2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 21:28:17 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2438622D5E0;
        Thu, 20 Oct 2022 18:28:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.17.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id DD0C648AD8E56;
        Fri, 21 Oct 2022 09:28:13 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1666315694; bh=Mcwc/xysfiPp9KmR+fYxUpZHdWCznx5TLY6JFqvM3Ik=;
        h=From:To:Cc:Subject:Date;
        b=QNGuJXzBJM4UD/PDqnNe6Z7Ccz9xWSuFlEFyxQ9oogL9WFyPxnkCSma5Rzp5lAyaC
         tI+DOe7VXWgbqITLMQrhZKUbHJBpUSy1VsogpcEa23QpIDOfICF2pilqnieiBqgLfX
         oHrDL4tyDwFxtCbLpc50ySQd8ig7KP2xsp0gGH88=
From:   bingjingc <bingjingc@synology.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     fdmanana@kernel.org, bingjingc@synology.com, bxxxjxxg@gmail.com,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] fstests: btrfs: test incremental send for orphan inodes
Date:   Fri, 21 Oct 2022 09:27:55 +0800
Message-Id: <20221021012755.334389-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Test that an incremental send operation can handle orphan files or
directories in or not in the parent snapshot and the send snapshot.

This issue is fixed by a kernel patch with the commit 9ed0a72e5b355d
("btrfs: send: fix failures when processing inodes with no links")

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 tests/btrfs/278     | 218 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/278.out |   3 +
 2 files changed, 221 insertions(+)
 create mode 100755 tests/btrfs/278
 create mode 100644 tests/btrfs/278.out

diff --git a/tests/btrfs/278 b/tests/btrfs/278
new file mode 100755
index 00000000..ff59ebd2
--- /dev/null
+++ b/tests/btrfs/278
@@ -0,0 +1,218 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 BingJing Chang.
+#
+# FS QA Test No. btrfs/278
+#
+# Regression test for btrfs incremental send issue when processing inodes
+# with no links
+#
+# This issue is fixed by the following linux kernel btrfs patch:
+#
+#   commit 9ed0a72e5b355d ("btrfs: send: fix failures when processing
+#   inodes with no links")
+#
+. ./common/preamble
+_begin_fstest auto quick send
+
+# real QA test starts here
+_supported_fs btrfs
+_fixed_by_kernel_commit 9ed0a72e5b355d \
+	"btrfs: send: fix failures when processing inodes with no links"
+_require_test
+_require_scratch
+_require_btrfs_command "property"
+_require_fssum
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
+
+# Creating the first snapshot looks like:
+#
+# .                                                                  (ino 256)
+# |--- deleted.file                                                  (ino 257)
+# |--- deleted.dir/                                                  (ino 258)
+# |--- changed_subcase1.file                                         (ino 259)
+# |--- changed_subcase2.file                                         (ino 260)
+# |--- changed_subcase1.dir/                                         (ino 261)
+# |    |---- foo                                                     (ino 262)
+# |--- changed_subcase2.dir/                                         (ino 263)
+# |    |---- foo                                                     (ino 264)
+#
+touch $SCRATCH_MNT/vol/deleted.file
+mkdir $SCRATCH_MNT/vol/deleted.dir
+touch $SCRATCH_MNT/vol/changed_subcase1.file
+touch $SCRATCH_MNT/vol/changed_subcase2.file
+mkdir $SCRATCH_MNT/vol/changed_subcase1.dir
+touch $SCRATCH_MNT/vol/changed_subcase1.dir/foo
+mkdir $SCRATCH_MNT/vol/changed_subcase2.dir
+touch $SCRATCH_MNT/vol/changed_subcase2.dir/foo
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
+
+# Delete the deleted.*, create a new file and a new directory, and then
+# take the second snapshot looks like:
+#
+# .                                                                  (ino 256)
+# |--- changed_subcase1.file                                         (ino 259)
+# |--- changed_subcase2.file                                         (ino 260)
+# |--- changed_subcase1.dir/                                         (ino 261)
+# |    |---- foo                                                     (ino 262)
+# |--- changed_subcase2.dir/                                         (ino 263)
+# |    |---- foo                                                     (ino 264)
+# |--- new.file                                                      (ino 265)
+# |--- new.dir/                                                      (ino 266)
+#
+unlink $SCRATCH_MNT/vol/deleted.file
+rmdir $SCRATCH_MNT/vol/deleted.dir
+touch $SCRATCH_MNT/vol/new.file
+mkdir $SCRATCH_MNT/vol/new.dir
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap2
+
+# Set the snapshot "snap1" to read-write mode and turn several inodes to
+# orphans, so that the snapshot will look like this:
+#
+# .                                                                  (ino 256)
+# |--- (orphan) deleted.file                                         (ino 257)
+# |--- (orphan) deleted.dir/                                         (ino 258)
+# |--- (orphan) changed_subcase1.file                                (ino 259)
+# |--- changed_subcase2.file                                         (ino 260)
+# |--- (orphan) changed_subcase1.dir/                                (ino 261)
+# |--- changed_subcase2.dir/                                         (ino 263)
+# |    |---- foo                                                     (ino 264)
+#
+# Note: To make an easy illustration, I just put a tag "(orphan)" in front of
+# their original names to indicate that they're deleted, but their inodes can
+# not be removed because of open file descriptors on them. Mention that orphan
+# inodes don't have names(paths).
+#
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap1 ro false
+exec 71<$SCRATCH_MNT/snap1/deleted.file
+exec 72<$SCRATCH_MNT/snap1/deleted.dir
+exec 73<$SCRATCH_MNT/snap1/changed_subcase1.file
+exec 74<$SCRATCH_MNT/snap1/changed_subcase1.dir
+unlink $SCRATCH_MNT/snap1/deleted.file
+rmdir $SCRATCH_MNT/snap1/deleted.dir
+unlink $SCRATCH_MNT/snap1/changed_subcase1.file
+unlink $SCRATCH_MNT/snap1/changed_subcase1.dir/foo
+rmdir $SCRATCH_MNT/snap1/changed_subcase1.dir
+
+# Turn the snapshot "snap1" back to read-only mode.
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap1 ro true
+
+# Set the snapshot "snap2" to read-write mode and turn several inodes to
+# orphans, so that the snapshot will look like this:
+#
+# .                                                                  (ino 256)
+# |--- (orphan) changed_subcase1.file                                (ino 259)
+# |--- (orphan) changed_subcase2.file                                (ino 260)
+# |--- (orphan) changed_subcase1.dir/                                (ino 261)
+# |--- (orphan) changed_subcase2.dir/                                (ino 263)
+# |--- (orphan) new.file                                             (ino 265)
+# |--- (orphan) new.dir/                                             (ino 266)
+#
+# Note: Same notice as above. Mention that orphan inodes don't have
+# names(paths).
+#
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap2 ro false
+exec 81<$SCRATCH_MNT/snap2/changed_subcase1.file
+exec 82<$SCRATCH_MNT/snap2/changed_subcase1.dir
+exec 83<$SCRATCH_MNT/snap2/changed_subcase2.file
+exec 84<$SCRATCH_MNT/snap2/changed_subcase2.dir
+exec 85<$SCRATCH_MNT/snap2/new.file
+exec 86<$SCRATCH_MNT/snap2/new.dir
+unlink $SCRATCH_MNT/snap2/changed_subcase1.file
+unlink $SCRATCH_MNT/snap2/changed_subcase1.dir/foo
+rmdir $SCRATCH_MNT/snap2/changed_subcase1.dir
+unlink $SCRATCH_MNT/snap2/changed_subcase2.file
+unlink $SCRATCH_MNT/snap2/changed_subcase2.dir/foo
+rmdir $SCRATCH_MNT/snap2/changed_subcase2.dir
+unlink $SCRATCH_MNT/snap2/new.file
+rmdir $SCRATCH_MNT/snap2/new.dir
+
+# Turn the snapshot "snap2" back to read-only mode.
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap2 ro true
+
+# Test that a full send operation can handle orphans with no paths
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
+
+# Test that an incremental send operation can handle orphans.
+#
+# Here're descriptions for the details:
+#
+# Case 1: new.file and new.dir (BTRFS_COMPARE_TREE_NEW)
+#        |  send snapshot  | action
+#  --------------------------------
+#  nlink |        0        | ignore
+#
+# They are new inodes in the send snapshot ("snap2"), but they don't have
+# paths because they have no links. Test that the send operation can ignore
+# them in order not to generate the creation commands for them. Or it will
+# fail, with -ENOENT, when trying to generate paths for them.
+#
+#
+# Case 2: deleted.file and deleted.dir (BTRFS_COMPARE_TREE_DELETED)
+#       | parent snapshot | action
+# ----------------------------------
+# nlink |        0        | as usual
+#
+# They're deleted in the parent snapshot ("snap1") but become orphans which
+# have no paths. Test that no deletion commands will be generated as usual.
+# This case didn't fail before.
+#
+#
+# Case 3: changed_*.file and changed_*.dir (BTRFS_COMPARE_TREE_CHANGED)
+#           |       | parent snapshot | send snapshot | action
+# -----------------------------------------------------------------------
+# subcase 1 | nlink |        0        |       0       | ignore
+# subcase 2 | nlink |       >0        |       0       | new_gen(deletion)
+#
+# In subcase 1, test that the send operation can ignore them without trying
+# to generate any commands.
+#
+# In subcase 2, test that the send operation can generate an unlink command
+# for that file and test that it can generate a rename command for the
+# non-empty directory first and a rmdir command to remove it finally. Or
+# the receive operation will fail with a wrong unlink on a non-empty
+# directory.
+#
+_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+		     $SCRATCH_MNT/snap2
+
+$FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/snap1
+$FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
+	-x $SCRATCH_MNT/snap2/snap1 $SCRATCH_MNT/snap2
+
+# Recreate the filesystem by receiving both send streams and verify we get
+# the same content that the original filesystem had.
+exec 71>&-
+exec 72>&-
+exec 73>&-
+exec 74>&-
+exec 81>&-
+exec 82>&-
+exec 83>&-
+exec 84>&-
+exec 85>&-
+exec 86>&-
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Add the first snapshot to the new filesystem by applying the first send
+# stream.
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+
+# Test the incremental send stream
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/snap1
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/snap2
+
+status=0
+exit
diff --git a/tests/btrfs/278.out b/tests/btrfs/278.out
new file mode 100644
index 00000000..82b93b4e
--- /dev/null
+++ b/tests/btrfs/278.out
@@ -0,0 +1,3 @@
+QA output created by 278
+OK
+OK
-- 
2.37.1

