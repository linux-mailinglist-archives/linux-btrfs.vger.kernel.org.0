Return-Path: <linux-btrfs+bounces-12074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4896DA55BFF
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 01:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1FD3B9589
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 00:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1E3B19A;
	Fri,  7 Mar 2025 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="A+4GJd55";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xvNwesyW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162827701
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307300; cv=none; b=MIAN7TcwTt5Vrr+4MiamKioFcsN/s5wzzR5GwqqKg6cWtSJ2A9qzOL0iIgMi1BdFzCgCmJtsGiZVZRmJAM69S1mJQqYaIRPeU6Vgleh3zUlhpgqH4iVgGX9aXLPx7pIbXnI06KpF4PuBPz6UAcnazDsDUcI8GndYFlJ/BWddrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307300; c=relaxed/simple;
	bh=RCx7Enbup5l5Nsg4PjOog7yN62nKFfJ6kLkswDQSgSQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEtStGL5jFjA+jQJez5IEA7kds56sqJnUsF/MMXkF/ENUHBoxCe2VLCPLBTy+uOhR+GuSSdtHa0Len5GGK1sX+pQOgz72f5TXL2pnOwvD4HANbvIczrtxMAeCNnNBqz3n6DGtYpEX36xBK2OCf0B0TV+uGQqm1Z1SjMWnnmEWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=A+4GJd55; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xvNwesyW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7552C13826AA;
	Thu,  6 Mar 2025 19:28:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 19:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741307297; x=
	1741393697; bh=czrxCCb2zq5m1SFHoFLIObpPSGpKFuIyKsF9YBmcy30=; b=A
	+4GJd55prfkHbGGoqPRLVyXgFtmSTXk6JGqTuyFAnHCXDq9XFogpDrCTP1YIuQj6
	pNSbG38jLe7bKBqPGJlMUjbCIhn1MZgwFBDMA/MwL2awHQJ1J8asOBQFkcsLp3NE
	OqsxTabdWy7Ly7V/oA5NjoGxRKeFh5QK8UOqNPKiU8SPMijDGzhlVCInVzQq4VBI
	KQHZjUY7Jc31KKf9qbSXOheqiXSSn4M8iS8XOhK+yXFpk0YlZdXhULc65uxEJ1G8
	AQzcdYKfesy+O6jo02D5a76XNxaAHQd4uItx2nbAojZ7Hni3DTHvFlOW6P5Rt/Q2
	TKOJgtfnzujjmg1SWVglw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741307297; x=1741393697; bh=czrxCCb2zq5m1SFHoFLIObpPSGpK
	FuIyKsF9YBmcy30=; b=xvNwesyWlxT1fsZbrVkUGq0tu/E7L+SSxhPEskaPpCjd
	Y81bw8bIrLfkZsxarQFbpV6BcXa1y0y5irlYZfksj8uGStzmRHffkwef+dCp9R6i
	1SBVVMgVotS4rViQzRLuJl+yBVAv6eKtovh2pkf7fFCHL2UCRM333nXgo5FCzyNU
	fS/vJsGb4MuMgQK9UaEM+jpjg2OiFrqe473Nwo79lrHfegyzoBgFQofkhAXbgXBW
	5Ql8K9fnMamyIBMPku5FRu1q9LCWTgYOYCbIpeWJWqwcw4UnqbbEqXYNZVRcXQWo
	E/DPsyMY4Dz4GEl3Gro1rSNn6ePoBLgBrUGjqbtu8w==
X-ME-Sender: <xms:oT3KZ8DdClF0l4HZJFf361Z7n0V70wIkIDm4wwZ_OxEP3YLJ6lV-xg>
    <xme:oT3KZ-gG0XnToSUyphsCVKMj2-SLvCaFRrSfrd0Gg7_UtjNQSAzsLK-due_UJwqBd
    LL0zIYJmJ8PjsnYfBc>
