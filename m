Return-Path: <linux-btrfs+bounces-10852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9916A07B9E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770817A0757
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DC622069B;
	Thu,  9 Jan 2025 15:15:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4521CFF0;
	Thu,  9 Jan 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435724; cv=none; b=m/67/5fH47skypbwytnwL/2MPJ0yKKPCWqjTZTG8/BcRIybyGZ87X714s5YBQeuK1eEsj3ytd1xmFN8imz9nXOtH81p4nzeD0BKpu0fuC77aYgXmlU5YSkpaQNgFt+ZfU5dHcFbD//1gpbi5Fqjt5WZHagaEAkPlYU923XpLsxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435724; c=relaxed/simple;
	bh=nDHaNn1VA42Nqy+KzH1vDglgIIwzwAdXjfSI9GIrdPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eA/Qm2ztzSMDT0tTPzHJehAuqQSmSsg95FT4ElBARw6twU3N3stE2qMxUUJvtrGlKkY26753FqfzP9WvYepcU+ajN9Ix3rgjTg2hcetUqzXz490/ggLVZ7dh0tU3iTkjHGY7eivoNRTwXmSVTaAVRExcUB1D5qdDOAfAmsIQD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so166666866b.0;
        Thu, 09 Jan 2025 07:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435721; x=1737040521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nPgOpo09U+aMg6lojzJKZD2YVp6zwKoPsftL/1sNH0=;
        b=Nb88PqKfdbPl8xJgSC9fbh1+fnR1869BiNLS3OzPXsmqUun2dBEFhmFe759goAAtqc
         /+XYOo9O19U6eE1MM689U70++C/v3Fe/9/tHq7+r/4NsQOaC36gtSxMfFQHWZMv1hmcX
         kMEQgUtBPdUTyAmVTcxpxvuVlfDtuNcC4pDyIGBl7jvvhk3IgdrCXmjh0uw+qoo5dKfl
         oeCQ26lTUOnEcvwRYoI5CoDrH5Vpnw+CoObSGxOd+PfUaUsda5kCh6TbUrVqlE2+mxjV
         6diSYWIf4tQwx6k11MLzQ9Tb+Y1aAC+QuSCO2t/uRVqonzNvZJnNWXiE3TbQ0U5UqdzC
         zTlA==
X-Forwarded-Encrypted: i=1; AJvYcCUY+EycPv6nw9xrqGcN3BCCXhcRbM8CUx5M300dnWdhWqlo1syo1Ep83Il3CcJ0/28T7j3UKqEoXoAGgQ==@vger.kernel.org, AJvYcCUorxAa2BpFLMjCOvHD2bAta9uqSsGrgGS5usnND1yKi0Iid9TcBZ3sIeQn9CeZcyFxG0N+XKtlloNpYhxp@vger.kernel.org
X-Gm-Message-State: AOJu0YzvlvHMN7lHVuR+E6tD7zWhE5+mX/Ux+Njs9plDPrzC0+0G0NgS
	L1t2G+0obx70HVTrEx+Vo3IdV4HKn483ckafqzgLxvTiK/vRMFsJ
X-Gm-Gg: ASbGnctlefyvABI+TFwg9HHs6K6OmHqVUxWw+St8yoGkHOkjGbCdzpC731js8hxrf88
	w9INcaDLgI6+Gz4vONeYPb/QYzmJ5mKzdZFS5WBXixr18UuN/LQ4LtVy4eyBLvmLIJ50Z4Cc1gt
	qZyk6rhZBwIVtqMGrkCXnjYfkGeQ7MyGXsigVFm6fOf448AlxSsALOnvhSAudSisyHNPypAno8/
	xiIKrQkGOLVjXQYK3Axqdzctqowtl/tTZmZtrPiv15cFqKk4/vZnzX4tKjgeO0swDG53RTYJLhH
	igM8kWGKVYahKCrrDSlSZTikWbWoW/C9EwML
X-Google-Smtp-Source: AGHT+IFN+NzMdezi7ezy7wiCDC3wI1o3mHTp3HqBNtSwXbXJSkSNbQz57iRGtIky8L8+I4gXnhaevA==
X-Received: by 2002:a05:6402:321a:b0:5d3:cff5:635e with SMTP id 4fb4d7f45d1cf-5d972e63d86mr15500622a12.26.1736435720482;
        Thu, 09 Jan 2025 07:15:20 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:20 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:03 +0100
Subject: [PATCH v3 02/14] btrfs: don't try to delete RAID stripe-extents if
 we don't need to
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-2-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212; i=jth@kernel.org;
 h=from:subject:message-id; bh=DwPyDVlnF+iWOQrGDC+7oSUBI24Ggo3Gzbhb6/bjcq8=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2DxPtS4+WGfWM7D595ssfceb5wtLSm+N2HVAqmFD
 h2/6yX+d5SyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEnEwY/heaef9m4zt211qx
 YrWemss6w4y77R9W6J3XzmCcoGYk2MnIMNXpla311n6TVGX+khtuHHcuCy9LPmA7p1qgeu7qM1H
 afAA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Even if the RAID stripe-tree is not enabled in the filesystem,
do_free_extent_accounting() still calls into btrfs_delete_raid_extent().

Check if the extent in question is on a block-group that has a profile
which is used by RAID stripe-tree before attempting to delete a stripe
extent. Return early if it doesn't, otherwise we're doing a unnecessary
search.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c             | 15 ++++++++++++++-
 fs/btrfs/tests/raid-stripe-tree-tests.c |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 0bf3c032d9dc43eefe158e430813add9292c577e..be923144cc85a0ecb370dbb1ebeea44269a1f4ad 100644
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
index 2e8083f1d0d184a23317facbb566ef949639a8a7..f060c04c7f76357e6d2c6ba78a8ba981e35645bd 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -480,6 +480,7 @@ static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
 	}
 	btrfs_set_super_incompat_flags(root->fs_info->super_copy,
 					BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE);
+	btrfs_set_fs_incompat(root->fs_info, RAID_STRIPE_TREE);
 	root->root_key.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
 	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root->root_key.offset = 0;

-- 
2.43.0


