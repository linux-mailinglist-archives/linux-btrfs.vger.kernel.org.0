Return-Path: <linux-btrfs+bounces-19646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 245DFCB4FA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2086B3014631
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F32C21E8;
	Thu, 11 Dec 2025 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi56/D6v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6129F2BF00D
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437921; cv=none; b=mu5LiwhMlAxaMOym2AZZWueamH5PU8n0rcN6BLuCu1ut7Hn7PZ+uwk5CrexiNC2GlTJLTIUKGgzFcDjUjsZ8mEprLkHDAUGPL/QM6Hq/qaFbx+4snHWVfENse3O8otHKaEhajBQmWvw/QODA6cWjyZzFfyxiNFBj0MMP2surF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437921; c=relaxed/simple;
	bh=wnYEnO2YaH5q88OX6h78fgnL+5SBTZEDvgyFxCV7p5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF0WLsY3uCJbQ4LkGiWx+EEpCNRXQJcwTeEdnSb0QIPZRKuIYHGLd++zYM7+Wg3B/Ix8r+J1rJ2jeuQOrGnfsqU00kEJZhwaTPgwac/x+IWVMMpm7nA96gB2id/NWD4XQvGHm6HfGpyYu534u50kAA0RhWTPbvfAb5VsXBRUtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi56/D6v; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7ae1c96ece1so16898b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 23:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765437919; x=1766042719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3qXMHFKyFO5Cn5pTawlTqNWz8osVV4QMh+AG6riMGE=;
        b=gi56/D6vY9McQuGDRmF4/9sJPRONsH0vPiKpmnxv+2Laa5Qg++Zini9z9cmwaap/83
         SMby2xlBQUoOxNuoiG0leHPo/hVWlZRqGXCz7KyemW/cmITMLkjORC6ou/MMuf3FpTkA
         p3svgSudSIDf8f0W0rYlXJHE/WYqjwEeyPEG7Hh0YeBtWLBgt5Ck2LhsuOssycir9vOi
         Gy9SMnWVPPWqxoAsGRj3mc1mnVpGS6vPiUplQv41phgmTyDL7K9E02ip+YLOodE6058/
         Ej4B6IkpcdsM3EXCQDH2PlCZ1WYzqLcXOvREOMjSWMbhr3IBHKNcKL3zQhj1sGvMbt5n
         6beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765437919; x=1766042719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k3qXMHFKyFO5Cn5pTawlTqNWz8osVV4QMh+AG6riMGE=;
        b=VNiG4Afi+0K/vxC4BF/FehcdthTZCJMUXRUbCishP2/lNY/1cjDfmv5gJdU3XPU2p4
         YswwdmpJVck7xe7TNIjz46OAKODQExzsW2DfxmtDoUexE4rAwoBlWGXFz+qz+y3nG+t0
         6HcGpVCyDac7/6W4zP+IAT7Xm+WvUFF7h5jwvU3VGdM+yNz0SY/3pLEW9VKYsnfYKGOr
         h5RUc47nvY3M1X//l+cVeUyUwgQwOecBgrrDkv3RJWcArpY+SS4YsZdq+R+ohG9xFHIU
         VaKgsqdyxhxfekVF4Vob1Y9zUx0sQoBlYeDu4noUg5msntkY37VK6VVqfGjXZDTd4gBQ
         NkSQ==
X-Gm-Message-State: AOJu0YwNjS2j/eU/lyoWLBle+RJzwqke8n9lxS+o6EmI5OUz5IT20eIl
	2L4tqrQBauPmrDJtV0QoGK56i/poa8YbwdpX3znpwfZ3A7deqV1XXfr2BrbS5si5Z0wqdA==
