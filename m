Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C10698713
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 22:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjBOVKw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 16:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjBOVKf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 16:10:35 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D255A6;
        Wed, 15 Feb 2023 13:10:21 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 828C332009B6;
        Wed, 15 Feb 2023 16:10:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 15 Feb 2023 16:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1676495418; x=1676581818; bh=GIWUKbLozinPeggLVCmnWZdsd
        /FdjO3reVTGgLkvVfM=; b=hFuKvF63yBjka4K1NVqt3Q71em/YMitV9yJD9Shap
        lh618rrCsnbZ/xxuvxdCQDOspiwGCRJ4pQ0dc/aX+ZNsypAcRmJC6cM7WjESUatA
        NWW52aCZFkpOwyrxqSjT1WcX0kxe4EHfZ6QqephYVcfMVMtR3T2ttxkYSVodMWN8
        PTUNl1OFNi0RD9pxybgN+Vfro5gwfQfQy8cZaPu+0XvJbb2DcAnoV1ZMe+huDHYJ
        UdOntFjJBFZUz4mSbSo6tCUKQpxCIPzgA341oo1X/8fWb+5DboItmXckN/a4MW9B
        2jd4RnTdKsaLjpUs3oGEB0FY3aR1t0BS8Ny72xSTLghwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1676495418; x=1676581818; bh=GIWUKbLozinPeggLVCmnWZdsd/FdjO3reVT
        GgLkvVfM=; b=T5ePQ96B66BMewtIRWeGiwPefbhAwHbJfsugoWYt3lCE5Q5a5he
        i828sjh++9ESy1U9XIo/ZXVriJS/xnaQ3EjP0mwOuMsNkHefgACvLXl3fARRamhK
        7jQ9dxb7NXH6r4ofIOnEk4/IBnxa/v+jP1BEoBZ1db6eLu5uPOqDED85Ywqumdv2
        XrwoX/Vv620H4stR162SZMYv3XQGmQYBPKb+BGd+n3EoLkUCF6sCg4jXqBIzYag+
        5qnlD9kBHebh8BHYGe+pX/BGPtde+l3OMMP4pLdlGWdZECPHaqsH6kK3ZwdDLbUR
        IJpPWbcersBHIfmDgznVrQj1FDVRE78ESdw==
X-ME-Sender: <xms:OUrtYzCYbmfHFecarGxdi0bd9FLrFwE2gmZ8KtRf_V7IHE0wQBzWyw>
    <xme:OUrtY5gICJvktu3FCBBng1gGNK6eRyd-wm7VWcfJ-efB7Fn6qHdiFe_KWJR_uyj9K
    IrKnFmpIHDwtdfvQfI>
X-ME-Received: <xmr:OUrtY-mQpO3PNINqAaUwsYZNWsJsegY6zPgpI3xPN8offk6xX4fB4R9T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:OUrtY1x18vKwMhuUTvxuqc-VC9CukwTjJsgk7t_KKQUOj9msydjv0Q>
    <xmx:OUrtY4RkwHtAFp9GdQnlYL_2PmLvGCa9oGtgcHDxbzkQENXkFoANgQ>
    <xmx:OUrtY4YA0C1cX_anfnjMdZ6ufjAsFW-pk-RdvOlgjmiCdkOr7whFSw>
    <xmx:OkrtYzJQyB0NmhItoRnBsZTlpqWkM5bIpShJpF06B2KpZSNz5_7szQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 16:10:17 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v5] btrfs: test block group size class loading logic
Date:   Wed, 15 Feb 2023 13:10:16 -0800
Message-Id: <fa66499531a46105f295af0f29d9fc253f361d78.1676495310.git.boris@bur.io>
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
index 00000000..2176c8e4
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
+_fixed_by_kernel_commit xxxxxxxx "btrfs: add size class stats to sysfs".
+
+sysfs_size_classes() {
+	local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
+	cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"
+}
+
+_supported_fs btrfs
+_require_scratch
+_require_btrfs_fs_sysfs
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

