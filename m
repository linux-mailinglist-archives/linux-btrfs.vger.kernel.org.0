Return-Path: <linux-btrfs+bounces-2956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C764686D819
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 01:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399B91F223BB
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 00:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB9417E1;
	Fri,  1 Mar 2024 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NSDLXf9R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VXUdSopJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC917D2;
	Fri,  1 Mar 2024 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251339; cv=none; b=MmQJehUoliTf+aqrfud77OK29SJhmKOBbq+ceK+e+YwI5aic5Lxb5eJZTZUPEqjtTycOhSWdQsJQQTXEeY8m0nxjJuP8dAOG5gMj83cWCFWM2JOjJ4vfi3aXO4u26AUPcHoQVqOKkBNMfvFiBqrFzQYYUrp/gvRfVjQUY3w42sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251339; c=relaxed/simple;
	bh=kLzuGW4fAEdlAEEK4xy9MuCJ7/48nx73xWSGvkVvYYI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qsifX6fpyGSZcMTdab98IB4qCXCcECwnnMEHEuIwCCWm6f8MJlGYcLeU5Rth465a07QmrXWhCCDKyc8Up520g9N0HAye3KugIJ0D3NnUOnaKKlVKfOjH+/iJHPtDnwU6ksUj5ZcicRieGgOY34eo2WEsERJPWPWZcW8J8cev4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NSDLXf9R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VXUdSopJ; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 972EF3200063;
	Thu, 29 Feb 2024 19:02:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 29 Feb 2024 19:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1709251335; x=1709337735; bh=9o1hpJTnxrK7R1iM1B+vz
	S8pXPd1trfpZJrqCs6ks+U=; b=NSDLXf9RFXCNUoPPBao6nBqSFkQowpnF7tPfN
	baOnh/R/CYPKmCkM8LhG7B3trSH3bSArelx14KE0KAGYeeRqTu/Y++Me2TAziOc/
	6jR+ZYDrHCihtYnv7SsVor617x8UdxfT+0ieMyjCkYKFZz38G0lgUakEVc0hX+Po
	nG5YDbxTGxuifbDmSiqBzeINz4id5rR556hkipAa1zOyfx5igsfDiesPz0XD5mza
	JQTG5x1wEl9oLcibWTyR1elWx6Fur4Z6jqJkqaLJo7Tk27NPHu60UDW57uEUXmn7
	vwHS+h40gaMdzjQ10zSDK71Xv1vSAxK21+OpZASITLOnIUAYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709251335; x=1709337735; bh=9o1hpJTnxrK7R1iM1B+vzS8pXPd1
	trfpZJrqCs6ks+U=; b=VXUdSopJE7jyNUzI54dGMajAX5oa4YC6Mf6Se7uyDcGz
	OOLLiB9623KHjKoKFLo39C+1ul6JHABHqKP18GxUnMOpX9T5oTs+kD9YLd+fLpm2
	59JsXoWv6czAQV2b0Xq2SSaUL3JSlThlLyFysyJAJeio7WC/wCu1B00F7GwaPgtl
	32CkSnuaOG1V3udJ8SYIXR7mua8euVVJ4pyQTPFIB2bcY1SkaRSeQcVFAmTyOEt4
	nLJraT/QmjnuNhtyOJT6R1H3HDxzGGkH2Y3fsgw7Cn7jFEs7vuHttCFI6tiZv+kL
	e7BxzSR+Dq11qLFY3/WTx+reOgbQXQYt2VLhH1RgiA==
X-ME-Sender: <xms:BhvhZcjLM75KTD7a3wCehx9Ldh7V-AJZk4-0mWox78Csl2pYNf7AfQ>
    <xme:BhvhZVCQeRk7TgItmHy1FPtLimBeMd0dB_fgmMv-x39MYpTFDcsZ2DV1bAz9q2NMC
    UslTV8-armdoBfDa88>
