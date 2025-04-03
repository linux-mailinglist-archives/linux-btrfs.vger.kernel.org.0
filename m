Return-Path: <linux-btrfs+bounces-12770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AD5A7AAA1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 21:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94363B52CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB5F25C706;
	Thu,  3 Apr 2025 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaiGOzT6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D625C6EE;
	Thu,  3 Apr 2025 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707024; cv=none; b=DJ3t1x+V9qNLzBUCvhmwX8rE9HNGshkRIe/lQcuUyrqANr326SmJx0nQQDlRZxRkgTtJ7Hd555a+xLIBe4IHuOG5OODI2mNA9i68IKgm8mjU9LO0nvr0+8zYs9KkPkmoEyHxI6eytR3+qCIZE7w36nYWrG06kVBWhXu3cAI08dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707024; c=relaxed/simple;
	bh=ocUmumNNqTn8lwXlmZIoT+GwMG8uU3C5LnKpYpZ+rKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IBXOTpP0xeff3QYxuyoQr6u0INsMMb7MlKXRODz8fgWvDV+3eSBRPbrhIghJbeBhwmyS2C3FJI4r7hH1JYo7DM82lpiu7XmJcCc8n8nHUm1qPJ71rIf2Wua4FcONhB/Zdrd1pg+lNgxYDRbyEF4Fr4ajbRkCFOmQQL/fXT78aVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaiGOzT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F49C4CEE9;
	Thu,  3 Apr 2025 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707024;
	bh=ocUmumNNqTn8lwXlmZIoT+GwMG8uU3C5LnKpYpZ+rKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MaiGOzT6YEDeOAHSFt5JFavP98pkaVYGuDEEC0uxMYLlc5/Qvv6wE7defhXXhWIuj
	 H9PIgQrVCLYa4oF/2gz8OFH3LmvsZaP0rTrds2gmgA/3w9ffIi/OuSCmcf6oMQ8wtf
	 AXP7rEGcADiJKv54hKh/UElK52Sx6BNNV2Vhe3xIAV1j4zKS0ASVraTzTXOQGReG/J
	 nhQ4c/nXaJOxKERWt6VFhwTk2DMdflBbpmLa9q/JZSggQ+KHqEL6H1dej3XHSh9smI
	 8spUUszMzwsTX2+qS31+NbWzsISPPJp0ipc1huI9LxISJTEuEO+G4XfuOTbx5A7hfZ
	 EVzq6QXYnIypw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 41/54] btrfs: harden block_group::bg_list against list_del() races
Date: Thu,  3 Apr 2025 15:01:56 -0400
Message-Id: <20250403190209.2675485-41-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 7511e29cf1355b2c47d0effb39e463119913e2f6 ]

As far as I can tell, these calls of list_del_init() on bg_list cannot
run concurrently with btrfs_mark_bg_unused() or btrfs_mark_bg_to_reclaim(),
as they are in transaction error paths and situations where the block
group is readonly.

However, if there is any chance at all of racing with mark_bg_unused(),
or a different future user of bg_list, better to be safe than sorry.

Otherwise we risk the following interleaving (bg_list refcount in parens)

T1 (some random op)                       T2 (btrfs_mark_bg_unused)
                                        !list_empty(&bg->bg_list); (1)
list_del_init(&bg->bg_list); (1)
                                        list_move_tail (1)
btrfs_put_block_group (0)
                                        btrfs_delete_unused_bgs
                                             bg = list_first_entry
                                             list_del_init(&bg->bg_list);
                                             btrfs_put_block_group(bg); (-1)

Ultimately, this results in a broken ref count that hits zero one deref
early and the real final deref underflows the refcount, resulting in a WARNING.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c |  8 ++++++++
 fs/btrfs/transaction.c | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3014a1a23efdb..6d615711f0400 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2874,7 +2874,15 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 						   block_group->length,
 						   &trimmed);
 
+		/*
+		 * Not strictly necessary to lock, as the block_group should be
+		 * read-only from btrfs_delete_unused_bgs().
+		 */
+		ASSERT(block_group->ro);
+		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
+		spin_unlock(&fs_info->unused_bgs_lock);
+
 		btrfs_unfreeze_block_group(block_group);
 		btrfs_put_block_group(block_group);
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index aca83a98b75a2..c0e9d4bbe380d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -160,7 +160,13 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 			cache = list_first_entry(&transaction->deleted_bgs,
 						 struct btrfs_block_group,
 						 bg_list);
+			/*
+			 * Not strictly necessary to lock, as no other task will be using a
+			 * block_group on the deleted_bgs list during a transaction abort.
+			 */
+			spin_lock(&transaction->fs_info->unused_bgs_lock);
 			list_del_init(&cache->bg_list);
+			spin_unlock(&transaction->fs_info->unused_bgs_lock);
 			btrfs_unfreeze_block_group(cache);
 			btrfs_put_block_group(cache);
 		}
@@ -2096,7 +2102,13 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
 
        list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_list) {
                btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
+		/*
+		* Not strictly necessary to lock, as no other task will be using a
+		* block_group on the new_bgs list during a transaction abort.
+		*/
+	       spin_lock(&fs_info->unused_bgs_lock);
                list_del_init(&block_group->bg_list);
+	       spin_unlock(&fs_info->unused_bgs_lock);
        }
 }
 
-- 
2.39.5


