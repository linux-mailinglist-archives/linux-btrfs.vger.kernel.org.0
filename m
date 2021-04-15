Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02959360154
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhDOFFZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:36862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhDOFFZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SuAUh5xPuphRTh1cxjFjnOBhX/AFbeUdWxYiHmaFZHM=;
        b=ECAid8+uLX5v2Uipi2kct9RkNnjRc5nTBWXSAPO/xEZrdegFpamGF7PmlCqlWxOF1pMhGt
        Wl4tpPw616Ckxh73cmLl3lwjGoyZbbhxr/Olx7IMaaIeSD/PUvkI8pLVfPjfGDZ/05KyTl
        P9wyl9zH6cghjccHx4Qkiol7/SrxvtM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F41C6AF39
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/42] btrfs: remove the unused parameter @len for btrfs_bio_fits_in_stripe()
Date:   Thu, 15 Apr 2021 13:04:11 +0800
Message-Id: <20210415050448.267306-6-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The parameter @len is not really used in btrfs_bio_fits_in_stripe(),
just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c   | 5 ++---
 fs/btrfs/volumes.c | 5 +++--
 fs/btrfs/volumes.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1a349759efae..4c1a06736371 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2212,8 +2212,7 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 	em = btrfs_get_chunk_map(fs_info, logical, map_length);
 	if (IS_ERR(em))
 		return PTR_ERR(em);
-	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), logical,
-				    map_length, &geom);
+	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), logical, &geom);
 	if (ret < 0)
 		goto out;
 
@@ -8169,7 +8168,7 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 			goto out_err_em;
 		}
 		ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
-					    logical, submit_len, &geom);
+					    logical, &geom);
 		if (ret) {
 			status = errno_to_blk_status(ret);
 			goto out_err_em;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6d9b2369f17a..c33830efe460 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6117,10 +6117,11 @@ static bool need_full_stripe(enum btrfs_map_op op)
  * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
  */
 int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
-			  enum btrfs_map_op op, u64 logical, u64 len,
+			  enum btrfs_map_op op, u64 logical,
 			  struct btrfs_io_geometry *io_geom)
 {
 	struct map_lookup *map;
+	u64 len;
 	u64 offset;
 	u64 stripe_offset;
 	u64 stripe_nr;
@@ -6226,7 +6227,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
 	ASSERT(!IS_ERR(em));
 
-	ret = btrfs_get_io_geometry(fs_info, em, op, logical, *length, &geom);
+	ret = btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index d4c3e0dd32b8..0abe00402f21 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -443,7 +443,7 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_bio **bbio_ret);
 int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
-			  enum btrfs_map_op op, u64 logical, u64 len,
+			  enum btrfs_map_op op, u64 logical,
 			  struct btrfs_io_geometry *io_geom);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
-- 
2.31.1

