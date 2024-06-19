Return-Path: <linux-btrfs+bounces-5820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD890F243
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD091F238F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F059153593;
	Wed, 19 Jun 2024 15:35:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC3152188;
	Wed, 19 Jun 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811307; cv=none; b=omSrqTA8SkeOuUyJL+t1FSZ8yISvTRYOt3mhwDX2WZCuQibP5Om64UCTJzGPlTeJiO5G3MGeW3hLFsrPrunDyb01OShVTQU6JMoSi4v3wkvbJVotLqmi9P3cA+oXhqO/755tibMtmcQS64B6eOdy+bqzMwIfTZj4c60TJ4rdzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811307; c=relaxed/simple;
	bh=2izMZ3dmor0xUWSLs/SzVt/Jl5DktPXrWE1qLh60XaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZNnFkIoETTf0Kh1lisdz0qGBWO+W6+JMY4mmXdlLPWAHNWVyopcuQVgbaC/gnT6FpvG6A+R5+og7WW/Hryz1wtnv4mvm7FvPYoRPSQIxiWJw1s4E3/sVKmfSavTadonWdWSY0puZW3PASBlCwsnVZxH/A/1NXxzanHme0VTFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217d451f69so54736265e9.0;
        Wed, 19 Jun 2024 08:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811304; x=1719416104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6WFl7aFlMAKF2BVC3/LiVx3aK8vlI/C/B6IWyQb8e0=;
        b=M/q3Bs/OgY32qfaWor3JDHGXkMc7yv3pHSktdueNZOYaCOoSrZCs5ilvNxAyxVMyl9
         f2tWwI2F0PWPo30y68JO+wPq4CTrDjMCwh+eMeJWzW6LyEiVztH/n203uT4PYztHJH7c
         GLgzLa2WaGPfPV6JupkVS/OoSkroG76rE4KIXWVwhvX1j62kwtJhaKUti+LG6aX9mWx0
         S1gnFpB2lKUvycwdvSEpEXKChwIMYt8F+GVp8FXgbIf3FSNeFsvAHQTCpgMxsxPBr4N2
         Q6Y98pS9RnyDjx+kaWAksalJ7Um57caHL8GhTjOpN/dRLuGOpSaBkQf1BC/kpcFFEroT
         lpNA==
X-Forwarded-Encrypted: i=1; AJvYcCUkovrutX99KXiy53uvxzf+7OH/8lce/Nycfsxi3moFFr1eeVy+AAL8EuyN1i8l7B2cG+2GWChBPo14g4PjUUc2B0FfXrxtBMTaB5cf
X-Gm-Message-State: AOJu0YxiH0/KPrjd521yA74Dh7mFoARH4hPH2zLNY0KzBABrvE5Ooee4
	ubfQ8V2IoePGs8dIuKKCTfLUV0nnRf1Z39HPInUhUdTpKgOh7XjGsoD2JA==
X-Google-Smtp-Source: AGHT+IGaFvzQamYUwBbfkH/SAlM6S1Fikeh5YeEum5r+73ZJBuVbdtOMscA/6C8KNyOBpUsg6pYLwA==
X-Received: by 2002:a05:600c:1c0e:b0:423:4c2:7a80 with SMTP id 5b1f17b1804b1-42475078676mr20342285e9.5.1718811303951;
        Wed, 19 Jun 2024 08:35:03 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7110500fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f711:500:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe9263sm268882135e9.15.2024.06.19.08.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:35:03 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 19 Jun 2024 17:34:53 +0200
Subject: [PATCH v2 3/4] btrfs: split RAID stripes on deletion
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-b4-rst-updates-v2-3-89c34d0d5298@kernel.org>
References: <20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org>
In-Reply-To: <20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4283; i=jth@kernel.org;
 h=from:subject:message-id; bh=LHvwAE7uLPXkoCP95RNbChA7GHz/3kVK1zWwXyZuU7M=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQV/Vo4u8f1wMN15s0PbzXP/nxq1xm7JYt5b8nv2/Wgt
 WLfphOlbR2lLAxiXAyyYoosx0Nt90uYHmGfcui1GcwcViaQIQxcnAIwkaOmjAx3OFe2nrr/1GcB
 z8oXSaxGk25G7/fYxREy+cSLF31/gyX/MPyvC+B+XmhkyCoz53N6t7BWY4uNVrnT4YaP67557m7
 wsOEBAA==
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
 fs/btrfs/ctree.c            |   1 +
 fs/btrfs/raid-stripe-tree.c | 100 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 763b9a1da428..a5c841da0357 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3858,6 +3858,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
 	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
+	       key.type != BTRFS_RAID_STRIPE_KEY &&
 	       key.type != BTRFS_EXTENT_CSUM_KEY);
 
 	if (btrfs_leaf_free_space(leaf) >= ins_len)
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 3020820dd6e2..64e36b46cbab 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -33,42 +33,94 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
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
+
+	if (found_end > end) {
+		u64 diff = found_end - end;
+		struct btrfs_key new_key;
 
-		trace_btrfs_raid_extent_delete(fs_info, start, end,
-					       found_start, found_end);
+		new_key.objectid = found_start;
+		new_key.type = BTRFS_RAID_STRIPE_KEY;
+		new_key.offset = length - diff;
 
-		ASSERT(found_start >= start && found_end <= end);
-		ret = btrfs_del_item(trans, stripe_root, path);
+		ret = btrfs_duplicate_item(trans, stripe_root, path,
+					   &new_key);
 		if (ret)
-			break;
+			goto out;
 
+		btrfs_mark_buffer_dirty(trans, leaf);
 		btrfs_release_path(path);
+		goto again;
+
 	}
 
+	ret = btrfs_del_item(trans, stripe_root, path);
+
+ out:
 	btrfs_free_path(path);
 	return ret;
 }

-- 
2.43.0


