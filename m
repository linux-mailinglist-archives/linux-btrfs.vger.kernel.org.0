Return-Path: <linux-btrfs+bounces-9609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11BD9C7A4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 18:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457CAB2A878
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB3201113;
	Wed, 13 Nov 2024 17:17:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97E148FED
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518230; cv=none; b=AZLbEwtRJoSEFHTb+R0qj5XcNdlUlMlJL6hoovyX7HYsA1x+0SM1DffNrVQrFLXWXf27juuIPt6ZDqqPOHFve05CSo/zag1ELIInDYHQ4jidPVrgnzUKi2AXZ89ssNpUd8PvQ0WX/qgXycPErOMblLeVE9MRVCoQ4SaTVSmIBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518230; c=relaxed/simple;
	bh=gEhjtssTeddhPiuPB273k8ozJ0Hqw1rkrgudaiVcgA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fxg1XE6ZNUoOqWVpvKYYasvAVSq+m0agDTKj+A/8h1htp40YJM2PPcxzhKUG/ibCY2u60xD36B0eBFUnKKUG0ljpZ5TF27bcgMSZo2ScJ/flwtwPReMnFX2p86M+FSi74yQFARoWQ8Ah2snRiiRMXcluSsdHNpLedOOWJ+2SDZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so60224005e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 09:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731518227; x=1732123027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRvjIfwlDJ5hojlXjQaYi4ae+9C5paiKn2ymkrDKrDw=;
        b=NT/lSDYZEWtylrFg5CV65edy+O/n7b6N7RZD3a/lMv1Vpv9z8p/uomauYKN505KKop
         5BweUMvS8xqrAYYmJnwK8zh8WMw0XiaxWfsOu30SBDVprPadd/8OHAZpx5Jgozdzz4GL
         Rq6QcG3taTQwtoblcVqy6/nkN63hDngB5j3hboryCjvjmCIZTkYNu8Zmd0oRPWZs0S/5
         k2FUb6VZrdhZiiEarhbKPWoicyw3I+kRzQD/0iPiW5qCM/c6wPn/zkCP8Lu1INviXHP2
         usAtt/584aja9bUBScLFym1gEcQcOsTvvFmMQQecbRT2Tnr3l+P0SW70lwvfAEj+MrRq
         5Y3Q==
X-Gm-Message-State: AOJu0Yx+VLveenyBGh9n6yLvaOo1EGmvBCeqvZCErZC3KYZQk6ygnY/H
	1RoTJizGP9Gn5S/oDMkqmXecWYW50K1rgFvJSawPN9NjdVaWvRAPxjHy+g==
X-Google-Smtp-Source: AGHT+IH+diRl3drwm3kATel4S4LXW9Wb5olxz8K9lcg5AEqX+9yVaUfFeMy9l1gt95sNX9NllboLew==
X-Received: by 2002:a05:600c:4e14:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-432d4ad33ffmr33761775e9.25.1731518227101;
        Wed, 13 Nov 2024 09:17:07 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea6b5sm19157660f8f.84.2024.11.13.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:17:06 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Mark Harmstone <maharmstone@fb.com>,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v3 2/2] btrfs: simplify waiting for encoded read endios
Date: Wed, 13 Nov 2024 18:16:49 +0100
Message-ID: <59f75f70e743049cbb019752baf094a7e2f044fa.1731518011.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731517699.git.jth@kernel.org>
References: <cover.1731517699.git.jth@kernel.org>
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

Furthermore use refcount_t instead of atomic_t for reference counting the
private data.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fdad1adee1a3..3ba78dc3abaa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include "linux/completion.h"
 #include <crypto/hash.h>
 #include <linux/kernel.h>
 #include <linux/bio.h>
@@ -9068,9 +9069,9 @@ static ssize_t btrfs_encoded_read_inline(
 }
 
 struct btrfs_encoded_read_private {
-	wait_queue_head_t wait;
+	struct completion done;
 	void *uring_ctx;
-	atomic_t pending;
+	refcount_t pending_refs;
 	blk_status_t status;
 };
 
@@ -9089,14 +9090,14 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 		 */
 		WRITE_ONCE(priv->status, bbio->bio.bi_status);
 	}
-	if (atomic_dec_and_test(&priv->pending)) {
+	if (refcount_dec_and_test(&priv->pending_refs)) {
 		int err = blk_status_to_errno(READ_ONCE(priv->status));
 
 		if (priv->uring_ctx) {
 			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
 			kfree(priv);
 		} else {
-			wake_up(&priv->wait);
+			complete(&priv->done);
 		}
 	}
 	bio_put(&bbio->bio);
@@ -9116,8 +9117,8 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	if (!priv)
 		return -ENOMEM;
 
-	init_waitqueue_head(&priv->wait);
-	atomic_set(&priv->pending, 1);
+	init_completion(&priv->done);
+	refcount_set(&priv->pending_refs, 1);
 	priv->status = 0;
 	priv->uring_ctx = uring_ctx;
 
@@ -9130,7 +9131,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		size_t bytes = min_t(u64, disk_io_size, PAGE_SIZE);
 
 		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
-			atomic_inc(&priv->pending);
+			refcount_inc(&priv->pending_refs);
 			btrfs_submit_bbio(bbio, 0);
 
 			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
@@ -9145,11 +9146,11 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		disk_io_size -= bytes;
 	} while (disk_io_size);
 
-	atomic_inc(&priv->pending);
+	refcount_inc(&priv->pending_refs);
 	btrfs_submit_bbio(bbio, 0);
 
 	if (uring_ctx) {
-		if (atomic_dec_return(&priv->pending) == 0) {
+		if (refcount_dec_and_test(&priv->pending_refs)) {
 			ret = blk_status_to_errno(READ_ONCE(priv->status));
 			btrfs_uring_read_extent_endio(uring_ctx, ret);
 			kfree(priv);
@@ -9158,8 +9159,8 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
 		return -EIOCBQUEUED;
 	} else {
-		if (atomic_dec_return(&priv->pending) != 0)
-			io_wait_event(priv->wait, !atomic_read(&priv->pending));
+		if (!refcount_dec_and_test(&priv->pending_refs))
+			wait_for_completion_io(&priv->done);
 		/* See btrfs_encoded_read_endio() for ordering. */
 		ret = blk_status_to_errno(READ_ONCE(priv->status));
 		kfree(priv);
-- 
2.43.0


