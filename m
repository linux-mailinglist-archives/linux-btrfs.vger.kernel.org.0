Return-Path: <linux-btrfs+bounces-6232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A5928B65
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D98286F59
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472D616EC10;
	Fri,  5 Jul 2024 15:14:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3EA16E863;
	Fri,  5 Jul 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192444; cv=none; b=HJfwSAXYaX3cazGwK+ddy/XfYVjjmBV58DbXiQlOAeO1Ou1ESQt91XcnuSaGTTXPHmJGH4DuN41uCpNEovcHkgACssTNGGf7V8mHx3abVnlG5GQJhG02BKYXTIv2Thcn36/bp5jdN10uvOLGfR/4IaPcZtYSAgFqsGP9CmwHrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192444; c=relaxed/simple;
	bh=3ENqzb97joBmtCY5X5PZSKhZQlDsXq21Lx8PuDDcIc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9mUaLLXoKiHEJ65mIbzFZ73TWepLdrRkiDrxAFVd7iN1Sf/DLgnrcKAy46VhEg/pIrfdO5264iKXzx8QcmPLgB5R+/cm3SBvcbEzgpct0I6Ym+tYQCWMHon7jU0j4ew9cxTx8LdlJ8nQ+vXSzijQ3x1nozxA3++uxplkzFabRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77bf336171so255796266b.1;
        Fri, 05 Jul 2024 08:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192441; x=1720797241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4fJBqRhN/ALwL+ec4EbLWnLhrO++xB8AGJ6zLwkd/8=;
        b=ucRNPQ7oXfWPiYnLkea0+eiAU70soKhTaZ/OfO4CK2ZtcQ9jSuGjFNltKFduR6VAdw
         mvdIi4YKzjvqrdXlLl7GhMl/VLCuSpya34XWWOeiJ/EJOGGOtbErw4CgA4ipKZgK1mkh
         2VEkQ/r4LXuq6P7/feH3XFiKQw0gDWKTxO4EAQnvqdB9L/hfXX0qw9lrtUmPcK6EXX50
         mu8xgiaNrxsgli/dVFHp7NcRRm5eFmkinOOQ0XXDKbMF+qt3JY1hng6+6K16Qcw9eo5T
         BT5n33AzlxkRu2zSZlkAD6CQrOANGAiikWmJAHXSaimughrI77heh6lytvGv/JErgacJ
         ScrA==
X-Forwarded-Encrypted: i=1; AJvYcCXcOcotLP88Ag8kVHRAOkONARw7XrveVo+WRHZFNhRWpJXWSRK/+5d9IKKn2ZoFBj52iYwa7SjW5yPEFzhQzUwvv/cVd6brNbP5T2St
X-Gm-Message-State: AOJu0YwbvTABi8is1QPQoAh7NSV1KdyQO5eINhORbqSfF6yzMgxCmwHQ
	q2jdMO2o9yoTWej7AxzSj0LtB40InD5QUtcVi/z6E412D7MBbvO5Pu1GIQ==
X-Google-Smtp-Source: AGHT+IERhMPGGhZZrLR1D1u7uiSii05k0mKMva35MIAJ7UCZLA/ge1PpSS9I612ZRZCQJPvhlqqRPQ==
X-Received: by 2002:a17:906:4685:b0:a6f:20e0:1d1a with SMTP id a640c23a62f3a-a77bdadffb9mr397468366b.33.1720192441083;
        Fri, 05 Jul 2024 08:14:01 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf6336csm686226566b.70.2024.07.05.08.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:14:00 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 05 Jul 2024 17:13:51 +0200
Subject: [PATCH v4 5/7] btrfs: don't hold dev_replace rwsem over whole of
 btrfs_map_block
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-b4-rst-updates-v4-5-f3eed3f2cfad@kernel.org>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
In-Reply-To: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3501; i=jth@kernel.org;
 h=from:subject:message-id; bh=FSQfegSNF0R+Xzt230/PK3KBm1geIM/wZFBq+IyvNp8=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaR18G4Sjk8zeXlu4fvys18n7Nt7sczMZ17I9hlMgcHTT
 kvd8vk2s6OUhUGMi0FWTJHleKjtfgnTI+xTDr02g5nDygQyhIGLUwAm8mcOI8PSz83i9zomT6rO
 N//6e374vU8cK/d/0zg949a5uVHWHd8CGf7pbL+fFbvjUmGIzEk9bf0bM6z3/LjJ3dmf39EZkR/
 lwcYLAA==
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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


