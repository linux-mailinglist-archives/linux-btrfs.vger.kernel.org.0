Return-Path: <linux-btrfs+bounces-12772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C90A7ABC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 21:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58F4188DA33
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9495E267715;
	Thu,  3 Apr 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A26jYcGU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC8E2676FE;
	Thu,  3 Apr 2025 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707132; cv=none; b=F4CfvVRHv8n3hXRFmD3bJk4T4YvTeKbZROl34/vPgygW/ydrpYNv1YfYuq27a7k9ej9xjmOEyuA/0+wmJcamXHmPijCYRciQIxgpwa1crXvSaBGy+KGVcLA/3+6cY57s4U9lHrr39+F22Yq1IHMva4Np5GL8kf9uFcwrCn7vOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707132; c=relaxed/simple;
	bh=zt5igv9MTGiNl0AapQuX7uxADFwXI+02OPUa1CK0BRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETQjQXMLev10ZddzdaZ6eB9/1lRycYAl4X2h5Dvx61ugvaz83qAkiVTnjdXLB05g10tjOklwgBA3HSJbnCgSVaNa4r4/jBHLsy2pxI4cw4DGko6czFVZ0rY87rnGIoMg9YWqv02tqDdANWG1rXAfz7TejtzYvIgmeEg7dOKT33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A26jYcGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDB3C4CEE9;
	Thu,  3 Apr 2025 19:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707132;
	bh=zt5igv9MTGiNl0AapQuX7uxADFwXI+02OPUa1CK0BRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A26jYcGUnhOFGN9m1TPI/wIxouivFRKRpW1FiVnuc+tuV/WLHZZGb2HxeoNgtY8MQ
	 pHRAtoJxKnNK1stR2kFotPCc8vwLF5GHU5VBVaCaMhRHFbaRZIMHILg47tgYmkkkeH
	 gwcY12PZSxH9q8kMpz6OqfDKGvmLkXkpkommLFpERLrUh7P6NWNHUr1QiQfemKsesA
	 HUKFkUhyNfNw9b7T9tsbC06WXlC29QZXOTIBZJKf4ZAHZ+cJYpxj+FhsSVyxC8NeN8
	 YFrtaQdiABZ1bnqNAoLAE4J1wH3Emtn89jn5xkAi/8GNt01VCEb2fF6N7IQq+kM/XS
	 Qc3uq/mdDeBYA==
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
Subject: [PATCH AUTOSEL 6.13 37/49] btrfs: harden block_group::bg_list against list_del() races
Date: Thu,  3 Apr 2025 15:03:56 -0400
Message-Id: <20250403190408.2676344-37-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 3c6f7fecbb9aa..840e7959b0772 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2873,7 +2873,15 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
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
index 914a22cc950b5..7c789b4b946b3 100644
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
@@ -2097,7 +2103,13 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
 
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


