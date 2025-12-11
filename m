Return-Path: <linux-btrfs+bounces-19643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6FDCB4F9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C8E5300D43B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 07:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E6286D4B;
	Thu, 11 Dec 2025 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLpmCqOS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1854A2C236D
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437911; cv=none; b=r2aR7zwKsg/VKlRRmnyQC7myoXRs5Jknjk+feznPc/EaS1Aoohb0t0EmXcOT417zeLYw8kEoMQCi3iaAhV0/UiRxdcbKVT4oISQvnJpf0C0rgyLmL8kvVHF/Mdrylz+g76N8XSdvOXltqEHSbbKsvTB5Za56wUHa2UkdiXJWhcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437911; c=relaxed/simple;
	bh=yB3RyEj/oqUKbBmIeSSavLlNVpLyvwmVpRrygxIXVNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtYLNwcAj3EoceivCLgE+sYUY2OCRtW7B60QF6uZkroguX87YjgaT93GuXje1OnwH3dgJh/MV273pwFilChwg3zGWsMvrWDDzbGeed98pDopKzq1wQIgPf01sayu2HLELdIkVgwfGux3hMx2vTE5uKiz9VuEVk83xkGx7VakKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLpmCqOS; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-349bb0a901fso127715a91.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 23:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765437909; x=1766042709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhqf5jwofzMsHmKf1DdMDZm52UhXy3shxr5zhKg0Y5g=;
        b=jLpmCqOSb5mlfUtRvUcU74fTOfb8/IHRKcItr97IyKe49KYUUbJEFpJ20YdawX3ryO
         SqUvH6dvJTFBkmjIA3qRpOTHlCNsHJA08W+ed/j1NUKiucAD899UJfVF0V5hzQGqe1cN
         NJUmv6jBMRwFt2Ujnr6RnV+8r9E97b3X9iHHrZljl9wc+48ABi1AMub5ee1al+C5hlHT
         cYz4w0gQQdhZsSS7iSDm/AvoJt+zYclV3pL7sCvKxKjzc8L2/7tC3ZEg58o7rnjVlh7H
         SwC25aP+0HF8lBlzvWz1oxreOQvfzmbSXhUhl5wZIYt5orxFwfefF1dmz9E8VTUqKgJq
         Emdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765437909; x=1766042709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhqf5jwofzMsHmKf1DdMDZm52UhXy3shxr5zhKg0Y5g=;
        b=LMIVoktEMWp32QmRII8b6pBRK2w/ZDr5hGDzZYZgM2/uwYP3j0xBbhIsjVBtsioJA1
         Dn1vkSaqYEZpSLpGyjOIDIu5PMI3bNi3OJHE7Y63CAdTZYisxwPpVHub/vEqR4FT8kqy
         7nmj5VBJINNCVC4lMyzPU56dJ8V0OPMwv0N1l5kdr3RvwlN6eeVBo2n5tSn6L8OALfq/
         b9ztruo5Waxo+oZ7zR54B3Iyw4akp7o5MqVCFk/50+ngib3058MnRDEl06KSJppQsE3v
         vBISI7nHNTNuwVmQCuyyfBf81PpphjoCBE94iiUKmgInmmhjAhriU4WfJTt+JQZo6HDw
         IwIg==
X-Gm-Message-State: AOJu0Yx0z7tS+JcYYXMmqydSn1ihp5O32aOWC9zHp7YZOsuGzJQ1w4QE
	BduVOsdoDrY9led01W2frp0TW8P7ldw9QgGqG8sV5zCTGfzOUVW8xaPb7ibLTJqu2MYg5w==
X-Gm-Gg: AY/fxX5WelWj6C57Py7lMxyqOshk6v8wecyrTcZCtszWoJAOBC+NTur0WlzA70k5j8j
	QwNTSiXaLnXAcLgfpVi4/dV5H0VKMF2iwbkP5ZXXlI4DR5231eaDQ9SmulAAvdaHpCVmB95k1pe
	scHZyB0OjFG9bfS2KenBU2CBfvmgG5mfg+0UqUcqPDDMnNL/SLGFQ+XjmSlRJZg4h8QYFQhOrW9
	c+MIe5J/K7hEoB/3LeBTyGBPmzNooMswveHQpevAoRyPjdzpQpkBxso3OCGcvpPvFYaXypu3vNO
	CMV9E/IFm6zC/4w6YbrH4Zrc406tqXM2mQk2Q/NOnXKNZg1PFw6ufdrsb7FRBaXYKbAQrn9iwU9
	gRDXJnY2WfC2UhgdPS4grM+bRuU4lB2DMPzDHnMFFbb/IGfUHrp95RrZrIQNoA/Kl3UwNnYIDQ7
	P6dnJRX+UnF2mJp/VcA/2K
X-Google-Smtp-Source: AGHT+IHygRVgWIV/BC5dGvUBsrxwTnLGBbmDDr1285J5t1+f5IAKBG2XpDPIOaVjojqjpd84PaT94w==
X-Received: by 2002:a05:6a20:7f91:b0:342:d1c5:491 with SMTP id adf61e73a8af0-36835f7cb97mr1206231637.0.1765437909370;
        Wed, 10 Dec 2025 23:25:09 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4ab4984sm1526520b3a.33.2025.12.10.23.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:25:09 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 1/4] btrfs: don't set @return_any for btrfs_search_slot_for_read in btrfs_read_qgroup_config
Date: Thu, 11 Dec 2025 15:22:16 +0800
Message-ID: <20251211072442.15920-3-sunk67188@gmail.com>
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

The call to `btrfs_search_slot_for_read` in `btrfs_read_qgroup_config` is
intended to find the very first item in the quota root tree to initiate
iteration.

The search key is set to all zeros: (0, 0, 0).

The current call uses `return_any=1`:
`btrfs_search_slot_for_read(..., find_higher=1, return_any=1)`

With `find_higher=1`, the function searches for an item greater than
(0, 0, 0). The `return_any=1` flag provides a fallback: if no higher item
is found, it attempts to return the next lower item instead.

Since the search key (0, 0, 0) represents the absolute floor of the btrfs
key space (u64 objectid), there can be no valid key lower than it. The
`return_any` fallback logic is therefore pointless and misleading in
this context.

Change `return_any` from `1` to `0` to correctly express the intention:
find the first item strictly higher than (0, 0, 0), and if no such item
exists, simply return 'not found' (1) without attempting an unnecessary
and impossible search for a lower key.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/qgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9e2b53e90dcb..d780980e6790 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -415,7 +415,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	key.objectid = 0;
 	key.type = 0;
 	key.offset = 0;
-	ret = btrfs_search_slot_for_read(quota_root, &key, path, 1, 1);
+	ret = btrfs_search_slot_for_read(quota_root, &key, path, 1, 0);
 	if (ret)
 		goto out;
 
-- 
2.51.2


