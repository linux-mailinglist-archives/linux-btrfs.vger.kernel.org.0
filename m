Return-Path: <linux-btrfs+bounces-6827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C851B93F4BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB53B1C21BCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C481474A3;
	Mon, 29 Jul 2024 12:00:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47224146580;
	Mon, 29 Jul 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254414; cv=none; b=ZyTdF06Zc95wFLrmKS7T6MkhbX+Ra7bdp5B7hMbZm21Br+c3a64hPKsapIJzpnrYQxJvIvBtgQOowJvYRSutrNZvU7sYd4G9d2lbiYAxXdQB7f75p2SwC93iGeUMHaBhyDel1P0GbXvcspCIrpn09I2J0ZBustTUgdlLjmdL+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254414; c=relaxed/simple;
	bh=7z9b6DSEEd3AS7TAf2EEFdpb8JBFUBPJjjKwMcTk1bM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STdMptkS3T0UisBC6r4hxcWB6V9VDkOV/QWC5806idXfIYFEzm+Dn+ArsQdykSjFgldhF4HashMmfu/8CVkrJZB5qSQ4YsnafrwvPlqMap4VshjF/V2NAXnvEsjzo1goNVH0MR1SgzukC5S0wADWCSOdd4T4MRqqU21J3fIOEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7d26c2297eso395246066b.2;
        Mon, 29 Jul 2024 05:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254411; x=1722859211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGN/kk6WdhdWkkFKRFXP8WuazD2BEVj2C7KF2uk7+UY=;
        b=ntObzTs08jgwsUBZVCenDWr4isQ8BlY5pQY3tpWMtfBSi0xvgXDZR/c28FQ13i5Pch
         c552XhhRwP7YPvuQyeWkSeHRdm+nLiC71Bf2/qNr861zkWhAYrPtZAcF0cJQ98eNVKrb
         UUeqKuMBGKwKkxrxA96/wYlCg7m58OgtkiOiNZoJbxnoc4nejo+vCcm2ZYbXOf2U8tnT
         bpo8AbdthsXQbYwl9q1PfJNwb11rQIqitU24J2m/gtd4vhu6iy0AsiaaLfJadN2vTXwG
         ngfbJrnj43edEX6CFfJy39LgiEmbaLDjGnmByfQ8t3S6ppYsEv5WcZtLfySKsYWg7ipW
         f3Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVKLWFzWFnzl08m7jMdlJw2vPYhgP9BT/E/Zg1O736RN8rtCb4yv/qUhv6Az0JM5liGLReE+FFvE0Mkz0MomKGJ24IL4qxBQh1BDbuI
X-Gm-Message-State: AOJu0YybxjY+1foctwvEsszGrvQ/VAXc9iH41cHz5rPKAVRctbELWk5X
	ZUqLJUxp+2kj1Dg8UFwePOMLv80arL5m6M1UrxWPhMyOu6DHyd94GCT6QQ==
X-Google-Smtp-Source: AGHT+IE9AxVBSVkSTYFKVJohns5FWVZFoGL3k8kvpXxxgN2d7QBQJpUmdX1VNeyPpLHVIp01Q7opGA==
X-Received: by 2002:a17:907:2da0:b0:a7a:acae:340c with SMTP id a640c23a62f3a-a7d3ffadb71mr558795266b.13.1722254411418;
        Mon, 29 Jul 2024 05:00:11 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2311asm508136266b.18.2024.07.29.05.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:00:11 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 29 Jul 2024 14:00:02 +0200
Subject: [PATCH 1/4] btrfs: don't dump stripe-tree on lookup error
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-debug-v1-1-f0b3d78d9438@kernel.org>
References: <20240729-debug-v1-0-f0b3d78d9438@kernel.org>
In-Reply-To: <20240729-debug-v1-0-f0b3d78d9438@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=jth@kernel.org;
 h=from:subject:message-id; bh=hwc/5qBk/m03Fn+onMcecnGBzxZqVF2km5Mrm9HY6u4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQtb/G41SzC1s9XKcVdo/yf2Vo95tS85j0nZEp6ZaQbj
 npP17jVUcrCIMbFICumyHI81Ha/hOkR9imHXpvBzGFlAhnCwMUpABP5dp2RYd2UXTNSd+0/9do5
 rvhISKJkFt+3umtu7qnpGSKsrkYtagz/6/f90la4IJ30v1Wed1ayoXO9ZaQew1Y2tnKLyYf71gU
 xAAA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This just creates unnecessary noise and doesn't provide any insights into
debugging RAID stripe-tree related issues.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 684d4744f02d..97430918e923 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -284,8 +284,6 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	if (ret > 0)
 		ret = -ENOENT;
 	if (ret && ret != -EIO && !stripe->is_scrub) {
-		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
-			btrfs_print_tree(leaf, 1);
 		btrfs_err(fs_info,
 		"cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
 			  logical, logical + *length, stripe->dev->devid,

-- 
2.43.0


