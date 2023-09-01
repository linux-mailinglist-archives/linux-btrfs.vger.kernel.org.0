Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4FD78F76A
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Sep 2023 05:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjIADSc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Aug 2023 23:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjIADSa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Aug 2023 23:18:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89DE7C
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Aug 2023 20:18:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso1276964b3a.1
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Aug 2023 20:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693538307; x=1694143107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNTe1gxC/LTmPc4iCRTmyEq0tl6z8FO5NISj6FN+iro=;
        b=NQKjkHMpRZqZwg9dJWABqE715ogVuYR54aaTE2VOWxC+LNOFPpfbgqDE4Uv1UfqU58
         G/nOjYG8gg8gFJr4utYIT4V98LZ1rVba50V0oulREz7Q5eHljiSngpurJ2dzijUdL8fP
         Kd3Xkdo1qWQY+0FDxK02MseOo1MwjURSUD+7DPBevJLie3+sIMMPZhsDOOMZMm6EV3us
         y0nHhYJAaE3LU/9p70KT05BY/iD69QKvhid6gm5yO/+5VBBEyvO21WGjplEORqPUZhnL
         NgELS5aSxCjVZQiSfr4uephw331qdsV7rx5Py80ZP2abqXClV+tN9vVJvg4bmswBfZKr
         6VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693538307; x=1694143107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNTe1gxC/LTmPc4iCRTmyEq0tl6z8FO5NISj6FN+iro=;
        b=MbO0GAriW7GUab/Bi4DSYUZFVFv055jt9t5sdxGAMkrs38qjtfDl6guu501ah5Pna2
         YZ3Wneinm9drzUMIQMJ6sW9WOToqgE4/4qb6I5om//qbUPubJ5JdizroqDg9Zpbw/j7o
         EeXHhOBK9e5tYh5DDJZN680Q+K+97n/P6TyOHDIauVpKIgVJF3t3LBM/6aGL5kfUr5Pg
         o3KG6rhLBiAoqSQ3PsM1fDWl8JsDmWHVdOL8ZsepPujrWCwrtnzXgpvw8H4qzVte16xS
         rXe4lDXj2cHH16DD8TcIKevBNDndMMgeCcg0lIziawxNDLi7f6y2mwXgJtZTKPKQG3rg
         BnoA==
X-Gm-Message-State: AOJu0YzpdfbJRyf9t2/uf1Gs+Bfo+3L9KFzdY52YZPvzyMMul4WwYxeH
        2rjsIdkvaM30oPKoYWERr3vnbQ==
X-Google-Smtp-Source: AGHT+IGnFkgFKFA6IKhRQTOd2NkrSOCI1hsoOl9dX9Q+FTM0gSS0ewGr5R7/GrJrhvjz3AmmRLocLg==
X-Received: by 2002:a05:6a21:272a:b0:14b:7d8b:cbaf with SMTP id rm42-20020a056a21272a00b0014b7d8bcbafmr1284911pzb.57.1693538306870;
        Thu, 31 Aug 2023 20:18:26 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001bb9bc8d232sm1915293pli.61.2023.08.31.20.18.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Aug 2023 20:18:26 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] btrfs: remove btree_dirty_folio() inside DEBUG
Date:   Fri,  1 Sep 2023 11:18:17 +0800
Message-Id: <20230901031817.93630-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the DEBUG compilation option is enabled (KCFLAGS=-DDEBUG),
the following compilation error will occur:
fs/btrfs/disk-io.c: In function ‘btree_dirty_folio’:
fs/btrfs/disk-io.c:538:16: error: ‘struct btrfs_subpage’ has no member named ‘dirty_bitmap’
  ASSERT(subpage->dirty_bitmap);
                ^~
fs/btrfs/messages.h:181:29: note: in definition of macro ‘ASSERT’
 #define ASSERT(expr) (void)(expr)
                             ^~~~
fs/btrfs/disk-io.c:539:19: error: ‘BTRFS_SUBPAGE_BITMAP_SIZE’ undeclared (first use in this function); did you mean ‘BTRFS_FREE_SPACE_BITMAP_SIZE’?
  while (cur_bit < BTRFS_SUBPAGE_BITMAP_SIZE) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
                   BTRFS_FREE_SPACE_BITMAP_SIZE
fs/btrfs/disk-io.c:539:19: note: each undeclared identifier is reported only once for each function it appears in
fs/btrfs/disk-io.c:545:22: error: ‘struct btrfs_subpage’ has no member named ‘dirty_bitmap’
   if (!(tmp & subpage->dirty_bitmap)) {
                      ^~

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 fs/btrfs/disk-io.c | 52 +---------------------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0a96ea8c1d3a..f0252c70233a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -515,62 +515,12 @@ static void btree_invalidate_folio(struct folio *folio, size_t offset,
 	}
 }
 
-#ifdef DEBUG
-static bool btree_dirty_folio(struct address_space *mapping,
-		struct folio *folio)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(mapping->host->i_sb);
-	struct btrfs_subpage *subpage;
-	struct extent_buffer *eb;
-	int cur_bit = 0;
-	u64 page_start = folio_pos(folio);
-
-	if (fs_info->sectorsize == PAGE_SIZE) {
-		eb = folio_get_private(folio);
-		BUG_ON(!eb);
-		BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
-		BUG_ON(!atomic_read(&eb->refs));
-		btrfs_assert_tree_write_locked(eb);
-		return filemap_dirty_folio(mapping, folio);
-	}
-	subpage = folio_get_private(folio);
-
-	ASSERT(subpage->dirty_bitmap);
-	while (cur_bit < BTRFS_SUBPAGE_BITMAP_SIZE) {
-		unsigned long flags;
-		u64 cur;
-		u16 tmp = (1 << cur_bit);
-
-		spin_lock_irqsave(&subpage->lock, flags);
-		if (!(tmp & subpage->dirty_bitmap)) {
-			spin_unlock_irqrestore(&subpage->lock, flags);
-			cur_bit++;
-			continue;
-		}
-		spin_unlock_irqrestore(&subpage->lock, flags);
-		cur = page_start + cur_bit * fs_info->sectorsize;
-
-		eb = find_extent_buffer(fs_info, cur);
-		ASSERT(eb);
-		ASSERT(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
-		ASSERT(atomic_read(&eb->refs));
-		btrfs_assert_tree_write_locked(eb);
-		free_extent_buffer(eb);
-
-		cur_bit += (fs_info->nodesize >> fs_info->sectorsize_bits);
-	}
-	return filemap_dirty_folio(mapping, folio);
-}
-#else
-#define btree_dirty_folio filemap_dirty_folio
-#endif
-
 static const struct address_space_operations btree_aops = {
 	.writepages	= btree_writepages,
 	.release_folio	= btree_release_folio,
 	.invalidate_folio = btree_invalidate_folio,
 	.migrate_folio	= btree_migrate_folio,
-	.dirty_folio	= btree_dirty_folio,
+	.dirty_folio	= filemap_dirty_folio,
 };
 
 struct extent_buffer *btrfs_find_create_tree_block(
-- 
2.20.1

