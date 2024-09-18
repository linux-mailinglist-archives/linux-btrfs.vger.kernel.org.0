Return-Path: <linux-btrfs+bounces-8110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A597BDB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D002E1C22279
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE7518B497;
	Wed, 18 Sep 2024 14:09:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2520EF9CB
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668547; cv=none; b=VV3zZyqRuYEQcW7ecmwNrP9FLsfom43KhFBdiWWKgNc9YiqGPvyJwhzGdIMHJMuqvo1eR7PbaQwc5Emd0SJDqmsRYmchqNEJB2rT669ujB5ezaUfJyg5Lw7vu1rmTd+Dn+YL3b3RqHjebaIc2vmwusQjTOOu1IaUmMPIMxY7/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668547; c=relaxed/simple;
	bh=6tnYlSsMuoT2rLJTiBlBoiWKCGvAffky89H0sQRKFT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j98QRZyb9go2or7Q64PJwdObsdYX0reMqw8IFma2tIN0IEEYAJEQ/X8bauMH+aYALcEQHrH3Qx+sC19OehDQanLVuUu9Dm4QPqEF2kYtySK9wHAQqKQYUPXVFmvTdmdXs8SbO0I3WizSUscZI0aGRym41uKY84iT9H5XsVWNlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so66921285e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 07:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726668544; x=1727273344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6/9NvyV28MezKBTULTWOn1KxDnMQ2m0K9DWObo8thk=;
        b=B2FJP1DRg5cYXU/qfKVd6+ICjxEwuAM1NT9LScYnTlq4WLa1VrtYEkwfwi8IcRXGUj
         zWZ4e5WDlvBExrsHstLVZh1sykqp7ViaCz1Kguz2UYnI3zzU4YsjK2D68Lhrka+zoOGF
         ETPq2Fo5UfqIUBhe0TwBq7oOxxGXh3jej/syiwpW4/dzPPILdT+HAr1QIuTEPpHj8Orp
         IC9veR7u74F1C3d8sKCic3oTAo/NKJiBhr+JjOuN1Uj0SZjrz9YFhMfk3NeTVzYcWtEB
         bFrre+UpCTXfTeMkT/kMJVr2eOp3Pxu6vDFm7l32AY62T7VL+p2vcrGQjhP54jkhNd0N
         grBg==
X-Gm-Message-State: AOJu0YwzZXloTqfMwdbCqrlQZ+y7vu7hmqwEkYYIGBQa+FTSjgik9k+P
	RXEUD9gBa0ruxqxEexgZw05MZ7Y2r1TKDPQ8ftoTjtiCT8Nc7VVn
X-Google-Smtp-Source: AGHT+IFPc/dsTyBcpiPMZtX+V6EWENTsNcTkvwjr4Z0ZFgGoNRpV1FJVbMv2XTsALrn3/yhAWTynVA==
X-Received: by 2002:a05:600c:1e1d:b0:426:5fbc:f319 with SMTP id 5b1f17b1804b1-42cdb5783d9mr159465375e9.33.1726668544093;
        Wed, 18 Sep 2024 07:09:04 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f72a2100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72a:2100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e704f2698sm18282125e9.24.2024.09.18.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 07:09:03 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC 1/2] btrfs: introduce dummy RAID stripes for preallocated data
Date: Wed, 18 Sep 2024 16:08:49 +0200
Message-ID: <20240918140850.27261-2-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918140850.27261-1-jth@kernel.org>
References: <85888aaa-c8f5-453b-8344-6cabc82f537e@gmx.com>
 <20240918140850.27261-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Introduce BTRFS_RAID_STRIPE_DUMMY_KEY which describes a range in the
RAID stripe-tree that is backed by meta-data but no data. For instance
for preallocated extents.

On read, we can simply ignore the contents of the stripe_extent as
we're not interested in the physical address and device id of these
stripe_extents.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c     | 43 +++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h     |  2 ++
 include/uapi/linux/btrfs_tree.h |  1 +
 3 files changed, 46 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 075fecd08d87..bbe0689b1d17 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -158,6 +158,40 @@ static int update_raid_extent_item(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+int btrfs_insert_dummy_raid_extent(struct btrfs_trans_handle *trans,
+				   u64 logical, u64 length)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_key stripe_key;
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	struct btrfs_path *path;
+	int ret;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	stripe_key.objectid = logical;
+	stripe_key.type = BTRFS_RAID_STRIPE_DUMMY_KEY;
+	stripe_key.offset = length;
+
+	ret = btrfs_insert_empty_item(trans, stripe_root, path, &stripe_key, 0);
+	if (ret == -EEXIST) {
+		struct extent_buffer *leaf = path->nodes[0];
+		int slot = path->slots[0];
+		struct btrfs_key found_key;
+
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+		found_key.objectid = logical;
+		found_key.offset = length;
+		btrfs_mark_buffer_dirty(trans, leaf);
+		ret = 0;
+	}
+	btrfs_free_path(path);
+
+	return ret;
+}
+
 static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 					struct btrfs_io_context *bioc)
 {
@@ -305,6 +339,15 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	if (end > found_end)
 		*length -= end - found_end;
 
+	/*
+	 * If we have a BTRFS_RAID_STRIPE_DUMMY_KEY it means we've hit
+	 * an entry for a preallocated extent. Noone will ever check
+	 * the physical, only logical and length, so we're good to
+	 * bail out from here.
+	 */
+	if (found_key.type == BTRFS_RAID_STRIPE_DUMMY_KEY)
+		goto out;
+
 	num_stripes = btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
 	stripe_extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
 
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 1ac1c21aac2f..dbe52789f201 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -27,6 +27,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 				 u32 stripe_index, struct btrfs_io_stripe *stripe);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_extent *ordered_extent);
+int btrfs_insert_dummy_raid_extent(struct btrfs_trans_handle *trans,
+				   u64 logical, u64 length);
 
 static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 						 u64 map_type)
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index fc29d273845d..76b18013b394 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -281,6 +281,7 @@
 #define BTRFS_CHUNK_ITEM_KEY	228
 
 #define BTRFS_RAID_STRIPE_KEY	230
+#define BTRFS_RAID_STRIPE_DUMMY_KEY 231
 
 /*
  * Records the overall state of the qgroups.
-- 
2.43.0


