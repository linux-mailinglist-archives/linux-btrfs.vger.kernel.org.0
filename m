Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F7E27F995
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 08:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgJAGkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 02:40:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:57400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAGkm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 02:40:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601534441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=eAcQfyZHmOKVZT2np4tk1z72BHPjeXQHTVCXZMr88AI=;
        b=qN5Lj7nxop5s5EszSJsibANuktwquOaw/+XQEXjXRAy050UnTuhqs9k8CkOX2hgrSAvxgq
        ANIzEfQ1Rn7PK+W4f6W9qVYnVGWMFJT9veQlc6wi29ma8dvnqAkUTmmZujsK6Dc8N+7/5q
        GQaFPBVU5dCwXblnpl9YOysT3XToets=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F749ABBE;
        Thu,  1 Oct 2020 06:40:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Rename BTRFS_INODE_ORDERED_DATA_CLOSE flag
Date:   Thu,  1 Oct 2020 09:40:39 +0300
Message-Id: <20201001064039.3231-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 8d875f95da43 ("btrfs: disable strict file flushes for
renames and truncates") eliminated the notion of ordered operations and
instead BTRFS_INODE_ORDERED_DATA_CLOSE only remained as a flag
indicating that a file's content should be synced to disk in case a
file is truncated and any writes happen to it concurrently. In fact
this intendend behavior was broken until it was fixed in
f6dc45c7a93a ("Btrfs: fix filemap_flush call in btrfs_file_release").

All things considered let's give the flag a more descriptive name. Also
slightly reword comments.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/file.c        | 10 +++++-----
 fs/btrfs/inode.c       |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 6fdb46d58299..1aff6187f3ab 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -21,7 +21,7 @@
  * new data the application may have written before commit.
  */
 enum {
-	BTRFS_INODE_ORDERED_DATA_CLOSE,
+	BTRFS_INODE_FLUSH_ON_CLOSE,
 	BTRFS_INODE_DUMMY,
 	BTRFS_INODE_IN_DEFRAG,
 	BTRFS_INODE_HAS_ASYNC_EXTENT,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d64ca6abea86..b8826aec3656 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2091,12 +2091,12 @@ int btrfs_release_file(struct inode *inode, struct file *filp)
 	filp->private_data = NULL;
 
 	/*
-	 * ordered_data_close is set by setattr when we are about to truncate
-	 * a file from a non-zero size to a zero size.  This tries to
-	 * flush down new bytes that may have been written if the
-	 * application were using truncate to replace a file in place.
+	 * Set by setattr when we are about to truncate a file from a non-zero
+	 * size to a zero size.  This tries to flush down new bytes that may
+	 * have been written if the application were using truncate to replace
+	 * a file in place.
 	 */
-	if (test_and_clear_bit(BTRFS_INODE_ORDERED_DATA_CLOSE,
+	if (test_and_clear_bit(BTRFS_INODE_FLUSH_ON_CLOSE,
 			       &BTRFS_I(inode)->runtime_flags))
 			filemap_flush(inode->i_mapping);
 	return 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7f9eaa009971..9f70e8299efc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4818,11 +4818,11 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 
 		/*
 		 * We're truncating a file that used to have good data down to
-		 * zero. Make sure it gets into the ordered flush list so that
-		 * any new writes get down to disk quickly.
+		 * zero. Make sure any new writes to the file get on disk
+		 * on close.
 		 */
 		if (newsize == 0)
-			set_bit(BTRFS_INODE_ORDERED_DATA_CLOSE,
+			set_bit(BTRFS_INODE_FLUSH_ON_CLOSE,
 				&BTRFS_I(inode)->runtime_flags);
 
 		truncate_setsize(inode, newsize);
-- 
2.17.1

