Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867AF27F935
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgJAF56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:57:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:40098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgJAF56 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:57:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEoxUABMqVRLswpNAFRpcjJgbPjxSsANud/cpgqWsUI=;
        b=QpIMO+RvuI3/6vHCjO3V98pDk5TjLuHxWfpX6fAX3T1Cs5spzz/xDFeJ9TDhNaabHyokvN
        CPUed8is+limE56PiU87/A5tRSU9TJ9JyXqU8oW1NOvkvEsPVK6rr8E1+bq0UO4jCOpU63
        REgK+ZnKtQdM33tFfdUkI8hiDAvsLwY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43DDFB31D
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 05:57:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9 03/12] btrfs: block-group: make link_block_group() to handle avail alloc bits
Date:   Thu,  1 Oct 2020 13:57:35 +0800
Message-Id: <20201001055744.103261-4-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001055744.103261-1-wqu@suse.com>
References: <20201001055744.103261-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we call link_block_group(), we also call set_avail_alloc_bits()
after that.

Thus we can merge the set_avail_alloc_bits() into link_block_group().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 831855c85419..cb6be9a3d1dc 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1771,6 +1771,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 
 static void link_block_group(struct btrfs_block_group *cache)
 {
+	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_space_info *space_info = cache->space_info;
 	int index = btrfs_bg_flags_to_raid_index(cache->flags);
 	bool first = false;
@@ -1783,6 +1784,8 @@ static void link_block_group(struct btrfs_block_group *cache)
 
 	if (first)
 		btrfs_sysfs_add_block_group_type(cache);
+
+	set_avail_alloc_bits(fs_info, cache->flags);
 }
 
 static struct btrfs_block_group *btrfs_create_block_group_cache(
@@ -1986,7 +1989,6 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 
 	link_block_group(cache);
 
-	set_avail_alloc_bits(info, cache->flags);
 	if (btrfs_chunk_readonly(info, cache->start)) {
 		inc_block_group_ro(cache, 1);
 	} else if (cache->used == 0) {
@@ -2196,7 +2198,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	trans->delayed_ref_updates++;
 	btrfs_update_delayed_refs_rsv(trans);
 
-	set_avail_alloc_bits(fs_info, type);
 	return 0;
 }
 
-- 
2.28.0

