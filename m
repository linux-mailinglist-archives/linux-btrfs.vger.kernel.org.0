Return-Path: <linux-btrfs+bounces-19596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4481CCAED22
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 04:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55EBF304CC01
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 03:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7430101A;
	Tue,  9 Dec 2025 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4lsbZ5W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585C2F1FCF
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251493; cv=none; b=Jo+5zbbcx9xG2uliwMZ/2iRhWQ38Tjor5MJN3zhNAaVrKjLepVqTike11VGfwvXN3LiIUVcCM5C2v7fQxYigR+t+KBtwjL0c6UkHUkFSBnTCxCf7jlPcT3ZqdhVqej3FeIp/zdQ0LwvSdCwXOMtNR+bjH4X9ZrCXC8b++c1NMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251493; c=relaxed/simple;
	bh=9gjbMeMDzAmDwV8KEgdt2YJoX16i2f/n3ycRx08X/JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2Bqyu3oRWMw7/g/5z4UGM7Z9V0Cwj7VWBOGd7EKCU8IBSYFiu1kp9n0xVyqECZ3b4tPlpnt3o5vurbsIa7jc7WYA4YPoE6C0Ewe11kJwGHG0d3/lPkanrZsdqQiJXZBxLx0e62PzI79GtIFxWpW2ApdLK0K0siW73lXopZly6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4lsbZ5W; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-bc144564e07so131201a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 19:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765251491; x=1765856291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr2uW6LYiVxQckAaJ0+A799lyNiv74UwCmPg/mK5umE=;
        b=Z4lsbZ5WFhB8yRgjRrQ4tZgBu+eNewcOVCd5Z6z+grRnK8a+paUuHCgD2Lsn1WqA1m
         md0EXHsnnS1klkzKzAWcmS7ncn+C1fK/N7Tr/K7YVAyZdCOQ8toZOxDUKYlxvvz+7O95
         MUk047JGxw+5u4cPrUwmdx5W9f1NFMpZflx9x3V4Umh39J+OqMIkzEH/EVI+DDJX4Q29
         9jVzs+8BkuGYOx/rPCGlI+3+jPo/bTtTIZ07iHpEZVOUOSBQYMn6zVtZhu2YzmaTTPbL
         fJ4ZOzf8Dn5tV174aQccUYNqQxqAIltZFgeKLG7rGM+8P7porEplsBTPg0W4LOQmWC85
         I1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765251491; x=1765856291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fr2uW6LYiVxQckAaJ0+A799lyNiv74UwCmPg/mK5umE=;
        b=dHzuPEr4We/+JNjOcg9X1vWBpmnnT4S3QFU638VlBjjrjdyNLIiL96kChFuwE5cGUU
         lH7RkAVae5vijQURxWc0PHgKAVxtkvnhb1X1tbHX2SaTe8L8Xk3srSzIqkBwa2DMtd9j
         jpitvbuCORTMqU0emEMoot6dGEMcjXU/CD9/ZP0lbqUaVPZquB1FFzOx+KiSxYUEWKac
         ohBFjEYHArjEOhenUAtmw+82/efjNJB9L94dAlqIOMCimMi0RgMlkwH0pOdfeD+Q8oWr
         d7S1GRD7HDsJVYpUYzywyfWlDWqDCRWX63wEGBJnkjsU+x0Ve6ST9QMxLDXszpPAUraC
         vGpQ==
X-Gm-Message-State: AOJu0YwWqgK18sSkjX2qFUMdG4/nKwOjjA3OU9lbOkYD36zN4n9D1D/E
	Ivt6vpG3XSYCW4SfeEtz3CLfe63DbrPZJD867KvLUX3PlbWeYDmMISurDKk0BKvSXI0qsw==
X-Gm-Gg: ASbGnctfYa474/RGuVAKv5h0aLb5QF7frcWbkKE3x75dSk3ZEVVuA2aHTVmQGPc1EGW
	EuEr8k7j70CHNMFg3RNgBTFy9hPVKJHNdKf3a+TtlVj/M3sg/8nwzTv59OURMm3iCJgnQDOuJks
	I6J6BNttqz7QUe61Igueny1Hu018kVBJ1hx2OOyHsiTZUNIGw0Cvs/l4fvdnhvHMamcE3C0M7FZ
	FaRyTE5zAhPshhKUYRuxCo8dymbsnOGHwshws5c/wPawt8nLbecM76WIVAz1Tr29DJLPDegR2Cf
	iZhbY6AHBiz88HO1uoX+2aA/U2xYLq6LbNyNNURXl9ZDW7bPs2a83xi+bz8LsohezVk1QNS0anG
	ZVxD3GqBv/KN7wo98qD8WLpEQF7mTTjszcqiLJOq+yvLQtV5Cq5dtuNvPQe3jjyvwiV1cXtxttz
	5En3K52j4Zq3AahXpY1IhNaTspJ92NzaI=
X-Google-Smtp-Source: AGHT+IECXNlFf9xDLVnYuvzYJaDSfB4UlSZNDitLivsCF/eTcMREQ3NQaQSXI0uZCRXaMFL9eskrOg==
X-Received: by 2002:a05:6a00:bb8f:b0:7e1:afd9:9a69 with SMTP id d2e1a72fcca58-7e8c5043f00mr5551259b3a.5.1765251491448;
        Mon, 08 Dec 2025 19:38:11 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7edac47617dsm3923900b3a.42.2025.12.08.19.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 19:38:11 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
