Return-Path: <linux-btrfs+bounces-6359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFC092DFFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 08:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AD7B229A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 06:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F631311B6;
	Thu, 11 Jul 2024 06:21:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713C12DD95;
	Thu, 11 Jul 2024 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678904; cv=none; b=FKwzhEB4fjAlbPWv5R+LRt3yfYRcZpTJFEp8tY+Gk98U3rAZqho7pTk5fTk2/ZoPJxFQenE62hUEY3dmLqPcCBKDctJbzhAwIYwP0/syU2lnYkh+bRZQYZlrTt8WkUJfbjhrNjFFET01JFU34pr1EtdDI6iTD0hAaudUM3jKaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678904; c=relaxed/simple;
	bh=wYnjBVzTcF/OzalHx2oAQbF/PY+TIdryRfsI0bE4fL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKfkOGhOK0TSq/wOXV9e7MVZqEsHNObz5h9MtkIOYr4XfXvhp0isK3mKT8TAAH25IV1xwfM6VnFyXfLOlgkoKa60Q2rYOiFtWe8XaklspGptEmUVToX/a5QmoZ06S2yWB+d2t62IKyIRl/KVcXPAWZneLZFDI11Cr2ROJ8FE52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5957040e32aso370898a12.2;
        Wed, 10 Jul 2024 23:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720678901; x=1721283701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jqmu7ZRed+yR97RAgoDGzIXlD6UyBcncdYUkhMXLDQ=;
        b=i3NfatfxXqSuYYtvb9jfvsr8YUGBbyxBmmcEF48Mofe8QnSq/zCQ1Rkj4JWJ7K0vra
         Ei37n5rJzwLP0ZgQB0CDwgnSpyCtIv1zPlxcZqMKtk0tjw54tikk+MOlVz/IACuWL7lW
         uz2LLuJEI09FGMf+pfDv8R+RLZh49449B0NAEFqRbys85C3rQc35KSXz1noVRMcN1jfv
         V6VAciZgxWk1BlL3Kqml1vQjNHIxBP+EcqjliWc1MKvq185lAo322FjZWP4rXET5GIeo
         nGxrbG5pIdMgtKoFll3j0acw4y9zT83l0jLVjEbl6nB39AHOsibLozW0Y6absfbCXdSh
         M1yA==
X-Forwarded-Encrypted: i=1; AJvYcCUzSii1TLToGoTb3NHuSbqSQ5NXGi+cGfzXT4ZxYw7FnoU0ZsU2L4LoYL6ik5AblTmBmmbIHtVc5Q31STzDdKvKNh8O+qjIfRdcMIrM
X-Gm-Message-State: AOJu0YxQlyqbVn5/1eO6W3sXrBpccTazE65EKmZ30ELdiQ9qmOjXRtzM
	Ugk4RJlBq+LrVzff2o8Wi7ellvTNtw3d83E+jlBndWuQEexK5wny
X-Google-Smtp-Source: AGHT+IFxTA4CMWXVbNisHI+JmfEEAvtFP1tM1wH5lUZpxTZb7pJ1mtNiyc2QktHf6nW8qgE2x6Mn7A==
X-Received: by 2002:a05:6402:430b:b0:58c:3252:3ab8 with SMTP id 4fb4d7f45d1cf-594bcba83fcmr8029083a12.37.1720678900708;
        Wed, 10 Jul 2024 23:21:40 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f73ce200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f73c:e200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff73bsm224815266b.101.2024.07.10.23.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:21:40 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 11 Jul 2024 08:21:30 +0200
Subject: [PATCH v2 1/3] btrfs: don't hold dev_replace rwsem over whole of
 btrfs_map_block
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-rst-updates-v2-1-d7b8113d88b7@kernel.org>
References: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
In-Reply-To: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3579; i=jth@kernel.org;
 h=from:subject:message-id; bh=C/2veQuXInUAYzzKEwd4xcEWSsj265yrCeC73ehFe4I=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaT1V36s6zi7/sO1kp16x1NzPijJ3Vae+Uxw280Gow/Xd
 uzKZ26u6ChlYRDjYpAVU2Q5Hmq7X8L0CPuUQ6/NYOawMoEMYeDiFICJ8MQyMrRflVzh9Ug+JkXx
 6l0T3YvlxziWi26MfrHoqNou1h3H7ggx/A+5cPGWqErSn9+Xm/Sl/y/433BAy4x/3vZJc2Zaz2J
 ifMcPAA==
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


