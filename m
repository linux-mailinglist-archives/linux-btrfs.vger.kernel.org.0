Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6528C6F5AF7
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjECPY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjECPYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:24:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCCE6A57
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jHutw3XFavXfGJ5JEbtG0TfkhCiRdWVUqlKVfNHC/RU=; b=RQsmbXJLkWWeUlFz2vnDNdpgp0
        2BSCrzEO/1maMuwsCguzeCoAem7VeL5pq6oOylPvXU7L2p4mO4lZiKcS13KMGlsF3VAT7bqs6pfUH
        cyMibXm4162FuBDjNPLNEqDNyZ5cPg/LHdNE0CrRz60zpD7u/A1nTBKa6qKdE0rSjbmsySWUzKz+y
        pNk6zP1nPFpXltmtPeayQdBuZ+1embLup1CvFgq2HXfoqTIoeF73Krncxn4GAJ9JAARZxD5XBsG9x
        j/ft4HJVvI6fUjBOR/W3li7iZiMyuTddWaY6KaXJ+EeI5lG/n58eSi3404AD3Mal1fcjg95wrfchJ
        fw3VOG4w==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puELX-004xcV-2Z;
        Wed, 03 May 2023 15:24:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 01/21] btrfs: mark extent_buffer_under_io static
Date:   Wed,  3 May 2023 17:24:21 +0200
Message-Id: <20230503152441.1141019-2-hch@lst.de>
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

extent_buffer_under_io is only used in extent_io.c, so mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/extent_io.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1adadd5d25ddb..2e0ca7e8138295 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3421,7 +3421,7 @@ static void __free_extent_buffer(struct extent_buffer *eb)
 	kmem_cache_free(extent_buffer_cache, eb);
 }
 
-int extent_buffer_under_io(const struct extent_buffer *eb)
+static int extent_buffer_under_io(const struct extent_buffer *eb)
 {
 	return (atomic_read(&eb->io_pages) ||
 		test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 4341ad978fb8e4..342412d37a7b4b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -265,7 +265,6 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 bool set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
-int extent_buffer_under_io(const struct extent_buffer *eb);
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
-- 
2.39.2

