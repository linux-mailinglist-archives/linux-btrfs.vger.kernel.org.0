Return-Path: <linux-btrfs+bounces-12160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0426A5A461
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 21:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC923AEA1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB7F1DE4FF;
	Mon, 10 Mar 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ULKLHpf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d2Fnv2F3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4271DDA09
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637186; cv=none; b=iM+F35jNnQaVGFWlaDN2pButBoRq/59DhBfEoGUec/qGrPSw774ddGk/bvoCjtl7JUzfOlvIEaJz2t5Fv8RczBNnOUHblQin7bqvbtMF+rTKZjpoFovGSW669l/jTPUKl+LSaVD6VWXElF8eodJ4UJtjM5eUe6GU1Y+ZwElmQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637186; c=relaxed/simple;
	bh=a8GliFKuwJozEkX8lQ9ghqkc/DOzPnF+sas7xSJdBmw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYFrOWn1VLOV5Lce5xAwcZfl4dfvQ+DmlzBGyeOl2UjKKLMtqJYhhYd63GA4bl69Q+q7F3UaSVMpmBZ4Xoibq9qeOft5UFm85KBVVLQYirT2fKIv2sN5mV2YPo+ToZT3V5yfwIA/mr/RZUZMsjkL9S9t1PSgkv+jxYEjiPjJErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ULKLHpf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d2Fnv2F3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BAB922540100;
	Mon, 10 Mar 2025 16:06:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 10 Mar 2025 16:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741637183; x=
	1741723583; bh=DVXts/98tHZ2vxZE+3Wgaw+MggJ8UwczYg8DvQBKv2M=; b=U
	LKLHpf8g1gJGgToFOKITgbMICb1Vm3pmIVkSlq38Jeg3IsDdcR82DUbTwHnCLw/y
	XA3/kiWkRhOg0wt1SGA/DVCzG9MBtsPpi4IAjCEk0NsKUD6v41uEdpnDyjeDYcod
	K79KjpEbrkz95XkUucre6V5EPZQIJJq/dnRVLBr7LtXqPsGUYemdGxhST2e8a//6
	UZ+RFUHf9BauqCtbdlPC5s1PdaqRgPu7g6bG2TE0og41fVAy9FJWl+6eSVZFRFSc
	0KHYvT9yVN0e5Fqxhx6Q8Jw2S/dq2xHUF3t8MjSZRrIh7Kd+ujyR5yScb/ThdJ/3
	pjAOKnLv7ps3gQ/EqvD8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741637183; x=1741723583; bh=DVXts/98tHZ2vxZE+3Wgaw+MggJ8
	UwczYg8DvQBKv2M=; b=d2Fnv2F3MYhzwn0oQvIhS/941GL1fcFVIf7zGOmikpE7
	VEizjKS1WWdqgocsfxSTRryitqIXrowBl8CpfdpNNkuM42Hc++5ad/ufIHzLTxhL
	rIzy4nd8QFMIXnOdroAKVWKnItZK3eZgTIPRSK/FC9vh4H6hXBa+zP4S+wIDVdmB
	ZpwdctETjQZxOmugC8D3CGrmoh9RL0N+3X19HqlGnpBYjJuC99BFzjv2GJJkFStj
	bMWHN3lBT3S3uVZkDwF2hVrFm82bjFOpnPMRndKlUpmjD2eYNLrToY7bXmlpseFF
	y4pqCVsCwNuxyjT8puwoTLi7LdwBRHIwyuijyEp+PA==
X-ME-Sender: <xms:P0bPZzocLmaZehC2-e64ekPsdTkVAeL2hs92VgL_TiJz9WnTepOLjw>
    <xme:P0bPZ9o8bIh-XHjEPZhtAMuNgb9Tv1Keyr_3nP_hxOgQeByQJJy_SoXy3-gcu5HoA
    ip03AxOBPvkyY8fVGM>
X-ME-Received: <xmr:P0bPZwMdGnHuM1KmoBGDOPU42j3et-M8RcgHk_5uaYRvd0W1PSf_Ez3x5c3k7M3paDVNJW06jfiE9QT-Wz8KNt_9QLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeuje
    fhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnh
    gvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:P0bPZ2541juo4WeLHKOCHJmhQqjC9B47xK0fm6CaJRH9nIjvTaAZlg>
    <xmx:P0bPZy7fL9AtuCjVDK3dKpW9oEb09qxEB5xezroig-jjr67J9U5qAA>
    <xmx:P0bPZ-j2M8rwKnFq4ODx8YTuc8QtFW2l6-NBL1IzXmPWHuIQpuWH_g>
    <xmx:P0bPZ04icgizLHMfEEmKbMUc8k8AKbFieT4iWZ5FABToroTz0ObAAQ>
    <xmx:P0bPZyFkOiLQ_gSkmRRusK0QvcunaY5L50BG_xvTb8F-lhzsaszTsgY3>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:06:23 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 3/5] btrfs: make discard_workfn block_group ref explicit
Date: Mon, 10 Mar 2025 13:07:03 -0700
Message-ID: <f5b833a4f6637bef817a9a7f639a175563cc4331.1741636986.git.boris@bur.io>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
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


