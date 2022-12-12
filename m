Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582CC64999F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiLLHhv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiLLHhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:37:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3AABED
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eO1r9qp8kPsqndud5zFZ+eXXTfL0NqkF3YnolJIUgzw=; b=Oc8KXd3KvLHlrCqWihVElbMmGD
        cetZKiojzXnaBHwkWh54setEq2d/zDxM0lvD0jU61Db+kRCwTggOiPv444kjTwHt+Dr5rqGFmwMZ0
        twKh6IKE2Lmp+kMBMoZTlq1pXPOKV6gjJT4SUiiE4BZTsO4tVbvKEYWyfiTCifrTUH7oNWS8GsChk
        Zr5gA+fvzMVoOVmPApWhlnPLNy3I9Q+aKSrXTjnd5AMJFqyazrahFk56xx00VpDbLO3fqjGR0tYpM
        vV4yVh3rFmJH2jyAvX2bMxSR72Ba7R6IYvHXJwAfk5kEhYfCzV9v8SNBStjRrC+WQWn4FXnw/EkfC
        rHxrjTwA==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4dNa-009WPj-6Z; Mon, 12 Dec 2022 07:37:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: pass a btrfs_bio to btrfs_use_append
Date:   Mon, 12 Dec 2022 08:37:21 +0100
Message-Id: <20221212073724.12637-5-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221212073724.12637-1-hch@lst.de>
References: <20221212073724.12637-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

struct btrfs_bio has all the information needed for btrfs_use_append, so
pass that instead of a btrfs_inode and file_offset.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c       | 2 +-
 fs/btrfs/extent_io.c | 3 +--
 fs/btrfs/zoned.c     | 4 +++-
 fs/btrfs/zoned.h     | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4ccbc120e869ba..d4ce7c83f85a25 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -614,7 +614,7 @@ static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
-	bool use_append = btrfs_use_zone_append(inode, logical);
+	bool use_append = btrfs_use_zone_append(bbio);
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_io_stripe smap;
 	blk_status_t ret;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3d1bcc71ee9998..92724fac9e0824 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -930,7 +930,6 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 				struct btrfs_inode *inode, u64 file_offset)
 {
 	struct btrfs_ordered_extent *ordered;
-	u64 logical = (bio_ctrl->bio->bi_iter.bi_sector << SECTOR_SHIFT);
 
 	/*
 	 * Limit the extent to the ordered boundary for Zone Append.
@@ -938,7 +937,7 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	 * to them.
 	 */
 	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
-	    btrfs_use_zone_append(inode, logical)) {
+	    btrfs_use_zone_append(btrfs_bio(bio_ctrl->bio))) {
 		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
 		if (ordered) {
 			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e8681615324dcb..77f453005dc924 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1622,8 +1622,10 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
 	spin_unlock(&trans->releasing_ebs_lock);
 }
 
-bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
+bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 {
+	u64 start = (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT);
+	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_block_group *cache;
 	bool ret = false;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 157f46132c56e0..c0570d35fea291 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -55,7 +55,7 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
-bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start);
+bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
@@ -181,7 +181,7 @@ static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 
-static inline bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
+static inline bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 {
 	return false;
 }
-- 
2.35.1

