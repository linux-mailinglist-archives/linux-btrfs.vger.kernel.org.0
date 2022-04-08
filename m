Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2194F8E36
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiDHFLG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiDHFLF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:11:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A96623B3D3
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tLT+FbkIcBjA3qPdQz/pzXpSyzTC5kmwAJ9XjMyiKXI=; b=j/hW+DxRQqX+65WZ81XrkbeNfK
        VKloamR+1FuQV1+UunRBfri4KsqFQ+8h3dG8T5LJx4/FwXq3yRdFGkpUqzy+fxKyQouWZx2G9JFIf
        +CRa547l6cPRFQ75Q65d2zQThuc+EbBByfYSbYQW2j85MFJtig22wQc8m9j0hxZn7pHeaaaWXjF3D
        5vhIfFVAXJrjpe7/ISXVipwToMw3vS+rDNlocYzMp7FlLSGyNm/M6aXwMxhZxbFjhse/5NH0aYQnh
        LAZrTFvOMHgeWiMBqIDgAzr66Uf2FPNbWLoIAsUJKe456NjP2EArH0IMXqzgvpiFyjK/Qzgjt+wfD
        jJYKqifw==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgrj-00F167-TL; Fri, 08 Apr 2022 05:09:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 05/12] btrfs: simplify scrub_recheck_block
Date:   Fri,  8 Apr 2022 07:08:32 +0200
Message-Id: <20220408050839.239113-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408050839.239113-1-hch@lst.de>
References: <20220408050839.239113-1-hch@lst.de>
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

The I/O in repair_io_failue is synchronous and doesn't need a btrfs_bio,
so just use an on-stack bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a4f9cfdec8b60..3790747c449b0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1458,8 +1458,9 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		return scrub_recheck_block_on_raid56(fs_info, sblock);
 
 	for (i = 0; i < sblock->sector_count; i++) {
-		struct bio *bio;
 		struct scrub_sector *sector = sblock->sectors[i];
+		struct bio_vec bvec;
+		struct bio bio;
 
 		if (sector->dev->bdev == NULL) {
 			sector->io_error = 1;
@@ -1468,20 +1469,17 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		}
 
 		WARN_ON(!sector->page);
-		bio = btrfs_bio_alloc(1);
-		bio_set_dev(bio, sector->dev->bdev);
-
-		bio_add_page(bio, sector->page, fs_info->sectorsize, 0);
-		bio->bi_iter.bi_sector = sector->physical >> 9;
-		bio->bi_opf = REQ_OP_READ;
+		bio_init(&bio, sector->dev->bdev, &bvec, 1, REQ_OP_READ);
+		bio_add_page(&bio, sector->page, fs_info->sectorsize, 0);
+		bio.bi_iter.bi_sector = sector->physical >> 9;
 
-		btrfsic_check_bio(bio);
-		if (submit_bio_wait(bio)) {
+		btrfsic_check_bio(&bio);
+		if (submit_bio_wait(&bio)) {
 			sector->io_error = 1;
 			sblock->no_io_error_seen = 0;
 		}
 
-		bio_put(bio);
+		bio_uninit(&bio);
 	}
 
 	if (sblock->no_io_error_seen)
-- 
2.30.2

