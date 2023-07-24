Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255575F9B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjGXOWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGXOWr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:22:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A3CF
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jgeJ4CUi9vRUabJkqpzFSJAbNDBwazU6jwUOiaI5sFk=; b=oxbMsu4QpTPtN5sppEny45UCC5
        Vqn0bO9QCA/G+MY+1R0uswRmVZCzt//0tSm3zXcOGIe/yuuumQ3M52jn6q2ergfiLSystHOKekRKd
        7b2vOhvtebBM98ypLC0b5ShT8LxlcNHx9rYnKJbzuipoIe//TpPGcogJ7xadP3LtKz6fDBTS4Nt9y
        CQ6itnjj9lxSD/9wK0QB4O4VcAKhynf/fcDqG14f0tByAecLfPTHbN2tnNE1QoScbLHrrP/fhtwZ4
        DMoBtLpPutCkZxg9X+Om38exLlibVRNJO7ES5fxBkAwwIQWt4wngKyQ5UDQfUsVUCYNo03pmDtsHX
        4xiDLGUQ==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwSS-004b9l-0x;
        Mon, 24 Jul 2023 14:22:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: move the !zoned assert into run_delalloc_cow
Date:   Mon, 24 Jul 2023 07:22:41 -0700
Message-Id: <20230724142243.5742-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724142243.5742-1-hch@lst.de>
References: <20230724142243.5742-1-hch@lst.de>
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

Having the assert in the actual helper documents the pre-conditions
much better than having it in the caller, so move it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2d465b50c228ed..92182e0d27fdb5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1978,6 +1978,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	u64 ino = btrfs_ino(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
 
+	/*
+	 * Normally on a zoned device we're only doing COW writes, but in case
+	 * of relocation on a zoned filesystem serializes I/O so that we're only
+	 * writing sequentially and can end up here as well.
+	 */
+	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		goto error;
@@ -2257,14 +2264,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		 start >= page_offset(locked_page) + PAGE_SIZE));
 
 	if (should_nocow(inode, start, end)) {
-		/*
-		 * Normally on a zoned device we're only doing COW writes, but
-		 * in case of relocation on a zoned filesystem we have taken
-		 * precaution, that we're only writing sequentially. It's safe
-		 * to use run_delalloc_nocow() here, like for  regular
-		 * preallocated inodes.
-		 */
-		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));
 		ret = run_delalloc_nocow(inode, locked_page, start, end);
 		goto out;
 	}
-- 
2.39.2

