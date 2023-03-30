Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0436CFB8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjC3GbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjC3GbN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF6C4EEA
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=83c77I+4g+T4k/fr/P2gdwBFWJSyzDGdWJK9Ru6yn7g=; b=NdWIWpOsxH3zfcmf4G7YgVrw6Q
        qA3P3ReBefSJZV8fTjTHt7ORGZEwUQ04BHeo5l2ODGNu4CvjF7IfqhHzGd4KKficRTtxM8yD3L9NZ
        Gs2H31KxeUcVsMJAatTHE0NgIFYqjX1yja8bThUceuMMSToWvywMVjhrHwdzTf7DydjkU6+BXuNRj
        olFICeYmhrwK5CXCDdfaRc+Ii2391g37xjqohHCbXtJlt+/xrJxxLixwCVTiphp+dkUecbocsAEey
        IF7E+nwAm/fu5hSCjedIO2vxEJ+ueSTXGuiZjjEP0kIelrXDN1fZP6BoacUOkzQSlcacOBcnIk07X
        7NdKsVTw==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phloT-002lb2-0R;
        Thu, 30 Mar 2023 06:31:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 03/21] btrfs: move setting the buffer uptodate out of validate_extent_buffer
Date:   Thu, 30 Mar 2023 15:30:41 +0900
Message-Id: <20230330063059.1574380-4-hch@lst.de>
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

Setting the buffer uptodate in a function that is named as a validation
helper is a it confusing.  Move the call from validate_extent_buffer to
the one of its two callers that didn't already have a duplicate call
to set_extent_buffer_uptodate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3f57c41f41bf5f..20043c28c992dd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -590,9 +590,7 @@ static int validate_extent_buffer(struct extent_buffer *eb,
 	if (found_level > 0 && btrfs_check_node(eb))
 		ret = -EIO;
 
-	if (!ret)
-		set_extent_buffer_uptodate(eb);
-	else
+	if (ret)
 		btrfs_err(fs_info,
 		"read time tree block corruption detected on logical %llu mirror %u",
 			  eb->start, eb->read_mirror);
@@ -684,6 +682,8 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 		goto err;
 	}
 	ret = validate_extent_buffer(eb, &bbio->parent_check);
+	if (!ret)
+		set_extent_buffer_uptodate(eb);
 err:
 	if (ret) {
 		/*
-- 
2.39.2