X-ME-Received: <xmr:oT3KZ_m4dC8G3tjNelG4RUp4pyaItcQsLMxRVBW_z4ECgqj8uTjhWrBRAi75rCRnP7ysJFyICp6cUhBVac6WSvXdki8>
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
X-ME-Proxy: <xmx:oT3KZyzkUcvaOToyFOlxau8zLpqARy4Q4gCup3nfQE6RlAQvItKYSA>
    <xmx:oT3KZxRzseFyEZZzsbCnU3-bFBSCyhNpGGCYITqshxPT2zqhbczgUA>
    <xmx:oT3KZ9aTSHXF_WZK1n94sAkPSL7Kb0sZdkCsz-f1QHz-J0wBotM-9w>
    <xmx:oT3KZ6THnnQHV49IzCtoJii3J4Opx3LiiQYoby1HYtJJ7C3BBCldZQ>
    <xmx:oT3KZ8dOCBnCmN77JucksPYAAxPdHpGfAX5zN4FJaOOBsmndANBfdA6J>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 19:28:16 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: make discard_workfn block_group ref explicit
Date: Thu,  6 Mar 2025 16:29:03 -0800
Message-ID: <ab8a6f9b2e3ce6ee7196a481233956ea9629b7b8.1741306938.git.boris@bur.io>
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

Currently, the async discard machinery owns a ref to the block_group
when the block_group is queued on a discard list. However, to handle
races with discard cancellation and the discard workfn, we have some
cute logic to detect that the block_group is *currently* running in the
workfn, to protect the workfn's usage amidst cancellation.

As far as I can tell, this doesn't have any overt bugs (though
finish_discard_pass and remove_from_discard_list racing can have a
surprising outcome for the caller of remove_from_discard_list in that it
is again added at the end)

But it is needlessly complicated to rely on locking and the nullity of
discard_ctl->block_group. Simplify this significantly by just taking a
refcount while we are in the workfn and uncondtionally drop it in both
the remove and workfn paths, regardless of if they race.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/discard.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index e815d165cccc..d6eef4bd9e9d 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -167,13 +167,7 @@ static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	block_group->discard_eligible_time = 0;
 	queued = !list_empty(&block_group->discard_list);
 	list_del_init(&block_group->discard_list);
-	/*
-	 * If the block group is currently running in the discard workfn, we
-	 * don't want to deref it, since it's still being used by the workfn.
-	 * The workfn will notice this case and deref the block group when it is
-	 * finished.
-	 */
-	if (queued && !running)
+	if (queued)
 		btrfs_put_block_group(block_group);
 
 	spin_unlock(&discard_ctl->lock);
@@ -260,9 +254,10 @@ static struct btrfs_block_group *peek_discard_list(
 			block_group->discard_cursor = block_group->start;
 			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
 		}
-		discard_ctl->block_group = block_group;
 	}
 	if (block_group) {
+		btrfs_get_block_group(block_group);
+		discard_ctl->block_group = block_group;
 		*discard_state = block_group->discard_state;
 		*discard_index = block_group->discard_index;
 	}
@@ -493,9 +488,20 @@ static void btrfs_discard_workfn(struct work_struct *work)
 
 	block_group = peek_discard_list(discard_ctl, &discard_state,
 					&discard_index, now);
-	if (!block_group || !btrfs_run_discard_work(discard_ctl))
+	if (!block_group)
 		return;
+	if (!btrfs_run_discard_work(discard_ctl)) {
+		spin_lock(&discard_ctl->lock);
+		btrfs_put_block_group(block_group);
+		discard_ctl->block_group = NULL;
+		spin_unlock(&discard_ctl->lock);
+		return;
+	}
 	if (now < block_group->discard_eligible_time) {
+		spin_lock(&discard_ctl->lock);
+		btrfs_put_block_group(block_group);
+		discard_ctl->block_group = NULL;
+		spin_unlock(&discard_ctl->lock);
 		btrfs_discard_schedule_work(discard_ctl, false);
 		return;
 	}
@@ -547,15 +553,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	spin_lock(&discard_ctl->lock);
 	discard_ctl->prev_discard = trimmed;
 	discard_ctl->prev_discard_time = now;
-	/*
-	 * If the block group was removed from the discard list while it was
-	 * running in this workfn, then we didn't deref it, since this function
-	 * still owned that reference. But we set the discard_ctl->block_group
-	 * back to NULL, so we can use that condition to know that now we need
-	 * to deref the block_group.
-	 */
-	if (discard_ctl->block_group == NULL)
-		btrfs_put_block_group(block_group);
+	btrfs_put_block_group(block_group);
 	discard_ctl->block_group = NULL;
 	__btrfs_discard_schedule_work(discard_ctl, now, false);
 	spin_unlock(&discard_ctl->lock);
-- 
2.48.1


