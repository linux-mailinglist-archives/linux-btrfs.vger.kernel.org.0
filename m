Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F15691958
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 08:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBJHs7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 02:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjBJHs6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 02:48:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B35BA7B
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 23:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=y8N2jRs3RPqEzw393uTbY4Y4hMvqRnzvBhY+SmiNkUs=; b=1Z9VkW1GJqKmzMy+8SGRVSI48R
        Lcuvdhdv1BTofBYCuvrMlc+1/vFIBl9r2wYxwro4dPFt2hNbrj3TF5GGY3cT9TfLo8kuUQnwlS7BO
        O+Hr8trTq0EjxNXz7UFpgMg+TfLU2t2idbcxE0StCCmZBUmgYEuXI+Q+ifokTbqRB0T9sjUcN5HLX
        Dt2wYCrNum8S8IP0M6deUY2GXEeognevqdIM6uEb7mUOU05aOwzPitDCQSeX/pAJcBtU8o1XnOCtG
        FaU5Xip82myGjxVs0X6wihse6JmFXXYL1WffL5ijcTyzJSk5AInzcwiHL+QdoL6zSgADLopYG0ZcA
        t1OmAqQA==;
Received: from 213-147-164-133.nat.highway.webapn.at ([213.147.164.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQO9O-004ff1-72; Fri, 10 Feb 2023 07:48:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: cleanup em handling in btrfs_submit_compressed_read
Date:   Fri, 10 Feb 2023 08:48:35 +0100
Message-Id: <20230210074841.628201-3-hch@lst.de>
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

em can't be non-NULL after the free_extent_map label.  Also remove
the now pointless clearing of em to NULL after freeing it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index cd0cfa8fdb8c15..6fd9c6efe387bd 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -572,7 +572,6 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 	cb->orig_bio = bio;
 
 	free_extent_map(em);
-	em = NULL;
 
 	cb->nr_pages = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
 	cb->compressed_pages = kcalloc(cb->nr_pages, sizeof(struct page *), GFP_NOFS);
@@ -629,7 +628,6 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 	kfree(cb->compressed_pages);
 out_free_bio:
 	bio_put(comp_bio);
-	free_extent_map(em);
 out:
 	btrfs_bio_end_io(btrfs_bio(bio), ret);
 }
-- 
2.39.1

