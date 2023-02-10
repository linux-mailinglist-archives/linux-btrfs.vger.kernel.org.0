Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7D569195D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 08:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBJHtU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 02:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBJHtT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 02:49:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3975BA4C
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 23:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nRQzHXVdAE2z6gRk9SiR8xCZNuD8sOy/blzfWqL2nek=; b=Xin0iZXDTeTtysN7XPpVfrn23O
        gFQY3lhhnZOi0/6bNllQyDhdxcvenNaSc7bEejHxIrtY32e9rLLq8cqZxj2btkFTStCG1lfpUkV/j
        PPxfokg8qO1cN4TbES9aB/v7BA8c2GvMrDp0qDbc9NZT3Jg5rftmgxPqdL/FdvsNF1TQrwUG/ESnS
        UYMFKkjhjgukCPpDViG9gpy1BOd8gGINyC/fY0uroOYM3FeG5IZdddaIKRF/aHk2zjSIaBrV3eR6v
        q2NdkGWepe73S+OpH6qEr+Wkec92YjG46iqXPJL/sPZ29qtvUubwk3cQzyev9Qh6QkWdTa9xWiHIL
        hdQ7vDWg==;
Received: from 213-147-164-133.nat.highway.webapn.at ([213.147.164.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQO9k-004fiy-Hc; Fri, 10 Feb 2023 07:49:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: don't clear ->mapping in btrfs_free_compressed_pages
Date:   Fri, 10 Feb 2023 08:48:40 +0100
Message-Id: <20230210074841.628201-8-hch@lst.de>
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

No one ever set ->mapping on these pages, so don't bother clearing it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ac9ffec5fc925d..0bbaccb1787080 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -163,12 +163,8 @@ static void btrfs_free_compressed_pages(struct compressed_bio *cb)
 {
 	unsigned int i;
 
-	for (i = 0; i < cb->nr_pages; i++) {
-		struct page *page = cb->compressed_pages[i];
-
-		page->mapping = NULL;
-		put_page(page);
-	}
+	for (i = 0; i < cb->nr_pages; i++)
+		put_page(cb->compressed_pages[i]);
 	kfree(cb->compressed_pages);
 }
 
-- 
2.39.1

