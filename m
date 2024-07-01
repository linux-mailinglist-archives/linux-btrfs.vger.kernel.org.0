Return-Path: <linux-btrfs+bounces-6070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AEB91DC63
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485EE280D8B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F83F143745;
	Mon,  1 Jul 2024 10:25:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6A12C486;
	Mon,  1 Jul 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829528; cv=none; b=TLDIDvVI0+cR9A0GCy79qZArRFf2xNKgIggLVeyZQWgvWjLjmoqJGxJV4Mg/UsOhouM0mTbK+84vepszZYjWZPafApcPBro0DRpx2HCEMeircEYbcftnrcoQ8gtQppZyV951b1+ThQAQwat5ZmZimWOpKplKSG/9isOJIt0b3qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829528; c=relaxed/simple;
	bh=Ihnv77fdO6VNQuv7P1wE+zU2Zro1Fedjo4vDunZrwuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+gneLs22doAV87CVS9EdoeE/G2hfP33U1MvSYs+AB7SUgI9XKmVxK6NO415mC2rW2m56N+3pm6IcE+kdJm+ZKr1uOvBTb4KEXvu0Y4ijW/qRlvrv0w0UM/QSI5bNqIs9Fa5CtoeLEOnGRo0DbWaObAAPY+4QWHX7WTCQESBXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5858e973ef5so37401a12.0;
        Mon, 01 Jul 2024 03:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829525; x=1720434325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0JT/Xo83f4nbcp2XDGTrGdTQ8pcv3iU30WHc4X2nJU=;
        b=P+EnMmJGLjFg0Yr3xUmBZWj0iHJ/mx4melKbGImtSsS1OLiIqI4cR6wxZJhYargKtt
         sfWHoSR4iXYxr4dpRGqdUDre0vgzXGSDHMbBvuAAphGOcNW0IqBxgr2i7q77tEUZfIDc
         CN4G03LqfLQvyV/D5HItj3IB7JcNWp4r3FhI6Gze1isj70WG5jiMjgHKF7UBlPixn7QG
         /DoPMPmBVZPIqMuly6zU058je5RxyOgMHLbaY3WQgxmk0nrDx7qAW2p7M+jP1pBV3n3C
         aOZJ5McNSIjry5OyYjGL1HfAZfRHQVCRS2IV0qyTkyM1zAWLNier7sSGQwyoqOxjOAvG
         gRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+5K5oS+vVRjO4sNYJqCZtGPSrMQFYX6jqSa8YoYnNpwZGw/bBSS0gqVbSTN7oxwQMQOY8ygdc98s3OGP9QE2HA8ZPDXAjVzqlJ+fh
X-Gm-Message-State: AOJu0YwWjvCHft+SqnTG79nuUsPttNCVbyMRIZOh0rfvQ0j4zskhR12i
	HXbXwM/rHGdAkSprik1w2OU/a6Bu/h4RcTIzJmTO95WUAKDQjpI+qfmjbA==
X-Google-Smtp-Source: AGHT+IHW+PvoEk4sz1fCjEyY1kf5G9YsfZe/k7tgQ9NdeGMBRVfVPMR8NsuZdAlRZDqx0jHQOeu47Q==
X-Received: by 2002:a05:6402:51c7:b0:585:4048:12a6 with SMTP id 4fb4d7f45d1cf-5879f5a61d2mr4313157a12.19.1719829525407;
        Mon, 01 Jul 2024 03:25:25 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c83583sm4238901a12.5.2024.07.01.03.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:25:25 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 01 Jul 2024 12:25:16 +0200
Subject: [PATCH v3 2/5] btrfs: split RAID stripes on deletion
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-rst-updates-v3-2-e0437e1e04a6@kernel.org>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
In-Reply-To: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4283; i=jth@kernel.org;
 h=from:subject:message-id; bh=c4gL3l0PJr5NwuEdLrKy7RI6oaeMUeYRLq3GongUBWg=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQ1tQgpd9e9abube/F3aN3G+uT9b5vfa9qt3GT0IMy1W
 kG5+vipjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZjIdCaGf4oZihMNQu7Ybl8r
 +43N4Z/sjhnNjqXn/ixYeMf/VK+zQD3Df5f/66oEd5l3y688dat3X3J58fmNm8v+BAeE+Mcsu/g
 ngxMA
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
index e33f9f5a228d..16f9cf6360a4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3863,6 +3863,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
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


