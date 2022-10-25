Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BCB60CA67
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiJYKxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiJYKxA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 06:53:00 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E7008E790;
        Tue, 25 Oct 2022 03:52:59 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 22C051E80C8E;
        Tue, 25 Oct 2022 18:51:37 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7u1RwzFhtnfz; Tue, 25 Oct 2022 18:51:34 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 43DE61E80C82;
        Tue, 25 Oct 2022 18:51:34 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     quwenruo.btrfs@gmx.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Li zeming <zeming@nfschina.com>
Subject: [PATCH v2] btrfs: volumes: Increase bioc pointer check
Date:   Tue, 25 Oct 2022 18:52:44 +0800
Message-Id: <20221025105244.5212-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch has the following changes:
1. Modify "is returned" in the comments to "should be returned".
2. Remove the __GFP_NOFAIL flag from the kzalloc function, which returns
NULL if kzalloc fails to allocate memory for bioc.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Li zeming <zeming@nfschina.com>
---
 v2: Add annotation vocabulary modify, remove __GFP_NOFAIL flag.

 fs/btrfs/volumes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 064ab2a79c80..b8d901f58995 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5891,7 +5891,9 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 		 * and the stripes.
 		 */
 		sizeof(u64) * (total_stripes),
-		GFP_NOFS|__GFP_NOFAIL);
+		GFP_NOFS);
+	if (!bioc)
+		return NULL;
 
 	atomic_set(&bioc->error, 0);
 	refcount_set(&bioc->refs, 1);
@@ -6071,7 +6073,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
  * array of stripes.
  * For READ, it also needs to be supported using the same mirror number.
  *
- * If the requested block is not left of the left cursor, EIO is returned. This
+ * If the requested block is not left of the left cursor, EIO should be returned. This
  * can happen because btrfs_num_copies() returns one more in the dev-replace
  * case.
  */
-- 
2.18.2

