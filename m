Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55302FCFE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbhATMRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:17:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:37882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730335AbhATK10 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 05:27:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611138329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8ysQjbUZXJ82XPd3WjQwNk8GjbJPKMwaMFCBZO3QEw=;
        b=I6WR12RI2Si/td+NI4hxngExzUVTU/1JNR7yzluOLhdBbKyR5f5ub5k+8gJkEz5tycnolK
        4xaOiAvtQHgjdcy5bjwlAn8waXezObPCTN+12xPHs4DtnbRjAaKZk3DgWg1/+A4B4UfK9/
        F/VJTd8ftGTPafqf3BXyBWM3GP9ay3s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21F4BAFEF;
        Wed, 20 Jan 2021 10:25:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 05/14] btrfs: Improve parameter description for __btrfs_write_out_cache
Date:   Wed, 20 Jan 2021 12:25:17 +0200
Message-Id: <20210120102526.310486-6-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120102526.310486-1-nborisov@suse.com>
References: <20210120102526.310486-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes following W=1 warnings:
fs/btrfs/free-space-cache.c:1317: warning: Function parameter or member 'root' not described in '__btrfs_write_out_cache'
fs/btrfs/free-space-cache.c:1317: warning: Function parameter or member 'inode' not described in '__btrfs_write_out_cache'
fs/btrfs/free-space-cache.c:1317: warning: Function parameter or member 'ctl' not described in '__btrfs_write_out_cache'
fs/btrfs/free-space-cache.c:1317: warning: Function parameter or member 'block_group' not described in '__btrfs_write_out_cache'
fs/btrfs/free-space-cache.c:1317: warning: Function parameter or member 'io_ctl' not described in '__btrfs_write_out_cache'
fs/btrfs/free-space-cache.c:1317: warning: Function parameter or member 'trans' not described in '__btrfs_write_out_cache'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/free-space-cache.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index fd6ddd6b8165..c8f42385a302 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1300,10 +1300,12 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
 
 /**
  * __btrfs_write_out_cache - write out cached info to an inode
- * @root - the root the inode belongs to
- * @ctl - the free space cache we are going to write out
- * @block_group - the block_group for this cache if it belongs to a block_group
- * @trans - the trans handle
+ * @root:        the root the inode belongs to
+ * @inode:       freespace inode we are writing out
+ * @ctl:         the free space cache we are going to write out
+ * @block_group: the block_group for this cache if it belongs to a block_group
+ * @io_ctl:      holds context for the io
+ * @trans:       the trans handle
  *
  * This function writes out a free space cache struct to disk for quick recovery
  * on mount.  This will return 0 if it was successful in writing the cache out,
-- 
2.25.1

