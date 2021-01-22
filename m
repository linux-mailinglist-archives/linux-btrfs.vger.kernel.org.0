Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEDF2FFFC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbhAVKGM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:06:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:58350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbhAVKAh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 05:00:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4eVcACymSWLzPRBn/3/o05mNLkF6M/wexUv93+X/d0=;
        b=XhFUvYH+7H6V3oLPfuMB9ivehKu7kn3Vty3bpld4IPJH6e9QLrOPSFU6vQCuLAyhC/p0ka
        GV1JmCY85M95Vv4uTgVCd2RFEvXIoFtMi+I9PZG/IVye/YLY3cYhovqs4mb9GcvimMHiX2
        vI0iGSz/1au+lZVKKxd3Nfq4BqjoKDA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F262B7AC;
        Fri, 22 Jan 2021 09:58:08 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 07/14] btrfs: Document fs_info in btrfs_rmap_block
Date:   Fri, 22 Jan 2021 11:57:58 +0200
Message-Id: <20210122095805.620458-8-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122095805.620458-1-nborisov@suse.com>
References: <20210122095805.620458-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes fs/btrfs/block-group.c:1570: warning: Function parameter or member 'fs_info' not described in 'btrfs_rmap_block'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0886e81e5540..cd277c483777 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1553,7 +1553,9 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 }
 
 /**
- * btrfs_rmap_block - Map a physical disk address to a list of logical addresses
+ * Map a physical disk address to a list of logical addresses
+ *
+ * @fs_info:       the filesystem
  * @chunk_start:   logical address of block group
  * @physical:	   physical address to map to logical addresses
  * @logical:	   return array of logical addresses which map to @physical
-- 
2.25.1

