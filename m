Return-Path: <linux-btrfs+bounces-10400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FF59F2B98
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 09:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1921882A7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B6F2010EB;
	Mon, 16 Dec 2024 08:10:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFB1FFC61;
	Mon, 16 Dec 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336654; cv=none; b=M2x9jj3OkFsl8uc//PR9NGhBQF2e5vBLderuTLV5wEbcOBR5lkHIJRRh1+OF+7jmDnu9zkIZp5dp/7jwLnRvzgqVNdxVoaw2kF6tOpU3tZVb1F61jvn14m/yHOQ6P5UpV9d+L1ig6EPH0fS0b1roq9Bo2JzohCmR8xUwATQrehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336654; c=relaxed/simple;
	bh=4c603uTNAwr5v/6+xrBGBpFPfCttRch2pLDlAFH0K80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0zDNnwTZIo7IRQ0xsH6EySIM+UQ23O0QfEmMInYQVOZzCqmf4JDkN1/C/Ac5VCmvEUnaSAO3v5lXZBur3lpqRFa75jtw/pZ9VXMywTHzSTCNNhgAznehcSpwwFhTefkx3OMG9VKGTmNsmRWUXKuw4/Nuxd+FxeaZ/MZuqaCpeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso5703577a12.2;
        Mon, 16 Dec 2024 00:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734336651; x=1734941451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHc4YCLZspdqL2zoQEWiAY4cxdZYclIx9AhPDOUD8/4=;
        b=clWZ/o9VQYRhEtKlpV7DOzBYzke3JJ/Kplbii880/sRyqOyANBEQ6rtPy6fRfFaPrX
         v/6vtgi5MO8HdmHjIArWOBAn62Q1M0sR7K/HfGByfNYlo/rfaJaf2ME2PcDD4CPQ2OSw
         jZklzMnw043BxpZrT6iQQiWE+UD8nS73UvEB0x3/9dcs+dFkSOA4h1Q9/OryzWLt2P2+
         oFH7jO5vmQWsnHS9+xQIloZrO0xwREdxn+Z5bdqcGdxNw2M5U2UkVCkBwG3G7Hi8Zovg
         bQR0UUXEldiI+mOI++bRkSsVTZoFFuzsZwFOQRu8muVXbETbLcbwkZ+hp36aAM1L2jfc
         xdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7U3BG2lmSDfnbHUaZMgfweE3xs4d22l+dLYAA/WisnV6oqpMm92Ezw9TVCap+rP5aQ5Cv6MsWDDPamUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY1DDwKtTkQG9cxDv5BPEqBmOi0lcR4mUC+pzTiJmh5O1RomkL
	4YOATYn+UezRkBlOt19qtNbMxLnge8mhoRevzhnoHNkLPI9oFPRP
X-Gm-Gg: ASbGncuMAq9a50UHMWPhwo8JKkS2UBVPsyxm9zQr/n7bo2N71VVYPcLsq2/vH7I1OaT
	T1AD8gMFsqZamajYFtMo4RcKT7izudmyRU+O8ngjQga+09Q7g8EF01m4awEplByF2YVhMGQW4UD
	CoF78EaCE+ah4TPg0J+MrMfYvGXGQlR+LpTBJdYzxVcAYQGJjlKL4vWABaVhpund3FW1QiDQniL
	QfecINEJIbwUi/25KpoJjUuoDBdPt+1DD3doXlyondx5zOQbCYUzBJV1zc5LUjBN2NnT5p40kFa
	DVnSYdvss0e/qemTof58dGFDvlo33lLj0XdO
X-Google-Smtp-Source: AGHT+IH9ldVas3acJmpAU7kzyJpGULMIkUBNF2yWJBn3mtkPRFOAgJf8fV2cPREvin017sdfkF+H4A==
X-Received: by 2002:a17:906:31d4:b0:aa6:9624:78f7 with SMTP id a640c23a62f3a-aab77909c84mr1108965866b.17.1734336650580;
        Mon, 16 Dec 2024 00:10:50 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635a000sm299013566b.113.2024.12.16.00.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:10:50 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 16 Dec 2024 09:10:41 +0100
Subject: [PATCH v2 3/3] btrfs: pass btrfs_io_geometry to
 is_single_device_io
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-3-42b6d0274da7@kernel.org>
References: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-0-42b6d0274da7@kernel.org>
In-Reply-To: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-0-42b6d0274da7@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thjumshirn@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892; i=jth@kernel.org;
 h=from:subject:message-id; bh=hofpE60IAMuznsG9YF0VqcKYrjrHH5YeItqCqOIioPc=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTHP2jzmHNuTnujks6x0AuKuYuczAUKT7+//GXjzuf/D
 VbVnF71t6OUhUGMi0FWTJHleKjtfgnTI+xTDr02g5nDygQyhIGLUwAmYtHN8N/nqcW2V3IBx+Kz
 egIePV71I3/BMSWu9BOyyrXdwWfiXnIyMkw6u+qWxuYpW/3XKKfHrW2VTPIuyTVLfpSancv349y
 913wA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now that we have the stripe tree decision saved in struct
btrfs_io_geometry we can pass it into is_single_device_io() and get rid of
another call to btrfs_need_raid_stripe_tree_update().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 088ba0499e184c93a402a3f92167cccfa33eec58..fcd80ba9dd4286305ebeea58adc5950a532cc06c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6362,7 +6362,7 @@ static bool is_single_device_io(struct btrfs_fs_info *fs_info,
 				const struct btrfs_io_stripe *smap,
 				const struct btrfs_chunk_map *map,
 				int num_alloc_stripes,
-				enum btrfs_map_op op, int mirror_num)
+				struct btrfs_io_geometry *io_geom)
 {
 	if (!smap)
 		return false;
@@ -6370,10 +6370,10 @@ static bool is_single_device_io(struct btrfs_fs_info *fs_info,
 	if (num_alloc_stripes != 1)
 		return false;
 
-	if (btrfs_need_stripe_tree_update(fs_info, map->type) && op != BTRFS_MAP_READ)
+	if (io_geom->use_rst && io_geom->op != BTRFS_MAP_READ)
 		return false;
 
-	if ((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)
+	if ((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && io_geom->mirror_num > 1)
 		return false;
 
 	return true;
@@ -6648,8 +6648,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * physical block information on the stack instead of allocating an
 	 * I/O context structure.
 	 */
-	if (is_single_device_io(fs_info, smap, map, num_alloc_stripes, op,
-				io_geom.mirror_num)) {
+	if (is_single_device_io(fs_info, smap, map, num_alloc_stripes, &io_geom)) {
 		ret = set_io_stripe(fs_info, logical, length, smap, map, &io_geom);
 		if (mirror_num_ret)
 			*mirror_num_ret = io_geom.mirror_num;

-- 
2.43.0


