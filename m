Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B5B717504
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 06:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjEaESB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 00:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjEaER4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 00:17:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431D211F
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 21:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tmCh3k3ZkgoApEh2y44zL2TAx6ygO1BjJSSQwoNsstE=; b=YTgcuILdfSL4pSb6OLLEduXGRR
        vi30VqIHPeDaVIQIZCBIHALoU4P9EPkkwkRfFwWh3ryMaKPygF3VpvoMJS4i/xiuYjolEji5VOSOP
        DlHeoNU6oSnn3kIbjzyAvSKR+FyY1Mt6ufy/FobdhlzVl2QiJLpfEjzoQpdp0ImFAVQLaO3XA/IgM
        Ptmg2CzKcQTzG4bQd2nY8XrBBtliUGMkI2swmbGbZ/8QoL73IotyE4KtcSE7SwkPwHMAv9AnVyymk
        p2GNfN9pl+GU/Mn6YqePS65AwUXYTxVqZGQpdgnsCsciOGDTjl3qmWHmb03gg4kDCC18PTGvnt7U5
        RKt3HMHA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4DHV-00G1QR-1O;
        Wed, 31 May 2023 04:17:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: rename __btrfs_map_block to btrfs_map_block
Date:   Wed, 31 May 2023 06:17:37 +0200
Message-Id: <20230531041740.375963-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531041740.375963-1-hch@lst.de>
References: <20230531041740.375963-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the old btrfs_map_block is gone, drop the leading underscores
from __btrfs_map_block.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c             |  4 ++--
 fs/btrfs/check-integrity.c |  4 ++--
 fs/btrfs/dev-replace.c     |  2 +-
 fs/btrfs/volumes.c         | 16 ++++++++--------
 fs/btrfs/volumes.h         | 10 +++++-----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ae6345668d2d01..85511a8a480194 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -622,8 +622,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	int error;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
-	error = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
-				  &bioc, &smap, &mirror_num, 1);
+	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
+				&bioc, &smap, &mirror_num, 1);
 	if (error) {
 		ret = errno_to_blk_status(error);
 		goto fail;
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index fe15367000141a..3caf339c4bb3e4 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1464,8 +1464,8 @@ static int btrfsic_map_block(struct btrfsic_state *state, u64 bytenr, u32 len,
 	struct btrfs_device *device;
 
 	length = len;
-	ret = __btrfs_map_block(fs_info, BTRFS_MAP_READ, bytenr, &length, &bioc,
-				NULL, &mirror_num, 0);
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, bytenr, &length, &bioc,
+			      NULL, &mirror_num, 0);
 	if (ret) {
 		block_ctx_out->start = 0;
 		block_ctx_out->dev_bytenr = 0;
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index dc3f30c79320a1..5e86bea0a9507c 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -41,7 +41,7 @@
  *   All new writes will be written to both target and source devices, so even
  *   if replace gets canceled, sources device still contains up-to-date data.
  *
- *   Location:		handle_ops_on_dev_replace() from __btrfs_map_block()
+ *   Location:		handle_ops_on_dev_replace() from btrfs_map_block()
  *   Start:		btrfs_dev_replace_start()
  *   End:		btrfs_dev_replace_finishing()
  *   Content:		Latest data/metadata
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4c6405c4ce041d..53059ee04f9b60 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6232,11 +6232,11 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
 			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
 }
 
-int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-		      u64 logical, u64 *length,
-		      struct btrfs_io_context **bioc_ret,
-		      struct btrfs_io_stripe *smap, int *mirror_num_ret,
-		      int need_raid_map)
+int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
+		    u64 logical, u64 *length,
+		    struct btrfs_io_context **bioc_ret,
+		    struct btrfs_io_stripe *smap, int *mirror_num_ret,
+		    int need_raid_map)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -6486,7 +6486,7 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_io_context **bioc_ret)
 {
-	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
+	return btrfs_map_block(fs_info, op, logical, length, bioc_ret,
 				 NULL, NULL, 1);
 }
 
@@ -8066,8 +8066,8 @@ int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 
 	ASSERT(mirror_num > 0);
 
-	ret = __btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical, &map_length,
-				&bioc, smap, &mirror_ret, true);
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical, &map_length,
+			      &bioc, smap, &mirror_ret, true);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 481f3ace988c44..c70805c8d89554 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -585,11 +585,11 @@ void btrfs_put_bioc(struct btrfs_io_context *bioc);
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_io_context **bioc_ret);
-int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-		      u64 logical, u64 *length,
-		      struct btrfs_io_context **bioc_ret,
-		      struct btrfs_io_stripe *smap, int *mirror_num_ret,
-		      int need_raid_map);
+int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
+		    u64 logical, u64 *length,
+		    struct btrfs_io_context **bioc_ret,
+		    struct btrfs_io_stripe *smap, int *mirror_num_ret,
+		    int need_raid_map);
 int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 			   struct btrfs_io_stripe *smap, u64 logical,
 			   u32 length, int mirror_num);
-- 
2.39.2

