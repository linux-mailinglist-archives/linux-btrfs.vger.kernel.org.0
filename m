Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E98191EBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 02:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgCYBu4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 21:50:56 -0400
Received: from gateway30.websitewelcome.com ([192.185.197.25]:46418 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbgCYBu4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 21:50:56 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id CE77979DB
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 20:50:52 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id GvC0jsVwu1s2xGvC0jZzk8; Tue, 24 Mar 2020 20:50:52 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MXPjJWe03glsfP+xATizEKIBHpyrnpQI14WXaAujnYc=; b=DNvWeE6/MSx6HQ5ZezsXhxbfyl
        u+RwoACY3Yi0jipxyfNC6XLJhoCwi4eRA1niZHNTG27sZCyzr4tYfL8waWze0bfJa1/twYYJ6rVGV
        5qwTeQVeov/WzfLD/5T7u8G+LezmWyXcgQGQJlmJ/95jHpd2b0RV/4mTrnRK0bUWXGCZSPMbBa3W3
        3RDeERumJv7dUzit3CV+dPDHZJFKs5dWUuMkzCld2vikbFlDy9kHxOlCkSkHu0QvXv7FYA1F4+T/E
        u9S0Y1VsV1mmy2GT33qbMr00OwRXBlkXQCx3L/yUa4TgaD8AOG/wEKluNgTwPYgK0UyMEl573eDYV
        jcVpiJnw==;
Received: from 200.146.53.142.dynamic.dialup.gvt.net.br ([200.146.53.142]:46144 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jGvC0-00070M-6Z; Tue, 24 Mar 2020 22:50:52 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH RFC] btrfs: send: Emit all xattr of an inode if the uid/gid changed
Date:   Tue, 24 Mar 2020 22:52:51 -0300
Message-Id: <20200325015251.28838-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 200.146.53.142
X-Source-L: No
X-Exim-ID: 1jGvC0-00070M-6Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 200.146.53.142.dynamic.dialup.gvt.net.br (hephaestus.prv.suse.net) [200.146.53.142]:46144
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

[PROBLEM]
When doing incremental send with a file with capabilities, there is a
situation where the capability can be lost in the receiving side. The
sequence of actions bellow show the problem:

$ mount /dev/sda fs1
$ mount /dev/sdb fs2

$ touch fs1/foo.bar
$ setcap cap_sys_nice+ep fs1/foo.bar
$ btrfs subvol snap -r fs1 fs1/snap_init
$ btrfs send fs1/snap_init | btrfs receive fs2

$ chgrp adm fs1/foo.bar
$ setcap cap_sys_nice+ep fs1/foo.bar

$ btrfs subvol snap -r fs1 fs1/snap_complete
$ btrfs subvol snap -r fs1 fs1/snap_incremental

$ btrfs send fs1/snap_complete | btrfs receive fs2
$ btrfs send -p fs1/snap_init fs1/snap_incremental | btrfs receive fs2

At this point fs/snap_increment/foo.bar lost the capability, since a
chgrp was emitted by "btrfs send". The current code only checks for the
items that changed, and as the XATTR kept the value only the chgrp change
is emitted.

[FIX]
In order to fix this issue, check if the uid/gid of the inode change,
and if yes, emit all XATTR again, including the capability.

Fixes: https://github.com/kdave/btrfs-progs/issues/202

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 I'm posting this patch as a RFC because I had some questions
 * Is this the correct place to fix?
 * Also, emitting all XATTR of the inode seems overkill...
 * Should it be fixed in userspace?

 fs/btrfs/send.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c5f41bd86765..5cffe5da91cf 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6187,6 +6187,14 @@ static int changed_inode(struct send_ctx *sctx,
 		sctx->cur_inode_mode = btrfs_inode_mode(
 				sctx->right_path->nodes[0], right_ii);
 	} else if (result == BTRFS_COMPARE_TREE_CHANGED) {
+		u64 left_uid = btrfs_inode_uid(sctx->left_path->nodes[0],
+					left_ii);
+		u64 left_gid = btrfs_inode_gid(sctx->left_path->nodes[0],
+					left_ii);
+		u64 right_uid = btrfs_inode_uid(sctx->right_path->nodes[0],
+					right_ii);
+		u64 right_gid = btrfs_inode_gid(sctx->right_path->nodes[0],
+					right_ii);
 		/*
 		 * We need to do some special handling in case the inode was
 		 * reported as changed with a changed generation number. This
@@ -6236,15 +6244,12 @@ static int changed_inode(struct send_ctx *sctx,
 			sctx->send_progress = sctx->cur_ino + 1;
 
 			/*
-			 * Now process all extents and xattrs of the inode as if
+			 * Now process all extents of the inode as if
 			 * they were all new.
 			 */
 			ret = process_all_extents(sctx);
 			if (ret < 0)
 				goto out;
-			ret = process_all_new_xattrs(sctx);
-			if (ret < 0)
-				goto out;
 		} else {
 			sctx->cur_inode_gen = left_gen;
 			sctx->cur_inode_new = 0;
@@ -6255,6 +6260,22 @@ static int changed_inode(struct send_ctx *sctx,
 			sctx->cur_inode_mode = btrfs_inode_mode(
 					sctx->left_path->nodes[0], left_ii);
 		}
+
+		/*
+		 * Process all XATTR of the inode if the generation or owner
+		 * changed.
+		 *
+		 * If the inode changed it's uid/gid, but kept a
+		 * security.capability xattr, only the uid/gid will be emitted,
+		 * causing the related xattr to deleted. For this reason always
+		 * emit the XATTR when an inode has changed.
+		 */
+		if (sctx->cur_inode_new_gen || left_uid != right_uid ||
+		    left_gid != right_gid) {
+			ret = process_all_new_xattrs(sctx);
+			if (ret < 0)
+				goto out;
+		}
 	}
 
 out:
-- 
2.25.1

