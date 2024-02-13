Return-Path: <linux-btrfs+bounces-2353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B70A8534DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDA3284FED
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BF5F47C;
	Tue, 13 Feb 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5Yh4C8N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1F5DF26
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838681; cv=none; b=W6J3tl6LZckG1wCkhSgnU4PQrUv+dmjnzQPhjh4TAhdc+vfXW0g4nCVkJQ8o+75E+SR66YdIPsTQuNVBtr7ce49GMu/H3RsUhu1foocAHIASK/qZn5R+djMHu5yPE0Qz7+3VeN8lquX9110HN1/5g8VHI5YwtThoghcfAEWjuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838681; c=relaxed/simple;
	bh=APAnNnSZEu2tAdZ8FXp6euZsBRfdtVzAixVm73Wqxg8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LErBLRkhsJaQU/Ilchfl8273Dv0M72hef27GfHjBtAQufeBdui7/mIJy6VMYMM9nVu6l83gSpsl48YjrzaFNoM12y9lnd2/h4wFf7RutsNxcPFGq5SHPuro/uCeBb+FRGZVQWKF7UGOaOY0VmHCSH6KmyaYOv3Tfu8avc7B/6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5Yh4C8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32779C43390
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838680;
	bh=APAnNnSZEu2tAdZ8FXp6euZsBRfdtVzAixVm73Wqxg8=;
	h=From:To:Subject:Date:From;
	b=C5Yh4C8NFawMhkcglV/QYvAakmyzC/Kg8iMLKRk+XGGxdhIkQkWC9umG1oqi6rsZ9
	 M27ggdEp1CbjEuf8NsU7XnMoQMg9bCdLh/aiCS89uJNTYCF/dRafarefuGowq7LnGK
	 ZWmF/8YoB7CQhOfohtcQQONL0IakjuN8ViagG34v35+7snYi+z7S4p050PJTju0QV6
	 gmCfAR2ojR7lU7FlG30cXJI1K5bx/KlxDpfASiZfQJjqaTaNOpdVLrtHTE+1FdQFGj
	 9oj2QZ11LEKc0UgBB2EFbaG5vucolJ4nIZIohD9B12Y1vLNXoMTC0HS5xzf5Ir1sP2
	 YU7U79+K6XT3A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove no longer used btrfs_transaction_in_commit()
Date: Tue, 13 Feb 2024 15:37:57 +0000
Message-Id: <00e9779bc56f516852e1488cc89403ca2d7d3a7c.1707838285.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The function btrfs_transaction_in_commit() is no longer used, its last
use was removed in commit 11aeb97b45ad ("btrfs: don't arbitrarily slow
down delalloc if we're committing"), so just remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 13 -------------
 fs/btrfs/transaction.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3575b2bf3042..6c201bdbaac7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1957,19 +1957,6 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
 		super->uuid_tree_generation = root_item->generation;
 }
 
-int btrfs_transaction_in_commit(struct btrfs_fs_info *info)
-{
-	struct btrfs_transaction *trans;
-	int ret = 0;
-
-	spin_lock(&info->trans_lock);
-	trans = info->running_transaction;
-	if (trans)
-		ret = (trans->state >= TRANS_STATE_COMMIT_START);
-	spin_unlock(&info->trans_lock);
-	return ret;
-}
-
 int btrfs_transaction_blocked(struct btrfs_fs_info *info)
 {
 	struct btrfs_transaction *trans;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 681109c5f441..4e451ab173b1 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -277,7 +277,6 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 				struct extent_io_tree *dirty_pages, int mark);
 int btrfs_wait_tree_log_extents(struct btrfs_root *root, int mark);
 int btrfs_transaction_blocked(struct btrfs_fs_info *info);
-int btrfs_transaction_in_commit(struct btrfs_fs_info *info);
 void btrfs_put_transaction(struct btrfs_transaction *transaction);
 void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
-- 
2.40.1


