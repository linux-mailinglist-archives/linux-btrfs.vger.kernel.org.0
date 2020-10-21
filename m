Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F741294835
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440769AbgJUG0z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:43234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbgJUG0z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2grTSz56albd0BUDyalScJ+xvMEWdyaflq7+LcK8vwg=;
        b=B0/r6Cgxcfd6g0/jAlSjCFmGQXR48H6qpsTSlCdsR5dSQF4C3/snnDS6KJEyH56tC+Cckq
        3bWkDsKoT5ecWe6e/j8d/EvbvdTCd3bU/IuBuPTsrDM0wIwdbJgqHD2GtmnR6RGJEFE8MW
        JxPurkquHtv5Ib85Vz5G8eYTfldKThI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16AB9AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 25/68] btrfs: disk-io: accept bvec directly for csum_dirty_buffer()
Date:   Wed, 21 Oct 2020 14:25:11 +0800
Message-Id: <20201021062554.68132-26-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently csum_dirty_buffer() uses page to grab extent buffer, but that
only works for regular sector size == PAGE_SIZE case.

For subpage we need page + page_offset to grab extent buffer.

This patch will change csum_dirty_buffer() to accept bvec directly so
that we can extract both page and page_offset for later subpage support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ee2a6d480a7d..b34a3f312e0c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -495,13 +495,14 @@ static int btree_read_extent_buffer_pages(struct extent_buffer *eb,
  * we only fill in the checksum field in the first page of a multi-page block
  */
 
-static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
+static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec)
 {
+	struct extent_buffer *eb;
+	struct page *page = bvec->bv_page;
 	u64 start = page_offset(page);
 	u64 found_start;
 	u8 result[BTRFS_CSUM_SIZE];
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
-	struct extent_buffer *eb;
 	int ret;
 
 	eb = (struct extent_buffer *)page->private;
@@ -848,7 +849,7 @@ static blk_status_t btree_csum_one_bio(struct bio *bio)
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
-		ret = csum_dirty_buffer(root->fs_info, bvec->bv_page);
+		ret = csum_dirty_buffer(root->fs_info, bvec);
 		if (ret)
 			break;
 	}
-- 
2.28.0

