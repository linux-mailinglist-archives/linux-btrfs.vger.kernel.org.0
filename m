Return-Path: <linux-btrfs+bounces-9513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF459C599A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 14:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEEE284BBF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A71FC7D0;
	Tue, 12 Nov 2024 13:53:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07D1FBF6C
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419632; cv=none; b=CN8hlTQCJh2CCBkv04Uk9h1L3/DoZ6I16AvoNG08wCgjlrvOXn+TQpEWHg4kie7mTq8g0urg4ztEOUEIbcQEKzPPf1Bzwlz6oeVJco8Ijp/PaiBVP0oJE7Cclh1Mee7oQei4GwCfBvb1/PUaiksNb2z1EIaTODm/EI8rAHDc1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419632; c=relaxed/simple;
	bh=AXo7o/yqHu87lI5ssNWcPwJpKR87WFYZp3HOduRrgDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVDnyWjkvMo2p1eBStyUsbXk2lgZ6+tPio3nbFF+gzFSRCc3uwdVPwid5YoOi7pheQlrKkjG9deiHIRMxxxX0cHamoLzFT9OLrAKNrdoct/kjEpYxPsbxLmsOwVRbea9UfTE2nUMqkV/ygjP6qMh23XdnjpRpLhCtLVc+cCttQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431695fa98bso45020265e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 05:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419629; x=1732024429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xX86HIs6z6DZE+HmX0XbypC7O/AkKmMe7v9t9bFRKU4=;
        b=BTFQfNmOJJh4khZh54OLahEZCMdqZAAadq+TKB/myrYSFSgapAu5Qra1G9qVlY1Z+n
         MHK5atbfYiuq5f3E2/9V2L21MkGnztlB7F/InE0KL7BUIXfIJ/3gYDdP3Kl9DKJeb6JO
         qeayKGM6WvvF/4ND7F04YvWEasAxwBcHP8SJJEpKzG9bkAXenY1j37bqWp3AUgqYQoSM
         SBhQz3IqHtM3+VWgazsHOzIuJcvM069hDLmMNw0sISdko4ElGnOknqu5fKachR4dE/Qk
         OOcnopPy7xyR9BWOZ8bosWt1HJvReA6gAgoeMj6iekDlfDhks5uCs+jvYFFuD9pcIZi5
         fWLg==
X-Gm-Message-State: AOJu0YxFX8tr0SV1d/mLcaINIChP8cv2GxR/yjdqD47SIWQs6CyTUYti
	5//xP4epILJ6Y2AwQtlIxp4v+gacayX3kwOjqSHwK5HBGGNIJxF7k8hhOQ==
X-Google-Smtp-Source: AGHT+IF/VwpyPha7GT3ThQjjjQwfKL4xI8JKHzB5Y36IUpglSIv2wfNYkowkzMqrljizGlQeRFOE2g==
X-Received: by 2002:a05:600c:4f04:b0:42f:310f:de9 with SMTP id 5b1f17b1804b1-432b75099c1mr121104695e9.15.1731419628502;
        Tue, 12 Nov 2024 05:53:48 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a1f8sm253520825e9.30.2024.11.12.05.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 05:53:48 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH v2 2/2] btrfs: simplify waiting for encoded read endios
Date: Tue, 12 Nov 2024 14:53:26 +0100
Message-ID: <efda9415bfe4a33b764d82fe9f7a522a23b4586f.1731419476.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731407982.git.jth@kernel.org>
References: <cover.1731407982.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Simplify the I/O completion path for encoded reads by using a
completion instead of a wait_queue.

Furthermore skip taking an extra reference that is instantly
dropped anyways and convert btrfs_encoded_read_private::pending into a
refcount_t filed instead of atomic_t.

Freeing of the private data is now handled at a common place in
btrfs_encoded_read_regular_fill_pages() and if btrfs_encoded_read_endio()
is freeing the data in case it has an io_uring context associated, the
btrfs_bio's private filed is NULLed to avoid a double free of the private
data.

Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cb8b23a3e56b..3093905364e5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9068,9 +9068,9 @@ static ssize_t btrfs_encoded_read_inline(
 }
 
 struct btrfs_encoded_read_private {
-	wait_queue_head_t wait;
+	struct completion done;
 	void *uring_ctx;
-	atomic_t pending;
+	refcount_t refs;
 	blk_status_t status;
 };
 
@@ -9090,14 +9090,15 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 		WRITE_ONCE(priv->status, bbio->bio.bi_status);
 	}
 	bio_put(&bbio->bio);
-	if (atomic_dec_and_test(&priv->pending)) {
+	if (refcount_dec_and_test(&priv->refs)) {
 		int err = blk_status_to_errno(READ_ONCE(priv->status));
 
 		if (priv->uring_ctx) {
 			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
+			bbio->private = NULL;
 			kfree(priv);
 		} else {
-			wake_up(&priv->wait);
+			complete(&priv->done);
 		}
 	}
 }
@@ -9116,8 +9117,8 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	if (!priv)
 		return -ENOMEM;
 
-	init_waitqueue_head(&priv->wait);
-	atomic_set(&priv->pending, 1);
+	init_completion(&priv->done);
+	refcount_set(&priv->refs, 1);
 	priv->status = 0;
 	priv->uring_ctx = uring_ctx;
 
@@ -9130,7 +9131,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		size_t bytes = min_t(u64, disk_io_size, PAGE_SIZE);
 
 		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
-			atomic_inc(&priv->pending);
+			refcount_inc(&priv->refs);
 			btrfs_submit_bbio(bbio, 0);
 
 			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
@@ -9145,26 +9146,26 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		disk_io_size -= bytes;
 	} while (disk_io_size);
 
-	atomic_inc(&priv->pending);
 	btrfs_submit_bbio(bbio, 0);
 
 	if (uring_ctx) {
-		if (atomic_dec_return(&priv->pending) == 0) {
+		if (bbio->private && refcount_read(&priv->refs) == 0) {
 			ret = blk_status_to_errno(READ_ONCE(priv->status));
 			btrfs_uring_read_extent_endio(uring_ctx, ret);
-			kfree(priv);
-			return ret;
+			goto out;
 		}
 
 		return -EIOCBQUEUED;
 	} else {
-		if (atomic_dec_return(&priv->pending) != 0)
-			io_wait_event(priv->wait, !atomic_read(&priv->pending));
+		wait_for_completion_io(&priv->done);
 		/* See btrfs_encoded_read_endio() for ordering. */
 		ret = blk_status_to_errno(READ_ONCE(priv->status));
-		kfree(priv);
-		return ret;
 	}
+
+out:
+	kfree(priv);
+	return ret;
+
 }
 
 ssize_t btrfs_encoded_read_regular(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.43.0


