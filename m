Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E69B6FB355
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjEHO6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjEHO6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 10:58:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE4A3
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+mdXbOY2x3pJBV86qK/GMt0Wc7SuGlS+Wcf+r6ukRXQ=; b=Guhe2rm2Df5H9XGke+fI5kiAz5
        7Vm6gKkfmp0G9ceugMuvBLmQMd6LN1uG+UoOndsg0cwrzV0bv0rGYjsK7GiBfLR+Er/kCwYZFThMd
        M9DquOvhh1I25uFDya76Rss0s6SreZ8zticfp9zXFGM08u+hvSuDzgExGscjrqeDsIa4T7PfGHKQ0
        ogs6xQ58ym2fKVQwXynGvctS+3EAw4VhF3gKbqGaLsJ4KvFzB8wvAnCB3dXEq0MZ4uGOozPtEHiI/
        Yo3bPoD3tGhYqlwSYaL06Q5Kg/9AFJDkDO70fBq7TozRUB4beVkN2MD8z2CSVyMtnw2i5OxiU6vRX
        fJOTXbAA==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw2K1-000ogO-0B;
        Mon, 08 May 2023 14:58:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Subject: [PATCH 1/3] btrfs: zero the buffer before marking it dirty in btrfs_redirty_list_add
Date:   Mon,  8 May 2023 07:58:37 -0700
Message-Id: <20230508145839.43725-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508145839.43725-1-hch@lst.de>
References: <20230508145839.43725-1-hch@lst.de>
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

btrfs_redirty_list_add zeroes the buffer data and sets the
EXTENT_BUFFER_NO_CHECK to make sure writeback is fine with a bogus
header.  But it does that after already marking the buffer dirty, which
means that writeback could already be looking at the buffer.

Switch the order of operations around so that the buffer is only marked
dirty when we're ready to write it.

Fixes: d3575156f662 ("btrfs: zoned: redirty released extent buffers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e3fe02aae641f3..7095cfca2fdde1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1610,11 +1610,11 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	    !list_empty(&eb->release_list))
 		return;
 
+	memzero_extent_buffer(eb, 0, eb->len);
+	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
 			       eb->start + eb->len - 1, EXTENT_DIRTY);
-	memzero_extent_buffer(eb, 0, eb->len);
-	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 
 	spin_lock(&trans->releasing_ebs_lock);
 	list_add_tail(&eb->release_list, &trans->releasing_ebs);
-- 
2.39.2

