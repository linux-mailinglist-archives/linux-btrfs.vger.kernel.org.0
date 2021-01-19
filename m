Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC092FBA16
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 15:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404134AbhASOlr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 09:41:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:38048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390978AbhASM3M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 07:29:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611059214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qt19Bqx/BOaubuN1rJmaOmPmXgHGdf8NFei28dIduZY=;
        b=pZU3bAHJLl+lLXzctu7/grJ2WjaVsa+Fz8WERXB5jVVv5EnmS5Is+BJi1Df2CdiTSDm9WW
        MUy5JtIkUx8Gv9O9/gDehYcs7tOIKPv+l+uhzoCBg7L6hnEmE2MIitnmeuuAvPF0U2+jNw
        3acUQ3PaYMQygOZdvvh+x7a3COhbIYU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7A59AF92;
        Tue, 19 Jan 2021 12:26:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 11/13] btrfs: Fix parameter description in space-info.c
Date:   Tue, 19 Jan 2021 14:26:47 +0200
Message-Id: <20210119122649.187778-12-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119122649.187778-1-nborisov@suse.com>
References: <20210119122649.187778-1-nborisov@suse.com>
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
 fs/btrfs/space-info.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 84fb94e78a8f..55588da66dff 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -562,9 +562,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 /**
  * maybe_commit_transaction - possibly commit the transaction if its ok to
- * @root - the root we're allocating for
- * @bytes - the number of bytes we want to reserve
- * @force - force the commit
+ * @fs_info: fs context
+ * @space_info: space_info we are checking for commit, either data or metadata
  *
  * This will check to make sure that committing the transaction will actually
  * get us somewhere and then commit the transaction if it does.  Otherwise it
@@ -1216,10 +1215,10 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 
 /**
  * handle_reserve_ticket - do the appropriate flushing and waiting for a ticket
- * @fs_info - the fs
- * @space_info - the space_info for the reservation
- * @ticket - the ticket for the reservation
- * @flush - how much we can flush
+ * @fs_info: the fs
+ * @space_info: the space_info for the reservation
+ * @ticket: the ticket for the reservation
+ * @flush: how much we can flush
  *
  * This does the work of figuring out how to flush for the ticket, waiting for
  * the reservation, and returning the appropriate error if there is one.
@@ -1297,10 +1296,10 @@ static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
 
 /**
  * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
- * @root - the root we're allocating for
- * @space_info - the space info we want to allocate from
- * @orig_bytes - the number of bytes we want
- * @flush - whether or not we can flush to make our reservation
+ * @fs_info: fs context
+ * @space_info: the space info we want to allocate from
+ * @orig_bytes: the number of bytes we want
+ * @flush: whether or not we can flush to make our reservation
  *
  * This will reserve orig_bytes number of bytes from the space info associated
  * with the block_rsv.  If there is not enough space it will make an attempt to
@@ -1408,10 +1407,10 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 
 /**
  * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
- * @root - the root we're allocating for
- * @block_rsv - the block_rsv we're allocating for
- * @orig_bytes - the number of bytes we want
- * @flush - whether or not we can flush to make our reservation
+ * @root: the root we're allocating for
+ * @block_rsv: the block_rsv we're allocating for
+ * @orig_bytes: the number of bytes we want
+ * @flush: whether or not we can flush to make our reservation
  *
  * This will reserve orig_bytes number of bytes from the space info associated
  * with the block_rsv.  If there is not enough space it will make an attempt to
@@ -1450,9 +1449,9 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 
 /**
  * btrfs_reserve_data_bytes - try to reserve data bytes for an allocation
- * @fs_info - the filesystem
- * @bytes - the number of bytes we need
- * @flush - how we are allowed to flush
+ * @fs_info: the filesystem
+ * @bytes: the number of bytes we need
+ * @flush: how we are allowed to flush
  *
  * This will reserve bytes from the data space info.  If there is not enough
  * space then we will attempt to flush space as specified by flush.
-- 
2.25.1

