Return-Path: <linux-btrfs+bounces-2935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AD586D266
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3ABF288067
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1367A156;
	Thu, 29 Feb 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="PZ7t1AFE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GvUhn2H6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654B381C4;
	Thu, 29 Feb 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231732; cv=none; b=I7UHatyWYMxI4FdxYl32gdX05pLOcGCOX6pQDtql3uTvyXuUGB+zbPslSGsQQy5Ok/FJ9rFZrn6YtEm9CskmKl6K4isIj0WpwXNgapWkTvA2TjVIA2Hqin1iozt3qzbDFAp/yJSEHPIEB/W8oec2gHfpXdDIjUtG+/DGeEVKhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231732; c=relaxed/simple;
	bh=F/bemvYPNWTCS8rNBpNXnSl5Zag4FxUsJ8prmVI1Kwo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=saentz88IEK0eRMCc4qG2pppC1IEWZp3kFvgiNHFd3IC5cFlr65N308LQjQj2087pRHHrowO8GWX+ZTRshTMHVW3xc8+2Wdq4M4SoyUo3d/SYhpy7eo1qMWVC+XUaCaRD7v/A9r9jYdbvrQ16v+ZPuKwPR/l7g3pcznM2mBniZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=PZ7t1AFE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GvUhn2H6; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id D84BE3200906;
	Thu, 29 Feb 2024 13:35:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 29 Feb 2024 13:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1709231728; x=1709318128; bh=JStfRPPwT87i2TqPbIeZ+
	DSFcE5INSSmLGon9NIRu8w=; b=PZ7t1AFEuAOojWSMBazYTItp+cb+5XNstOCzH
	HVrUpO1fCUJ1vcIAGWtqbnMAUFToGVHG4emm1zY8mXR0bgrPo+C54y2bXa9BHuQo
	7xl96txqsaW1VlHCGYhxf3dmzwkqBuylvGh5OY4Kd5fIEjZC3bHzWTqS/bLbgr4c
	GI2ZUBlt3RRVAMxyRu5KJA9bQsC4s8bwiVTolBeHCR16enjQdxNShzgsymsOTtEr
	K89u9+HxmPHDlDxOJbgXYDyVVbl+1OFmQ1L9co0GDwy/23+nkUBq8UJP3FR90Tnq
	dypy3uEGpi0XO/7Xhq9d/y7Butcs8cl418x4/u+OYwMqAM1jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709231728; x=1709318128; bh=JStfRPPwT87i2TqPbIeZ+DSFcE5I
	NSSmLGon9NIRu8w=; b=GvUhn2H6cc38WrMM1sG9GtZLAkPKw3Xx83kL81ixuFTi
	/leMNRpFsQs203isNMFowxLSwVGbP8wJSkSozBl7NJEee1Bjl8TaquqIVLAVYk5O
	gvNtIvxsR7+32zkmZGn/t3rSd+L6FgzoNJaj2QBAL8B06/jWXhhANGDP4lg+R0ts
	mxYsPwg3FcUjtCOn04qyHGP+zWeC1wQZ0ND9J8DsRcI8xEFuPk6fU64TD/Dm6eF3
	giJxQOwN6DcFGBtO4IQY8uiMitwL1mOsg8/aVE8TP0HZsLAdf+ciEQ0Jf8TJVlRK
	EuvCMV+dXoe8c+lugoL/5D7uxfBIM4lBfKNEQqayYw==
X-ME-Sender: <xms:cM7gZd7nY7pEj-vOiUOC9JV_eoHbEGM4FMyAxDndbnApFChnl9Zxpg>
    <xme:cM7gZa5Jeas5OpwaaamCtAOdvpShq_vjuHLJe4uzsBlO6h78iD20MJ4f34IX6oEdy
    auz9tLkuImhgDe7D90>
X-ME-Received: <xmr:cM7gZUcLn8Krv6t2esHAtClO-Ix0B7vaLLDeAC7LhPTEGkj6wHRyuiA-MtZvAuOyFRJm89epP8d71iPpXybMvVefdj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:cM7gZWIDMf4FwxrqRMNx3nISpZ3-Ej6Bh7gFJepjH_4CQftVCMxZZg>
    <xmx:cM7gZRJBhJpdV94Oe0wu7iWeu8A48SQV6I7hHYaNB2aWGiBrdJfwGA>
    <xmx:cM7gZfx8RLa-EstjFpNkKQ3v1sOtJeaZPnfN1vLA7bgrQ5y_X6wGSg>
    <xmx:cM7gZfhY7Ku_uucBqpBBdhkmRObMdo6TzsOpK1y4V4cFqvlvychRmw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 13:35:27 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs: add test for shifting devt