Date: Tue,  9 Dec 2025 11:27:21 +0800
Message-ID: <20251209033747.31010-5-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251209033747.31010-1-sunk67188@gmail.com>
References: <20251209033747.31010-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a common parttern in callers of btrfs_prev_leaf:
p->slots[0]-- if p->slots[0] points to a slot with invalid item(nritem).

So just make btrfs_prev_leaf() ensure that path->slots[0] points to a
valid slot and cleanup its over complex logic.

Reading and comparing keys in btrfs_prev_leaf() is unnecessary because
when got a ret>0 from btrfs_search_slot(), slots[0] points to where we
should insert the key. So just slots[0]-- is enough to get the previous
item.

And then remove the related logic and cleanup the callers.

ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]))
is enough to make sure that nritems != 0 and slots[0] points to a valid
btrfs_item.

And getting a `nritems==0` when btrfs_prev_leaf() returns 0 is a logic
error because btrfs_pref_leaf() should always

1. either find a non-empty leaf
2. or return 1

So we can use ASSERT here.

No functional changes.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 100 +++++++++--------------------------------------
 1 file changed, 19 insertions(+), 81 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index bb886f9508e2..07e6433cde61 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2365,12 +2365,9 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 {
 	struct btrfs_key key;
-	struct btrfs_key orig_key;
-	struct btrfs_disk_key found_key;
 	int ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
-	orig_key = key;
 
 	if (key.offset > 0) {
 		key.offset--;
@@ -2390,48 +2387,12 @@ static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 	if (ret <= 0)
 		return ret;
 
-	/*
-	 * Previous key not found. Even if we were at slot 0 of the leaf we had
-	 * before releasing the path and calling btrfs_search_slot(), we now may
-	 * be in a slot pointing to the same original key - this can happen if
-	 * after we released the path, one of more items were moved from a
-	 * sibling leaf into the front of the leaf we had due to an insertion
-	 * (see push_leaf_right()).
-	 * If we hit this case and our slot is > 0 and just decrement the slot
-	 * so that the caller does not process the same key again, which may or
-	 * may not break the caller, depending on its logic.
-	 */
-	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
-		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
-		ret = btrfs_comp_keys(&found_key, &orig_key);
-		if (ret == 0) {
-			if (path->slots[0] > 0) {
-				path->slots[0]--;
-				return 0;
-			}
-			/*
-			 * At slot 0, same key as before, it means orig_key is
-			 * the lowest, leftmost, key in the tree. We're done.
-			 */
-			return 1;
-		}
-	}
+	/* There's no smaller keys in the whole tree. */
+	if (path->slots[0] == 0)
+		return 1;
 
-	btrfs_item_key(path->nodes[0], &found_key, 0);
-	ret = btrfs_comp_keys(&found_key, &key);
-	/*
-	 * We might have had an item with the previous key in the tree right
-	 * before we released our path. And after we released our path, that
-	 * item might have been pushed to the first slot (0) of the leaf we
-	 * were holding due to a tree balance. Alternatively, an item with the
-	 * previous key can exist as the only element of a leaf (big fat item).
-	 * Therefore account for these 2 cases, so that our callers (like
-	 * btrfs_previous_item) don't miss an existing item with a key matching
-	 * the previous key we computed above.
-	 */
-	if (ret <= 0)
-		return 0;
-	return 1;
+	path->slots[0]--;
+	return 0;
 }
 
 /*
@@ -2461,19 +2422,10 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
 		if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
 			return btrfs_next_leaf(root, p);
 	} else {
-		if (p->slots[0] == 0) {
-			ret = btrfs_prev_leaf(root, p);
-			if (ret < 0)
-				return ret;
-			if (!ret) {
-				if (p->slots[0] == btrfs_header_nritems(p->nodes[0]))
-					p->slots[0]--;
-				return 0;
-			}
-			return 1;
-		} else {
-			p->slots[0]--;
-		}
+		if (p->slots[0] == 0)
+			return btrfs_prev_leaf(root, p);
+
+		p->slots[0]--;
 	}
 	return 0;
 }
@@ -4957,26 +4909,19 @@ int btrfs_previous_item(struct btrfs_root *root,
 			int type)
 {
 	struct btrfs_key found_key;
-	struct extent_buffer *leaf;
-	u32 nritems;
 	int ret;
 
 	while (1) {
 		if (path->slots[0] == 0) {
 			ret = btrfs_prev_leaf(root, path);
-			if (ret != 0)
+			if (ret)
 				return ret;
-		} else {
-			path->slots[0]--;
-		}
-		leaf = path->nodes[0];
-		nritems = btrfs_header_nritems(leaf);
-		if (nritems == 0)
-			return 1;
-		if (path->slots[0] == nritems)
+		} else
 			path->slots[0]--;
 
-		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+		ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]));
+
+		btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
 		if (found_key.objectid < min_objectid)
 			break;
 		if (found_key.type == type)
@@ -4998,26 +4943,19 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid)
 {
 	struct btrfs_key found_key;
-	struct extent_buffer *leaf;
-	u32 nritems;
 	int ret;
 
 	while (1) {
 		if (path->slots[0] == 0) {
 			ret = btrfs_prev_leaf(root, path);
-			if (ret != 0)
+			if (ret)
 				return ret;
-		} else {
-			path->slots[0]--;
-		}
-		leaf = path->nodes[0];
-		nritems = btrfs_header_nritems(leaf);
-		if (nritems == 0)
-			return 1;
-		if (path->slots[0] == nritems)
+		} else
 			path->slots[0]--;
 
-		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+		ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]));
+
+		btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
 		if (found_key.objectid < min_objectid)
 			break;
 		if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||
-- 
2.51.2


