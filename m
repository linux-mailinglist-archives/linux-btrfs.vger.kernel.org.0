Return-Path: <linux-btrfs+bounces-15533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30753B07FB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 23:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B414A4CA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686C22EBDFA;
	Wed, 16 Jul 2025 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="uRFU8Wkq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MAes9Lpk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95D266F05
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701722; cv=none; b=O9JesZu5IUXwYIrDlQ1YCJPOtadN6gp4eL5ZIe+w+vhOr/oujw5iW4+Uff9oAZPizwuyQzMaAnylm0Y/J2qjj7KKufiyblIVEH4RQFSZXObjqStBxCUzNmty/KfjLj35HkOQv+CRITLYnXNGF2KVnWfFHIE3E+WDY6kOuQRWdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701722; c=relaxed/simple;
	bh=NHQAf/ATWtamSJ1z93IPxQFkfsOQXVt1W01Y3U2Ewb8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EuKgGqzeitjv4o+mApjctdUAFJGhUJQcsG/ZACIfo4N3E6duZPhCXYN8wsCW3tVysUs7jxKse2R7OfXgIVByiCZSrHdLsVA99tRNnXLEdTuTl7CwJwGsq+W1uSXRoRehFd67W+2zMhycaPN0RLVpPrzHmvZoHtlFvlOfm+P6PdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=uRFU8Wkq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MAes9Lpk; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3EF2AEC01F2;
	Wed, 16 Jul 2025 17:35:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 16 Jul 2025 17:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1752701718; x=1752788118; bh=ZlbddsCWyfjSX6TTS5k3/
	DIJhqdKFYTKpqCOijjYGzM=; b=uRFU8WkqCSaRAi1j1TjJ1bnU+tZbrzhqKnvz5
	k22v9vdArZdYvDx654OntPD21aa1x1Z028MTc1LAmBKv34YV4KF/0Dx5PsaOSzr5
	a4jRS60nmFxCUhNE1MB9plh2Q/tdJ5nNPp4SHC4kTgs6bdyY7nDwgxwODcCHPDSV
	BBKM2cGR2cEmiRKXqzpI+p1hbfGdmMaRzK/GD/s2LZjFzyPlrmBTrhndjO8MSq6p
	XU4FxwrlRQf51c8wl6nrrBnOsmBSwlH8Y7TThahJVZ2Pk6dzZq3+veepNnKIERhf
	WJzwnI0Fc9Q26RI7g0w0pkKVaDy18c1tyzdJaSVjayJpf1Fxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752701718; x=1752788118; bh=ZlbddsCWyfjSX6TTS5k3/DIJhqdKFYTKpqC
	OijjYGzM=; b=MAes9Lpk0v+NBObEEJK+fir3f/GGtlQNXhbwQUZgZMYvShTiDRy
	dcpxIelkNsvzitpMSyjAVxUTECtWY5VA0qG5xuZLq/DrfwxyJErQqRDAWce7tSP7
	cmA8Ga3Kct3LHPQNSnpXyfKOlsmCtQo1hTLzm4wshMqRNfdiMDuQQaRagWbbqblB
	0vhRWuXbV+a/0ztUvAAJ9yPp6NSVjeJX9VRiRnw347eznzB+8yKBfRDrU7dYjpAp
	s++jxPZQzKIikkvmEnbFvVrzSLNoD021O3tZIZTiIuK5F90xAObzIo+qHrMO0Qeb
	u3p0rhoQgIZh+Sy6PdddHrpij5Ixu5WA0dQ==
X-ME-Sender: <xms:FRt4aHhRONkmE9fHwVuyEO-dpVPxnLAUfTFAPr1-iWWNwfkkhQIxWA>
    <xme:FRt4aEN2FXUWuiitX_FguRjWvnLZNkL4kge8TYwrIfkq38xz8DBkwwshuFHv588Im
    41k62CViDFIEevwoHE>
X-ME-Received: <xmr:FRt4aI7VAWrLOel0VrF4QbOnFeFbrW4dZAoz7e5MWioyCEIOLoiGvClZR8rBoRCka0FLq7T5Fdxn4OGj0LaWFXQ4_mk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekudduteefke
    fffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:FRt4aC3_U7WKEItjpZPsPwVXjPMDFrXnMdh9AFZ2zaDe--XOo769IQ>
    <xmx:FRt4aJb_GY3hogfG5cn-h4cd6N3XoIWyoecaI2IPEErZ0vKTiCtkOQ>
    <xmx:FRt4aKBJj_3jgb6CtxZ2mIWRFX2Mc15ppYaf8NC3qIW_Y-mkgDMNVA>
    <xmx:FRt4aL8QegOMc7YlgEI5lI9wLHasVGoUzT2jJAwURjCtMDQAjDkw4g>
    <xmx:Fht4aB5o_hWCuRNCqYFx2IZxDHOlcPdPpSS3RdwCkmhf0Il4K1kJVwIY>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 17:35:17 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: use find_free_extent_check_size_class() in clustered check
Date: Wed, 16 Jul 2025 14:36:50 -0700
Message-ID: <c6624547086a52fd70e6ab651372f35a05ee7b65.1752701770.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Metadata block groups will not set their size class, while the ffe_ctl
will just go off the size of the request (nodesize), so this will mess
up the proper function of the clustered allocator for metadata.

Fix it by using the appropriate helper that is aware of data vs.
metadata

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ca54fbb0231c..c93d91235dc5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3651,6 +3651,21 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 	btrfs_put_block_group(cache);
 }
 
+static bool find_free_extent_check_size_class(struct find_free_extent_ctl *ffe_ctl,
+					      struct btrfs_block_group *bg)
+{
+	if (ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED)
+		return true;
+	if (!btrfs_block_group_should_use_size_class(bg))
+		return true;
+	if (ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS)
+		return true;
+	if (ffe_ctl->loop >= LOOP_UNSET_SIZE_CLASS &&
+	    bg->size_class == BTRFS_BG_SZ_NONE)
+		return true;
+	return ffe_ctl->size_class == bg->size_class;
+}
+
 /*
  * Helper function for find_free_extent().
  *
@@ -3673,7 +3688,7 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 		goto refill_cluster;
 	if (cluster_bg != bg && (cluster_bg->ro ||
 	    !block_group_bits(cluster_bg, ffe_ctl->flags) ||
-	    ffe_ctl->size_class != cluster_bg->size_class))
+	    !find_free_extent_check_size_class(ffe_ctl, cluster_bg)))
 		goto release_cluster;
 
 	offset = btrfs_alloc_from_cluster(cluster_bg, last_ptr,
@@ -4230,21 +4245,6 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	return -ENOSPC;
 }
 
-static bool find_free_extent_check_size_class(struct find_free_extent_ctl *ffe_ctl,
-					      struct btrfs_block_group *bg)
-{
-	if (ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED)
-		return true;
-	if (!btrfs_block_group_should_use_size_class(bg))
-		return true;
-	if (ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS)
-		return true;
-	if (ffe_ctl->loop >= LOOP_UNSET_SIZE_CLASS &&
-	    bg->size_class == BTRFS_BG_SZ_NONE)
-		return true;
-	return ffe_ctl->size_class == bg->size_class;
-}
-
 static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
 					struct find_free_extent_ctl *ffe_ctl,
 					struct btrfs_space_info *space_info,
-- 
2.50.1


