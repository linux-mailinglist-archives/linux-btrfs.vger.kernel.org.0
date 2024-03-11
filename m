Return-Path: <linux-btrfs+bounces-3194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D9487888F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 20:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF80281FDF
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 19:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F0354BFC;
	Mon, 11 Mar 2024 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GXC+pCs6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4QwMA8I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C3200A6;
	Mon, 11 Mar 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184373; cv=none; b=ZaPnuXa/6IRJXanFAUPGuamV1HKG2wx0PAa9BUq3T9XNgGyI2u/kkApPeUQQZWOCIstafxaixEGTnqGlGE2vVXXU401yFDKc3odaRJUl582VTC8D51EsXHS7Oz14m/dDoPv9myTQr4qb5hm8mAakbtNW8CIdVPc1uZvYNPuwG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184373; c=relaxed/simple;
	bh=Mms9koGfB4pkpDLvyNXXZz2GY/wAqH2Lsr/G6nZHGaM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IW1myedBoCOXhj1xuSAZUhRuzi1kJdWp29L3DYwaDk+V4Ti5sMlTu1c1IXWR3aef8Iuz6qkhgkdAVNHNmPpICi0A5ydVnwR/IC5Y+je6jUF9Z4J5aoYhjFqYejtQ+38GmR2GazJvla3WKX2Zk8TvkJBN1N6tXZXP4TwnBRVAaac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GXC+pCs6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4QwMA8I; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 3099B5C0053;
	Mon, 11 Mar 2024 15:12:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Mar 2024 15:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710184370; x=1710270770; bh=122k9XQbNXOBOpgOr6s25
	Dl5ekyujFUno/UCJ/JCaM0=; b=GXC+pCs6WIJY5iXYhlx2jO801zX0MazwPHBiF
	ypcMqLtlHW9NdFxroe6P8wPPTsx+tk34lHJqsTU/q9mUMb3JzyIXekcpZ28OLjWE
	hFGm/K01K1lEeVwxUejqIO3X6xohM8Mepv3Jy8c6EBHuH1Y1aykGIp9ufxkd45WG
	ewbF92wb3xiB2Uhe8bnrzbn5YHYlNyymm0LR66WTjskD4mTuB6NAoIacXLnK1FZ8
	RGIcOQO1CJ0IXP9EfBkEGHzgZfiZtfmLn3/sV0cx/wzG9nmSTWMvpvatE89CCkPS
	OkEUfTbS9n5M0ypJUT8zholNbGX8SgfQpSlynOTq804JBnftg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710184370; x=1710270770; bh=122k9XQbNXOBOpgOr6s25Dl5ekyu
	jFUno/UCJ/JCaM0=; b=P4QwMA8IJmVBMn74rxjLw5hFUUeXgbwETdmvoZP4fjMi
	iES4dudyipmxVIWBvD39QmeKgso1/b21+4PQ17A8lcksbYIA1DUhiRnyBvM4OXs+
	nlig3lHBEAsFR5bb06hHu0hfxrc/EFHT48/eKjYjTvVFEp6c2Odjtfd7hjnYU3C0
	2c1IcyY6Y0EdMyQV3s0kDNvxGltwNZXjmJzl/hjWntyqBdf4N6DDDLp7UzTkQ5OY
	hhpL6eFC4I65xhhcoTkHO989hF6/KfZGXGKoMgVGCDBA95sjoCc9Pi+RYbTmfJP3
	gFSP4AnWZx0KGdduyuM8S0x5V1EnEkohG1FdWIJnaA==
X-ME-Sender: <xms:slfvZYQ6LWPgDEasio1YCXzBAUYK0vE4rTbM23jViy03tcYM9KNfSA>
    <xme:slfvZVyeeo6hMM6DMsWrfaZYPpFWXIJUQz5H7L9xY5bKcgsHU44damkSqmJjQ-V9s
    _mfSDHdvUwSmx0HFa4>
X-ME-Received: <xmr:slfvZV1trJDAr-xExtjdStYCMivw8xKt58EOTnlQ5I4zrjUzGklOeykHTCR1usn5ASMcsH4be6vET9_pIL1peQZ0Cxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:slfvZcCKS0AwJ-BZDF-EA5pGQUOE3snEzpJJ6HChTiZFKk9rbEEecQ>
    <xmx:slfvZRhYFuS7ONq6QtRWEEeKpx2ecRKsVGnFkK8rf8lc_6vp9U_IRw>
    <xmx:slfvZYqur7dgJ_H-JmnYEReuNa0zQ2rVJY7TD3xI0kd7wR402N4mcQ>
    <xmx:slfvZRYuAZ4XHLTp2FXihaT7Re_LvrKbkWLoThoROmEmlUUphHd3-g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 15:12:49 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v4] btrfs: new test for devt change between mounts
Date: Mon, 11 Mar 2024 12:13:44 -0700
Message-ID: <ab39a4385d586a0b82dafdec73f625cf434fe026.1710184289.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to confuse the btrfs device cache (fs_devices) by
starting with a multi-device filesystem, then removing and re-adding a
device in a way which changes its dev_t while the filesystem is
unmounted. After this procedure, if we remount, then we are in a funny
state where struct btrfs_device's "devt" field does not match the bd_dev
of the "bdev" field. I would say this is bad enough, as we have violated
a pretty clear invariant.

