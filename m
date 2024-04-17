Return-Path: <linux-btrfs+bounces-4370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D18A8612
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6588DB257FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122751411F9;
	Wed, 17 Apr 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2IEm6qCr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6514265A
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364584; cv=none; b=RDdw24kZz45y29YTAf2b/8chCJCg8X2hYvCsJUu1cJvz4nMwkZVsGnd2Dx/PM42mZrj3sXV1jN7uplfj4NezA63rJFFaV27xLLWGWyAnu0CIL9EnbdlWlumYIxl76qlxEa/+WMCUZao01VoavXv7erYGj3R1ir9Zi9+Ru4MCTxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364584; c=relaxed/simple;
	bh=C2pHpaOwxF4Uy/2iPX/OMPprNTSJ5v7TXP/vU49rI3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jELncPENreFyKjwIYrq/7Q3dEOuHvEzCV7z8zv1bo9MRzNcdeVoRwoMKkMFQk9P12WSjgIX/+L1f7JsSChdjQPuoVqBecz/KFvA/vW01yX2WO1ipKU4WMGw5/jyHNHr1KlG3YYYMaIbJ8TiiP+g/gi3gUjeLFlfTlbJQxhKaRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2IEm6qCr; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78f0628da1eso17932785a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364582; x=1713969382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cD7WSdCurTVd5Mm/482ElKQHrN3Ade6v1tp7omUgaQ=;
        b=2IEm6qCrP2NDkGgoSWtef4xv8DulC5dXKJ8ON60/RKJzO3mIR+uXAJo82nlKOmvhoD
         wdECbi+RB59fDLY2GABUSS7K3a1Y49SauyNZo23dl+Uw4jp9PTHn+3BLfB+QqCymyxd7
         JtMBu24E0ssDuHHAHGb+SAulQvT6mml/b/Zell6/2reSEbqlZVHRpwZ93u/Kd7nIIzep
         eL1YUvSrrnLrkyNFQs3a5kun6MZVlZzdcqbWy8C3C+1wi+w3ABACOqUg8xrHuhlA7iNY
         fDmR76TJEvOm/t24ixq84/chaH77ZT99ZpcIbjapeeuhn9Gk8j5cLApZiJvykcASScAm
         bAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364582; x=1713969382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cD7WSdCurTVd5Mm/482ElKQHrN3Ade6v1tp7omUgaQ=;
        b=fsKRy2yaIaMXaqBFUmwuQjea/odLwbjArIVcDVLn5EWlA84t8FACIfxqIjMHZoKPSL
         WLOg9lgSfv0/WS1d4EdAsoOIdMXXVhhK/xv9AK3eDzZwiu+Jl4IoQymJO8+1z7xsgMK5
         MrQvUS3Zq5A2cKy4zrYO3gsJKiz3i/XHGsgGObWUjTFbjUOXVqtpj0ZvZHkPHwPo7ZAf
         mUcKZBi/FwsJW38M2+6rctgxaXKXVy0LNYh4eoMChtUo1XfDLm82g0FhJf7wufU6UJFu
         iOddt4RfX4s5TjNkydsqNpFPNradka31kV26oJgoLW9z+d9WP0w7wZGuP/s7LjPo3iUi
         5Omg==
X-Gm-Message-State: AOJu0YyXzDuM7S8BfVKf8L7YUVkP5+xnQwc3VzYyFmvEAf2QQ96NzuiD
	75bepksjRSs7eWfXAMfvwz9VSPug9loNgrYCIUp6B4wGt+yvDlXejp5xTt9BgHNCzR/+fexPWTM
	I
X-Google-Smtp-Source: AGHT+IG+GWnupM/XbrQKHAJcdBtoWlOQT37cEldb32+GdnYoBUqZ9W/5C9WF0qAc3224f299SmHP0g==
X-Received: by 2002:a37:e116:0:b0:78d:5f25:ef66 with SMTP id c22-20020a37e116000000b0078d5f25ef66mr18384638qkm.50.1713364581773;
        Wed, 17 Apr 2024 07:36:21 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ou5-20020a05620a620500b0078d5b3b5b4asm8473528qkn.125.2024.04.17.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 13/17] btrfs: push lock_extent into cow_file_range_inline
Date: Wed, 17 Apr 2024 10:35:57 -0400
Message-ID: <c55f19e4ce3d4c1890f80b2d665dc01fcd92ae51.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we've pushed the lock_extent() into cow_file_range() we can
push the extent locking into cow_file_range_inline() and move the
lock_extent in cow_file_range() to after we call
cow_file_range_inline().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e076b91376a9..fcad740b1e28 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -744,17 +744,22 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 					  struct folio *compressed_folio,
 					  bool update_i_size)
 {
+	struct extent_state *cached = NULL;
 	unsigned long clear_flags = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 		EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING | EXTENT_LOCKED;
 	u64 size = min_t(u64, i_size_read(&inode->vfs_inode), end + 1);
 	int ret;
 
+	lock_extent(&inode->io_tree, offset, end, &cached);
 	ret = __cow_file_range_inline(inode, offset, size, compressed_size,
 				      compress_type, compressed_folio,
 				      update_i_size);
-	if (ret > 0)
+	if (ret > 0) {
+		unlock_extent(&inode->io_tree, offset, end, &cached);
 		return ret;
+	}
 
+	free_extent_state(cached);
 	extent_clear_unlock_delalloc(inode, offset, end, NULL, clear_flags,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
@@ -1028,7 +1033,6 @@ static void compress_file_range(struct btrfs_work *work)
 	 * Check cow_file_range() for why we don't even try to create inline
 	 * extent for the subpage case.
 	 */
-	lock_extent(&inode->io_tree, start, end, NULL);
 	if (total_in < actual_end)
 		ret = cow_file_range_inline(inode, start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL, false);
@@ -1040,7 +1044,6 @@ static void compress_file_range(struct btrfs_work *work)
 			mapping_set_error(mapping, -EIO);
 		goto free_pages;
 	}
-	unlock_extent(&inode->io_tree, start, end, NULL);
 
 	/*
 	 * We aren't doing an inline extent. Round the compressed size up to a
@@ -1336,8 +1339,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	bool extent_reserved = false;
 	int ret = 0;
 
-	lock_extent(&inode->io_tree, start, end, NULL);
-
 	if (btrfs_is_free_space_inode(inode)) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -1367,6 +1368,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 	}
 
+	lock_extent(&inode->io_tree, start, end, NULL);
+
 	alloc_hint = get_extent_allocation_hint(inode, start, num_bytes);
 
 	/*
-- 
2.43.0


