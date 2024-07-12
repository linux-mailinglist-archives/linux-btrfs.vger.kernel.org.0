Return-Path: <linux-btrfs+bounces-6427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE4792FFD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 19:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BF22819BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EEA176AC0;
	Fri, 12 Jul 2024 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="D7CfMESX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bXNxTa/9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A511DFD2;
	Fri, 12 Jul 2024 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805704; cv=none; b=SbPXnRwgxFPubu4MfrX80hHY3i/hdSix/fY/eKRLFxX7y4PWROAu/bBWorgFgxuW6x8lQ5QISZW6SKu6TF0wlRjgneYgtYRMZ7eaLRMAVOLs08iQTBuVEmgWwnXgNn2yJBOC2DJ4ZwLYrwuU9IkATjXqB1aS0Mksk6zlsLq4tLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805704; c=relaxed/simple;
	bh=Q9Gj+9P6WLOysXjM9+CrsahqkLOLqdSL9sHm9t4NF2A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f9eITTDko/Pv+xUx4qthWAsmcIrGJNH6xczF6+OwSj16wzlRGpS+mKFvrp9i9rvr4kXqKRYjKypKOoJ94LDBSk65Z9KD5cg0g1zO0tk5f/cmObHbEswogc5yUn4SVcZIDlEEl8b8PW9Yy0T7kzVj8YF/3au9j2Zmo3L5UKV3A9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=D7CfMESX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bXNxTa/9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CDCA41140C69;
	Fri, 12 Jul 2024 13:35:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 12 Jul 2024 13:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1720805701; x=1720892101; bh=UrGjCD4XTVWx8Q7gkxE+y
	GaGl6pvTYS1zJtbq/3sjvY=; b=D7CfMESXwHOeLoCT7OW37xElk6U8MeswZ4qos
	CMHf2cTT6dRSFAz1V3J+fY9FsLhhvwrMaCL9KQ+5PiXoY59Q4XlwaxCLD7ffd/I6
	0Zlr5djTffMLCXvMQGdFDQ0rgsgy57psfdQjqWeWM06+E20mjhHULIZQcWCIYsbi
	5t79XpNKYn3oBMIUqkZ7X2NTGHvZfSp97BsI5W8LwOQhOpu1vZnZfddTNJxwsU10
	6VVqiWddkySwD7K+T/TVu5r0JFJ6GsvIKALsqJqzWUhE0Xu7epm5M/XmLLnp4zMb
	vqL+jlfFq50V2VGjR+IdAYSXqJEqNqvsmMSPeRRocoSctDOxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720805701; x=1720892101; bh=UrGjCD4XTVWx8Q7gkxE+yGaGl6pv
	TYS1zJtbq/3sjvY=; b=bXNxTa/9KZw6+x53xoZ9M9DPPcepJIPyIVRajv65mNRR
	nrGrznjjyzgmxOsMb8VQQlLDUn/pGkzWsY1LsqyL9aTYlv39wS0GRL8ZNs0MuEWb
	JEqnrpsPr9SqoPXwjsZRHmD6i0dz5osLAMBaNwtIHChgRD0fe20Ee1RyQvZ3w2rN
	S29BlwHyLjeWgdNJEJox60xI53JbLfN02NKrifiIOM6GDxvVg2xSCpoWx8rvd3Zu
	kMFu0GaraN4tGU2ZpiqBmG5yKfPF5QnpS4PNYWFZ7ezr4ueiWbeV0IWhejP7EaJb
	zu/ZqKJFL1WvW3Urr5uKcY+zqMYJ4uuVdS8vNVwrhw==
X-ME-Sender: <xms:RGmRZqe-Z8YJiYLPGHRFJO7zj0b4z03DIAzTGNf621HKb4VhYP0v4w>
    <xme:RGmRZkNTYItlXDMwzk_HRbcY8LJ7Mpco1oNQI3dgPISaCfPg5z67wQkWbgRbYzSoz
    F9TyC7ij5oVS4Cmylc>
X-ME-Received: <xmr:RGmRZrj99bW_lUbkph7O_kGYRiSFxA2D9YIRk0w0igmJfgXoeZe8BJVSG-E9oVwUfksNWRPbOFSNHJ6gxQgIx5-MN74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:RGmRZn_DMzYBqry_9bF4af6P8xy8ToppijssM3cz81Q__C4Dwskn1Q>
    <xmx:RGmRZmsbBi1sFmCiI6WAv5BG3kZUZojEs69FYDVoxLpF8MbSLG1h-w>
    <xmx:RGmRZuFqxjnrTnH5Um273Uunm5ks_0_mZrByfX6dty8Sc_SQnK7oyA>
    <xmx:RGmRZlM5i_UjDyAq6EIFhq68NJQWOxMrJuKpLrnthij5JKekrZlgAw>
    <xmx:RWmRZqLrIsbbps7j-U1La1_ONhUwHEz8KI7GwBEOgPwS76PgKIOYmtB_>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jul 2024 13:35:00 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v3] btrfs: add test for btrfstune squota enable/disable
Date: Fri, 12 Jul 2024 10:34:03 -0700
Message-ID: <70a2aa49c64b3c69d220f35bacbbba66c4ec4568.1720805527.git.boris@bur.io>
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
index 000000000..54557857e
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
+$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV | grep -v 'created qgroup for'
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
+$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV
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


