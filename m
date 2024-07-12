Return-Path: <linux-btrfs+bounces-6418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1AD92FDF4
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 17:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4958028230F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 15:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB6174EEB;
	Fri, 12 Jul 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="OBFTPBAA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bwx5fXpw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAEF1741C2;
	Fri, 12 Jul 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799575; cv=none; b=OKVfWD6Wz2A8d5psi/CAu9nZzB+73+c3dlC8vFAqTOx4gNbdhP9a5GAD5MxoRuJxbTleurY5RjzrGQr2EhXDXxExA2hkruC9RGZ3bC5JynfPA7OYpeGjZBuI2sPd6C+OXRpLLVCOhqV6WtqI0DKRjPslyI0fPZ00OUVC2nd9/PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799575; c=relaxed/simple;
	bh=nOvxA6Bb4aVUsBBD6aBu6bPbJQA6SNHPDuWTFWs/IT0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DmJIOM7xtr+uoLyp8ChjmZNHiSHHN8PhC5TLOAxNLFWPqjUO0+oBapDNbd6axE9RJxXak2MgRZImZ3cu0ZZhe4By8722ya5TwMKrjE4Xz+MpEo4OZnO3Iw0MiK2ceYoviCA2C5ldc3xkImIQyg6evOqb16X4380a3ixIgte2jXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=OBFTPBAA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bwx5fXpw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 29C74138124C;
	Fri, 12 Jul 2024 11:52:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 12 Jul 2024 11:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1720799572; x=1720885972; bh=u6CY5MlZg+G7e4ssMZQ31
	6qZmV3Wz1bkdkLHIk3LG7M=; b=OBFTPBAAkfNOo65XVHX5KtNhVEcOFLmR9y10e
	VS/xrR/35G/4zoLxNeRjKc6twMjqE7rcqKvAW0VVGy3FtnKpYdrU3mXw6pQ47IUy
	m2Ht082El8WuVh8LrL1WeZjWxkBXAzwgiPN/U2E6F5Fb/XR32tnGHfWPwkbqRhsd
	SY+KI7xAGZ9QnRkPFyaz8pfIC3/PR5zY8wD93lHwMq0PK+CsZxk0sNLSp8t+SyZw
	7OyGkf2B8MR2H2tFLZVp/rMXuDjbOqi/BBtXNOed+n58oFIJP/9WzqF967V31SGr
	3MUMvtbSw5fY1iu+79N+vWENq+069QhPcCRooF5lwB7qaTgaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720799572; x=1720885972; bh=u6CY5MlZg+G7e4ssMZQ316qZmV3W
	z1bkdkLHIk3LG7M=; b=bwx5fXpwsfY24AyrUCc0Fhfohd1iakWmSiNc4NvxFcRa
	pv33gfV+HMuof84bpS2aSHUWiaAB59rKe1l4r8xm0Fbn0h+if0cgOJm4poTeZwC/
	gG9pwo07HM12C/vFo9aWeXrbf0AFsM8fNCvIRiR5Ji9Cy7zcFtZD4RNgG7E3R6pv
	QTbv9W1x8+cBuShfgpLb578NlKtrTAFY+EtbA2PJQ1PVd26HX/PIjebjnRrGxK3v
	y7YfaEy7yodgbe1iC/rX9a+CJiTJtu/0F2EEP5PKRI4eZa90blj3K62KG9YE4nxg
	HUj9IX7ZY1jtrA1WQczzovYPd8rmudHpOt3WVzj6Rw==
X-ME-Sender: <xms:UlGRZnebbN9kBLerAw8Z92Z8Ywsfju3sBNLdc5Pv9ZmxJFzxmb2_Og>
    <xme:UlGRZtM3lYDBT3SVMoI46kSofRohkSAv6j9Cin1d6UotFeOYuIMh30S70vmQvSi1o
    W5BBJRSrNg-jm_zvu4>
X-ME-Received: <xmr:UlGRZgivlDeYcaVygiNfV3GR5E3pQ2l_dSQOfrkv67sESq4mMlO04O3b-12J7a_pwx4S24CQDRuOxOjKBOGN-eizOBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:UlGRZo8i08-OaV0LFqRR2DvQ91C5BlI84ZsQv3HibQ6oSrokxCvJJw>
    <xmx:UlGRZjv1CUhc46Qcdb5n7jDJsEoPuYdjMS3dM18JHyrQiK_XDLqv2g>
    <xmx:UlGRZnEI21uz1lKpok5PeT7ar8XyMeG46v67S4YvtVghL3Yr_VLNPQ>
    <xmx:UlGRZqOvoR55n8JOp1IhkLA206aW8hk-j9eUW5O_fgigm_ExY4AvjA>
    <xmx:VFGRZjKrdy7Ox4c6tbRuOxwMqYA0LiqJp2x_wTJHz5Or48_yidkGuvmx>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jul 2024 11:52:50 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2] btrfs: add test for btrfstune squota enable/disable
Date: Fri, 12 Jul 2024 08:51:53 -0700
Message-ID: <7339416633376271b21b1be844e1a34f8656f780.1720799383.git.boris@bur.io>
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
 tests/btrfs/332     | 69 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/332.out |  2 ++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/btrfs/332
 create mode 100644 tests/btrfs/332.out

diff --git a/tests/btrfs/332 b/tests/btrfs/332
new file mode 100755
index 000000000..d5cf32664
--- /dev/null
+++ b/tests/btrfs/332
@@ -0,0 +1,69 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
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
+_require_btrfs_dump_super
+_require_btrfs_command inspect-internal dump-tree
+$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--enable-simple-quota' || \
+	_notrun "$BTRFS_TUNE_PROG too old (must support --enable-simple-quota)"
+$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--remove-simple-quota' || \
+	_notrun "$BTRFS_TUNE_PROG too old (must support --remove-simple-quota)"
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
+$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1 || \
+	_fail "enable simple quota failed"
+_check_btrfs_filesystem $SCRATCH_DEV
+_scratch_mount
+fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
+[ "$fssum_pre" == "$fssum_post" ] \
+	|| echo "fssum $fssum_pre does not match $fssum_post after enabling squota"
+
+# do some more stuff
+run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
+fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
+_scratch_unmount
+_check_btrfs_filesystem $SCRATCH_DEV
+
+$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1 || \
+	_fail "remove simple quota failed"
+_check_btrfs_filesystem $SCRATCH_DEV
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


