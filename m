Return-Path: <linux-btrfs+bounces-10947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C715EA0C183
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99CA16B888
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58451DE4D5;
	Mon, 13 Jan 2025 19:32:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A01D45EA;
	Mon, 13 Jan 2025 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796721; cv=none; b=rnVuo7uBFoevU8cmuzEvlGOvRQTRyZmfA5K0XWXWkw4qOQoGpuyOoNnxBGoy6x7eCLR67NF05+RUxIKq7oNZtgObh7tR7eadyBOEd3apuydQxLJw1DKz2Cyqb8L57pl6qb8/+ab5s11fEq6rCjnIxewGZXy/W5iieIVFuZ3VG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796721; c=relaxed/simple;
	bh=TmACSHqrN7sfl9FsVJCIJwxp+Q9vTJXTL1DaLOgUhYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s6JvKUcuwKJvhtNFJV6vADNvMOzf30jP0amaOmhetf5iTWcA161bijK1qFVBOmT31mgSc+BQP33WUE1MnaaRTh1W8x+UqTlKagMdKtlxB2wyzE03jX05STMTcqMjWmMtSZUVyUzRfaUjOw2SvsOOtTFIxsQ2ZocgDtMhVKzwGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361815b96cso33190375e9.1;
        Mon, 13 Jan 2025 11:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796717; x=1737401517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucyJoNw6QFKkSZ2jNzF6PvZw0GMEtb/7zoh8ROnU+zs=;
        b=Ue+tUTqxFodNqcMN7Ct6EvhRpc+TEYhhU6bZtzBdU5VnTsRfG+uJSN1JSRDhJNvneC
         R0Qvhu/R/KS++n+3KlzUCj4AjqFwHYDnzwfuSVvYWdPWQv4wabzAKwJawbj1oxfdYnVp
         gwDNX3vHB3NCStlIC2hMIya1PNa2XtcbPZ1u616Gznnw1YjFcFEhfhVbseYYwcCnDiUJ
         ZkohEN7/+Gx0P/Wr8Fcz0qehXmBG5kV7TaU0QGl0jEsN4LKaImV3PwMbAwBZSM7i5m0M
         8NQ91qOGv53CYbZk38LmStgF9c6sRgI3LVnfKwX1FeVSAWmjQeIpJ7knO1TMc/upLFY/
         R4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCULWE1xZseMo0PnV3nK3ydKSQEZTIE6Kwu6rLyXcDLA3ZlCvk9azDjHA8BYJD5FlpDWTT12Ljsv9eDAjw==@vger.kernel.org, AJvYcCWCAaEtU6yfilg4RvJaK23q8KG71JEtSmp8ck2djl840Y5oo26vWTvLsxlFHrKQN4ZuO2FKFEbYCnuWzMlx@vger.kernel.org
X-Gm-Message-State: AOJu0YyoEjrITSxBnkQiVlfa0aRltRqyrCVCOSTQ3OO5ccOnUHiftw4p
	M/9qJRsONl+pB9bkhDGRG7pc0m4RNGu87Rk0v2UvvWFBxnuzm5w7
X-Gm-Gg: ASbGncvVj3UpTQDUnOddKA1eFkHU+rY13JZEmv8zzfuIdvBxd25m9FWsz7tJJ0/4DLv
	zydYFQiXe62V1QRYeRMtY4mXqib3GoOXopI67pvFBLvGtnN2PpXjlHBxAWbZLWkPpmohNx31uCW
	LwV2UaNdr8+S6w4cPLM3AscYe3igdHmSrVlS1OZlZZq3OT7BRl8FWQud7KaPCT2Wx66o5SdVGRW
	0sokA3KoJi6V5EGcfX20PD11z+K+3SE4c1gRmcsFnUlX4fN43pWEa1r7usICOF1dwOD4ZC7grNq
	WpxrpTqjybRB29D2PlqG487x8gvjjsiuRM/n
