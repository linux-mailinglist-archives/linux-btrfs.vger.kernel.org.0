Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB076988B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 00:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBOXUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 18:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBOXUh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 18:20:37 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0652B42BE2;
        Wed, 15 Feb 2023 15:20:35 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B05B93200942;
        Wed, 15 Feb 2023 18:20:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Feb 2023 18:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1676503234; x=1676589634; bh=nfcbJYLRBqiMTw9PoxE1v4oit
        a3cF2XD3anoamKYM50=; b=fMAl59r6ZZIYUGQUO6aDzO0shAdFs0WY2OvxRDBir
        V1mRkjF6zg5p1hP9o4LMJx39n4hUiKIp5Epr2VTjkb/9oYeJMEXRdM3nP3ibVHLs
        k2MUp2EByTIU/GuFUp1iZTdw3IFonCxMC3/Y0E08zHID9jm/ADUYXeMp8icAQAml
        dZsU6dRb+q2UZaldYH4ZbihVvN+N87H9kyv7MH+5pJfQaLAeg3UFHeQHYWKf6asK
        5xxqJlJhqeOjYgRSTvPECRkTLiuGZBNXL/CooVBtKznG3oU5VfpsbLsCuawBx+27
        i8wd561M6zjbJRrPNLzBm6ap2lMnTsuRN7+Gc0XxcnsnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1676503234; x=1676589634; bh=nfcbJYLRBqiMTw9PoxE1v4oita3cF2XD3an
        oamKYM50=; b=jBl6+OabyK7tT8Liy3pEtsKi4yEdI/j8W38E3vQs4Sq0BAr4mNs
        3fLTSZEZbwipzdF2WxkqCz52exSO7FBmB4F7QkSC8uVQdAP1vLIC7rshIBuoGLrE
        3RrsJe1hOSvzExvVC7rWIVEnSEjZNxJw40zAM6w0KwUc3tWc3fD3H00uTDdMboJU
        wpa4B9KxzfNLxj4RSZ4yvkaewjr/NKeRnbeVRNrNCn4GedOmjeMWta+aopm3EPgw
        hO/T/sNgANE0w5utU8ZYbBKBpIHJZUwyFkQ/9EbN4TiuujjqC/iYqc9/lfHtGv97
        vrKJZE4p5dR8WJhlr9ixoc4AnSSHpqhGovA==
X-ME-Sender: <xms:wmjtYyUuEwnRLuCBE0cniq_tHB_MdYwufHEi35S5Otsoi9nvNqViag>
    <xme:wmjtY-n_sQC7SVhX3-wemHwOV75lArpEclnT83Hc54VGID_C04NKohtmU7GEV8cAq
    9MsZMTy1i7bPrYpWW0>
X-ME-Received: <xmr:wmjtY2ak4ScFAYqMrpXbxi1pe3U0ggfEfjCsrsYJShFTFK5Al1p6JfZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiiedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:wmjtY5UPsvsOmsYWkRDyDkCq8nQ--E8zAzje_aWMOZBJAy4pqdbTUg>
    <xmx:wmjtY8lEcPQxENYw_slZV1gWnrTMxC70SPjam7HgHo7d2qFAY_N4HQ>
    <xmx:wmjtY-d7zCklmZzAmJzr4t9WaJURaBqrZzptl-xClu9ZZL1yxKicsg>
    <xmx:wmjtY4uYgfAxB3kaPyidnOHJ-AWLGdRMHoFDfb2spC5eR25cLMCWLw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 18:20:33 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v6] btrfs: test block group size class loading logic
Date:   Wed, 15 Feb 2023 15:20:32 -0800
Message-Id: <160e7557f66a6a34fd052d6834909aa02a702956.1676503163.git.boris@bur.io>
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


 tests/btrfs/283     | 50 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/283.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/btrfs/283
 create mode 100644 tests/btrfs/283.out

diff --git a/tests/btrfs/283 b/tests/btrfs/283
new file mode 100755
index 00000000..2c26b41e
--- /dev/null
+++ b/tests/btrfs/283
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 283
+#
+# Test that mounting a btrfs filesystem properly loads block group size classes.
+#
+. ./common/preamble
+_begin_fstest auto quick mount
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
diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
new file mode 100644
index 00000000..efb2c583
--- /dev/null
+++ b/tests/btrfs/283.out
@@ -0,0 +1,2 @@
+QA output created by 283
+Silence is golden
-- 
2.39.1

