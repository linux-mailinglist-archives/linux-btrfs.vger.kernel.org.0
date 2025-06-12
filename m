Return-Path: <linux-btrfs+bounces-14618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8745EAD66D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 06:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BC01884E66
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 04:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC01DF974;
	Thu, 12 Jun 2025 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiPF4+52"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC53C1DED52
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702845; cv=none; b=S++8pVzB1kDubLo1AbIIhXBmhRtXOrC0nXOguJiHbY7nRk8IHtwfzoN1QtyIeNX9rx54zsI6K5TgO3cnI3j5fdtHlPXGZF/Qb75QGiEEK+gsCkSJ+3CqzQbH2dwvdMC+VYbCjG1yWbhIWj0wwBqzEdM4Oa/6CoblcnCrtyhsqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702845; c=relaxed/simple;
	bh=qpZQi5uznQH29xIeRy/vRfZm35/6GNfzWZufmpsSHow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZeBqR3nED07qB/OQUj/PFa/vrVXYX0g9P3rADL+vzFFCxtjh2v12/rsHp+tghgxXI2NT/tV3lnLMtsETgu98n52m5E6UaYW0gaIc6lXgl8sCXBCOB3D3U0N64mOEDb/L9Cn5yeAejd84MC4bNaA3PBw0gaWAz4rpgRI8zmK3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiPF4+52; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-6f2b58f0d09so346196d6.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 21:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749702842; x=1750307642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stLNfA5SNjpzH9gaZ/EZ/DsdfbVrIKR026eT7RvkUi8=;
        b=EiPF4+52CXu5Pm/8jaFR2N59xgoPoNJJcVnPO3nA+5JMGfnvk8RWMDx2B6L85U1rAP
         70nz4gYE+9IjKbrOjOQrnA295HyHpGRshco5L6KkL29nPDFbPlVjYM7ZTNdHO3tuLxtW
         PibtHcQRT3cSc/KKFBi8UkL15AF3rC5FLjFfSMwpw6LeRR2i2O82sjpV8Ye+IWXodfM2
         r6ASAMCGSqsf6VWTvpvMhGpsgsbhuMHFZ1Zv2FMZFsVtJgaLb3AEraYCa9rK3IVlhAGq
         Dx8tSAJWSIjucHV6MUuHTQ20VAsIm6XVzoVfTe5NafNMnQo7w/gKiwcVEbLxDdAXf9DS
         3+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749702842; x=1750307642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stLNfA5SNjpzH9gaZ/EZ/DsdfbVrIKR026eT7RvkUi8=;
        b=K7hlSuK0V4knNQsWi62HLPnUucp9V57GxDjD/0OnwYMN7mBrqVDG5fjxbgUehJXieL
         llUuF4/VCzV+aSd2t5Ra/IjvtmgN1kUUQ0Ci9vKfEFQc0N+26YB2tyYbJcqmoCu5uDK3
         QQN+guyyQJmlxpZcTsDA296cFiVdS7A2CuP/BYJCvlboYuxYzatIovi6hpbfr0fMWfBe
         Ypbk6M8napGdYCG37IfsdVcGZdE2IXopzYF1S3g0hq0lB1x9uiT717mStFyTqy+63UMr
         peo8wGj22bZUk06MgIUXU0Wk4BGoElrScrtGHZ2OuxrNDZK/yopF36Hx0Sc1gPien/+X
         hSFg==
X-Gm-Message-State: AOJu0YxDF6HdUcYkNcvM9jM6lFWsht9MgE6Dl9BmDGmesifVNL0zY4pz
	VM7e+WrHnzwldu9/LezdPDxzLv4trQXYZF1iYTeDPLBC0QkE7Kgj4BJOLzyY/iTGY0MhsQ==
X-Gm-Gg: ASbGncsSDLXgiyH1C47zNjKQbyScqfVgiHtE08Oe6s6j6BCMRd+BiToccm+XkQapjHL
	enFUxRXyRk66NgQSl1sdUqch9G1s1qhamLt/gikv0ANMxJpTF7n9jDxQntIR3nCvkWJdhgWeIvC
	En1gjSwruGWa4W2UwCgy7yAymnGc7BDjSCuj80Z7upqkreJ4oqJ95V0p9vFevTpXh9wOf2CuEpq
	lf9MeCwteiwekaaVaGE6ryLdn1KRnKs9pUcoil1XhdL2gsz5J5Fm8VNNqpL8BByxXS4zhDVMvgx
	tH91NiSzt68JfMhmUl2SZQw6km5MpmlMvfw7r0P0l5+yGqPIXOM1/g+jmpMOyA==
X-Google-Smtp-Source: AGHT+IHcotG4+4RInxI9792Lgc358nL48XVrlbM9X8JywIyZteG0Ch356UVcVQkd0hG0BQCgTzEhsA==
X-Received: by 2002:a05:6214:252b:b0:6fa:cbe8:b86c with SMTP id 6a1803df08f44-6fb2c367e98mr33981286d6.6.1749702842414;
        Wed, 11 Jun 2025 21:34:02 -0700 (PDT)
Received: from SaltyKitkat.. ([154.3.36.122])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c42a28sm5524836d6.83.2025.06.11.21.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 21:34:02 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 3/3] btrfs: replace key_in_sk() with a simple btrfs_key compare
Date: Thu, 12 Jun 2025 12:31:13 +0800
Message-ID: <20250612043311.22955-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612043311.22955-1-sunk67188@gmail.com>
References: <20250612043311.22955-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The min-key guard is inherent to btrfs_search_forward().

The max-check logic is equivalent to the original.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ioctl.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5e6202a417c4..2bc99e603974 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1446,30 +1446,6 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
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
@@ -1481,7 +1457,8 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	u64 found_transid;
 	struct extent_buffer *leaf;
 	struct btrfs_ioctl_search_header sh;
-	struct btrfs_key test;
+	struct btrfs_key min_key;
+	struct btrfs_key max_key;
 	unsigned long item_off;
 	unsigned long item_len;
 	int nritems;
@@ -1492,17 +1469,26 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	slot = path->slots[0];
 	nritems = btrfs_header_nritems(leaf);
 
+	max_key.objectid = sk->max_objectid;
+	max_key.type = sk->max_type;
+	max_key.offset = sk->max_offset;
+
 	if (btrfs_header_generation(leaf) > sk->max_transid)
 		goto advance_key;
 
 	found_transid = btrfs_header_generation(leaf);
 
+	min_key.objectid = sk->min_objectid;
+	min_key.type = sk->min_type;
+	min_key.offset = sk->min_offset;
+
 	for (int i = slot; i < nritems; i++) {
 		item_off = btrfs_item_ptr_offset(leaf, i);
 		item_len = btrfs_item_size(leaf, i);
 
 		btrfs_item_key_to_cpu(leaf, key, i);
-		if (!key_in_sk(key, sk)) {
+		WARN_ON(btrfs_comp_cpu_keys(&min_key, key) > 0);
+		if (btrfs_comp_cpu_keys(key, &max_key) > 0) {
 			ret = 1;
 			goto out;
 		}
@@ -1574,10 +1560,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
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
2.49.0


