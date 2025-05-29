Return-Path: <linux-btrfs+bounces-14297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35637AC7C71
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E15B1BC26B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32828E606;
	Thu, 29 May 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5mc3Ir/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29828E5E7;
	Thu, 29 May 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517231; cv=none; b=AuVpVQJP8i+tWYaB73Baw0PiFDB3JsTxDxGTeRb4PNP+NTcIT6VBt81yjtKxmz3t22ZAYjsQ6xaBQM/OodhuXaLT0GtCS2an4qea6A2c0mK2AZVslBQE71y9xP8zdF6upyIR2tDhPD39Ssq+NA7x8vjtQz16EtLtIQSzBQo0u6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517231; c=relaxed/simple;
	bh=m4lUknICkIllSrRu78Dk49hH4yfIukhR/P204gUtdwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f74rp7kDoHkrLswNRoE3brVBjUa5QdPJp6ovGw3L171kK+m9BqQNxVMhEaFKUX4kgMC1ogRY79n2ot+/zk+NF0Uo21ZeUrgVUe8z/IBF73+Y9DjPXgmHjRCydUeTOcVUlfqStzHNU6QotWeDs1BxrJkX/jz1smSxE0+RbqAnjTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5mc3Ir/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AF4C4CEEB;
	Thu, 29 May 2025 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748517230;
	bh=m4lUknICkIllSrRu78Dk49hH4yfIukhR/P204gUtdwg=;
	h=From:To:Cc:Subject:Date:From;
	b=k5mc3Ir/ngu5KJyVzxb2A9MzyTJQ+HuZyYOxlYNDt9yuObkFLFYMZ++BIi3dGw9to
	 Tb/qPAVfKuNbpnsKddKFPO6Uf9qaSBRBHg9Zl3a+HSpZs00QJjiV/feoIB/kFY5OuO
	 k6O0KLFek6M6J0SeAmzL3s/em6EhScMYA2PELd3GUWC8UZU++D9G5k6WD0w7v70cDb
	 kKiekIhVuomUSz49lCcFkXGdunS/cg+vNnEvbb4Aq8AZ/8SeLXxbWelw09D8CP/8eQ
	 XzTW9ic9jXdBjwfJlAdTPI230l4iSQXmNjRFyyeDHYLVLWQ+93HoAckXBUaom42TQ2
	 hvy4u+Dze6kRQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: add kernel commit IDs to some tests
Date: Thu, 29 May 2025 12:13:41 +0100
Message-ID: <df0a4c7749812f3dec49c2ec05c6da5c7b7e822f.1748517133.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The kernel fixes exercised by some tests have already landed in Linus'
tree, so update the tests with the respective commit IDs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/f2fs/011    | 2 +-
 tests/generic/370 | 2 +-
 tests/generic/761 | 3 ++-
 tests/generic/764 | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/f2fs/011 b/tests/f2fs/011
index ec3d39ec..c21cb586 100755
--- a/tests/f2fs/011
+++ b/tests/f2fs/011
@@ -23,7 +23,7 @@ _begin_fstest auto quick
 
 _fixed_by_kernel_commit 48ea8b200414 \
 	"f2fs: fix to avoid panic once fallocation fails for pinfile"
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit f7f8932ca6bb \
 	"f2fs: fix to avoid running out of free segments"
 
 _require_scratch
diff --git a/tests/generic/370 b/tests/generic/370
index cbc18644..d9ba6c57 100755
--- a/tests/generic/370
+++ b/tests/generic/370
@@ -21,7 +21,7 @@ _cleanup()
 
 [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 03018e5d8508 \
     "btrfs: fix swap file activation failure due to extents that used to be shared"
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 2d873efd174b \
 	"xfs: flush inodegc before swapon"
 
 _require_scratch_swapfile
diff --git a/tests/generic/761 b/tests/generic/761
index 9406a4b8..bd7b02a9 100755
--- a/tests/generic/761
+++ b/tests/generic/761
@@ -18,7 +18,8 @@ _begin_fstest auto quick
 _require_scratch
 _require_odirect
 _require_test_program dio-writeback-race
-_fixed_by_kernel_commit XXXXXXXX \
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 968f19c5b1b7 \
 	"btrfs: always fallback to buffered write if the inode requires checksum"
 
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/764 b/tests/generic/764
index 1b21bc02..55937fc0 100755
--- a/tests/generic/764
+++ b/tests/generic/764
@@ -20,7 +20,7 @@ _cleanup()
 
 . ./common/dmflakey
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 5e85262e542d \
 	"btrfs: fix fsync of files with no hard links not persisting deletion"
 
 _require_scratch
-- 
2.47.2


