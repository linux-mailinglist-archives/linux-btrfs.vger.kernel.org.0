Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4562763BC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjGZP5Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjGZP5Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FE5100
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CF961B9C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3FAC433C7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387043;
        bh=3CvrCFtTtSApyEIMkrc/z16O0GuqEfTlsrH3h5jaWCQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rSMJ9vJCLJza5rYtS49bUO4Dfe2mCzIl3e6hS+RZeRiVxGwI0zTsUvwvOLFUU52vD
         icNFaAj2jK3sc7JVbd4bnxbcBZfEKsEcaGeR6W6VWGEJmziGPpabSgRzFfiLjYAPLB
         H9eBgJ9Gv9s4pHwQfTKBIQPlm/fuNYwMRtf1hEwO11aO/47QOSRPNReJ798rY7WOPS
         B4RNmAAlUWcgUcMpHQlTmXvInlZxjLEbY7psUhENm4clDGF1G47zCJGa3wdRzvRsSO
         BFnfOnQkJu+NKVrBZ3mR/JEZTEEQvuLvuIQXGH4NnzNqEYSYb9ZhPSemDHtFkEmvbf
         4r+Dm73VYNmSQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/17] btrfs: print available space across all block groups when dumping space info
Date:   Wed, 26 Jul 2023 16:57:02 +0100
Message-Id: <ec09a059f39fe8281bc46b96f1a3d86396f06015.1690383587.git.fdmanana@suse.com>
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

When dumping a space info also sum the available space for all block
groups and then print it. This often useful for debugging -ENOSPC
related problems.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 54d78e839c01..de0044283e29 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -510,6 +510,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 			   int dump_block_groups)
 {
 	struct btrfs_block_group *cache;
+	u64 total_avail = 0;
 	int index = 0;
 
 	spin_lock(&info->lock);
@@ -537,10 +538,13 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 			   avail, cache->ro ? "[readonly]" : "");
 		spin_unlock(&cache->lock);
 		btrfs_dump_free_space(cache, bytes);
+		total_avail += avail;
 	}
 	if (++index < BTRFS_NR_RAID_TYPES)
 		goto again;
 	up_read(&info->groups_sem);
+
+	btrfs_info(fs_info, "%llu bytes available across all block groups", total_avail);
 }
 
 static inline u64 calc_reclaim_items_nr(const struct btrfs_fs_info *fs_info,
-- 
2.34.1

