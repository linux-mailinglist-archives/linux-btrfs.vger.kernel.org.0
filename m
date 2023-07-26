Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA740763BBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjGZP5Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjGZP5X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EBF1FDA
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C61361AFE
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D4CC433C8
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387042;
        bh=ygQtzzAhD4wbTmkKEqiPTUVAgXJxc3fa4SpmUORcqpI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kEvaeTVhm7KwxsAO4uiRwWTC1oGpiVlg/fagWis//DNBP4cZTak5Crm3f1wI4JF92
         cC7jlhblSN7oqMakLIqEdTMZEjQZF7UOB1s7C0724iaZWgAOYIREAS+0HHq7O6S/UT
         azxOYXx8fWZ8pszTwJ99zDwe86fbUI3PfjsMePwwMACgu8I37UZQoPlKsImhO4q3cr
         NOFhH35tBaiz37AH/4iBVm94bdXr+A2FLYkCwHbJ78VeZBMnqLxLY4EZYCnlE9ry2o
         RaH5AqzMWIXbBRs9CjUpiNNTzHJtKIcoeu0Z/ZUy1ZQ8aMgzourzyFZgIZ9vR9yV+0
         b7IYhTFOuER4g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/17] btrfs: print available space for a block group when dumping a space info
Date:   Wed, 26 Jul 2023 16:57:01 +0100
Message-Id: <2744218996a0f0d663b61bd005a2911c2e2d8801.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When dumping a space info, we iterate over all its block groups and then
print their size and the amounts of bytes used, reserved, pinned, etc.
When debugging -ENOSPC problems it's also useful to know how much space
is available (free), so calculate that and print it as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ae12a8a9cd12..54d78e839c01 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -523,13 +523,18 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	down_read(&info->groups_sem);
 again:
 	list_for_each_entry(cache, &info->block_groups[index], list) {
+		u64 avail;
+
 		spin_lock(&cache->lock);
+		avail = cache->length - cache->used - cache->pinned -
+			cache->reserved - cache->delalloc_bytes -
+			cache->bytes_super - cache->zone_unusable;
 		btrfs_info(fs_info,
-"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu delalloc %llu super %llu zone_unusable %s",
+"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu delalloc %llu super %llu zone_unusable (%llu bytes available) %s",
 			   cache->start, cache->length, cache->used, cache->pinned,
 			   cache->reserved, cache->delalloc_bytes,
 			   cache->bytes_super, cache->zone_unusable,
-			   cache->ro ? "[readonly]" : "");
+			   avail, cache->ro ? "[readonly]" : "");
 		spin_unlock(&cache->lock);
 		btrfs_dump_free_space(cache, bytes);
 	}
-- 
2.34.1

