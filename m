Return-Path: <linux-btrfs+bounces-2085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3190E847D11
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 00:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07F428A2E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 23:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46B83A07;
	Fri,  2 Feb 2024 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="C4e3ul5G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q8fpsxbM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7AE12F365
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915484; cv=none; b=lMu0BiPRYFkmWOI0G9BSPIC4+8fcBG5heupl/85bLcn93WVleuByIi7MEZkbAESRzgUbjh9FIJwwmVOp/YFddj67NqHxBupl6faZC0ejClymP0HfhOHCG0cOYEA6LOrnRIuSXObKFpgMvp+tgZao1LLT6Rgo8ezs4X4XDforS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915484; c=relaxed/simple;
	bh=z2Z9CCBLISpITabUZJ/AIIS7zWcSf1tkkVa+GDQtWp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJEPi13HtRtgNHtiHU5JTretEZAp/WFkT4De/E2n+gjBRwI3uhnc4m9aR1L1M2ZCenjCTMRzVNg2ouIqd8SK6qsFYHQIPyzn6aCeTkJbGnKLZrT9sD9KUzFElJTnxrEQ4l9wIa4ann+xSSCVN2ll9CQL+4Ji3NBvoVmxsEWZllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=C4e3ul5G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q8fpsxbM; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 6C2743200A48;
	Fri,  2 Feb 2024 18:11:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 18:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1706915480; x=
	1707001880; bh=AGFsIildfQigbbuhNKfEDjdgPucteGfeucMmu1awsDs=; b=C
	4e3ul5GcvUvw8nLNvqthxUcbbXXw0FszDMK6d0+eDbeDcCAVqbUkYheix98PnOgo
	nJoQA8cWHpoT2AdyCHFVGI453hjf5GBDaHxa3VXKSzxbxK0B8dkZFfUOtv6kPZs3
	r87rHoPL9zuk933A0Ixme2XnFMMUawwUQNBGODzjGpaV+aipIN6+Tc7sk62dVfSB
	5nDu5SPqAkbKycmrF1jibd3I2TWi3ixKQstqfvX0XeCBp9G46LXvtBkazxlMOmZY
	oPqGPeA2WjsC8/5uT5Rb3K+//KNULQCxRpJOnL9Q8kIaULVL3KoEoEc+sRSPMPdG
	dtfaVDfJkHazxHg7mE3zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1706915480; x=1707001880; bh=AGFsIildfQigb
	buhNKfEDjdgPucteGfeucMmu1awsDs=; b=Q8fpsxbMVe7cWwAiGaxYIteNK0a4b
	h6UF/rJnfy2NG784a5T1FnwVQReuVgcniVAVAstHRJWj6b/xv083r8WNbncr/i7G
	WckNY+MhUmXggzEfokSqWFM463gTHh4RLCFFHZnZUeBJdU/kwoDz8F1l1DU30FCq
	nvm2s9QxyuW2wrUm+bS1x+lORpnvr9Cou2QfDpEtd8QVMnkbkPljjwVxla/DGivU
	oFR5BB+S7H8HeEe+8pMVXisUCiLPEQHNTvGdtXTy+iW5M+nxmGrWBSe60cqMmFuZ
	ZwTbFNnaVUG7dL8ypzLxhwj0kNMsKnAaQ1DR7syFCY7B/OjFk5NzKIMZg==
X-ME-Sender: <xms:mHa9ZZcuwLuSHg3ZQ0VdZuolM338rIzlpGb0SJEa9hCVP6Fb9L-GmQ>
    <xme:mHa9ZXOc2cdi5FgC2Mhml74xCMbjlnNoY-nSjZp90RPaR9gGbFmxi9zr38KbcjpWB
    78tq8T4r7W2FXFkKuQ>
X-ME-Received: <xmr:mHa9ZShHm4VStNHF_rsAWqOcYKaTU2gZ2_wDqkfvXMgbxY7vZL_8-IWnYOKKck3g_YqzemPK1E1L_N81jP0X7QfYGec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:mHa9ZS-ozvKKOPY0oSaKOFF4w7sC7WUwPLME_BP7JhqyTltLP6rNLg>
    <xmx:mHa9ZVuarxZfq1kqlTjkzlX2TjdTzF7gapNsR7yxY8c4WnJgeoPI5A>
    <xmx:mHa9ZREXPSQlqgLC82AsrGAZharRMNZhuM1tm2Gk7y2dAgpUo08xKA>
    <xmx:mHa9ZT0hS_OPfLv7wahijb5AZ2TqI_dPWx9eWkLS0tH2MGNj-51VAw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 18:11:20 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 6/6] btrfs: prevent pathological periodic reclaim loops
Date: Fri,  2 Feb 2024 15:12:48 -0800
Message-ID: <edd9f3c46e50c5f0527d48e6c4ca9cbd94e1f405.1706914865.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706914865.git.boris@bur.io>
References: <cover.1706914865.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Periodic reclaim runs the risk of getting stuck in a state where it
keeps reclaiming the same block group over and over. This can happen if
1. reclaiming that block_group fails
2. reclaiming that block_group fails to move any extents into existing
   block_groups and just allocates a fresh chunk and moves everything.

Currently, 1. is a very tight loop inside the reclaim worker. That is
critical for edge triggered reclaim or else we risk forgetting about a
reclaimable group. On the other hand, with level triggered reclaim we
can break out of that loop and get it later.

With that fixed, 2. applies to both failures and "successes" with no
progress. If we have done a periodic reclaim on a space_info and nothing
has changed in that space_info, there is not much point to trying again,
so don't, until some space gets free.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 3 ++-
 fs/btrfs/space-info.c  | 6 ++++++
 fs/btrfs/space-info.h  | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1a752a8a1bea..41b9320d3d3b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1871,7 +1871,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		}
 
 next:
-		if (ret)
+		if (ret && !READ_ONCE(space_info->periodic_reclaim))
 			btrfs_mark_bg_to_reclaim(bg);
 		btrfs_put_block_group(bg);
 
@@ -3580,6 +3580,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		space_info->bytes_used -= num_bytes;
 		space_info->disk_used -= num_bytes * factor;
 
+		space_info->periodic_reclaim_ready = true;
 		reclaim = should_reclaim_block_group(cache, num_bytes);
 
 		spin_unlock(&cache->lock);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7ec775979637..bef4d29c07dd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1968,6 +1968,12 @@ static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
 	bool urgent;
 
 	spin_lock(&space_info->lock);
+	if (space_info->periodic_reclaim_ready) {
+		space_info->periodic_reclaim_ready = false;
+	} else {
+		spin_unlock(&space_info->lock);
+		return 0;
+	}
 	urgent = is_reclaim_urgent(space_info);
 	thresh_pct = btrfs_calc_reclaim_threshold(space_info);
 	spin_unlock(&space_info->lock);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 2917bc4247db..e6e3f82c2409 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -175,6 +175,12 @@ struct btrfs_space_info {
 	 * threshold in the cleaner thread.
 	 */
 	bool periodic_reclaim;
+
+	/*
+	 * Periodic reclaim should be a no-op if a space_info hasn't
+	 * freed any space since the last time we tried.
+	 */
+	bool periodic_reclaim_ready;
 };
 
 struct reserve_ticket {
-- 
2.43.0


