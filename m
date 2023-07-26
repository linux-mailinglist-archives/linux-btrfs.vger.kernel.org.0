Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D409763BC0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjGZP5X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjGZP5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93382136
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA88F61A21
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92471C433C7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387041;
        bh=N5xEhTBBvdw+vV9C0+cXJDybHc7iTm+mPDZP5T5uuUs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JjWgjxY/aW6g8GMbZzZh3N0Wwpna6x8Kncr3ie0Y536KwgkLr5tt5wQCz7bvDwOff
         8BFtxc3gwsjoQZvOHrmDThA8++FT+05hvQNk4j/M3GPPmg1t5eQ+9S4D4nM90/WuyX
         GZicFvmTkNib/EdXogZ+S2FK2flWLJ9e7n3s6m/pS5Bv3Na+cr+lLTlLXrryGIV2Ip
         B3mnUR0Sr9VK1lEEHhEyrwywkDczK6EJPYecvzBU0UHeCu8SuYkxTVcP2d9LPzLL1X
         WBw3md04A6JO1I+F/XC9KQzbY/Ss3Y41F8Nz1Nut59BocXvRp6zsW1S+JnF7Nx4RAf
         9Uxn79Ae8EFjg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/17] btrfs: print block group super and delalloc bytes when dumping space info
Date:   Wed, 26 Jul 2023 16:57:00 +0100
Message-Id: <10c77455ed3cc49c334247cab26caf9c1479b322.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When dumping a space info's block groups, also print the number of bytes
used for super blocks and delalloc. This is often useful for debugging
-ENOSPC problems.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 75e7fa337e66..ae12a8a9cd12 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -525,10 +525,11 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	list_for_each_entry(cache, &info->block_groups[index], list) {
 		spin_lock(&cache->lock);
 		btrfs_info(fs_info,
-			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu zone_unusable %s",
-			cache->start, cache->length, cache->used, cache->pinned,
-			cache->reserved, cache->zone_unusable,
-			cache->ro ? "[readonly]" : "");
+"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu delalloc %llu super %llu zone_unusable %s",
+			   cache->start, cache->length, cache->used, cache->pinned,
+			   cache->reserved, cache->delalloc_bytes,
+			   cache->bytes_super, cache->zone_unusable,
+			   cache->ro ? "[readonly]" : "");
 		spin_unlock(&cache->lock);
 		btrfs_dump_free_space(cache, bytes);
 	}
-- 
2.34.1

