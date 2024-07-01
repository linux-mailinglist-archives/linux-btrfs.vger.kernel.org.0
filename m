Return-Path: <linux-btrfs+bounces-6069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDAE91DC62
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC2F1C214F1
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D813E043;
	Mon,  1 Jul 2024 10:25:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7984D29;
	Mon,  1 Jul 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829527; cv=none; b=oH3Ua4fWKOkqWhe7btVLhTGfT1c9ssJk9NHuk+RGuTpubfu/n6UXQ+CVnizhUs0lMta9XInu8i1iO3W1bRjHD9CHfmiPY4OhsjZj6oHY5N4wLkP90OOSyoCdLYidQdT+kMXPt/rlnL158jfMBqsMQKgEoTQz+cUoJyQpfV6RNeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829527; c=relaxed/simple;
	bh=pdLAdw8AbZIIIqEbHF3B9lATObRLtWTBZcl4cyl+jVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAPhz+In7KTzt2l4yndYrVWgD3KzTP5xDmIF3vJ4/G59XCofZvKVUppU943xEJQAwk17ijeglMaLQ2EtmRdKaQ9t3UsjxYRjN1Ob6H+M2dSg03C4ejQCCLOhLc4SAF+CePJxkqi1I+/vYTBytn6XZO39FC0O08TXle3MjnO2b78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso56902a12.2;
        Mon, 01 Jul 2024 03:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829525; x=1720434325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3M8GIwcTP2w6CaI85iIBf+6uE7YDXide+uxJUTmFVs=;
        b=iE9PatDok/LADHyBTePVd9d381OEA4TuRnORTGOGzp77C4dIJVkqmxt5gMOHNExxS/
         /0NkH28nZndM5rFjiwrXo3o3fhAnvzSnJKl3uRslXLqu00WcbL9c2EFhfFXxesUezo1N
         UEtCA34louvsD05SMXhTJigS/qdb6i3qdy2PsjgpJx9vkxqOsV3HKy/o75gNcGP7FW6z
         wrt+5aNh3zAQ4a3IUebFkJZ/AjUv1ibo1z3pJGiCj10HiLAUUuHIjx0zCGml0pXAxR56
         V7LcDWngPFRZ2r4pZQV/XzmOR2uTKAJyODykn/OJ3US+ZC6wIuWzKVr/prYlSmfiMLFa
         gfmg==
X-Forwarded-Encrypted: i=1; AJvYcCW+klTP+DOjfUYeF6w8Kb+8GkX1eaipvrvvm60iu9paJlobSgq5P8UuRrfR4JQDWdof/nfCGhCvV2f62eJ8wW+cbFVstSaUxHCNgLjL
X-Gm-Message-State: AOJu0Ywpli+3LefUZcC3gPT+cXxXa5Dlq5JPDZY/zWbkX1OcbG+ww8xv
	npSH4Nmpj1PIK7l2H80nAz31zSaVjoABrPWzasyEAE2Iu+FQJLGT2X+J/g==
X-Google-Smtp-Source: AGHT+IHDIUs+Btlle/80N7RuFpfFk6isvbItryFLFBl4+0cfjgExi1OR4p3DFxie0ApVD7kfiHrcRA==
X-Received: by 2002:a05:6402:42cb:b0:57d:22ef:d055 with SMTP id 4fb4d7f45d1cf-5879f983b59mr4077835a12.24.1719829524509;
        Mon, 01 Jul 2024 03:25:24 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c83583sm4238901a12.5.2024.07.01.03.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:25:24 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 01 Jul 2024 12:25:15 +0200
Subject: [PATCH v3 1/5] btrfs: replace stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-rst-updates-v3-1-e0437e1e04a6@kernel.org>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
In-Reply-To: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=jth@kernel.org;
 h=from:subject:message-id; bh=3H78qr1E4CM/iN5I9YPMUD81FD/yCQ/9SOrHfoxgDzI=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQ1tQhN//wx14u59Ons9umbm6bqdmxnir+0qedF56qzp
 TE2bF1vO0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAi168x/BVL82mYGSa6NLg/
 8lto/aP5xlsfHv33wC96wb/mP788wxwZ/nAzJMVv4HtsduxH/wnu8hlb3y2UXVLD/1Lu4CWRuxt
 rs/gA
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


