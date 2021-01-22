Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA652FFFB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbhAVKB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:01:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:58380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbhAVKAo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 05:00:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5YaUj33VhPxtRHJ6Ak/qrroBNU6rzjC6AVv3M42abQ=;
        b=p+sZ/mJZdkm5tpgPC4wtv0yBkg9Y/QnWciz3Z7VmAueNGooQQPIfS855f5NEus8XTGJSpp
        TvCol1qD5smD4fcGWSjo0fqcWJoEM+pkvflgp6tevKVL3Ual9u3LYiIY6l9E8B7sU1X0Qh
        Rk3MjjSokTSCy9Q+IQ0bTbx1gsiwBjE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FD71B7E8;
        Fri, 22 Jan 2021 09:58:09 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 11/14] btrfs: Fix parameter description in space-info.c
Date:   Fri, 22 Jan 2021 11:58:02 +0200
Message-Id: <20210122095805.620458-12-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122095805.620458-1-nborisov@suse.com>
References: <20210122095805.620458-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With these fixes space-info.c is clearn for W=1 warnings, namely the
following ones are fixed:

fs/btrfs/space-info.c:575: warning: Function parameter or member 'fs_info' not described in 'may_commit_transaction'
fs/btrfs/space-info.c:575: warning: Function parameter or member 'space_info' not described in 'may_commit_transaction'
fs/btrfs/space-info.c:1231: warning: Function parameter or member 'fs_info' not described in 'handle_reserve_ticket'
fs/btrfs/space-info.c:1231: warning: Function parameter or member 'space_info' not described in 'handle_reserve_ticket'
fs/btrfs/space-info.c:1231: warning: Function parameter or member 'ticket' not described in 'handle_reserve_ticket'
fs/btrfs/space-info.c:1231: warning: Function parameter or member 'flush' not described in 'handle_reserve_ticket'
fs/btrfs/space-info.c:1315: warning: Function parameter or member 'fs_info' not described in '__reserve_bytes'
fs/btrfs/space-info.c:1315: warning: Function parameter or member 'space_info' not described in '__reserve_bytes'
fs/btrfs/space-info.c:1315: warning: Function parameter or member 'orig_bytes' not described in '__reserve_bytes'
fs/btrfs/space-info.c:1315: warning: Function parameter or member 'flush' not described in '__reserve_bytes'
fs/btrfs/space-info.c:1427: warning: Function parameter or member 'root' not described in 'btrfs_reserve_metadata_bytes'
fs/btrfs/space-info.c:1427: warning: Function parameter or member 'block_rsv' not described in 'btrfs_reserve_metadata_bytes'
fs/btrfs/space-info.c:1427: warning: Function parameter or member 'orig_bytes' not described in 'btrfs_reserve_metadata_bytes'
fs/btrfs/space-info.c:1427: warning: Function parameter or member 'flush' not described in 'btrfs_reserve_metadata_bytes'
fs/btrfs/space-info.c:1462: warning: Function parameter or member 'fs_info' not described in 'btrfs_reserve_data_bytes'
fs/btrfs/space-info.c:1462: warning: Function parameter or member 'bytes' not described in 'btrfs_reserve_data_bytes'
fs/btrfs/space-info.c:1462: warning: Function parameter or member 'flush' not described in 'btrfs_reserve_data_bytes'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/space-info.c | 46 ++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 84fb94e78a8f..5f4b9ac99ae6 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -561,10 +561,10 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 }
 
 /**
- * maybe_commit_transaction - possibly commit the transaction if its ok to
- * @root - the root we're allocating for
- * @bytes - the number of bytes we want to reserve
- * @force - force the commit
+ * Possibly commit the transaction if its ok to
+ *
+ * @fs_info:    the filesystem
+ * @space_info: space_info we are checking for commit, either data or metadata
  *
  * This will check to make sure that committing the transaction will actually
  * get us somewhere and then commit the transaction if it does.  Otherwise it
@@ -1216,10 +1216,10 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 
 /**
  * handle_reserve_ticket - do the appropriate flushing and waiting for a ticket
- * @fs_info - the fs
- * @space_info - the space_info for the reservation
- * @ticket - the ticket for the reservation
- * @flush - how much we can flush
+ * @fs_info:    the filesystem
+ * @space_info: the space_info for the reservation
+ * @ticket:     the ticket for the reservation
+ * @flush:      how much we can flush
  *
  * This does the work of figuring out how to flush for the ticket, waiting for
  * the reservation, and returning the appropriate error if there is one.
@@ -1296,11 +1296,12 @@ static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
 }
 
 /**
- * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
- * @root - the root we're allocating for
- * @space_info - the space info we want to allocate from
- * @orig_bytes - the number of bytes we want
- * @flush - whether or not we can flush to make our reservation
+ * Tries to reserve bytes from the block_rsv's space
+ *
+ * @fs_info:    the filesystem
+ * @space_info: the space info we want to allocate from
+ * @orig_bytes: the number of bytes we want
+ * @flush:      whether or not we can flush to make our reservation
  *
  * This will reserve orig_bytes number of bytes from the space info associated
  * with the block_rsv.  If there is not enough space it will make an attempt to
@@ -1407,11 +1408,12 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 }
 
 /**
- * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
- * @root - the root we're allocating for
- * @block_rsv - the block_rsv we're allocating for
- * @orig_bytes - the number of bytes we want
- * @flush - whether or not we can flush to make our reservation
+ * Tries to reserve metadata bytes from the block_rsv's space
+ *
+ * @root:       the root we're allocating for
+ * @block_rsv:  the block_rsv we're allocating for
+ * @orig_bytes: the number of bytes we want
+ * @flush:      whether or not we can flush to make our reservation
  *
  * This will reserve orig_bytes number of bytes from the space info associated
  * with the block_rsv.  If there is not enough space it will make an attempt to
@@ -1449,10 +1451,10 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 }
 
 /**
- * btrfs_reserve_data_bytes - try to reserve data bytes for an allocation
- * @fs_info - the filesystem
- * @bytes - the number of bytes we need
- * @flush - how we are allowed to flush
+ * Tries to reserve data bytes for an allocation
+ * @fs_info: the filesystem
+ * @bytes:   the number of bytes we need
+ * @flush:   how we are allowed to flush
  *
  * This will reserve bytes from the data space info.  If there is not enough
  * space then we will attempt to flush space as specified by flush.
-- 
2.25.1

