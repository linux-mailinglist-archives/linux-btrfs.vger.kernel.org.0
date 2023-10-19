Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67367CF8A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 14:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbjJSMYO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 08:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjJSMYN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 08:24:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C74A3;
        Thu, 19 Oct 2023 05:24:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1654EC433C8;
        Thu, 19 Oct 2023 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697718251;
        bh=jVv88ycSKk1t4XZAyebfgY8YDB4MbBZTE/cuELqnjgw=;
        h=From:To:Cc:Subject:Date:From;
        b=Fo4LlXdGg4PQwU1zxww6tWngkVXt0J63I3E7k9mobvYOhBTdUyc+WSmKL5F8+++7m
         q7NWxqB6IwHNyxspFft/3zD3FTcnlVd8Pg5h2fTEVwkWhZygQyOmUCQsK2P6pxVo8U
         1VJ/jDQ/ErsFHOVASMA7HRbS7iA5nlxGNB5SXfSwO2F9A9geY/TS5N0DKwEXbj7p7F
         4xhF08y7UAKKmDtCDxAR05Jj7S6TkFsGSlyz3nedzsRRJ9/39ZVFrDRjOjxl9OlGv3
         AoGC/+sFas6p9A3dNcKcGZtSw74ayOZ83FEx7jcZj9UtA0If+GZj93oYBIRwJhFf3Z
         BV6zzml3JEE5Q==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test snapshoting a subvolume that was just created
Date:   Thu, 19 Oct 2023 13:23:49 +0100
Message-Id: <3149ccc2900f5574a046e675a6db79b019af2bac.1697718086.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that snapshoting a new subvolume (created in the current transaction)
that has a btree with a height > 1, works and does not result in a fs
corruption.

This exercises a regression introduced in kernel 6.5 by the kernel commit:

  1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/302     | 61 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/302.out |  4 +++
 2 files changed, 65 insertions(+)
 create mode 100755 tests/btrfs/302
 create mode 100644 tests/btrfs/302.out

diff --git a/tests/btrfs/302 b/tests/btrfs/302
new file mode 100755
index 00000000..13b60f9d
--- /dev/null
+++ b/tests/btrfs/302
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 302
+#
+# Test that snapshoting a new subvolume (created in the current transaction)
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
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix unwritten extent buffer after snapshoting a new subvolume"
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

