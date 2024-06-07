Return-Path: <linux-btrfs+bounces-5561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1B900CB3
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 22:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71D81F22E12
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7861413E8AF;
	Fri,  7 Jun 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="oKonlQTS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GsanXISd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE933EE
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717790662; cv=none; b=LZhmt/ZiEfkkOE/lCrYjizaXfRYBfQNi2Xl3+txDAK/D3ZUlX0tZNrsN5dhrCGTOfGw3FsT23gc1XYYZ30OXiepGbRwEREix6Ye7E7ooJCHfNgqSg//yitsFWObvHMiot9C05vWjgBRs9JHjJon1uhxPHo55moy/26IH4Z94c/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717790662; c=relaxed/simple;
	bh=r6Wg6NfO+XMz0Mx7EFo9UPGOin5gdQa7Gbk+1T7b7LU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aHbw1KQSs2T7NLO+7/ZhES36JzOW/jPfmD4tCs6hPFeN+OfQz1Y9hhiz2aQEwfTcwYv/2lt2coIyAI2Q0ydIeXCSP2SNP0wUKhg6uxIefWg8QKDIU/ibOs0J1KA/4uC8MT7xl2qatQie+JY893RMwHTE9y9VUJbiYmPtfzp5HeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=oKonlQTS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GsanXISd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 989CB138009F;
	Fri,  7 Jun 2024 16:04:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 07 Jun 2024 16:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1717790659; x=1717877059; bh=ni+N7dKmGxomGtQgbjPmF
	F8MEETPL1ivKKGWC0b5o0I=; b=oKonlQTSr5fKiNFMLf6KgGZDk5Ajj2U4Xr920
	+hrnjF+1heZ0cEaXNedoEnO6yiZArh1iHqkB80LbRaq0Kso9FhtAK2O5xGO96Aue
	NnGIx9sUisP1WiLyIEgHrds2oyn82UJw1pEY4b3Vie7L9Nc2KJWS0KkpxwqZWIQD
	MlyUAPO5uYFRZkXhq8+FM4AbrI0ZSoscMHRXp7Z3IScAE4AzWvOOHKS3k/uiJQKh
	s1GAFfS+6SvCV//hGccc6/Z8IL3hnwYJ1zHNJs99hZvv+wd22JsiPjgDxEwnfTTH
	HzykhrEdNrCvL7b4HssaCCS48ycvsygkr9bqK7DgMcVJiG3Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717790659; x=1717877059; bh=ni+N7dKmGxomGtQgbjPmFF8MEETP
	L1ivKKGWC0b5o0I=; b=GsanXISd/ae/C5AFWXZuEsfKHAq5B3dw/HL+jt63uWY4
	9W+V6vU8YleJ0/2DRlF9/zbqzVd5hNPvoqdDWpoXY5+dH/X54XtZHsR2SzTQovZ9
	s+KpE4+ROD06TfOx+O8gXk8g1rLVBKyHUnTtJGy0puhI5Q4bI1DqXHinv0XgnQgQ
	3Xw7zBHtF0jSSkW2g2iCS4x2x54Tput2CvW936p+e3bg1Vm3Bmw095V4pdeu+Iyx
	BM9oC6HGruxdsU808oWYxnQW9qyu+kGFe79bFKivtEMeYZnj8hHyujyQALWmDl8w
	dnOLkXc9wwKeNCKGH3MgGgnPM1NJDBWpb4L3O9eT0g==
X-ME-Sender: <xms:w2djZrmPMxfMTDWmbNs62OvFs14T-QN2j1xH9sy_w51QaD6jk2-OAA>
    <xme:w2djZu2DlmgWPVAqof_jhbo_PXgd8ugmuBjEHArQjzul2-_fL-wR-mZUuWcqRN5oV
    vHemxUXsOOeU6b7NM4>
X-ME-Received: <xmr:w2djZhpyed7fS8c8nnmVfzOpxR2nSWvhFDv8HfnrcVjrUKhwGk4EDym33NIQySgHHJYOKYfOqpABNu42Lyt2GvUkuSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:w2djZjldFNecpAf6SMPA-CHwuPSNRQOXrZqR8i-FsVQXOKL55d8-DA>
    <xmx:w2djZp2rPHq2Dgl_tFsxDXB_Gdf7wwe97tDULmT4ce0wWHWa82X8Vg>
    <xmx:w2djZiu8pmnAcfvAZcleDFofZCSfV0YmYZnvcohGgK6_JKGrXhTyDA>
    <xmx:w2djZtVRTv3dWO2F4tXvbpFcHL87Zopky9AzxZB9RTWeWTMUmrewrg>
    <xmx:w2djZnCv5H1Td1Av3txJhthKbbx4GUxaYzTuC4tT97dMALSSPe5dwA5D>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 16:04:19 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: retry bg reclaim without infinite loop
Date: Fri,  7 Jun 2024 13:04:04 -0700
Message-ID: <3ed106331a7ff61303c9e1c2930f8a7673b80a86.1717790627.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If inc_block_group_ro systematically fails (e.g. due to ETXTBUSY from
swap!) or btrfs_relocate_chunk systematically fails (from lack of
space), then this worker becomes an infinite loop.

At the very least, this strands the cleaner thread, but can also result
in hung tasks/rcu stalls on PREEMPT_NONE kernels and if the
reclaim_bgs_lock mutex is not contended.

I believe the best long term fix is to manage reclaim via work queue,
where we queue up a relocation on the triggering condition and re-queue
on failure. In the meantime, this is an easy fix to apply to avoid the
immediate pain.

Cc: stable@vger.kernel.org
Fixes: 7e2718099438 ("btrfs: reinsert BGs failed to reclaim")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9910bae89966..fe61fc2df950 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1792,6 +1792,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
+	LIST_HEAD(retry_list);
 
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
@@ -1928,8 +1929,11 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		}
 
 next:
-		if (ret)
-			btrfs_mark_bg_to_reclaim(bg);
+		if (ret) {
+			// refcount held by the reclaim_bgs list after splice
+			btrfs_get_block_group(bg);
+			list_add_tail(&bg->bg_list, &retry_list);
+		}
 		btrfs_put_block_group(bg);
 
 		mutex_unlock(&fs_info->reclaim_bgs_lock);
@@ -1949,6 +1953,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 end:
+	spin_lock(&fs_info->unused_bgs_lock);
+	list_splice_tail(&retry_list, &fs_info->reclaim_bgs);
+	spin_unlock(&fs_info->unused_bgs_lock);
 	btrfs_exclop_finish(fs_info);
 	sb_end_write(fs_info->sb);
 }
-- 
2.45.2


