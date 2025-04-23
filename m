Return-Path: <linux-btrfs+bounces-13316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24DBA98CC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBC818875A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738EF280CEE;
	Wed, 23 Apr 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ6g6Tg5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DC280A5C
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418026; cv=none; b=jqZg4OQTK3KNmvV9kjQ7IR4Nt9MKww/Bfspg1cz6LdvDs70aOtGRbbhqb2KewSJGHWRiRsdSxAfzFNPW3wAeXHHFa37ZXeD1ouvs2Nv88KNtOzgFDvWlJk6ahncf+jL7uuzRkJy4y9hX6ztnYdrlH+oEom2+eujrwU9aBF7pHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418026; c=relaxed/simple;
	bh=jOgPEEHMpKZQhisZ/PFz4w7soNhyq6jZpP87n/2FPBQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GpD8Kz5JfdUv7pPz0Qxn25iB1dL0yIBZ9l2QXOp8jeki1TWLebxc3uKt4dD+fk9vE1lelLO5Sjhcv5pZd05gwGnXmzkM8Ny4HL+vIMIBaXgT5Kb3GRJv29FaFSp41CAMzPMy1KEaEjZDMxb8DBSgoMRlN8HyvtyBjm3kfJV70x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ6g6Tg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0F9C4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418026;
	bh=jOgPEEHMpKZQhisZ/PFz4w7soNhyq6jZpP87n/2FPBQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nZ6g6Tg5LSHZDtJOSotz3E3R/NbZKydzZJW7D9NSH47hJ/TdHDhWKaHB0hmZMDvjd
	 xm7LP2l9Ib5mGqP6mVMv5Bk/atWn16sOA4d1/HdR4pQ5m16X7zxPa4I16K0kzxdubs
	 Radb+1ZfpBlNFK6Zwof9rxYtTpxrHxuDpw4sQYVdOhDDWmZJpxakvg3c/KJERGI2IO
	 IgSz9SAR6VZc5F/V1PWxhulf58LQfb9HBl99UqdxwvGZ/ei2DsWOcHKMZHESaYls1j
	 fwAlCezLuCbjnFr/EOFAReph2umhAa5LkNOksTILlugT5cIUHAtZQjr7UE6OiLWQvh
	 oiI/aViihj33Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 20/22] btrfs: don't BUG_ON() when unpinning extents during transaction commit
Date: Wed, 23 Apr 2025 15:20:00 +0100
Message-Id: <50515568e31194778d278585beeaa9fe2ec1b3d6.1745401628.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In the final phase of a transaction commit, when unpinning extents at
btrfs_finish_extent_commit(), there's no need to BUG_ON() if we fail to
unpin an extent range. All that can happen is that we fail to return the
extent range to the in-memory free space cache, meaning no future space
allocations can reuse that extent range while the fs is mounted.

So instead return the error to the caller and make it abort the
transaction, so that the error is noticed and prevent misteriously leaking
space. We keep track of the first error we get while unpinning an extent
range and keep trying to unpin all the following extent ranges, so that
we attempt to do all discards. The transaction abort will deal with all
resource cleanups.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
 fs/btrfs/transaction.c |  4 +++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a68a8a07caff..190bde099ee8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2821,6 +2821,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	struct extent_io_tree *unpin;
 	u64 start;
 	u64 end;
+	int unpin_error = 0;
 	int ret;
 
 	unpin = &trans->transaction->pinned_extents;
@@ -2841,7 +2842,22 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 
 		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);
 		ret = unpin_extent_range(fs_info, start, end, true);
-		BUG_ON(ret);
+		/*
+		 * If we get an error unpinning an extent range, store the first
+		 * error to return later after trying to unpin all ranges and do
+		 * the sync discards. Our caller will abort the transaction
+		 * (which already wrote new superblocks) and on the next mount
+		 * the space will be available as it was pinned by in-memory
+		 * only structures in this phase.
+		 */
+		if (ret) {
+			btrfs_err_rl(fs_info,
+"failed to unpin extent range [%llu, %llu] when committing transaction %llu: %s (%d)",
+				     start, end, trans->transid,
+				     btrfs_decode_error(ret), ret);
+			if (!unpin_error)
+				unpin_error = ret;
+		}
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 		btrfs_free_extent_state(cached_state);
 		cond_resched();
@@ -2888,7 +2904,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		}
 	}
 
-	return 0;
+	return unpin_error;
 }
 
 /*
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 39e48bf610a1..3c00666871da 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2555,7 +2555,9 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	wake_up(&cur_trans->commit_wait);
 	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
 
-	btrfs_finish_extent_commit(trans);
+	ret = btrfs_finish_extent_commit(trans);
+	if (ret)
+		goto scrub_continue;
 
 	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &cur_trans->flags))
 		btrfs_clear_space_info_full(fs_info);
-- 
2.47.2


