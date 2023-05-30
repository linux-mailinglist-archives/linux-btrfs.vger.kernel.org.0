Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C07715506
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 07:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjE3Fke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 01:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjE3Fj6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 01:39:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E620137
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6/NXqNNA8nBtoVCElpGBC5tvCWHnTMrZNH6U3xX5FKc=; b=H9PwFmHV5fkpk1q+7ZIisshtZX
        P4aTDmLFv5aXH0ftr/LT3UaZVekMxFi8VVJR9x8+cy6tsNTicTmnTdqGHzllmYuYwA3g9MspcM7aS
        2A7ISBUf1HTmpKDIIdENdyO71ymR74cNj2w1usu9bYvjPRHf7JaXyJDiFYTaKaNA1rmPlxZwONr64
        8BnjwjR8e8us0gSdKnIL5aJM9Ho6o3gj7M6lvw4++58dm9vfaW3xkYr9eN9z0TSh8pE+hccwipGTL
        Ww35TgQRYmT75+5eAFtNl3Br/l/ZFb/CYeRXzoY2eLWPMZOToInoAllADjJTXfhNqIa+7vq1E71SU
        7FivahYA==;
Received: from 089144192089.atnat0001.highway.a1.net ([89.144.192.89] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q3s55-00CUXk-23;
        Tue, 30 May 2023 05:39:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add back cgroup writeback support for metadata
Date:   Tue, 30 May 2023 07:39:36 +0200
Message-Id: <20230530053936.104984-1-hch@lst.de>
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

Commit c211fd861077 ("btrfs: don't use btrfs_bio_ctrl for extent buffer
writing") removed support for cgroup association for metadata writeback.
While cgroup interaction with metadata is somewhat questionable and not
done by other file systems, any kind of change to this behaviour should
not happen silently and under the hood, so bring it back.

Fixes: c211fd861077 ("btrfs: don't use btrfs_bio_ctrl for extent buffer writing")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bbf212c7a43f79..87ee376b3cc812 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1820,6 +1820,8 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
 			       eb->fs_info, extent_buffer_write_end_io, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
+	bio_set_dev(&bbio->bio, fs_info->fs_devices->latest_dev->bdev);
+	wbc_init_bio(wbc, &bbio->bio);
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
 	if (fs_info->nodesize < PAGE_SIZE) {
@@ -1833,6 +1835,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 			wbc->nr_to_write--;
 		}
 		__bio_add_page(&bbio->bio, p, eb->len, eb->start - page_offset(p));
+		wbc_account_cgroup_owner(wbc, p, eb->len);
 		unlock_page(p);
 	} else {
 		for (int i = 0; i < num_extent_pages(eb); i++) {
@@ -1842,6 +1845,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 			clear_page_dirty_for_io(p);
 			set_page_writeback(p);
 			__bio_add_page(&bbio->bio, p, PAGE_SIZE, 0);
+			wbc_account_cgroup_owner(wbc, p, PAGE_SIZE);
 			wbc->nr_to_write--;
 			unlock_page(p);
 		}
-- 
2.39.2

