Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98E21251D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgGBNq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:46:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:45832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbgGBNq4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:46:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA4ADAD88;
        Thu,  2 Jul 2020 13:46:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/10] btrfs: Remove out label in btrfs_submit_compressed_read
Date:   Thu,  2 Jul 2020 16:46:50 +0300
Message-Id: <20200702134650.16550-11-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702134650.16550-1-nborisov@suse.com>
References: <20200702134650.16550-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/compression.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c28ee9fcd15d..f9a9ec51a1ec 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -678,8 +678,10 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 	compressed_len = em->block_len;
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
-	if (!cb)
-		goto out;
+	if (!cb) {
+		free_extent_map(em);
+		return BLK_STS_RESOURCE;
+	}
 
 	refcount_set(&cb->pending_bios, 0);
 	cb->errors = 0;
@@ -803,10 +805,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	}
 
 	return 0;
-
-out:
-	free_extent_map(em);
-	return ret;
 }
 
 /*
-- 
2.17.1

