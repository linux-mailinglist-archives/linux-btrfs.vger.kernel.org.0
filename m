Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D9DBF092
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 12:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfIZKya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 06:54:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32926 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfIZKya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 06:54:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so1372307qkb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AvkyMxSl3KkhqKaG7Xc8v2lRB7TKAWSi0YoQdWVK35g=;
        b=O0rxiwlv+TExWoJEZF2fZ/GEFg/99SR69GXcrmONh0Ej3yBxm/AT3c51Lx8RG9XBle
         C49yix9Sns9QCuIWqnk94b+lCpLx522JpWncRH4gGgf8yKyGfy0ScTCRUfBtUbsjzEaP
         KsK42sOXyXYWKRtti9dzUy89WKOVhhFk6h7zgOBlQA3PpqJC1A7oplyZtp0C5RSpBgpO
         tRwPVbanOvLS3Yx/QJxirVY5VDwgajnrtGcmDiTvPN33wrbjTAYfFKix13vhA9dUvK+e
         ej2lxhtfHnUs/SMtDObVz89+7vwbBhLc5XkENtuB+1THbdUg4kbgTFE41FJm5bnbSQDr
         V5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AvkyMxSl3KkhqKaG7Xc8v2lRB7TKAWSi0YoQdWVK35g=;
        b=PZLIcD77k4EXPE+mC7n4n7/fE7XMrQ7aa4eqgIAWzpHzOL3bF657pHOUNhYnhkbo84
         gYpqRLjTFmnnQzBc6Co9RrAgDRDUjNjKyYpGyDqvTwsIJU4SIPeFwIuBXmxUjzNQzPGr
         9O1tMIYanrD/6nmsX7vmnzq3kwnEsY12SiKzHbJL+ZEnZ6lSyT/7h37Fd89VpxzwZJGG
         1KcS4rzP1cOudbn7HyBEEDdiIa9vfz1xdZm5aV0iM5+lhLTX+P5zmWedxMn8zgr4MF/9
         M+s0Y3L0kpbwn9SjW3DtpZtPJirY+z/HrTWxWGSYbY/23wU6jUPXJo2lXXu9+cd2N7dw
         3Jng==
X-Gm-Message-State: APjAAAXbxDwFsoU3LZACZs7ubdQw/7xpGOBkrM/wcBn0S5wyvbZfzT/b
        xTuI0Xp093c+MKThVzNxQcbJZw==
X-Google-Smtp-Source: APXvYqzxWvFjPbNn7Be54vvrvarIr1cLQvNEjPuXnfuRLKMglKKDIPv7p82cUsnrRu4ELmHq6qrVBA==
X-Received: by 2002:a37:a550:: with SMTP id o77mr2626075qke.205.1569495269209;
        Thu, 26 Sep 2019 03:54:29 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l23sm1229904qta.53.2019.09.26.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 03:54:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use refcount_inc_not_zero in kill_all_nodes
Date:   Thu, 26 Sep 2019 06:54:27 -0400
Message-Id: <20190926105427.5978-1-josef@toxicpanda.com>
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

This is because we're unconditionally grabbing a ref to every node, but
there could be nodes with a 0 refcount.  Fix this to instead use
refcount_inc_not_zero() and only process the list for the nodes we get a
refcount on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-inode.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1f7f39b10bd0..320503750896 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1936,7 +1936,7 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 {
 	u64 inode_id = 0;
 	struct btrfs_delayed_node *delayed_nodes[8];
-	int i, n;
+	int i, n, count;
 
 	while (1) {
 		spin_lock(&root->inode_lock);
@@ -1948,13 +1948,16 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 			break;
 		}
 
-		inode_id = delayed_nodes[n - 1]->inode_id + 1;
-
-		for (i = 0; i < n; i++)
-			refcount_inc(&delayed_nodes[i]->refs);
+		count = 0;
+		for (i = 0; i < n; i++) {
+			if (!refcount_inc_not_zero(&delayed_nodes[i]->refs))
+				break;
+			count++;
+		}
+		inode_id = delayed_nodes[count - 1]->inode_id + 1;
 		spin_unlock(&root->inode_lock);
 
-		for (i = 0; i < n; i++) {
+		for (i = 0; i < count; i++) {
 			__btrfs_kill_delayed_node(delayed_nodes[i]);
 			btrfs_release_delayed_node(delayed_nodes[i]);
 		}
-- 
2.21.0

