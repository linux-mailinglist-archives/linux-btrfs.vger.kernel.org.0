Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA96E31009D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 00:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhBDXZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 18:25:40 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39245 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229581AbhBDXZh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 18:25:37 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 036C35C00D1;
        Thu,  4 Feb 2021 18:24:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Feb 2021 18:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=Vr4whrfd1Vz7SJBEC7QRkl+9R4
        GXggcPH20g+uHmu5E=; b=q5P7D/Hcwrw8vciLssqN2BZ9gxjczBo61C/zF6X9Ge
        PwXpW4tYef74Fgd9VgK6DCn7/gKrHArDZzeql2c6kBJ2KilMONHPZkFhaVDGtWea
        FcvYj/XF+XO/D9C50CrtrEzPyihed/juWEno5ZKIdsK13FYUHShjMifgvy8GcSC2
        dtX1BHnVYemujA8xgE9sDyksx1vTRY7tF8po5xdRFadVsukIKq5LGq7yyn74bxyB
        nuiEPaKMvBzDMY1C3r5xbdkzbkQSWYGZp2k+IajzMJ0hwyxbk7PcaNiKIXPai2Sd
        eFlGi+6+706x2+g0fb/2XHTFba+UaVAOEEQx77Zlzjvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Vr4whrfd1Vz7SJBEC
        7QRkl+9R4GXggcPH20g+uHmu5E=; b=rq4fxouv5R4RcCE0PCSLy33+VGjtCRfDX
        BQGAzsUfsCVP+n7ugs4eUTfNS+LWNjnaFYmkzv0YUn1w7fK+oa3xy5eqqWHjHMs6
        FdlLh6EN7FjE0pdoqqq4H1MqPJqB0W+pDKWJvRbTEyfGRshJW41Tx7yxRBqAb6Rz
        NbyDpe8qivGLLT3yhSUDdBeu6wRsJKGMxbpLVK0OaHeeZCJoQtqmRZij+zoBU6yn
        /HxPF5PNef2+UoHII+bh+z2nlFuxQo7zq5oO8eQzxnht55LY6ZzUXRFlaccC7uTc
        kIN+SDFukmp0ZdefCMbq1GbkW823/akbcCoViwCF3CNdtlN738lkw==
X-ME-Sender: <xms:LoIcYAREF1erBiPzLNX1zFitx7uqfDlLkMldXzoBHOGgPP5oimUmog>
    <xme:LoIcYNypqW_p_1G1WlIB-HXqxdgGoT8INeSp9ZkQnhDkhiW7BN38f0fLKnNyuqNjA
    6lKWZB7HFCWdJXJdxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrih
    ho
X-ME-Proxy: <xmx:LoIcYN1SCVAm20LV0fNYgQowU6W3VJ28uwBxp2-Uj5OFpUU7lyigcQ>
    <xmx:LoIcYEBCCsMoVgv2cSV4vjbBgdkx1tQ36PE4_bCvI5r6jMrsyhbscg>
    <xmx:LoIcYJh5JxIW_LQTxMMhs4wzBUYmNZQH3vIvffQkjRvFJmH6Bv5XNg>
    <xmx:LoIcYJIO6YCVkxdf1hrvj6nykISF0TWzWY6s3GYrtRFjsP0ABsmlWw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 479D2108005B;
        Thu,  4 Feb 2021 18:24:30 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] btrfs: add a test for btrfs fsverity
Date:   Thu,  4 Feb 2021 15:24:26 -0800
Message-Id: <c16cbe8ad5795f059af45bfe7cf673dab58028a2.1612468162.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are some btrfs specific fsverity scenarios that don't map
neatly onto the tests in generic/574, like holes, inline extents,
and preallocated extents. Cover those in a btrfs specific test.

That test relies on assumptions about how the Merkle tree is stored
by ext4/f2fs which don't apply to btrfs, so we also test Merkle tree
corruption here. This could be merged by some generic abstraction.

Finally, that test relies extensively on fiemap, which is currently
broken on btrfs for offsets and sizes that don't align to PAGE_SIZE,
so put a simple regular file case in this test for now, while we fix
fiemap or generalize extent lookup.

This test relies on the btrfs implementation of fsverity in:
btrfs: add compat_flags to btrfs_inode_item
btrfs: initial fsverity support
btrfs: check verity for reads of inline extents and holes
btrfs: fallback to buffered io for verity files
btrfs: add sysfs feature for fsverity

