Return-Path: <linux-btrfs+bounces-12076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1ADA55C03
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 01:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F41D189E72C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 00:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA454778E;
	Fri,  7 Mar 2025 00:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="jhatErlw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rQfsoIUo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFA847B
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307303; cv=none; b=ojbL7bXHGON7pBOo/SmQNnRRk8ii/vJEIE2ex6fkYg8BLGcFaKQ1+Am+ZsDsM4CoFzLR7lyT+U2fo49kRQ0vEZmi6xdL9lJeAABYG2ur6xgr4fJEm/wgt7qGnmt/SsWMliuPdNu+iKBZJ2n+za5S/Qh/MawR+OREG/IMjCy3kR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307303; c=relaxed/simple;
	bh=QqUv0P3FUjcPyMWlhy2zBGoumDG49go17hl7pOZgn3w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8Fcomg3MNZmXKRBmDr65cp+zCCoJDZC4hp41vfbHjSQXKi9Ew68d2H5aIOOTc6XNF6cnC24Ebvw8zDrH82rNc+6ZCUGU8/VboJRu3OZP6+PHaJvuoqcN8GCsraQFB/lFEo7U77VSgoR6Hq5Xibs/RtnNvwWJVrN84254KjpotE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=jhatErlw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rQfsoIUo; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB08E1140190;
	Thu,  6 Mar 2025 19:28:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 06 Mar 2025 19:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741307300; x=
	1741393700; bh=0Q3wNFG+LyXz/cLYYxCXwoxA5w8FrbdH3LzRAlBftZo=; b=j
	hatErlw3oxKJryIVS3qVCoMCJPZ1i5SkrEuBeo5/7Z+waRE70ala+rQR/Y+rtZuA
	MywuBZsucM3/PTDH5EwKnWc/+VeUtG+TYuFPfPbSpSj5Uu+Rvwz4dua8VDr/31aO
	VMkD1uH7BQyNZMDdfS/U1tVjOo9sIDBgaxuSD5naznlA3wwFAzIIQuhPfXLHiWfo
	06CQQrPmgerKSs1exoitFWYWuwnKE7SbXPsFDbEN3XeH342qs3Mz7xB/U26pnv1w
	MrU4yjGkYPcZquF99kc1xBxFrvQa2zHvr8uU/TE9NSWoCnORY6XI2+dm6j8KYoFN
	a3Hy6eivpuBxZAeuOPryA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741307300; x=1741393700; bh=0Q3wNFG+LyXz/cLYYxCXwoxA5w8F
	rbdH3LzRAlBftZo=; b=rQfsoIUolUBTxSDBKXcNZuAxajYXAg9nHxRuvV1Ay2/O
	guiGx9TCx+TrBV0Sdm7GEyHxwmPDZ9WSWPp/63nNzd4V8N+EKV5e21pXTGZRKDnW
	n3594NHqECQaUH3v5rP3CrSRcGcLvUpEgUzVENQGVB3Iyg+iH7uYAijo+GZiaJs8
	oLvdTF5VbypQ5cht57C36mxAIvYSNA8G+7JRQsPPYH1mOh4irlyX2qfxCEkn9JN5
	szmSWdboU5qm4cH/o0cVVulk17vC0Y1K9MM2dITEZehjom+vvcK/sU9UCpRq39Y6
	u5uA9YewI1hXn0sHbppshuZe0Ui0W8oDFu4rIbItGg==
X-ME-Sender: <xms:pD3KZ-_jaEA9_XWic9fK8S4bHex5XAK5U_tcwzoSgOQ-ula1SAsf9g>
    <xme:pD3KZ-viu1POsUboiJxqgHL4hAk_vlpzzXgmZJ27he7DFEKs2y_LItQMFNJr1yBGn
    a14hnLGiqMSJVAznMk>
X-ME-Received: <xmr:pD3KZ0AY42YJIUqfl2eoMNZmHwBgmTam5fo9e12idqGrplVADx92pzhrtWUlhR6hCziq_S_X1R-hzOYMyS3rqrJYYiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdelvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeuje
    fhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnh
    gvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:pD3KZ2c_Xva-JyKAibLhHOK13gVeJ4nYXQoTHhd1oOMlOpkMVegFWA>
    <xmx:pD3KZzNNT5RYe84YDKzfSM9sQI79NAuggYQc-3TIhDLXespzWEtfZw>
    <xmx:pD3KZwlNCktyyRkFDiDsLm1L0bCVvem-GGbBXjFaSFgSChEKTS78AQ>
    <xmx:pD3KZ1t0gnmf7U_vv9ExCBaGhf9LB7KCFnc0mEX8kLYPSik8kl1-rg>
    <xmx:pD3KZ8atVfHCYPNjq1HyusFXHSZPMUT-un0HwBb6zBg4RsIuEtMmo2Aw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 19:28:20 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: codify pattern for adding block_group to bg_list
Date: Thu,  6 Mar 2025 16:29:05 -0800
Message-ID: <91e9ffb668376e4c67753ca92c8ca8737c07258c.1741306938.git.boris@bur.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741306938.git.boris@bur.io>
References: <cover.1741306938.git.boris@bur.io>
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

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 54 +++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e4071897c9a8..a570d89ff0c3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1455,6 +1455,31 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 	return ret == 0;
 }
 
+/*
+ * link the block_group to l via bg_list
+ *
+ * Use this rather than list_add_tail directly to ensure proper respect
+ * to locking and refcounting.
+ *
+ * @bg: the block_group to link to the list.
+ * @l: the list to link it to.
+ * Returns: true if the bg was linked with a refcount bump and false otherwise.
+ */
+static bool btrfs_link_bg_list(struct btrfs_block_group *bg, struct list_head *l)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	bool added = false;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+	if (list_empty(&bg->bg_list)) {
+		btrfs_get_block_group(bg);
+		list_add_tail(&bg->bg_list, l);
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