X-Google-Smtp-Source: AGHT+IE1cclo1ieKVxHR4FQJlzNAC30rUdEle4T6yY8hd9qXxQvjPDagSYDw0ECYjYVHhWYWxVi6CQ==
X-Received: by 2002:a05:600c:4f06:b0:436:6160:5b81 with SMTP id 5b1f17b1804b1-436e26b98d1mr223553545e9.14.1736796717418;
        Mon, 13 Jan 2025 11:31:57 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:57 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:48 +0100
Subject: [PATCH v4 07/14] btrfs: implement hole punching for RAID stripe
 extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-7-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166; i=jth@kernel.org;
 h=from:subject:message-id; bh=L8Hoo5vCoU/RSEY6WScLora10s8xNCnlLJcM0w/MT2o=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3ZqkK7snMc9vPKNww6aiI2dLSt6/ulLq8l627rFTrv
 y3zitDejlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZiIRC0jw7Evzx6nsbh0WnxY
 8cOB7Z3aHM24BxMsTQKfniq5tXZb026G/6W6DSYO5k1LendwyqrN513F3OO2Tf9RZtKFHB9RafX
 1rAA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

If the stripe extent we want to delete starts before the range we want to
delete and ends after the range we want to delete we're punching a
hole in the stripe extent:

  |--- RAID Stripe Extent ---|
  | keep |--- drop ---| keep |

This means we need to a) truncate the existing item and b)
create a second item for the remaining range.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.c            |  1 +
 fs/btrfs/raid-stripe-tree.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c93f52a30a16028470594de1d1256dbec5c7899c..92071ca0655f0f1920eb841e77d3444a0e0d8834 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3833,6 +3833,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
 	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
+	       key.type != BTRFS_RAID_STRIPE_KEY &&
 	       key.type != BTRFS_EXTENT_CSUM_KEY);
 
 	if (btrfs_leaf_free_space(leaf) >= ins_len)
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 439b0e63d00d0ffa3ceb2314a39f2653e8a6e9ec..a5dc97210b16701a23549204bdadea0c554b6bb9 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -140,6 +140,55 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		trace_btrfs_raid_extent_delete(fs_info, start, end,
 					       found_start, found_end);
 
+		/*
+		 * The stripe extent starts before the range we want to delete
+		 * and ends after the range we want to delete, i.e. we're
+		 * punching a hole in the stripe extent:
+		 *
+		 *  |--- RAID Stripe Extent ---|
+		 *  | keep |--- drop ---| keep |
+		 *
+		 * This means we need to a) truncate the existing item and b)
+		 * create a second item for the remaining range.
+		 */
+		if (found_start < start && found_end > end) {
+			size_t item_size;
+			u64 diff_start = start - found_start;
+			u64 diff_end = found_end - end;
+			struct btrfs_stripe_extent *extent;
+			struct btrfs_key newkey = {
+				.objectid = end,
+				.type = BTRFS_RAID_STRIPE_KEY,
+				.offset = diff_end,
+			};
+
+			/* "right" item */
+			ret = btrfs_duplicate_item(trans, stripe_root, path,
+						   &newkey);
+			if (ret)
+				break;
+
+			item_size = btrfs_item_size(leaf, path->slots[0]);
+			extent = btrfs_item_ptr(leaf, path->slots[0],
+						struct btrfs_stripe_extent);
+
+			for (int i = 0; i < btrfs_num_raid_stripes(item_size); i++) {
+				struct btrfs_raid_stride *stride = &extent->strides[i];
+				u64 phys;
+
+				phys = btrfs_raid_stride_physical(leaf, stride);
+				phys += diff_start + length;
+				btrfs_set_raid_stride_physical(leaf, stride, phys);
+			}
+
+			/* "left" item */
+			path->slots[0]--;
+			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+			btrfs_partially_delete_raid_extent(trans, path, &key,
+							   diff_start, 0);
+			break;
+		}
+
 		/*
 		 * The stripe extent starts before the range we want to delete:
 		 *

-- 
2.43.0


