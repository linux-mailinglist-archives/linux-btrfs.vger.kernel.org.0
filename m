Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F9EBF2FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfIZM3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 08:29:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41156 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfIZM3h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 08:29:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id n1so2577147qtp.8
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 05:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+f9oa9SEcPX+PW72BjLGbD/syp5ej9lb3W/MbjqGCIg=;
        b=xsIhQdbEOuAuPPCPrRaIl4lFBMjKwowCCInkcoTCVveozTCuddM3/onNYqoLAKSE3b
         u1wgB3nkid+Hp7MtKzdxssCUz3wV7Y73Uqo41DZib/LuKpSWkjAYcXqlO1Mj4hrJsgii
         p0JhYvEU86jKVPvko0hU4OSeBG6bO3xhH7wQKAVPXh0KRYKg8sUbxjsfykrKicXvn4/v
         ChKWS9fRUA6JF4CmseeYFntUKztyh6QWeRIXa0aNXZ8Lj3TwgaMPMAyBwPhYHzXUNHhx
         lZ7+pd4CjEjhLAVBf9jb5wnQudEf4beYCdZdOmMQZJ2D0QP0axFPGJHqjm/SGIyapo51
         QTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+f9oa9SEcPX+PW72BjLGbD/syp5ej9lb3W/MbjqGCIg=;
        b=kZeE4GIIK5mijPCt1BIxgAyrUiqunUxcTUj5d7QGESreNvQfzbpbK8Doa/2OfdhiYL
         mOzz3po6NOs/SQoTyv+2Nu8Tua7hMQiwa9+KXuaZHqdXjvSNyuprV/6e/GYRTYaI3hGB
         +J65+rTKNscEl2r4CunNUXyvSkzEeZsqjDtjnWBoKYAPEWY1C47sIa9VFdF6SXEdDLbz
         qWkyU4cdTk+YWhI6pMKxEX0Tb9LnxGVIBvnstk+R1g6zTs5gNAq3EgFdOE04q9xztNmi
         70pP6OQ8raYblS5PZiCcbitljdl6WkIlhWoAGCHw50K4MXAOk9dfZF9CaWbgEg+E8K9Z
         ag6g==
X-Gm-Message-State: APjAAAUt1REfJ28E0+gpIDSUgAQd23tYjui2Jxl7PZX2hXJsnOUMlzJ4
        DhomdMpPrNDYBRNbFq3Fi3MisdJBtBCteg==
X-Google-Smtp-Source: APXvYqw6fO6HEooUQuGvvh0PsVMMdTM1J9qca6dvhe4UBbkFhgMgMZ2AGGU3I6XPV1DGZCQB1r3igQ==
X-Received: by 2002:a0c:9369:: with SMTP id e38mr2390768qve.25.1569500974669;
        Thu, 26 Sep 2019 05:29:34 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q8sm1009487qtj.76.2019.09.26.05.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 05:29:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v3] btrfs: use refcount_inc_not_zero in kill_all_nodes
Date:   Thu, 26 Sep 2019 08:29:32 -0400
Message-Id: <20190926122932.7369-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We hit the following warning while running down a different problem

[ 6197.175850] ------------[ cut here ]------------
[ 6197.185082] refcount_t: underflow; use-after-free.
[ 6197.194704] WARNING: CPU: 47 PID: 966 at lib/refcount.c:190 refcount_sub_and_test_checked+0x53/0x60
[ 6197.521792] Call Trace:
[ 6197.526687]  __btrfs_release_delayed_node+0x76/0x1c0
[ 6197.536615]  btrfs_kill_all_delayed_nodes+0xec/0x130
[ 6197.546532]  ? __btrfs_btree_balance_dirty+0x60/0x60
[ 6197.556482]  btrfs_clean_one_deleted_snapshot+0x71/0xd0
[ 6197.566910]  cleaner_kthread+0xfa/0x120
[ 6197.574573]  kthread+0x111/0x130
[ 6197.581022]  ? kthread_create_on_node+0x60/0x60
[ 6197.590086]  ret_from_fork+0x1f/0x30
[ 6197.597228] ---[ end trace 424bb7ae00509f56 ]---

This is because the free side drops the ref without the lock, and then
takes the lock if our refcount is 0.  So you can have nodes on the tree
that have a refcount of 0.  Fix this by zero'ing out that element in our
temporary array so we don't try to kill it again.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v2->v3:
- always git show after a revision kids, to make sure your new code still makes
  sense with the original code, not your previous version.

 fs/btrfs/delayed-inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1f7f39b10bd0..ac71615a480c 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1949,12 +1949,15 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 		}
 
 		inode_id = delayed_nodes[n - 1]->inode_id + 1;
-
-		for (i = 0; i < n; i++)
-			refcount_inc(&delayed_nodes[i]->refs);
+		for (i = 0; i < n; i++) {
+			if (!refcount_inc_not_zero(&delayed_nodes[i]->refs))
+				delayed_nodes[i] = NULL;
+		}
 		spin_unlock(&root->inode_lock);
 
 		for (i = 0; i < n; i++) {
+			if (!delayed_nodes[i])
+				continue;
 			__btrfs_kill_delayed_node(delayed_nodes[i]);
 			btrfs_release_delayed_node(delayed_nodes[i]);
 		}
-- 
2.21.0

