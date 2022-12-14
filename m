Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB764D30C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Dec 2022 00:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLNXMF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 18:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNXME (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 18:12:04 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B711146;
        Wed, 14 Dec 2022 15:12:03 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 99FA85C00AE;
        Wed, 14 Dec 2022 18:12:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 14 Dec 2022 18:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1671059522; x=1671145922; bh=T5TU2SL0cANYwCK6LeRCq/78V
        vHjLRsCGVLKsRGPLYw=; b=PPPuLFCI2Mu05LYd3qgcLc2D51c8Yu4A9jglRX9xv
        0zWTFe7YC0DV8dejtHnim0jFhAo8tObASY0KGEwyiM+RSqYRIqgQgfVLVccskyK9
        6H2LO91elO7NgjrS/HkEms/mVQjta1W1qMnWL6qpmoBSx9LB1BTPE/iisz4ZzQIj
        h7jO8948+GjbPteAaIMGbopRu7FRoFNl88hFQcZMAgMa/iz6t8UfLfgKnJ4MMTxC
        jB2k3ccnpYIZIxRFNsKO3EE/GDFy+fwkqdip+h79/j+hURlvxSeU2QLu5cubOzYI
        6/VBIlRv1H06B0Wvcov3FIGcOQJtgJIP9MPOq59f8RnLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1671059522; x=1671145922; bh=T5TU2SL0cANYwCK6LeRCq/78VvHjLRsCGVL
        KsRGPLYw=; b=ol0W8y9kY4MMfxz3tOP6dJrpVQADc4w1V2gYuORy6h8LXUYh/Rr
        uccdNkAupbmKfAAQNJ/kwySmhs2BTlfj9h2ys+/bh9HP+qDy+qYTc1RqOq6r5vmI
        19apPWwnkq6cr///5f9L3RSahorE7hiXfXvxT17exb2EppggeOHqG8/9npjw0xqM
        PEUKEz/fDHRtntICBpuGxekKK2AibUvuh/5WwVxTKSm/3ur5PRVW6pZJ5tntbKG3
        8G39+YFJnJBreN8y5VXdq2/XTpQ2990vVzNwZj43KYKC66tKR9Fhgzwwbkbavo4f
        3wh9xfrvWbiWVR2gGIA9sDlow2Do9dD3nXg==
X-ME-Sender: <xms:QliaY3909qg0IT7M3PeLJB4Qgc5OAzMbrVyndCX4yoJ39AF6lgZAbQ>
    <xme:QliaYzvQoyyeb-r6XeKLZdln1YLu3bs_F-UIyQ8MCyCkVLfOltupW0yVHoL9URtWC
    HS1YuVUDfsaKc-_J58>
X-ME-Received: <xmr:QliaY1ADmUYur89V_AeDYCt_13vzcrt7qQ7J79usZxZkZ6GcGqHQRfWj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeggddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:QliaYze1wzrs2g1tO1zEicNS3EcfXFEGK1GsAlsMZUGMGO5xpa8VVg>
    <xmx:QliaY8NWG9cE-HDB7wgsHVxk5Eu6AUWLJUDrzDLd_IEaHrXI3g0DXg>
    <xmx:QliaY1m_Qb189kHS-48b6PXOEIOV57-zSZSzTWt5bwqVlSjoqbjX1g>
    <xmx:QliaY22QEZZccVOemWykS56v04BkM6UYqhZN_3oqNc5NH2BXOnsXVw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 18:12:02 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] btrfs: new test for logical inode resolution panic
Date:   Wed, 14 Dec 2022 15:12:01 -0800
Message-Id: <98d2055515cd765b0835a7f751a21cbb72c03621.1671059406.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we create a file that has an inline extent followed by a prealloc
extent, then attempt to use the logical to inode ioctl on the prealloc
extent, but in the overwritten range, backref resolution will process
the inline extent. Depending on the leaf eb layout, this can panic.
Add a new test for this condition. In the long run, we can add spew when
we read out-of-bounds fields of inline extent items and simplify this
test to look for dmesg warnings rather than trying to force a fairly
fragile panic (dependent on non-standardized details of leaf layout).

