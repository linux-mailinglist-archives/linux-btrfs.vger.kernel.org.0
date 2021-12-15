Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696334758B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 13:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbhLOMUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 07:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbhLOMUJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 07:20:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9659AC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 04:20:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3906C618A0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BDDC34605
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639570807;
        bh=HQ8V/vhFsGUV5sv7xSnZEStTbHY4OdSmS+XLfPkrn+4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RAu47+WClgGtf7fBCOiA0TgId1d/BJI5uTdRvfaLJoNFb1Er+Bt+mk2xt0kMKbYHJ
         16plYNESSBYYlf0AHgXUMAg3MpBcBmnzCVrT9K5btzC/D7ALo6RHRWe8OginKRbKhT
         QcS1BzCZKhFh8KAtTzKscZHFpyTUIg9feoieBIDxzjiusKT/kJ0gEEC7Vj36bnnIbV
         o5Q0ywmlPs9euZzfKIh0OnJn0dxz8b2uovhOC9nTXrFRHlVkRe75A2UZO7tFCL3QqW
         +RQeA4T7XknVWwuXoF78a4fDkXH+stRyPZTfvNr90WTGZsMJfBDFwJfCNAganIMJk0
         nD4rrF+K5G5sg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: put initial index value of a directory in a constant
Date:   Wed, 15 Dec 2021 12:19:59 +0000
Message-Id: <80c71845e132bb5677dd280aa33fcdce08bc5542.1639568905.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1639568905.git.fdmanana@suse.com>
References: <cover.1639568905.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_set_inode_index_count() we refer twice to the number 2 as the
initial index value for a directory (when it's empty), with a proper
comment explaining the reason for that value. In the next patch I'll
have to use that magic value in the directory logging code, so put
the value in a #define at btrfs_inode.h, to avoid hardcoding the
magic value again at tree-log.c.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 12 ++++++++++--
 fs/btrfs/inode.c       | 10 ++--------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b3e46aabc3d8..6d4f42b0fdce 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -13,6 +13,13 @@
 #include "ordered-data.h"
 #include "delayed-inode.h"
 
+/*
+ * Since we search a directory based on f_pos (struct dir_context::pos) we have
+ * to start at 2 since '.' and '..' have f_pos of 0 and 1 respectively, so
+ * everybody else has to start at 2 (see btrfs_real_readdir() and dir_emit_dots()).
+ */
+#define BTRFS_DIR_START_INDEX 2
+
 /*
  * ordered_data_close is set by truncate when a file that used
  * to have good data has been truncated to zero.  When it is set
@@ -173,8 +180,9 @@ struct btrfs_inode {
 	u64 disk_i_size;
 
 	/*
-	 * if this is a directory then index_cnt is the counter for the index
-	 * number for new files that are created
+	 * If this is a directory then index_cnt is the counter for the index
+	 * number for new files that are created. For an empty directory, this
+	 * must be initialized to BTRFS_DIR_START_INDEX.
 	 */
 	u64 index_cnt;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a88130c7782e..97fd33d599eb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5971,14 +5971,8 @@ static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
 		goto out;
 	ret = 0;
 
-	/*
-	 * MAGIC NUMBER EXPLANATION:
-	 * since we search a directory based on f_pos we have to start at 2
-	 * since '.' and '..' have f_pos of 0 and 1 respectively, so everybody
-	 * else has to start at 2
-	 */
 	if (path->slots[0] == 0) {
-		inode->index_cnt = 2;
+		inode->index_cnt = BTRFS_DIR_START_INDEX;
 		goto out;
 	}
 
@@ -5989,7 +5983,7 @@ static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
 
 	if (found_key.objectid != btrfs_ino(inode) ||
 	    found_key.type != BTRFS_DIR_INDEX_KEY) {
-		inode->index_cnt = 2;
+		inode->index_cnt = BTRFS_DIR_START_INDEX;
 		goto out;
 	}
 
-- 
2.33.0

