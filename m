Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBF3CFB4C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 15:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfJHN0U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 09:26:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:34750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730249AbfJHN0U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 09:26:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6A08B147;
        Tue,  8 Oct 2019 13:26:18 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: User assert to document transaction requirement
Date:   Tue,  8 Oct 2019 16:26:16 +0300
Message-Id: <20191008132616.18183-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Using an ASSERT in btrfs_pin_extent allows to more stringently observe
whether the function is called under a transaction or not.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5f4b0c4e22aa..59989ee64dbc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2589,15 +2589,14 @@ static int pin_down_extent(struct btrfs_block_group_cache *cache,
 			 bytenr + num_bytes - 1, GFP_NOFS | __GFP_NOFAIL);
 }
 
-/*
- * this function must be called within transaction
- */
 int btrfs_pin_extent(struct btrfs_fs_info *fs_info,
 		     u64 bytenr, u64 num_bytes, int reserved)
 {
 	struct btrfs_block_group_cache *cache;
 	int ret;
 
+	ASSERT(fs_info->running_transaction);
+
 	cache = btrfs_lookup_block_group(fs_info, bytenr);
 	BUG_ON(!cache); /* Logic error */
 
-- 
2.17.1

