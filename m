Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D389C717695
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjEaGFp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjEaGFp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D1911D
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bOj9JFNBbLSSuYObMrCi4xb+NXf8oe3Z1C4HnwA0Rws=; b=4qXZKgkOAlX9FzAhTtTWfVJ81I
        ME1INDSCZU4exqOFAsgw8h9E99XLtyFD2/JSRwGkG4pV6gklpxdBQMP2g9j+mQeOytd88en3iaNCU
        vYpDCCg059jKNttEYU3+bu+nfFTcsCnGDtaQCJw3MzfZYoKTJxZgatBxVX/MfE6GwqMfi8JRUwUi2
        1Oy4Pl6i3cHonnp5M1mY//MRIQRR/gk5oA3oqNpYdfX8ReMopmUDmFh+/i2L2+nTvuOnAhsgiDBzn
        Xk0A2J3bJTKzDjlft2Ds1MOCt/KnH20Gg0hJn7fYXMnZBrQlP10CgD7L2XrOyQ/57ZyFHDdFSIPZG
        DkVowtoA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Exq-00GF7q-0U;
        Wed, 31 May 2023 06:05:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 11/16] btrfs: move nr_to_write to __extent_writepage
Date:   Wed, 31 May 2023 08:05:00 +0200
Message-Id: <20230531060505.468704-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
References: <20230531060505.468704-1-hch@lst.de>
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

Move the nr_to_write accounting from __extent_writepage_io to
__extent_writepage_io as we'll grow another __extent_writepage_io that
doesn't want this accounting soon.  Also drop the obsolete comment -
decrementing a counter in the on-stack writeback_control data structure
doesn't need the page lock.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a2e1dbd9b92309..f773ee12ce1cee 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1370,12 +1370,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		return 1;
 	}
 
-	/*
-	 * we don't want to touch the inode after unlocking the page,
-	 * so we update the mapping writeback index now
-	 */
-	bio_ctrl->wbc->nr_to_write--;
-
 	bio_ctrl->end_io_func = end_bio_extent_writepage;
 	while (cur <= end) {
 		u64 disk_bytenr;
@@ -1521,6 +1515,8 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	if (ret == 1)
 		return 0;
 
+	bio_ctrl->wbc->nr_to_write--;
+
 done:
 	if (nr == 0) {
 		/* make sure the mapping tag for page dirty gets cleared */
-- 
2.39.2

