Return-Path: <linux-btrfs+bounces-3187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04183878394
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 16:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E26B24940
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9056930D;
	Mon, 11 Mar 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvqz9/Gj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086E41C7F;
	Mon, 11 Mar 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170088; cv=none; b=DDVvn1m0khOcmCrqnkvwYvrcyYL103ADatiKfoQolgGHsoXv83aIG5iK7x2Z4Ljv7VsKeYyZM4TL3kz1HtaxEZ7adiGa1vM4wg/E5lfvDxqjzlJ2bPjO437ieJpYb/Tj7m9mGla6OQApf1mKFNEIpylH7f5V0cMTuvI0TUh/PO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170088; c=relaxed/simple;
	bh=vFZ03WCOn1wR1bZjKIw44TLC5EW/38on4bVp+puNMPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXCo+zXWIak7uH0ntzZuiKX/svwHt5/zVwrBQ3vvhUeQEAyZIbA/4veW+vKIQU7wkbCoFl1MyMp3MbOO0o5479mFsrcE31TTjlfmpUjTUBeSu9tBNC+pE2siSCYRw7b+tis3ykBIGrcYQtrkMJuRQ7u5jOG4USNE0OnwMO5Vj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvqz9/Gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFD6C433F1;
	Mon, 11 Mar 2024 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170088;
	bh=vFZ03WCOn1wR1bZjKIw44TLC5EW/38on4bVp+puNMPs=;
	h=From:To:Cc:Subject:Date:From;
	b=cvqz9/GjVnwayj56yWZJBk59c3DTDGBTjB4pYr9Y6+HEwOMYvamL9u3fHeO8Ezqx4
	 pGIzWaG1uTqot34NInTWKNBax58I8Heez3wxdCzItUx0iwRrTdXOIQjGKSDydbGZyr
	 TAP+iOuj6/PCEC/p4UP7T8hHZU52xuisZS8GR92Bn6M2+65KqWXfqoskkI/IErdMAb
	 rgScic2xdChg5AHEJpXyo+bPI3yyDArlvQ1MMJPF1pagNhpqDcdKBze5B7V/9wHq5a
	 w1WBqxCwjIKwyO0CwYp7d5ly0KzNxcw13J5dTFc9eXkQTDMy6rnAVqOczdcvTPRXx2
	 Lgy4h4d90o3jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/4] btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve
Date: Mon, 11 Mar 2024 11:14:41 -0400
Message-ID: <20240311151445.318822-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.271
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit c7bb26b847e5b97814f522686068c5628e2b3646 ]

At btrfs_use_block_rsv() we read the size of a block reserve without
locking its spinlock, which makes KCSAN complain because the size of a
block reserve is always updated while holding its spinlock. The report
from KCSAN is the following:

  [653.313148] BUG: KCSAN: data-race in btrfs_update_delayed_refs_rsv [btrfs] / btrfs_use_block_rsv [btrfs]

  [653.314755] read to 0x000000017f5871b8 of 8 bytes by task 7519 on cpu 0:
  [653.314779]  btrfs_use_block_rsv+0xe4/0x2f8 [btrfs]
  [653.315606]  btrfs_alloc_tree_block+0xdc/0x998 [btrfs]
  [653.316421]  btrfs_force_cow_block+0x220/0xe38 [btrfs]
  [653.317242]  btrfs_cow_block+0x1ac/0x568 [btrfs]
  [653.318060]  btrfs_search_slot+0xda2/0x19b8 [btrfs]
  [653.318879]  btrfs_del_csums+0x1dc/0x798 [btrfs]
  [653.319702]  __btrfs_free_extent.isra.0+0xc24/0x2028 [btrfs]
  [653.320538]  __btrfs_run_delayed_refs+0xd3c/0x2390 [btrfs]
  [653.321340]  btrfs_run_delayed_refs+0xae/0x290 [btrfs]
  [653.322140]  flush_space+0x5e4/0x718 [btrfs]
  [653.322958]  btrfs_preempt_reclaim_metadata_space+0x102/0x2f8 [btrfs]
  [653.323781]  process_one_work+0x3b6/0x838
  [653.323800]  worker_thread+0x75e/0xb10
  [653.323817]  kthread+0x21a/0x230
  [653.323836]  __ret_from_fork+0x6c/0xb8
  [653.323855]  ret_from_fork+0xa/0x30

  [653.323887] write to 0x000000017f5871b8 of 8 bytes by task 576 on cpu 3:
  [653.323906]  btrfs_update_delayed_refs_rsv+0x1a4/0x250 [btrfs]
  [653.324699]  btrfs_add_delayed_data_ref+0x468/0x6d8 [btrfs]
  [653.325494]  btrfs_free_extent+0x76/0x120 [btrfs]
  [653.326280]  __btrfs_mod_ref+0x6a8/0x6b8 [btrfs]
  [653.327064]  btrfs_dec_ref+0x50/0x70 [btrfs]
  [653.327849]  walk_up_proc+0x236/0xa50 [btrfs]
  [653.328633]  walk_up_tree+0x21c/0x448 [btrfs]
  [653.329418]  btrfs_drop_snapshot+0x802/0x1328 [btrfs]
  [653.330205]  btrfs_clean_one_deleted_snapshot+0x184/0x238 [btrfs]
  [653.330995]  cleaner_kthread+0x2b0/0x2f0 [btrfs]
  [653.331781]  kthread+0x21a/0x230
  [653.331800]  __ret_from_fork+0x6c/0xb8
  [653.331818]  ret_from_fork+0xa/0x30

So add a helper to get the size of a block reserve while holding the lock.
Reading the field while holding the lock instead of using the data_race()
annotation is used in order to prevent load tearing.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-rsv.c |  2 +-
 fs/btrfs/block-rsv.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 36ef3228bac86..63205d2f4d84c 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -392,7 +392,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 
 	block_rsv = get_block_rsv(trans, root);
 
-	if (unlikely(block_rsv->size == 0))
+	if (unlikely(btrfs_block_rsv_size(block_rsv) == 0))
 		goto try_reserve;
 again:
 	ret = btrfs_block_rsv_use_bytes(block_rsv, blocksize);
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index d1428bb73fc5a..69770360917cb 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -98,4 +98,20 @@ static inline void btrfs_unuse_block_rsv(struct btrfs_fs_info *fs_info,
 	btrfs_block_rsv_release(fs_info, block_rsv, 0);
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
2.43.0


