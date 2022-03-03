Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791FD4CBCE7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 12:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiCCLlP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 06:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiCCLlO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 06:41:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50FA5419E;
        Thu,  3 Mar 2022 03:40:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 850FFB82502;
        Thu,  3 Mar 2022 11:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CA3C004E1;
        Thu,  3 Mar 2022 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646307626;
        bh=jANP81KBlGd9yJk8XpMl1DOaqoU7a5GCzy2wa6Kbtj0=;
        h=From:To:Cc:Subject:Date:From;
        b=e6Tt1thOJ/v3M3d5j+GFcnYR8VVk8tZa53P0GCoyC5EQJilynUT6LQoT3acChnRvM
         +QCEraq6W1pKLmHJtDPcA07/mCd1NKEBGevoyiFwzdUEInSvzCueEA0SEfrlDWEXK6
         DWsosmebQ/8z6tU6ehR3caxFqKNjzDv5D0d5fhK4lbB/bS1sEXiyzKfzxon3d/oray
         R93SHwOpF9VDt9Phvn43OUxBLTIY31w+9FtRuC9xq0LOFhRzcsyoLniiojhlool6s7
         ns50mmgTqF6680WxXS7uuapg8QDy6OVfBjJUkwiZQAAoUvOFhB4Sf/djDlodZIlX2n
         kuC9ic81kL9tw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: move test case btrfs/261 into the generic group
Date:   Thu,  3 Mar 2022 11:40:21 +0000
Message-Id: <69cac173b34bdb3135ffa12ecbf690029ca3c513.1646307523.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The test case btrfs/261, part from its comments, doesn't really exercise
any behaviour that is btrfs specific, so, as Dave Chinner pointed out, it
can be moved into the generic group.

This change moves that test into the generic group and slightly adjust the
comments to make it clear which parts are btrfs specific.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/{btrfs/261 => generic/677}         | 35 ++++++++++++++----------
 tests/{btrfs/261.out => generic/677.out} |  2 +-
 2 files changed, 22 insertions(+), 15 deletions(-)
 rename tests/{btrfs/261 => generic/677} (60%)
 rename tests/{btrfs/261.out => generic/677.out} (93%)

diff --git a/tests/btrfs/261 b/tests/generic/677
similarity index 60%
rename from tests/btrfs/261
rename to tests/generic/677
index 8275e6a5..1d4eaa53 100755
--- a/tests/btrfs/261
+++ b/tests/generic/677
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2022 SUSE Linux Products GmbH.  All Rights Reserved.
 #
-# FS QA Test 261
+# FS QA Test 677
 #
 # Test that after a full fsync of a file with preallocated extents beyond the
 # file's size, if a power failure happens, the preallocated extents still exist
@@ -25,7 +25,7 @@ _cleanup()
 
 # real QA test starts here
 
-_supported_fs btrfs
+_supported_fs generic
 _require_scratch
 _require_dm_target flakey
 _require_xfs_io_command "falloc" "-k"
@@ -39,11 +39,16 @@ _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
-# Create our test file with many file extent items, so that they span several
-# leaves of metadata, even if the node/page size is 64K. We use direct IO and
-# not fsync/O_SYNC because it's both faster and it avoids clearing the full sync
-# flag from the inode - we want the fsync below to trigger the slow full sync
-# code path.
+# Create our test file with many extents.
+# On btrfs this results in having multiple leaves of metadata full of file
+# extent items, a condition necessary to trigger the original bug.
+#
+# We use direct IO here because:
+#
+# 1) It's faster then doing fsync after each buffered write;
+#
+# 2) For btrfs, the first fsync would clear the inode's full sync runtime flag,
+#    and we want the fsync below to trigger the full fsync code path of btrfs.
 $XFS_IO_PROG -f -d -c "pwrite -b 4K 0 16M" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Now add two preallocated extents to our file without extending the file's size.
@@ -52,15 +57,17 @@ $XFS_IO_PROG -f -d -c "pwrite -b 4K 0 16M" $SCRATCH_MNT/foo | _filter_xfs_io
 $XFS_IO_PROG -c "falloc -k 16M 1M" $SCRATCH_MNT/foo
 $XFS_IO_PROG -c "falloc -k 20M 1M" $SCRATCH_MNT/foo
 
-# Make sure everything is durably persisted and the transaction is committed.
-# This makes all created extents to have a generation lower than the generation
-# of the transaction used by the next write and fsync.
+# Make sure everything is durably persisted.
+# On btrfs this commits the current transaction and it makes all the created
+# extents to have a generation lower than the generation of the transaction used
+# by the next write and fsync.
 sync
 
-# Now overwrite only the first extent, which will result in modifying only the
-# first leaf of metadata for our inode. Then fsync it. This fsync will use the
-# slow code path (inode full sync bit is set) because it's the first fsync since
-# the inode was created/loaded.
+# Now overwrite only the first extent.
+# On btrfs, due to COW (both data and metadata), that results in modifying only
+# the first leaf of metadata for our inode (we replace a file extent item and
+# update the inode item). Then fsync it. On btrfs this fsync will use the slow
+# code path because it's the first fsync since the inode was created/loaded.
 $XFS_IO_PROG -c "pwrite 0 4K" -c "fsync" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Simulate a power failure and then mount again the filesystem to replay the log
diff --git a/tests/btrfs/261.out b/tests/generic/677.out
similarity index 93%
rename from tests/btrfs/261.out
rename to tests/generic/677.out
index e9cfe1e8..4c91a0dd 100644
--- a/tests/btrfs/261.out
+++ b/tests/generic/677.out
@@ -1,4 +1,4 @@
-QA output created by 261
+QA output created by 677
 wrote 16777216/16777216 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 4096/4096 bytes at offset 0
-- 
2.33.0

