Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB184DA5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFTTie (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:34 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35829 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfFTTid (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:33 -0400
Received: by mail-yw1-f67.google.com with SMTP id k128so1681369ywf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=pQJXSj+dLF77Or0BCPiIWcXQR4aAQTZGeoSeFqrBG1Q=;
        b=zNAT/Q5DUMEO9lN71KtWn1BoQFDRwWUoifA9lIXO+8grCloz3lf47XGvS+druBlWu/
         4iiJAFoN9dlhb1b6mRZCRyuyTIs/iMtGQr13lSiLc0Fzs1wRsuldXBUpU7gX7SL6Ssyx
         JxonDYnOgQXQf3KJN8CdyGKp9y+qyJwQsGtzxUEezRm6XfWiKcL3idIcVOva0zCIFqM7
         GdI4zw2Df3glU7dTfdPo86g6rt6DAFItv3rKV8pnBN0wAuRjGFS1u0lmj12tkXHYF8lP
         xds5LSqK3StTkNnwOYJ9ndLyCwBmKe2+NSipoQbd79Sjgp1+Mwk/lw1t0KfdCvEXHTI9
         VWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=pQJXSj+dLF77Or0BCPiIWcXQR4aAQTZGeoSeFqrBG1Q=;
        b=U4AetoshZTs8jzysDQTpvxeemMfcBbM+k7pvdysJ4cg2JFwof5HBBnx9G4mPeHfZUS
         8fVteZ4QcUQ2O8aPN3O+CX2HYXeLMYh8tY+6jC+KKWUDD23kYERhgzaU2SC3pWU7ckFK
         GGWkuWrQET/qP0WvODGo70VIwejWvt+t8o0Kxg5ZI9cdjQhhJ8C1JeazyjnkCpueSekh
         g1pzdaBxFjtV8h+IzxJIlBs7tjBVdp2cu2YwyQLAcQFYpBkbfUUIUnUHqLdMvzm0m7K0
         vbTcR8Jxo7zDdC1wQ00MD6U0EY5GhXtuFHXLC3gwhY2V69W8KxsAMvKGJQ8pKkkC36ic
         0bSA==
X-Gm-Message-State: APjAAAVKaD92yqfrv401V8LtI0MDsQekFIBuogTI7TfnyAo+m6lPbtlo
        FRWBgaxqhNqQyPqi548C1O0YmLQVaBL0/w==
X-Google-Smtp-Source: APXvYqwdIrm7SyAZZKCb2/K5+YIol474Xqi6VL9Jhzgx7KheZT0grMRMtK0/qwpI+1E/xNTXZxzmuQ==
X-Received: by 2002:a81:5e57:: with SMTP id s84mr3462715ywb.244.1561059512546;
        Thu, 20 Jun 2019 12:38:32 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a70sm123009ywa.79.2019.06.20.12.38.31
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/25] btrfs: export get_alloc_profile
Date:   Thu, 20 Jun 2019 15:37:56 -0400
Message-Id: <20190620193807.29311-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This gets used directly by a bunch of the block group code, export it to
make it easier to move things around.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/extent-tree.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 890327c1235c..96443ebd63d2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2463,6 +2463,7 @@ static inline u64 btrfs_calc_trunc_metadata_size(struct btrfs_fs_info *fs_info,
 int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
 			      u64 start, u64 num_bytes);
 void btrfs_free_excluded_extents(struct btrfs_block_group_cache *cache);
+u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			   unsigned long count);
 void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1a101fc55007..38d757bb3666 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3234,7 +3234,7 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	return extended_to_chunk(flags | allowed);
 }
 
-static u64 get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
+u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
 {
 	unsigned seq;
 	u64 flags;
@@ -3267,23 +3267,23 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 	else
 		flags = BTRFS_BLOCK_GROUP_METADATA;
 
-	ret = get_alloc_profile(fs_info, flags);
+	ret = btrfs_get_alloc_profile(fs_info, flags);
 	return ret;
 }
 
 u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
-	return get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_DATA);
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_DATA);
 }
 
 u64 btrfs_metadata_alloc_profile(struct btrfs_fs_info *fs_info)
 {
-	return get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 }
 
 u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
 {
-	return get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 }
 
 static void force_metadata_allocation(struct btrfs_fs_info *info)
@@ -6794,7 +6794,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 	ret = __btrfs_inc_block_group_ro(cache, 0);
 	if (!ret)
 		goto out;
-	alloc_flags = get_alloc_profile(fs_info, cache->space_info->flags);
+	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
@@ -6814,7 +6814,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 {
-	u64 alloc_flags = get_alloc_profile(trans->fs_info, type);
+	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
 
 	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 }
@@ -7533,7 +7533,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	}
 
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
-		if (!(get_alloc_profile(info, space_info->flags) &
+		if (!(btrfs_get_alloc_profile(info, space_info->flags) &
 		      (BTRFS_BLOCK_GROUP_RAID10 |
 		       BTRFS_BLOCK_GROUP_RAID1 |
 		       BTRFS_BLOCK_GROUP_RAID5 |
-- 
2.14.3

