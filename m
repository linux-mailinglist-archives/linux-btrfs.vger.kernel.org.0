Return-Path: <linux-btrfs+bounces-6317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A1892B042
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 08:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA70B22C67
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 06:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1869913F458;
	Tue,  9 Jul 2024 06:32:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF713E02E;
	Tue,  9 Jul 2024 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506744; cv=none; b=iO267MwpmfTmcHDMaXarLzjOS5womYzd3YgJHDf18qy6/EpRyVt0TKcwzW+VlBcSIkFlcueBdA6NDDia6xEMNRr+e1Scw8RLUU2AndWRRZX76GNjvZwd0/tH4qkgc/FWVCeYKfuPty5jeyusLHoslfOlWy6Czx6NGoeGce4jEys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506744; c=relaxed/simple;
	bh=q9gFy/XwEKiI9CjlaUGuum1Ne2kcm65R/YqRco6dkY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBLePhY6DBhYmSFLLxA0jRKHTYuOopox+ELEsrU8yzeSVxHsrEm01l+MPxjNgUA8eyqKnqEwDvMggjkMwbGAxOASTZNa0mwwV9OsC7lvegk2LFnLRimjP8tGoLUO6OypPXvagTcU5uuJIhT6DTHRXoPuaWpji4tagaUtBr5cA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36798779d75so4160493f8f.3;
        Mon, 08 Jul 2024 23:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506741; x=1721111541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2X7qWagYo2b5UXuhyFICzIjSWa2F0fefrD2a+vdHpI=;
        b=dRBwxWuQeT8HkWRl78NkxE9FtGZ7HAuirD2hcjNGmvm9eAFOpPppx/30vaNRbK32oS
         gAIM7B8eGF8gNYRw342uVFSdpXpjn4qnHXMtuuCsMDIvRWUhY6STg2PluZLB4rg7ex5Q
         m2zkBmOa5y+tfmc9aRoeKnF3k2+V4mFXHDgForGtcXfkTSnsXgMIlRUidc2vGImUmxP4
         xSKlho8ZLc3dzGnLSOy4ocoWyvZ1BEqHPPMpjL+xVy0FaQ/CDZUd1NyHrEyW8SaBr29C
         izU2DrG5DXpnzp3VAROls52CxoqdEZl1KnSSiIu38eDsDJqdhLiqVt75BapFmwKxKKoR
         nE9w==
X-Forwarded-Encrypted: i=1; AJvYcCWvsxw4FJRj4FVvE+HzOkerMDbEEgkkrmgFz1yLAKjbUreLZrrv5a124/NfLWofDcC7cdezgozsY0hj3yHy0sMdLb3Z/Wq+J58A8xIB
X-Gm-Message-State: AOJu0YwcOXY98sCGBwW3M7AOGiXlUJSV0/QLcDDLPxqmYpsKrpwju0J0
	uOEh7wsUUhe6qGIk8t3m9QJfMvu+b6RPdKuXXvOfyHI1PIIAxeYegxV/dLvP
X-Google-Smtp-Source: AGHT+IEY+aKZvLdXvDRAvZXq8Vz2VLMJ0vCPYoa0f629ac+wJiniJWbPFnvS4zbEWWn7B1ePNOw0tQ==
X-Received: by 2002:a5d:6981:0:b0:367:9903:a91 with SMTP id ffacd0b85a97d-367cea45c68mr1414724f8f.11.1720506741224;
        Mon, 08 Jul 2024 23:32:21 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm1569239f8f.63.2024.07.08.23.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:32:20 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 09 Jul 2024 08:32:13 +0200
Subject: [PATCH 2/2] btrfs: replace stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-rst-updates-v1-2-200800dfe0fd@kernel.org>
References: <20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org>
In-Reply-To: <20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=jth@kernel.org;
 h=from:subject:message-id; bh=iXS0EqJj2fo7X0N8Hop1tMZDVNOW43TMkN/0GZKub28=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaT13CwsZk7/q5y3VSrrV8daQ5m3CzZN9fS1+WBuuSZPX
 TPojUZLRykLgxgXg6yYIsvxUNv9EqZH2Kccem0GM4eVCWQIAxenAEzE153hr8jGx2adVyJXTDNP
 7bQVrIp7trL7K7OxjW1M7/H/TOUM3xkZGoS0lHoubA7jkY/gPjTH+eJ6Voue1R8smWrmX9yk9MC
 SBwA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Update stripe extents in case a write to an already existing address
incoming.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index e6f7a234b8f6..fd56535b2289 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -73,6 +73,55 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	return ret;
 }
 
+static int update_raid_extent_item(struct btrfs_trans_handle *trans,
+				   struct btrfs_key *key,
+				   struct btrfs_io_context *bioc)
+{
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	struct btrfs_stripe_extent *stripe_extent;
+	int num_stripes;
+	int ret;
+	int slot;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(trans, trans->fs_info->stripe_root, key, path,
+				0, 1);
+	if (ret)
+		return ret == 1 ? ret : -EINVAL;
+
+	leaf = path->nodes[0];
+	slot = path->slots[0];
+
+	btrfs_item_key_to_cpu(leaf, key, slot);
+	num_stripes = btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
+	stripe_extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
+
+	ASSERT(key->offset == bioc->size);
+
+	for (int i = 0; i < num_stripes; i++) {
+		u64 devid = bioc->stripes[i].dev->devid;
+		u64 physical = bioc->stripes[i].physical;
+		u64 length = bioc->stripes[i].length;
+		struct btrfs_raid_stride *raid_stride =
+			&stripe_extent->strides[i];
+
+		if (length == 0)
+			length = bioc->size;
+
+		btrfs_set_raid_stride_devid(leaf, raid_stride, devid);
+		btrfs_set_raid_stride_physical(leaf, raid_stride, physical);
+	}
+
+	btrfs_mark_buffer_dirty(trans, leaf);
+	btrfs_free_path(path);
+
+	return ret;
+}
+
 static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 					struct btrfs_io_context *bioc)
 {
@@ -112,6 +161,8 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
 				item_size);
+	if (ret == -EEXIST)
+		ret = update_raid_extent_item(trans, &stripe_key, bioc);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 

-- 
2.43.0