and it relies on btrfs-corrupt-block for corruption, with the patches:
btrfs-progs: corrupt generic item data with btrfs-corrupt-block
btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/config       |   1 +
 common/verity       |   7 ++
 tests/btrfs/290     | 188 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/290.out |  17 ++++
 tests/btrfs/group   |   1 +
 5 files changed, 214 insertions(+)
 create mode 100755 tests/btrfs/290
 create mode 100644 tests/btrfs/290.out

diff --git a/common/config b/common/config
index d83dfb28..80d5ab66 100644
--- a/common/config
+++ b/common/config
@@ -254,6 +254,7 @@ export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
 export BTRFS_TUNE_PROG=$(type -P btrfstune)
+export BTRFS_CORRUPT_BLOCK_PROG=$(type -P btrfs-corrupt-block)
 export XFS_FSR_PROG=$(type -P xfs_fsr)
 export MKFS_NFS_PROG="false"
 export MKFS_CIFS_PROG="false"
diff --git a/common/verity b/common/verity
index a8d3de06..c0b0c55d 100644
--- a/common/verity
+++ b/common/verity
@@ -8,6 +8,10 @@ _require_scratch_verity()
 	_require_scratch
 	_require_command "$FSVERITY_PROG" fsverity
 
+	if [ $FSTYP == "btrfs" ]; then
+		_require_command "$BTRFS_CORRUPT_BLOCK_PROG" btrfs_corrupt_block
+	fi
+
 	if ! _scratch_mkfs_verity &>>$seqres.full; then
 		# ext4: need e2fsprogs v1.44.5 or later (but actually v1.45.2+
 		#       is needed for some tests to pass, due to an e2fsck bug)
@@ -91,6 +95,9 @@ _scratch_mkfs_verity()
 	ext4|f2fs)
 		_scratch_mkfs -O verity
 		;;
+	btrfs)
+		_scratch_mkfs
+		;;
 	*)
 		_notrun "No verity support for $FSTYP"
 		;;
