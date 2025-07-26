Return-Path: <linux-btrfs+bounces-15686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BB1B12AD0
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 15:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2329B189A4DB
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141F287245;
	Sat, 26 Jul 2025 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5U4DDBI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6B2286D78
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537958; cv=none; b=rS2sXVwooTTiZe9nsV9xoZf4VYe0wmcKqxYQ7+hsDOAuyfouf+Y6H9ziXpE4lv+2ww+PgmEEv4nmAX3jJc+3FV5ThjIPZyCQo+8qD12gjmJsr5eGd0AYdC7oFkUIOj+2a0gLIqirB1gNQLgkAssI47jhnhoy7/osxqKwPQpF5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537958; c=relaxed/simple;
	bh=JvCWchEdSN3/jeOPMOECVye1GhALVRQqR3V0OWoviOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmd9wBcLBBYmMBisoqjQ3/ojqX3msvgn3ZwK63zHvBMM51A4pWTskR9TlJCsnRtstk4/50kEdHGuVml28Z549d9TdASS9WvPydQJkJtNjLRIM9n8ARbTGC2nlqyHNqDkTiassgNqHwjIVDedkO9OYS2xqLS/yVLUhVvVXny1sTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5U4DDBI; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so600995a91.1
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 06:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537955; x=1754142755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWEnDiz6K9Hc9T8THpoGUK9VDgX2elNVT27P3ovnQpA=;
        b=Y5U4DDBICBk06BUcqgxbmdjphXBvl0aKQT3FC2RGuABxNlfRgIsdc3NjDjHravnuJb
         SfOQ7VgJChXCCVWxtcQEo/frdoU3cbVhvNvGSDJMoRKX4spoltENHsODhzzzJ5hTAC37
         /+uzsGHfwthW90P5DjaBkNh7whV38Sja86G8+lq6bdnSZ/YtpYlDMhU7hjIIxj4pU0tL
         fCL5rLV3BoARWFX9bFTzMwsduRLXiBNajBwWwOjXZoKchcYDt/NVoWns+wbM3P6Vx2za
         +ZDsw/BgJ/X0ywiO0Lhpe++v+zGMVtEVqzOdf3PkfNASXKgtMQ+b/HvGUunHWteLbHKz
         DIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537955; x=1754142755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWEnDiz6K9Hc9T8THpoGUK9VDgX2elNVT27P3ovnQpA=;
        b=ZbRwA/DLY74GXx25Kf+CPUeIiFLDLVux0ecmi5angP1JC4gKW21nURTatK6iEbOSXR
         AwSHqlDMa0AbOiNWDPvsmWn4lPdlTYf7pLhVQtUlwuLZD1WWXOtDLR19wqDMZRedU0pi
         GFW/ub+P8ZtRgO3hPj12TX1b0aTBlDqWd/apr4YFFVSdfHHR0rbkg989ASDldovwP5/1
         C1VHSzsbEG/5jVgFLMXTFwell5lOmH/qmczvzCdY319ibMEX1dCb4NjrygjrgbSURXjs
         syWE3HchKcdi1jmHvSgpaZSdqC5E2LNqZfx7ZWZbH/EEZOG2OTTsY5FfCvrBtA6D8hBY
         byew==
X-Gm-Message-State: AOJu0YxYBKV9PJqX6NYzscIQSeqk5o38ts3cH4DsS8BJwIpRNO9crPri
	Qb3c2FSkPEPrWVrktPTscO1ByeURx3mtOk1tFnzmUfxdS87VwIQpjmKl
X-Gm-Gg: ASbGnctUoIPP0w5OFzJL9VHtCSqNmFIQ3xHZPumaIRF4xvlcFwCkJ5k8wtqiIk+fYj/
	7GN7AZ66ijoLrwmaAbQbaWNLC4MWj1I3mGFMOh4v4DwtI93GJj/GCo2oBy1JFul/qKwz0ipCdvi
	zuw8d+V94thZv0TyZ0v7lxf2PHp1Wb/IGMeZ7jbWGDm3qDaQ/92zy1ZttDb+/xhB0dErO5XWmKE
	zpHyev24y9QVDLH0/tB/4grvXg6IbFrKXWxpVQLwpgFziAf5UAto82ajOnsSYF+F4UB3WuKwvsS
	0X9dkMTZedG4JIw+CJya9Bv+jfHPUwC+JMlngl1D1HsSCaKdo/xDu3h5zksHdEDH82JdlFpGJkm
	YXL+P86ZCGfkyDSV9ukrcq+saKpttmpsjsw==
X-Google-Smtp-Source: AGHT+IEzf9Be0s5iO16M8du+4ICMh78p8n0aep8DIjBy3GfyTFUzK4TlqSPEMpQSTu4sK5wUhOpxZQ==
X-Received: by 2002:a17:90a:2c86:b0:31e:9cdc:72b0 with SMTP id 98e67ed59e1d1-31e9cdc73e2mr655050a91.3.1753537955283;
        Sat, 26 Jul 2025 06:52:35 -0700 (PDT)
Received: from SaltyKitkat ([2a0c:9a40:9210:2:be24:11ff:fee6:cbe9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83580856sm1874234a91.38.2025.07.26.06.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:52:35 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: sunk67188@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: replace key_in_sk() with a simple btrfs_key compare
Date: Sat, 26 Jul 2025 21:51:41 +0800
Message-ID: <20250726135214.16000-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250726135214.16000-1-sunk67188@gmail.com>
References: <20250612043311.22955-1-sunk67188@gmail.com>
 <20250726135214.16000-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- The min-key guard is inherent to btrfs_search_forward().
- The max-check logic is equivalent to the original.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ioctl.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 27c294e9d68d..504c29af2f85 100644
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
+		ASSERT(btrfs_comp_cpu_keys(&min_key, key) <= 0);
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
2.50.0


