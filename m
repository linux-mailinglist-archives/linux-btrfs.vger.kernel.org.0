Return-Path: <linux-btrfs+bounces-9421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56799C3ADD
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 10:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1B71F227A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2822175D48;
	Mon, 11 Nov 2024 09:28:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C151553AB
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317323; cv=none; b=l2j9fF6IYY1NDOgeFjc8yjd7uZfTl76zrB+YZFmEQQSGY/K1fmoeJyskQIY73Nc49oEFhbD24Nr2suOaPYvSB2relPD1ag86XAt8dicoj22bEkxf+ORKlu7wXe/cgwJP5piABH5NfgTf8FKrnZezlZhLhpAXwvSP6sR3pMioIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317323; c=relaxed/simple;
	bh=c2x7qal3yovR0rUMs48xNVcE8vGoUHygiOqg/EdAugk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rk9cQoUG52UOHJAdj77mqOQ1NDDZpNNrwJsuODLk4Fp66mCkbzNQAZLAHQmuCQJm+beNmMSySefxY8SPpfuWwpI8C/bIHvducemb8J0tvAiYWAJ6R4GNe8LANtjwWBBHvxf+5qewkKFVyMn6t44Rgb+gGzG65UTuzFpwoKVtQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so37604775e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 01:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731317320; x=1731922120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PfmCXdSTFO6/rEm+dGC66+lP9B/rpowz2PMIhLnd8k=;
        b=Ahr97kUeI1afIYP/0Bsaqft6+qsUxrIl1+rGjpGvm/8TOWiQ47g4E+b1fbVCIe6+Ni
         p1HGMz32HDTBQNoq8kf5hi4+K5fuGldrmSE/xNDP3Ria8hNCwI9BHQgFhFczGV1GLLjA
         TdnSfoGTtS9ztzwxjFKCiH4y/EP4WdEm7rfbYv4XmhX1KEtEzxLmYmcEPq+NuWbM52bx
         qr5Py8WHJKabiD++g/tVwlojxyttnUDEzWaxKCZYfN4GjXuMkJ2uSCholO40wCdP5ia7
         UnGtF/zfF2jX36A1OFNfSRssvBdIMd+J8nW5Q6euWbQWFQ5QZ9+gbtiJYPlCbqItRm0R
         U6Sg==
X-Gm-Message-State: AOJu0YzCSlcb0pua6zfpQp/AgsISu+tQ20RugA1ayVyfWFld/LwcWzuF
	b1jTI0MyQzy+m1a8rrqmhwF0bmOuQpTFlJY3clz0QhGraGPj63NcJV01ag==
X-Google-Smtp-Source: AGHT+IGDybBo4x6fTrQTGF9jqDz6RUOiOInjUo0XBd5oeqoCYuwb4IxobEAkiWBrjt0NpBM14362kg==
X-Received: by 2002:a05:600c:1392:b0:431:53db:3d29 with SMTP id 5b1f17b1804b1-432b750a281mr106677715e9.18.1731317319788;
        Mon, 11 Nov 2024 01:28:39 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c202asm173711505e9.30.2024.11.11.01.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:28:39 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Mark Harmstone <maharmstone@fb.com>,
	Omar Sandoval <osandov@osandov.com>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 2/2] btrfs: simplify waiting for encoded read endios
Date: Mon, 11 Nov 2024 10:28:27 +0100
Message-ID: <22c7231a2ce9c0c7c187dff159be1c868d783765.1731316882.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731316882.git.jth@kernel.org>
References: <cover.1731316882.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Simplifiy the I/O completion path for encoded reads by using a
completion instead of a wait_queue.

Furthermore skip taking an extra reference that is instantly
dropped anyways.

Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cb8b23a3e56b..916c9d7ca112 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9068,7 +9068,7 @@ static ssize_t btrfs_encoded_read_inline(
 }
 
 struct btrfs_encoded_read_private {
-	wait_queue_head_t wait;
+	struct completion done;
 	void *uring_ctx;
 	atomic_t pending;
 	blk_status_t status;
@@ -9097,7 +9097,7 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
 			kfree(priv);
 		} else {
-			wake_up(&priv->wait);
+			complete(&priv->done);
 		}
 	}
 }
@@ -9116,7 +9116,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	if (!priv)
 		return -ENOMEM;
 
-	init_waitqueue_head(&priv->wait);
+	init_completion(&priv->done);
 	atomic_set(&priv->pending, 1);
 	priv->status = 0;
 	priv->uring_ctx = uring_ctx;
@@ -9145,11 +9145,10 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		disk_io_size -= bytes;
 	} while (disk_io_size);
 
-	atomic_inc(&priv->pending);
 	btrfs_submit_bbio(bbio, 0);
 
 	if (uring_ctx) {
-		if (atomic_dec_return(&priv->pending) == 0) {
+		if (atomic_read(&priv->pending) == 0) {
 			ret = blk_status_to_errno(READ_ONCE(priv->status));
 			btrfs_uring_read_extent_endio(uring_ctx, ret);
 			kfree(priv);
@@ -9158,8 +9157,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
 		return -EIOCBQUEUED;
 	} else {
-		if (atomic_dec_return(&priv->pending) != 0)
-			io_wait_event(priv->wait, !atomic_read(&priv->pending));
+		wait_for_completion(&priv->done);
 		/* See btrfs_encoded_read_endio() for ordering. */
 		ret = blk_status_to_errno(READ_ONCE(priv->status));
 		kfree(priv);
-- 
2.43.0


