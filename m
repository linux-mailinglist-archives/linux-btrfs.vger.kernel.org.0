Return-Path: <linux-btrfs+bounces-6228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7433928B5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 17:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D70B1F22AF5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CC116CD11;
	Fri,  5 Jul 2024 15:14:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420414A60C;
	Fri,  5 Jul 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192440; cv=none; b=pNPgQmSTB6zG3SAXKx14eznG7kGf6phBnw6Wm3YxkT/uagpGlF7NDhg4xDycnt9P5j2eKl8sSRLwO5OfqeAty4ZXTU4bGMq79uTZDHSe0l9kASBgL3FakcSjU13IQjJEbbY62YOndrY6ghIdzjDM6IawsCg1nXGPLDaE6iiDmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192440; c=relaxed/simple;
	bh=2sRJOr8yNCoBqCRZKtS0aHunaDitsRUFOHAd4BSzZUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kunkyu5TUSFWos2XVuwsLzGaO8x2XhliC3VbytuiczVYa0zStt1Jl4vGELKJKvmJrtKvQk5nRSY2Py8QyAfsV6FBMoRToTtwH6NaR86e5M1MffmPS05xebWyXuIEGdwD2GnH79rc5XM63FkgbW0DSuwoClTXTXfSqQMYCEuygRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso99701966b.2;
        Fri, 05 Jul 2024 08:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192437; x=1720797237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui/evj4sZznHtsxKnMwIDYhzqdeAFRSy+YGy9CYAhdA=;
        b=YjcGASCbotnkxgEZmoZ2f9D4U4rQSsj3D+IUp17tVpbjGMzSfK4oX39663+II0MSR/
         +UWcTY5z/D949VPYAuKwpmzKWrog8Hn5kXk84cLL1M4ulYsn9KpaVikbCE8V5N1Ttkiv
         pcolKgLAuWNkaA41YvPKwNEvSUq3IE91N5opCYcR/Mm+l0YQmw88gFXMQcRgR5F6cidc
         YXXAVqdeQbXW0UU4Ui1n4VxKg67QUD/i+/dISjluxBv0rKG4BHa/piSDBClBEc0qVy03
         HYdT0Bk00O8MILKZlQmAAMPOWBj0mbXbi2Nu5nOtyGAKWahVIaSW+mHCHQP/dRhRDAsq
         BuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUqIxm++lWirtHEYUFIx194u7jGBw7a9XTDv1jvI2wMqH7gQypcVUUxtFbsAgF1ESUbpv3iLHIkPBkt6RaNKFYLkEWYwdEkXn55pX2
X-Gm-Message-State: AOJu0Yz6mOwPV/KF4qaN0Pa/AH4HWES4m0vkVQxeFDNabceh6KIXMSYG
	Ihel0JnOgkt+5wLYV4gE6z5avoM8nr/gluoyE5TwGJSsXgykP78Rl42iPw==
X-Google-Smtp-Source: AGHT+IGg34UcA7/267iQUiqbnGgF9FjuGiH/0pkC+7IkZZzs+TOJ6qrgoxAqW8F+Q7VkoMQdsFMwPg==
X-Received: by 2002:a17:906:3c49:b0:a77:c199:9d01 with SMTP id a640c23a62f3a-a77c1999e66mr244215966b.22.1720192436759;
        Fri, 05 Jul 2024 08:13:56 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf6336csm686226566b.70.2024.07.05.08.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:13:56 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 05 Jul 2024 17:13:47 +0200
Subject: [PATCH v4 1/7] btrfs: replace stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-b4-rst-updates-v4-1-f3eed3f2cfad@kernel.org>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
In-Reply-To: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072; i=jth@kernel.org;
 h=from:subject:message-id; bh=hWXRtvyntafCT4XnKrcTYAkQgbW5dNOrGqpu/T/gXtA=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaR18G4MXuwty/94mlGv2wsV7xKRrDkCt4WfCHU9M2Y6P
 O9J1/rAjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZjINyOG/3nzb8lGRz22evXu
 xLOc1NLatX4LAw6+uPnH4vfWG5zJd+sYGbbt+tXX51KbxXV047q+Wbd5M7/bztvRp/OaQ65gn/L
 VMC4A
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
 fs/btrfs/raid-stripe-tree.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index e6f7a234b8f6..3b32e96c33fc 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -73,6 +73,39 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
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
+	if (ret) {
+		ret = (ret == 1) ? -ENOENT : ret;
+		goto err;
+	}
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
@@ -112,6 +145,9 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
 				item_size);
+	if (ret == -EEXIST)
+		ret = replace_raid_extent_item(trans, &stripe_key,
+					       stripe_extent, item_size);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 

-- 
2.43.0


