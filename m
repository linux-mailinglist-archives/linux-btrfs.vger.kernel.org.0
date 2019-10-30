Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8999FE9B68
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfJ3MWc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:22:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfJ3MWc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:22:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B7DAB6CB;
        Wed, 30 Oct 2019 12:22:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs-progs: Remove type argument from btrfs_alloc_data_chunk
Date:   Wed, 30 Oct 2019 14:22:26 +0200
Message-Id: <20191030122227.28496-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030122227.28496-1-nborisov@suse.com>
References: <20191030122227.28496-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's always set to BTRFS_BLOCK_GROUP_DATA so sink it into the function.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 convert/main.c | 3 +--
 volumes.c      | 6 +++---
 volumes.h      | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/convert/main.c b/convert/main.c
index bb689be9f3e4..9904deafba45 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -943,8 +943,7 @@ static int make_convert_data_block_groups(struct btrfs_trans_handle *trans,
 			len = min(max_chunk_size,
 				  cache->start + cache->size - cur);
 			ret = btrfs_alloc_data_chunk(trans, fs_info,
-					&cur_backup, len,
-					BTRFS_BLOCK_GROUP_DATA, 1);
+					&cur_backup, len, 1);
 			if (ret < 0)
 				break;
 			ret = btrfs_make_block_group(trans, fs_info, 0,
diff --git a/volumes.c b/volumes.c
index 1d088d93e788..87315a884b49 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1245,7 +1245,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
  */
 int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 			   struct btrfs_fs_info *info, u64 *start,
-			   u64 num_bytes, u64 type, int convert)
+			   u64 num_bytes, int convert)
 {
 	u64 dev_offset;
 	struct btrfs_root *extent_root = info->extent_root;
@@ -1328,7 +1328,7 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_chunk_length(chunk, num_bytes);
 	btrfs_set_stack_chunk_owner(chunk, extent_root->root_key.objectid);
 	btrfs_set_stack_chunk_stripe_len(chunk, stripe_len);
-	btrfs_set_stack_chunk_type(chunk, type);
+	btrfs_set_stack_chunk_type(chunk, BTRFS_BLOCK_GROUP_DATA);
 	btrfs_set_stack_chunk_num_stripes(chunk, num_stripes);
 	btrfs_set_stack_chunk_io_align(chunk, stripe_len);
 	btrfs_set_stack_chunk_io_width(chunk, stripe_len);
@@ -1338,7 +1338,7 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 	map->stripe_len = stripe_len;
 	map->io_align = stripe_len;
 	map->io_width = stripe_len;
-	map->type = type;
+	map->type = BTRFS_BLOCK_GROUP_DATA;
 	map->num_stripes = num_stripes;
 	map->sub_stripes = sub_stripes;
 
diff --git a/volumes.h b/volumes.h
index 586588c871ab..83ba827e422b 100644
--- a/volumes.h
+++ b/volumes.h
@@ -272,7 +272,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		      u64 *num_bytes, u64 type);
 int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 			   struct btrfs_fs_info *fs_info, u64 *start,
-			   u64 num_bytes, u64 type, int convert);
+			   u64 num_bytes, int convert);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       int flags);
 int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
-- 
2.7.4

