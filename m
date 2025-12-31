Return-Path: <linux-btrfs+bounces-20051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71286CEBD8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 12:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B6893038F40
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884C2882C5;
	Wed, 31 Dec 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY2H5XA/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5EB2820DB
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767179807; cv=none; b=Gmzq2vpv51+8Eg7r6sFh9ddimXeigeSNC7s1alMoj0Gqc8JR3vVC5SvGVcEFrGJhiHGLAnLATmTnQjrWlVKFYjmqtWafo5aLfhHWTiBeiRQseVk6baTPwADqibI1NnCO50QVWgo9ONMT4hoVSJs5Cur4iZXDgK3sOuiTF1Yyh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767179807; c=relaxed/simple;
	bh=imZa0HeUWwHEHqBcw5JglFpQZFjkYnL9sIr/8QOXWS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwzVKeZbpa02EYfHlSOC9JLEnrCw/1076/T6YLqHlzCfSphLEHRNGtFoubtnzfgV3DqGQVprpmJ2lYnfyeA5phZErZXFx19Mc6Lf09041MvLnRNxLn8OdMCHjkixYmEhLlxo24fB1LKgpjxyS8J8K26lh/2KQNgLnzQ2z56L0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY2H5XA/; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a08c65fceeso21652395ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 03:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767179805; x=1767784605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWYdUp6yz/n4XcfrsPe/c37jj0G3r6+H8ur45DAUzqg=;
        b=TY2H5XA/kG3I34XD/y5JXE4g73ucvuC4XWPGar5tF+/FUvIGKuWBrCitsCLuV1vePl
         j6X3N+ds91/kkZUDIJIb+rE5jrPr8EWahjjL86PK1PA5ag3Ih4bsT2ySOwJdw4taBWAg
         n6LkqiS2QqTVPHvP8AS+MOqUVZwVUWC+fkw2uJIzwnWEVDGiqSNY823ms7YgChPn7V2Q
         ALwvcWPhehPPh1+IDd1m+gqfI9AZudekYNmCygqYQUF3ABcwEHNcj7fznV/3w3S1Rs2f
         57yPImFgMxSJDkLKB/8biUotBnSDVJyBaNAy+cVGsPdp+BQbZUBCMmhelGuJJmBRfqTR
         F7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767179805; x=1767784605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RWYdUp6yz/n4XcfrsPe/c37jj0G3r6+H8ur45DAUzqg=;
        b=GcyL2g49fps7WewJAHGy8h/BMyXyVjmvL8aO5snb1H7U15EV03tLM26HIP4r4i3pvy
         OLLZqhQbOEAfFudOnBzakb3x1lCvW0OSgWCwQZ4DS8kp9LAtzUuK1Tx8J160xU5TVOuN
         KYNXKj9Wp+6/9M1nuEL5NfjmaaiZVVRgX2/Rf7jTBecXoR7mOdr254x5Ek4x4vEN6Pi1
         AlF5St4rt79dwieAjFJVVuSbjL6hgW44FLyS2viZDghrtuR31Hj1AFipLMEgrA/4NpkA
         2EKTt4ajYL6EiphDwtf9QKQsyrGMujjXWMzPQRGahr54ryhdCq2HKUQ6uNvFkul0b/IJ
         BK5w==
X-Gm-Message-State: AOJu0YzwtVCTOHE3Czx69TgJ0cH1WkDaiO0JoVDX0OodOKdmjhqXvZRA
	6hwRs+pQ4OvzIK1VOcsaWD/ghWZmXTgfBQmiSUacU7uJFKoa2l3p2LmojsyC76UOv0sclUdc
X-Gm-Gg: AY/fxX4G2S0mEcWERUhGWkn3G9q36m8pdOSfAUAlcmG/Pzu1JZoKzAEK3h+iPywJEjC
	rctiZAXsI8hn8DAT/daifRvCH8uzxQHeYK2Rrxtu+z1pmf+cGuLyyQuWt3evogkC/v4pPFaV4ld
	VgAEd1/M07Rr7PF5xYE4qbF2zTjcl10CxYY4X+OdSKZkMVvJJO3iW/U5pLODTvTr6mcCy1laISC
	DMTB+ScCKzjT8wIbKunfbc+CM4+PJ/DbJ7ko5dGOJlgdglPPRcRMfzSo90slxnMM3Ml2B+d8IJM
	9pQh3Lqu9hU+k015ReVS3Towz9wV5yVgXYhzE8UAnIjP4stEXX42H6k7wDr6kQgKtkDrFZv5b5e
	AenODVxoClGFlAAK9zhcQGlytn1WQinQzgUuOdnrbcA/NvxCqG1RhM9gkGw8ezKD51Sq8xsGHlo
	WssRJf54f8YPi7XkXmwWkEliU=
X-Google-Smtp-Source: AGHT+IHvrvRGBXlils5CSG7v5T2recBZMn49kxhEpAAGFAOdWwhXC82CAMwdYrsWe6nfN5lAWFo4hw==
X-Received: by 2002:a17:902:d2ce:b0:2a0:de66:49f1 with SMTP id d9443c01a7336-2a2f21fc6b8mr253116355ad.1.1767179805195;
        Wed, 31 Dec 2025 03:16:45 -0800 (PST)
Received: from SaltyKitkat ([175.145.176.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm321394385ad.5.2025.12.31.03.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:16:44 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 3/7] btrfs: use proper types for btrfs_block_group fields
Date: Wed, 31 Dec 2025 18:39:36 +0800
Message-ID: <20251231111623.30136-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231111623.30136-1-sunk67188@gmail.com>
References: <20251231111623.30136-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert disk_cache_state and cached fields in struct btrfs_block_group
from int to their respective enum types (enum btrfs_disk_cache_state
and enum btrfs_caching_type). Also change btrfs_block_group_done() to
return bool instead of int since it returns a boolean comparison.

No functional changes intended.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 88c2e3a0a5a0..bbd9371e33fd 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -162,10 +162,10 @@ struct btrfs_block_group {
 
 	unsigned int ro;
 
-	int disk_cache_state;
+	enum btrfs_disk_cache_state disk_cache_state;
 
 	/* Cache tracking stuff */
-	int cached;
+	enum btrfs_caching_type cached;
 	struct btrfs_caching_control *caching_ctl;
 
 	struct btrfs_space_info *space_info;
@@ -383,7 +383,7 @@ static inline u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
 	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 }
 
-static inline int btrfs_block_group_done(const struct btrfs_block_group *cache)
+static inline bool btrfs_block_group_done(const struct btrfs_block_group *cache)
 {
 	smp_mb();
 	return cache->cached == BTRFS_CACHE_FINISHED ||
-- 
2.51.2


