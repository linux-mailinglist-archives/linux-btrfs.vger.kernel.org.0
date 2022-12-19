Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4AA6513D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 21:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiLSUZm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 15:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLSUZl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 15:25:41 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569BE6;
        Mon, 19 Dec 2022 12:25:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8726D5C0120;
        Mon, 19 Dec 2022 15:25:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Dec 2022 15:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1671481536; x=1671567936; bh=hQxjnJVGjme9mjVoKBnE4JEVP
        caqk9h4EzX5j4TU49U=; b=dwBpOJMq2eycuMvdX5vSU9PkDtZ9J2f6+pwCHS+tu
        GC3HULCnbQai/HPmykk8ePb+PZp3KddQJf/433Ymzq3GUjyFR4JjDq7mWMlZG8V9
        VAE6LpEXD9oYPYyepmBzV4nmHiTGq74e5AL27Hw0sZwSSJgAhwFLn2BAt9IZLre4
        FSMoep/0SFGpgyAHyoCAMzj46YpdLtVn0TSdWST7ldDip/0RDyH6nCVDxjKmjrEo
        16izGmD1uYWfnfNK1FV/0In6NoSd82PzK46LkYwRNI7Mn0r3vj42+Ek/MFjaFuEz
        BLbx0/gNt1glg6qF4G68PBQ8cHbsxErFGQacWe+rQSULw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1671481536; x=1671567936; bh=hQxjnJVGjme9mjVoKBnE4JEVPcaqk9h4EzX
        5j4TU49U=; b=rH0FeywI8EgKcF0ody3/0fWnydiGW5OxnLE8LRC8TCEcwQmt0HC
        h8VNMdc9Ih1Z2A0dnSAmZBQu5+4ToGXPKY60/6YXOxwLLvZkExGFF8h7Xw+A7WOk
        jXVWHsLNuBRjNxtzGGDSVFdqUbKLmB0XIQL8UegsbtUSWfhXUFwMjYd258hH7aWP
        BZEdrzW1j84ayeEhQfR1chH4R+MxWgb0G0guRVB3Ws7xQPUAp2yv84JqGHslyOzo
        jeXoJvz3cfy+sjBG1ck68ZXuvanFd8iS7bkpjho2TNxMEKEg+sstZSNfFlKioBZC
        WyLMkH1SphBrIYlB8MtDRhLdgsFk+DFDttw==
X-ME-Sender: <xms:wMigY-kx0NYPKvGGWaA3BpMx8vtNWu48S1ftuqZtugBfGx2F496fZA>
    <xme:wMigY12yPtwHeOI3shrhfN08olHOTmakRW66g73d9anR1d16X0boZm6x8JN8ge_10
    tpZOTk1jKrHeMnYszQ>
X-ME-Received: <xmr:wMigY8rXDSYhhcfHnPV4Fozxz_6ccWswDnasxRnGkBTlWr90ck-260h3IoM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:wMigYynJ3wJUwWG7BWtWDUwlR_FykbMqdQP_JP8BmUTrGVL62CkFOg>
    <xmx:wMigY81AE4Rce_UAl4VbA3OfVS2m0aCCkjaCM6m0cK2VymRYGtWqPg>
    <xmx:wMigY5thTYwWhXFSk3UKczez_jMsmdyj22uxOzgA4NUVOO3-FPjCXA>
    <xmx:wMigY59wDQIRXFo1MeY2k3u5bBXsAs6BN9cK0rFbCQkr91gNkAMKGQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Dec 2022 15:25:36 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2] btrfs: new test for logical inode resolution panic
Date:   Mon, 19 Dec 2022 12:25:29 -0800
Message-Id: <4d2045a13be9bb2931c4755aa4b558c60f698f78.1671481303.git.boris@bur.io>
X-Mailer: git-send-email 2.30.2
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
Changes for V2:
- move to btrfs/299
- change to 64k extent buffers
- improve comments
- cut down on unneeded fsyncs
- various cleanups to requires/includes

 tests/btrfs/299     | 103 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/299.out |   2 +
 2 files changed, 105 insertions(+)
 create mode 100755 tests/btrfs/299
 create mode 100644 tests/btrfs/299.out