X-Gm-Gg: AY/fxX6axNGVnqb1lITf8EfUwdDSy0a8LCGfbJY8H7sTwKW+3ma6xZaRQAURHDY/627
	67E8wQcB9CN1hd9JMyHgqm6B3F6Jj4aNHtS6+Q9bBSqhBoShZeM5x9FPtZdQNqLLP9vIRcppK3H
	wyqDCJoGHRGi0wcjoBP/ofaifAGAJ9pghQtN6f/bj1+gI/YW7IG/vXftiFaYk4C+3Il1+vg8gif
	siZbV57cWGdtnWlMCyrHIZA2OSIkcBEfoMWQq/GnDIj800mHPsGw9AgvmTEeAemvWuRsNzxSxyZ
	9KhIhQOJD9K/Pe8R7l6uvCfG7FHiKhqdFQv0SPg1m804Nsmn4JoYEjbn6y9/aaERORfP0mSyELS
	3jjLY5Ojptxw6QbygDuaztvMyLS7iUG1C5itGBaOdxSWdBziW8BWbYYdIjpmGkRU8KumkiK7Gfi
	iNtsRKNEOcP6aaZcCw5CzF
X-Google-Smtp-Source: AGHT+IHtbYimDQXU+GBuTIiTSAHYGy/Ydn0ZwlLBI0EI7aWo9j7b/Uv8M82AE6y30Vzkl87wEElOgw==
X-Received: by 2002:a05:6a20:7486:b0:341:fcbf:90b9 with SMTP id adf61e73a8af0-366e2469302mr3927095637.4.1765437918592;
        Wed, 10 Dec 2025 23:25:18 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4ab4984sm1526520b3a.33.2025.12.10.23.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:25:18 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
Date: Thu, 11 Dec 2025 15:22:19 +0800
Message-ID: <20251211072442.15920-6-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251211072442.15920-2-sunk67188@gmail.com>
References: <20251211072442.15920-2-sunk67188@gmail.com>
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

And then remove the related logic and cleanup the callers.

This will make things much simpler.

No functional changes.

A. Details about changes in callers:

ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0])) in callers
is enough to make sure that nritems != 0 and slots[0] points to a valid
btrfs_item.

And getting a `nritems==0` when btrfs_prev_leaf() returns 0 is a logic
error because btrfs_pref_leaf() should always

1. either find a non-empty leaf
2. or return 1

So we can use ASSERT safely here.

B. Details about cleanup of btrfs_prev_leaf().

The previous implementation works like this:

0) Get a previous key by "dec by 1" of the original key. Let's call it
   search key. It's obvious that search key is less than original key
   and there's no key between them.

1) Call btrfs_search_slot() with search key.

2) If we got an error or an exact match, early return.

3) If p->slots[0] points to the original item, p->slots[0]-- to make sure
   that we will not return the same item again. This may happen because
   there might be some tree balancing happened so the original item is no
   longer at slot 0.

4) Check if the key of the item at slot 0 is (less than the original key
   / less than or equal to search key) to verify if we got a previous leaf.

However, 3) and 4) are over complex. We only need to check if
p->slots[0] == 0 because:

3a) If p->slots[0] == 0, there's no key less than or equal to search key
    in the tree, which means the original key is lowest in the tree. In
    this case, there's no previous leaf, we should return 1.

3b) If p->slots[0] != 0, using p->slots[0]-- is enough to get a valid
    previous item neither missing anything nor return the original item
    again because:

    i) p->slots[0] == nritems, which means all keys in the leaf are less
       than search key so the leaf is a previous leaf. We only need to
       p->slots[0]-- to get a valid previous item.

    ii) p->slots[0] < nritems, p->slots[0] points to an item whose key
        is greater than search key(probably the original item if it was
        not deleted), and p->slots[0] - 1 points to an item whose key is
        less than search key. So use p->slots[0]-- to get the previous
        item and we will neigher miss anything nor return the original
        item again. This handles the case 3) in original implementation.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 99 ++++++++++--------------------------------------
 1 file changed, 19 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0a0157db0b0c..3026d956c7fb 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2376,12 +2376,9 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
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
@@ -2401,48 +2398,12 @@ static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
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
@@ -2473,19 +2434,11 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
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
+		/* We have no lower key in the tree. */
+		if (p->slots[0] == 0)
 			return 1;
-		} else {
-			p->slots[0]--;
-		}
+
+		p->slots[0]--;
 	}
 	return 0;
 }
@@ -4969,26 +4922,19 @@ int btrfs_previous_item(struct btrfs_root *root,
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
@@ -5010,26 +4956,19 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
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


