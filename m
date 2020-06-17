Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3B71FC9A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgFQJR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 05:17:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgFQJRX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 05:17:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CED50AE82;
        Wed, 17 Jun 2020 09:17:25 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Remove hole  check in prealloc_file_extent_cluster
Date:   Wed, 17 Jun 2020 12:10:42 +0300
Message-Id: <20200617091044.27846-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617091044.27846-1-nborisov@suse.com>
References: <20200617091044.27846-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Extents in the extent cluster are guaranteed to be contiguous as such
the hole check inside the loop can never trigger. In fact this check
was never functional since it was added in 18513091af948 which came
after the commit introducing clustered/contiguous extents: 0257bb82d21b.

Let's just remove it as it adds noise to the source.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/relocation.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 11d156995446..348985c8a559 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2604,9 +2604,6 @@ int prealloc_file_extent_cluster(struct inode *inode,
 
 		lock_extent(&BTRFS_I(inode)->io_tree, start, end);
 		num_bytes = end + 1 - start;
-		if (cur_offset < start)
-			btrfs_free_reserved_data_space_noquota(inode,
-						       start - cur_offset);
 		ret = btrfs_prealloc_file_range(inode, 0, start,
 						num_bytes, num_bytes,
 						end + 1, &alloc_hint);
-- 
2.17.1

