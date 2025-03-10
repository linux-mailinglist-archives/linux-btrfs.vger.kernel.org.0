Return-Path: <linux-btrfs+bounces-12162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8984AA5A464
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 21:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BD71892F3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5B1D8DF6;
	Mon, 10 Mar 2025 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="me/TJ6ww";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fFi0aKAX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10861DE895
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637190; cv=none; b=p7sGJCPCGcL+0o5WWqF0d4ZCQavW6ATeNFoSStPx3HDetZGY10b7z0WsDkdkIW4rZv1jZiAGm0W2UNuca37+IKjYZK5Lqm3+e3O2Rw11O0/KxQjnx8g5VAH+h8ImjQ5hGBWLAzaOLfkOR1svc3edde11JzYckb4wn06NxYqTSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637190; c=relaxed/simple;
	bh=CCfC5MH4NejjmcRyQRtXMPbVgbLZQbv489BcXUtgoXA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYup2V05ikfjZCQNlvKwAtUuwlLFeK77UTmQMZTK8WnEc117Y56UHZf/pFqk4SR7cQkK/8PUTNPG/Vxgf47zqo/iZwXTTYIpvKLYnlywkEhM+/YhPjUsAbJvJg0iir+yU6c1Zs7dkqOnOikdnpS10t7ME/FinItR0YfVOpi9+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=me/TJ6ww; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fFi0aKAX; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A59521140199;
	Mon, 10 Mar 2025 16:06:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 10 Mar 2025 16:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741637187; x=
	1741723587; bh=uXeQn6WnNuRKv4Z8OM5zT0iFk4eHXSDsJY9qT48cFUc=; b=m
	e/TJ6wwUFMn4rCMyw+OHkhjBlx7yqIX2vdesm9Ow8WgzYgqKO2Sjwzuzq7EmKKdO
	XyO8UDXfHlP7gGjNdq1yTgSxoowx4sQ8Su/cdm6QffWvN0QZ/ALL/11bZiTq8btX
	BHiTkZ0RbBhCgpKEtvsC45YETNvnUVRsZaZV8EPKorLFXmOkge6OXzNFa0/vZnQJ
	v8fLVUiB0KG36nPxHTAs3MCq5Y+YMKUmiuD/GZhyAk/ptewgMkiRV7+Q1PNzEY5+
	jo1amaVMjODBBzX5LUutLmuA0bxLGHsrTWzdd8GdvgUsQiT/BondCF0alm8ki2w0
	sezvx1epRMeRe/vzeZ2Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741637187; x=1741723587; bh=uXeQn6WnNuRKv4Z8OM5zT0iFk4eH
	XSDsJY9qT48cFUc=; b=fFi0aKAXCPMaPpeHnu1JQGbcXqrKgocPtZ9ZWwpTLyFY
	nUMj2+NM21yN9WW5pGQ6WvhdzwUnN8NagOO9bxMATlVaoyFpb6rhcv+kUOruCG5Z
	Ud9f/jhjAY9XGiJzwwI/BxCHxHUI6ugggtQcGACjxIBDDzW+bh0CglHo7wjA/U7w
	SOGf6+2nt/AUnFiZ1iTDQqkkAOW+7p1conPia/PChOQL6WLCxAlE46ysGVebSZOA
	vDHmQ8PHDJZ3spzBKyR4KMhX9iMRZCY1Ej0AwWGKgzNkDyrLo6cEpYl4PMCKXPfV
	W/p/QFsBJUHY+MMZk10fq5MGD7wRhp9Jia22yfXGGA==
X-ME-Sender: <xms:Q0bPZ_Cdh18HBQvvdLDRjsLU0lhuinvSS32HEtBhqSE2paU14E3YNw>
    <xme:Q0bPZ1j72YV_XoGpaOBS6GWMVhXXV8hZ8CfIEymAnhs4vcAM36M4xrkgZrHaGxMUY
    6RlmevvwZtAtgCd-d0>
