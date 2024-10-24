Return-Path: <linux-btrfs+bounces-9136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593AC9AEBE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880671C22910
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273761F8193;
	Thu, 24 Oct 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIAWBdgT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C861F81AC
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787077; cv=none; b=eL68yMAoMs0tysjLYNzlI8jxAp2Fb5bDnB+HiegIb4v4EtYq9zOs5lkdXLBPb8y0Z2niCT1Ie5WLd1CWXAtWCj32oTn/6HGrGvAMEEb7yKARvoVKugJMHmNXb98l9GVEQtEXVd8URHXVP4D+qkakl3bercymjCUBA3XmrabF2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787077; c=relaxed/simple;
	bh=03BWRIt1zYx6CPcNbvvXdy6Zvw0GRgHVRWUMybXNClY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtIb9z+/++t20wGILyhTVGPrlV4+DxRpL9cHv2qwmHUz/Rr9m5uhj01ZeXNVQHBagaCQIOZ50gRrE87BWr+4AarFvCxhxpp4FWqOAgMEwUoLTnSP6hlxfbTH0IlEEveYTWZKL3GkXH65TO9/e7/UNJWZFpukewBkdeRTchOkeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIAWBdgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B55C4CEE5
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787077;
	bh=03BWRIt1zYx6CPcNbvvXdy6Zvw0GRgHVRWUMybXNClY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dIAWBdgTjlsQ1+q509CkZVF6veNCVPlGWE/L1g3Wj6TyZ0GfsMbxzJPdJNoKnSIAM
	 G5wy/SYiaz+LsoRI/+jaBGsYQZI9BDBwd6Pxj5AP/+0fHE/+45ay2JNBQbIqX6zJFP
	 ME37/gLxcOaQUSMa/UttrRkNJNn4AGvxMLmBBbJbxGMS7waWkyh2P5mzfbicFxTRE2
	 i07zisQyLShg2y7cdOFsqx5U93qaDVnOv0kGyfOV6OS/rqNTMrP4OJeGVjwR8ZEKRT
	 XZnLyxXoHSIOWWlJEgWJLrugDAYxjY6ddRkrfjq6sVf68YbpoapUMoPtX6mwBT8IsN
	 gdqF/wy6BRf1w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/18] btrfs: remove num_entries atomic counter from delayed ref root
Date: Thu, 24 Oct 2024 17:24:15 +0100
Message-Id: <b400edcf7f452fcce034c3b0a930198b05f01d3c.1729784713.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The atomic counter 'num_entries' is not used anymore, we increment it
and decrement it but then we don't ever read it to use for any logic.
Its last use was removed with commit 61a56a992fcf ("btrfs: delayed refs
pre-flushing should only run the heads we have"). So remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 4 ----
 fs/btrfs/delayed-ref.h | 5 -----
 fs/btrfs/extent-tree.c | 1 -
 fs/btrfs/transaction.c | 1 -
 4 files changed, 11 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 2b2273296246..2e14cfcb152e 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -463,7 +463,6 @@ static inline void drop_delayed_ref(struct btrfs_fs_info *fs_info,
 	if (!list_empty(&ref->add_list))
 		list_del(&ref->add_list);
 	btrfs_put_delayed_ref(ref);
-	atomic_dec(&delayed_refs->num_entries);
 	btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
 }
 
@@ -604,7 +603,6 @@ void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 
 	rb_erase_cached(&head->href_node, &delayed_refs->href_root);
 	RB_CLEAR_NODE(&head->href_node);
-	atomic_dec(&delayed_refs->num_entries);
 	delayed_refs->num_heads--;
 	if (!head->processing)
 		delayed_refs->num_heads_ready--;
@@ -630,7 +628,6 @@ static bool insert_delayed_ref(struct btrfs_trans_handle *trans,
 	if (!exist) {
 		if (ref->action == BTRFS_ADD_DELAYED_REF)
 			list_add_tail(&ref->add_list, &href->ref_add_list);
-		atomic_inc(&root->num_entries);
 		spin_unlock(&href->lock);
 		trans->delayed_ref_updates++;
 		return false;
@@ -901,7 +898,6 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		}
 		delayed_refs->num_heads++;
 		delayed_refs->num_heads_ready++;
-		atomic_inc(&delayed_refs->num_entries);
 	}
 	if (qrecord_inserted_ret)
 		*qrecord_inserted_ret = qrecord_inserted;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index cc78395f2fcd..a97c9df19ea0 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -216,11 +216,6 @@ struct btrfs_delayed_ref_root {
 	/* this spin lock protects the rbtree and the entries inside */
 	spinlock_t lock;
 
-	/* how many delayed ref updates we've queued, used by the
-	 * throttling code
-	 */
-	atomic_t num_entries;
-
 	/* total number of head nodes in tree */
 	unsigned long num_heads;
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e29024c66edb..9b588ce19a74 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2009,7 +2009,6 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		default:
 			WARN_ON(1);
 		}
-		atomic_dec(&delayed_refs->num_entries);
 
 		/*
 		 * Record the must_insert_reserved flag before we drop the
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e580c566f033..9ccf68ab53f9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -351,7 +351,6 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 
 	cur_trans->delayed_refs.href_root = RB_ROOT_CACHED;
 	xa_init(&cur_trans->delayed_refs.dirty_extents);
-	atomic_set(&cur_trans->delayed_refs.num_entries, 0);
 
 	/*
 	 * although the tree mod log is per file system and not per transaction,
-- 
2.43.0


