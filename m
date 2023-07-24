Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200A175F843
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 15:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjGXN1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjGXN1T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 09:27:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB8FE
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GwjONCJn3D5Zd2JMFVM7WYrxTZJ2bfVUbOKNfPUMpzE=; b=bapi2nk5WhTpnfadRxtDOp6jWd
        W3RscPHiS8myVXKexb4EqsEIHUYJ4jkaxbk1ei5zeJpHF9gFEsaCbrPcnumTPqbmTIJ6U218XAw1q
        fnstPXpAbmFco+tiLULyIOcI1IfE4NY23n4zFY0B7WwOrIfK//BF3TPKejjNQWlpZNZl3SSvMtl2u
        wR9RQjw9zzk5nmcx0WOSGvUWEaxZr1ZENgF9MvUIZSGyj1YLirhvgNjGAZrVtgHbsvh9lmWMamj8f
        WqL41K9yZZhFGkoQuhY1W0rsTS3w71f+XPi71kHcoOfo9psSC42JEHO6C6Rgyhy93qSDbTndbouv/
        XaQTwqVA==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNvaZ-004RMJ-1H;
        Mon, 24 Jul 2023 13:27:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs: remove the call to btrfs_mark_ordered_io_finished in btrfs_writepage_fixup_worker
Date:   Mon, 24 Jul 2023 06:27:00 -0700
Message-Id: <20230724132701.816771-9-hch@lst.de>
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

If btrfs_writepage_fixup_worker is called for a range that is
covered by and ordered_extent, but which doesn't have the PageOrdered
bit set, that means the ordered_extent is either for a pending direct
I/O, or for a buffered writeback in the final stages of I/O completion.

In either case it is now owned by the calling context, and should
never be completed by it.

Fixes: 87826df0ec36 ("btrfs: delalloc for page dirtied out-of-band in fixup worker")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 84c8c51e20478c..0d33bff5ca176f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2798,8 +2798,6 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		 * to reflect the errors and clean the page.
 		 */
 		mapping_set_error(page->mapping, ret);
-		btrfs_mark_ordered_io_finished(inode, page, page_start,
-					       PAGE_SIZE, !ret);
 		btrfs_page_clear_uptodate(fs_info, page, page_start, PAGE_SIZE);
 		clear_page_dirty_for_io(page);
 	}
-- 
2.39.2

