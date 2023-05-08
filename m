Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB69B6FB4C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjEHQJO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjEHQI6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C6865B5
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=e7/Uo8pet6CDs868vn74KDVtUPHYQqK7Fce+4jiBIj4=; b=bL1vYNdIstAVzx7aPbwxc8eFc0
        LkPbmLqRLmTq7iqxq8SZzvUGzFDteJnKg8zplMRrPF6OrWW9nliG5EjP9uejaPMorSenqOZDjypH2
        8lM6PFbSfHkEvea91y805ZN8GpuqZt49l71rV+fW6PQzEXivEzA32yEA1/wK2I1v1FdfWjCNo6W5o
        N88jX0EAjnXtzc+eY3bGrgWoeFWO37hULtP6QG6vdoq0AkuS+yAVu0/I1qb+4sGSjGWBmvGXK6ONE
        5Rv/JRGQ6Clbn1yM0yD93k8tMbYazEqqnTf4Oo9nUtGPt8cSnma59LoItc7myPrx25QeNFnAh/asT
        3YQajfJQ==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pz-000w4G-1s;
        Mon, 08 May 2023 16:08:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 18/21] btrfs: use btrfs_finish_ordered_extent to complete compressed writes
Date:   Mon,  8 May 2023 09:08:40 -0700
Message-Id: <20230508160843.133013-19-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
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

Use the btrfs_finish_ordered_extent helper to complete compressed writes
using the bbio->ordered pointer instead of requiring an rbtree lookup
in the otherwise equivalent btrfs_mark_ordered_io_finished called from
btrfs_writepage_endio_finish_ordered.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a3f8416125a8c1..222cd998807838 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -226,13 +226,8 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
 	struct compressed_bio *cb =
 		container_of(work, struct compressed_bio, write_end_work);
 
-	/*
-	 * Ok, we're the last bio for this extent, step one is to call back
-	 * into the FS and do all the end_io operations.
-	 */
-	btrfs_writepage_endio_finish_ordered(cb->bbio.inode, NULL,
-			cb->start, cb->start + cb->len - 1,
-			cb->bbio.bio.bi_status == BLK_STS_OK);
+	btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start, cb->len,
+				    cb->bbio.bio.bi_status == BLK_STS_OK);
 
 	if (cb->writeback)
 		end_compressed_writeback(cb);
-- 
2.39.2

