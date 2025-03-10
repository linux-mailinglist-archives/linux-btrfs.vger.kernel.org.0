Return-Path: <linux-btrfs+bounces-12161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB3A5A462
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 21:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92EE7A3B26
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6A01DE8AB;
	Mon, 10 Mar 2025 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="nXrWrPuL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aydbTMs+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00B1DE4EF
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637188; cv=none; b=tGzCJFykvpmVqcV4D4tJ8HAGPsoHq3eY3787gab9OrHE5j+Ovu7tkF12GTNsEMLkZzj1Ac6ugIyMaqTXxFKFUk6obimneQSrKAbyWYe6GJQphsiMetCVwd6B/4lcs1TRWSz+QC/nFG2so/XNJ52SJgWprfqAPg36Ye9M5NoGp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637188; c=relaxed/simple;
	bh=60UpVM4h3IBiIqIK12f59Twv61/aMzVeCnf8i+hF2Hc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drtr75eMlTEB20+b8k8Fylmle9v61ay8/VSiN4OhYVgk6u9a+q7K6V0Iul+w3cq/+3ZApDsdJ/+e2+SXrVcx4aqOIYcAm8vNG5vKxkRXES1Hn5PE1xiPI2+jOGXZ8pARAIk5QWy+92JtRnIQIRJIAurna7D5ws3oLdenN69hYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=nXrWrPuL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aydbTMs+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4B4325401FB;
	Mon, 10 Mar 2025 16:06:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 10 Mar 2025 16:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741637185; x=
	1741723585; bh=ZvYkrBp8FBTjhczrjsDx3itZexfG8oeS+u5mj27MUQo=; b=n
	XrWrPuLiSoPiM6a9aSDDsIjLk+oxHID3jGx2bq8j4v/RaLQF7QWVXub8WQz9sycE
	o/StsoQc0XluYTMI6Q9O8Q4U1uSjBJSxBEuFv34tVUVLuJkAsBjEdrTVt/jeEjvI
	BG+yKgDuok9+iDMA+LRFtJ8TEYODIA3+lZvAQSWqmpTRc8kTBbxp01pWg1jgbebK
	fJsmvufpzrlgEHBEHKzuJDdJDn+Qy1C99e/1CAPezGCv/2TAwYOGDJOQjsWAMZ72
	0CK8f7ejs1TynfAKX66v0XjhqgtK/3ArtGea1j2yIPTKUCfqfqx/ozikQA6rw1Uv
	qbTz2cT7JPfS/Eb6xhGrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741637185; x=1741723585; bh=ZvYkrBp8FBTjhczrjsDx3itZexfG
	8oeS+u5mj27MUQo=; b=aydbTMs++EeXR6SVcADSlJQItaCGNmTr55JQSLvAtMJb
	PxLsfqRKK6Z3WL472GD65QY8N+/c5iV834E5KOplfnqy9xzq2SmPUKf9FU/PmVXe
	4u8KppDXVYDOOmyBjM+dleVtCs5fz0KoXwS8eenyPMVetniAX/Wl3HEGMJr6q9t/
	EEG5eVx1ujMCFQXK7pFj+vu16I/JuKfmz6Kt4Ne8TLslDicUlaOk3lgFWjcZ+KTS
	2C05iyfXWh9i8ajCBtVgoGqUoI1q/NlV9A/ZSCUf2WKFNl86b0OAEJEBKs3taICb
	CJQ01I/RG+jEXzmASQXJ6XaAx3rt4vPY1LnJgvi/ug==
X-ME-Sender: <xms:QUbPZ84GQGbQN84VLjn7jPFkKC-Qs0LaPcHww80LvjCA0UR-4jHzuw>
    <xme:QUbPZ94VPkEgSs0q3CWWg3pUUN7UMjGy0cDrcS1jQPNauBfV19VjJ6CqQJ8Sdku_L
    YA2FBFCb6AEUGrMptw>
X-ME-Received: <xmr:QUbPZ7cbHTOM8yZgG4588AKxZ06xMYal7Ha2FWUYmIV1NjaAka7uleKJGILhBBu9muicEgEK-b5KzIeabfHC__9evNc>
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
X-ME-Proxy: <xmx:QUbPZxKj4m21bAOcjNA2QEGk9vYi4Cgcf0BUTt-et4UydS7hRqZgEg>
    <xmx:QUbPZwJf3ZQRtphGFE1U-bHt57SpXB8X1vLON63DWv5c9q-0M6iyNQ>
    <xmx:QUbPZyzcWxj9-ujRWOTVuyAqyLQ9EfiaWga_i2Zjzv8p-2qooPo9Tw>
    <xmx:QUbPZ0LYGXpE6qKS0Ak3NU-3gJKasc7wClb0O6JZgc1MOG-Irqbruw>
    <xmx:QUbPZ3WKoGRfXKzDYxscTjjqM1DOuSDE5stl4T7uUpDXTvPUUl3qjdGB>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:06:25 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 4/5] btrfs: explicitly ref count block_group on new_bgs list
Date: Mon, 10 Mar 2025 13:07:04 -0700
Message-ID: <5ea6c280fbe91b772802313847967ee4c2e89201.1741636986.git.boris@bur.io>
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

All other users of the bg_list list_head inc the refcount when adding to
a list and dec it when deleting from the list. Just for the sake of
uniformity and to try to avoid refcounting bugs, do it for this list as
well.

This does not fix any known ref-counting bug, as the reference belongs
to a single task (trans_handle is not shared and this represents
trans_handle->new_bgs linkage) and will not lose its original refcount
while that thread is running. And BLOCK_GROUP_FLAG_NEW protects against
ref-counting errors "moving" the block group to the unused list without
taking a ref.

With that said, I still believe it is simpler to just hold the extra ref
count for this list user as well.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 2 ++
 fs/btrfs/transaction.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2db1497b58d9..e4071897c9a8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2801,6 +2801,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
 		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
+		btrfs_put_block_group(block_group);
 		spin_unlock(&fs_info->unused_bgs_lock);
 
 		/*
@@ -2939,6 +2940,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	}
 #endif
 
+	btrfs_get_block_group(cache);
 	list_add_tail(&cache->bg_list, &trans->new_bgs);
 	btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 470dfc3a1a5c..f26a394a9ec5 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2108,6 +2108,7 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
 		*/
 	       spin_lock(&fs_info->unused_bgs_lock);
                list_del_init(&block_group->bg_list);
+	       btrfs_put_block_group(block_group);
 	       spin_unlock(&fs_info->unused_bgs_lock);
        }
 }
-- 
2.48.1


