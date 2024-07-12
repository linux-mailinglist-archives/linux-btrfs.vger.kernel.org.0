Return-Path: <linux-btrfs+bounces-6414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D0592F677
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 09:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D08AB20D07
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 07:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73718E0E;
	Fri, 12 Jul 2024 07:48:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AF13DBA0;
	Fri, 12 Jul 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770528; cv=none; b=O6h16KczAQAyGLSLlbBpWE47DNnrkVL4CnMVyeRj2GABlPaMZJ3T4mNAuEfZXkBioCUIWxd6SoXXiLGUqPi1jbO79n4zPoYmwdb+va/v9m8ftC7PRoT8qjdEmMCQPqdu1Bn1KweXR8HuPAacZmzx6LfnNK0KhZ6TkDijGPiu+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770528; c=relaxed/simple;
	bh=XUwugfCE9Tm+k6GDreopNnOooRbhzsUUDl5CILgTSt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=on0WoY8qIWJfGGCZUklAxTjJz99JGzqBEBOB+C4Th3hrnXkQ+26xliyB2Rv/I6eps1FmdnO/z4ets7i7GsAUE9uro0cPmUE8lG7XeF/LB7m44ODal5vgzw5T2NQfYd39pgYSfOfBKFyO/P7NlVngTzVzDydHeCbDUNiEAVn18HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-426717a2d12so10314255e9.0;
        Fri, 12 Jul 2024 00:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720770525; x=1721375325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2FIO7np3Ivb7Xklcye4ZI+8TK1UL4eZRCnQV0PzGzs=;
        b=XeK0iemmxyJNXjtLiGhtPP6V92qNJjBGW59sUm/WRjSafaGLS+qMtINEf1CyQMchi7
         LTIZ2AAKkTCb9Hc7ToZ9fV4VlFStzZBl+QR5JGB/KK/fQWJ/EwHNCspGLNegv7i2zQLE
         lQzhGTI7B5Aqx+gx9Lj+jcIqY5dh3cJj2lrAPWELMI+wzytxCTW5fA5x0dydEG0YbZnW
         pWMxECJxLl7GaSWO6B7zVRlblkwk3yAIplupEapN4aJUxFt6Ehu8svo7KM3P91+8BBZr
         4mPo88F9Qnzava0kvrbtQXDgZ6xyJqDaJnnVtllRZqSVviD/tEwwW5+jgK3f9KQ03X4i
         H5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXVgWZ/4s5PAEIoP9U/NgMzZct5kqg7TlW4uJEdAAG9pK6o0Tmai2UjvVL/oyfZvBiDaHXhSpEv1JAMl6f/gXZBLGuSHQc4hQG0e5QM
X-Gm-Message-State: AOJu0Yzlclf0+b9ZABgVTPLyFig1/FFMMhr32PvRLeAyvY1LWTC8MR5s
	ydi8ulcvzv2LEg1/TPI+lS5robsrG5a6rsT2+QxkkkzqxCqTAlzG
X-Google-Smtp-Source: AGHT+IG5b7wTHma6DdXeRHS2MUe1fLAA/3B/ylXxcuC4fkr3T8IthFxiwfaNy3jklpKuHubc+91S2A==
X-Received: by 2002:a05:600c:6b0b:b0:426:698b:791f with SMTP id 5b1f17b1804b1-4279d9f3513mr13070895e9.3.1720770525117;
        Fri, 12 Jul 2024 00:48:45 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f73ce200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f73c:e200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d74d5sm13532115e9.46.2024.07.12.00.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 00:48:44 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 12 Jul 2024 09:48:37 +0200
Subject: [PATCH v3 2/3] btrfs: replace stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-b4-rst-updates-v3-2-5cf27dac98a7@kernel.org>
References: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
In-Reply-To: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=jth@kernel.org;
 h=from:subject:message-id; bh=dOFoLPAc5U8sFuri/LBq+DIup0Nt+zq+aMLO188sAjY=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaRNuH9ryfz1fJKFQbePZ5p+enemjjXh+Yl0Jdb32zYda
 qgJrpoj11HKwiDGxSArpshyPNR2v4TpEfYph16bwcxhZQIZwsDFKQAT0RRjZPiW5Rqy4tmzCk1D
 fVPmx+rbGrddClq8944WH8s84SbnQ2qMDHdsZt9dU2Jhq1xfYr2572nvNYmlV51m6V61+fq5vHj
 9dT4A
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Update stripe extents in case a write to an already existing address
incoming.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index e6f7a234b8f6..53ca2c1a32ac 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -73,6 +73,36 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	return ret;
 }
 
+static int update_raid_extent_item(struct btrfs_trans_handle *trans,
+				   struct btrfs_key *key,
+				   struct btrfs_stripe_extent *stripe_extent,
+				   const size_t item_size)
+{
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
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
+	write_extent_buffer(leaf, stripe_extent,
+			    btrfs_item_ptr_offset(leaf, slot), item_size);
+	btrfs_mark_buffer_dirty(trans, leaf);
+	btrfs_free_path(path);
+
+	return ret;
+}
+
 static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 					struct btrfs_io_context *bioc)
 {
@@ -112,6 +142,9 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
 				item_size);
+	if (ret == -EEXIST)
+		ret = update_raid_extent_item(trans, &stripe_key, stripe_extent,
+					      item_size);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 

-- 
2.43.0


