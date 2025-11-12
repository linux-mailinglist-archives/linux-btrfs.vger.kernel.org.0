Return-Path: <linux-btrfs+bounces-18893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD2C52610
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 14:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A80654EC76D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66670336EFF;
	Wed, 12 Nov 2025 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+7E6nmI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7C33557B;
	Wed, 12 Nov 2025 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952520; cv=none; b=OOqhTRZKKuPF/kMjprs4w2Fx3+Stw27eAP/PQ9TjVOiaJe3TEtnVG7PF7Qi/DzjtXUhp7zoTcZgNvSF6P4ZcpDaRUJ2Aou0oBy+F23Y3j8T3N7gen2xiyWS8xg6RN5xvtFRFTCDuQASyghptq4tmD5ju3RpGIyFlxbkUrITcrIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952520; c=relaxed/simple;
	bh=tmpmS4hYp0yttGcr5QrOJmbu3JaaJWOIiD9pK9G+jKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tksd0JakSYNT2n8Uq1uag2ttKe0ZQBEwGUrC+I9OJPBPwa78Z+NSd3+YDxMZqvk/XTkR6ipUNCCLs4jTZcIH0UME+JernBYboUeBKmud9Txrb6BQklWJI4RcHgSutrnNK29SjIqFAQr0Ii2ty8AyH6MBGPLBcAfNZJieFnj9j2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+7E6nmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F349C16AAE;
	Wed, 12 Nov 2025 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762952520;
	bh=tmpmS4hYp0yttGcr5QrOJmbu3JaaJWOIiD9pK9G+jKM=;
	h=From:To:Cc:Subject:Date:From;
	b=O+7E6nmIH5oMy9NPYEANboPoYP8XTh5pmCef3FCUsmGj1M+HbH51RKbopethYKF7z
	 mpdB4gANdv7MhQcB40H/k0QouOkKpw5CtdeJeXTJgWDHt6kCkuLmpBh89G5+1xGlVj
	 H3xCH+SH9IBm+r9VLlP1WCvNxHe1Rnf8aS1ZBVb8dHAyN+D5TQYbHaH6s0MEZ6HJJq
	 kUkmJLCd6qaSbYKUvtCDmibT0Wku9YgG35RDT5n4ThZ7LDqiZrvm/ureu62fJ6zHrV
	 x5cWOGjh4j67AuDA4hnKcErij7T9+ZUMMlc+SU0Do3BtRPEmHo0MvQw2d8U2Ck7/rg
	 QOyXOihxY01RQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: add kernel commit IDs to some tests that miss it
Date: Wed, 12 Nov 2025 13:01:51 +0000
Message-ID: <e167d491435cbb02c671c974d7a2f80613f1c487.1762952458.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Kernel patches for some tests are now in Linus' tree, so update their
commit IDs and for btrfs/301 fix the commit subject since it was changed
before being sent to Linus.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/301   | 4 ++--
 tests/btrfs/337   | 2 +-
 tests/f2fs/018    | 2 +-
 tests/generic/779 | 2 +-
 tests/generic/782 | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 4b51a273..f1f33cd9 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -21,8 +21,8 @@ _require_no_compress
 
 _fixed_by_kernel_commit 7b632596188e \
 	"btrfs: fix iteration bug in __qgroup_excl_accounting()"
-_fixed_by_kernel_commit XXXXXXXXXXXX \
-	"btrfs: fix squota _cmpr stats leak"
+_fixed_by_kernel_commit de134cb54c3a \
+	"btrfs: fix squota compressed stats leak"
 
 subv=$SCRATCH_MNT/subv
 nested=$SCRATCH_MNT/subv/nested
diff --git a/tests/btrfs/337 b/tests/btrfs/337
index a57df1de..e6db3cd6 100755
--- a/tests/btrfs/337
+++ b/tests/btrfs/337
@@ -9,7 +9,7 @@
 . ./common/preamble
 _begin_fstest auto quick compress clone
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 9786531399a6 \
 	"btrfs: fix corruption reading compressed range when block size is smaller than page size"
 
 . ./common/reflink
diff --git a/tests/f2fs/018 b/tests/f2fs/018
index 2373129b..f0cbed2d 100755
--- a/tests/f2fs/018
+++ b/tests/f2fs/018
@@ -13,7 +13,7 @@ _begin_fstest auto quick rw compress
 
 _fixed_by_kernel_commit ba8dac350faf \
 	"f2fs: fix to zero post-eof page"
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 0b2cd5092139 \
 	"f2fs: fix to zero data after EOF for compressed file correctly"
 
 _require_xfs_io_command "truncate"
diff --git a/tests/generic/779 b/tests/generic/779
index 40d1a86c..842472ae 100755
--- a/tests/generic/779
+++ b/tests/generic/779
@@ -24,7 +24,7 @@ _require_scratch
 _require_symlinks
 _require_dm_target flakey
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 953902e4fb4c \
 	"btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
 
 rm -f $seqres.full
diff --git a/tests/generic/782 b/tests/generic/782
index a85959a4..13c729d2 100755
--- a/tests/generic/782
+++ b/tests/generic/782
@@ -25,7 +25,7 @@ _cleanup()
 _require_scratch
 _require_dm_target flakey
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit bfe3d755ef7c \
 	"btrfs: do not update last_log_commit when logging inode due to a new name"
 
 _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
-- 
2.47.2


