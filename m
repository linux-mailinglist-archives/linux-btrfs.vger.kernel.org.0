Return-Path: <linux-btrfs+bounces-10763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A112A03FB1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D90165EE5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D7B1F0E47;
	Tue,  7 Jan 2025 12:47:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B81E3DC4;
	Tue,  7 Jan 2025 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254073; cv=none; b=hC8euNPSBbIvwbT4AjTJx3cac5CSfoYZu/L5GsC1bKiys+ONLnBiCsQYxUcXW1HGjPmj2wRRjFC3WSVfs2uKuTWk36Ay4uhiVD08q+jFzuftPChLouMLjxk/Mkm/38FRF38lp7IM2Y8BspXmMEIwaPslEj6rkAZO+cwBLTXabeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254073; c=relaxed/simple;
	bh=4dccEVdYglD0Dmgm54SCN7FdILwAHo5bmKqFGoZac7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MCGYqbT8ZHPjjj/ir4gJXDV16cq9fzpcP3dXX9ZlnMYXODopFyn64iOjUbAH1xgwPbw8CICIJofDUpuQeVag58aHwRwoc7HOptkT61wmvbMsgqGkVMbZl5k+ywEBDcFHMDqQ+W2kYeVXAUpEp5pRfqAy2pDWNps/Ly3jTCYiF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso106851065e9.0;
        Tue, 07 Jan 2025 04:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254069; x=1736858869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ2XH5NLBv71T4OjQH8i8r7Ei7+B6QrcJlpQOt48wPM=;
        b=TPk+34lYvsg0+Kr9Jlab7iJDw5PzUkhwDFXH2u43cmB55yp1t0rzpXRS//o1W4tI+0
         FKear1c3u7Kdqqe9lOPMVUtbW8uLpY9mzhoEk3ohCmALuZO8olT1NsjQWWNmxyJ/MHaH
         5bIvfEWs+GaviizzOdnq+qadKtdcaFcn78roEwQwqC+Q0225bVLdFE6ZHZ/dF4lDwXg6
         sWEBQnmIwWzz7Imqdn4UPr7rmeOdchCbUUP+be0Nmof8sysPk4klOYU3bKgJhOytKoFa
         cg7RBkELpZhizc81K96i/5LiBG6B86b2+5HB4o9ZvtgL9oJF2thfPah1f4OdgLWt0Afb
         UR0w==
X-Forwarded-Encrypted: i=1; AJvYcCXwn+TiQZBR6tQBgyZIsj+7B14HQTKMzU+6WC/T4j0gOmp95RZHQH9NKe3QKPkg7vTg7w5Qyv1r94A2Tk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+dfTrg9/9c1c64ehxDtg6jXZ6ZKd6WVMVVy8jyAATjOeiaP/
	lD0KqcyREN5qsBhdLH31aeACcaIfmV2iTOX0lp1Eq3jWFO+UWMP2tN9Mrg==
X-Gm-Gg: ASbGnctO6x9FaMabyUGsNQYyx9jLeYW/ElLePuh7mLHW2zH1/iQQBhor8IdpyshdEDP
	6DN/Hmp1qKFs9U4sL9CD8dIkJL1mMb2Ge5uXfQv6hw0phsTNMcTGNdqnUB0rJhcK1/hly0kpnH1
	Z8N/JkwVEgqcps9RattPLqYWMQOQhneNOqR7YJd0o0+ELYyfi0C2SUBuTmEpJKNIsMDHNrvLbbu
	blzgHL0A1Itk4PQ/i6ju2Ndj0rYUjiqkTkLdw6wKzX8liyH3l9Zeo2Cu+LjpwhbowRlFN46YmLd
	v9rVrihlibhfEFZwL7RnEaOZYlA6uDK6vYm7
X-Google-Smtp-Source: AGHT+IEeMOyJTTb64xoIxLCYpfFmjJBMah+Qx9nAn/2OtmnH3SKDpkUSM0jzc2zWnkuceKmOW4AqNA==
X-Received: by 2002:a05:600c:1d21:b0:434:a4a6:51f8 with SMTP id 5b1f17b1804b1-4366790e3fdmr582775485e9.0.1736254068450;
        Tue, 07 Jan 2025 04:47:48 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:48 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:31 +0100
Subject: [PATCH v2 01/14] btrfs: don't try to delete RAID stripe-extents if
 we don't need to
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-1-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=jth@kernel.org;
 h=from:subject:message-id; bh=W7+obICRHX3n/iMqbxUrpU4kmmyR3NNrLIE17rHDiq4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhV0Biut5T5p6/0mueGER+y0s6cluGenVQpf7fVKf
 v3vZG1uRykLgxgXg6yYIsvxUNv9EqZH2Kccem0GM4eVCWQIAxenAExkCQfDH57f4TftZSeuzL9w
 SO3QOVefOXpTrXb3FOk26G1b8qnrVDYjw8KjHDOVOxL3nu0INdk0M87rZTgLo7SewZuFgs+UfSa
 95QcA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't try to delete RAID stripe-extents if we don't need to.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c             | 15 ++++++++++++++-
 fs/btrfs/tests/raid-stripe-tree-tests.c |  3 ++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 45b823a0913aea5fdaab91a80e79d253a66bb700..757e9c681f6c49f2d0295c1b3b2de56aad3c94a6 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -59,9 +59,22 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
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
+		if (!map)
+			return -EINVAL;
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
index 30f17eb7b6a8a1dfa9f66ed5508da42a70db1fa3..f060c04c7f76357e6d2c6ba78a8ba981e35645bd 100644
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


