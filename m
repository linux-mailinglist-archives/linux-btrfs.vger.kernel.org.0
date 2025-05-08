Return-Path: <linux-btrfs+bounces-13843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E59AB0402
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 21:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61BC3AB35F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9159B28853E;
	Thu,  8 May 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JQMxmlHi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KboFOJXE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BFC21D5B6
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734003; cv=none; b=u4wk8P6f/uZysVLpBBNHY0pcY9HUviqxwuQKgpEPQkD7wY/JvDx8gpGoGUW3DUpynRw4d8URYMFRE3sdXIkK8Fna8+QbGY17EFjDyxUamgGen6fArGDQkU7CxVGB4y2AKTMPsBHphIjkRh6kbqRLhZKJaIKwCSfOklP7SrHLghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734003; c=relaxed/simple;
	bh=97Y87gjPk40SToe9h6w1VMP69plrZGYinOjKgabrQCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1QKmMLtZBbSgz56XrbjGcQGaKQQt0vg3629yV/i1F87hync9ej1nNWKLKYDmFCtSYZVFSRwYLJweAj/k4lFBJKP+GjfGjO3iVdYkZw5HWJC2IW1fduu/8fd8xIVEm5JQthzWUdH6h8I19TO+2ATbqrntgef3e8aRlP1ZpvtJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JQMxmlHi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KboFOJXE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D48F913801BD;
	Thu,  8 May 2025 15:53:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 08 May 2025 15:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1746733999; x=1746820399; bh=13UcTWQ1MD9XUhV4WVJPr
	Jo3oeHJykUBRZmfmi/d+BE=; b=JQMxmlHipRjJnx80s7yDbM1jbfNeMF4aUphxG
	o8QMQPXT4otGdjTwpXSS/NrtlX09y9HjLzR77EgyaGawuhnKze25Xr+lL3ClvqAg
	5qEso92DKjmcmBsM8Z63ht4ViJj1A1wHLarRktvjlyakU0lwVpGhCWxs60O44D9u
	qH7dm3A42P7028TnAFjwpsmOeCdF6AM6N9nAhx6etW/4sdW3BhzVi06Rx8ayLgUu
	JU7i1UGwU6mq79m4ThsvgDfdt5BTRieSBhx4WbY4dLCA2Vmu/gbcjYKZBuAbljwU
	3kPET60aW0/rysg+3/Lv13+S5Mx3ZCogEZ9ICDfojWnfCqYJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746733999; x=1746820399; bh=13UcTWQ1MD9XUhV4WVJPrJo3oeHJykUBRZm
	fmi/d+BE=; b=KboFOJXEZUPS37oFLw5kOZH+ga/Y/3lp81kN5eDCytvG1rO/oU+
	TrOfPSdOZL7xQPy5b5oe6hq/HS86hChEOt7r5IzR2pfnhSlmmS1WK1wK0SPrT/z5
	+53jA6Y3RI5ASX9J1YyvPoNKDs+MavmRm3TlMEFBYI1zABi/QFLQLnha/zDBQSrU
	dx7PADrYl8a1ZDQ/hfAH9Cev+I7C3Xqx/B9ZHnNtCaRNZ0Hw+ZZgw+UunRexKPGL
	EwyePlrY1yjSIrN8HBWWnA9Grh6wu5iom49w/5d2iKpD24mBSeiU/7MSxjZP3tc+
	xEZLioBiYcMR8bSGrbXZJ8/r+ah1b4a7nYQ==
X-ME-Sender: <xms:rwsdaIbLNghuEZU9N8WSZx_vqF1XO8ZaUHtBhBcTsAISiuVwMHGXJw>
    <xme:rwsdaDYordUqN4i-lZNykEpSsdbUNM6jYoF7RgE9PDvGo3ViDrubwGXWQIVy-Tqje
    O9nNQ7QK1nXZbIqGzk>
X-ME-Received: <xmr:rwsdaC_7AmprdcAEyH4H-pvFVtPcZO93yxQT-JAsyL1UVdGj2EqfTnX8nJfjC5f_I1AcXqCzbOrhA-r_r4-TIXqvQQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcu
    oegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudduhfevvddugffgge
    fgkeeggfdvieejgfegkedvudetkeehhfdvffeugeevfedunecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhig
    qdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvg
    hlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:rwsdaCqZKGc5GRflEs8VWm_GCnSEcq4fUx-deKOcAMK8KMK0KE4J4w>
    <xmx:rwsdaDq34EDeYvAZPS4raiDsndj4-0WBYD9grmINDksb4q7R52GPyQ>
    <xmx:rwsdaAS8qjq7Jh1EWZ2TqJSh1F_MeTLpAOE2aoeBgVw2EvxXwD1feA>
    <xmx:rwsdaDo3653Mrl0pSVahSGh4YGhKUS3YW-Pnva3XTuikg-PgLnvNEg>
    <xmx:rwsdaOF_TgFirKWeZv9K-jUK5rhE0Af72691QQG-fOlUwxah1Lpo4T0B>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 15:53:19 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: fdmanana@kernel.org
Subject: [PATCH v2] btrfs: fix folio leak in submit_one_async_extent()
Date: Thu,  8 May 2025 12:53:56 -0700
Message-ID: <88fe9938eed8a7ca2dc9f4fe3a49b565b8441c1f.1746733876.git.boris@bur.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If btrfs_reserve_extent() fails while submitting an async_extent for a
compressed write, then we fail to call free_async_extent_pages() on the
async_extent and leak its folios. A likely cause for such a failure
would be btrfs_reserve_extent() failing to find a large enough
contiguous free extent for the compressed extent.

I was able to reproduce this by:
1. mount with compress-force=zstd:3
2. fallocating most of a filesystem to a big file
3. fragmenting the remaining free space
4. trying to copy in a file which zstd would generate large compressed
extents for (vmlinux worked well for this)

Step 4. hits the memory leak and can be repeated ad nauseam to
eventually exhaust the system memory.

Fix this by detecting the case where we fallback to uncompressed
submission for a compressed async_extent and ensuring that we call
free_async_extent_pages().

Fixes: 131a821a243f ("btrfs: fallback if compressed IO fails for ENOSPC")
Reviewed-by: Filipe Manana <fdmanana@kernel.org>
Co-authored-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
* Make it safer in non CONFIG_BTRFS_DEBUG builds by also setting
  free_pages=true in the BTRFS_COMPRESS_NONE case where the folio list
  is empty.

 fs/btrfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2666b0f73452..6bd0ecc7f7d0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1092,6 +1092,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	struct extent_state *cached = NULL;
 	struct extent_map *em;
 	int ret = 0;
+	bool free_pages = false;
 	u64 start = async_extent->start;
 	u64 end = async_extent->start + async_extent->ram_size - 1;
 
@@ -1112,7 +1113,10 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 
 	if (async_extent->compress_type == BTRFS_COMPRESS_NONE) {
+		ASSERT(!async_extent->folios);
+		ASSERT(!async_extent->nr_folios);
 		submit_uncompressed_range(inode, async_extent, locked_folio);
+		free_pages = true;
 		goto done;
 	}
 
@@ -1128,6 +1132,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		 * fall back to uncompressed.
 		 */
 		submit_uncompressed_range(inode, async_extent, locked_folio);
+		free_pages = true;
 		goto done;
 	}
 
@@ -1169,6 +1174,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 done:
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
+	if (free_pages)
+		free_async_extent_pages(async_extent);
 	kfree(async_extent);
 	return;
 
-- 
2.49.0


