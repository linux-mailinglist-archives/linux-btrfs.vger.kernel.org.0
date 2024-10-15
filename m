Return-Path: <linux-btrfs+bounces-8951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E7099FC75
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 01:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DAD9B231CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 23:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A82E1D95B5;
	Tue, 15 Oct 2024 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="XEbFZhpQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b52I6V80"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8A21E3BC;
	Tue, 15 Oct 2024 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034859; cv=none; b=OeXamnYC7s3ZgmNXk5dXthGbMn3Isrzbn2J/zkBvF0GpKEo03QOxa+YBlHsBxBeFGZ7dfFHWecwLVNIwIkyApcidLVKjVLxEQRPEcRE1bbL9ULJj13gEtVBZgy/acEnKmSRm/h7TtisJKrvK7e2y+qBOlCN/Hvwe4DuxP5VaBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034859; c=relaxed/simple;
	bh=WNDGENH2QeJYwCcM+NoDG5Kg71HZpwDTq7WvSuJ/97g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fnEz/OXAf328leS7ukewKZ1233/TdcUhW3ezLbeonuLSRRR3yxw/a+KLTCbGSAJ5VAcqWWLh1a23R8t2hP9p8iFkorQRRPNwqyeXoAf5md7jnogzhIAPl9li5xI6+RAwGsrT3/yUqXDV/QTi89xRZRo1fJYzRXVnGifAQUcBPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=XEbFZhpQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b52I6V80; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 056D5114015C;
	Tue, 15 Oct 2024 19:27:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 15 Oct 2024 19:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1729034856; x=1729121256; bh=iMYxw+d7fl5tFdAyd1OXA
	z6F6WMW1HgYkyxztSD1G8Y=; b=XEbFZhpQUPknUaeTCMGjCfcT8pbr6ZcQd07l5
	/FC6zIDuY0fygPrzUA8P9TwQutzU3ecwGnOm81uASu24HK0dAcqTbpSM08/FLDUm
	099DID6BEICRvlnKU6Xfn+CiuJtl/Ev0uqQ52uNt9PvG1ReLLsCYpHdOGU12tzVI
	6o6Y0bXEqkgHzRPaLubcBq2+p2uFaz8U3zHG7HYL3ERTW94EYMbCHEUIcy04gqqw
	wEtNRZ4PQYeyczqiRCAdf9rtON5YWQyi02rWvXTCDFTdezGRAXAZLjU4KOCHMF8J
	P7B8pQ88iEMiv2iuDGVbnO5Waf1uRpk+PQVf6HVyhj8p0lgRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729034856; x=1729121256; bh=iMYxw+d7fl5tFdAyd1OXAz6F6WMW
	1HgYkyxztSD1G8Y=; b=b52I6V8038llO5HyJf24QplIeADTjl0jPDQIY1CR7EIw
	BklHWPxH3q5q7XgWg82yLyN4s28iXDeGqhlHvib/Io/8DYc8kZNuZO71JPUggotT
	U7B9HCIgKCozuyTbIwiCu5IIas2srqo9UR8/C+XAPiTzLWEugU6f7J26ws8dWsdX
	QVrvjMqbFDQWGV25BeNJ14/m8PBvhFi5S7wGfz7XDzQPgfEeT/nR5q7R2rFSY54V
	BKe5Iyu3ffHSWDvz81jDQJ3L7rOZyWrN8tP3hG4ihBjqfQWLO0suORudr2lPegmZ
	UlCTOjuMWHTDnJngduMuW+XEUuJQvxr9Jg7nU0ITIA==
X-ME-Sender: <xms:Z_oOZ3BUVLyazgwf1l1HvM-FCQww-IHLXNl9UrYK4_O5sooUM9jF3Q>
    <xme:Z_oOZ9iv-jJoNYA_somaHHodlkvTWaxRBfz134I9BAvlJnl8R3aHxXf_w_HH7fpCp
    5l7rP8ITFCYfMXyqc8>