diff --git a/tests/btrfs/299 b/tests/btrfs/299
new file mode 100755
index 00000000..42a08317
--- /dev/null
+++ b/tests/btrfs/299
@@ -0,0 +1,103 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 299
+#
+# Given a file with extents:
+# [0 : 4096) (inline)
+# [4096 : N] (prealloc)
+# if a user uses the ioctl BTRFS_IOC_LOGICAL_INO[_V2] asking for the file of the
+# non-inline extent, it results in reading the offset field of the inline
+# extent, which is meaningless (it is full of user data..). If we are
+# particularly lucky, it can be past the end of the extent buffer, resulting in
+# a crash. This test creates that circumstance and asserts that logical inode
+# resolution is still successful.
+#
+. ./common/preamble
+_begin_fstest auto quick preallocrw
+
+# real QA test starts here
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+_require_xfs_io_command "falloc" "-k"
+_require_btrfs_command inspect-internal dump-tree
+_require_btrfs_command inspect-internal logical-resolve
+_fixed_by_kernel_commit xxxxxxxx "btrfs: fix logical_ino ioctl panic"
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
+	get_extent_data $ino | grep "disk byte" | $AWK_PROG '{print $5}'
+}
+
+# This test needs to create conditions s.t. the special inode's inline extent
+# is the first item in a leaf. Therefore, fix a leaf size and add
+# items that are otherwise not necessary to reproduce the inline-prealloc
+# condition to get to such a state.
+#
+# Roughly, the idea for getting the right item fill is to:
+# 1. create extra inline items to cause leaf splitting.
+# 2. put the target item in the middle so it is likely to catch the split
+# 3. add an extra variable inline item to tweak any final adjustments
+#
+# It took a bit of trial and error to hit working counts of inline items, since
+# it also had to account for dir and index items all going to the front.
+
+# use a 64k nodesize so that an fs with 64k pages and no subpage sector size
+# support will correctly reproduce the problem.
+_scratch_mkfs "--nodesize 64k" >> $seqres.full || _fail "mkfs failed"
+_scratch_mount
+
+f=$SCRATCH_MNT/f
+# write extra files before the evil file to use up the leaf and
+# help trick leaf balancing
+for i in {1..41}; do
+	$XFS_IO_PROG -fc "pwrite -q 0 1024" $f.inl.$i
+done
+
+# write a variable inline file to help pad the preceeding leaf
+$XFS_IO_PROG -fc "pwrite -q 0 1" $f.inl-var.$i
+
+# falloc the evil file whose inline extent will start a leaf
+$XFS_IO_PROG -fc "falloc -k 0 1m" $f.evil
+$XFS_IO_PROG -fc fsync $f.evil
+
+# write extra files after the evil file to use up the leaf and
+# help trick leaf balancing
+for i in {1..42}; do
+	$XFS_IO_PROG -fc "pwrite -q 0 1024" $f.inl.2.$i
+done
+
+# grab the prealloc offset from dump tree while it's still the only
+# extent data item for the inode
+ino=$(stat -c '%i' $f.evil)
+logical=$(get_prealloc_offset $ino)
+
+# do the "small write; fsync; small write" pattern which reproduces the desired
+# item pattern of an inline extent followed by a preallocated extent. The 23
+# size is somewhat arbitrary, but ensures that the offset field is past the eb
+# when we are item 0 (borrowed from the actual crash this reproduces).
+$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
+$XFS_IO_PROG -fc fsync $f.evil
+$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
+
+# ensure we have all the extent_data items for when we do logical to inode
+# resolution
+sync
+
+# trigger the backref walk which accesses the bad inline extent
+btrfs inspect-internal logical-resolve $logical $SCRATCH_MNT
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/299.out b/tests/btrfs/299.out
new file mode 100644
index 00000000..0fcc0304
--- /dev/null
+++ b/tests/btrfs/299.out
@@ -0,0 +1,2 @@
+QA output created by 299
+Silence is golden
-- 
2.38.1

