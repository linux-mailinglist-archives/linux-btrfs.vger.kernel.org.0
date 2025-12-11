Return-Path: <linux-btrfs+bounces-19644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37348CB4F9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19C693010FE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 07:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D661FECBA;
	Thu, 11 Dec 2025 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ditRkAgZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4A2C158E
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437914; cv=none; b=hSVBvEOz29alCNn2rWLT73g92ADzZEq7jetxcUNYDGL3mStg5MOPnVDmjjTcr3v2yZVlS8xxSyRdOyDG3q5801VjGrOaVoGsayVLmtWAzu07+qpnM0L/q2dklx8PGNDvrR1Npg7xBpcgw3Hh3TI2iETtzOM9S92KmFWcGlJBmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437914; c=relaxed/simple;
	bh=iLxBhAxVOlsBK/CYpuauw2ONLqu11z3gcVq9FxJ2GmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQpjFv63aRgz/Trv5cDjqIhqv0kIm0kTxgYeh4o6IgEzHJPGcuQJf6dGlcPf2lI6ICwHr8Gcy7PmkuRhBLX6Nng1Ym5/8XPv+MH025O7zf7h4DeNC9wUvu+vY0THXR51ng175tIE46IRR4mjNFf2tLvlfgUDE2C0t479k8Fj7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ditRkAgZ; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7ae1c96ece1so16880b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 23:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765437912; x=1766042712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT5iLCG4O8qZM4FPoscL1cvH90ndvsfft78qTEWKl8w=;
        b=ditRkAgZyiFPwlcdtqmwq3ilB/rmLv0lEChJeqsupywuurEVdhKwJfJVAUT481A9jS
         GT4y+AQlcnhpRTMjG28bXak1yqy77BInXW0YGWzKbpYIo5zFVxIV1Lu/dRMBWWN/spGg
         hUqIVzQnpXa/+mrFRjjXPIroXDzR38/dQN5/ZxamikJfjKP0Gb9Fc0UgzljPdYj8U4qj
         YRmCIK7suU4J1XOjr4LV/1SYTdp9gWid01j43sbXhsSpoyL9gsZl0+y4ZXwV7geBY+ne
         5apTXpzxvXUodGi5q2tz85x7vb9+SVWCeYrL2Y6bZZ1z9VZcyFleyMeNd0saeyTOdwDg
         ARZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765437912; x=1766042712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qT5iLCG4O8qZM4FPoscL1cvH90ndvsfft78qTEWKl8w=;
        b=wNlVHQElDtfCgBV/tJlUSGvDoJdKvQX5d45gX5ta3gZdftmnmjEFuE2eDmr1Cq/679
         ClzA+0BXGRvoHXsmsEGjMXtiyNVffxSrOLYZunfOg1i1tf2kz5EvRXsNQILi8G7oz+rN
         htKDmzvc4a09TrzUPesF8A50b0t/r4wGiGhXawDzd+D9/fkqYZJVlRmYXsqxd5ifzCQh
         jconZXpaAENFhvOWB5a+dUbVsoN98VV/Z1LCY7FfHbOhV2XM5gUTlbw4BhKF3nQnP3sZ
         cBEOFYiZexR1vKen36WQdu5V2XA8MeOfFTTGVQs6fQY4pFCxvfsNxpTjuV2kGv5mzLC9
         mLqA==
X-Gm-Message-State: AOJu0Yxd5F3cPdU5st0BcFDEMeKONVESwMkXdyJLRIokFz8DApstkrX8
	CbZhaigqokXySXwtrokxyMu2iZb6st/2UW/1TyLGThCo75M57ybjl1HMVNIobiLf3I8zNw==
X-Gm-Gg: AY/fxX6Kr4lrocrzm+XYC/KRwFfkp1EhdKr2sELclmuqzqFN9V+Zz/TrFSccoWfiqP/
	er2A91X1w53etZ3ARfmDwZQr/NCcfulxF0NgXMh5DpMofB4I9LZHeIhQBBcIYAAbkmDDFswZEjQ
	13msqEPSxttAU01x0+cMBcrevoFCc9ZDEEHXNQyoygbjgYThXc4t06rrxCwCgtM+iW88Tkghg6v
	KLP8xIeAG9UsIapLkvUqsq5y5+GxgpMO5pfIHcFJ7aaW461efSDrRjNB7nV6S4YEz8wSWzqdtpM
	mu32pdiXUbhg7caepzx3/v4Ebda0Qjx0emqlquBKYxFO19GQ4v9G7Jrj9WWLUYcILZIjALV/EvU
	Dfz2jTiBu8WAHmoYwzrzNQ/zdYMNr7IQVBn/UoOrVOLlfsFwoM7O8xfg6e9NgVtFBO/Z0BGbX0s
	IxID3kkdFtagDS1ak/qzfh
X-Google-Smtp-Source: AGHT+IGDxfui9aeSmK3Nq7aAo7jxv8E3PsIVjgX9j5Q0W9N0t9p9PsnXxJow/K6iIknKYnCo3L38aw==
X-Received: by 2002:a05:6a00:94c6:b0:776:19f6:5d3d with SMTP id d2e1a72fcca58-7f22d6dd6f5mr4074914b3a.2.1765437912035;
        Wed, 10 Dec 2025 23:25:12 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4ab4984sm1526520b3a.33.2025.12.10.23.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:25:11 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 2/4] btrfs: don't set return_any @return_any for btrfs_search_slot_for_read in get_last_extent()
Date: Thu, 11 Dec 2025 15:22:17 +0800
Message-ID: <20251211072442.15920-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251211072442.15920-2-sunk67188@gmail.com>
References: <20251211072442.15920-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There must be a previous item at least the inode_item. So setting
@return_any is not necessary.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/send.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2522faa97478..eae596b80ec0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6320,16 +6320,14 @@ static int get_last_extent(struct send_ctx *sctx, u64 offset)
 	key.objectid = sctx->cur_ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = offset;
-	ret = btrfs_search_slot_for_read(root, &key, path, 0, 1);
+	ret = btrfs_search_slot_for_read(root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
-	ret = 0;
+	ASSERT(ret == 0);
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	if (key.objectid != sctx->cur_ino || key.type != BTRFS_EXTENT_DATA_KEY)
-		return ret;
-
-	sctx->cur_inode_last_extent = btrfs_file_extent_end(path);
-	return ret;
+	if (key.objectid == sctx->cur_ino && key.type == BTRFS_EXTENT_DATA_KEY)
+		sctx->cur_inode_last_extent = btrfs_file_extent_end(path);
+	return 0;
 }
 
 static int range_is_hole_in_parent(struct send_ctx *sctx,
-- 
2.51.2


