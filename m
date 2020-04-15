Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D591AA2D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897091AbgDOLfy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 07:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897080AbgDOLfs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 07:35:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C37E21582;
        Wed, 15 Apr 2020 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950545;
        bh=cpi8xhq+oGMQDR0pcONOu5VnjZ2jS7IwZWsgpVsV+8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2au6HHe9HWrUtTc0mvZPdn4t8d79TEWsqEyuMuvcw8cRoPj1JQtZLEj+EoZlohwU
         tl0nY334ev120JfIvStASDXtJAUwVHsggvvpl0xv6mHPZPvdwQU8ahKz5QaqU1Zbuq
         ajowrhq6EPY5LqeJBsonk6Dvap4Js5FOFynFaWsY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 052/129] btrfs: add RCU locks around block group initialization
Date:   Wed, 15 Apr 2020 07:33:27 -0400
Message-Id: <20200415113445.11881-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

[ Upstream commit 29566c9c773456467933ee22bbca1c2b72a3506c ]

The space_info list is normally RCU protected and should be traversed
with rcu_read_lock held. There's a warning

  [29.104756] WARNING: suspicious RCU usage
  [29.105046] 5.6.0-rc4-next-20200305 #1 Not tainted
  [29.105231] -----------------------------
  [29.105401] fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!

pointing out that the locking is missing in btrfs_read_block_groups.
However this is not necessary as the list traversal happens at mount
time when there's no other thread potentially accessing the list.

To fix the warning and for consistency let's add the RCU lock/unlock,
the code won't be affected much as it's doing some lightweight
operations.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7f09147872dc7..c9a3bbc8c6afb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1987,6 +1987,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		btrfs_release_path(path);
 	}
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
 		if (!(btrfs_get_alloc_profile(info, space_info->flags) &
 		      (BTRFS_BLOCK_GROUP_RAID10 |
@@ -2007,6 +2008,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 				list)
 			inc_block_group_ro(cache, 1);
 	}
+	rcu_read_unlock();
 
 	btrfs_init_global_block_rsv(info);
 	ret = check_chunk_block_group_mappings(info);
-- 
2.20.1

