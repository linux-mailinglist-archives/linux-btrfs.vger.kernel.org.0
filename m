Return-Path: <linux-btrfs+bounces-1626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3058C83776C
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 00:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82421B2514F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 23:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46D48CED;
	Mon, 22 Jan 2024 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="jmNUeJN4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sc33KcJX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA248CDE;
	Mon, 22 Jan 2024 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964729; cv=none; b=AKv+VpjE0ZeK1wt5FudGBcAGvVq2s/OsaLzHeENh3ht3b62aaCtvxHpRxzgHo4OxtI2v527crusINui1xXbN0WBj0IhWkYfeIvu+ifuc6ltZO1erqELaoWFiSwR+oRMWf16bHgps+abbYjjMPeTUlQGQSvIjXXkSmdJfFi9aST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964729; c=relaxed/simple;
	bh=JTSmGzhhgd/D+wcKtMduOHazpxqYsBFx+mPbfm7mMwE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lDj5OjK9CkX5wsXKoZMd7V9jXrr0i8BEImYwc1Ohb422GN2gT2VOvjkPcplGbJK6kVzRuttLWeRErgViYeHkWnA+HthxYcohJ4fETUrx60iFWds9/LawrmHzGtd8sxJj5W21FrGbEOXBtNCrdjfvvSNbvTH+TWsg30mw696IvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=jmNUeJN4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sc33KcJX; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id C17033200A3B;
	Mon, 22 Jan 2024 18:05:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 22 Jan 2024 18:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1705964725; x=1706051125; bh=RS5NX66ZE6PjkMihkhF90
	MYAB6KXybsAkT3yWwEZsiw=; b=jmNUeJN4tW6zBrCJ2cKieVViRpPqS5r0RNdwd
	ZbIYwdpYdmkU475LGk58qdeO4NugzeC2u8vUmoy2mVYoPfV6Cmp43GGxls5R4Abo
	bUg823Q2e7lbz3AfFkB1vfX/tArQX4+g9xuuBH/VG+5PIcBYVzFgsb+Aa92M4tOq
	gcLtEETuJhFeLpS3F1Xf8HfuE3sgwWOseIUVii9K3s1PO3YUdwJ/O4McybRdeTZE
	Zj8sMPrGHn+j7qIeFGQT3FXJHPenBj1P56IT8odEKJPe/lxlYWm8R1EeoSuOuhJk
	+OWUIVC9AThCI6ONi4jzL4XQrYX6eWoYgwusPnPEqB7enLDBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705964725; x=1706051125; bh=RS5NX66ZE6PjkMihkhF90MYAB6KX
	ybsAkT3yWwEZsiw=; b=sc33KcJX4pxSuCSYMZsW3D1S3mwEw27+WFvQd0WjGJLY
	tK1NoyQZcD5p5dBA4r2QcyBPP2Rwfik3urlxntRLSjPipIMo46797Dyrlc4ruLUv
	AzRYytSREzn63bOF0r+ZqtSeaPPZm9MCKBW+5la7xTzxLtVJuaNd0w4mdvet+vzB
	vLDFOLGhYnDkxRM4uVMFs04Dl5dLw+gjHZCSD+XjCi5P8miw0VGhC00j9OYAiV2l
	LXrIB78OIuTl+49Wj1+6K0D5opMy4xF4o9Borv+K573HzSVZid58Zstr7MpxtG6x
	XgZ4XI8P6I60tWDXBxm1jwisivQyNf1Ob6FVMhOl/g==
X-ME-Sender: <xms:tPSuZdeYm9xDh-US4ezl37Vk3Sdz8f_KhO7dc3CaeCYwYapNJlQojA>
    <xme:tPSuZbNZu1kILUH6dr-haV-ol1GyQiAQl0k5saysRG_5R8z_03urZwHV_EZ7A7xgv
    3h4Vz6U5Qsm-Kk5vQs>
X-ME-Received: <xmr:tPSuZWhbwGnO3kUxHfKTWlqUZtWuipl4sQWXYpRedyhT6ouoADyZgjAYAxkigaaGC0kJRsYNOMfhniAvv2DNsYW-47U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:tPSuZW_HyZFt5u1NWbZFGeAvDl12-hywu-ZrT4aMLAI6Zv-eMf2WSA>
    <xmx:tPSuZZtor7SNEv2vbeDVZNpEOQo2a5Dho4Waz-az7NIFICL9DFT2Ag>
    <xmx:tPSuZVFodeA4sONashQjNyfGrZOB5cj13JKOwtrw-mbpcbZdwK0t5Q>
    <xmx:tfSuZaWxQv2mkpj-PAyFGhLyp3n5skk6yOpDgeaPrdX-aq9nHqwVKg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 18:05:24 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/304: test qgroup deletion
Date: Mon, 22 Jan 2024 15:06:28 -0800
Message-ID: <c9fa8fa558e307a5d0d28545ff69433ae8324f4c.1705964751.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using squotas, an extent's OWNER_REF can long outlive the subvolume
that is the owner, since it could pick up a different reference that
keeps it around, but the subvolume can go away.

Test this case, as originally, it resulted in a read only btrfs.

Since we can blow up the subvolume in the same transaction as the extent
is written, we can also increment the usage of a non-existent subvolume.

This leaves an OWNER_REF behind with no corresponding incremented usage
in a qgroup, so if we re-create that qgroup, we can then underflow its
usage.

