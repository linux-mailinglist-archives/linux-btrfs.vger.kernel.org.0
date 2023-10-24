Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6E47D4EC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 13:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjJXLYA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 07:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjJXLX6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 07:23:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7344EFE;
        Tue, 24 Oct 2023 04:23:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0917AC433C7;
        Tue, 24 Oct 2023 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698146636;
        bh=mTnMbIwuf8YWJ9V6rvZW9WCT2iE09mXnh5FhjRRjnIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/Gu7yD/nzv+294NTHMBHsEME15Cmq+EBN4hjJOP2JLrSvgr2ktcTmX7NA62KUHmh
         7ggTY3b1jbcOAelgzCEBzfAlCzrLfe6YO28NZBe6h0+8hXJth+/ljbC/kO16cV3/Q3
         EBivKK+aUhfiqKVYdLcxN2DpVcRPMWOXXIV+9AL3P2XuTLZaAq4T9uFpuJlkWco0BU
         h/alpN0M/0HvOwWXrLPppheje1NE1SO6WBaE1yP1M3ZmcIHhpN/o5aWZww7079tWR0
         cPnaUJ2g0RQZuhqnYJt2scxSUD7uyLh2oMVMQpLAr0k32WgTU7PrJxpHHQrex4ScUu
         LlK0zf9ZZzDvA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2] btrfs: test snapshotting a subvolume that was just created
Date:   Tue, 24 Oct 2023 12:23:46 +0100
Message-Id: <c0b651af75a999cb1356e64d936080b65067ae56.1698146559.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3149ccc2900f5574a046e675a6db79b019af2bac.1697718086.git.fdmanana@suse.com>
References: <3149ccc2900f5574a046e675a6db79b019af2bac.1697718086.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that snapshotting a new subvolume (created in the current transaction)
that has a btree with a height > 1, works and does not result in a fs
corruption.

This exercises a regression introduced in kernel 6.5 by the kernel commit:

  1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---

v2: Add git commit ID for the kernel fix, as it was merged yesterday into
    Linus' tree. Also fixed a typo and included Josef's Reviewed-by tag.

 tests/btrfs/302     | 61 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/302.out |  4 +++
 2 files changed, 65 insertions(+)
 create mode 100755 tests/btrfs/302
 create mode 100644 tests/btrfs/302.out

diff --git a/tests/btrfs/302 b/tests/btrfs/302
new file mode 100755
index 00000000..f3e6044b
--- /dev/null
+++ b/tests/btrfs/302
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 302
+#
+# Test that snapshotting a new subvolume (created in the current transaction)
+# that has a btree with a height > 1, works and does not result in a filesystem
+# corruption.
+#
+# This exercises a regression introduced in kernel 6.5 by the kernel commit:
+#
+#    1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")
+#
+. ./common/preamble
+_begin_fstest auto quick snapshot subvol
+
+. ./common/filter
+
+_supported_fs btrfs
+_require_scratch
+_require_fssum
+
+_fixed_by_kernel_commit eb96e221937a \
+	"btrfs: fix unwritten extent buffer after snapshotting a new subvolume"
+
+# Use a filesystem with a 64K node size so that we have the same node size on
+# every machine regardless of its page size (on x86_64 default node size is 16K
+# due to the 4K page size, while on PPC it's 64K by default). This way we can
+# make sure we are able to create a btree for the subvolume with a height of 2.
+_scratch_mkfs -n 64K >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
+
+# Create a few empty files on the subvolume, this bumps its btree height to 2
+# (root node at level 1 and 2 leaves).
+for ((i = 1; i <= 300; i++)); do
+	echo -n > $SCRATCH_MNT/subvol/file_$i
+done
+
+# Create a checksum of the subvolume's content.
+fssum_file="$SCRATCH_MNT/checksum.fssum"
+$FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
+
+# Now create a snapshot of the subvolume and make it accessible from within the
+# subvolume.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
+		 $SCRATCH_MNT/subvol/snap | _filter_scratch
+
+# Now unmount and mount again the fs. We want to verify we are able to read all
+# metadata for the snapshot from disk (no IO failures, etc).
+_scratch_cycle_mount
+
+# The snapshot's content should match the subvolume's content before we created
+# the snapshot.
+$FSSUM_PROG -r $fssum_file $SCRATCH_MNT/subvol/snap
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
new file mode 100644
index 00000000..8770aefc
--- /dev/null
+++ b/tests/btrfs/302.out
@@ -0,0 +1,4 @@
+QA output created by 302
+Create subvolume 'SCRATCH_MNT/subvol'
+Create a readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol/snap'
+OK
-- 
2.40.1

