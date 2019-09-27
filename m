Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A40BC035C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfI0KXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 06:23:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:33042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbfI0KXX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 06:23:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3CFAB0B7;
        Fri, 27 Sep 2019 10:23:22 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/3] btrfs: Simplify btrfs_file_llseek
Date:   Fri, 27 Sep 2019 13:23:17 +0300
Message-Id: <20190927102318.12830-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927102318.12830-1-nborisov@suse.com>
References: <20190927102318.12830-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Handle SEEK_END/SEEK_CUR in a single 'default' case by directly
returning from generic_file_llseek. This makes the 'out' label redundant.
Finally return directly the vale from vfs_setpos. No semantic changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 000b7bd89bf0..cda1882f5cb5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3413,10 +3413,8 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 	int ret;
 
 	switch (whence) {
-	case SEEK_END:
-	case SEEK_CUR:
-		offset = generic_file_llseek(file, offset, whence);
-		goto out;
+	default:
+		return generic_file_llseek(file, offset, whence);
 	case SEEK_DATA:
 	case SEEK_HOLE:
 		inode_lock_shared(inode);
@@ -3427,9 +3425,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 			return ret;
 	}
 
-	offset = vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
-out:
-	return offset;
+	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
 }
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
-- 
2.17.1

