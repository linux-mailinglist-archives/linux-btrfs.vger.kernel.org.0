Return-Path: <linux-btrfs+bounces-11698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1893A3F4BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 13:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D72E860D90
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E9720A5D1;
	Fri, 21 Feb 2025 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8ClqXCR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603B61EE00E;
	Fri, 21 Feb 2025 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740142490; cv=none; b=KLMrHS0j4QQm1QxJUAolZ0RlCdQGfud2ffXS5tUPKBxAAU5PEW3Dh393r6jqzSEIsQu/lG69yxw2UjwGY89NLuX4PVr/0z8ziUVYkLWSBtw/m7bmbJipKkVjaH6PP+PCJAjcWu2cKD2Jjy5/2CSffgMH9CiSCkrGcrkmBGao3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740142490; c=relaxed/simple;
	bh=PcUS/83HjBOY6GsNbTD/RmobTvvq1zbmZ3d6BroLlO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYp0/VKe0K8FxF2ti9aQw7S0bZVJ9u3qiHbVDPZsbq6gFWmzszWizcCo2HCLk2LDzA9zT4kOgdVqHDV19n0tjdWDDBaVZHgKeZ7qNL9KWQgGFHgI9CUsf+1AW9VQnKMBOJHDqE4IzYLLILAaUQZb9vGSbYvGrLvCTYTmWIJ/6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8ClqXCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABF9C4CED6;
	Fri, 21 Feb 2025 12:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740142489;
	bh=PcUS/83HjBOY6GsNbTD/RmobTvvq1zbmZ3d6BroLlO4=;
	h=From:To:Cc:Subject:Date:From;
	b=o8ClqXCRizWDwkk5dSs7fH3VSYae0/vYTKg5sls0ZOeYNTBfq0m12z2Hw7CU28cCj
	 HIG+AYNISbOfUUEc89Pd4PWzYasOze33GBnzwwZ+0E+r4U3Etts9h/ONT+X4plIfRp
	 iQaTO3qgEfMewU4r6cAJY5CUAgFnNVyYpNn05i7i+AcPuLy/t3/X9s4GjuurEHtouC
	 ZYZoFCk0sQuHPr10HqihBpyqwvhEJIMRmedza8Uh1jOcXfGxQ07sCvzIozGtxi4+rl
	 mUwijXk44Q5AiKfntBgG0LT/dakflbjE60I+0LYDHS85l4lMyhVzsil/S/1dFHIcg2
	 rhcY3Iq/6uXkw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: add commit IDs for kernel patches that are already in Linus' tree
Date: Fri, 21 Feb 2025 12:54:43 +0000
Message-ID: <4ba5443a5789880423ce3b90406a12314626e349.1740142425.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Update a few tests to refer to the commit IDs of patches that were already
merged into Linus' tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/323   | 2 +-
 tests/btrfs/326   | 2 +-
 tests/btrfs/330   | 2 +-
 tests/generic/562 | 2 +-
 tests/xfs/273     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/323 b/tests/btrfs/323
index b7421f6e..08ebf194 100755
--- a/tests/btrfs/323
+++ b/tests/btrfs/323
@@ -13,7 +13,7 @@ _begin_fstest auto quick seed remount volume
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_scratch_dev_pool 2
 
-_fixed_by_kernel_commit XXXXXXXX \
+_fixed_by_kernel_commit 70958a949d85 \
 	"btrfs: do not clear read-only when adding sprout device"
 
 _scratch_dev_pool_get 1
diff --git a/tests/btrfs/326 b/tests/btrfs/326
index 1fc4db06..7e6e7b77 100755
--- a/tests/btrfs/326
+++ b/tests/btrfs/326
@@ -15,7 +15,7 @@ _fixed_by_kernel_commit 951a3f59d268 \
 
 # Another rare bug exposed by this test case where mnt_list list corruption or
 # extra kernel warning on MNT_ONRB flag is triggered.
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 344bac8f0d73 \
 	"fs: kill MNT_ONRB"
 
 _cleanup()
diff --git a/tests/btrfs/330 b/tests/btrfs/330
index 92cc498f..3a311a5a 100755
--- a/tests/btrfs/330
+++ b/tests/btrfs/330
@@ -19,7 +19,7 @@ _cleanup()
 
 $MOUNT_PROG -V | grep -q 'fd-based-mount'
 if [ "$?" -eq 0 ]; then
-	_fixed_by_kernel_commit xxxxxxxxxxxx \
+	_fixed_by_kernel_commit cda7163d4e3d \
 		"btrfs: fix per-subvolume RO/RW flags with new mount API"
 fi
 
diff --git a/tests/generic/562 b/tests/generic/562
index 36bd0291..03a66ff2 100755
--- a/tests/generic/562
+++ b/tests/generic/562
@@ -16,7 +16,7 @@ _begin_fstest auto clone punch
 . ./common/reflink
 
 test "$FSTYP" = "xfs" && \
-	_fixed_by_kernel_commit XXXXXXXXXX "xfs: don't drop errno values when we fail to ficlone the entire range"
+	_fixed_by_kernel_commit 7ce31f20a077 "xfs: don't drop errno values when we fail to ficlone the entire range"
 
 _require_scratch_reflink
 _require_test_program "punch-alternating"
diff --git a/tests/xfs/273 b/tests/xfs/273
index 9f11540a..7e743179 100755
--- a/tests/xfs/273
+++ b/tests/xfs/273
@@ -24,7 +24,7 @@ _require_scratch
 _require_populate_commands
 _require_xfs_io_command "fsmap"
 
-_fixed_by_kernel_commit XXXXXXXXXXXXXX "xfs: fix off-by-one error in fsmap"
+_fixed_by_kernel_commit a440a28ddbdc "xfs: fix off-by-one error in fsmap"
 
 rm -f "$seqres.full"
 
-- 
2.45.2