But for style points, we can then remove the extra device from the fs,
making it a single device fs, which enables the "temp_fsid" feature,
which permits multiple separate mounts of different devices with the
same fsid. Since btrfs is confused and *thinks* there are different
devices (based on device->devt), it allows a second redundant mount of
the same device (not a bind mount!). This then allows us to corrupt the
original mount by doing stuff to the one that should be a bind mount.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v4:
- add tempfsid group
- remove fail check on mount command
- btrfs/311 -> btrfs/318
- add fixed_by annotation
v3:
- fstests convention improvements (helpers, output, comments, etc...)
v2:
- fix numerous fundamental issues, v1 wasn't really ready

 common/config       |   1 +
 tests/btrfs/318     | 108 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/318.out |   2 +
 3 files changed, 111 insertions(+)
 create mode 100755 tests/btrfs/318
 create mode 100644 tests/btrfs/318.out

diff --git a/common/config b/common/config
index 2a1434bb1..d8a4508f4 100644
--- a/common/config
+++ b/common/config
@@ -235,6 +235,7 @@ export BLKZONE_PROG="$(type -P blkzone)"
 export GZIP_PROG="$(type -P gzip)"
 export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
 export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
+export PARTED_PROG="$(type -P parted)"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/tests/btrfs/318 b/tests/btrfs/318
new file mode 100755
index 000000000..796f09d13
--- /dev/null
+++ b/tests/btrfs/318
@@ -0,0 +1,108 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 Meta, Inc. All Rights Reserved.
+#
+# FS QA Test 318
+#
+# Test an edge case of multi device volume management in btrfs.
+# If a device changes devt between mounts of a multi device fs, we can trick
+# btrfs into mounting the same device twice fully (not as a bind mount). From
+# there, it is trivial to induce corruption.
+#
+. ./common/preamble
+_begin_fstest auto quick volume scrub tempfsid
+
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: validate device maj:min during open"
+
+# real QA test starts here
+_supported_fs btrfs
+_require_test
+_require_command "$PARTED_PROG" parted
+_require_batched_discard "$TEST_DIR"
+
+_cleanup() {
+	cd /
+	$UMOUNT_PROG $MNT
+	$UMOUNT_PROG $BIND
+	losetup -d $DEV0
+	losetup -d $DEV1
+	losetup -d $DEV2
+	rm $IMG0
+	rm $IMG1
+	rm $IMG2
+}
+
+IMG0=$TEST_DIR/$$.img0
+IMG1=$TEST_DIR/$$.img1
+IMG2=$TEST_DIR/$$.img2
+truncate -s 1G $IMG0
+truncate -s 1G $IMG1
+truncate -s 1G $IMG2
+DEV0=$(losetup -f $IMG0 --show)
+DEV1=$(losetup -f $IMG1 --show)
+DEV2=$(losetup -f $IMG2 --show)
+D0P1=$DEV0"p1"
+D1P1=$DEV1"p1"
+MNT=$TEST_DIR/mnt
+BIND=$TEST_DIR/bind
+
+# Setup partition table with one partition on each device.
+$PARTED_PROG $DEV0 'mktable gpt' --script
+$PARTED_PROG $DEV1 'mktable gpt' --script
+$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
+$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
+
+# mkfs with two devices to avoid clearing devices on close
+# single raid to allow removing DEV2.
+$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 >>$seqres.full 2>&1 || _fail "failed to mkfs.btrfs"
+
+# Cycle mount the two device fs to populate both devices into the
+# stale device cache.
+mkdir -p $MNT
+_mount $D0P1 $MNT
+$UMOUNT_PROG $MNT
+
+# Swap the partition dev_ts. This leaves the dev_t in the cache out of date.
+$PARTED_PROG $DEV0 'rm 1' --script
+$PARTED_PROG $DEV1 'rm 1' --script
+$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
+$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
+
+# Mount with mismatched dev_t!
+_mount $D0P1 $MNT
+
+# Remove the extra device to bring temp-fsid back in the fray.
+$BTRFS_UTIL_PROG device remove $DEV2 $MNT
+
+# Create the would be bind mount.
+mkdir -p $BIND
+_mount $D0P1 $BIND
+mount_show=$($BTRFS_UTIL_PROG filesystem show $MNT)
+bind_show=$($BTRFS_UTIL_PROG filesystem show $BIND)
+# If they're different, we are in trouble.
+[ "$mount_show" = "$bind_show" ] || echo "$mount_show != $bind_show"
+
+# Now really prove it by corrupting the first mount with the second.
+for i in $(seq 20); do
+	$XFS_IO_PROG -f -c "pwrite 0 50M" $MNT/foo.$i >>$seqres.full 2>&1
+done
+for i in $(seq 20); do
+	$XFS_IO_PROG -f -c "pwrite 0 50M" $BIND/foo.$i >>$seqres.full 2>&1
+done
+
+# sync so that we really write the large file data out to the shared device
+sync
+
+# now delete from one view of the shared device
+find $BIND -type f -delete
+# sync so that fstrim definitely has deleted data to trim
+sync
+# This should blow up both mounts, if the writes somehow didn't overlap at all.
+$FSTRIM_PROG $BIND
+# drop caches to improve the odds we read from the corrupted device while scrubbing.
+echo 3 > /proc/sys/vm/drop_caches
+$BTRFS_UTIL_PROG scrub start -B $MNT | grep "Error summary:"
+
+status=0
+exit
diff --git a/tests/btrfs/318.out b/tests/btrfs/318.out
new file mode 100644
index 000000000..2798c4ba7
--- /dev/null
+++ b/tests/btrfs/318.out
@@ -0,0 +1,2 @@
+QA output created by 318
+Error summary:    no errors found
-- 
2.43.0


