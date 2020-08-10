Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342E9240AA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgHJPnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgHJPnJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:43:09 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C0C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w9so7057750qts.6
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O4at75NeL2MEVN21Ox+pwwTaDGwleWVHrMojaixO+/Y=;
        b=XDvabvuDdUGLKgAPCQ4FRlmbheHfQIJvF1GmhSC6SP5MfRAZvd3HiUNCGpc6RSB5PD
         +5hrc2hRE2LgxyVr18VaU1+kX77NnZIqQaisK4HdvW4FPtRVGvqGW+nH9Ygf2c6nZudW
         SNBwbW2VUjx59BueH3RQGKSyzTywYo4KWanl14ArlQn+UbPaq+jvlVQG4V8kni3g0ham
         5PyvSWb1XdurliOebCdKfB4X+fDjM2yBxFq0QMX4GKGWfN2J5eOqZVijE/KBNxYZEcLS
         lGSlsfaE1Mj3hyCd+icdRfymCLGhOd20kfXG/N7oOben3ISvl4Bzvk64X4OKW16Ct9vC
         aqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O4at75NeL2MEVN21Ox+pwwTaDGwleWVHrMojaixO+/Y=;
        b=SgSar7vEASj6uVwckmvqgfXABf6noxtttnpL/reOsZ8rdkny88ZH1OG3rRvicke8rg
         m26bB6zRIsH6tyEJpltWi0Lgj/kGcMcw1rKSf6Fe0hfgV5oN2xv/BIGfVs2Ke/IUQ5ow
         /nGPRz/cO5fyyrzPN4juMFooKu5jaTUyPSsvRiFzvPMJa1zgk5wqc2C6y8s0cndVbsdq
         nutn6vuWVUaEbTwP9jtCRLfkhR7p4ph5CNkEK5GXBlxt5L5zmbu9lLVfaOzDuqJdvKod
         8WdR5wYDST7RK05q2Z0GwOpx3aMaA4CMB+5Dz/oCEuP1327/vzi4plD+qu+oCD3RLd32
         ehVw==
X-Gm-Message-State: AOAM531ETDOU1T198j8gNR+UHqwRMlm4nrU5VbqgcOTCHtAV/O9Na8Rf
        Xe5bU0aaOJUblvJUD8x/KZ7XQTAgYJZ/Cw==
X-Google-Smtp-Source: ABdhPJyAilxKrPdvxGtaXd026NniESTrBMYspDBm6y+K4IvlylB+36Tp+a1v11ltEV/V+pVwaHK+iA==
X-Received: by 2002:ac8:5416:: with SMTP id b22mr27459557qtq.45.1597074187597;
        Mon, 10 Aug 2020 08:43:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k134sm14842062qke.60.2020.08.10.08.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:43:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/17] btrfs: introduce BTRFS_NESTING_LEFT/BTRFS_NESTING_RIGHT
Date:   Mon, 10 Aug 2020 11:42:36 -0400
Message-Id: <20200810154242.782802-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Our lockdep maps are based on rootid+level, however in some cases we
will lock adjacent blocks on the same level, namely in searching forward
or in split/balance.  Because of this lockdep will complain, so we need
a separate subclass to indicate to lockdep that these are different
locks.

lock leaf -> BTRFS_NESTING_NORMAL
  cow leaf -> BTRFS_NESTING_COW
    split leaf
       lock left -> BTRFS_NESTING_LEFT
       lock right -> BTRFS_NESTING_RIGHT

The above graph illustrates the need for this new nesting subclass.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   | 16 ++++++++--------
 fs/btrfs/locking.h | 12 ++++++++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a9699232d5bc..ea5412cd0f62 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1896,7 +1896,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		left = NULL;
 
 	if (left) {
-		btrfs_tree_lock(left);
+		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
 		btrfs_set_lock_blocking_write(left);
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left,
@@ -1912,7 +1912,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		right = NULL;
 
 	if (right) {
-		btrfs_tree_lock(right);
+		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
 		btrfs_set_lock_blocking_write(right);
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right,
@@ -2076,7 +2076,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 	if (left) {
 		u32 left_nr;
 
-		btrfs_tree_lock(left);
+		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
 		btrfs_set_lock_blocking_write(left);
 
 		left_nr = btrfs_header_nritems(left);
@@ -2131,7 +2131,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 	if (right) {
 		u32 right_nr;
 
-		btrfs_tree_lock(right);
+		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
 		btrfs_set_lock_blocking_write(right);
 
 		right_nr = btrfs_header_nritems(right);
@@ -3742,7 +3742,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (IS_ERR(right))
 		return 1;
 
-	btrfs_tree_lock(right);
+	__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
 	btrfs_set_lock_blocking_write(right);
 
 	free_space = btrfs_leaf_free_space(right);
@@ -3975,7 +3975,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (IS_ERR(left))
 		return 1;
 
-	btrfs_tree_lock(left);
+	__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
 	btrfs_set_lock_blocking_write(left);
 
 	free_space = btrfs_leaf_free_space(left);
@@ -5393,7 +5393,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			if (!ret) {
 				btrfs_set_path_blocking(path);
 				__btrfs_tree_read_lock(next,
-						       BTRFS_NESTING_NORMAL,
+						       BTRFS_NESTING_RIGHT,
 						       path->recurse);
 			}
 			next_rw_lock = BTRFS_READ_LOCK;
@@ -5430,7 +5430,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			if (!ret) {
 				btrfs_set_path_blocking(path);
 				__btrfs_tree_read_lock(next,
-						       BTRFS_NESTING_NORMAL,
+						       BTRFS_NESTING_RIGHT,
 						       path->recurse);
 			}
 			next_rw_lock = BTRFS_READ_LOCK;
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 9e0975aa82b3..f93e3e10ddbd 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -26,6 +26,18 @@ enum btrfs_lock_nesting {
 	 * a subclass for COW'ed blocks so that lockdep doesn't complain.
 	 */
 	BTRFS_NESTING_COW,
+
+	/*
+	 * Oftentimes we need to lock adjacent nodes on the same level while
+	 * still holding the lock on the original node we searched to, such as
+	 * for searching forward or for split/balance.
+	 *
+	 * Because of this we need to indicate to lockdep that this is
+	 * acceptable by having a different subclass for each of these
+	 * operations.
+	 */
+	BTRFS_NESTING_LEFT,
+	BTRFS_NESTING_RIGHT,
 };
 
 struct btrfs_path;
-- 
2.24.1

