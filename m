Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3D703DA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245079AbjEOTXb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 15:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245012AbjEOTX2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 15:23:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4321437E
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NnEwKH9aBFlqdZe7W0mRyWUjX0YkIFs8Wkrn/e36yYE=; b=Yyg3O/iXO8MGEVkIdepbS0PkbG
        sW65t44dLCHWTAIJZCPNnol7FV57nMMERFLKbJYviBcSzptt5GWZNMRKgluovRoQ9yW+j0qStd2NL
        TdCQnehw8e64eMTzEbP8KeeGzLvb7wj607anEQ/dQ6kR1kkHqz3EmnB8oN6l5CY0/Z/nnDseneIPE
        WlzWjSLj40BlTbyPKShUBooICq4kc8odwiChhf3vcojGy5cwXHk3AD9ZTbOygdQMz5u/yfT9DmUxa
        8d3q1r3jtJ1CtT36izjoLvFDPVC8o3oHGiIBkxle17KMLOQ0mpY3GpoXHDTUIdJSWjTNZy918G6dE
        Gug+Eehw==;
Received: from [2001:4bb8:188:2249:ad42:acf3:6731:a041] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pydmv-003HGq-2I;
        Mon, 15 May 2023 19:23:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: directly wait for buffer writeback completion in btrfs_wait_buffers
Date:   Mon, 15 May 2023 21:22:53 +0200
Message-Id: <20230515192256.29006-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515192256.29006-1-hch@lst.de>
References: <20230515192256.29006-1-hch@lst.de>
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

Don't bother to got to filemap_fdatawait_range to look up each page in an
extent_buffer and then wait for writeback completion on each page, but
instead just call wait_on_extent_buffer_writeback on the buffer.  All
write errors are propagated through the EXTENT_BUFFER_WRITE_ERR bit on
the extent_buffer itself, so there is no need to check for per-page
errors either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_buffer.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_buffer.c b/fs/btrfs/extent_buffer.c
index d20fc0d113968f..70a6a5f2e0e0a8 100644
--- a/fs/btrfs/extent_buffer.c
+++ b/fs/btrfs/extent_buffer.c
@@ -63,19 +63,15 @@ int btrfs_write_buffers(struct btrfs_fs_info *fs_info, struct list_head *list)
 
 int btrfs_wait_buffers(struct btrfs_fs_info *fs_info, struct list_head *list)
 {
-	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct dirty_buffer *db;
-	int werr = 0, err;
+	int werr = 0;
 
 	while ((db = list_first_entry_or_null(list, struct dirty_buffer,
 			wb_entry))) {
 		list_del_init(&db->wb_entry);
 
-		err = filemap_fdatawait_range(mapping, db->eb->start,
-					      db->eb->start + db->eb->len - 1);
-		if (err)
-			werr = err;
-		if (!werr && test_bit(EXTENT_BUFFER_WRITE_ERR, &db->eb->bflags))
+		wait_on_extent_buffer_writeback(db->eb);
+		if (test_bit(EXTENT_BUFFER_WRITE_ERR, &db->eb->bflags))
 			werr = -EIO;
 		free_extent_buffer(db->eb);
 		kfree(db);
-- 
2.39.2

