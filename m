Return-Path: <linux-btrfs+bounces-1705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9DB83AF95
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF78287DA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC0486AD8;
	Wed, 24 Jan 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fEbgKZFt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043186AC4
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116786; cv=none; b=Q3dl4sFCm6h9OBQOQN+WqX3RHM3JEpcxdD10FuL8EaE4izRLOiCTKQONsfNEeUVzReXYslYQdWXozKEjd0WFBPbV2JhX9X0giClSDkv9h6yWyuqfLvpIPLjf1FkbE2g0opPvPJTNn7QiT/B2wez2jrOC/MaX+p8frt19az4vb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116786; c=relaxed/simple;
	bh=3bqo6uIlM7VzNondcvUjpG0wyPXYmqH4gSZ8I4GtssU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eispGRD1Ca0aqB4hxGNBJjTQ2P4S8SVEpH+VUwZcE39PuXiiP9UePbj1OE24WpqD9KDm0HEVUUz8Vmg0sNVyPU/s6tJdHeAZaFy9peLcuQ1YhaO9lwdO3f0sYwbPLwmda3CKZMSD5KRmxgu5v+UgwLLBUXRTAsQ9gmjmpzBnZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fEbgKZFt; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6002317a427so26659187b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116784; x=1706721584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bB2XJl2JZgzIeBCR7t+2npeajEWLjf4KpV2gm7yg5Q=;
        b=fEbgKZFtNljJ68D7XKnDxf6bp7okiAErNPSLX3xTGVjE+BLHQtqUbjtyHnFZeLkR2B
         8Pj7g/+FLJwitsfZ+ghQr+5YPB1NYcLlQ5Oddpydf3JtWqy+3zhSBa3hUHLgxgWVrqUi
         PyWnN1151yLhq3fifPaR0sM+qlvD4LqkCD1cSO6C9WiwRgdBYKoFBi/L3wG/u9yqv51/
         APmDd0mEgRynt0PTyH6kqqW+zxnY5u9doUbEuMal49TiSy94C6bk9N4LlUImvjuT7/Ml
         exHgLAV0LXVDhR3HLBthgSxKhQArrbvjYvDg+8u4QcmaiA2nN0EyKA/mttj6Gd4MwKzr
         BhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116784; x=1706721584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bB2XJl2JZgzIeBCR7t+2npeajEWLjf4KpV2gm7yg5Q=;
        b=uSdu+Utcx47j4edGUCQImr8V4Qr7tt03H8v2zYl1ByEiMpb7gs5mUnAbQFSEQ4G523
         0D/XZKXP5iOeMhLY/ugW3/cMjMvCyLgAFUIChzrGOskOyAB9G9drLgaKn3e+tVT795lY
         o7quu1+brhFAVNc4OYoqhLrMXHWIFG5gx1MUdAJMv1Zv6k9iRjdyIYoaYKpwzdEx1v9+
         w3iUG22NLtGgXdFRqvWgSe0+inJxyLVqgTduKPP0sw41pXHEPhXH/afAkcujXW4pXWTS
         zRbJB5d4Q4YpbgEqH6Op5mSPW/11FOmXgepZw6JPccfCydoyYpD6CQsYJi8RyBGuFG06
         t3jw==
X-Gm-Message-State: AOJu0Yy2cLYwgI/CpQ9PnW4i8AlB4Xmx8KjmYJlQDuESyAP7nKbn4S9Q
	WTV9hSQbQ5ZTblwTRk64Xo3w3APzGHBOePF1hNFu80qJZCLl4waUavfl10x1WeuDGPNFTOqeEO2
	v
X-Google-Smtp-Source: AGHT+IHiKOYfXrYYmy/Q/YkzeQLKiu8yGe6gutwX9jELYtzTyuSZSirmNmBhrfKdmoWUN5fqCU4nhQ==
X-Received: by 2002:a0d:edc3:0:b0:5ff:48fc:94f8 with SMTP id w186-20020a0dedc3000000b005ff48fc94f8mr1092209ywe.39.1706116784545;
        Wed, 24 Jan 2024 09:19:44 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ey1-20020a05690c300100b005ffcb4765c9sm65027ywb.28.2024.01.24.09.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 23/52] btrfs: add fscrypt_info and encryption_type to ordered_extent
Date: Wed, 24 Jan 2024 12:18:45 -0500
Message-ID: <de9ff13d1dc042b764c224d039fbb2a08946e004.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to need these to update the file extent items once the
writes are complete.  Add them and add the pieces necessary to assign
them and free everything.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ordered-data.c | 2 ++
 fs/btrfs/ordered-data.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 59850dc17b22..a9879d35a3af 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -182,6 +182,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
+	entry->encryption_type = BTRFS_ENCRYPTION_NONE;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = qgroup_rsv;
 	entry->flags = flags;
@@ -566,6 +567,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 			list_del(&sum->list);
 			kvfree(sum);
 		}
+		fscrypt_put_extent_info(entry->fscrypt_info);
 		kmem_cache_free(btrfs_ordered_extent_cache, entry);
 	}
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 127ef8bf0ffd..85ba9a381880 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -108,6 +108,9 @@ struct btrfs_ordered_extent {
 	/* compression algorithm */
 	int compress_type;
 
+	/* encryption mode */
+	int encryption_type;
+
 	/* Qgroup reserved space */
 	int qgroup_rsv;
 
@@ -117,6 +120,9 @@ struct btrfs_ordered_extent {
 	/* the inode we belong to */
 	struct inode *inode;
 
+	/* the fscrypt_info for this extent, if necessary */
+	struct fscrypt_extent_info *fscrypt_info;
+
 	/* list of checksums for insertion when the extent io is done */
 	struct list_head list;
 
-- 
2.43.0


