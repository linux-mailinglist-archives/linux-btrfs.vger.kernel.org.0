Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D5FBF289
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 14:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfIZMIc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 08:08:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33207 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfIZMIc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 08:08:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so2566273qtd.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dF+9/0+JN98tJwIQLNB350UnToDA3GpPjpj26h4ArR0=;
        b=AA2auC8d3oLCuDMbpOZH39e0CP+4rfaHtRMAigPM9nZx6woZGX2INS6mzgaeRl8bXU
         qO/AFeAMAbLEQT/TXZrOSJuR3+G3GBtVn5DVz4LH2HSbEoZAWovQvp6TQMSkqL6Iwe1I
         ZLgRemA+K/erWo36AwfKJ3DQOdofrGo/YfvzOK17fgXsJVMPq0p9EJOQseEIkItPRS/W
         J9hw3DgERTCo9JTvDqxUJXrWKWOCqdQYCywUbgvlwrVRrp7iylVXkpJn8DO5w23ZbbTh
         bEpXaUUyi4MVQfwcLslN2JE0NLbLYqJ56yxrE2PBDj1mDTGCT7wOywKKLkM1GaExzJ12
         f++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dF+9/0+JN98tJwIQLNB350UnToDA3GpPjpj26h4ArR0=;
        b=nqUw6BrxouT3+mnyaAcOuglSZm/bod6B224gnaLK6860defBJJKUKaA8Jj0IGe6ilc
         gQhozKsecpyA/fcvQBO9Dl3etCUldmhLmFgNPYBWFgqAtJBJROR2frCNSfVQKqlc4iNw
         j6X9y++kqQHVniRzFAtJSK8p1Gg24dJIcUHJrM/Jm9o73zdD6tfDkxCAbGcI6EDWC3+U
         iIPIxJyEycA6DozP5M/gyUh504+5E4i5ThxPr+aZcXVaYcxB2B/MoBvexCaXSwJhYCmG
         TAn5t/PDFN80kzcby3FemdW5txbtXtYQmr8z8441OK9AWTCZ7PdXIFQuEfmsLOB0rhk+
         ggHA==
X-Gm-Message-State: APjAAAWCchleu66rnhOIhFq2pGgj3jvtZt/iCd1tIAtYNiIqtLtnZLMp
        lr9kQa3dz0P7Ea2Jzd2hxWhHnG+bZTp0RQ==
X-Google-Smtp-Source: APXvYqwbMvZZ6EAz4NWr0+1fvNIQxuJSr1ZEY4upEvNDU2wjc/4QPwULaEPvtKI2BR/ybFQi/et/aQ==
X-Received: by 2002:ac8:739a:: with SMTP id t26mr3506330qtp.176.1569499711058;
        Thu, 26 Sep 2019 05:08:31 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 16sm383024qky.93.2019.09.26.05.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 05:08:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v2] btrfs: use refcount_inc_not_zero in kill_all_nodes
Date:   Thu, 26 Sep 2019 08:08:29 -0400
Message-Id: <20190926120829.7229-1-josef@toxicpanda.com>
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
v1->v2:
- I'm an idiot.

 fs/btrfs/delayed-inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1f7f39b10bd0..81b2fd46886f 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1948,13 +1948,16 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 			break;
 		}
 
-		inode_id = delayed_nodes[n - 1]->inode_id + 1;
-
-		for (i = 0; i < n; i++)
-			refcount_inc(&delayed_nodes[i]->refs);
+		for (i = 0; i < n; i++) {
+			inode_id = delayed_nodes[i]->inode_id + 1;
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

