Return-Path: <linux-btrfs+bounces-20507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A35BFD1F16B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 14:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A17D2302D8A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A934399004;
	Wed, 14 Jan 2026 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcqJ0uB7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03137F8AF
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768397922; cv=none; b=b7vhUgtO9W7TlzjR6A4cJrUPAU7O1n2K7h8WfWU2AKOmspo7O2Li9wSOCJnzJ1VxZEhm6HFzG/XURRDkqxgaPnfR1LA5G9BTM0KMazIKMWc6DcTJxfwcGDEyaY3IHn9QCBOPXUOw4K3/D7cSwpj7gUHWBw9pvq8stc/J8NPqesE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768397922; c=relaxed/simple;
	bh=P1Lj4iXnVBMDNweWw9cDA2VEouzDpxdajoQGJ1anIHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETIrrXBOebb73BbaWfqb/ObHn0jKVB3FarJMKkskJzCAJxoj1syUyao23GftLObjgd95bmzVisHrpfY2F0MxiWTuP8RC2miM8sl0+UCRi8rAPCRtIXj2tIdJo3gvnRMze5rdlVobrkRJ47xJXGAX/LjX2NNGyXwYO6SUOcp47N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcqJ0uB7; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a097cc08d5so20770435ad.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 05:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768397920; x=1769002720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lj8aD6d/wD/FqBBRGVYO9cbkzACLASPmnGR5ygEp8dI=;
        b=GcqJ0uB7aypd6ryBRCHHFEtlvB0czlQolIklWJkctKYIhmlU56Pm6KzHlsx8D6+AAk
         8WGlISLz8yh5TByAA9KYTLHS3Fjens4pGIwvsmlvW70kmsSwCOCitbz+Qsc//sNd7z7v
         fmSx5OPW1R02ktU3lPfzACUXpJiujb2ZyHftHXllIH04ioz1924JGUcGBjub09CbXwkE
         sjnlitE27AftTveD6WymdIrKt9F0hut3rMhbY4/QV4LzS41hqeucUrCKLLKubEcECN/P
         Q2UHc/uUwfIgvqZoj72pkHzRrM+XWcUJXTH+wxI/4C+oSG4J+IqhbjyJNot9B7jWWS6g
         pUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768397920; x=1769002720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj8aD6d/wD/FqBBRGVYO9cbkzACLASPmnGR5ygEp8dI=;
        b=VRMxX5Af4ovkCTBrvGnfa8rDdL5zCkP9rDjBzAEBUTjX03jircE4LwuelK3iYJtfA9
         R2JcCqZxlsH48odtlUr//2OCEDm8qRomq0ouJbHdaWqrBLG+qJ0N1tXB7q0y4cg01zpv
         UF5qG/4qkw6twV0KnljQOuMUKl91MA7nvP4QbD2bJAhuyuNBlm0Goog6RSX8lLb72bKh
         yf778gOsCHCgJiewOXuGNB2rYQJyQ2w8Pd9cF8AQCpc4+u2Lt9qfr2znjO6DHcRV1ibp
         U8F1F1koRyX/wKSQzE8MqQ/jooHK2jIFt7onxbJvlRQt0HNo3TwQ0GzG0NmF/hWmJ4rF
         jkPQ==
X-Gm-Message-State: AOJu0YyPuwL7NCTTWGMsEr2eTiWrhKILJiCO7lJ96g5eDQ9+BdO9/21e
	EsSKWaJWWSvCftmtzEWAbq2+eSco7+eYkU6bT/32syGQX9m+Dnhll/CaI5UJbHlYlgJYLQ==
X-Gm-Gg: AY/fxX4TQzVgf5J8+9yh1wDvtH9yY4U2TyhROEgOPtC+aFW+i3vClIOBx83oeNzq5Ua
	ze5URpvD124fhin1jtg9/ad4/4IH12Oa5+RazKL9+M77q2IXm/B+iKn86YDw+weD8k0/ms2BHnd
	yMl7I0O/mq31lShiLlExKby9JjDZcc+gdTOHPUX5/zWYYnyfkBbORB9ekYGSt7dkTWYQURcFibP
	ikcKCVCs5KJAdIgUIJCuj0vFQvpVTd3Fu08tKnU/OYHBOgkwfFkL51wE5txax/9o2fYmb/t9sIB
	Gz4leedZQVHTphZYz0e0VPnI1weTlx8BA1mxetBS4Et4TMy67b8RAK4hiqTmyzzKr68rPzLbtRW
	KC6DpctEgTQ+5+3KMzKeDKznXKINeyOhSC1iI+ZCVF0g3HJ9ESGl3oDjn9RkUjU2+RniDrsA1R3
	0sVOlgCCEZW1OSw86K05IP
