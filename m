Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49668322A52
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 13:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhBWMLn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 07:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232696AbhBWMJf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 07:09:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FBFA601FF
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Feb 2021 12:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614082134;
        bh=DXKgqUXWggre8pb+n7ubDQFTEZqblI7KH0bCrTVwXoc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L3ERtcls24xtv76wn5KSgiwdxvOvSemBsCQOe9i37zcIU989KIGrJisEAu+IGzD/8
         VUAHRIf+onW4V9WmUvGaJ+OePBuxl/+ldlwVqHo3T/3emguNpmlQYhpUeGpCVHDQbV
         YaqiUGY4tHq1+b5G53/PvggLWWJyxv073+AA3H13PkUOy1vdlni3K0xwOVRV+Z5N9n
         niwHRDsCI4vEEFy5oxTa9vNY4Zr+xW7YH0B9kuOJ217GD4z48l9Y+XzqRyn6XtjrDC
         mpoVVL3qVyfGvPejLyiA7Kqrai3gaN2B0wKnUL1dQnDdwreeyYguhIq6QhTPkUylgC
         2RfEFR1MqETMg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: remove stale comment and logic from btrfs_inode_in_log()
Date:   Tue, 23 Feb 2021 12:08:49 +0000
Message-Id: <dabc6885cc5175dc41b926d47863931fafcc3f4c.1614081281.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1614081281.git.fdmanana@suse.com>
References: <cover.1614081281.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs_inode_in_log() checks the list of modified extents of the
inode, and has a comment mentioning why, as it used to be necessary to
make sure if we did something like the following:

  mmap write range A
  mmap write range B
  msync range A (ranged fsync)
  msync range B (ranged fsync)

we ended up with both ranges being logged.

If we did not check it, then the second fsync would do nothing because
btrfs_inode_in_log() would return true. This was added in 125c4cf9f37c98
("Btrfs: set inode's logged_trans/last_log_commit after ranged fsync") and
test case generic/325 from fstests exercises that scenario.

However, as of commit 487781796d3022 ("btrfs: make fast fsyncs wait only
for writeback"), every ranged fsync is now turned into a full ranged fsync
(operates on the range from 0 to LLONG_MAX), so it is now pointless to
test of emptiness of the list of modified extents, and the comment is
clearly outdated.

So just remove the comment and list emptiness check, while also changing
the function's return type to be a boolean instead of an integer.
In case one day we get support for ranged fsyncs again, it will be easy
to notice the check is necessary again, because it will make generic/325
always fail.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 8011596e1eb3..c652e19ad74e 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -315,24 +315,15 @@ static inline void btrfs_set_inode_last_sub_trans(struct btrfs_inode *inode)
 	spin_unlock(&inode->lock);
 }
 
-static inline int btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
+static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 {
-	int ret = 0;
+	bool ret = false;
 
 	spin_lock(&inode->lock);
 	if (inode->logged_trans == generation &&
 	    inode->last_sub_trans <= inode->last_log_commit &&
-	    inode->last_sub_trans <= inode->root->last_log_commit) {
-		/*
-		 * After a ranged fsync we might have left some extent maps
-		 * (that fall outside the fsync's range). So return false
-		 * here if the list isn't empty, to make sure btrfs_log_inode()
-		 * will be called and process those extent maps.
-		 */
-		smp_mb();
-		if (list_empty(&inode->extent_tree.modified_extents))
-			ret = 1;
-	}
+	    inode->last_sub_trans <= inode->root->last_log_commit)
+		ret = true;
 	spin_unlock(&inode->lock);
 	return ret;
 }
-- 
2.28.0

