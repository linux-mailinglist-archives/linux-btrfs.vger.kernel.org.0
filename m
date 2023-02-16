Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB63699A22
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 17:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBPQeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 11:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBPQet (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 11:34:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DFEDC
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 08:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EPXV0jNN3+sAM9bkBB3MIiKxWTR4yh4ehCyU8esBYpM=; b=KwRVTsevdGMkgvdA7oda2u84NX
        iV3X7cJxitBD4BZ4Y8fpWJ6CKROcHXzIxOLF+Lm5BykWNsT88TCpalzBd8q1QQ9uZJdCOKBuA2FZc
        aU/n3ee5en3CAhX2RNS40ck4Q8kP8+ZM6Ig+kyisfs2lM7hCiuENP0JarGe9uwthsg7PB1mtV9/Qt
        MRwBtqlMG9fb+9GtP98Sq1dAABGwWlyyFjvAoEXXLL/du3UivbiSFFV9VfPiVUeiMlRcmLZIqF8Iz
        pl/qAnDLlaijBf0262neM1b98Uya3/lKy+Lql5TOjAe25gcu316utFbBAXy7RjY20/DUzJzLfVx4X
        FkY++bnw==;
Received: from [2001:4bb8:181:6771:37af:42b9:3236:81df] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pShDZ-00BCxI-8a; Thu, 16 Feb 2023 16:34:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/12] btrfs: remove a bogus submit_one_bio call in read_extent_buffer_subpage
Date:   Thu, 16 Feb 2023 17:34:27 +0100
Message-Id: <20230216163437.2370948-3-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216163437.2370948-1-hch@lst.de>
References: <20230216163437.2370948-1-hch@lst.de>
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

The first call to submit_one_bio call in read_extent_buffer_subpage is
for a btrfs_bio_ctrl structure that has just been initialized and thus
can't have a non-NULL bio, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b53486ed8804af..e9639128962c99 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4442,7 +4442,6 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
-	submit_one_bio(&bio_ctrl);
 	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
 				 eb->start, page, eb->len,
 				 eb->start - page_offset(page), 0);
-- 
2.39.1

