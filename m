Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E8B99FA6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391822AbfHVTOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:14:41 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37748 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389212AbfHVTOk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:14:40 -0400
Received: by mail-yb1-f195.google.com with SMTP id t5so2967287ybt.4
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAuAnL8pm4xNX5yKv5xw4R69r84AXKKF6dBTdVGoCxQ=;
        b=xYVK9XExUEuBPuQIWUrQFx+Q53AMndnhgTTefj4WoEaNohroQvsT1dKkxA0ky3C7WW
         +lHe5C8R3gIE3DpQCc66ReVTP2vGmdB7YYZTuE2ty0XHBePzKAUDL29D5KWI+qnTHYkO
         sQDV7Yfw08HW8AgpuVKsRVP/NRBTQ0pfK07OTcrXP4Gynw2WEM0FGHfGPEJsFa5vm+ad
         hFz9De4H+KK0upUVaz+hUt8+I0ikaGkMiW3erN7VZ1LbPM2nhznkmtauGSHoX3P5Tjbp
         temUvQXpibnGokZ75GukrypmjMOQwCGlq9UXFSx646rt87B3UnoO6CXjYSvDfL5Dtzlo
         /qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAuAnL8pm4xNX5yKv5xw4R69r84AXKKF6dBTdVGoCxQ=;
        b=VRLl/qnsR4LW5j+ABd6T7/D9KcgmntHY0QJktkELRtYDNVCBgeGhCIkd9TWTVEoZ4D
         a13sHqDIo7HFXsSLbyhgg2lK4M4LLpYQWjbVwlVyt+s3Uu/uowYDFJVG3E2Xa+fVSLDj
         U9goj/taJ8TEbf6P1nmhJZeWUcr7+kGjTXfwGmdeAEee3U0UL1mfi38TRgnEzlf3CSAs
         PiZSkcmN1cq6GGCThH6Xw0oZj+8Y0elaVZDLE/BUVK9/13LkklgefpvRkiGEue2BNPBP
         5bnPybInC/UpqF5VS/Doz8BUJjefz0DxGEU5aeg3GId5e+lW4ksxDe0k+3Ov63U3noww
         Wy7g==
X-Gm-Message-State: APjAAAUWH9eFWp9jRmR5zenRpKbRCINTqpoRnYmVyHzqx0sN99pia30f
        02tKO4NfmikfoMXJsuft/SKGqTmmW+bapQ==
X-Google-Smtp-Source: APXvYqxg3gLJgeHla2+HauQ8R17p8Xx5asG8SwTAJB82kFHVh03EhRxIYXcBNFZK0BAgVVYpTPvk6g==
X-Received: by 2002:a25:8401:: with SMTP id u1mr404939ybk.478.1566501280101;
        Thu, 22 Aug 2019 12:14:40 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o3sm127377ywi.93.2019.08.22.12.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:14:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: only reserve metadata_size for inodes
Date:   Thu, 22 Aug 2019 15:14:34 -0400
Message-Id: <20190822191434.13800-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191434.13800-1-josef@toxicpanda.com>
References: <20190822191434.13800-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Historically we reserved worst case for every btree operation, and
generally speaking we want to do that in cases where it could be the
worst case.  However for updating inodes we know the inode items are
already in the tree, so it will only be an update operation and never an
insert operation.  This allows us to always reserve only the
metadata_size amount for inode updates rather than the
insert_metadata_size amount.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delalloc-space.c | 21 +++++++++++++++++----
 fs/btrfs/delayed-inode.c  |  2 +-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 2412be4a3de2..d949d7d2abed 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -251,9 +251,16 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
 
 	lockdep_assert_held(&inode->lock);
 	outstanding_extents = inode->outstanding_extents;
-	if (outstanding_extents)
+
+	/*
+	 * Insert size for the number of outstanding extents, 1 normal size for
+	 * updating the inode.
+	 */
+	if (outstanding_extents) {
 		reserve_size = btrfs_calc_insert_metadata_size(fs_info,
-						outstanding_extents + 1);
+						outstanding_extents);
+		reserve_size += btrfs_calc_metadata_size(fs_info, 1);
+	}
 	csum_leaves = btrfs_csum_bytes_to_leaves(fs_info,
 						 inode->csum_bytes);
 	reserve_size += btrfs_calc_insert_metadata_size(fs_info,
@@ -278,10 +285,16 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 {
 	u64 nr_extents = count_max_extents(num_bytes);
 	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
+	u64 inode_update = btrfs_calc_metadata_size(fs_info, 1);
 
-	/* We add one for the inode update at finish ordered time */
 	*meta_reserve = btrfs_calc_insert_metadata_size(fs_info,
-						nr_extents + csum_leaves + 1);
+						nr_extents + csum_leaves);
+
+	/*
+	 * finish_ordered_io has to update the inode, so add the space required
+	 * for an inode update.
+	 */
+	*meta_reserve += inode_update;
 	*qgroup_reserve = nr_extents * fs_info->nodesize;
 }
 
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index de87ea7ce84d..9318cf761a07 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -612,7 +612,7 @@ static int btrfs_delayed_inode_reserve_metadata(
 	src_rsv = trans->block_rsv;
 	dst_rsv = &fs_info->delayed_block_rsv;
 
-	num_bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
+	num_bytes = btrfs_calc_metadata_size(fs_info, 1);
 
 	/*
 	 * btrfs_dirty_inode will update the inode under btrfs_join_transaction
-- 
2.21.0

