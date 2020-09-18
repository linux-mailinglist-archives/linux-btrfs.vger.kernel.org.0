Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF78B26FE9F
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 15:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgIRNes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 09:34:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:40956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgIRNeo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 09:34:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600436082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=0qaYJoq+FQ7iTUNj0F3LUI4KfLa2Ry3PFjExuFLQRDU=;
        b=QnDZc+0gt4kt99jPO6gwI8ZfFLQync2cIZf6qGjcHKRItURc7ZkPqY4CB2ELYgJXnTa+Li
        hKZnZDJM3DxAVOaXzJtuXFlL8dzKDIZivMrEkvbax47eO0p1dq4Fq6kQY/Vtl+UWrwUq7j
        w1eM8hiZOQejrw0SGNBjGJOYFNNngNg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7AFD3B1EA;
        Fri, 18 Sep 2020 13:35:16 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/7] btrfs: Don't opencode is_data_inode in end_bio_extent_readpage
Date:   Fri, 18 Sep 2020 16:34:36 +0300
Message-Id: <20200918133439.23187-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918133439.23187-1-nborisov@suse.com>
References: <20200918133439.23187-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the is_data_inode helper.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e976bd86600..26b002e2f3b3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2816,8 +2816,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		bool data_inode = btrfs_ino(BTRFS_I(inode))
-			!= BTRFS_BTREE_INODE_OBJECTID;
+		bool data_inode = is_data_inode(inode);
 
 		btrfs_debug(fs_info,
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
-- 
2.17.1

