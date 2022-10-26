Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EEE60D8DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 03:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiJZBgV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 21:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJZBgT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 21:36:19 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0D136A514;
        Tue, 25 Oct 2022 18:36:18 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id AD1D31E80C9B;
        Wed, 26 Oct 2022 09:34:52 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id No9tDtmXi6nw; Wed, 26 Oct 2022 09:34:50 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id CD88C1E80C8E;
        Wed, 26 Oct 2022 09:34:49 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH v3] btrfs: volumes: Increase bioc pointer check
Date:   Wed, 26 Oct 2022 09:36:11 +0800
Message-Id: <20221026013611.2900-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The __GFP_NOFAIL flag will cause memory to be allocated an infinite
number of times until the allocation is successful, but it is best to
use it only for very necessary code, and try not to use it.

The alloc_btrfs_io_context function looks a little closer to normal
(excuse my analysis), but I think we can remove __GFP_NOFAIL from it and
add a bioc pointer allocation check that returns NULL if the allocation
fails.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 v2: Add annotation vocabulary modify, remove __GFP_NOFAIL flag.
 v3: Modifying the Description.

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

