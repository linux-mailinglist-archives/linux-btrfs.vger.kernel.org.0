Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A424240AA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgHJPnO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgHJPnM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:43:12 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30A4C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:12 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h21so7046546qtp.11
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=915Pcf2m0NeZH1EUM9S9ojGS95EQ1CPFI6c3SyybXEE=;
        b=UM+JWiAL1a0navYr6f45H9eqCKtcweVymlF8bQZ+yIc5CWWaxXb4+WwPvsCgn/k8dE
         DumxVuGJZVzaDoGj6a+lvQdRf8mjVNSxQcOnkfamNwP86jxAUhd3oMdvWElgfWWqbIWS
         LX3N8aAJiE8YolBr8/9TEhRuWjvJDVLalDemdZma46C+KTjyGPOpNsU+DlqE9Oq5n3+1
         5ygeTYkJg0H/BUx5JGyFZIxdOZDHWkLIWm1ehlE2ZWchZt3syczFXCsiM2eIQzJMfV94
         NnWZbbHiF4ZlbouBcLyrgutD3ynaYvmZf8m0a6Vdow2DUp1XHkqYTQ+FMgwkowU973Hf
         9XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=915Pcf2m0NeZH1EUM9S9ojGS95EQ1CPFI6c3SyybXEE=;
        b=rcjTTA6/56yGgTrhIyz4HH5Q4oL6f7l6eWOmHDC2nd3ib7YiyCqIjGy51ILD8v3G2J
         M4LIdDZM28xnYwhvGoc3QJguYuJ4BH13Q17lhDUERwHpzyqZI4+aFRPX4PJzqF7VvhNs
         mBMmhn+qEZMTfUeq6sBA00kp9Fx5sK1ZK++sBmNOIzK0bk2OQXmVyRUn8JT/8MkAmG/2
         JdQF7a9rHZE/jQ4P3UfQm9Oqu6d1twmvWk/wNgwDuz4xrDSa4ZPNnJ6FTG+If/Chj5Ku
         gngNmXSOPI3lSVF7PtV50n6XWb0NIncezdzRj53LjE4iR7Zke5L0lnHx7PdpGqxdOhZz
         ej7g==
X-Gm-Message-State: AOAM533ehfL3kq5RAhynGSm3BICO4aV01zp1PM6x4GDuGpqNCINYNYLL
        2e2T4ySE2lRh2PaIq68BzV7wj14nlnF8Lg==
X-Google-Smtp-Source: ABdhPJyc+h2ixc52etkbHcbFfg/2JlLj0FC8ta48y7J5Z/huT9dKFz9Ae/FyPzLD2ExtnDEFjTn53Q==
X-Received: by 2002:ac8:67c9:: with SMTP id r9mr28057906qtp.301.1597074191776;
        Mon, 10 Aug 2020 08:43:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i7sm16024294qtb.27.2020.08.10.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:43:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/17] btrfs: introduce BTRFS_NESTING_SPLIT for split blocks
Date:   Mon, 10 Aug 2020 11:42:38 -0400
Message-Id: <20200810154242.782802-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we are splitting a leaf/node, we could do something like the
following

lock(leaf)  BTRFS_NESTING_NORMAL
  lock(left) BTRFS_NESTING_LEFT + BTRFS_NESTING_COW
    push from leaf -> left
      reset path to point to left
        split left
          allocate new block, lock block BTRFS_NESTING_SPLIT

at the new block point we need to have a different nesting level,
because we have already used either BTRFS_NESTING_LEFT or
BTRFS_NESTING_RIGHT when pushing items from the original leaf into the
adjacent leaves.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   | 4 ++--
 fs/btrfs/locking.h | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6b63b3bcacd4..82dac6510a86 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3473,7 +3473,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 	btrfs_node_key(c, &disk_key, mid);
 
 	split = alloc_tree_block_no_bg_flush(trans, root, 0, &disk_key, level,
-					     c->start, 0, BTRFS_NESTING_NORMAL);
+					     c->start, 0, BTRFS_NESTING_SPLIT);
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
@@ -4250,7 +4250,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 		btrfs_item_key(l, &disk_key, mid);
 
 	right = alloc_tree_block_no_bg_flush(trans, root, 0, &disk_key, 0,
-					     l->start, 0, BTRFS_NESTING_NORMAL);
+					     l->start, 0, BTRFS_NESTING_SPLIT);
 	if (IS_ERR(right))
 		return PTR_ERR(right);
 
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 31a87477b889..4f5586fed25a 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -46,6 +46,15 @@ enum btrfs_lock_nesting {
 	 */
 	BTRFS_NESTING_LEFT_COW,
 	BTRFS_NESTING_RIGHT_COW,
+
+	/*
+	 * When splitting we may push nodes to the left or right, but still use
+	 * the subsequent nodes in our path, keeping our locks on those adjacent
+	 * blocks.  Thus when we go to allocate a new split block we've already
+	 * used up all of our available subclasses, so this subclass exists to
+	 * handle this case where we need to allocate a new split block.
+	 */
+	BTRFS_NESTING_SPLIT,
 };
 
 struct btrfs_path;
-- 
2.24.1

