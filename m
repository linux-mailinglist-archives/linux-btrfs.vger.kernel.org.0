Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B167D37C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 18:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjAZRsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 12:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjAZRsW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 12:48:22 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C7C3432F;
        Thu, 26 Jan 2023 09:48:20 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 02ABC32003AC;
        Thu, 26 Jan 2023 12:48:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 26 Jan 2023 12:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1674755299; x=1674841699; bh=cXYZ31DxtVUOGiMTUDq0Rm8EC
        HRPH9azLGvWl5jhHaU=; b=nvuw9zP0wr5CJtwsC1oOpHaiU/E/o8YASyms9AUX7
        jfkSRC+d5cARUaCuep3kPWxG2QvMzMPw569X7CvSr3euI8/TrW8sd9P1ojRxl8rr
        LN8OGQkTXQNbNB9bcyurKanyqDtbdZyXRIBmkxrH+PcsPLtPhHHYGnmisOwbP0kw
        +X5cpm4PyY2QTppMkRY4Jba3W632fyrtrXdiQDA09oNK1XI///GdvxlXu4OHd/oG
        fQKilSgEeaF7dmdn8J+NAqRGHlsPYLlm109kyqLSCW6W/915n7Kd2mHMlPNaAKXf
        MpGZjR2PMW7zn6GbD/OJ5s5dVhvV/bfOEloUBm5zzPgxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1674755299; x=1674841699; bh=cXYZ31DxtVUOGiMTUDq0Rm8ECHRPH9azLGv
        Wl5jhHaU=; b=Vm82XOP0FYD8X9i4o4wBT4xIX5HtbCq9yCEZhtmYCbqqiq1D0L4
        EWA87V9s1UYwiljYvhPvKNvupmYFyYrskXR9hRu1K36iT2omFoMLkGivO/lbygyb
        qZM+Ex51n3XBv6spqHYNOZj7xTI5aYvuk1Gu/gJskm7KXYBN2trnsSp/pVHKFTKf
        Zfv6swt81IttR+dg4PJ8e4TIcqQH8OqBo+sjgJgppM1/Uq7QPw5eQTalWmaRR2A4
        OICuBup1x51CSUZrVKkDCOEYzysj6I9ENPTC6lONSNqLLPRBk5UfGyKWyAltXOUH
        EfPr13VMNaQrpDHIGcAO/GZYKEGpbSwZNzA==
X-ME-Sender: <xms:47zSY48YyfzDwPa197gU_G3YSgjp2BBe5d0VKWnoqQZCP9CGgsN4lQ>
    <xme:47zSYwsLejuJ1nEdgXe34eOM0MAfZGirJru02KWLC4pSCNIP6TZE3bGK-ylPWXH_K
    wldLDVm6zAQTPgc5zI>
X-ME-Received: <xmr:47zSY-DtZqjMNZ6_PWDZ9Mg4YixTCGQ3t8BuS4hPe-y_35ThLWSYWzIb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:47zSY4f07fwwXdbBXXQ-PHygJsOOqKQeSTGRgXxtF67DivGIGv6BYQ>
    <xmx:47zSY9MrujWu0cQ14mv0-I7Nci6n8shUiVqrbO0SIhe2GLUJUkPzPw>
    <xmx:47zSYynXDgV5nUrE5hgZ0UJmY2PgPDmvLV3H0zz69rVEp73siPKqHw>
    <xmx:47zSY71pZrE8t3wp87FISS0hj4H-o51NxUdzVwAniR5a8-k1_2yoeA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 12:48:19 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v3] btrfs: test block group size class loading logic
Date:   Thu, 26 Jan 2023 09:48:17 -0800
Message-Id: <16b9a9042169c25a10dd1867cedd14849d00dca5.1674755053.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 00000000..d250a389
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
+fixed_by_kernel_commit xxxxxxxx "btrfs: add size class stats to sysfs".
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

