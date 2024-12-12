Return-Path: <linux-btrfs+bounces-10293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB09EE0A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC22281F9F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982420B802;
	Thu, 12 Dec 2024 07:55:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06620B21F
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990159; cv=none; b=ZUpODmZlGFlSMEceRPT5RKEf9guhWCN+pliCRojH1RUNjLLiSn6bf1WRkJZ5ON6VmWvmvrTkHxOZWR83jRmb++fZjH4o4hl/fZb/dAdHiLR8TYvas28XdXAC1mMwpo5zxHsoGC6WqjN1k3CMSfftMOHvXtgHOqd6A8dpeVKQIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990159; c=relaxed/simple;
	bh=Y0HwGaYxizeZk8pd8C2hoMrkuworcNKQt7v60O8OuCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azifo/hYb0j0/9R+GrMxmYQUNH19YWBUNuHo2JXH1iCzHaCg4PXQRfKFln942lA/GMxowFbyqvtj2EooQFnDYIXeCCAHFnDE0TBM4ErqXMpciBw6ZuIQb09NUsyIumyFCpQIkIVVjeAfWs+aszdrBRYP3fFZHrMtuEz0wnR2Wsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso500602a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990156; x=1734594956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEfrWvEsqPw0eIeXgAQG+diIzmvxZsaH8mP9t5XgUCY=;
        b=vM/WaWu2ChVuXX/kY7G1EsRjMs3Pr15oq9k2jUuC0QBlOKsKPfS7VCVhE4cB+EIMBP
         s2CktHlgOu/rkf3IErqAVOu2jJVsy5IUBdE5f6acxbsOTvWJ8jr3h6ByKhWq7ER+nYWd
         AcnV4sdSi6LquEBtWwODdZuqHyzO99sna0AEygghy409o44ImsQY82kXrd3uKskSIZx0
         hsYgqRAmxIBb7qCyW5kbXfjAc0VUZ6WQJNUtDSq9maokJjhq/RZotnr45/p0fec+JxKF
         zAAK2j2EydY0/cwltXicS+XuawzEPwZv3EaJqiJD3l27JGccRTgw1uaNtDDvmuSOt+w0
         Xl0w==
X-Gm-Message-State: AOJu0YzDMu9St4q0em6GQ3s9YnVLkSRs97CGWmsBBI2n5yFW6Kkf+ElA
	ztMbllXYxn3qoqqrw7SGD5/54nEdNNm5BFpgQ6WxqgiCywojpq6zkoH0rowo
X-Gm-Gg: ASbGncsMptQzJOa68832Tw2aSI8vih3nG9C/c5OVIfZuy7u/Vy6V9+Qh7M/tthxfR21
	rlJL1il6NW94+1YYaNce6Rlv+oJIJphPTPxpOmPKy3UD+s9OK80SYrToEtXL9WfmQbPc/wpRDSn
	endsz7tvnjlt828w17ykGCTMSO+hLvPWl8JTnjiQ79344JyCIsiu7BCrEDyUkoNOM5zae8pJr2k
	8TAjgPK+UMlNav+n2ZLk8l0A99gTbMTCCbV/S6QQP1sY6uRTjpD/TLp1hqcBtblnrQGBcg53sqV
	k5eeW6YHrJjIdmfcG5xnD/qDjjUSUt6NdY/rX/g=
X-Google-Smtp-Source: AGHT+IGXJxltW3v3xVSx2U2QPKanuqpnzCw4z/K14Fed5mmUGYN02Ft/Ch03zCluHGhykWXCbvfFHw==
X-Received: by 2002:a17:907:7617:b0:aa6:8211:ff85 with SMTP id a640c23a62f3a-aa6b1225c4fmr456706066b.35.1733990155902;
        Wed, 11 Dec 2024 23:55:55 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:55:55 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/14] btrfs: don't try to delete RAID stripe-extents if we don't need to
Date: Thu, 12 Dec 2024 08:55:20 +0100
Message-ID: <fc5d9d03586f57ffa99ac9e2f10389e2d61a29a7.1733989299.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733989299.git.jth@kernel.org>
References: <cover.1733989299.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't try to delete RAID stripe-extents if we don't need to.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c             | 13 ++++++++++++-
 fs/btrfs/tests/raid-stripe-tree-tests.c |  3 ++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 9ffc79f250fb..2c4ee5a9449a 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -59,9 +59,20 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	int slot;
 	int ret;
 
-	if (!stripe_root)
+	if (!btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE) || !stripe_root)
 		return 0;
 
+	if (!btrfs_is_testing(fs_info)) {
+		struct btrfs_chunk_map *map;
+		bool use_rst;
+
+		map = btrfs_find_chunk_map(fs_info, start, length);
+		use_rst = btrfs_need_stripe_tree_update(fs_info, map->type);
+		btrfs_free_chunk_map(map);
+		if (!use_rst)
+			return 0;
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 30f17eb7b6a8..f060c04c7f76 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -478,8 +478,9 @@ static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
 		ret = PTR_ERR(root);
 		goto out;
 	}
-	btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
+	btrfs_set_super_incompat_flags(root->fs_info->super_copy,
 					BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE);
+	btrfs_set_fs_incompat(root->fs_info, RAID_STRIPE_TREE);
 	root->root_key.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
 	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root->root_key.offset = 0;
-- 
2.43.0


