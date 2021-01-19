Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6840C2FB9FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 15:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbhASOkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 09:40:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:37984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390836AbhASM3F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 07:29:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611059213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irLtReI5ibF5FB3wYeZ7kPRp1qTAq9+6dVDx7bLbgRY=;
        b=mjrTR+DqrkHclI4slhDGHWcHG8jx7ZVrYkTn1mSR8sGtPXwjn11aLz43wUdujSPozRHzqk
        ND/kL+ghEXNLRPUKDLyDwy8797HVx2AIrz1nculD2xldF7Oa1boEMiWjTTNUd3TeWBX3V2
        twi4wHiH9fuZkisciE4LxAwzP1WlPLI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58D1DAF44;
        Tue, 19 Jan 2021 12:26:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 05/13] btrfs: Improve parameter description for __btrfs_write_out_cache
Date:   Tue, 19 Jan 2021 14:26:41 +0200
Message-Id: <20210119122649.187778-6-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119122649.187778-1-nborisov@suse.com>
References: <20210119122649.187778-1-nborisov@suse.com>
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
index fd6ddd6b8165..3ad109114e0c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1300,10 +1300,12 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
 
 /**
  * __btrfs_write_out_cache - write out cached info to an inode
- * @root - the root the inode belongs to
- * @ctl - the free space cache we are going to write out
- * @block_group - the block_group for this cache if it belongs to a block_group
- * @trans - the trans handle
+ * @root:  the root the inode belongs to
+ * @inode: freespace inode we are writing out
+ * @ctl:  the free space cache we are going to write out
+ * @block_group:  the block_group for this cache if it belongs to a block_group
+ * @io_ctl: holds context for the io
+ * @trans:  the trans handle
  *
  * This function writes out a free space cache struct to disk for quick recovery
  * on mount.  This will return 0 if it was successful in writing the cache out,
-- 
2.25.1

