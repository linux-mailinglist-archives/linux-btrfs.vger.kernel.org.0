Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A7C51FFE9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiEIOfZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 10:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbiEIOfY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 10:35:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5103AA7E;
        Mon,  9 May 2022 07:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BCBFB81629;
        Mon,  9 May 2022 14:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD7FC385A8;
        Mon,  9 May 2022 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652106686;
        bh=+6UbeY9xYzbc2lM4FcLkUebuZm+rJOcmdE5EBSDH8wU=;
        h=From:To:Cc:Subject:Date:From;
        b=I8P7RbLHkJIu4bmpaCZNGj24hNs3zcfnDFmIs3DunCKbI7qJrg9jxfjCXCvVsQ+6m
         YGuby0ocgnkM92i6nPG2/15FUlF3iOvxvBuDJ2zgbeKq2MZoW/leW+4IWt1BBmIvIa
         Jz5qspaFKFZNVLXVtev3My9993eDaS5qYZx2uootud4hRJX3GdhxJF42OifZQQ571O
         z9cqJVlhn9lCL/OA6ALK54R+S5ZIa/TUuuEUmAQ+bkv4j8WQ/e2KfCLziv/e0PyJ0l
         Bcu6dl4owZrqfKwXqMyqMmc7wN59xzST400wdh04CfVt0Z8NbnTsh7e5q1Ero44E3o
         mFNXkehaWa3Tg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@kernel.org, ddiss@suse.de,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] generic: test fsync of directory with renamed symlink
Date:   Mon,  9 May 2022 15:31:02 +0100
Message-Id: <3f3d20ef0abcc05ebfb6bc4aaa97261598611e49.1652106518.git.fdmanana@suse.com>
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

Test that if we fsync a directory, create a symlink inside it, rename
the symlink, fsync again the directory and then power fail, after the
filesystem is mounted again, the symlink exists with the new name and
it has the correct content.

This currently fails on btrfs, because the symlink ends up empty (which
is illegal on Linux), but it is fixed by kernel commit:

    d0e64a981fd841 ("btrfs: always log symlinks in full mode")

Reviewed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

v2: Rebased on latest for-next, quoted $SCRATCH_MNT references (David Disseldorp)
    and added David's review tag.

 tests/generic/690     | 90 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/690.out |  2 +
 2 files changed, 92 insertions(+)
 create mode 100755 tests/generic/690
 create mode 100644 tests/generic/690.out

diff --git a/tests/generic/690 b/tests/generic/690
new file mode 100755
index 00000000..f03295a5
--- /dev/null
+++ b/tests/generic/690
@@ -0,0 +1,90 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 690
+#
+# Test that if we fsync a directory, create a symlink inside it, rename the
+# symlink, fsync again the directory and then power fail, after the filesystem
+# is mounted again, the symlink exists with the new name and it has the correct
+# content.
+#
+# On btrfs this used to result in the symlink being empty (i_size 0), and it was
+# fixed by kernel commit:
+#
+#    d0e64a981fd841 ("btrfs: always log symlinks in full mode")
+#
+. ./common/preamble
+_begin_fstest auto quick log
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
+
+# real QA test starts here
+
+_supported_fs generic
+_require_scratch
+_require_symlinks
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+# f2fs doesn't support fs-op level transaction functionality, so it has no way
+# to persist all metadata updates in one transaction. We have to use its mount
+# option "fastboot" so that it triggers a metadata checkpoint to persist all
+# metadata updates that happen before a fsync call. Without this, after the
+# last fsync in the test, the symlink named "baz" will not exist.
+if [ $FSTYP = "f2fs" ]; then
+	export MOUNT_OPTIONS="-o fastboot $MOUNT_OPTIONS"
+fi
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test directory.
+mkdir "$SCRATCH_MNT"/testdir
+
+# Commit the current transaction and persist the directory.
+sync
+
+# Create a file in the test directory, so that the next fsync on the directory
+# actually does something (it logs the directory).
+echo -n > "$SCRATCH_MNT"/testdir/foo
+
+# Fsync the directory.
+$XFS_IO_PROG -c "fsync" "$SCRATCH_MNT"/testdir
+
+# Now create a symlink inside the test directory.
+ln -s "$SCRATCH_MNT"/testdir/foo "$SCRATCH_MNT"/testdir/bar
+
+# Rename the symlink.
+mv "$SCRATCH_MNT"/testdir/bar "$SCRATCH_MNT"/testdir/baz
+
+# Fsync again the directory.
+$XFS_IO_PROG -c "fsync" "$SCRATCH_MNT"/testdir
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log.
+_flakey_drop_and_remount
+
+# The symlink should exist, with the name "baz" and its content must be
+# "$SCRATCH_MNT/testdir/foo".
+[ -L "$SCRATCH_MNT"/testdir/baz ] || echo "symlink 'baz' is missing"
+symlink_content=$(readlink "$SCRATCH_MNT"/testdir/baz | _filter_scratch)
+echo "symlink content: ${symlink_content}"
+
+_unmount_flakey
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/690.out b/tests/generic/690.out
new file mode 100644
index 00000000..84be1247
--- /dev/null
+++ b/tests/generic/690.out
@@ -0,0 +1,2 @@
+QA output created by 690
+symlink content: SCRATCH_MNT/testdir/foo
-- 
2.35.1

