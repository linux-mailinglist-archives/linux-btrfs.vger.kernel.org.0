Return-Path: <linux-btrfs+bounces-6230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67DE928B61
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 17:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03AABB26FFB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36016DEB3;
	Fri,  5 Jul 2024 15:14:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E916CD0F;
	Fri,  5 Jul 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192442; cv=none; b=VzTzyml0yhk1yW+HUWsa751UsFN7xQNfRJppc4s+T1qtMTbi2zt46FpMvexTKxBKpFIc9e5emZQt+IwN+AihVqPzdc/QY+HNVQ7VvI21ziNFkY/AnQ6I6FDakrdOGOiiTT370NIqhr7Ct32hgQN1q+lt0pftDkePv7l/LgQHIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192442; c=relaxed/simple;
	bh=is+g/UmLn3VnD5JZNWK/X0ZjNyP++WSe0zIuSqaWhNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WWVYebGfycPN5br3I1/6TLvgsESk9sUwatXU9sgRwpS6sl6uH+ULcUBrmMSr3NNznmEGYi5f1s2uMYbIjakLxGDz2t2QKb4Nk8C7uy6WNYP0EStDqSoXfC9YhiUIyTIUIEzSVkhIFpD3jeHOOt0rwkXh4WzkbnOMhYXV00UuUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so190537066b.2;
        Fri, 05 Jul 2024 08:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192439; x=1720797239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4yJib9/yu31KzhE/Fvb9I0Ph5ips0oIhml2mycHtDs=;
        b=lvr0lfn3WYPGEjH9FFazuTD7MPCtJoCYRAXsr0V4K1mDA3wuButvHuSdh50Jwxdfx2
         IfIf9uW4zPMgmW2Dj7/QRW2Fr9WhF5hTsHHLvjGljNyLEAAXflhp4qpG1lZtK9zV6gHW
         Xpem3yWU/XtqH+U6WBDfheohmE70PaDDuJDC02C8MrMjSeDftlbPsdnIwhz19XOrN9/A
         dkAv5raoJxfPzRRF3NjzeEvcC8qARv5FWXnAkmAOwFgeCKPXoSaZNqbVqfZlT2GFCEUJ
         KaXo99ilTgv/djevPh+VuIHXdT4GJCEbsgihR6LAOSxhKnYiH0mzNK2zKIsJBSgA+1M2
         kx5w==
X-Forwarded-Encrypted: i=1; AJvYcCVlRwAjQyk66SvQuE9EU5AGnIcgbiqzKmq5IqAL8MU0Xp0zpRFCK/6uKynmwLLtcK9HsABxAaxgUJ7YvsR0lA1UTdgpeoc1g43v60Uc
X-Gm-Message-State: AOJu0Yw+F52Pd31K2Yw6MHDQETVxnokQuGWQFs3e5epHsO0GwDclLzw1
	3XRjImxg6wkvzuR+BulDlh7wGeFX2iy52fCGneRS2Fq7XqSGTbtwQYvlKQ==
X-Google-Smtp-Source: AGHT+IHXwiDHUoN0WHlTQXRP9FZ9KNOwF/QDhAiLG/kx6iL92RdcCk4TouZWtFe6dVwHRNf3ihJ49A==
X-Received: by 2002:a17:907:608c:b0:a77:bfca:da54 with SMTP id a640c23a62f3a-a77bfcadb9emr344657166b.29.1720192438928;
        Fri, 05 Jul 2024 08:13:58 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf6336csm686226566b.70.2024.07.05.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:13:58 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 05 Jul 2024 17:13:49 +0200
Subject: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-b4-rst-updates-v4-3-f3eed3f2cfad@kernel.org>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
In-Reply-To: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4263; i=jth@kernel.org;
 h=from:subject:message-id; bh=rknHPBJsb/MFqKgvZKmBibYNWi+sACspr+DYxYi9A/U=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaR18G5a3mqQznA+Wp9H6YH0bLu2v711XwqnKV142vJ7n
 fXT1DnHOkpZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAi6zoZGdp0fi1KU+1+c3nW
 t0en8w6f3O0ezV7S8F/54kbtHSs8xV4w/HeRMl1tJMq4KvDW9Yl6FQ9unAhcb6b3b/q3d58t/++
 rLOYFAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The current RAID stripe code assumes, that we will always remove a
