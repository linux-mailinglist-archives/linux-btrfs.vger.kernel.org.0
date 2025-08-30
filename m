Return-Path: <linux-btrfs+bounces-16538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B4B3CB76
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E5CA001E6
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CFD248F6F;
	Sat, 30 Aug 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0wUXnC6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6021FF38
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Aug 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756564910; cv=none; b=tvdZ3Zd2DNNpzhfUkFTjkLl2Mttrw1rkYQfMZTCOJ0vUaQntXRu/7ivYS7sR4bHm28NU8Q1H7JZA4/IZUqPobvrdqI/ZxBeKG5rkF28unI3QYbWKrMS+WXOqR9w7NpOtghShwM1WFGotYux9o3YFE0DxZV5h4BX1ZhbGO4pXuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756564910; c=relaxed/simple;
	bh=EzGuRb88N6cBwcQVyX9bQ49rLbfMCciNx9qEQrVG22Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2R2M0SIF36H2i+jY2CiLRDT35T7Xuo6t9WWO4W9lJNYbmn0Ib35E9aT3ruvQxQOuVxv09m8Lhpf4GBgKmxSaoeKxHjWIrM0bAMkqujc2xpb1BcLE2XYdzxCEW5fZ+9Sqiu56k70aSEllyLBn0Q0ah4aQo89E9JrZRFcK2fmXuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0wUXnC6; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2489b6b6cbdso4710735ad.1
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Aug 2025 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756564908; x=1757169708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBL6oZ01Hx/JAUrvxZIg6a0UU/9uaLQ7s18BLvqU+D0=;
        b=a0wUXnC6A8WNEDhwhW3Mc0CM6/kEQEELoS/uon8PrIJx8qNq7T7awu/Y8ESbUxAZMb
         8mqUj7BT+aeiztFsJs15ly0BnUZWhw+AzUqYdYIIyOkuUnTTBE/CIEqF9ZpN+ltjmwQg
         UK+RVwho9ZGUqp0zp4GdaFrdsuRRt2SKp5ANIkZIraM4h+xUj1qsPQOqNOBQoVTit7e5
         FUaoWpUN8aJAM/aEd7toaH9bdy72Udhm7ciiG2muFtx+dAprEH8ZLxHMwZlIY4Ig1+iz
         GDMvEWL843ZaSLsts7VUTsCCmy4FciJtEpyRtjSjiatvF5I2HNqfD8aSujiXr1i5/a3A
         Q+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756564908; x=1757169708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBL6oZ01Hx/JAUrvxZIg6a0UU/9uaLQ7s18BLvqU+D0=;
        b=LA8XXiqkVLeQPa+PaL4gCxXLb5n47OniiT1ImUJoHqQ8kgpupG1UfePPJOUf3kph1M
         665caxs8CmCZoJjgTBsY1/hWEkkBAT1VGOgWde5FpL7m0IbMLePwNIlAjqxzxcyO03iP
         qGjxHRJZ5N3MkQmXRrvcVf88YiPHMWLXxucvl6V2h6QlkDH06umTNtcviILf7aHMTZpX
         aBf+aZkGjsqTvlHQMfmzVtkAHRK4pu+qeg+to+Wu04LaDTvanVJbphGdBKU2kNbneRoL
         xETESOXy6FlwsKCsz25/vhbd73qPGB+fH9dt0RHUSApvt9pnljx5Hy2hYM0X7VrWGOrp
         yGig==
X-Gm-Message-State: AOJu0Ywe5+84NbL8r8prFiZhXjLwhS677QNaxtW70mjLEZ2Y9qaerQp9
	ZCaxaSeTJqWLIl0TfTTtoc0zf3GfF1m0yryW6+3wdGUp/EA5tWQ6EllIM8oR2tWODBVJEg==
X-Gm-Gg: ASbGnct0sHO9WIRQ4+JgwxJu/NmQEdIQgjTmCULvw8xM+SvuovjycvZrPGACTfhd3Qo
	U7W477M1XVP0Q/Uo7zUww2fLJhUl41Ven9ckAwBzOc6vrZs1du5T4J6uyO+AXEhSOboOBEB/SqS
	OqX4m3T8MRGXFV4UyXZj2oHVnrdfCxxEDNaVFoeoowpVoyZOW9+QzW0Ns1J9evBTQNFzCby3srU
	/v2CMPLrjBGjGaywCscOcqf+zkNsmsP1mFkDODefas6rPketZ3mtPLN3a/oDKoJSGiaFFEV63de
	/C1DnFGqafP7hLgVxUVyZgcaEyeXwGpUUzvicJs7PLElJqtBrlsQcK2Q8tEIECotIFZwRj37WxO
	y+jpaGcgVJp2PmDjnSdOQWNz3eRqCrhb2C+Y76n3J
X-Google-Smtp-Source: AGHT+IEp6N5JX3dlZP5uobam+sqCJE+jG4xSZvkAvxRWuSHtUb0DkcnB4aXA1dHNkiuiT9ri4aSWOQ==
X-Received: by 2002:a17:902:f545:b0:246:f090:6d91 with SMTP id d9443c01a7336-2491f27ac2fmr41381465ad.11.1756564908148;
        Sat, 30 Aug 2025 07:41:48 -0700 (PDT)
Received: from SaltyKitkat ([116.80.76.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705b9dsm54609355ad.7.2025.08.30.07.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:41:47 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.cz,
	Sun YangKai <sunk67188@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] btrfs: fix kernel test bot warnings
Date: Sat, 30 Aug 2025 22:40:40 +0800
Message-ID: <20250830144100.3606-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 2d6338c69725 ("btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508301747.dZexfo9v-lkp@intel.com/
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/scrub.c | 2 +-
 fs/btrfs/send.c  | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d8c36cbf423d..9159e3a8af17 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -612,7 +612,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	ret = extent_from_logical(fs_info, swarn.logical, path, &found_key,
 				  &flags);
 	if (ret < 0)
-		return ret;
+		return;
 
 	swarn.extent_item_size = found_key.offset;
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6811eeb96490..69cf124674d7 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1771,7 +1771,6 @@ static int gen_unique_name(struct send_ctx *sctx,
 			   u64 ino, u64 gen,
 			   struct fs_path *dest)
 {
-	int ret = 0;
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *di;
 	char tmp[64];
@@ -1806,7 +1805,6 @@ static int gen_unique_name(struct send_ctx *sctx,
 
 		if (!sctx->parent_root) {
 			/* unique */
-			ret = 0;
 			break;
 		}
 
-- 
2.50.1


