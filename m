Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3F264999E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiLLHhu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiLLHhr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:37:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B09F12D
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CxnT7Y4V4DrHvXRFoQV257AwL1XL2xGi3H4FcRFCrHk=; b=OyBMCCGHrUPp87oFAdIhpZOszw
        XVZVUTlxofHv4Sh0vRiAzxDwJn/25KUCSZBxv0d+jhoRzHmRLXqxGGudsaF/3mWpgbdOLwFwtLmtM
        MMIMyDKNV4tOnjSHcGVHP7ZR7+W8W8seriDmnBITybagIwNF3l4iRK9khefHeXedFf3376nBiAwOJ
        a4UtDkNMBJ5AeyPiK60RDQFDWjJ5DDXYagNCYGd/4lhLgUf2ulbrgCLGR0NKDMdwZ1ZmH1FgWCYzk
        u0o2M4RRI6pcxfOnsEjIJCBn0qPeRat7ds+2sOF//8Xcd1VOh0h1wsArp92WrI2AvWcUl9tBekfJq
        IezWEjrQ==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4dNX-009WNP-Cj; Mon, 12 Dec 2022 07:37:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: set bbio->file_offset in alloc_new_bio
Date:   Mon, 12 Dec 2022 08:37:20 +0100
Message-Id: <20221212073724.12637-4-hch@lst.de>
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

Instead of digging into the bio_vec in submit_one_bio, set file_offset at
bio allocation time from the provided parameter.  This also ensures that
the file_offset is available all the time when building up the bio
payload.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1fcb55e549717f..3d1bcc71ee9998 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -130,8 +130,6 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
-	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
-
 	if (!is_data_inode(inode))
 		bio->bi_opf |= REQ_META;
 
@@ -973,6 +971,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 		bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	else
 		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
+	btrfs_bio(bio)->file_offset = file_offset;
 	bio_ctrl->bio = bio;
 	bio_ctrl->compress_type = compress_type;
 	calc_bio_boundaries(bio_ctrl, inode, file_offset);
-- 
2.35.1