X-Received: by 2002:a17:903:22c8:b0:2a0:d63c:7859 with SMTP id d9443c01a7336-2a599db2d1cmr18358615ad.3.1768397920220;
        Wed, 14 Jan 2026 05:38:40 -0800 (PST)
Received: from SaltyKitkat ([104.28.237.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8dd2sm227034085ad.82.2026.01.14.05.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:38:39 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: search_tree ioctl performance improvement
Date: Wed, 14 Jan 2026 21:37:43 +0800
Message-ID: <20260114133818.2755-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the following two assumptions(min_key and max_key here is the
related fields in search_key):

1. When `btrfs_search_forward` returns 0, the key will always greater
   than or equal to the provided key. So the function `copy_to_sk` will
   never be called with a key less than the min_key. So we will never get
   a key less than min_key during walking forward in the leaf.

2. When we got a key greater than max_key in current leaf, we will never
   get a key in search_key range any more. So we should stop searching
   further.

So we can safely remove the comparing with min_key and replace the
continue with early exiting. This will improve the performance of the
search_tree related ioctl syscalls, which is the bottleneck of tools
like compsize.

I've run compsize with and without this patch to compare the performance.

When cache is cold, it's
4.29user 28.48system 0:43.39elapsed 75%CPU without the patch, and
4.52user 22.53system 0:38.16elapsed 70%CPU with the patch.

When cache is hot, it's
4.10user 19.42system 0:23.52elapsed 99%CPU without the patch, and
4.23user 12.73system 0:16.96elapsed 99%CPU with the patch.

This is not a serious benchmark, but can reflect the performance
difference.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ioctl.c | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6eb6fe47074d..376c17c8233f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1432,30 +1432,6 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	return ret;
 }
 
-static noinline bool key_in_sk(const struct btrfs_key *key,
-			       const struct btrfs_ioctl_search_key *sk)
-{
-	struct btrfs_key test;
-	int ret;
-
-	test.objectid = sk->min_objectid;
-	test.type = sk->min_type;
-	test.offset = sk->min_offset;
-
-	ret = btrfs_comp_cpu_keys(key, &test);
-	if (ret < 0)
-		return false;
-
-	test.objectid = sk->max_objectid;
-	test.type = sk->max_type;
-	test.offset = sk->max_offset;
-
-	ret = btrfs_comp_cpu_keys(key, &test);
-	if (ret > 0)
-		return false;
-	return true;
-}
-
 static noinline int copy_to_sk(struct btrfs_path *path,
 			       struct btrfs_key *key,
 			       const struct btrfs_ioctl_search_key *sk,
@@ -1467,7 +1443,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	u64 found_transid;
 	struct extent_buffer *leaf;
 	struct btrfs_ioctl_search_header sh;
-	struct btrfs_key test;
+	struct btrfs_key max_key;
 	unsigned long item_off;
 	unsigned long item_len;
 	int nritems;
@@ -1483,6 +1459,9 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		i = nritems;
 		goto advance_key;
 	}
+	max_key.objectid = sk->max_objectid;
+	max_key.type = sk->max_type;
+	max_key.offset = sk->max_offset;
 	found_transid = btrfs_header_generation(leaf);
 
 	for (i = slot; i < nritems; i++) {
@@ -1490,8 +1469,10 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		item_len = btrfs_item_size(leaf, i);
 
 		btrfs_item_key_to_cpu(leaf, key, i);
-		if (!key_in_sk(key, sk))
-			continue;
+		if (btrfs_comp_cpu_keys(key, &max_key) > 0) {
+			ret = 1;
+			goto out;
+		}
 
 		if (sizeof(sh) + item_len > *buf_size) {
 			if (*num_found) {
@@ -1560,10 +1541,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	}
 advance_key:
 	ret = 0;
-	test.objectid = sk->max_objectid;
-	test.type = sk->max_type;
-	test.offset = sk->max_offset;
-	if (btrfs_comp_cpu_keys(key, &test) >= 0)
+	if (btrfs_comp_cpu_keys(key, &max_key) >= 0)
 		ret = 1;
 	else if (key->offset < (u64)-1)
 		key->offset++;
-- 
2.52.0


