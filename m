Return-Path: <linux-btrfs+bounces-6431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B3930095
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 20:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F00CB22D94
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF7E1EB3E;
	Fri, 12 Jul 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Og+7MDcn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zw9A6+Ly"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57927224D1;
	Fri, 12 Jul 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810417; cv=none; b=fbbHpen0HJjZT49vbF0xn4Ut0v4SrF1vZvErxsq90q//j1hgdLD5GyUCmsA4cqdybmbQTexyXVHaLcVBYsZa8tS7PzBYZmEJXkz9eNytbsI8x8SEu0pxR7krJgxrTsNX1Hg16v8aMnPQCp6mTBuPNcsGdmPT7UxxVW9BSuXE+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810417; c=relaxed/simple;
	bh=I8J+9MigaEStozI08yOyKFSJOjX26/rvAIXXQVP4VlM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PTI0hYmKKDQomLpzEPa3/RKynd+gXYevKIrJAsRVELKCTFxX/ussQz4HWGRUem6/fEdxKfxqORN/nh56dtzMtocUJ9EruXrjnwiwRrng7ytA8LLw1yMIx4OPDHprmJPy+kp3wnuvaaie92rcC/FLcMuSXv6CwJ6hH3NsRLr09R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Og+7MDcn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zw9A6+Ly; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5DFD413819C5;
	Fri, 12 Jul 2024 14:53:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 12 Jul 2024 14:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1720810414; x=1720896814; bh=z6M7rRQNt8hiUYJ2IjKGZ
	uKU/wriuaIrfp5E8CbSt4s=; b=Og+7MDcn0QOEr5kdAyn2hnRL5/XIvz2kIbcT+
	RHkVKRDDb5zHILVdC0QLW349hFZogPrOaxAYkUcm1q5hqrkRii2hQEQozdP004Ur
	FzSdPl5L4VKKBvI5FOI4oHpGi/9fZQ76XdWSMDsYHUCvDr44DvO6bwwxWNuwzHUn
	NGcZUxbnv0P6bGT6r/NJbBt10iWp/RBsO8LJcG9XiDR8+Hhmwpg8ShI/jmNPj7pi
	fV+3GFaksSIFP+lTqDkWEO3J6Ym7NZrcb4pALgmGJkkIOZR3j4E8KpqDEw1QwcV2
	6/FAGXE0l27pt+2B65x4pVnghKqwSGzdGckdu43V7hvVY0kEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720810414; x=1720896814; bh=z6M7rRQNt8hiUYJ2IjKGZuKU/wri
	uaIrfp5E8CbSt4s=; b=Zw9A6+LybkrPuKS41SZkmE6t3bF8XM1R5JJ0kCelghSF
	RxU/2MishgKBDWesfO+FNF7QRTIFZquEErxCtN4tmmCqsTtUDF87FaWQpxDzVB9w
	HbWgn/2fD9Ml5FwK2Hg2E2Usu0pHS4+xN20RppIo18htJzoaClhY7O8ZrOJtZLEG
	aAz5MXq5L+LJcMaxgAQ6h2QyTGDHowPmv/N7tUhkX+PsvmIIICelJ9ObXa6BTIO1
	2ChbRu3LtNemOtfokx2D5Tfw7UTffQJELZRPaLKxa7IM/VDqOj8nsmHIsgos5/pF
	8deVl5Pz9aJ7jz0ZG4RoMTONJvcEqlIKVMRNFyQpHA==
X-ME-Sender: <xms:rnuRZnxxi2zDX2Rtl5TMEOh7b2oJAj18C39D3D45K0vz5TInFplYAA>
    <xme:rnuRZvTVmu0On7WBaN7O9xoZkSl0nLre26Hsk3mODYBLB9aoOC5fXKGXRb_UQ0IEU
    zYVqERo64CdP3FJ1gc>
X-ME-Received: <xmr:rnuRZhWpdhO_oABYM2AaevaLOR2NJXvLesaFgtrJYwkUgOKYcefgqe3NzgHz2CsmRV4JrENSntMdtnGDc4_p5R1BxZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:rnuRZhhIrj-mNMLR9e-tpq8DkxlVwnowseriOftrPWk_2nZzq_1ehQ>
    <xmx:rnuRZpAGXjTslN56bhkPJ7N1EF7uLXYXCRWrdeFbpf8uni6p51TdgQ>
    <xmx:rnuRZqLHlDNi9mNXZCn04-u6kW1qXa-akHfTTr8cYy7EAZk_g6-l0Q>
    <xmx:rnuRZoAdqpmSUYEy1MkSibYRwPQd33bLdUHqC5Bok56grtgcVxEQ-Q>
    <xmx:rnuRZoO_PWwYHi-z4cmzBRaEp0R9flGEpifLEcF9tiknkf0DN2A4M9Za>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jul 2024 14:53:33 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v4] btrfs: add test for btrfstune squota enable/disable
Date: Fri, 12 Jul 2024 11:52:36 -0700
Message-ID: <797a1ffab1bb76e65d278d9996abc72f423042ed.1720810205.git.boris@bur.io>
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
Changelog:
v4:
- redirected stdout of both btrfstune commands to .full file. Re-tested
  on 1. correct progs (passes) and 2a. buggy progs with a leaked eb and
  2b. buggy progs that hits a uptodatebuffer error while committing the
  txn. Everything behaved as expected.
v3:
- switched btrfstune commands from '|| _fail' to filtered golden output.
  Got rid of redirecting stderr to .full because some aberrant output
  (like eb leaks) shows up in stderr and I think it is helpful to treat
  those as errors.
v2:
- added needed requires invocations
- made fsck and btrfstune command failures matter 


 tests/btrfs/332     | 67 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/332.out |  2 ++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/btrfs/332
 create mode 100644 tests/btrfs/332.out

diff --git a/tests/btrfs/332 b/tests/btrfs/332
new file mode 100755
index 000000000..7f2c2ff9c
--- /dev/null
+++ b/tests/btrfs/332
@@ -0,0 +1,67 @@
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
+$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full
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
+$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full
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


