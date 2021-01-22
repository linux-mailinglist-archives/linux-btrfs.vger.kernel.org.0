Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39502FFFFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbhAVKPb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:15:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:56160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbhAVJ7J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 04:59:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vujXWFcLvqzSKCQw0nvXTtpibFCCgpNY2Yp03OoFvuE=;
        b=XkxXE4nUWY5gt5DT8lbzcLSIpGfMsOnFhNzMy13H8XNPU/mpihyIDPhdh6/FgsUIOIbvm7
        9VXbEFi9O7v32PTMMt4IGfrnEs6+gGUs+ZCB4jEn4HEcFWc9a4UNrTr4vekDle4rfTIKjE
        Q5+KkdJSZ7ZiK1MK3AoEgj++JBc7DdE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6115AF45;
        Fri, 22 Jan 2021 09:58:07 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 03/14] btrfs: Fix function description format
Date:   Fri, 22 Jan 2021 11:57:54 +0200
Message-Id: <20210122095805.620458-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122095805.620458-1-nborisov@suse.com>
References: <20210122095805.620458-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This fixes following W=1 warnings:

fs/btrfs/file-item.c:27: warning: Cannot understand  * @inode:  the inode we want to update the disk_i_size for
 on line 27 - I thought it was a doc line
fs/btrfs/file-item.c:65: warning: Cannot understand  * @inode - the inode we're modifying
 on line 65 - I thought it was a doc line
fs/btrfs/file-item.c:91: warning: Cannot understand  * @inode - the inode we're modifying
 on line 91 - I thought it was a doc line

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file-item.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 6ccfc019ad90..784adae2d0f9 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -24,8 +24,10 @@
 				       PAGE_SIZE))
 
 /**
- * @inode - the inode we want to update the disk_i_size for
- * @new_i_size - the i_size we want to set to, 0 if we use i_size
+ * Set inode's size according to filesystem options
+ *
+ * @inode:      the inode we want to update the disk_i_size for
+ * @new_i_size: the i_size we want to set to, 0 if we use i_size
  *
  * With NO_HOLES set this simply sets the disk_is_size to whatever i_size_read()
  * returns as it is perfectly fine with a file that has holes without hole file
@@ -62,9 +64,11 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 }
 
 /**
- * @inode - the inode we're modifying
- * @start - the start file offset of the file extent we've inserted
- * @len - the logical length of the file extent item
+ * Marks a range within a file as having a new extent inserted
+ *
+ * @inode: the inode being modifying
+ * @start: the start file offset of the file extent we've inserted
+ * @len:   logical length of the file extent item
  *
  * Call when we are inserting a new file extent where there was none before.
  * Does not need to call this in the case where we're replacing an existing file
@@ -88,9 +92,11 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 }
 
 /**
- * @inode - the inode we're modifying
- * @start - the start file offset of the file extent we've inserted
- * @len - the logical length of the file extent item
+ * Marks an inode range as not having a backing extent
+ *
+ * @inode: the inode being modifying
+ * @start: the start file offset of the file extent we've inserted
+ * @len:   the logical length of the file extent item
  *
  * Called when we drop a file extent, for example when we truncate.  Doesn't
  * need to be called for cases where we're replacing a file extent, like when
-- 
2.25.1

