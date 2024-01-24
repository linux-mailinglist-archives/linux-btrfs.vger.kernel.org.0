Return-Path: <linux-btrfs+bounces-1716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F8C83AFA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F0E28A84C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6106912836C;
	Wed, 24 Jan 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="J7yFUs4F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082B1272D4
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116798; cv=none; b=kM/S40dQ9+4/FVLCvR6JAgWcLQG+8vx0t1FQRdNZ575DlPeNvcEUbo3Vm0yQuCq7Dv+HVA5aP5Arewu++UFgtKC1emiqiKZuaWXYH+TPvHmtFaPh6KDMoj2yvk5JPUo6rNt1HYiCWVSJM6cdJgemAxDoC9IQOGDwT/gAKuWfCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116798; c=relaxed/simple;
	bh=wAYaqIwI5+uBXKQTWA8jqpYbxYa0zQQ5N+yfQ5uTc7w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXNeG8w90EmPfyghk42BR9nCHQmXkOM2kHdQuAj3cdtAX5fwBjzKoxAZfnnRY8u/O1QBM1tEylOTmzeKZs4uRerCqkAc9z1qJKYBGHZ547DS0ztloCRgSfDYoip7W06V9bkhBkQk0mRmtW3OnFKzO8Ui8DIIvregUTIBVBrLVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=J7yFUs4F; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f69383e653so56937197b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116796; x=1706721596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5teHbpuiGJxA/6pn6TS+uYj83hc+FQ+fxWhnMmn8Q3o=;
        b=J7yFUs4F7NYm1OWt65ypB3zU51jzmm/RqITX7I9fPyKhoZXi55GXxRN4pTqAxNhgzP
         /rMYWjvQTtZ6I+dg02HgQneM7tIFXfnbGqppaue9W2mzxaMtA348Z4mP4sxgcw7bEh5f
         HmxfoUyeaEi9h1kHyYzLgIlhbQtlkbhAlRpOecSpAjRQd4K169TsjxMO7joS0dsMt3nB
         M+VPyG6zvcIlN53qKPxnwly7o2WywZqt1jYphh00s7IE0V98YGQVX/AvXm3qAS3rB18I
         wsDdWi+8dpL71TLL5p+BTom6rwYktHw78MyiZjFzzpTMyQmy+uqs1w293hTBxbIHi+Yh
         /vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116796; x=1706721596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5teHbpuiGJxA/6pn6TS+uYj83hc+FQ+fxWhnMmn8Q3o=;
        b=nt/zf7DYyvGW2pCDvtXJLVXziOeS9gEot8sGWXykhiM+yzuToOcF04KPORaX2O+6Wu
         ljQOobzc0vT0UOf3FDQWyS5H/sKaXW/8kzufTAXBFzJRMVeXByH0CgUEkziN7o43mJyJ
         fMnQhTPxjrhd9bRIWcR4OJM5tBHFoe0UjsNxW4tt/EohtasC7nh3t0h1AmXSQVVzyEde
         MePiDVTDPpy/ENC3Zt0JnS9wiQD7nKxyH/fQqioOjA0eIZfWgyPejMlWH4ZVMQEDI5XF
         WpcM4+KLQd0aYO/RCG/URuFBa6QcFIxrOoPWdfI5zKdObIyVJz7h3W0lbD3BO1g9XwLz
         Fg5w==
X-Gm-Message-State: AOJu0YwC36GqQNk6Bp6EbL4WUHXpRSbi3UIY5ECo2LpMGqknEindkt1m
	8if75mJLVMqBBY2q+NZQUMq+R6E+MkTCUizlL/U5BOQcBbOm2xDFHA3w7rK6yrYGIQRDO0M+PZp
	I
X-Google-Smtp-Source: AGHT+IH/KvxbqhRR1jiL84hLDice9gC3ZIXd9KX8Vez2iQvYwPfDHnl3nmQJH+U8l/9TXF6cAJuFaw==
X-Received: by 2002:a81:844b:0:b0:5f7:b18e:9298 with SMTP id u72-20020a81844b000000b005f7b18e9298mr1149149ywf.67.1706116795954;
        Wed, 24 Jan 2024 09:19:55 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bf22-20020a05690c029600b005ef7ecd53absm65828ywb.39.2024.01.24.09.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 35/52] btrfs: add a bio argument to btrfs_csum_one_bio
Date: Wed, 24 Jan 2024 12:18:57 -0500
Message-ID: <595a2e46dae3d18bceb5dfa60ac3ae23760fc800.1706116485.git.josef@toxicpanda.com>
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

We only ever needed the bbio in btrfs_csum_one_bio, since that has the
bio embedded in it.  However with encryption we'll have a different bio
with the encrypted data in it, and the original bbio.  Update
btrfs_csum_one_bio to take the bio we're going to csum as an argument,
which will allow us to csum the encrypted bio and stuff the csums into
the corresponding bbio to be used later when the IO completes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c       | 2 +-
 fs/btrfs/file-item.c | 3 +--
 fs/btrfs/file-item.h | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2d20215548db..fc5c56a9d25f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -537,7 +537,7 @@ static blk_status_t btrfs_bio_csum(struct btrfs_bio *bbio)
 {
 	if (bbio->bio.bi_opf & REQ_META)
 		return btree_csum_one_bio(bbio);
-	return btrfs_csum_one_bio(bbio);
+	return btrfs_csum_one_bio(bbio, &bbio->bio);
 }
 
 /*
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a00dc5f0273f..6264cb837dcf 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -730,13 +730,12 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 /*
  * Calculate checksums of the data contained inside a bio.
  */
-blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
+blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio)
 {
 	struct btrfs_ordered_extent *ordered = bbio->ordered;
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums;
 	char *data;
 	struct bvec_iter iter;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index bb79014024bd..e52d5d71d533 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -51,7 +51,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
-blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio);
+blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio);
 blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
-- 
2.43.0


