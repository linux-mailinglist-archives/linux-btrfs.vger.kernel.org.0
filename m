Return-Path: <linux-btrfs+bounces-6413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7934092F675
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 09:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FE3B209E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BA4142659;
	Fri, 12 Jul 2024 07:48:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1BC13B2BB;
	Fri, 12 Jul 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770527; cv=none; b=q10Z/EgiR0qECdllmIZUS5Tv5rnoUREzc2mAR81ZC87yQk2lBGHtZhiMDrr9gatB1khvc/j8CTaQVsxH0NT8DrK9mMipCKTped8j+6Us00UhmK1hOGSqy2B6N+hcBfGEHsnKtzI3izxDh03JJYGuShq5hcoxj2rE3NnpusrtZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770527; c=relaxed/simple;
	bh=wYnjBVzTcF/OzalHx2oAQbF/PY+TIdryRfsI0bE4fL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VeSpcGQ8kXOiVCY4USYh2eg3xUVVX04y3Va7YlvDgx5JJ1VFqQ2Qee6sFK8FXkUjNjDJi2djxzMuZcm68IFQ2buSt0dViBxhkh9kZ1BH0f7MxLwkYn4/jmfgamaYEslyR9bq3pBE+0Eenbh77i5Ocfc7xgaLok82n6zx1EUiHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-426717a2d12so10314155e9.0;
        Fri, 12 Jul 2024 00:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720770524; x=1721375324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jqmu7ZRed+yR97RAgoDGzIXlD6UyBcncdYUkhMXLDQ=;
        b=laFzCHZcMp0g0Vs7lK8Fv/ey/GVKGd0PIXSfdd2DLge9HqGb8FbTHzlXgmUEXiN6mj
         3VsNSVQA7ERJvKqou3KCTBagTKhy4S6Xellea9VxxlpRlVUUkAP0o/HL8ELxXJFng+nS
         BQfqISmHj5s0V4chTF8YRj5EcjSNP52oscLhHUPJhqH1+5hDHOhL/+TcWufI0i+Y0j3/
         pcfTOOjNC3jqh2PILrWUBxevGlm5O3hY9mu8BUwT6Lpqzv3CoCuRR/4x/7IVpUEsAjY4
         uJPIrlegAVYRvlSLw5QS6elRgKrtCnISSeJ9sjd7lrhOCC147TXAZ79zKn9r84m0v5o9
         p9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUviKDQ+cnree0YOiXpGoEpv+c9fWSY//xWGpNwl3UwCxKmyr/n8opp2+HXFRrI93i20fn3HeS4UXYJULpqjgnK0FB9h5v9QNVy5iC
X-Gm-Message-State: AOJu0Yx0OcCyIk3+BBFOAM/aDk7QqPuaJjoWKX35sLVVLWYrbCVB8f8z
	Vtp4PPt17uodijMgpVmxK/AOeMml9gKR8MbUAdpmB5DESNz/YVBq
X-Google-Smtp-Source: AGHT+IEeomES8zZlRcnj8cmM5sp6zSmql8wK8MRRHYOYM1ODnDSWDv57/cJmR/d/q5TwptAlJ9EGvQ==
X-Received: by 2002:a05:600c:33a5:b0:426:6fb1:6b64 with SMTP id 5b1f17b1804b1-4279da024e6mr15977515e9.7.1720770524172;
        Fri, 12 Jul 2024 00:48:44 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f73ce200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f73c:e200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d74d5sm13532115e9.46.2024.07.12.00.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 00:48:43 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 12 Jul 2024 09:48:36 +0200
Subject: [PATCH v3 1/3] btrfs: don't hold dev_replace rwsem over whole of
 btrfs_map_block
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-b4-rst-updates-v3-1-5cf27dac98a7@kernel.org>
References: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
In-Reply-To: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3579; i=jth@kernel.org;
 h=from:subject:message-id; bh=C/2veQuXInUAYzzKEwd4xcEWSsj265yrCeC73ehFe4I=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaRNuH/L6b/BmnlfRE8nV6mpy/+VCnyw4sRL5uK694xPd
 t5xnr+kt6OUhUGMi0FWTJHleKjtfgnTI+xTDr02g5nDygQyhIGLUwAmUvefkeHif7d/HtqrH5z/
 Uc89eUPdR/UvrFsvZRRoHmF2a1iz/n4+wz/LdxxNB7fMyS8NntwR5vrw0ZWU7HnTZnvFbVE7b1H
 n/pcVAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't hold the dev_replace rwsem for the entirety of btrfs_map_block().

It is only needed to protect
a) calls to find_live_mirror() and
b) calling into handle_ops_on_dev_replace().

But there is no need to hold the rwsem for any kind of set_io_stripe()
calls.

So relax taking the dev_replace rwsem to only protect both cases and check
if the device replace status has changed in the meantime, for which we have
to re-do the find_live_mirror() calls.

This fixes a deadlock on raid-stripe-tree where device replace performs a
scrub operation, which in turn calls into btrfs_map_block() to find the
physical location of the block.

Cc: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fcedc43ef291..4209419244a1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6650,14 +6650,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
+again:
 	down_read(&dev_replace->rwsem);
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
-	/*
-	 * Hold the semaphore for read during the whole operation, write is
-	 * requested at commit time but must wait.
-	 */
-	if (!dev_replace_is_ongoing)
-		up_read(&dev_replace->rwsem);
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case BTRFS_BLOCK_GROUP_RAID0:
@@ -6695,6 +6690,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			   "stripe index math went horribly wrong, got stripe_index=%u, num_stripes=%u",
 			   io_geom.stripe_index, map->num_stripes);
 		ret = -EINVAL;
+		up_read(&dev_replace->rwsem);
 		goto out;
 	}
 
@@ -6710,6 +6706,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 */
 		num_alloc_stripes += 2;
 
+	up_read(&dev_replace->rwsem);
+
 	/*
 	 * If this I/O maps to a single device, try to return the device and
 	 * physical block information on the stack instead of allocating an
@@ -6782,6 +6780,18 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		goto out;
 	}
 
+	/*
+	 * Check if something changed the dev_replace state since
+	 * we've checked it for the last time and if redo the whole
+	 * mapping operation.
+	 */
+	down_read(&dev_replace->rwsem);
+	if (dev_replace_is_ongoing !=
+	    btrfs_dev_replace_is_ongoing(dev_replace)) {
+		up_read(&dev_replace->rwsem);
+		goto again;
+	}
+
 	if (op != BTRFS_MAP_READ)
 		io_geom.max_errors = btrfs_chunk_max_errors(map);
 
@@ -6789,6 +6799,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	    op != BTRFS_MAP_READ) {
 		handle_ops_on_dev_replace(bioc, dev_replace, logical, &io_geom);
 	}
+	up_read(&dev_replace->rwsem);
 
 	*bioc_ret = bioc;
 	bioc->num_stripes = io_geom.num_stripes;
@@ -6796,11 +6807,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	bioc->mirror_num = io_geom.mirror_num;
 
 out:
-	if (dev_replace_is_ongoing) {
-		lockdep_assert_held(&dev_replace->rwsem);
-		/* Unlock and let waiting writers proceed */
-		up_read(&dev_replace->rwsem);
-	}
 	btrfs_free_chunk_map(map);
 	return ret;
 }

-- 
2.43.0


