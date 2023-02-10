Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B042691959
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 08:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjBJHtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 02:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjBJHtD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 02:49:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7D7B38A
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 23:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Jnsc2VcTLYldBntU8k8QK3ymDCaSz+wcSgoG6uCrTBw=; b=ONa+QLny3x/8lyhgVHW+qD2DPg
        d6Jrmxsl8y33RLzeGC70VJN42kA4Pd2yjNy1prq87kjhYbNcmsymt+VQOnyZiOeQ7F+XbAcWUopVh
        7WL4mG6AQVzqXzCp+OwFWlJgMmSKmB0/VXwZdGHcedFuuVZDnktZyBsnDCPs1FMEwbRN4TolXKBiO
        SaEW0J3Zf/a/7HZmIJiovhxzB/YN5kigQ2//lzzeCnm61aXTjId8qTj2Xfy8KtXhNUrAZgs6VDiCc
        hGSI8vEtmsQBb7UcEVZe5kgjNRKiIoxqD8XIj9KlAwqXLFc+d+h3D2jPDrkXGqPGlEKAvLw2Sa5KC
        tPkZqEMg==;
Received: from 213-147-164-133.nat.highway.webapn.at ([213.147.164.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQO9T-004ffg-Au; Fri, 10 Feb 2023 07:49:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: use the bbio file offset in btrfs_submit_compressed_read
Date:   Fri, 10 Feb 2023 08:48:36 +0100
Message-Id: <20230210074841.628201-4-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210074841.628201-1-hch@lst.de>
References: <20230210074841.628201-1-hch@lst.de>
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

struct btrfs_bio now has a file_offset field set up by all submitters.
Use that in btrfs_submit_compressed_read instead of recalculating the
value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6fd9c6efe387bd..f7b6c0baae809a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -533,7 +533,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 	struct bio *comp_bio;
 	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 cur_disk_byte = disk_bytenr;
-	u64 file_offset;
+	u64 file_offset = btrfs_bio(bio)->file_offset;
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
@@ -542,9 +542,6 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 	blk_status_t ret;
 	int ret2;
 
-	file_offset = bio_first_bvec_all(bio)->bv_offset +
-		      page_offset(bio_first_page_all(bio));
-
 	/* we need the actual starting offset of this extent in the file */
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
-- 
2.39.1

