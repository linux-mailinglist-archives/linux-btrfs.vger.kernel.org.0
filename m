Return-Path: <linux-btrfs+bounces-10783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B255A04563
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C124F7A2FA2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CE127456;
	Tue,  7 Jan 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia3ncyLY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1B1F2C50;
	Tue,  7 Jan 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265742; cv=none; b=LFpET4fotaz647b++DaP8auV2in7wFhKZJdD1NAEJjCc3j0o/k0DOlKZKkQFe/F9EDwCLQwjrVjc/Gm+2M9SN33ZNu6Z6oZPt66NUWmxBUzmhXPjXA892WAVCyC5nTsodeHJ+YHG37T2FX8uf+dn1FGWoC5VNM2I2RIRVqCmfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265742; c=relaxed/simple;
	bh=eF0z1ZR0bKJopD86w39Zd25areqrIT+Gqik+ok62Wcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWnavmHz/M0eZR3izwJ3wto1JHBo+9Rdzh8ALlYcb743MbO+9YiWa1n1BBj+umHQ2DhWCUk7M/69rRT66qO40jNdWU/NE+y/idZh08NtW9oxQmriRZi/bI2L7RoBIf9bkbGHkA3k2v2l5/WjEPttNC3al+GmZGjNzoWYOG6GyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia3ncyLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545D0C4CED6;
	Tue,  7 Jan 2025 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736265742;
	bh=eF0z1ZR0bKJopD86w39Zd25areqrIT+Gqik+ok62Wcc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ia3ncyLYwc30YRsnWhu3LpWhr5uZVY+7j5U+8NXZqfwwci6i4SWqbj0csm4gK3Klo
	 K8M2oasuywkZSJSiOTnG8U1pjmKu2QUkCPOuTayba1A3FjlAUs+pTaWMvuvAR3rnOv
	 AOVwNqkNKKFsAhTIhmfNu8rHHkahltCZIFb8r8Xa9nyQkzqViA9xAIJ+3eLQ3ZQfnb
	 4/k/LdAZhhxIe25cbtJ/WV+Iqcp/MiNYIu8oB6TCmayw3ipF3tBN4Qxpi3Jz0WaP7o
	 j/oOlW9HjIGvJ6ghGif0ngVis1wYs3uVeMzx1CjLW465QS/A54BqosUDu4t/ECLeVM
	 vqMokIg8K18yw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test cycle mounting a filesystem right after enabling simple quotas
Date: Tue,  7 Jan 2025 16:02:11 +0000
Message-ID: <c4991049b54536bb7073f3c2118d12dae604d73d.1736265642.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that if we enable simple quotas on a filesystem and unmount it right
after without doing any other changes to the filesystem, we are able to
mount again the filesystem.

This is a regression test for the following kernel commit:

  f2363e6fcc79 ("btrfs: fix transaction atomicity bug when enabling simple quotas")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/328     | 31 +++++++++++++++++++++++++++++++
 tests/btrfs/328.out |  2 ++
 2 files changed, 33 insertions(+)
 create mode 100755 tests/btrfs/328
 create mode 100644 tests/btrfs/328.out

diff --git a/tests/btrfs/328 b/tests/btrfs/328
new file mode 100755
index 00000000..8e56c4d6
--- /dev/null
+++ b/tests/btrfs/328
@@ -0,0 +1,31 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 328
+#
+# Test that if we enable simple quotas on a filesystem and unmount it right
+# after without doing any other changes to the filesystem, we are able to mount
+# again the filesystem.
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup
+
+_fixed_by_kernel_commit f2363e6fcc79 \
+	"btrfs: fix transaction atomicity bug when enabling simple quotas"
+
+_require_scratch_enable_simple_quota
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+$BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
+
+# Without doing any other change to the filesystem, unmount it and mount it
+# again. This should work - we had a bug where it crashed due to an assertion
+# failure (when kernel config has CONFIG_BTRFS_ASSERT=y).
+_scratch_cycle_mount
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/328.out b/tests/btrfs/328.out
new file mode 100644
index 00000000..67faba8f
--- /dev/null
+++ b/tests/btrfs/328.out
@@ -0,0 +1,2 @@
+QA output created by 328
+Silence is golden
-- 
2.45.2


