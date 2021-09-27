Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71739418FD8
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhI0HYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56850 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbhI0HYP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 493C320090
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e48ETYO5NKGJZPHkbVDdGrMd9wvszasMeuBfUv130Q8=;
        b=CA+84tr9J+yAQGnS0Tt7zHuz3VeUzyg7reWusjpq9TDt8kLRsgbpxJuODBlNy0HLlS+PO4
        bq+1LB5KRLP5UbyIpGwSaNSA6D+Pn78ABPeUJ4Mw9HGK7XKYculWkFLZHeM4m+86JMW/zj
        UpbHZZ2k54kktHZ+EPhfeL0JhIwYzV0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C60813A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GDLYGTxxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 10/26] btrfs: introduce submit_compressed_bio() for compression
Date:   Mon, 27 Sep 2021 15:21:52 +0800
Message-Id: <20210927072208.21634-11-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new helper, submit_compressed_bio(), will aggregate the following
work:

- Increase compressed_bio::pending_bios
- Remap the endio function
- Map and submit the bio

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 45 ++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b6ed5933caf5..3f0be97d17f3 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -422,6 +422,21 @@ static void end_compressed_bio_write(struct bio *bio)
 	bio_put(bio);
 }
 
+static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
+					  struct compressed_bio *cb,
+					  struct bio *bio, int mirror_num)
+{
+	blk_status_t ret;
+
+	ASSERT(bio->bi_iter.bi_size);
+	atomic_inc(&cb->pending_bios);
+	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
+	if (ret)
+		return ret;
+	ret = btrfs_map_bio(fs_info, bio, mirror_num);
+	return ret;
+}
+
 /*
  * worker function to build and submit bios for previously compressed pages.
  * The corresponding pages in the inode should be marked for writeback
@@ -518,19 +533,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 		page->mapping = NULL;
 		if (submit || len < PAGE_SIZE) {
-			atomic_inc(&cb->pending_bios);
-			ret = btrfs_bio_wq_end_io(fs_info, bio,
-						  BTRFS_WQ_ENDIO_DATA);
-			if (ret)
-				goto finish_cb;
-
 			if (!skip_sum) {
 				ret = btrfs_csum_one_bio(inode, bio, start, 1);
 				if (ret)
 					goto finish_cb;
 			}
 
-			ret = btrfs_map_bio(fs_info, bio, 0);
+			ret = submit_compressed_bio(fs_info, cb, bio, 0);
 			if (ret)
 				goto finish_cb;
 
@@ -557,18 +566,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		cond_resched();
 	}
 
-	atomic_inc(&cb->pending_bios);
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		goto last_bio;
-
 	if (!skip_sum) {
 		ret = btrfs_csum_one_bio(inode, bio, start, 1);
 		if (ret)
 			goto last_bio;
 	}
 
-	ret = btrfs_map_bio(fs_info, bio, 0);
+	ret = submit_compressed_bio(fs_info, cb, bio, 0);
 	if (ret)
 		goto last_bio;
 
@@ -875,12 +879,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		if (submit || bio_add_page(comp_bio, page, pg_len, 0) < pg_len) {
 			unsigned int nr_sectors;
 
-			atomic_inc(&cb->pending_bios);
-			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
-						  BTRFS_WQ_ENDIO_DATA);
-			if (ret)
-				goto finish_cb;
-
 			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
 			if (ret)
 				goto finish_cb;
@@ -889,7 +887,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 						  fs_info->sectorsize);
 			sums += fs_info->csum_size * nr_sectors;
 
-			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
+			ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
 			if (ret)
 				goto finish_cb;
 
@@ -904,16 +902,11 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		cur_disk_byte += pg_len;
 	}
 
-	atomic_inc(&cb->pending_bios);
-	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		goto last_bio;
-
 	ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
 	if (ret)
 		goto last_bio;
 
-	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
+	ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
 	if (ret)
 		goto last_bio;
 
-- 
2.33.0

