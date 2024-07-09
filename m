Return-Path: <linux-btrfs+bounces-6329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F6A92C2CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 19:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB41B21408
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C184917B043;
	Tue,  9 Jul 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="V0Msd9iO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7/CTl2U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1544F1B86FD;
	Tue,  9 Jul 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547525; cv=none; b=ErdqVYuUy4YU3b6A5sB1r11dTarvPGGw5uWURxNP9sMyGzFG3Ir48auzGmxjteUsA/ZBmvlzntOhE8dbTBBobmjpoCQfpF5CC2IzTZ6yaCBNoYTLdG8lF80lYupfxU6I56uAZPZ7Zb/YWS5JftT1eNMLUtjXMYNa7hP+RY3cKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547525; c=relaxed/simple;
	bh=X1IiFjxd+UcwxsthQpUm9T+qGcRq0YSepSFPJWt7Yzo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aIzoBudYsjL9fECl+4kG+gbTxYyLnQkxcmX3GEmWcjGUpiFud/pv21BZzOggCMx2h0Gl5Nd4cCDKf3pLgwRaSqz9z6FjSKoJCcxEaZoQ6L5kqt1jjth+e1bHwV/ouHnHw52MltNGjgH3ZiK3tFTFPXUexqEQbGhDdH5QIRL6oAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=V0Msd9iO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7/CTl2U; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 155F41140157;
	Tue,  9 Jul 2024 13:52:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 09 Jul 2024 13:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1720547522; x=1720633922; bh=NK4E89+scFesjdgquBJUr
	VTnOjvJ5mo5zcMk3Osi5Fo=; b=V0Msd9iOyLKA6IuJsIJsIsJ/MW+aIs+FrmSb0
	qiQLnXJyVFqRswujiTCnCKVwgjINgRZ84YoSDBrQVwtFRROYpZ8xNrKxW0U0tJmE
	tXqb5mAARpCoVS14HB1iq3O4VzX6kpsSOtZT/Xm5jW/mCPUt/urCPBDb5H9Nv0Ui
	t26q5uH+2JZj9VQEByXivCTwazVxXXrclMaIsPl98r7T7+MWNZbpDXgDF0AmnD9E
	7N3/sUxId4Kt46HxfRWEmAKTiJkp8BQbi3+IB22mfKvT97S+3cT2VO0TVVQauitn
	Q0aD3FpNbndmcvDrQ0hPT2Sy8IjYJY5zP58zcor0fW5Jkqoxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720547522; x=1720633922; bh=NK4E89+scFesjdgquBJUrVTnOjvJ
	5mo5zcMk3Osi5Fo=; b=l7/CTl2U5iP1OVqL51x38K4hAeJ/Hji8jJTs7KEaGUmd
	zc8kS8jwy9EOGhFvEHPhy1DqDzUw4HpYetILaiGsifiQAirhdlJ8/qbomoZM5MHy
	Ee1MThFpewepOCdZ7vhwRt88riujU2U1vxKd4c9urAoct1g4ZDYKtoJxVdd0jZEl
	GJgi4+cJiEcYi20pqKeXtqob6Oyqb3fQN7AzrVjjlYd8vAKMc4rfXBf9hQR9h5G2
	nmvALdRCVBCC/uHzp1KKJNKnEdCNvNINZh5YXxzJ+8Hbt9jIXhQUxOHcx/z/18Fk
	dxFvTlf7Y4LCQ8VUy3JYpCq8bhJjWhg6YgiHOOuzrQ==
X-ME-Sender: <xms:wXiNZg2bpw0tplaruhHKWBONopzEKg-_Okq2X_qKS0JSf6FRXRFuuA>
    <xme:wXiNZrHOnOOQX3tytlsK3UJP-Bzmv72NuTnuzvMkE77v7pvb_7tgUs0bhdo1z5QSA
    LK11DUh7Cq_prBULl4>
X-ME-Received: <xmr:wXiNZo5fA8z5YhP4fnjVGJo-sG1OP8LpJzUYLyCa9vDCky8Zf2n5Y0ThkkwWLwaBoj6yd88G4pVtM-PHGSK6jm_Tmw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:wXiNZp2vFGXCSlnYeA9nQjWuI8UyeUZrkdo6dCXrK8SDHkfBqHiddQ>
    <xmx:wXiNZjGYleZPc-9LO_j6E1HY6IraDXAyn7NS0-c7wSxME-4TlmrnGg>
    <xmx:wXiNZi9vgODdewt2FAlsKozbaJRKg2Id0r6i864ME5dlXYB7Ti2qbA>
    <xmx:wXiNZokiha6k4BLyHBpDkSdKJMdI8mBSFQ2jzFZNQ4RiA62MmzCBVA>
    <xmx:wniNZrDrD97aRxo2s7ePE-pv95gpsY_9Mc7w2_VuCya-KrnnnennPBYc>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jul 2024 13:52:00 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: kernel-team@fb.com,
	linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs: add test for subvolid reuse with squota
Date: Tue,  9 Jul 2024 10:51:04 -0700
Message-ID: <53cdc0c4696655a0e7a5eb62612a7b87ff4d48cd.1720547422.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Squotas are likely to leave qgroups that outlive deleted subvolids.
Before the kernel patch
2b8aa78cf127 ("btrfs: qgroup: fix qgroup id collision across mounts")
this would lead to a repeated subvolid which would collide on an
existing qgroup id and error out with EEXIST. In snapshot creation, this
would lead to a read only fs.

Add a test which exercises the path that could create duplicate
subvolids but with squotas enabled, which should avoid the trap.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/331     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/331.out |  2 ++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/btrfs/331
 create mode 100644 tests/btrfs/331.out

diff --git a/tests/btrfs/331 b/tests/btrfs/331
new file mode 100755
index 000000000..8a99d5527
--- /dev/null
+++ b/tests/btrfs/331
@@ -0,0 +1,45 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 331
+#
+# Test that btrfs does not recycle subvolume ids across remounts in a way that
+# breaks squotas.
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup snapshot
+
+_fixed_by_kernel_commit 2b8aa78cf127 \
+	"btrfs: qgroup: fix qgroup id collision across mounts"
+
+. ./common/btrfs
+_supported_fs btrfs
+_require_scratch_enable_simple_quota
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+$BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
+
+# Create a gap in the subvolume IDs
+sv=$SCRATCH_MNT/sv
+for i in $(seq 100); do
+	$BTRFS_UTIL_PROG subvolume create $sv.$i >> $seqres.full
+done
+for i in $(seq 50 100); do
+	$BTRFS_UTIL_PROG subvolume delete $sv.$i >> $seqres.full
+done
+
+# Cycle mount triggers reading the tree_root's free objectid.
+_scratch_cycle_mount
+
+# Create snapshots that could go into the used subvolid space.
+$BTRFS_UTIL_PROG subvolume create $sv.BOOM >> $seqres.full
+for i in $(seq 10); do
+	$BTRFS_UTIL_PROG subvolume snapshot $sv.BOOM $sv.BOOM.$i >> $seqres.full
+done
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/331.out b/tests/btrfs/331.out
new file mode 100644
index 000000000..0097e61d8
--- /dev/null
+++ b/tests/btrfs/331.out
@@ -0,0 +1,2 @@
+QA output created by 331
+Silence is golden
-- 
2.45.2


