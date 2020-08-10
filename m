Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877D6240AAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgHJPnQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgHJPnO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:43:14 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94207C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g26so8734839qka.3
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EZrMMM6r2oHa9LYxS6kZLedR0URv8Al5+PRg/ij10Tk=;
        b=wiGW5dsbUpsmSqC9J4m9L+LY8pwHY+YVlHQZlOPPPZJLrYeijk4foT5TTKE1PAZMAC
         MWkLLtMSxsqD70puy+GmWxftTG9wQIUaaoQpyDJ93nniarhvJemJu0GOSSfZqAbG8p67
         xv/Jcenc1wq+VErgNV+FpdP2fX3eAA7Ibeo4WP7QmNgbwD6XPxplau6ORZsiCG3rOezp
         7XSQ6JALmUzMU3iVpOGsblfymLmAd1uV5X+CfshSYm0ujcwDTuyyH3cBlexlCufW2xhY
         T32OAwQtSYsS9BprhuGQVG3k2yoaolEHYG5pxN9NHaKowFdiz9dcuZRa4PXZYqXQW0+b
         XQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZrMMM6r2oHa9LYxS6kZLedR0URv8Al5+PRg/ij10Tk=;
        b=lrJnIWVbNgzb7NjM9h6HvgyYIet2jpR7+2wCRDX+cBM7uA5ElrFbNnxJVMHuSpq2bv
         16CpEqt4bl45DAqOekJRoQVa6VWJ2d2Nd4RtW57sQA9k5sWHF42pUdFkcPkcIFOno1Vo
         105QQ6xYD6/PLklLxRamzcT9tQyvsf1H3lewD7+EobiFNNj7ZMLX7TvitH1fnVCMZ3Rj
         QYojuUyXAegTRdYH0tFR4xq1HXVU3jNyHf2BRcvVeZwYirOLWCdsS8g5WJWcUpHxwXYZ
         PoYG8ZPPhO+Pf9xF85v6KY8hJ858fXzbOpKynPdGFZmqfrTiF9ApGQfickMmymHt3/NC
         97Fg==
X-Gm-Message-State: AOAM530sJPVys182nVvRnhmP0lpjJnLSi0kBVvqZ4KzwV0/nc20q0Ss6
        kAixj/7K4R7DEN96Dt+4HGQUTZmgiT9jtw==
X-Google-Smtp-Source: ABdhPJxG5tbaxt3tPpd5beqm6slcIa4eX7HV29XHsme0yxaTGhbeI/AEH1s3BbUJPYx5WQy5jpuQlw==
X-Received: by 2002:a37:a54b:: with SMTP id o72mr26320552qke.289.1597074193453;
        Mon, 10 Aug 2020 08:43:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m30sm17340841qtm.46.2020.08.10.08.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:43:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/17] btrfs: introduce BTRFS_NESTING_NEW_ROOT for adding new roots
Date:   Mon, 10 Aug 2020 11:42:39 -0400
Message-Id: <20200810154242.782802-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The way we add new roots is confusing from a locking perspective for
lockdep.  We generally have the rule that we lock things in order from
highest level to lowest, but in the case of adding a new level to the
tree we actually allocate a new block for the root, which makes the
locking go in reverse.  A similar issue exists for snapshotting, we cow
the original root for the root of a new tree, however they're at the
same level.  Address this by using BTRFS_NESTING_NEW_ROOT for these
operations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   |  5 +++--
 fs/btrfs/locking.h | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 82dac6510a86..b0d6d86f449d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -198,7 +198,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		btrfs_node_key(buf, &disk_key, 0);
 
 	cow = btrfs_alloc_tree_block(trans, root, 0, new_root_objectid,
-			&disk_key, level, buf->start, 0, BTRFS_NESTING_NORMAL);
+				     &disk_key, level, buf->start, 0,
+				     BTRFS_NESTING_NEW_ROOT);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
 
@@ -3343,7 +3344,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 
 	c = alloc_tree_block_no_bg_flush(trans, root, 0, &lower_key, level,
 					 root->node->start, 0,
-					 BTRFS_NESTING_NORMAL);
+					 BTRFS_NESTING_NEW_ROOT);
 	if (IS_ERR(c))
 		return PTR_ERR(c);
 
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 4f5586fed25a..c845a0c07a1c 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -16,6 +16,11 @@
 #define BTRFS_WRITE_LOCK_BLOCKING 3
 #define BTRFS_READ_LOCK_BLOCKING 4
 
+/*
+ * We are limited in number of subclasses by MAX_LOCKDEP_SUBCLASSES, which at
+ * the time of this patch is 8, which is how many we're using here.  Keep this
+ * in mind if you decide you want to add another subclass.
+ */
 enum btrfs_lock_nesting {
 	BTRFS_NESTING_NORMAL = 0,
 
@@ -55,6 +60,15 @@ enum btrfs_lock_nesting {
 	 * handle this case where we need to allocate a new split block.
 	 */
 	BTRFS_NESTING_SPLIT,
+
+	/*
+	 * When promoting a new block to a root we need to have a special
+	 * subclass so we don't confuse lockdep, as it will appear that we are
+	 * locking a higher level node before a lower level one.  Copying also
+	 * has this problem as it appears we're locking the same block again
+	 * when we make a snapshot of an existing root.
+	 */
+	BTRFS_NESTING_NEW_ROOT,
 };
 
 struct btrfs_path;
-- 
2.24.1

