Return-Path: <linux-btrfs+bounces-3182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8C8782E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E65AB21441
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277B747F41;
	Mon, 11 Mar 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdYqyC0D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C246551;
	Mon, 11 Mar 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169954; cv=none; b=ZjVhGUN092N615meFAaxqcmouIqRffuromdus58lQQQhtOZB9Yi5y8ucZjcSc4WcqG418WsymP8plp5KGLvUQyYKj3X51qZuLIfu/HXw6a0N3p/aINFDrfU5tE28DU//QdYB/jwfQ22fTZnSavB6NRMVqFxsR6AXztFe0pZD39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169954; c=relaxed/simple;
	bh=v/GqwctWlG2sHaK90uHM0kIohRdym6r35L14FSDIhDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUDiIX4AZKZoP31CVp8aLpPgGcBiVP2dIpB3fBqLB5ZcKjCq4RjpqcFF3GPHp8HNRIbGJ9L2kt4xw5OLfulAmZ6Ag1eJYIO9F/YixEVDAfBIqSjAGnI3i2iSQqGjAtW8CjozSwUzAXQ39p4jroKfGqwDSDomwRMJA0o0ZiEAurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdYqyC0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CD6C433C7;
	Mon, 11 Mar 2024 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169954;
	bh=v/GqwctWlG2sHaK90uHM0kIohRdym6r35L14FSDIhDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdYqyC0D1BkO/qCJ5uZeWim6nNMnQIG87KRafxTQXlllAPsNWa1vWsrW/3z7xlcAJ
	 9EBO+qnbQr/1mi2MumqUEkQLNGhe9hAa/0CvwICO7LDigUR6GFChI4TjYZ7ku8sJRs
	 i2ttmJIXDHJzuapLpQcmkb5KYrNyqUqvej3UgtumPbWGJAX4PDv9DmSMRgkJbWde1M
	 0uAKGq1Kt36MOmNhS/+5dBCka13fauN5uBf/Riki3IeQqGWeuqi8QNoLj1Lg3Wu6Gg
	 CQV4T6R1lhAFb8DNLBXwlEf5EFwc+KWIvt6CKKhBOacpsQVbbvyIukj16xz5EHjWme
	 rg//k2ZXNbc8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 06/23] btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve
Date: Mon, 11 Mar 2024 11:11:46 -0400
Message-ID: <20240311151217.317068-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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
index ceb5f586a2d55..1043a8142351b 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -494,7 +494,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 
 	block_rsv = get_block_rsv(trans, root);
 
-	if (unlikely(block_rsv->size == 0))
+	if (unlikely(btrfs_block_rsv_size(block_rsv) == 0))
 		goto try_reserve;
 again:
 	ret = btrfs_block_rsv_use_bytes(block_rsv, blocksize);
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index fb440a074700a..43a9a6b5a79f4 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -117,4 +117,20 @@ static inline u64 btrfs_block_rsv_reserved(struct btrfs_block_rsv *rsv)
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
2.43.0