The test causes a kernel panic unless:
btrfs: fix logical_ino ioctl panic
is applied to the kernel.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/279     | 95 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/279.out |  2 +
 2 files changed, 97 insertions(+)
 create mode 100755 tests/btrfs/279
 create mode 100644 tests/btrfs/279.out

diff --git a/tests/btrfs/279 b/tests/btrfs/279
new file mode 100755
index 00000000..ef77f84b
--- /dev/null
+++ b/tests/btrfs/279
@@ -0,0 +1,95 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 279
+#
+# Given a file with extents:
+# [0 : 4096) (inline)
+# [4096 : N] (prealloc)
+# if a user uses the ioctl BTRFS_IOC_LOGICAL_INO[_V2] asking for the file of the
+# non-inline extent, it results in reading the offset field of the inline
+# extent, which is meaningless (it is full of user data..). If we are
+# particularly lucky, it can be past the end of the extent buffer, resulting in
+# a crash.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Import common functions.
+. ./common/filter
+. ./common/dmlogwrites
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "fsync"
+_require_xfs_io_command "pwrite"
+
+dump_tree() {
+	$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV
+}
+
+get_extent_data() {
+	local ino=$1
+	dump_tree $SCRATCH_DEV | grep -A4 "($ino EXTENT_DATA "
+}
+
+get_prealloc_offset() {
+	local ino=$1
+	get_extent_data $ino | grep "disk byte" | awk '{print $5}'
+}
+
+# This test needs to create conditions s.t. the special inode's inline extent
+# is the first item in a leaf. Therefore, fix a leaf size and add 
+# items that are otherwise not necessary to reproduce the inline-prealloc
+# condition to get to such a state.
+#
+# Roughly, the idea for getting the right item fill is to:
+# 1. create an extra file with a variable sized inline extent item
+# 2. create our evil file that will cause the panic
+# 3. create a whole bunch of files to create a bunch of dir/index items
+# 4. size the variable extent item s.t. the evil extent item is item 0 in the
+#    next leaf
+#
+# We do it in this somewhat convoluted way because the dir and index items all
+# come before any inode, inode_ref, or extent_data items. So we can predictably
+# create a bunch of them, then sneak in a funny sized extent to round out the
+# difference.
+
+_scratch_mkfs "--nodesize 16k" >/dev/null
+_scratch_mount
+
+f=$SCRATCH_MNT/f
+
+# the variable extra "leaf padding" file
+$XFS_IO_PROG -fc "pwrite -q 0 700" $f.pad
+
+# the evil file with an inline extent followed by a prealloc extent
+# created by falloc with keep-size, then two non-truncating writes to the front
+touch $f.evil
+$XFS_IO_PROG -fc "falloc -k 0 1m" $f.evil
+$XFS_IO_PROG -fc fsync $f.evil
+ino=$(stat -c '%i' $f.evil)
+logical=$(get_prealloc_offset $ino)
+$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
+$XFS_IO_PROG -fc fsync $f.evil
+$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
+$XFS_IO_PROG -fc fsync $f.evil
+sync
+
+# a bunch of inodes to stuff dir items in front of the extent items
+for i in $(seq 122); do
+	$XFS_IO_PROG -fc "pwrite -q 0 8192" $f.$i
+done
+sync
+
+btrfs inspect-internal logical-resolve $logical $SCRATCH_MNT | _filter_scratch
+_scratch_unmount
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/279.out b/tests/btrfs/279.out
new file mode 100644
index 00000000..c5906093
--- /dev/null
+++ b/tests/btrfs/279.out
@@ -0,0 +1,2 @@
+QA output created by 279
+Silence is golden
-- 
2.38.1

