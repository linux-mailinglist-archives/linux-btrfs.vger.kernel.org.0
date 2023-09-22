Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69EE7AAFB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjIVKjf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjIVKj0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:39:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD2BAB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:39:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B92C433C9
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379160;
        bh=tRyYZUOi+3DivC3JjVadhyIxvmtxptGch0WtJowd2Ow=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WIpGzFUpKTmUEyise7mtNSyCzoN1fQJ4ysNfdjTeYZ5oAoOPVaNoRXzeOe8gmazOW
         PLUq7SfQhvEZIvY4YXnPZaYe4BKKAYfKAUUCbXJPM6oBau3BTfhRkRyAY2MGbhAWzx
         wcEKGk6gMiXa1xSS+UXranGqFmVwJzLTR3xM6hBIz0FXZR+6ZXBGjxrZUWM3zyPhps
         AMcMssVipqK3xPKBS8YT2JRn3Yp46xk9EL/uvNkvO9cKbd63JFW57kK9Aeqr+yVUOX
         oo/35pm5Sl5n3DCnWeqINN60lx4LB5KmEP8TGtVCCTll9nFcHGkvaytoupOcnQ+eQ6
         ssze8yBXAwjCQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: use extent_io_tree_release() to empty dirty log pages
Date:   Fri, 22 Sep 2023 11:39:08 +0100
Message-Id: <459c0d25abdfecdc7c57192fa656c6abda11af31.1695333278.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333278.git.fdmanana@suse.com>
References: <cover.1695333278.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When freeing a log tree, during a transaction commit, we clear its dirty
log pages io tree by calling clear_extent_bits() using a range from 0 to
(u64)-1. This will iterate the io tree's rbtree and call rb_erase() on
each node before freeing it, which will often trigger rebalance operations
on the rbtree. A better alternative it to use extent_io_tree_release(),
which will not do deletions and trigger rebalances.

So use extent_io_tree_release() instead of clear_extent_bits().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f4257be56bd3..8687c944451f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3207,8 +3207,7 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
-			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
+	extent_io_tree_release(&log->dirty_log_pages);
 	extent_io_tree_release(&log->log_csum_range);
 
 	btrfs_put_root(log);
-- 
2.40.1

