Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B23C13F348
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 19:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbgAPRLm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 12:11:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389990AbgAPRLl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 12:11:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24F72468F;
        Thu, 16 Jan 2020 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194700;
        bh=Xu//IoAjWDWjzdXNMwlzFCfDT/q5SDU77D+BGGYp3nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQKBxyxif97x+2N5aBUyI5uIlbrW5VlgBA91mDE0KaciUKQOdQArNB6m5BNcE0+9x
         4/xQBYZ5mC4w5oJdcSecmWcU75uQd2NlPJ5CXPVgd9BeKyDABz1FmIvQ3X5qnQ/0Cy
         VlSyRleVHMshyo/sk7WGjlCDPyPcDdeP/R5rtYgA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 540/671] Btrfs: fix inode cache waiters hanging on failure to start caching thread
Date:   Thu, 16 Jan 2020 12:02:58 -0500
Message-Id: <20200116170509.12787-277-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a68ebe0790fc88b4314d17984a2cf99ce2361901 ]

If we fail to start the inode caching thread, we print an error message
and disable the inode cache, however we never wake up any waiters, so they
hang forever waiting for the caching to finish. Fix this by waking them
up and have them fallback to a call to btrfs_find_free_objectid().

Fixes: e60efa84252c05 ("Btrfs: avoid triggering bug_on() when we fail to start inode caching task")
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode-map.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index b3bd27070617..7c4d0107c6fb 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -12,6 +12,19 @@
 #include "inode-map.h"
 #include "transaction.h"
 
+static void fail_caching_thread(struct btrfs_root *root)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+
+	btrfs_warn(fs_info, "failed to start inode caching task");
+	btrfs_clear_pending_and_info(fs_info, INODE_MAP_CACHE,
+				     "disabling inode map caching");
+	spin_lock(&root->ino_cache_lock);
+	root->ino_cache_state = BTRFS_CACHE_ERROR;
+	spin_unlock(&root->ino_cache_lock);
+	wake_up(&root->ino_cache_wait);
+}
+
 static int caching_kthread(void *data)
 {
 	struct btrfs_root *root = data;
@@ -164,11 +177,8 @@ static void start_caching(struct btrfs_root *root)
 
 	tsk = kthread_run(caching_kthread, root, "btrfs-ino-cache-%llu",
 			  root->root_key.objectid);
-	if (IS_ERR(tsk)) {
-		btrfs_warn(fs_info, "failed to start inode caching task");
-		btrfs_clear_pending_and_info(fs_info, INODE_MAP_CACHE,
-					     "disabling inode map caching");
-	}
+	if (IS_ERR(tsk))
+		fail_caching_thread(root);
 }
 
 int btrfs_find_free_ino(struct btrfs_root *root, u64 *objectid)
@@ -186,11 +196,14 @@ int btrfs_find_free_ino(struct btrfs_root *root, u64 *objectid)
 
 	wait_event(root->ino_cache_wait,
 		   root->ino_cache_state == BTRFS_CACHE_FINISHED ||
+		   root->ino_cache_state == BTRFS_CACHE_ERROR ||
 		   root->free_ino_ctl->free_space > 0);
 
 	if (root->ino_cache_state == BTRFS_CACHE_FINISHED &&
 	    root->free_ino_ctl->free_space == 0)
 		return -ENOSPC;
+	else if (root->ino_cache_state == BTRFS_CACHE_ERROR)
+		return btrfs_find_free_objectid(root, objectid);
 	else
 		goto again;
 }
-- 
2.20.1

