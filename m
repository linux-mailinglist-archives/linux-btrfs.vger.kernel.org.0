Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB873F446
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 08:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjF0GNg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 02:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjF0GNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 02:13:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDF310DA
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o2cFYyiL3HaMeykVXU+lwBsbQy/VmIS14nCqZ4QI3B0=; b=tzaxlJB/VVZKo6Jykb4RuIOn66
        zQONephggy58+veooeGMPsU8bjpDFrC99rz+Atg7sUuFaNSXQSc1CmbT4MQcaqRvo68EWhTUqnWi8
        g0NieNV3gFo3HgV8cJIApNgG9nx8bkcV30pNV6H9K7xLgERww3bTqYgfMNQnK5UN3vCdHZfmWZWgp
        e4FtsBGsnB4Z11Pkpq4H+RcxjV62MHIj81/1CVBhxncli989ETHsm2xkhnQ3/GxscBhd7MuQkxLbe
        3fTZm7geDs/bjzQI61A95oH6joRBQzknRpNKSto9bD09OPszOwnXJAmZS6QxTQmJl3iETXv3ZaJJb
        xFO73J3w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qE1xF-00C5Ig-1M;
        Tue, 27 Jun 2023 06:13:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: simplify the no-bioc fast path condition in btrfs_map_block
Date:   Tue, 27 Jun 2023 08:13:24 +0200
Message-Id: <20230627061324.85216-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627061324.85216-1-hch@lst.de>
References: <20230627061324.85216-1-hch@lst.de>
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

nr_alloc_stripes can't be one if we are writing to a replacement device,
as it is incremented for that case right above.  Remove the duplicate
checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0d386ed44279ce..4907ed9809109d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6402,9 +6402,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * I/O context structure.
 	 */
 	if (smap && num_alloc_stripes == 1 &&
-	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
-	    (op == BTRFS_MAP_READ || !dev_replace_is_ongoing ||
-	     !dev_replace->tgtdev)) {
+	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)) {
 		set_io_stripe(smap, map, stripe_index, stripe_offset, stripe_nr);
 		if (mirror_num_ret)
 			*mirror_num_ret = mirror_num;
-- 
2.39.2

