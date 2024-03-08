Return-Path: <linux-btrfs+bounces-3127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA48876A1B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 18:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5047F281168
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88A58ACD;
	Fri,  8 Mar 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="HLGD7Kup";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FbBfhF7o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9C3BBE0;
	Fri,  8 Mar 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919737; cv=none; b=thgBoxGJFCKTT+H4jCdN8Ahx7qCBeUTsUZoc+h0P+Sr92Gv0HcN8zeWm6cEjljN8p/wiUIprVdOyfIOMALmGUkLOLDdeiurMI7+oR0ErvZlMI67b8xndg2gA6ot83hOFdWZwItacLatTo/3grpVCZIFuGmpZapW14kJLjK4b/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919737; c=relaxed/simple;
	bh=SFXOBL6fUQ0zXCAuiPL2fjHlxPpTNCi0fqeDqykGEBA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OGm7CQmb1h7nSH+VkKCDgAyc3RbrNCoOoBcSVhHIlEqk71pb9EmWxBt8eQylIm12MoRUS/Zx1Lz9hYFjX+/+LMiNmVmAuLejYIHpy5GyMRquCxOOodTCPj2Kgz7XSYS0wYOOXE2jcU2sfm1ibB01hgts+y7ckq/91mIl98mLw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=HLGD7Kup; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FbBfhF7o; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id C74EE320046F;
	Fri,  8 Mar 2024 12:42:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 08 Mar 2024 12:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1709919734; x=1710006134; bh=Z11qWlqb+meoXSY08Gl6o
	lUgw/cEJuC40cLpX9QO918=; b=HLGD7KupCwcLuornKBfwg/wkqQ6aT4dPJAzD/
	xQPtVkioEYB703d3BwF7Eueo2uZq09800hQDKgZ5MQZPCzMa5+Cbf5qxkkXieM8s
	DyqUr8al517NmuoevS6tRgGEBN0kfu/1T6TEob9zRy8XgpY9YwXSWbv9MyqH7aL8
	2RhbefD/MleENgezOoQNH/bCWXPFUl/yKequSv1r48as1J+LHFFnpTC7rftssyjL
	AFtVBrRA8NA05QuA0dx6ad6PbfpyNMhFEB33snBHrwLvgRlAYpQA2Jm8eiiwh7y0
	FNQfzZ2RqKwH/GTp/Yh8JStU8CEo2jZBpDGcdgWqdLN5ZCk7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709919734; x=1710006134; bh=Z11qWlqb+meoXSY08Gl6olUgw/cE
	JuC40cLpX9QO918=; b=FbBfhF7oufrX+ZpjcMMbJj+GFE0kcx5qA7kMYcGO35YQ
	/Vi5srCdfvU89fgiOM88UzjKjtb9uqKfRjVYZQ8irwR3syRYnr7qfLo72gTp802W
	GvT8Sc8tXU7/bXX9DWWYrWOHwSOWqIb5lxsFsEFO137XtKUs2wbZ74zPyh0gJFP+
	C61hSsplPwHSO39EyHuOWksGh/icW0FcbByTgF5/bpo5RsopHwcsIzu/PzC9Q+fl
	jyAmTq38QYWENy6igJm/bfojFpAo+6fteMJTblh8Wx0Hica2hSLjcnbISs7Iv0ZK
	M2phmxIsYxgMFSLKz0cz6bmhspeKCETVtHtwggqigw==
X-ME-Sender: <xms:9k3rZetKGH0krAYyo8iYJxnQYrjgUMvsbnzoVARi5EO6UlsBvId0Kg>
    <xme:9k3rZTckQTnUUxGforfCCkDVrjSVn6pcEjQxBwGfgfo2eVDcERfx47mcpPX7_qc8y
    JZkZmRGj-L_Ri8yfoQ>
X-ME-Received: <xmr:9k3rZZwtWvN5ROSSddVFissTrw1wnEbkc54uPcWRfp9iDBSbqqgh-QF58jPSW_9-y3P-GVkegRi-BJJdHnCOwG2_p-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:9k3rZZP_EjusskaMCIf9B_kcNs7JilDM9BcKo98z-8bknxMi0dnDIg>
    <xmx:9k3rZe-nfIptPXUoy7EtnQChjUUDlg8Z5qreZpSqoCf2m-ULnCCb6A>
    <xmx:9k3rZRXXLokCTtVGqJS05wddyK9DGPQzQmOndnRzvE059LtUSlblwQ>
    <xmx:9k3rZUlKxcJiIhqkpkwFR5yv3aSfOYL-Z9bSu095Wrf_2AztlAr1zg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Mar 2024 12:42:13 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v3] btrfs: new test for devt change between mounts
Date: Fri,  8 Mar 2024 09:43:14 -0800
Message-ID: <9dde3b18f00a30cae78197c9069db503f720fe71.1709844612.git.boris@bur.io>
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

Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v3:
- fstests convention improvements (helpers, output, comments, etc...)
v2:
- fix numerous fundamental issues, v1 wasn't really ready

 common/config       |   1 +
 tests/btrfs/311     | 105 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out |   2 +
 3 files changed, 108 insertions(+)
 create mode 100755 tests/btrfs/311
 create mode 100644 tests/btrfs/311.out

diff --git a/common/config b/common/config
index a3b15b96f..43b517fda 100644
--- a/common/config
+++ b/common/config
@@ -235,6 +235,7 @@ export BLKZONE_PROG="$(type -P blkzone)"
 export GZIP_PROG="$(type -P gzip)"
 export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
 export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
+export PARTED_PROG="$(type -P parted)"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/tests/btrfs/311 b/tests/btrfs/311
new file mode 100755
index 000000000..a7fa541c4
--- /dev/null
+++ b/tests/btrfs/311
@@ -0,0 +1,105 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 Meta, Inc. All Rights Reserved.
+#
+# FS QA Test 311
+#
+# Test an edge case of multi device volume management in btrfs.
+# If a device changes devt between mounts of a multi device fs, we can trick
+# btrfs into mounting the same device twice fully (not as a bind mount). From
+# there, it is trivial to induce corruption.
+#
+. ./common/preamble
+_begin_fstest auto quick volume scrub
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
+_mount $D0P1 $MNT || _fail "failed to remount; don't proceed and do dangerous stuff on raw mount point"
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
diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
new file mode 100644
index 000000000..70a6db809
--- /dev/null
+++ b/tests/btrfs/311.out
@@ -0,0 +1,2 @@
+QA output created by 311
+Error summary:    no errors found
-- 
2.43.0


