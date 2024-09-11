Return-Path: <linux-btrfs+bounces-7941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8C974F13
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231631C2167A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183A17B433;
	Wed, 11 Sep 2024 09:52:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6E224F6;
	Wed, 11 Sep 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048347; cv=none; b=ruXOSB4+ZtVSDIPZAC45XU7ahpIYD0Fu/yB5KJT6A+E+We4mRy9o5leSELlAYyvKuVfVilDFKM+7Q5Fa+EpizjN0Wly2m4B5h4d9wRJtNCFHkLh2+1dw1sc4CmhpeFViRigmdL4JM2KEOLeRl1lQXzuMdcNZ0an0yVvXH/LJr7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048347; c=relaxed/simple;
	bh=NYc2YZ5PM2+TMgbeqlCX6YZUtsMtN7emPC5oR7x/64k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R774bqRTQTXLixgu3sk8IXAZXnNG+9B07EhldMbI43Zry0ICuHy9rU25T2m6xIKxJRaFDHhQV23C9Bpq6me9StDycWwfaL7ZuQAc5MMPnxIxvCAKHlw3geq2x1n3rHDAQZQMwkiGp6NY9nAvsBmQVoFGqJkCwMsW1GEIX2hLPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso40792755e9.2;
        Wed, 11 Sep 2024 02:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726048344; x=1726653144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKsh8KL7iwj3VIFfzseruBz4dJRBWDFlUzwPNjq08ts=;
        b=UKM2LKgGndZrIiEwouNhReJ2tzP+HRyfXZCk4StIPc7Tyhk5RfM6cANZ/w2ZY0uT9P
         WcBftSezV5jZtThhpqFdbKHELsXVxXeWLVNMVvNzS/akj1xm1UE/dP9u9GU4oFZ/4J4O
         KqbQnNJ8Uf8v5cf/b9bphx92bTkM9pc+7ZS1+sebLoT6pedgTUeqc+WVTGRoD1pL90nR
         wQIjjRUpEY9hRRhjEJ3s3micTrFs6kMkoI4r5EOaHt/y14geOTChvQSYTL3z5hnJrRV+
         E8JltHKeReiHy549ZVXRkxg9KG3+5f/za3M5iZMrb5Qu3k2kmQGL0g6hgdZsR9gjAVBV
         iy0w==
X-Forwarded-Encrypted: i=1; AJvYcCV/LRxUOvaqBTWJ+W0wL+RVjL/BRkf3Vna/1iPddIugHsB8SrhmutIs6YZhyMx/h7PqoHjg6HNuQuwp3A==@vger.kernel.org, AJvYcCVcxsVP2tcekTuNm1xEFg+2IWM3Y5Nfu4oni3FnlxkaoAgM05KjxlGtYlNFPG4qVpnb7O82VKVxRBBf06Ju@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80ay1IAbyLfj+jpTTtRZu3k3z81Ur2ov/hTANxFZ9P8HmNCX5
	SRx8/c1ez4KSyEsAClOU3b0cF8uB5+UqPsds+9M/k4Q8of1OMgN/
X-Google-Smtp-Source: AGHT+IH2fl6EvyowPSZVginLJWxZJzpL307bK4QDFsJAQfU/ip2YYwDUNUMQue7C5pfFa4u5w7aCDw==
X-Received: by 2002:a05:600c:34ce:b0:42c:aeaa:6b0d with SMTP id 5b1f17b1804b1-42caeaa6d63mr128768845e9.9.1726048343700;
        Wed, 11 Sep 2024 02:52:23 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7178100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f717:8100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca7cccd35sm155195945e9.18.2024.09.11.02.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:52:22 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: stripe-tree: correctly truncate stripe extents on delete
Date: Wed, 11 Sep 2024 11:52:05 +0200
Message-ID: <20240911095206.31060-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

In our CI system, we're seeing the following ASSERT()ion to trigger when
running RAID stripe-tree tests on non-zoned devices:

 assertion failed: found_start >= start && found_end <= end, in fs/btrfs/raid-stripe-tree.c:64

This ASSERT()ion triggers, because for the initial design of RAID stripe-tree,
I had the "one ordered-extent equals one bio" rule of zoned btrfs in mind.

But for a RAID stripe-tree based system, that is not hosted on a zoned
storage device, but on a regular device this rule doesn't apply.

So in case the range we want to delete starts in the middle of the
previous item, grab the item and "truncate" it's length. That is, subtract
the deleted portion from the key's offset.

In case the range to delete ends in the middle of an item, we have to
adjust both the item's key as well as the stripe extents.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

Changes to v1:
- ASSERT() that slot > 0 before calling btrfs_previous_item()

 fs/btrfs/raid-stripe-tree.c | 52 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 4c859b550f6c..075fecd08d87 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -61,7 +61,57 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		trace_btrfs_raid_extent_delete(fs_info, start, end,
 					       found_start, found_end);
 
-		ASSERT(found_start >= start && found_end <= end);
+		if (found_start < start) {
+			struct btrfs_key prev;
+			u64 diff = start - found_start;
+
+			ASSERT(slot > 0);
+
+			ret = btrfs_previous_item(stripe_root, path, start,
+						  BTRFS_RAID_STRIPE_KEY);
+			leaf = path->nodes[0];
+			slot = path->slots[0];
+			btrfs_item_key_to_cpu(leaf, &prev, slot);
+			prev.offset -= diff;
+
+			btrfs_mark_buffer_dirty(trans, leaf);
+
+			start += diff;
+			length -= diff;
+
+			btrfs_release_path(path);
+			continue;
+		}
+
+		if (end < found_end && found_end - end < key.offset) {
+			struct btrfs_stripe_extent *stripe_extent;
+			u64 diff = key.offset - length;
+			int num_stripes;
+
+			num_stripes = btrfs_num_raid_stripes(
+				btrfs_item_size(leaf, slot));
+			stripe_extent = btrfs_item_ptr(
+				leaf, slot, struct btrfs_stripe_extent);
+
+			for (int i = 0; i < num_stripes; i++) {
+				struct btrfs_raid_stride *stride =
+					&stripe_extent->strides[i];
+				u64 physical = btrfs_raid_stride_physical(
+					leaf, stride);
+
+				physical += diff;
+				btrfs_set_raid_stride_physical(leaf, stride,
+							       physical);
+			}
+
+			key.objectid += diff;
+			key.offset -= diff;
+
+			btrfs_mark_buffer_dirty(trans, leaf);
+			btrfs_release_path(path);
+			break;
+		}
+
 		ret = btrfs_del_item(trans, stripe_root, path);
 		if (ret)
 			break;
-- 
2.43.0


