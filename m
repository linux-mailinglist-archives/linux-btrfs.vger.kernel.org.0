Return-Path: <linux-btrfs+bounces-9097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB339ACB24
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB59281E4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2341AE01E;
	Wed, 23 Oct 2024 13:25:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573A1DFEF
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689935; cv=none; b=LoTFR48bOpfcKKb0xq9RsOFtTDG/LqpdxWYPIaf7sNyRUs82puaHoQR/V2hLbsvXANgwiazDuSnDcJZpPZhKAahB/5M7/YcPgsQ23qKyCh67VtAWj2JZsLYjkWS4AXg60YBXqR6XlStg0vmKPjf97OrmMzIdKZHcH9kXxOe8wP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689935; c=relaxed/simple;
	bh=KZ1LhkW2SVutSQL88AvFNTIikAkFfxh2AoX33lpQzmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An+NSiWwSpm+vjH2mr5sOHPrp2yU4+Jsp+TIRk3DJWsVvNYt6qwBk0zgd7W11SqpG1Z6pQ5nBdBlhKCzOu6nXcLs2T3odtdhC3zx8s1Vx/3RWFg2gN7nM0HYE6U/wGJk9+k4K1Q4pAmIuqU11ClmBlWuAewNkuNc3QTTFpORt/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431616c23b5so6461365e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 06:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729689932; x=1730294732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHUjxO+4nTtFnRlt5bV8eKomJyJSxAm2kBc3bLapca0=;
        b=LZaCArL2eJ2UxMxgi78OTMnOTdzTKseUKPfs1tGGTJj7fhxl7TrjCwndYaMexgyAQB
         MJz6ThNsz0ZZNGQJYyT7sMtF1jNdigD/lr1QHiHuo8IcpbTr8pn8dNwpByhYUCeazU0t
         LJO32F/GBngoK/9Ii0LE6n0BuFvLMWBP4zOoxhkiIjiU7p9ij+SCvVMOQsbOhsZKN7xg
         SlEqE5s6GDO5WOyKbCHykdGCRHDV/icyViHABaOV3a/K8xoIakogjk2jI/lhVEMtWp28
         uQO3cRWuHAw6It8tCEVSq6f20pLRKgaPZdeEkWMgbow9pPYVUfd7SQFrHtf2ze7NgkuP
         6JfA==
X-Gm-Message-State: AOJu0YyCRZLmb/5Agm6bgUzUJX2njoStce31+uhPpgu6xD9sMKxU9Zoh
	UyS9JVL1h1q57cFkAbylVldlCORpYOvHyPUmw/oMXPcAb0VQI/mqzzrkhQ==
X-Google-Smtp-Source: AGHT+IEmhKF4o9tSslfZ282ENXujw3SwcfUcOgMe2KfQM/sZnYXgmSxiQa7/fvQBX+lgKIyjwqMv+w==
X-Received: by 2002:a05:600c:354f:b0:431:57cf:f13d with SMTP id 5b1f17b1804b1-43184337402mr17145215e9.3.1729689931583;
        Wed, 23 Oct 2024 06:25:31 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c1e387sm16169935e9.41.2024.10.23.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:25:30 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 1/2] btrfs: implement partial deletion of RAID stripe extents
Date: Wed, 23 Oct 2024 15:25:17 +0200
Message-ID: <20241023132518.19830-2-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023132518.19830-1-jth@kernel.org>
References: <20241023132518.19830-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

In our CI system, the RAID stripe tree configuration sometimes fails with
the following ASSERT():

 assertion failed: found_start >= start && found_end <= end, in fs/btrfs/raid-stripe-tree.c:64

This ASSERT()ion triggers, because for the initial design of RAID
stripe-tree, I had the "one ordered-extent equals one bio" rule of zoned
btrfs in mind.

But for a RAID stripe-tree based system, that is not hosted on a zoned
storage device, but on a regular device this rule doesn't apply.

So in case the range we want to delete starts in the middle of the
previous item, grab the item and "truncate" it's length. That is, clone
the item, subtract the deleted portion from the key's offset, delete the
old item and insert the new one.

In case the range to delete ends in the middle of an item, we have to
adjust both the item's key as well as the stripe extents and then
re-insert the modified clone into the tree after deleting the old stripe
extent.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 81 +++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 41970bbdb05f..9ffc79f250fb 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -13,6 +13,39 @@
 #include "volumes.h"
 #include "print-tree.h"
 
+static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
+					       struct btrfs_path *path,
+					       const struct btrfs_key *oldkey,
+					       u64 newlen, u64 frontpad)
+{
+	struct btrfs_stripe_extent *extent;
+	struct extent_buffer *leaf;
+	int slot;
+	size_t item_size;
+	struct btrfs_key newkey = {
+		.objectid = oldkey->objectid + frontpad,
+		.type = BTRFS_RAID_STRIPE_KEY,
+		.offset = newlen,
+	};
+
+	ASSERT(oldkey->type == BTRFS_RAID_STRIPE_KEY);
+
+	leaf = path->nodes[0];
+	slot = path->slots[0];
+	item_size = btrfs_item_size(leaf, slot);
+	extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
+
+	for (int i = 0; i < btrfs_num_raid_stripes(item_size); i++) {
+		struct btrfs_raid_stride *stride = &extent->strides[i];
+		u64 phys;
+
+		phys = btrfs_raid_stride_physical(leaf, stride);
+		btrfs_set_raid_stride_physical(leaf, stride, phys + frontpad);
+	}
+
+	btrfs_set_item_key_safe(trans, path, &newkey);
+}
+
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 length)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -36,23 +69,24 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	while (1) {
 		key.objectid = start;
 		key.type = BTRFS_RAID_STRIPE_KEY;
-		key.offset = length;
+		key.offset = 0;
 
 		ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
 		if (ret < 0)
 			break;
-		if (ret > 0) {
-			ret = 0;
-			if (path->slots[0] == 0)
-				break;
+
+		if (path->slots[0] == btrfs_header_nritems(path->nodes[0]))
 			path->slots[0]--;
-		}
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 		found_start = key.objectid;
 		found_end = found_start + key.offset;
+		ret = 0;
+
+		if (key.type != BTRFS_RAID_STRIPE_KEY)
+			break;
 
 		/* That stripe ends before we start, we're done. */
 		if (found_end <= start)
@@ -61,7 +95,40 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		trace_btrfs_raid_extent_delete(fs_info, start, end,
 					       found_start, found_end);
 
-		ASSERT(found_start >= start && found_end <= end);
+		/*
+		 * The stripe extent starts before the range we want to delete:
+		 *
+		 * |--- RAID Stripe Extent ---|
+		 * |--- keep  ---|--- drop ---|
+		 *
+		 * This means we have to duplicate the tree item, truncate the
+		 * length to the new size and then re-insert the item.
+		 */
+		if (found_start < start) {
+			u64 diff = start - found_start;
+
+			btrfs_partially_delete_raid_extent(trans, path, &key,
+							   diff, 0);
+			break;
+		}
+
+		/*
+		 * The stripe extent ends after the range we want to delete:
+		 *
+		 * |--- RAID Stripe Extent ---|
+		 * |--- drop  ---|--- keep ---|
+		 *
+		 * This means we have to duplicate the tree item, truncate the
+		 * length to the new size and then re-insert the item.
+		 */
+		if (found_end > end) {
+			u64 diff = found_end - end;
+
+			btrfs_partially_delete_raid_extent(trans, path, &key,
+							   diff, diff);
+			break;
+		}
+
 		ret = btrfs_del_item(trans, stripe_root, path);
 		if (ret)
 			break;
-- 
2.43.0


