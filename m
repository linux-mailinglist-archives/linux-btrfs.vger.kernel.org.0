Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6164DB958
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 21:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357875AbiCPU0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 16:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357868AbiCPU0o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 16:26:44 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473FC49F03;
        Wed, 16 Mar 2022 13:25:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 814983200F72;
        Wed, 16 Mar 2022 16:25:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 16 Mar 2022 16:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=ay1CxmSNjUjWplnQulWZWzTYkz6m8+
        1ofBbUt94ZwTQ=; b=iYcyRyYKcT1osATwUB9rnPAO9Pz/2v288ZtBrTWoeFBbvI
        lJJR21LuuC1LCB4Lxn4J3d7UOMWTEDIMNjKmTjoRD3oXE6YQban7Wz2QSFTItokK
        6Mgp7A3jYgdhgdhRPF4JM45ZfUZjC80QmuEdEvaQIDf2aORZEp9ajP5adgj859W5
        y/BvrW/UaKWldZqxOSbShw0MghQovxfT6rMHIKDQzNbK9QOrn34koP7akq1mi/vS
        2ahSceMuteKw/W/EmaO8EsY2n2dUlQZ62Fd+I70xJ84N7mIuwEyu5n6Gvorp8xlV
        ciEwsQ+7u5YFhNykaLt9FVT25UmJagNVEzq5Ngiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ay1Cxm
        SNjUjWplnQulWZWzTYkz6m8+1ofBbUt94ZwTQ=; b=jAVIGrCMpVGRJo+M3j2b60
        4d8+GGMdUfW1u8nJVNIkitlYjEUJiUsZiVFqU+qywHPkraz9PDFb7dIJ2rDDA1dJ
        Vo2UGa13d78BtlX88MM8xKIwEd/vzAH5xw3O/w0ykkDQSRLYSVU6h/tWhGRJKa83
        J/wQmTcIj83bIhBg4w4BdiogYTEwcmNb6R5jcBZ+2pzM9B3uPmsefctW4ijGzAhA
        kAQbGH7LKlkzj5ptPO9J0EZeAqyFhy1a08I651fa2eONrtgags5L9bFGTLQkSsD/
        EdCkFzjlCwDTkmqEMSxR9iyKcY32SZ+MsCGe45zJO/R8SK26e+owT2apevma+3Yw
        ==
X-ME-Sender: <xms:tUcyYlg-HgM4897P01dxx5MM_IQJIZ0ch9TTPr9kzN13u0iiaHc9AQ>
    <xme:tUcyYqC3-ZAEVSIarCdGx-BXrL0dPUiQ3dDJ06nEksNUoDDchoP_FYz92E3FQ02XZ
    PWaAdIcZHgqs3llmEo>
X-ME-Received: <xmr:tUcyYlFHLRRebkn7w81EJeAAsjQzBMAg6nbUPYT25W_mQn-kcz6YThXBYtQP5HoZK0K_xsmxj27I8BNQyr3JzrruJYuqcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefvddgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:tUcyYqSP6YZhye8bhO7Tl2og6ayiGeaTNPbUoUb0N3OoWeAdoMO78w>
    <xmx:tUcyYixF8ye8QYtC9GqcNRuNgownvyZHu9DgYFuCAijeZZiI3T8KXw>
    <xmx:tUcyYg6YMACdbMffHAhEtYfBFBYYjRj5DLL5rCTDXX5c5KZtNXeQHw>
    <xmx:tkcyYt9LeU5IJLZ7SilGoDGND8mjXZ5XJqG6AYzPjK4Zq2j2qBCXKw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Mar 2022 16:25:25 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 3/5] btrfs: test btrfs specific fsverity corruption
Date:   Wed, 16 Mar 2022 13:25:13 -0700
Message-Id: <fd69c62b9971d446f53ba3d168625fb3a3468882.1647461985.git.boris@bur.io>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647461985.git.boris@bur.io>
References: <cover.1647461985.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are some btrfs specific fsverity scenarios that don't map
neatly onto the tests in generic/574 like holes, inline extents,
and preallocated extents. Cover those in a btrfs specific test.

This test relies on the btrfs implementation of fsverity in the patch:
btrfs: initial fsverity support

and on btrfs-corrupt-block for corruption in the patches titled:
btrfs-progs: corrupt generic item data with btrfs-corrupt-block
btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/290     | 168 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/290.out |  25 +++++++
 2 files changed, 193 insertions(+)
 create mode 100755 tests/btrfs/290
 create mode 100644 tests/btrfs/290.out

