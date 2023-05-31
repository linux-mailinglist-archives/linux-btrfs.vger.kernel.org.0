Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C018717933
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjEaH4h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjEaH4T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:56:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F5B122
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yKzK/4yZHJFgL+/YkWB6teXMQul5lumESK917lHForo=; b=BznhA/lNYxUo5Y4va1OnSY/061
        m3DV868rTdraps0/FaZvVEYLWi06L7zlulHLvEMy/PAMUuHYxI8z2b2HtiMHki5nZsvVwtY9g81ha
        asHxl82hIa2H1/+B4sxzHzMCaHVSVt3XmcM6Hxb5/05VJzRbycZWV9j1AMkkvAthilMRHdbuXbxfY
        c+QLvgg+qhcIw8joqX7yVlMNL/qBDYJkK7hELrUzR2K9rLtZ1rSo6UHY4vfZ51OX/W3+9dWcWMUpB
        JkMeHubE7qrVFAHoTmPeYzHvFK2lXnrKCNE7Q8n7cpbnkDNPLPFdQbu4IWD1/YedNhFv4Xwh/P6XT
        O2kgWzHA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Gff-00GWz9-13;
        Wed, 31 May 2023 07:55:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 17/17] btrfs: use btrfs_finish_ordered_extent to complete buffered writes
Date:   Wed, 31 May 2023 09:54:10 +0200
Message-Id: <20230531075410.480499-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
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

Use the btrfs_finish_ordered_extent helper to complete compressed writes
using the bbio->ordered pointer instead of requiring an rbtree lookup
in the otherwise equivalent btrfs_mark_ordered_io_finished called from
btrfs_writepage_endio_finish_ordered.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 08c46de4d712da..c3ec2441466647 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -526,8 +526,8 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 		"incomplete page write with offset %u and length %u",
 				   bvec->bv_offset, bvec->bv_len);
 
-		btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), page, start,
-						     start + len - 1, !error);
+		btrfs_finish_ordered_extent(bbio->ordered, page, start, len,
+					    !error);
 		if (error) {
 			btrfs_page_clear_uptodate(fs_info, page, start, len);
 			mapping_set_error(page->mapping, error);
-- 
2.39.2

