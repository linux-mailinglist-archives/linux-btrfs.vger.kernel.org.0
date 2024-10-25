Return-Path: <linux-btrfs+bounces-9171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055CD9B0BA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 19:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BD11C21DC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 17:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14FB216DF9;
	Fri, 25 Oct 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHnYBJva"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E41718BC27;
	Fri, 25 Oct 2024 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877068; cv=none; b=pqTzGv/uzOyZrJxRTgZzLxP3jiasPfOQDo3Qu0vbqeEbcMLXU+OSvZIj9aJMFha/Ov6SjO0DTvdf3FYiOKtfeHDEEIYs3vEE9RlJkKd2XWqtJijOB9LczzsuHD1MmNh2QREqjv0QvcdHq1rYbDljaxD52X1xctjHY9QEulBZSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877068; c=relaxed/simple;
	bh=CcxmlaSs8ta9an8mZQTlX/JcFq/8aMT8URIvjFeAwXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IW8aRGsdO4/Dy7r1FkrBJ3YrV5FDHOid/bL516/83bu1Umw94yAdlGh/9TqYGX+eEAvBIfuJvxK133x3QsmoAhgX9GWKBEN9QZc+FI8uYTO43m+8xtHpvVusYGbCG/lftLX1Eka+mQMYh+73nrPmgtom8K64aSrdgPachsZFF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHnYBJva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDD6C4CEC3;
	Fri, 25 Oct 2024 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729877067;
	bh=CcxmlaSs8ta9an8mZQTlX/JcFq/8aMT8URIvjFeAwXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHnYBJvayiqQ9NGEqtTlHnM6HmkKPKEfCILStUJ/Tfqe9rm18C6+GAzI4O0UDqFZB
	 KufuTOQqWJTzGzdPCvH8nj9gxVWgfCzjrsrSU9x4ysudaAjFQBnsPzlklrOTbiPI7Q
	 mVZVHYrlONdHiYgrnm42jV854BFtsq8Vz5mIAw++h/cV8m/w7YXIQxz4snbMze5sb/
	 NYiReuQMf6tJtH9hfYxUF706UPo+TuBHJuEGuA7RszBkoM8juvbcWGG7ckjSpN9tWY
	 rlCPfYLxJT8IF8Vsob+WwF3vfaxqfPvZzXPjXFUvihNJqNMDszwJu2g+86jfhrLBCH
	 pdnPs6hKL37hA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: test remount with "compress" clears "compress-force"
Date: Fri, 25 Oct 2024 18:24:21 +0100
Message-ID: <965c0f0b02fbf9d314c2a7192a65e5fd5c0afe53.1729876932.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c0bbe053db28eb35daf4061bf832278305f9656c.1729855555.git.fdmanana@suse.com>
References: <c0bbe053db28eb35daf4061bf832278305f9656c.1729855555.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that remounting with the "compress" mount option clears the
"compress-force" mount option previously specified.

This tests a regression introduced with kernel 6.8 and recently fixed by
the following kernel commit:

  3510e684b8f6 ("btrfs: clear force-compress on remount when compress mount option is given")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Use findmnt instead of "mount | grep $SCRATCH_DEV".

 tests/btrfs/323     | 39 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/323.out |  2 ++
 2 files changed, 41 insertions(+)
 create mode 100755 tests/btrfs/323
 create mode 100644 tests/btrfs/323.out

diff --git a/tests/btrfs/323 b/tests/btrfs/323
new file mode 100755
index 00000000..5cafa4b2
--- /dev/null
+++ b/tests/btrfs/323
@@ -0,0 +1,39 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# Test that remounting with the "compress" mount option clears the
+# "compress-force" mount option previously specified.
+#
+. ./common/preamble
+_begin_fstest auto quick mount remount compress
+
+_require_scratch
+
+_fixed_by_kernel_commit 3510e684b8f6 \
+	"btrfs: clear force-compress on remount when compress mount option is given"
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount -o compress-force=zlib:9
+
+# Confirm we have compress-force with zlib:9
+grep -wq 'compress-force=zlib:9' <(findmnt -rncv -S $SCRATCH_DEV -o OPTIONS)
+if [ $? -ne 0 ]; then
+	echo "compress-force not set to zlib:9 after initial mount:"
+	findmnt -rncv -S $SCRATCH_DEV -o OPTIONS
+fi
+
+# Remount with compress=zlib:4, which should clear compress-force and set the
+# algorithm to zlib:4.
+_scratch_remount compress=zlib:4
+
+grep -wq 'compress=zlib:4' <(findmnt -rncv -S $SCRATCH_DEV -o OPTIONS)
+if [ $? -ne 0 ]; then
+	echo "compress not set to zlib:4 after remount:"
+	findmnt -rncv -S $SCRATCH_DEV -o OPTIONS
+fi
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
new file mode 100644
index 00000000..5dba9b5f
--- /dev/null
+++ b/tests/btrfs/323.out
@@ -0,0 +1,2 @@
+QA output created by 323
+Silence is golden
-- 
2.43.0