diff --git a/tests/btrfs/290 b/tests/btrfs/290
new file mode 100755
index 00000000..2e22e95a
--- /dev/null
+++ b/tests/btrfs/290
@@ -0,0 +1,188 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 290
+#
+# Test btrfs support for fsverity
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/verity
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+_supported_fs btrfs
+_require_scratch
+_require_scratch_verity
+
+cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+_ino() {
+	file=$1
+	ls -i $file | awk '{print $1}'
+}
+
+_validate() {
+	f=$1
+	sz=$2
+	# buffered io
+	cat $f > /dev/null
+	# direct io
+	dd if=$f iflag=direct of=/dev/null status=none
+}
+
+# corrupt the data portion of an inline extent
+corrupt_inline() {
+	f=$SCRATCH_MNT/inl
+	head -c 42 /dev/zero | tr '\0' X > $f
+	ino=$(_ino $f)
+	_fsv_enable $f
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+	_scratch_unmount
+	# inline data starts at disk_bytenr
+	# overwrite the first u64 with random bogus junk
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DEV > /dev/null
+	_scratch_mount
+	_validate $f
+}
+
+# preallocate a file, then corrupt it by changing it to a regular file
+corrupt_prealloc_to_reg() {
+	f=$SCRATCH_MNT/prealloc
+	fallocate -l 4k $f
+	ino=$(_ino $f)
+	_fsv_enable $f
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+	_scratch_unmount
+	# set extent type from prealloc (2) to reg (1)
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 1 $SCRATCH_DEV 2>/dev/null >/dev/null
+	_scratch_mount
+	_validate $f
+}
+
+# corrupt a regular file by changing the type to preallocated
+corrupt_reg_to_prealloc() {
+	f=$SCRATCH_MNT/reg
+	head -c 12k /dev/zero | tr '\0' X > $f
+	ino=$(_ino $f)
+	_fsv_enable $f
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+	_scratch_unmount
+	# set type from reg (1) to prealloc (2)
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 2 $SCRATCH_DEV 2>/dev/null >/dev/null
+	_scratch_mount
+	_validate $f
+}
+
+# corrupt a file by punching a hole
+corrupt_punch_hole() {
+	f=$SCRATCH_MNT/punch
+	head -c 12k /dev/zero | tr '\0' X > $f
+	ino=$(_ino $f)
+	# make a new extent in the middle
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+	head -c 4k /dev/zero | tr '\0' Y | dd of=$f bs=4k count=1 seek=1 conv=notrunc 2>/dev/null
+	_fsv_enable $f
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+	_scratch_unmount
+	# change disk_bytenr to 0, representing a hole
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 0 $SCRATCH_DEV > /dev/null
+	_scratch_mount
+	_validate $f
+}
+
+# plug hole
+corrupt_plug_hole() {
+	f=$SCRATCH_MNT/plug
+	head -c 12k /dev/zero | tr '\0' X > $f
+	ino=$(_ino $f)
+	fallocate -p -o 4k -l 4k $f
+	_fsv_enable $f
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+	_scratch_unmount
+	# change disk_bytenr to some value, plugging the hole
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 13639680 $SCRATCH_DEV > /dev/null
+	_scratch_mount
+	_validate $f
+}
+
+# corrupt the fsverity descriptor item indiscriminately (causes EINVAL)
+corrupt_verity_descriptor() {
+	f=$SCRATCH_MNT/desc
+	head -c 12k /dev/zero | tr '\0' X > $f
+	ino=$(_ino $f)
+	_fsv_enable $f
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+	_scratch_unmount
+	# key for the descriptor item is <inode, BTRFS_VERITY_DESC_ITEM_KEY, 0>,
+	# 88 is X. So we write 5 Xs to the start of the descriptor
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,0 -v 88 -o 0 -b 5 $SCRATCH_DEV > /dev/null
+	_scratch_mount
+	_validate $f
+}
+
+# specifically target the root hash in the descriptor (causes EIO)
+corrupt_root_hash() {
+	f=$SCRATCH_MNT/roothash
+	head -c 12k /dev/zero | tr '\0' X > $f
+	ino=$(_ino $f)
+	_fsv_enable $f
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+	_scratch_unmount
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,0 -v 88 -o 16 -b 1 $SCRATCH_DEV >> $seqres.full
+	#$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,0 -v 88 -o 120 -b 5 $SCRATCH_DEV > /dev/null
+	_scratch_mount
+	_validate $f
+}
+
+# corrupt the Merkle tree data itself
+corrupt_merkle_tree() {
+	f=$SCRATCH_MNT/merkle
+	head -c 12k /dev/zero | tr '\0' X > $f
+	ino=$(_ino $f)
+	_fsv_enable $f
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+	_scratch_unmount
+	# key for the descriptor item is <inode, BTRFS_VERITY_MERKLE_ITEM_KEY, 0>,
+	# 88 is X. So we write 5 Xs to somewhere in the middle of the first
+	# merkle item
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v 88 -o 100 -b 5 $SCRATCH_DEV > /dev/null
+	_scratch_mount
+	_validate $f
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
+# we intentionally corrupted, re-mkfs to avoid tripping the corrupted fs error
+_scratch_unmount
+_scratch_mkfs >/dev/null
+
+status=0
+exit
diff --git a/tests/btrfs/290.out b/tests/btrfs/290.out
new file mode 100644
index 00000000..4da61246
--- /dev/null
+++ b/tests/btrfs/290.out
@@ -0,0 +1,17 @@
+QA output created by 290
+cat: /mnt/scratch/inl: Input/output error
+dd: error reading '/mnt/scratch/inl': Input/output error
+cat: /mnt/scratch/prealloc: Input/output error
+dd: error reading '/mnt/scratch/prealloc': Input/output error
+cat: /mnt/scratch/reg: Input/output error
+dd: error reading '/mnt/scratch/reg': Input/output error
+cat: /mnt/scratch/punch: Input/output error
+dd: error reading '/mnt/scratch/punch': Input/output error
+cat: /mnt/scratch/plug: Input/output error
+dd: error reading '/mnt/scratch/plug': Input/output error
+cat: /mnt/scratch/desc: Invalid argument
+dd: failed to open '/mnt/scratch/desc': Invalid argument
+cat: /mnt/scratch/roothash: Input/output error
+dd: error reading '/mnt/scratch/roothash': Input/output error
+cat: /mnt/scratch/merkle: Input/output error
+dd: error reading '/mnt/scratch/merkle': Input/output error
diff --git a/tests/btrfs/group b/tests/btrfs/group
index a7c65983..58943c85 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -233,3 +233,4 @@
 228 auto quick volume
 229 auto quick send clone
 230 auto quick qgroup limit
+290 auto quick verity
-- 
2.30.0

