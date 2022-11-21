Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D3632B6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 18:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKURsG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 12:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiKURsE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 12:48:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1491817E39
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 09:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QlVIFBPiaqfkV0sxxypJAb2wvYMQwGaLkxQytb9tTAE=; b=mxvjFkt0VhWYDTPOL1h6utRjAo
        qm9RzG9mCPcRlq6mNk+avNo2y9K/PhR7jOK3CnGT02dZOUgmq7vliw0fuZeU0o5O+FRD3V1y3R/Aq
        P1LL2CeO8IE66GmbENBCeK4AGOuV+YCvQUwe1k0ut5My+UtpQmRL2qE9GTvNLZR4eoIOkr9rB2J/e
        YECMfoVJZw/dJ15xQ0cWBW8nMre/8cDucyKhbmMHMTklQOvfTg7XvnpCbWwJLc/t01KykA+xy0Dcj
        nPJDOzPSeVXramd2yaPQ1RWv+6cyvLTTqX26rjQfGR5LjzKjG36U3QUuUWy6jOXWTtUh54dONV/Od
        tj2Yg14w==;
Received: from [2001:4bb8:199:6d04:9a88:dc19:c657:d17f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxAtj-00GUMQ-8a; Mon, 21 Nov 2022 17:47:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: stop using write_one_page in btrfs_scratch_superblock
Date:   Mon, 21 Nov 2022 18:47:49 +0100
Message-Id: <20221121174749.387407-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221121174749.387407-1-hch@lst.de>
References: <20221121174749.387407-1-hch@lst.de>
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

write_one_page is an awkward interface that expects the page locked
and ->writepage to be implemented.  Just mark the sb dirty, put
the page and then call the proper bdev helper to sync the range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2dd7d2c5b0d80..ddf172ba67972 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2009,23 +2009,22 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 				     struct block_device *bdev, int copy_num)
 {
 	struct btrfs_super_block *disk_super;
-	struct page *page;
+	const size_t len = sizeof(disk_super->magic);
+	u64 bytenr = btrfs_sb_offset(copy_num);
 	int ret;
 
-	disk_super = btrfs_read_dev_one_super(bdev, copy_num, false);
+	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr);
 	if (IS_ERR(disk_super))
 		return;
-	memset(&disk_super->magic, 0, sizeof(disk_super->magic));
-	page = virt_to_page(disk_super);
-	set_page_dirty(page);
-	lock_page(page);
-	/* write_on_page() unlocks the page */
-	ret = write_one_page(page);
+	memset(&disk_super->magic, 0, len);
+	set_page_dirty(virt_to_page(disk_super));
+	btrfs_release_disk_super(disk_super);
+
+	ret = sync_blockdev_range(bdev, bytenr, bytenr + len - 1);
 	if (ret)
 		btrfs_warn(fs_info,
 			"error clearing superblock number %d (%d)",
 			copy_num, ret);
-	btrfs_release_disk_super(disk_super);
 }
 
 void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
-- 
2.30.2