X-ME-Received: <xmr:BhvhZUGqinFmNd-4_j-JiTqRdNMBzWyAwQVmPyQxUsYPwQjarsNnFEufyurFL7OCiNBNP2Lv7G4MEZ13hPTHKONp9lM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedtgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:BhvhZdRP0IOu4TfM9K8n5AOWUWNFy2QSXQeRHkrJJyzo2Jy_kkto-g>
    <xmx:BhvhZZw5HvNTBVAj04NtQbrJNmRITHLrSEJeRz6xtcjsjU9_mQg9Gg>
    <xmx:BhvhZb5LV5B7vgKcHuvQdL6rBzvCw8qOJC-42D9ieCycj5W4wzSVcg>
    <xmx:BxvhZaoBarDTA0gg72vO8J3jcxaRqwm3ekGfe3GKG-_UKQkBa6XPIA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 19:02:14 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2] btrfs/311: new test for devt change between mounts
Date: Thu, 29 Feb 2024 16:03:27 -0800
Message-ID: <f40e347d5a4b4b28201b1a088d38a3c75dd10ebd.1709251328.git.boris@bur.io>
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

This is fixed by the combination of the kernel patch:
btrfs: support device name lookup in forget
and the btrfs-progs patches:
btrfs-progs: allow btrfs device scan -u on dead dev
btrfs-progs: add udev rule to forget removed device

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/config       |   1 +
 common/rc           |   4 ++
 tests/btrfs/311     | 101 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out |   2 +
 4 files changed, 108 insertions(+)
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
diff --git a/common/rc b/common/rc
index 30c44dddd..8e009aca9 100644
--- a/common/rc
+++ b/common/rc
@@ -5375,6 +5375,10 @@ _require_unshare() {
 		_notrun "unshare $*: command not found, should be in util-linux"
 }
 
+_require_parted() {
+	$PARTED_PROG --list &>/dev/null || _notrun "parted: command not found"
+}
+
 # Return a random file in a directory. A directory is *not* followed
 # recursively.
 _random_file() {
diff --git a/tests/btrfs/311 b/tests/btrfs/311
new file mode 100755
index 000000000..887c46ba0
--- /dev/null
+++ b/tests/btrfs/311
@@ -0,0 +1,101 @@
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
+_begin_fstest auto quick volume
+
+# real QA test starts here
+_supported_fs btrfs
+_require_test
+_require_parted
+
+_cleanup() {
+	cd /
+	umount $MNT
+	umount $BIND
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
+$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 &>/dev/null
+
+# Cycle mount the two device fs to populate both devices into the
+# stale device cache.
+mkdir -p $MNT
+mount $D0P1 $MNT
+umount $MNT
+
+# Swap the partition dev_ts. This leaves the dev_t in the cache out of date.
+$PARTED_PROG $DEV0 'rm 1' --script
+$PARTED_PROG $DEV1 'rm 1' --script
+$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
+$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
+
+# Mount with mismatched dev_t!
+mount $D0P1 $MNT || _fail "failed to remount; don't proceed and do dangerous stuff on raw mount point"
+
+# Remove the extra device to bring temp-fsid back in the fray.
+$BTRFS_UTIL_PROG device remove $DEV2 $MNT
+
+# Create the would be bind mount.
+mkdir -p $BIND
+mount $D0P1 $BIND
+mount_show=$($BTRFS_UTIL_PROG filesystem show $MNT)
+bind_show=$($BTRFS_UTIL_PROG filesystem show $BIND)
+# If they're different, we are in trouble.
+[ "$mount_show" = "$bind_show" ] || echo "$mount_show != $bind_show"
+
+# Now really prove it by corrupting the first mount with the second.
+for i in $(seq 20); do
+	$XFS_IO_PROG -f -c "pwrite 0 50M" $MNT/foo.$i >$seqres.full 2>&1
+done
+for i in $(seq 20); do
+	$XFS_IO_PROG -f -c "pwrite 0 50M" $BIND/foo.$i >$seqres.full 2>&1
+done
+sync
+find $BIND -type f -delete
+sync
+
+# This should blow up both mounts, if the writes somehow didn't overlap at all.
+$FSTRIM_PROG $BIND
+echo 3 > /proc/sys/vm/drop_caches
+$BTRFS_UTIL_PROG scrub start -B $MNT >>$seqres.full 2>&1
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
new file mode 100644
index 000000000..62f253029
--- /dev/null
+++ b/tests/btrfs/311.out
@@ -0,0 +1,2 @@
+QA output created by 311
+Silence is golden
-- 
2.43.0


