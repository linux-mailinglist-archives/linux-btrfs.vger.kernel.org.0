Return-Path: <linux-btrfs+bounces-2586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAD285BBF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 13:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65B5B22564
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3E46995E;
	Tue, 20 Feb 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEs3KDkF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70DE67C7D
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431883; cv=none; b=RyTuj8heySdV0jjTIl6dShm/6JlnliE73yNkOZTEO0/P37hO3E2UhO2ACSXc1+ZeWcUMdc+YMpQqWAVk9rElO+XKbe+RsEpUd70s1mSVXcEQkIOS5SeznVy5XBocPKeKHlV1qgpqWIT01L7IUV85ZLVblcFP24SUrqlq9Hw9e4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431883; c=relaxed/simple;
	bh=Db2zZfagtc5SUyxU9Vw51XrWEwAxgPwVxq9qaOlY20U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWsl2v0KmRkFaX9Um572N9fzMbon616wv63n1G/XQDK9Z/nJhlBdW0DiCVE1kyFvHeEDgepiPAqIyFH8DUh869BunFTJ3KR6opHZXz0PeqtzlLm9uractlo7qpy/tlDvkwzedwlLkld3GyeUouhJiGqOzA2+GKN98IZRJXsBZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEs3KDkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC85BC433C7
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 12:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708431883;
	bh=Db2zZfagtc5SUyxU9Vw51XrWEwAxgPwVxq9qaOlY20U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UEs3KDkFlro8o5WjGY6/P/55xcLgF3/+tuyF+8Y6k78JRGyMzTqmTi93nHkL9QFsB
	 xmGRm/UXPoqD6IFn3KQRsCfeZe/h83K5iVXqU4yVK4GTDwbOUHGyIeLO8yRe6SKgM8
	 CLXxNUUi1nD+cbZ2MM1jR3qhhhy/02rRgzUP3fRziQVPJ0oMQJnoSHAdtsMX64BIqE
	 GAztGwiUc0K2wBVY9H+Z3FQce0zxUtWmij11dNWO0IOme6jTPGbRnUioWvXVjK3dAH
	 ku3JTBApW/nC1G+rSRvruitkvJqdJ4Trg+nLHneJ/QfcWe+w6OF7BbIMV/gWzkaRcg
	 8+XZVllSzMsWA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve
Date: Tue, 20 Feb 2024 12:24:34 +0000
Message-Id: <2fb327ae5cb4c9d401a477de7c38918dd00aa538.1708429856.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708429856.git.fdmanana@suse.com>
References: <cover.1708429856.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_use_block_rsv() we read the size of a block reserve without
locking its spinlock, which makes KCSAN complain because the size of a
block reserve is always updated while holding its spinlock. The report
from KCSAN is the following:

  [  653.313148] BUG: KCSAN: data-race in btrfs_update_delayed_refs_rsv [btrfs] / btrfs_use_block_rsv [btrfs]

  [  653.314755] read to 0x000000017f5871b8 of 8 bytes by task 7519 on cpu 0:
  [  653.314779]  btrfs_use_block_rsv+0xe4/0x2f8 [btrfs]
  [  653.315606]  btrfs_alloc_tree_block+0xdc/0x998 [btrfs]
  [  653.316421]  btrfs_force_cow_block+0x220/0xe38 [btrfs]
  [  653.317242]  btrfs_cow_block+0x1ac/0x568 [btrfs]
  [  653.318060]  btrfs_search_slot+0xda2/0x19b8 [btrfs]
  [  653.318879]  btrfs_del_csums+0x1dc/0x798 [btrfs]
  [  653.319702]  __btrfs_free_extent.isra.0+0xc24/0x2028 [btrfs]
  [  653.320538]  __btrfs_run_delayed_refs+0xd3c/0x2390 [btrfs]
  [  653.321340]  btrfs_run_delayed_refs+0xae/0x290 [btrfs]
  [  653.322140]  flush_space+0x5e4/0x718 [btrfs]
  [  653.322958]  btrfs_preempt_reclaim_metadata_space+0x102/0x2f8 [btrfs]
  [  653.323781]  process_one_work+0x3b6/0x838
  [  653.323800]  worker_thread+0x75e/0xb10
  [  653.323817]  kthread+0x21a/0x230
  [  653.323836]  __ret_from_fork+0x6c/0xb8
  [  653.323855]  ret_from_fork+0xa/0x30

  [  653.323887] write to 0x000000017f5871b8 of 8 bytes by task 576 on cpu 3:
  [  653.323906]  btrfs_update_delayed_refs_rsv+0x1a4/0x250 [btrfs]
  [  653.324699]  btrfs_add_delayed_data_ref+0x468/0x6d8 [btrfs]
  [  653.325494]  btrfs_free_extent+0x76/0x120 [btrfs]
  [  653.326280]  __btrfs_mod_ref+0x6a8/0x6b8 [btrfs]
  [  653.327064]  btrfs_dec_ref+0x50/0x70 [btrfs]
  [  653.327849]  walk_up_proc+0x236/0xa50 [btrfs]
  [  653.328633]  walk_up_tree+0x21c/0x448 [btrfs]
  [  653.329418]  btrfs_drop_snapshot+0x802/0x1328 [btrfs]
  [  653.330205]  btrfs_clean_one_deleted_snapshot+0x184/0x238 [btrfs]
  [  653.330995]  cleaner_kthread+0x2b0/0x2f0 [btrfs]
  [  653.331781]  kthread+0x21a/0x230
  [  653.331800]  __ret_from_fork+0x6c/0xb8
  [  653.331818]  ret_from_fork+0xa/0x30

So add a helper to get the size of a block reserve while holding the lock.
Reading the field while holding the lock instead of using the data_race()
annotation is used in order to prevent load tearing.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.c |  2 +-
 fs/btrfs/block-rsv.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 27207dad27c2..95c174f9fd4f 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -493,7 +493,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 
 	block_rsv = get_block_rsv(trans, root);
 
-	if (unlikely(block_rsv->size == 0))
+	if (unlikely(btrfs_block_rsv_size(block_rsv) == 0))
 		goto try_reserve;
 again:
 	ret = btrfs_block_rsv_use_bytes(block_rsv, blocksize);
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 89c99f4e9f16..1f53b967d069 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -124,4 +124,20 @@ static inline u64 btrfs_block_rsv_reserved(struct btrfs_block_rsv *rsv)
 	return ret;
 }
 
+/*
+ * Get the size of a block reserve in a context where getting a stale value is
+ * acceptable, instead of accessing it directly and trigger data race warning
+ * from KCSAN.
+ */
+static inline u64 btrfs_block_rsv_size(struct btrfs_block_rsv *rsv)
+{
+	u64 ret;
+
+	spin_lock(&rsv->lock);
+	ret = rsv->size;
+	spin_unlock(&rsv->lock);
+
+	return ret;
+}
+
 #endif /* BTRFS_BLOCK_RSV_H */
-- 
2.40.1


