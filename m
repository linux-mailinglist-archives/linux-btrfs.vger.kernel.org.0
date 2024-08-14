Return-Path: <linux-btrfs+bounces-7188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977C7951B16
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE851C21240
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD681B0124;
	Wed, 14 Aug 2024 12:45:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B864688;
	Wed, 14 Aug 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639558; cv=none; b=VwY7IT3HEyuXV4/rB4nsNwncpYu33fSN43yf2o2ygjWBEvRYBS82QqjBVNjf2scpXqHmpIbCmwMwwUQ21wstg8jgtywzq2GbJz28LPPSQmxfqV0mgqjUSdcqOjq5Qa/i4woQWph6IQr1BzKtQdaW4z2ZEenyqRyyXxCLPoW6i8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639558; c=relaxed/simple;
	bh=pqH4k4fCaG9LK8VcwrR/KJzjoalKVpcJd0DemYdHf7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rLiDmz8v36HqVA8Xuypm/N0EZPvoA/UJtgFUP2WK0iwPggCcHYRL9Z1NGO07Q0dqqQ68MiNfIDgXGqBgmpdu0xnjzJiVujqebBL5N5Zcu9xUJNobR5JbkrevCyKVT65W+BgoWxPoQQMnCr70QodTHjZWmoewLTZdTd3R5Q70ZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so769438766b.1;
        Wed, 14 Aug 2024 05:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723639555; x=1724244355;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lusYOxIcDEu5QGSkeE5IS6Mf4KYg8IOOQ5wgGWMSIVE=;
        b=hhiH0KCuAo5hGRh//J17NNOkXhNz/psvQ9qt96gP9Skdz7swiQdhUrD9wpm0dKd5MZ
         PcCFJPsBqd2AmfyvJ2I5V84uDaZy44i7xxUhH4xRq04lmUv5PP0HE/CQ4GhvCbt95RoM
         eN0sAlo6Efd5YTHJVQhPJUGHReq3eEO4e86qvFwYMA8rKuok4DIZWB2dm4KWnBDx0tmo
         LQHSIpL4NOrpWL9tiu3ngGgk1gx3Ok3ZEUI+gTScC52kC0lSb+vfnOlkThnLK1yiLoPy
         VxQ/qHXg52q14o+CY/QU2rvcXBizMJORb3UOhNWZLpHvdkXhNUJqFYhJtuvKsz++LaGJ
         VHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZF+Tv87kHjrp1yQcv/yABu2jgeE48fW5NCSSANk4U1APk9ULE4l5kvQSY+D8SdmLlXvoFaeLW9FVdVbm+lNFJ6rFcGPCXM07NUu7k
X-Gm-Message-State: AOJu0YxY04XbWoK1vpkky77Yy34AOdePNVBTzh4uxP5XJhd0W2+YJJ2r
	HwHJUcgQi+Ee6MKdCHtOJYY7oEaCBmjKzcqySM4MIEhETXyyzicYcGulSA==
X-Google-Smtp-Source: AGHT+IHmzXWDf51c6MJUE14MsPMhIlYjXkvFEREl85lcANkVKj86CIkIlJWBCsLcJSaHW346Svxk6w==
X-Received: by 2002:a17:907:e641:b0:a7a:84ec:8785 with SMTP id a640c23a62f3a-a8366d8c565mr176110666b.40.1723639554376;
        Wed, 14 Aug 2024 05:45:54 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411b536sm167379366b.137.2024.08.14.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:45:53 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 14 Aug 2024 14:45:40 +0200
Subject: [PATCH] btrfs: relax dev_replace rwsem usage on scrub with rst
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-dev_replace_rwsem-new-v1-1-c42120994ce6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPOmvGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0MT3ZTUsvii1IKcxOTU+KLy4tRc3bzUcl1Lw2RDMwNTc0sjEzMloN6
 CotS0zAqwudGxtbUAhdRRI2cAAAA=
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshin <johannes.thumshirn@wdc.com>, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Johannes Thumshirn <jth@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=jth@kernel.org;
 h=from:subject:message-id; bh=ygPOXP0/B1vR/WVMuLa9utU2sac6rEx1jJVi5LH6z7o=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTtWc5w2ZJl5vQHMdrMvj8yXm3M5RcTuzZl2klN382cc
 qwZetcVOkpZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAiAd8Y/llsbvok/E/P7lz8
 1Ifzj84uyWoM8j15Nt5GuMTzn0LGFT1GhvPnjT53y07harWs0knZF2VtkS7rOS9r3Y1e322S0/S
 WMwAA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshin <johannes.thumshirn@wdc.com>

Running fstests btrfs/011 with MKFS_OPTIONS="-O rst" to force the usage of
the RAID stripe-tree, we get the following splat from lockdep:

 BTRFS info (device sdd): dev_replace from /dev/sdd (devid 1) to /dev/sdb started

 ============================================
 WARNING: possible recursive locking detected
 6.11.0-rc3+ #592 Not tainted
 --------------------------------------------
 btrfs/4203 is trying to acquire lock:
 ffff888103f35c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x39f/0x2250

 but task is already holding lock:
 ffff888103f35c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x39f/0x2250

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&fs_info->dev_replace.rwsem);
   lock(&fs_info->dev_replace.rwsem);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 1 lock held by btrfs/4203:
  #0: ffff888103f35c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x39f/0x2250

This fixes a deadlock on RAID stripe-tree where device replace performs a
scrub operation, which in turn calls into btrfs_map_block() to find the
physical location of the block.

Cc: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---


Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 fs/btrfs/volumes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4b9b647a7e29..e5bd2bee912d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6459,6 +6459,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	int dev_replace_is_ongoing = 0;
 	u16 num_alloc_stripes;
 	u64 max_len;
+	bool rst;
 
 	ASSERT(bioc_ret);
 
@@ -6475,6 +6476,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (io_geom.mirror_num > num_copies)
 		return -EINVAL;
 
+	rst = btrfs_need_stripe_tree_update(fs_info, map->type);
+
 	map_offset = logical - map->start;
 	io_geom.raid56_full_stripe_start = (u64)-1;
 	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
@@ -6597,13 +6600,19 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * For all other non-RAID56 profiles, just copy the target
 		 * stripe into the bioc.
 		 */
+		if (rst && dev_replace_is_ongoing)
+			up_read(&dev_replace->rwsem);
 		for (int i = 0; i < io_geom.num_stripes; i++) {
 			ret = set_io_stripe(fs_info, logical, length,
 					    &bioc->stripes[i], map, &io_geom);
+
 			if (ret < 0)
 				break;
 			io_geom.stripe_index++;
 		}
+		if (rst && dev_replace_is_ongoing)
+			down_read(&dev_replace->rwsem);
+
 	}
 
 	if (ret) {

---
base-commit: 4ce21d87ae81a86b488e0d326682883485317dcb
change-id: 20240814-dev_replace_rwsem-new-91c160579246

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


