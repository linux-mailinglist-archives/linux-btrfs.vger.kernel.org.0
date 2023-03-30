Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B064B6CFB91
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjC3GbZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjC3GbY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB4261A4
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nkliL7/PV5NxqAfKFrVQuDY7ULiX7opspFI+9FZbZuE=; b=VYb/XAAfYMSdJmdXAKUUUycYBO
        g62qSJuNbA9VJy8q3jrCqfO2LeJbZ+7X3tSaz32T7nHyOYFOCZGjePF2v0YXO0sQ1flQpRkUl2Dbb
        Z+lybZcF2wzMz02jBYoBWstUYy52Q+i/W/B3T7UradF1dykY53VRoWKENLNZhtcq0/cJP+V5MJ7kU
        dlyPnA0Edwt4GtzekfW5873LhcutM48aeVORLFSVVjdUCpkoV13yo2pXCkN3CBBSvxaMdFIL3B41O
        S8f1ncF63bAeES5/aQkgeFWoSoKC7Jw0XtqnY1KVKbliSAFVV3dVLczCIIUftLw0mSdjjWxDGjogx
        2MTcLVCg==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phlog-002le1-1R;
        Thu, 30 Mar 2023 06:31:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/21] btrfs: do not try to unlock the extent for non-subpage metadata reads
Date:   Thu, 30 Mar 2023 15:30:47 +0900
Message-Id: <20230330063059.1574380-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330063059.1574380-1-hch@lst.de>
References: <20230330063059.1574380-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Only subpage metadata reads lock the extent.  Don't try to unlock it and
waste cycles in the extent tree lookup for PAGE_SIZE or larger metadata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5570f1050296c9..bc50163dd3b792 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4207,8 +4207,10 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 		bio_offset += bvec->bv_len;
 	}
 
-	unlock_extent(&bbio->inode->io_tree, eb->start,
-		      eb->start + bio_offset - 1, NULL);
+	if (eb->fs_info->nodesize < PAGE_SIZE) {
+		unlock_extent(&bbio->inode->io_tree, eb->start,
+			      eb->start + bio_offset - 1, NULL);
+	}
 	free_extent_buffer(eb);
 
 	bio_put(&bbio->bio);
-- 
2.39.2

