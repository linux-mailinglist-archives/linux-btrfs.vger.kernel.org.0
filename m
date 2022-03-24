Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426B04E674C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 17:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352004AbiCXQzr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 12:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352074AbiCXQzP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 12:55:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9E9B6D07
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hZJo9u0MSDvreXyCWC5j+KKrw3WzWepCZFRbIUmO9dU=; b=pXBt2t60WvgLdv65YvkgqaxS1A
        Q9HElEBbbjwfN9bshQD1KFfViOUFPihjsG3JqOnN6tUbfXkQppNnVxjU8HqYWKLrfq5W/OWP6V0KA
        PiLb3+vELvs41BvvYIs9dTYh5rAf03GBIqLz9WDJxX00CsWEL6IGLMRkSZ6oPBgBaz21fIedASSie
        rUdNL6hUAH7FUzoRwyYT1HR4DTahatEeTGzxi8EjaYjY7PLU5XCoQKQERPaIDa/3ud4Wg29IQU23I
        wr5hRRD2XImqnx+nkiQCBBOVLmTyWu/kEohRmR8xwfbCCBaRLlX8Lj9tNevNp5vT2fzj+rBKPEp+j
        MbR++scA==;
Received: from [2001:4bb8:19a:b822:2a44:1428:2337:3096] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXQh8-00HFxP-M7; Thu, 24 Mar 2022 16:52:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix and document the zoned device choice in alloc_new_bio
Date:   Thu, 24 Mar 2022 17:52:10 +0100
Message-Id: <20220324165210.1586851-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220324165210.1586851-1-hch@lst.de>
References: <20220324165210.1586851-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zone Append bios only need a valid block device in struct bio, but
not the device in the btrfs_bio.  Use the information from
btrfs_zoned_get_device to set up bi_bdev and fix zoned writes on
multi-device file system with non-homogeneous capabilities and remove
the pointless btrfs_bio.device assignment.

Add big fat comments explaining what is going on here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d78b3a2d04e3b..175a3f16c2da0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3334,24 +3334,37 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
 	if (ret < 0)
 		goto error;
-	if (wbc) {
-		struct block_device *bdev;
 
-		bdev = fs_info->fs_devices->latest_dev->bdev;
-		bio_set_dev(bio, bdev);
-		wbc_init_bio(wbc, bio);
-	}
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		struct btrfs_device *device;
+	if (wbc) {
+		/*
+		 * For Zone append we need the correct block_device that we are
+		 * going to write to set in the bio to be able to respect the
+		 * hardware limitation.  Look it up here:
+		 */
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			struct btrfs_device *dev;
+
+			dev = btrfs_zoned_get_device(fs_info, disk_bytenr,
+						     fs_info->sectorsize);
+			if (IS_ERR(dev)) {
+				ret = PTR_ERR(dev);
+				goto error;
+			}
 
-		device = btrfs_zoned_get_device(fs_info, disk_bytenr,
-						fs_info->sectorsize);
-		if (IS_ERR(device)) {
-			ret = PTR_ERR(device);
-			goto error;
+			bio_set_dev(bio, dev->bdev);
+		} else {
+			/*
+			 * Otherwise pick the last added device to support
+			 * cgroup writeback.  For multi-device file systems this
+			 * means blk-cgroup policies have to always be set on the
+			 * last added/replaced device.  This is a bit odd but has
+			 * been like that for a long time.
+			 */
+			bio_set_dev(bio, fs_info->fs_devices->latest_dev->bdev);
 		}
-
-		btrfs_bio(bio)->device = device;
+		wbc_init_bio(wbc, bio);
+	} else {
+		ASSERT(bio_op(bio) != REQ_OP_ZONE_APPEND);
 	}
 	return 0;
 error:
-- 
2.30.2

