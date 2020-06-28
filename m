Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F0020C91F
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jun 2020 19:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgF1REX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jun 2020 13:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgF1REW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jun 2020 13:04:22 -0400
X-Greylist: delayed 509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 Jun 2020 10:04:22 PDT
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F3EC03E979
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jun 2020 10:04:22 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 57651C01A; Sun, 28 Jun 2020 18:55:51 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     linux-btrfs@vger.kernel.org
Cc:     Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH btrfs-progs] btrfs-convert, ext2_copy_inodes: print inode number on error
Date:   Sun, 28 Jun 2020 18:55:42 +0200
Message-Id: <1593363342-19104-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

if ext2_copy_inodes fails on ext2_copy_single_inode on a specific inode,
there is no message whatsoever to help identify what caused the problem.

Printing the inode number at least makes it possible to look it up
(debugfs, stat <inode_num> or ncheck <inode_num>) and investigate what
went wrong
---
Had an error on btrfs-convert and was a bit clueless what happened
when the only error was the following:
```
ERROR: error during copy_inodes -95210]
WARNING: an error occurred during conversion, filesystem is partially created but not finalized and not mountable
```
It turns out the '210]' part of the line is leftover from the progress
indicator (I was wondering what the hell is that errno?!), and it always
happened on the same inode so I just had to delete it to get
btrfs-convert to succeed.

Turns out that was an old ext4 cryptfs test laying around that I have no
need for... Now I know that it'll be easy to make a reproducer smaller
than 300GB so also possible to figure an even better error message (or
interactively offer to skip?) but for now at least this simple message
will help a lot!

Cheers,

 convert/source-ext2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index f248249f..ba65c9f9 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -827,8 +827,11 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
 		pthread_mutex_lock(&p->mutex);
 		p->cur_copy_inodes++;
 		pthread_mutex_unlock(&p->mutex);
-		if (ret)
+		if (ret) {
+			fprintf(stderr, "ext2_copy_single_inode failed on ino %u: %d\n",
+				ext2_ino, ret);
 			return ret;
+		}
 		/*
 		 * blocks_used is the number of new tree blocks allocated in
 		 * current transaction.
-- 
2.26.2