Date: Thu, 29 Feb 2024 10:36:41 -0800
Message-ID: <27bad2e06121a6cd5cb34146e37b8e2dc46dec0c.1709231457.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 common/config       |   1 +
 common/rc           |   4 ++
 tests/btrfs/303     | 127 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/303.out |   2 +
 4 files changed, 134 insertions(+)
 create mode 100755 tests/btrfs/303
 create mode 100644 tests/btrfs/303.out

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
diff --git a/tests/btrfs/303 b/tests/btrfs/303
new file mode 100755
index 000000000..dece3eacc
--- /dev/null
+++ b/tests/btrfs/303
@@ -0,0 +1,127 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 Meta, Inc. All Rights Reserved.
+#
+# FS QA Test 303
+#
+# Test an edge case of multi device volume management in btrfs.
+# If a device changes devt between mounts of a multi device fs, we can trick
+# btrfs into mounting the same device twice fully (not as a bind mount). From
+# there, it is trivial to induce corruption.
+#
+. ./common/preamble
+_begin_fstest auto quick volume
+
+# Override the default cleanup function.
+# _cleanup()
+# {
+# 	cd /
+# 	rm -r -f $tmp.*
+# }
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_test
+_require_parted
+
+#BARE_MOUNT_PROG=$here/src/bare-mount
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
+do_mkpart() {
+	local dev=$1
+	$PARTED_PROG $dev 'mkpart mypart 1M 100%' --script
+}
+
+do_rmpart() {
+	local dev=$1
+	$PARTED_PROG $dev 'rm 1' --script
+}
+
+# Prepare 3 loop devices on the test device
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
+# Setup partition table with one partition on each device
+$PARTED_PROG $DEV0 'mktable gpt' --script
+$PARTED_PROG $DEV1 'mktable gpt' --script
+do_mkpart $DEV0
+do_mkpart $DEV1
+
+# mkfs with two devices to avoid clearing devices on close
+# single raid to allow removing DEV2
+$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 &>/dev/null
+
+# Cycle mount the two device fs to populate both devices into the
+# stale device cache
+mkdir -p $MNT
+mount $D0P1 $MNT
+umount $MNT
+
+# Swap the partition dev_ts. This leaves the dev_t in the cache out of date.
+do_rmpart $DEV0
+do_rmpart $DEV1
+do_mkpart $DEV1
+do_mkpart $DEV0
+
+# Mount with mismatched dev_t!
+mount $D0P1 $MNT || _fail "failed to remount; don't proceed and do dangerous stuff on raw mount point"
+
+# Remove extra device to bring temp-fsid back in the fray
+$BTRFS_UTIL_PROG device remove $DEV2 $MNT
+
+# Create the should be bind mount
+mkdir -p $BIND
+mount $D0P1 $BIND
+mount_show=$($BTRFS_UTIL_PROG filesystem show $MNT)
+bind_show=$($BTRFS_UTIL_PROG filesystem show $BIND)
+# If they're different, we are in trouble.
+[ "$mount_show" = "$bind_show" ] || echo "$mount_show != $bind_show"
+
+# now prove it by corrupting it
+for i in $(seq 20); do
+	# TODO diff prog
+	dd if=/dev/urandom of=$MNT/foo.$i bs=50M count=1 &>/dev/null
+done
+for i in $(seq 20); do
+	# TODO diff prog
+	dd if=/dev/urandom of=$BIND/foo.$i bs=50M count=1 &>/dev/null
+done
+sync
+find $BIND -type f -delete
+sync
+$FSTRIM_PROG $BIND
+sleep 5
+echo 3 > /proc/sys/vm/drop_caches
+$BTRFS_UTIL_PROG scrub start -B $MNT >>$seqres.full 2>&1
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
new file mode 100644
index 000000000..d48808e60
--- /dev/null
+++ b/tests/btrfs/303.out
@@ -0,0 +1,2 @@
+QA output created by 303
+Silence is golden
-- 
2.43.0