X-ME-Received: <xmr:Q0bPZ6lsIdKPZiGBcamzW63WSCvKQrjFC1-GQTLw76B9y0vQ3SJHSY0jmJDalUq0Chqe_qqVgyYQ2eymcJvKcVrIIJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeuje
    fhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnh
    gvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:Q0bPZxyGin4qgED64bD__NaZnAyocESiFCuCN-Q0LjZy2sFejIb4iQ>
    <xmx:Q0bPZ0QGjHtE88d0vUvaJaMAqDSGIxQ6pyeZjv2Dc7wF0IdakXwEzA>
    <xmx:Q0bPZ0Zf1qeOCQy1VX0P2pX41Q-qbe0NxOGDF5BW0hCBeujsZWlqJQ>
    <xmx:Q0bPZ1QGBQuTNAXKb0zDJitB1jkWlxvfaZKBhPeWshZopxodsZXl0g>
    <xmx:Q0bPZ_cXkMUBQxN5f_-rHpGYZDIR4VhLg_usSHqSquI6aksSVbQKSiZi>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:06:27 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 5/5] btrfs: codify pattern for adding block_group to bg_list
Date: Mon, 10 Mar 2025 13:07:05 -0700
Message-ID: <fed44344453198ae28616293163619315cd1e6e4.1741636986.git.boris@bur.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741636986.git.boris@bur.io>
References: <cover.1741636986.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to mark_bg_unused and mark_bg_to_reclaim, we have a few places
that use bg_list with refcounting, mostly for retrying failures to
reclaim/delete unused.

These have custom logic for handling locking and refcounting the bg_list
properly, but they actually all want to do the same thing, so pull that
logic out into a helper. Unfortunately, mark_bg_unused does still need
the NEW flag to avoid prematurely marking stuff unused (even if refcount
is fine, we don't want to mess with bg creation), so it cannot use the
new helper.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 54 +++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e4071897c9a8..5b13e086c7a8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1455,6 +1455,31 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 	return ret == 0;
 }
 
+/*
+ * Link the block_group to a list via bg_list.
+ *
+ * Use this rather than list_add_tail directly to ensure proper respect
+ * to locking and refcounting.
+ *
+ * @bg: the block_group to link to the list.
+ * @list: the list to link it to.
+ * Returns: true if the bg was linked with a refcount bump and false otherwise.
+ */
+static bool btrfs_link_bg_list(struct btrfs_block_group *bg, struct list_head *list)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	bool added = false;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+	if (list_empty(&bg->bg_list)) {
+		btrfs_get_block_group(bg);
+		list_add_tail(&bg->bg_list, list);
+		added = true;
+	}
+	spin_unlock(&fs_info->unused_bgs_lock);
+	return added;
+}
+
 /*
  * Process the unused_bgs list and remove any that don't have any allocated
  * space inside of them.
@@ -1570,8 +1595,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			 * drop under the "next" label for the
 			 * fs_info->unused_bgs list.
 			 */
-			btrfs_get_block_group(block_group);
-			list_add_tail(&block_group->bg_list, &retry_list);
+			btrfs_link_bg_list(block_group, &retry_list);
 
 			trace_btrfs_skip_unused_block_group(block_group);
 			spin_unlock(&block_group->lock);
@@ -1968,20 +1992,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		spin_unlock(&space_info->lock);
 
 next:
-		if (ret && !READ_ONCE(space_info->periodic_reclaim)) {
-			/* Refcount held by the reclaim_bgs list after splice. */
-			spin_lock(&fs_info->unused_bgs_lock);
-			/*
-			 * This block group might be added to the unused list
-			 * during the above process. Move it back to the
-			 * reclaim list otherwise.
-			 */
-			if (list_empty(&bg->bg_list)) {
-				btrfs_get_block_group(bg);
-				list_add_tail(&bg->bg_list, &retry_list);
-			}
-			spin_unlock(&fs_info->unused_bgs_lock);
-		}
+		if (ret && !READ_ONCE(space_info->periodic_reclaim))
+			btrfs_link_bg_list(bg, &retry_list);
 		btrfs_put_block_group(bg);
 
 		mutex_unlock(&fs_info->reclaim_bgs_lock);
@@ -2021,13 +2033,8 @@ void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
-	spin_lock(&fs_info->unused_bgs_lock);
-	if (list_empty(&bg->bg_list)) {
-		btrfs_get_block_group(bg);
+	if (btrfs_link_bg_list(bg, &fs_info->reclaim_bgs))
 		trace_btrfs_add_reclaim_block_group(bg);
-		list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
-	}
-	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
 static int read_bg_from_eb(struct btrfs_fs_info *fs_info, const struct btrfs_key *key,
@@ -2940,8 +2947,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	}
 #endif
 
-	btrfs_get_block_group(cache);
-	list_add_tail(&cache->bg_list, &trans->new_bgs);
+	btrfs_link_bg_list(cache, &trans->new_bgs);
 	btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
 
 	set_avail_alloc_bits(fs_info, type);
-- 
2.48.1


