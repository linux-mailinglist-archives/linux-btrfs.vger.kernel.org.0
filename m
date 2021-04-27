Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D70036CF14
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhD0XEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:04:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:36708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235395AbhD0XEp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:04:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8bb49Fadicn9P7hy7qhBNHTwSFT1xlehrbu+mVdidA=;
        b=TD77bQRQXR0YjYVkAXptKWs3xLCnPRFwiOJNMyFml8rH+iwLguJQhAN8wh9Thexgmqu2AQ
        qb6xiMkrRytfQXEImhJ9dEJNj2DHm6lSovJmFKPOmwnaIflC3GL9eAijfbymqyhNgne+rb
        Hl50B+Esh7Xt5IJhczr+UqsYsHXtD9c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD30DABED;
        Tue, 27 Apr 2021 23:04:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [Patch v2 03/42] btrfs: remove the unused parameter @len for btrfs_bio_fits_in_stripe()
Date:   Wed, 28 Apr 2021 07:03:10 +0800
Message-Id: <20210427230349.369603-4-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The parameter @len is not really used in btrfs_bio_fits_in_stripe(),
just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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
index 77cdb75acc15..9c9dbef82d0f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6133,10 +6133,11 @@ static bool need_full_stripe(enum btrfs_map_op op)
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
@@ -6242,7 +6243,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
 	ASSERT(!IS_ERR(em));
 
-	ret = btrfs_get_io_geometry(fs_info, em, op, logical, *length, &geom);
+	ret = btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9c0d84e5ec06..d9aefb04cfaa 100644
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

