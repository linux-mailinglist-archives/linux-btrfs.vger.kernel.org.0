Return-Path: <linux-btrfs+bounces-5819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F9290F241
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF591B2290C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE48152181;
	Wed, 19 Jun 2024 15:35:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26615217F;
	Wed, 19 Jun 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811306; cv=none; b=nuueFtTDqlzsCUUa8Kwb/pkWeNsHZW+ZxCsqztMZf70sD/wyWVhY36sE1fjlSlpJDOkNawp0yAC/eAx4ycV9G5q/Ytgu14YLuaxVoVAu004JMmlgqlqFxmyXNJZLW/gwi6LEIrcEAYINOhulZSDokpnFvZvGp+7e2W0i/J1IUmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811306; c=relaxed/simple;
	bh=pdLAdw8AbZIIIqEbHF3B9lATObRLtWTBZcl4cyl+jVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+ZDbrZEG94FkBizrtHsw7fweIGxsF6TLkV5d6WoM6B3kx+knGv2AEtrlgjl9U0C4ozHP9+xqikAhQVhryRsspuMwrCWyDnhKEhqAog8bZAFFTvdv4sdIjRofSn55GMsw1Lh8YinM8ScsXVPyb6Ql5P29WjM7WQF+vOlnvWuRjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217926991fso60251035e9.3;
        Wed, 19 Jun 2024 08:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811303; x=1719416103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3M8GIwcTP2w6CaI85iIBf+6uE7YDXide+uxJUTmFVs=;
        b=J5jPl8xcJwd8C287XXY+A9hnc4H6bEVinnkBAvQyVBBUZpfVV7uuj1fSF0wxE8B+FT
         i7bJIcQKg+XNKcAuTm1iAV1cA976AS7H68rBEyRLs/tO9ggXH2bU3DOHNjO3bolpdPsc
         znvt8YXbAf4xDNgcnRAf6U2TfxdVYqNdYsR6+z2Z1N2OWXQzKdQLiRoDT4XSbZhRFySG
         9wuNCrP8LEDhvMFR8kGTlm3GUzDVXy5HrhCjDHPUMVj4WDv75coCnGPh4RKl937urgtm
         tUhcUt4MiZaLxMAaVV6Za4SHB1fGgKZyLskcQ+xcXcZvuidDquHrgpxikkb3knBbLbHq
         ix0A==
X-Forwarded-Encrypted: i=1; AJvYcCXIDu1bhspjygtIYH73mnt6eXW8WMzTf8ylVRH1+52hjaCU6YtiwhlfIUo88totB/I8/BxyTULYIYYNNhHVyj7GAlT9dGUNgEeXd9Zd
X-Gm-Message-State: AOJu0YylhBYkIreEfIXkgO5YtGLGQoRwLgYpGEC7fhPCreCpxwkwGUtn
	+jq8wvWS4MVwwaeRVD0UT282xri2wGl5yTK002xS5oOunZO8G4qDV/qgRA==
X-Google-Smtp-Source: AGHT+IHH7PwUv8S1iCYF3J3uQVXx9HoQ7MA56Uvt4zifcynRnlfRoYPhwNv5yEMIHiW0MsMCat1ZWw==
X-Received: by 2002:a05:600c:6a9a:b0:422:50d7:ff0 with SMTP id 5b1f17b1804b1-4247507a6f6mr19328995e9.3.1718811302938;
        Wed, 19 Jun 2024 08:35:02 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7110500fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f711:500:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe9263sm268882135e9.15.2024.06.19.08.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:35:02 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 19 Jun 2024 17:34:52 +0200
Subject: [PATCH v2 2/4] btrfs: replace stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-b4-rst-updates-v2-2-89c34d0d5298@kernel.org>
References: <20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org>
In-Reply-To: <20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=jth@kernel.org;
 h=from:subject:message-id; bh=3H78qr1E4CM/iN5I9YPMUD81FD/yCQ/9SOrHfoxgDzI=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQV/Vp42zFll1rEtHOZSd9WFFpP5PXRvBQR9kSLKWj9x
 +t72DJUO0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAifUGMDIeENGJCQlsnLTJZ
 8uNwMMN1no72mjK1Ny1q+9PPXmdv82NkmPT5prngw4k/9Y/uP3360z31eH+Bm5b+5W+epr6LmS5
 5mRsA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

If we can't insert a stripe extent in the RAID stripe tree, because
the key that points to the specific position in the stripe tree is
already existing, we have to remove the item and then replace it by a
new item.

This can happen for example on device replace operations.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index e6f7a234b8f6..3020820dd6e2 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -73,6 +73,37 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	return ret;
 }
 
+static int replace_raid_extent_item(struct btrfs_trans_handle *trans,
+				    struct btrfs_key *key,
+				    struct btrfs_stripe_extent *stripe_extent,
+				    const size_t item_size)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	struct btrfs_path *path;
+	int ret;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(trans, stripe_root, key, path, -1, 1);
+	if (ret)
+		goto err;
+
+	ret = btrfs_del_item(trans, stripe_root, path);
+	if (ret)
+		goto err;
+
+	btrfs_free_path(path);
+
+	return btrfs_insert_item(trans, stripe_root, key, stripe_extent,
+				 item_size);
+ err:
+	btrfs_free_path(path);
+	return ret;
+}
+
 static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 					struct btrfs_io_context *bioc)
 {
@@ -112,6 +143,9 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
 				item_size);
+	if (ret == -EEXIST)
+		ret = replace_raid_extent_item(trans, &stripe_key,
+					       stripe_extent, item_size);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 

-- 
2.43.0


