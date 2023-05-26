Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC6D7122DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbjEZJBY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 05:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242871AbjEZJBU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 05:01:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B7198
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1B+zJ+IojLsM6S4Z51Vx+bfXw6QeOhppV+M2hXaPUpE=; b=3gAn8X4r4wkJTi1ZOkCkB72EyM
        HP2/d8CNzd+TCiSNEPGPOYKSklu4zNbNvo5LihAPXDRJmzq9OedZYQcdJd/BQIjZSMoI3/Alf4D7L
        fC+58f8hQ8k5T8D812WtJNeEfPgvoGt8mbwmxBgF6h61e7MU1uNPzpw8BBhlbpUH0wH4qWytAu6fA
        fA4+CtTAjbeDxykcMe5tnonmuasCUGyVuJ22xJGLsrs3SsdFqSk5ewEOe540k7MFdMvfJFygUqUns
        QizX6HqMcRQ9b7c2grkCuooz2/8+22tuiHv8y+cZJAVU8l4KCyJtNA9G6dVwO3Pjqu6SKQDylPtDo
        ekc5HWNg==;
Received: from [85.235.16.11] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2TJw-001hxf-0y;
        Fri, 26 May 2023 09:01:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.com, josef@toxicpanda.com, clm@fb.com
Cc:     quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix the uptodate assert in btree_csum_one_bio
Date:   Fri, 26 May 2023 11:01:09 +0200
Message-Id: <20230526090109.1982022-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

btree_csum_one_bio needs to use the btrfs_page_test_uptodate helper
to check for uptodate status as the page might not be marked uptodate
for a sub-page size buffer.

Fixes: 5067444c99c3 ("btrfs: remove the extent_buffer lookup in btree block checksumming")
Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
---
 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c461a46ac6f207..36d6b8d4b2c1fa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -269,7 +269,8 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 
 	if (WARN_ON_ONCE(found_start != eb->start))
 		return BLK_STS_IOERR;
-	if (WARN_ON_ONCE(!PageUptodate(eb->pages[0])))
+	if (WARN_ON(!btrfs_page_test_uptodate(fs_info, eb->pages[0],
+					      eb->start, eb->len)))
 		return BLK_STS_IOERR;
 
 	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
-- 
2.39.2

