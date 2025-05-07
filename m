Return-Path: <linux-btrfs+bounces-13809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F6AAED99
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 23:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569D3502716
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B86D28FAAA;
	Wed,  7 May 2025 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="A9yuwCM5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ru0/Ma9u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453172626
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746652120; cv=none; b=V14y3P5SgHPrjFm13KWQlf7/RX6QGbC7aYJXGP4NXlYS2hCRR5TbB7dcb7Dk1SnzgCcbr+p+tdjrMAm8SoT5VCbwGDxZQkMcqXWeXbBt7W/TVdZnHVnVD3a2CIJ0cwNvLT0V6bzzzvQVKRuzFa3qjMHhCC4z3A7/8xqrJN/9SUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746652120; c=relaxed/simple;
	bh=iSg0bthOdccp1QVK+njpajFHC6Xgz86mDtKRBQ1ptII=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pCMhzLlno99wvmxSXlVWT+7Pv2osdm0vrJHX3Tpreh/jOqy7Ye3xMSaG6oygZTK6hOfW6hTCWnGtDTXaohq59UJIXCk+fHOsVwzPXW9vZvGXUE56q1nZSG3cXCNn/SYA2GmwSh+22aig9/0qEx5jR19iBvauV0kYlwtEYcxZOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=A9yuwCM5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ru0/Ma9u; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E6D313801CA;
	Wed,  7 May 2025 17:08:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 17:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1746652116; x=1746738516; bh=L5ABk4PZfp+JggAxiesN+
	LLJ5KU9Go45u1fcPG4g0io=; b=A9yuwCM5laHUYkH8y5xu1/HaC3NkQE6Y4pGm8
	wnGHFEcggAwhoqD/7d4sqJ1Gyty985R8mq7uBRGTTWseAP/mH+lnrYHMCUxjgU+8
	8Tq2jMltKBEF3YS+QIJuLLQ7uf2sxwM4bOOIHtv+YFHU6Pkixax33m4OPnFrwvv4
	8vCqUd8pIgkXfhuEmV8PM/pT0axsCqJHNcPCdTY/XjoooDCSqyjq4HLmbT5USfkt
	8ZRv9cxmQVPvz+X3KmlTdkVCQ8A3fTQQ9Q4TDtkPTrmvYFPM2CwtbtxPn9Lu8VwN
	EfFCMgdkaxlETIXGzdgCTrd7NlnX1muHW2Er9QUe8WXh/omog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746652116; x=1746738516; bh=L5ABk4PZfp+JggAxiesN+LLJ5KU9Go45u1f
	cPG4g0io=; b=ru0/Ma9u7BgtEC5p4Za5rOaaQGfkLRJt6Ua8iKLkt7HAbyk8Dfm
	nupEAq+pghrqV0mOuhMarkcp4prh6bgE+W4FiRhl8um7jwftcI77pkmOFfBEPkAF
	O910bRk0wmlDzS/N4o4aZ+9wkP/I7XH1otPh/8UNVHysZA6ykehpylO1FQPqmAs9
	3l72m44gaih4bGs4NodTK4cZ0kkRrKxCRMlshf7NESUedBC9G0kx5srCKVEWbejZ
	MhkYp9zIuTjGvGqGGhNKyn+p+Ck6/qc5uqPYsw4pWgAhZg365QxHoPFcnDJdN6va
	HKvYevQaGSNTppoSg+rUsWnnMbbeKJZjEDg==
X-ME-Sender: <xms:1MsbaPBsmd-dRrm5oMnsLvgdjvgXdM1c6lf_ojnancn0-xy07XNGcA>
    <xme:1MsbaFgeaeGLQ9BmIh9T-9kYRw9Bte5N43GHOIUITCgjwPDmr-PVYirmzn8Q7jJAe
    LiHw2mZ8blO5EBaVlE>
X-ME-Received: <xmr:1MsbaKlThau3sv8PfKoYnCDsV8CZUvdY2RywjixBuGlSpI4-mFM5LcmlU8izdZdEa8fFCtEQuSTcJsHiqIi10MzM8t4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelff
    evleeifefgjeejieegkeduudetfeekffeftefhvdejveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:1MsbaBzhncNgli-9SxQo10SVrMRL87ehfbhNhtQY8JvrCk3ib47EJQ>
    <xmx:1MsbaETFiyxfhKniarPnxgTZVJI6wydRTNnTME-RhrweV10nM-1qPA>
    <xmx:1MsbaEayVN4nasHzGFni72uSiLIMz1F3jJ8QC1sAiIm7afcu_iiJGQ>
    <xmx:1MsbaFRdYEE3Aie8GoWhVplPyaa3gC9z9ZFgbFDSzsuSX75NT3Z5gg>
    <xmx:1MsbaPkaOzfq8bTm1GjsjpcoSxszkF_kTtR_Pnwgfz0RaCc9LcemKcT1>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 17:08:35 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix folio leak in submit_one_async_extent()
Date: Wed,  7 May 2025 14:09:18 -0700
Message-ID: <a9458a40fed8e6a27ada539372170d52c45967f0.1746652135.git.boris@bur.io>
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
Co-authored-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2666b0f73452..9d4b99ba8950 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1092,6 +1092,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	struct extent_state *cached = NULL;
 	struct extent_map *em;
 	int ret = 0;
+	bool free_pages = false;
 	u64 start = async_extent->start;
 	u64 end = async_extent->start + async_extent->ram_size - 1;
 
@@ -1112,6 +1113,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 
 	if (async_extent->compress_type == BTRFS_COMPRESS_NONE) {
+		ASSERT(!async_extent->folios);
+		ASSERT(!async_extent->nr_folios);
 		submit_uncompressed_range(inode, async_extent, locked_folio);
 		goto done;
 	}
@@ -1128,6 +1131,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		 * fall back to uncompressed.
 		 */
 		submit_uncompressed_range(inode, async_extent, locked_folio);
+		free_pages = true;
 		goto done;
 	}
 
@@ -1169,6 +1173,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 done:
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
+	if (free_pages)
+		free_async_extent_pages(async_extent);
 	kfree(async_extent);
 	return;
 
-- 
2.49.0


