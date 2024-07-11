Return-Path: <linux-btrfs+bounces-6360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98F92E000
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 08:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05E51F23693
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 06:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD313D24D;
	Thu, 11 Jul 2024 06:21:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBA12DDAF;
	Thu, 11 Jul 2024 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678905; cv=none; b=dkui+63pDjOa9SYmGB4faOqvx3T2gpJwPlDuj+FSKh0KSaWIyd/EH1wjkPR0fBorZITIZYAm+Hc0rgG2wXB4j3hX6ZKU+az/15lXYM4R0YYEh7xTCdqROYWmCwQGdVNd/7dyRMAJoy1SYeYszIJL3oZNVQtH05A+eDAQHnE08aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678905; c=relaxed/simple;
	bh=E1Rygkno4T5BcJ7XkxRKwwLhNE9/LYnAAlNk2nXPm28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dccu0gw5wwxstBm7n9GkGizTfrE7WSy2JatJQgfUZxJ01HEaly6GvrW5SZSrk2/j2PITLywfVM6AHcu2YbjJ0eVbp123O6EOuQ2R1+uMgtFSh0W3lCiIq82ovi9eXrWO1fViNYlZs3/GBxl+otKPr8BPqMcOzPCpzbyIi4/fgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6fd513f18bso58802766b.3;
        Wed, 10 Jul 2024 23:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720678902; x=1721283702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QurXtUEH8BTN9nyQvrsoprlRroyt1ZrLsWM6ZQAHQ/E=;
        b=e8x7jcqRDuoalh84flGaNqVcfJaEy+bWL9WjZH2IDVM7xlZeeLdJ4loY3WQDtCkN1F
         A1MZZBqFWEuE1Yza3Y83AXPiCPYfJuC6Z4k1naEe7uX9TDUblBqCjlcJKRnzbFE8JGUn
         VVlW9uuKva3kCtfoC6ROFSJ7OkJgUHGJ4fYbrZMNz661g5/71uf3XCfyBxmcd8mBVu2R
         NU2sXdL0HpyjPgyBnzpAxf8kH52AgT+5adWvflTGHfNzOz5LUDzdSI4nv0P1bzjVvdXW
         B2DxNvruSB1HibqRXNjP1J/6ikapfpAd9f56avdaZxKH/wix4EbdrGrDnD/rc/hXPl1m
         a21w==
X-Forwarded-Encrypted: i=1; AJvYcCXjxI9EQKsgRbflp2aKOKQGuEo1ip+XB90hI4fSX+pFmuAfBdUt34IUghSkSvpOH689bp8NHzppdfnZfjdshdENaJ2YrBpdBYa8swC4
X-Gm-Message-State: AOJu0Yz6ytxdsBdQQZuRj3IjwlpLmGjyU5WfGPYlT5ccVt3/K966S7Ur
	lcTVmHIux5/U/uf4Na08qNzIh6RtupX0+xhL+L7VahGIB+B9xV/s
X-Google-Smtp-Source: AGHT+IE6+eh3Ov+Fr7hFZ1Awnx1zNXof+KAK4NZjeJWzRjrAwqsj5XYOHBQBbWWBjw8TKRZu+G8lTg==
X-Received: by 2002:a17:906:f0cc:b0:a6f:e819:da9c with SMTP id a640c23a62f3a-a780b70539bmr480995766b.43.1720678901679;
        Wed, 10 Jul 2024 23:21:41 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f73ce200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f73c:e200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff73bsm224815266b.101.2024.07.10.23.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:21:41 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 11 Jul 2024 08:21:31 +0200
Subject: [PATCH v2 2/3] btrfs: replace stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-rst-updates-v2-2-d7b8113d88b7@kernel.org>
References: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
In-Reply-To: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2402; i=jth@kernel.org;
 h=from:subject:message-id; bh=V2ekxPfOBKYmlscJ31n+l+AOq+6mmzYwwxP4yafzWHA=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaT1V36UbPycN61fZN2mM5wCvBv8FZUeq+46tPRw+doiZ
 TtNrnkxHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjCRk0aMDHtNj5tPjsmd08kb
 +cMpnj/8dDB3ddq0fxPMXjD6fWTNfcXIsKJxvrW9XvO9+hvB3w4/yd35Upnv+98D3o6+3XWR3rW
 l7AA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Update stripe extents in case a write to an already existing address
incoming.

Reviewed-by: Qu Wenruo <wqu@suse.com>
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


