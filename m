Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BCE75F840
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 15:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjGXN1U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 09:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjGXN1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 09:27:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383A6E66
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8iPjpqgcm59PytEKER0uUQye3TSfrtezfdMzci1iUQo=; b=coFfqR/+ubYREyXhR3bA2LXlkS
        mmDUdXy1ZktilqKOZihspcD8F3m7UpNWgmv8PEBioeYkGwnIfQStfQJdUoFsWmsgAoFjnppUIaEaX
        S96AEVJ6x/TDFQmwieZmI7xNuYvVJZSfMiG2FudoRGazlwH4Kyq3X0kwmCqAfvXHcvWCXdzbTQEog
        fwZ84Z8WKWoab/6yVw1/JY9e1pD8R5WR+vTuZE9PDateuJnUNgCTfjRiVW/amR1Q4yBCfOKH8CrsI
        hJZOgf0mPAr7Xv3wdIHFy8sMdQ3bYDDScRxqctZKtKu/jSxkv3kLeioSBxjOFO/QptyKRQy0kV2hN
        qdWmi2Jg==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNvaX-004RLX-39;
        Mon, 24 Jul 2023 13:27:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/9] btrfs: don't stop integrity writeback too early
Date:   Mon, 24 Jul 2023 06:26:53 -0700
Message-Id: <20230724132701.816771-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724132701.816771-1-hch@lst.de>
References: <20230724132701.816771-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

extent_write_cache_pages stops writing pages as soon as nr_to_write hits
zero.  That is the right thing for opportunistic writeback, but incorrect
for data integrity writeback, which needs to ensure that no dirty pages
are left in the range.  Thus only stop the writeback for WB_SYNC_NONE
if nr_to_write hits 0.

This is a port of write_cache_pages changes in commit 05fe478dd04e
("mm: write_cache_pages integrity fix").

Note that I've only trigger the problem with other changes to the btrfs
writeback code, but this condition seems worthwhile fixing anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c0440a0988c9a8..231e620e6c497d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2098,7 +2098,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 * We have to make sure to honor the new nr_to_write
 			 * at any time
 			 */
-			nr_to_write_done = wbc->nr_to_write <= 0;
+			nr_to_write_done = wbc->sync_mode == WB_SYNC_NONE &&
+						wbc->nr_to_write <= 0;
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.39.2