X-ME-Received: <xmr:Z_oOZylHOVG6w6ZcPWsY0sKF2cmo_8_l0fQlHPJP6GxwjqjNMHvjDmSAFprfKvKZmJegfVwTyCugiBofNbcXXhI8uuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosgho
    rhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevle
    eifefgjeejieegkeduudetfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtg
    hpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsght
    rhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqth
    gvrghmsehfsgdrtghomhdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:Z_oOZ5yOAXg9ayaiZrgzbC9p4xyPF13R_HalUtiDmJDNk-Iu1LS2Ng>
    <xmx:Z_oOZ8Sk3XqmGT64jjWMCGpQ7gbeMPFp7yP0nmaW51JIGPkkIPwM3w>
    <xmx:Z_oOZ8bb_c-GVFWNZ8FNi7jUJAbdS1zfnMaGkBALaOB6v2WlOLlM6g>
    <xmx:Z_oOZ9QIsGPHtnLtwugKr3sNMMpKfbnvS9sgNFgvs2oaJ-8PTwd6Qg>
    <xmx:Z_oOZye0fx4oBVPPetfwCesufWZje_AGG2wsIPZSvm2OC6MFgmsQDHYB>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 19:27:35 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2] btrfs: add test for cleaner thread under seed-sprout
Date: Tue, 15 Oct 2024 16:27:12 -0700
Message-ID: <9925ac0001b867a523a8c9c838536b50c2b19348.1729034727.git.boris@bur.io>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a longstanding bug that creating a seed sprout fs with the
ro->rw transition done with

mount -o remount,rw $mnt

instead of

umount $mnt
mount $sprout_dev $mnt

results in an fs without BTRFS_FS_OPEN set, which fails to ever run the
critical btrfs cleaner thread.

This test reproduces that bug and detects it by creating and deleting a
subvolume, then triggering the cleaner thread. The expected behavior is
for the cleaner thread to delete the stale subvolume and for the list to
show no entries. Without the fix, we see a DELETED entry for the subvol.

Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
- update to real copyright info
- add extra rw->ro transition checks
- remove unnecessary _require_test
---
 tests/btrfs/323     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/323.out |  2 ++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/btrfs/323
 create mode 100644 tests/btrfs/323.out

diff --git a/tests/btrfs/323 b/tests/btrfs/323
new file mode 100755
index 000000000..ca57b1a1e
--- /dev/null
+++ b/tests/btrfs/323
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 323
+#
+# Test that remounted seed/sprout device FS is fully functional. For example, that it can purge stale subvolumes.
+#
+. ./common/preamble
+_begin_fstest auto quick seed remount
+
+. ./common/filter
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_scratch_dev_pool 2
+
+_fixed_by_kernel_commit XXXXXXXX \
+	"btrfs: do not clear read-only when adding sprout device"
+
+_scratch_dev_pool_get 2
+dev_seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+dev_sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
+
+# create a read-only fs based off a read-only seed device
+_mkfs_dev $dev_seed
+$BTRFS_TUNE_PROG -S 1 $dev_seed
+_mount $dev_seed $SCRATCH_MNT >>$seqres.full 2>&1 
+_btrfs device add -f $dev_sprout $SCRATCH_MNT >>$seqres.full
+
+# switch ro to rw, checking that it was ro before and rw after
+findmnt -n -O rw $SCRATCH_MNT
+_mount -o remount,rw $SCRATCH_MNT
+findmnt -n -O ro $SCRATCH_MNT
+
+# do stuff in the seed/sprout fs
+_btrfs subvolume create $SCRATCH_MNT/subv
+_btrfs subvolume delete $SCRATCH_MNT/subv
+
+# trigger cleaner thread without remounting
+_btrfs filesystem sync $SCRATCH_MNT
+
+# expect no deleted subvolumes remaining
+$BTRFS_UTIL_PROG subvolume list -d $SCRATCH_MNT
+
+_scratch_dev_pool_put
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
new file mode 100644
index 000000000..5dba9b5f0
--- /dev/null
+++ b/tests/btrfs/323.out
@@ -0,0 +1,2 @@
+QA output created by 323
+Silence is golden
-- 
2.46.0


