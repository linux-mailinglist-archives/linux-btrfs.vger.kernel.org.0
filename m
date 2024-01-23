Return-Path: <linux-btrfs+bounces-1650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E4839813
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 19:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA701C27407
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E0F823AC;
	Tue, 23 Jan 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="tie1Uzfv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDOGeIVm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D4481DC;
	Tue, 23 Jan 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035454; cv=none; b=dK3zHvWLpq7jOV08z9G7LdBmUnM/+1GSl7+xAx9WibPX9847jFL11f0ZuxwDeLst0qHRehrtE34x2JLmAwX7RPcZIsgS53+qYvqeTfe7be28zpbMEkgOmEhmtzeEC59rqAJJFK+jFjvvN0gH00XvwClYsut+AgrhzP3pZjt2TWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035454; c=relaxed/simple;
	bh=dO0erxP+hLsKnnwZUVtSNnhGYpv5CpjENnS5j4nGU1A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=k9wlCtkX5D0ZeYsKus9LLDdFIrq7JeKHwnuwwDDn/6coRXhq1d7FpNALdYZA+lSxqITyC0hOrZJ2P/w3M/TWk2NxzY+yXjkb4yWmbyc74IJZKs7Z/qtH4HVE357e/43GufPy39Fq7wXqjnuc5AOm21Z8g9Tae7gKchEzqTxTrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=tie1Uzfv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eDOGeIVm; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A226E5C0165;
	Tue, 23 Jan 2024 13:44:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 Jan 2024 13:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1706035450; x=1706121850; bh=Ts8xKziiO9cTTvAMeK/mx
	r8iJ4BCPeJY8CwuPeBF0E0=; b=tie1Uzfv8Ifd4MTR4dO+ZY4bSparWqbndgP5H
	/xn2+2ZAT+wuuQBqA6PFQ1ZPKMbVqUKQz4pWKB8dsRus3oduNpwmOTMTSWI0jrnY
	AJ4G4nLEAfWWx0giXd52jF2iakZDZd8lbxjOqvkL5ycmQfwQC7qmIaG6qhiGYdUJ
	qFdP8JkAKa7hlLbcgs8HF4LrEIGP82isBhVwg3/AZrmY+5iAKz0wTacqQx/hTe/D
	KZDoawb4ObuhKP08ZCgRSaifPwD+mN9riN6k1dGeQ8tMWXZMvw9FZqFH8grFt75/
	Exk806HBpvX0u1wEZwPlI/4hJjXM8r6Kuv9DolJ3AWemu+P+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706035450; x=1706121850; bh=Ts8xKziiO9cTTvAMeK/mxr8iJ4BC
	PeJY8CwuPeBF0E0=; b=eDOGeIVmwOKMfRw05mj3ElSkRDo23B2ywSmuRFxyliB3
	ylPKmrGlDW34V5RYFq6SafuUajsZT83W6XgglUqJ/O7Hk6LTS1FU/hULMSzcDbzs
	qiQcDZIMIqmhlOVvMOZgzENJuaNnSdVlfmkPbyAQDnAoYYQP8Dbpn60KhXvnIF+6
	iuq5iQbbhCoeh9m5yza3nD7O4LY0kkfhpKjNsSNzfBiftebqnBIBZPFlt01bnQpg
	mBpzYMaR5AQ9rg4laVsy0IOeAbDWjDRG5v6BvWWJi+GXC2RfK9Cv3ieKuHQ4keG0
	fRUQYJiDCuARI1+9dQ0SBTadAEm5Fs0IfGJ1YcfgyA==
X-ME-Sender: <xms:-giwZU6kfFkpBChLXrN4_FiLOj3XXQE4_3a8C_WrjCTA3DLnwyxwHA>
    <xme:-giwZV4ljnl9_qmZnxagrLqNbpbPkXP1Fmf988n4MqiJPyNIhyq_e0hV3kdeJ4bpt
    xnugucvmta_JPQYzj0>
X-ME-Received: <xmr:-giwZTe1IGV5p1UnmwHK3arcsfdH2qoChJc5hs0h3gDV4408O8rLU3Gd25WK2sGJZJiEI8PVFy-nJoJ02mFD_M1OieU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:-giwZZL-U3f7tOsPGqMqBT46ZdLfNp8eGZg_8KVu27MbWkAC9lzvAg>
    <xmx:-giwZYJUVsxHBvOHkTjdc60iP2GmtOYy4urYDD0onpF71_h2zBGoCA>
    <xmx:-giwZaxjbbVYoLkm_y1ifX-nsyzsa-JoHVOh56kPKwZAp7yR-NK-2Q>
    <xmx:-giwZSiKYSFARM9LY_1NQ0XelRXG5vuWnYhxxO41_egIVci5Vp5kag>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 13:44:09 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2] btrfs/310: test qgroup deletion
Date: Tue, 23 Jan 2024 10:45:12 -0800
Message-ID: <ce4a79cafb6790ef6d1e141d65195f72f469ae4d.1706035378.git.boris@bur.io>
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
Changelog:
v2:
- removed enable quota helper
- removed unneeded commented cleanup boilerplate
- change test number 304 -> 310 (based on v2024.01.14)

 tests/btrfs/301     | 14 ++------
 tests/btrfs/310     | 83 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/310.out |  6 ++++
 3 files changed, 91 insertions(+), 12 deletions(-)
 create mode 100755 tests/btrfs/310
 create mode 100644 tests/btrfs/310.out

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index db4697247..4c1127aa0 100755
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
+	$BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
 	$BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
 	local subvid=$(get_subvid)
 	set_subvol_limit $subvid $limit
@@ -397,7 +387,7 @@ enable_mature()
 	# Sync before enabling squotas to reliably *not* count the writes
 	# we did before enabling.
 	sync
-	enable_quota "s"
+	$BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
 	set_subvol_limit $subvid $limit
 	_scratch_cycle_mount
 	usage=$(get_subvol_usage $subvid)
diff --git a/tests/btrfs/310 b/tests/btrfs/310
new file mode 100755
index 000000000..02714d261
--- /dev/null
+++ b/tests/btrfs/310
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 310
+#
+# Test various race conditions between qgroup deletion and squota writes
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup subvol clone
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
+    $BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
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
diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
new file mode 100644
index 000000000..d7d4bc0ae
--- /dev/null
+++ b/tests/btrfs/310.out
@@ -0,0 +1,6 @@
+QA output created by 310
+free from deleted owner
+ERROR: unable to destroy quota group: Device or resource busy
+add to deleted owner
+ERROR: unable to destroy quota group: Device or resource busy
+ERROR: unable to create quota group: Invalid argument
-- 
2.43.0


