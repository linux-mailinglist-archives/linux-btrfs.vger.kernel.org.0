Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183CA6F5AF9
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjECPZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjECPYz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:24:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71B59F9
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MUp/VGWk63Ke5NGUfu84IC+tO6Ch4/K9lCMcWFxn/2g=; b=UTNSc1r1XNT5I+VTM762N/TV13
        5Cu+LWER77vv60X401POIZA6pY7uHkxPJQ/5pfbu0lN/A17ceJnFP01Un9vN7/p+g0peDiE/5Hnbl
        K2UQ+07I6Uw+KMLvBI1aR4Ktf0EZP7HpX/zEgURCvLydsX4m3UjQA1UkYOe9neg80mJg6Tm6U268K
        V4jDqLvCKJMpykEwQ0PlKmVaK2KPiVXKA9PgDUbSNpUgi4ocW/I+pUTDsgUqwZy2QF9FLWJP2BFmw
        qctUr93dOFhI6i7LQMN58USIkFe3oFWI9Qi22fnivyBZoxvPEwHkmx15xEnTHB/QXBWS9VvvfVJxk
        gglzD6aQ==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puELa-004xcx-1P;
        Wed, 03 May 2023 15:24:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 02/21] btrfs: fix sub-page error handling in end_bio_subpage_eb_writepage
Date:   Wed,  3 May 2023 17:24:22 +0200
Message-Id: <20230503152441.1141019-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
References: <20230503152441.1141019-1-hch@lst.de>
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

Call btrfs_page_clear_uptodate instead of ClearPageUptodate to properly
manage the uptodate bit for the subpage case.

Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2e0ca7e8138295..07ce8199960b6a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1915,7 +1915,8 @@ static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
 
 			if (bio->bi_status ||
 			    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
-				ClearPageUptodate(page);
+				btrfs_page_clear_uptodate(fs_info, page,
+							  eb->start, eb->len);
 				set_btree_ioerr(page, eb);
 			}
 
-- 
2.39.2