Both of these cases are fixed in the kernel by disallowing
creating subvol qgroups and by disallowing deleting qgroups that still
have usage.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/btrfs        | 10 +++++
 tests/btrfs/301     | 14 +------
 tests/btrfs/304     | 90 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/304.out |  6 +++
 4 files changed, 108 insertions(+), 12 deletions(-)
 create mode 100755 tests/btrfs/304
 create mode 100644 tests/btrfs/304.out

diff --git a/common/btrfs b/common/btrfs
index f91f8dd86..c8593c1f9 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -775,3 +775,13 @@ _has_btrfs_sysfs_feature_attr()
 
 	test -e /sys/fs/btrfs/features/$feature_attr
 }
+
+_enable_quota()
+{
+	local mode=$1
+
+	[ $mode == "n" ] && return
+	arg=$([ $mode == "s" ] && echo "--simple")
+
+	$BTRFS_UTIL_PROG quota enable $arg $SCRATCH_MNT
+}
diff --git a/tests/btrfs/301 b/tests/btrfs/301
index db4697247..b3ee66cd9 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -157,16 +157,6 @@ do_enospc_falloc()
 	do_falloc $file $sz
 }
 
-enable_quota()
-{
-	local mode=$1
-
-	[ $mode == "n" ] && return
-	arg=$([ $mode == "s" ] && echo "--simple")
-
-	$BTRFS_UTIL_PROG quota enable $arg $SCRATCH_MNT
-}
-
 get_subvid()
 {
 	_btrfs_get_subvolid $SCRATCH_MNT subv
@@ -186,7 +176,7 @@ prepare()
 {
 	_scratch_mkfs >> $seqres.full
 	_scratch_mount
-	enable_quota "s"
+	_enable_quota "s"
 	$BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
 	local subvid=$(get_subvid)
 	set_subvol_limit $subvid $limit
@@ -397,7 +387,7 @@ enable_mature()
 	# Sync before enabling squotas to reliably *not* count the writes
 	# we did before enabling.
 	sync
-	enable_quota "s"
+	_enable_quota "s"
 	set_subvol_limit $subvid $limit
 	_scratch_cycle_mount
 	usage=$(get_subvol_usage $subvid)
diff --git a/tests/btrfs/304 b/tests/btrfs/304
new file mode 100755
index 000000000..3fce0591c
--- /dev/null
+++ b/tests/btrfs/304
@@ -0,0 +1,90 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 304
+#
+# Test various race conditions between qgroup deletion and squota writes
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup subvol clone
+
+# Override the default cleanup function.
+# _cleanup()
+# {
+# 	cd /
+# 	rm -r -f $tmp.*
+# }
+
+# Import common functions.
+. ./common/reflink
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch_reflink
+_require_cp_reflink
+_require_scratch_enable_simple_quota
+_require_no_compress
+
+_fixed_by_kernel_commit xxxxxxxxxxxx "btrfs: forbid deleting live subvol qgroup"
+_fixed_by_kernel_commit xxxxxxxxxxxx "btrfs: forbid creating subvol qgroups"
+
+subv1=$SCRATCH_MNT/subv1
+subv2=$SCRATCH_MNT/subv2
+
+prepare()
+{
+    _scratch_mkfs >> $seqres.full
+    _scratch_mount
+    _enable_quota "s"
+    $BTRFS_UTIL_PROG subvolume create $subv1 >> $seqres.full
+    $BTRFS_UTIL_PROG subvolume create $subv2 >> $seqres.full
+    $XFS_IO_PROG -fc "pwrite -q 0 128K" $subv1/f
+    _cp_reflink $subv1/f $subv2/f
+}
+
+# An extent can long outlive its owner. Test this by deleting the owning
+# subvolume, committing the transaction, then deleting the reflinked copy.
+# Deleting the copy will attempt to free space from the missing owner, which
+# should be a no-op.
+free_from_deleted_owner()
+{
+    echo "free from deleted owner"
+    prepare
+    subvid1=$(_btrfs_get_subvolid $SCRATCH_MNT subv1)
+
+    $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+    $BTRFS_UTIL_PROG subvolume delete $subv1 >> $seqres.full
+    $BTRFS_UTIL_PROG qgroup destroy 0/$subvid1 $SCRATCH_MNT >> $seqres.full
+    $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+    rm $subv2/f
+    _scratch_unmount
+}
+
+# A race where we delete the owner in the same transaction as writing the
+# extent leads to incrementing the squota usage of the missing qgroup.
+# This leaves behind an owner ref with an owner id that cannot exist, so
+# freeing the extent now frees from that qgroup, but there has never
+# been a corresponding usage to free.
+add_to_deleted_owner()
+{
+    echo "add to deleted owner"
+    prepare
+    subvid1=$(_btrfs_get_subvolid $SCRATCH_MNT subv1)
+
+    $BTRFS_UTIL_PROG subvolume delete $subv1 >> $seqres.full
+    $BTRFS_UTIL_PROG qgroup destroy 0/$subvid1 $SCRATCH_MNT >> $seqres.full
+    $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+    $BTRFS_UTIL_PROG qgroup create 0/$subvid1 $SCRATCH_MNT >> $seqres.full
+    rm $subv2/f
+    _scratch_unmount
+}
+
+free_from_deleted_owner
+add_to_deleted_owner
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
new file mode 100644
index 000000000..55bbc64f5
--- /dev/null
+++ b/tests/btrfs/304.out
@@ -0,0 +1,6 @@
+QA output created by 304
+free from deleted owner
+ERROR: unable to destroy quota group: Device or resource busy
+add to deleted owner
+ERROR: unable to destroy quota group: Device or resource busy
+ERROR: unable to create quota group: Invalid argument
-- 
2.43.0