diff --git a/tests/btrfs/290 b/tests/btrfs/290
new file mode 100755
index 00000000..f9acd55a
--- /dev/null
+++ b/tests/btrfs/290
@@ -0,0 +1,168 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Facebook, Inc. All Rights Reserved.
+#
+# FS QA Test 290
+#
+# Test btrfs support for fsverity.
+# This test extends the generic fsverity testing by corrupting inline extents,
+# preallocated extents, holes, and the Merkle descriptor in a btrfs-aware way.
+#
+. ./common/preamble
+_begin_fstest auto quick verity
+
+# Import common functions.
+. ./common/filter
+. ./common/verity
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch_verity
+_require_scratch_nocheck
+_require_odirect
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "pread"
+_require_xfs_io_command "pwrite"
+_require_btrfs_corrupt_block
+
+get_ino() {
+	local file=$1
+	stat -c "%i" $file
+}
+
+validate() {
+	local f=$1
+	local sz=$(_get_filesize $f)
+	# buffered io
+	echo $(basename $f)
+	$XFS_IO_PROG -rc "pread -q 0 $sz" $f 2>&1 | _filter_scratch
+	# direct io
+	$XFS_IO_PROG -rdc "pread -q 0 $sz" $f 2>&1 | _filter_scratch
+}
+
+# corrupt the data portion of an inline extent
+corrupt_inline() {
+	local f=$SCRATCH_MNT/inl
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 42" $f
+	local ino=$(get_ino $f)
+	_fsv_enable $f
+	_scratch_unmount
+	# inline data starts at disk_bytenr
+	# overwrite the first u64 with random bogus junk
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DEV > /dev/null 2>&1
+	_scratch_mount
+	validate $f
+}
+
+# preallocate a file, then corrupt it by changing it to a regular file
+corrupt_prealloc_to_reg() {
+	local f=$SCRATCH_MNT/prealloc
+	$XFS_IO_PROG -fc "falloc 0 12k" $f
+	local ino=$(get_ino $f)
+	_fsv_enable $f
+	_scratch_unmount
+	# set extent type from prealloc (2) to reg (1)
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 1 $SCRATCH_DEV >/dev/null 2>&1
+	_scratch_mount
+	validate $f
+}
+
+# corrupt a regular file by changing the type to preallocated
+corrupt_reg_to_prealloc() {
+	local f=$SCRATCH_MNT/reg
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	local ino=$(get_ino $f)
+	_fsv_enable $f
+	_scratch_unmount
+	# set type from reg (1) to prealloc (2)
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 2 $SCRATCH_DEV >/dev/null 2>&1
+	_scratch_mount
+	validate $f
+}
+
+# corrupt a file by punching a hole
+corrupt_punch_hole() {
+	local f=$SCRATCH_MNT/punch
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	local ino=$(get_ino $f)
+	# make a new extent in the middle, sync so the writes don't coalesce
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+	$XFS_IO_PROG -fc "pwrite -q -S 0x59 4096 4096" $f
+	_fsv_enable $f
+	_scratch_unmount
+	# change disk_bytenr to 0, representing a hole
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 0 $SCRATCH_DEV > /dev/null 2>&1
+	_scratch_mount
+	validate $f
+}
+
+# plug hole
+corrupt_plug_hole() {
+	local f=$SCRATCH_MNT/plug
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	local ino=$(get_ino $f)
+	$XFS_IO_PROG -fc "falloc 4k 4k" $f
+	_fsv_enable $f
+	_scratch_unmount
+	# change disk_bytenr to some value, plugging the hole
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 13639680 $SCRATCH_DEV > /dev/null 2>&1
+	_scratch_mount
+	validate $f
+}
+
+# corrupt the fsverity descriptor item indiscriminately (causes EINVAL)
+corrupt_verity_descriptor() {
+	local f=$SCRATCH_MNT/desc
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	local ino=$(get_ino $f)
+	_fsv_enable $f
+	_scratch_unmount
+	# key for the descriptor item is <inode, BTRFS_VERITY_DESC_ITEM_KEY, 1>,
+	# 88 is X. So we write 5 Xs to the start of the descriptor
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 0 -b 5 $SCRATCH_DEV > /dev/null 2>&1
+	_scratch_mount
+	validate $f
+}
+
+# specifically target the root hash in the descriptor (causes EIO)
+corrupt_root_hash() {
+	local f=$SCRATCH_MNT/roothash
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	local ino=$(get_ino $f)
+	_fsv_enable $f
+	_scratch_unmount
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 16 -b 1 $SCRATCH_DEV > /dev/null 2>&1
+	_scratch_mount
+	validate $f
+}
+
+# corrupt the Merkle tree data itself
+corrupt_merkle_tree() {
+	local f=$SCRATCH_MNT/merkle
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	local ino=$(get_ino $f)
+	_fsv_enable $f
+	_scratch_unmount
+	# key for the descriptor item is <inode, BTRFS_VERITY_MERKLE_ITEM_KEY, 0>,
+	# 88 is X. So we write 5 Xs to somewhere in the middle of the first
+	# merkle item
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v 88 -o 100 -b 5 $SCRATCH_DEV > /dev/null 2>&1
+	_scratch_mount
+	validate $f
+}
+
+# real QA test starts here
+_scratch_mkfs >/dev/null
+_scratch_mount
+
+corrupt_inline
+corrupt_prealloc_to_reg
+corrupt_reg_to_prealloc
+corrupt_punch_hole
+corrupt_plug_hole
+corrupt_verity_descriptor
+corrupt_root_hash
+corrupt_merkle_tree
+
+status=0
+exit
diff --git a/tests/btrfs/290.out b/tests/btrfs/290.out
new file mode 100644
index 00000000..056b114b
--- /dev/null
+++ b/tests/btrfs/290.out
@@ -0,0 +1,25 @@
+QA output created by 290
+inl
+pread: Input/output error
+pread: Input/output error
+prealloc
+pread: Input/output error
+pread: Input/output error
+reg
+pread: Input/output error
+pread: Input/output error
+punch
+pread: Input/output error
+pread: Input/output error
+plug
+pread: Input/output error
+pread: Input/output error
+desc
+SCRATCH_MNT/desc: Invalid argument
+SCRATCH_MNT/desc: Invalid argument
+roothash
+pread: Input/output error
+pread: Input/output error
+merkle
+pread: Input/output error
+pread: Input/output error
-- 
2.31.0

