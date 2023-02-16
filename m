Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7E699932
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 16:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBPPrY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 10:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPPrX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 10:47:23 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807744B6;
        Thu, 16 Feb 2023 07:47:22 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EFB683200998;
        Thu, 16 Feb 2023 10:47:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 16 Feb 2023 10:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1676562440; x=1676648840; bh=Qh+fmMn04IoD/8mDyLfDcboII
        qSZJlt0vuCKaQwYS/w=; b=RlNWcaZgaM6rB37Qi6F7xqeNZfY6XTe76tkJyI5SL
        Hdq9oPjJdCxr0HUpbtFl50brq28p83ejLke4nsa6e6YaMSdC4bjvJB+qwgKu4Gg0
        xfI+qA6wz8VfL+ODh5iZGk2KmziWRGW7fufTQfuakj0LLXS76TCMEFO+rs1nHUXb
        KPotKZPNVeYHrr45bRkpLJ/4ThymDwEVn4DTTUjQ1ul1JKPVBqBOtY2wDo8QeD1F
        WABl9RiU/y0r+T2E2YUYq0/WB/k9FwxNgLzqV9Nln/nEpb46nAOFCEi6zsx9iKPh
        +XNfV/hd9mjwdQd1eYNHywzAf/kCSD/OcbUCih/oD3Lmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1676562440; x=1676648840; bh=Qh+fmMn04IoD/8mDyLfDcboIIqSZJlt0vuC
        KaQwYS/w=; b=KDUoDXLO7ba3GetIv308r65TfyxT/ciogAO0Xq4aJxDoXtPMy4L
        ILUUx9YgRVtxk8fA/JIM/g2UkMmeEDJvMvmeSIphCr2J5INcih/n8RYoAssiRZBY
        2QBe2W49WXLj7KngmRluAjb6C+QCaN1aDujsK/CkSd0qsxGHPiIKY/YKm6snJT7Q
        /bPSQvb9okJ17pUq1PE7ln2/YdD2RwQtSbedXZ9pKjg/FtrLFvx+3c8uxIlbdmZI
        nDO32ja16F2FikJXJXzBbNZc5amZAMesnYE/qukp1kYyTc39zUd2+0aIL+8F/a+w
        1KUoRQPOD6mUu+6U7+eCl5HfqTNOXUddVkQ==
X-ME-Sender: <xms:CFDuY4RZF4MQkDfj5-X3JMadcu66b0rIF1-vfUK0YTctJeZr0Jmo-w>
    <xme:CFDuY1zRAxGLAoGkSD4z5VkUQvI5FeUQ6Gx9iW3abnjGlG-13kqyr6V1ONjeDIaKX
    ix2YBuXvWC1rcSbds4>
X-ME-Received: <xmr:CFDuY10k6WwRYovuxWT5xxZqmGbfIKT1q3I9_KW_bcxnau51z1WkANIm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:CFDuY8B1j0ZG9cRGJ2kKMQFVE7hG1NxCEjV1_I5PXE3GhdeBcXRFoA>
    <xmx:CFDuYxhnIzi_v1mihnxF-GmF4js1_dqa7ZDjrUw5mDAWfJSgNcnWgQ>
    <xmx:CFDuY4oRuRAlUgQso8Tt_NY1p65UfVW2u7DWnvZFzP9ZVsJWZ5O28A>
    <xmx:CFDuYxZ5t5LnAx3qUkBY7B3QiQg_IxxSzl8C6plyJ2mEhysQDnDLRw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Feb 2023 10:47:19 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v7] btrfs: test block group size class loading logic
Date:   Thu, 16 Feb 2023 07:47:18 -0800
Message-Id: <a5d8e8988d8ea9c8ee81a96c69566a112527dccd.1676562365.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new test which checks that size classes in freshly loaded block
groups after a cycle mount match size classes before going down

Depends on the kernel patch:
btrfs: add size class stats to sysfs

Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v7:
Rebase, move to btrfs/284.
Remove mount test group.
v6:
Actually include changes for v5 in the commit.
v5:
Instead of using _fixed_by_kernel_commit, use require_fs_sysfs to handle
the needed sysfs file. The test is skipped on kernels without the file
and runs correctly on new ones.
v4:
Fix dumb typo in _fixed_by_kernel_commit (left out leading underscore
copy+pasting). Re-tested happy and sad case...
v3:
Re-add fixed_by_kernel_commit, but for the stats patch which is
required, but not a fix in the strictest sense.
v2:
Drop the fixed_by_kernel_commit since the fix is not out past the btrfs
development tree, so the fix is getting rolled in to the original broken
commit. Modified the commit message to note the dependency on the new
sysfs counters.

 tests/btrfs/284     | 50 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/284.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/btrfs/284
 create mode 100644 tests/btrfs/284.out

diff --git a/tests/btrfs/284 b/tests/btrfs/284
new file mode 100755
index 00000000..340b3cd9
--- /dev/null
+++ b/tests/btrfs/284
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 284
+#
+# Test that mounting a btrfs filesystem properly loads block group size classes.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+sysfs_size_classes() {
+	local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
+	cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"
+}
+
+_supported_fs btrfs
+_require_scratch
+_require_btrfs_fs_sysfs
+_require_fs_sysfs allocation/data/size_classes
+
+f="$SCRATCH_MNT/f"
+small=$((16 * 1024))
+medium=$((1024 * 1024))
+large=$((16 * 1024 * 1024))
+
+_scratch_mkfs >/dev/null
+_scratch_mount
+# Write files with extents in each size class
+$XFS_IO_PROG -fc "pwrite -q 0 $small" $f.small
+$XFS_IO_PROG -fc "pwrite -q 0 $medium" $f.medium
+$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large
+# Sync to force the extent allocation
+sync
+pre=$(sysfs_size_classes)
+
+# cycle mount to drop the block group cache
+_scratch_cycle_mount
+
+# Another write causes us to actually load the block groups
+$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large.2
+sync
+
+post=$(sysfs_size_classes)
+diff <(echo $pre) <(echo $post)
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/284.out b/tests/btrfs/284.out
new file mode 100644
index 00000000..931839fe
--- /dev/null
+++ b/tests/btrfs/284.out
@@ -0,0 +1,2 @@
+QA output created by 284
+Silence is golden
-- 
2.39.1

