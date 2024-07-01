Return-Path: <linux-btrfs+bounces-6072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5DC91DC68
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 12:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C5DB23496
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 10:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFFE14A601;
	Mon,  1 Jul 2024 10:25:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156CE14373A;
	Mon,  1 Jul 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829530; cv=none; b=Ab/iebT9EhurT+wXiCK5xv0CGb4X+P60hlsd2loy8hHbg7Iy6q2Sl0FCWKZ/PQdq0gVTZXV70YxTddBVyKN+a+Aj4wmAnQHe8txCLR3ZJSWdkh+7ZeLPOnwnUtR5XWqTJ+Cu1gvRu03SGdOCdo72b/LbGVR6r1FY48VhKRocInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829530; c=relaxed/simple;
	bh=s8ZarDR4XS9a3c2Cd4LDAESM/KS7/anxARtZNbWCb1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMmBajZWo0yg72qyb5M7dzGlwmaenXMWn596nbM8gw9Uz8w4a2/eTKE5+WEx/XMTNNjDi7zpunxlMZCzMNjz+7aJ3QSltJqCYqDq8BhKLrHvSfiss1aeqPQGNWtje13hpkzB1UKAblKwkRv3VN8zwMHWwhS66hJ3jgCcwCHCswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111b0so24559a12.3;
        Mon, 01 Jul 2024 03:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829527; x=1720434327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KPpjUc13iqbgrbu6+Pky7AZs5MQgVb7sL8cFHoyy6o=;
        b=G5Q5A3X5rFD5dvmJGwh47UIeTyzd33ONjL1W/ZXrCi7IAgC+0znC2CywLIyrBzDlq4
         o9q/xvPXSiP1loAt8OaCRPXgn8f/zv2i/LxnaEF1tCpM2M32tseX9HG7+cRIkmWvx/JY
         /P9ulAgGnpw5/y/wY1OiVGoXMSZnldvlYpWbaIWX2TxqnAuZvkKxatX94OlHNSogHhhH
         ZCSBPcHRuFiZhwoWvS3PHBFpwNA0G9tMpPEE79vlZOooIEncojCf+O2QA9q02+gS2FJf
         XyQw/TBI+n2zK+vnfkCP0WjE/h6M7z3o74c4WlY+J5GcX5u8c66jNx+eLdQ5sp6o6guy
         HLcg==
X-Forwarded-Encrypted: i=1; AJvYcCUsZ5lsefJVJ/kYehNnnUCzPUMDfa1sccZiKGgUJCdoeiyN5l031Gv3GZrpqyCxL3IlsvJqlPtYUhk5VilbQ93B5eaNty3cpZEL32S+
X-Gm-Message-State: AOJu0YxmE5kgjrbRf+xgCmh/MIzAzQwxHVpWZ5hVraEcUwPyEatm/FZR
	Ak/N4BQOJ1XR1vbukB+9iqZbOexAVsG6MLR1BeKyjr1iUaR/gPyCblzyLg==
X-Google-Smtp-Source: AGHT+IFJvzp0aeBO2IONr77eBrmZr/lVps3WXS29PCmyT1B4ZXN0BB2auNZ7kD+596yxMMjllD5jIg==
X-Received: by 2002:a05:6402:5107:b0:57c:6ade:d8f5 with SMTP id 4fb4d7f45d1cf-5879f69aff4mr5114637a12.21.1719829527380;
        Mon, 01 Jul 2024 03:25:27 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c83583sm4238901a12.5.2024.07.01.03.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:25:27 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 01 Jul 2024 12:25:18 +0200
Subject: [PATCH v3 4/5] btrfs: don't hold dev_replace rwsem over whole of
 btrfs_map_block
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-rst-updates-v3-4-e0437e1e04a6@kernel.org>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
In-Reply-To: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3452; i=jth@kernel.org;
 h=from:subject:message-id; bh=7HqQqz7PhsBmLZ1BQWPpYtyUVF2OZsMrQjoXL2UBmZ4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQ1tQiFzzx4U3VDQHPev68vcpc0lpmY/WrTUXj9ZnKRm
 ZoYx1PGjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZiIpzQjQ9s/z8s6CSEtfuef
 qs3cINn2ev17OSXLw7PlrKsXntrfE8zw34Mp7t56c1+roNVBkga3dke+PWfR8uuj6rKLR+4vuyy
 RyQwA
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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