whole stripe entry.

But if we're only removing a part of a RAID stripe we're hitting the
ASSERT()ion checking for this condition.

Instead of assuming the complete deletion of a RAID stripe, split the
stripe if we need to.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.c            |  1 +
 fs/btrfs/raid-stripe-tree.c | 98 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 75 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 451203055bbf..82278e54969e 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3863,6 +3863,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
 	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
+	       key.type != BTRFS_RAID_STRIPE_KEY &&
 	       key.type != BTRFS_EXTENT_CSUM_KEY);
 
 	if (btrfs_leaf_free_space(leaf) >= ins_len)
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 84746c8886be..d2a6e409b3e8 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -33,42 +33,92 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	if (!path)
 		return -ENOMEM;
 
-	while (1) {
-		key.objectid = start;
-		key.type = BTRFS_RAID_STRIPE_KEY;
-		key.offset = length;
+again:
+	key.objectid = start;
+	key.type = BTRFS_RAID_STRIPE_KEY;
+	key.offset = length;
 
-		ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
-		if (ret < 0)
-			break;
-		if (ret > 0) {
-			ret = 0;
-			if (path->slots[0] == 0)
-				break;
-			path->slots[0]--;
-		}
+	ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
+	if (ret < 0)
+		goto out;
+	if (ret > 0) {
+		ret = 0;
+		if (path->slots[0] == 0)
+			goto out;
+		path->slots[0]--;
+	}
+
+	leaf = path->nodes[0];
+	slot = path->slots[0];
+	btrfs_item_key_to_cpu(leaf, &key, slot);
+	found_start = key.objectid;
+	found_end = found_start + key.offset;
+
+	/* That stripe ends before we start, we're done. */
+	if (found_end <= start)
+		goto out;
+
+	trace_btrfs_raid_extent_delete(fs_info, start, end,
+				       found_start, found_end);
+
+	if (found_start < start) {
+		u64 diff = start - found_start;
+		struct btrfs_key new_key;
+		int num_stripes;
+		struct btrfs_stripe_extent *stripe_extent;
+
+		new_key.objectid = start;
+		new_key.type = BTRFS_RAID_STRIPE_KEY;
+		new_key.offset = length - diff;
+
+		ret = btrfs_duplicate_item(trans, stripe_root, path,
+					   &new_key);
+		if (ret)
+			goto out;
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
-		btrfs_item_key_to_cpu(leaf, &key, slot);
-		found_start = key.objectid;
-		found_end = found_start + key.offset;
 
-		/* That stripe ends before we start, we're done. */
-		if (found_end <= start)
-			break;
+		num_stripes =
+			btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
+		stripe_extent =
+			btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
+
+		for (int i = 0; i < num_stripes; i++) {
+			struct btrfs_raid_stride *raid_stride =
+				&stripe_extent->strides[i];
+			u64 physical =
+				btrfs_raid_stride_physical(leaf, raid_stride);
+
+			btrfs_set_raid_stride_physical(leaf, raid_stride,
+							     physical + diff);
+		}
+
+		btrfs_mark_buffer_dirty(trans, leaf);
+		btrfs_release_path(path);
+		goto again;
+	}
 
-		trace_btrfs_raid_extent_delete(fs_info, start, end,
-					       found_start, found_end);
+	if (found_end > end) {
+		u64 diff = found_end - end;
+		struct btrfs_key new_key;
 
-		ASSERT(found_start >= start && found_end <= end);
-		ret = btrfs_del_item(trans, stripe_root, path);
+		new_key.objectid = found_start;
+		new_key.type = BTRFS_RAID_STRIPE_KEY;
+		new_key.offset = length - diff;
+
+		ret = btrfs_duplicate_item(trans, stripe_root, path,
+					   &new_key);
 		if (ret)
-			break;
+			goto out;
 
+		btrfs_mark_buffer_dirty(trans, leaf);
 		btrfs_release_path(path);
 	}
 
+	ret = btrfs_del_item(trans, stripe_root, path);
+
+ out:
 	btrfs_free_path(path);
 	return ret;
 }

-- 
2.43.0


