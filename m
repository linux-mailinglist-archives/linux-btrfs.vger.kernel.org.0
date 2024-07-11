Return-Path: <linux-btrfs+bounces-6403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D03E892F10D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 23:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25600B22B11
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4019F464;
	Thu, 11 Jul 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="UNP/n+jg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IRM6F6Z4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D9A8BFC;
	Thu, 11 Jul 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733018; cv=none; b=uBpTnEHGqDn82FvluPY4VUCSbBlkKUmNVKfFsrWbLLQ3iaPErBvw5AA1CEF1RtbEpJIfsFG0fFRI+jk4LlOiPr1jYfstfQHfrf/Ngs9LtTP2Kf9mt37YOhFL4UtlJ37SGDbOtg6hs+4Ld48uoQcU6Fzqk1hhVtHFPqsze/tUuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733018; c=relaxed/simple;
	bh=R/AFHhYeVTWGOBC7NGL14oYBmC8cpCupeIJ+2nCkQUI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YO9C72rdG6i1/SlZTGms5C5gbVZtJ/FPyLuJOOHEVu0Yv6qqEeXncckAd52SMeQcgldKe85Ev1IvjTjQcwBcTqizo27gkForkGCXfucjqHexV80fF1ofVkXBx6Z4h9hmsqIcRw8mlob/Pro1i0u+WSYaIPKqUuHcgxohL23ixz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=UNP/n+jg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IRM6F6Z4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 64A9A1140D7F;
	Thu, 11 Jul 2024 17:23:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 11 Jul 2024 17:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1720733016; x=1720819416; bh=OmznikUkbqm/Ift/vdkAt
	R5dTLc98dniXdMTE7vBvSg=; b=UNP/n+jgjivdDsIbZqlK8SGH+DjiJCY2TKvT0
	g4p54+rmI/2RPxrhVC5y1U0ObLIfYeRnNWdARjncYAIlHgC5O5gcnFuSAv/4Y+TU
	6GlhyKKbQFMx3UKWCX0WVwhIGXJTP1kvrvMXfhhGgIssWolkGzLpfgaj0SDnzm04
	CyFmIdodBU45bkaS7cpx4Iqd6iAd2cm1k9FH5VdG4YqIeD8hejNQf78Aft5bLb+f
	2TfyQaZCSUaOgAN42XOQYSS7L3NcsYtzqvEOx6rBxlC1IdpmsNJRk2SEY6Mj4c65
	k//GXhfdPoyTebnMmCejQKW91QcgWdZM+dBw2+L1LXJfuVv7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720733016; x=1720819416; bh=OmznikUkbqm/Ift/vdkAtR5dTLc9
	8dniXdMTE7vBvSg=; b=IRM6F6Z44LDegB+KLfERbgsqFkj8/+VcTGRnHVkEnTjw
	1zN4DmsaKcdDzPz44Kpc/0FOujF0ILtN1YTLnKGIt8eLP3VhNJinLsaGSFNr0DRg
	zdgfLpMPCUZX6lWXJkWOGKhT5ZofztL7NQHqRlVjFwI+c2kPdMJpqDkUgIV+0kla
	oJTKiGM8mASGZhtsQlML2w3wHlh2oBNy6EpUSNQOXI8OH5yfI/dJ4IkiB+5Y2Wmi
	AbXrRIQCpXsZOE0h8+0bPhD5Pfia+ZO8Qk8q07rpvT39c8mUOQzQlbZjMDIz+DqH
	Tgr/1EjXGaGiwJfyPgTDCJ0xJ/mh+E74JzYmjrotqw==
X-ME-Sender: <xms:V02QZtY36ogflyshNjc60RQxuAsX_DVmO6x0QdQyuQU8aopZWYX-HA>
    <xme:V02QZkYmIg-BD8k-zRuL_iy5K7vs8nay7xs7cyAfkBkqfyau9gOcb62gsNkELafwq
    JII0orq8hYX4tmQvCw>
X-ME-Received: <xmr:V02QZv-H1RNJx94NnNrjcxjcFF9EB9S4vAUIDVyg29E4vmi5MKiFOvCZzpwEih-RowpVuHp7UxwfQtYiCrtJsO1lwBE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:V02QZrptERDbX0szN-GKdEzKXaIcXukgzr0gpBlc-T07PZHWh2UC6w>
    <xmx:V02QZoqYvC-NfLdPvHJ3atvtfH092lHUkARzQao68wtyjit6a6cTdA>
    <xmx:V02QZhSLd5CWHjvIjy-xSQ61KsGTtOv51BVuX8uH9xmW7Gl_q0AGdg>
    <xmx:V02QZgrB5-o7OqiszgmlMk21sazCnkXS4eSR-1-bgsMrIoLdEq0AGQ>
    <xmx:WE2QZjW_Vkq8_IQz3Jw7YUOxZ5PQB9VB7j8etDowTzy5AHDf-JbOwxBs>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 17:23:35 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs: add test for btrfstune squota enable/disable
Date: Thu, 11 Jul 2024 14:22:39 -0700
Message-ID: <dadd378fcd6de83a566f1e587fa5d1a8337c3f6b.1720732930.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfstune supports enabling simple quotas on a fleshed out filesystem
(without adding owner refs) and clearing squotas entirely from a
filesystem that ran under squotas (clearing the incompat bit)

Test that these operations work on a relatively complicated filesystem
populated by fsstress while preserving fssum.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/332     | 61 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/332.out |  2 ++
 2 files changed, 63 insertions(+)
 create mode 100755 tests/btrfs/332
 create mode 100644 tests/btrfs/332.out

diff --git a/tests/btrfs/332 b/tests/btrfs/332
new file mode 100755
index 000000000..efc2d4ec3
--- /dev/null
+++ b/tests/btrfs/332
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test No. btrfs/332
+#
+# Test tune enabling and removing squotas on a live filesystem
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup
+
+# Import common functions.
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch_enable_simple_quota
+_require_no_compress
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_fssum
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+# do some stuff
+d1=$SCRATCH_MNT/d1
+d2=$SCRATCH_MNT/d2
+mkdir $d1
+mkdir $d2
+run_check $FSSTRESS_PROG -d $d1 -w -n 2000 $FSSTRESS_AVOID
+fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
+
+# enable squotas
+_scratch_unmount
+$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1
+$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
+_scratch_mount
+fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
+[ "$fssum_pre" == "$fssum_post" ] \
+	|| echo "fssum $fssum_pre does not match $fssum_post after enabling squota"
+
+# do some more stuff
+run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
+fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
+_scratch_unmount
+$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
+
+$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1
+$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
+$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep 'SIMPLE_QUOTA'
+$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV  | grep -e 'QUOTA' -e 'QGROUP'
+
+_scratch_mount
+fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
+_scratch_unmount
+[ "$fssum_pre" == "$fssum_post" ] \
+	|| echo "fssum $fssum_pre does not match $fssum_post after disabling squota"
+
+echo Silence is golden
+status=0
+exit
diff --git a/tests/btrfs/332.out b/tests/btrfs/332.out
new file mode 100644
index 000000000..adb316136
--- /dev/null
+++ b/tests/btrfs/332.out
@@ -0,0 +1,2 @@
+QA output created by 332
+Silence is golden
-- 
2.45.2


