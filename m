Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEB924C270
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgHTPqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgHTPq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C61C061388
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so1909099qkn.4
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dwi//Fxn+U3xRh4MtqF97UHRk3f4TrfspnqPiPDDzew=;
        b=rjRBMTb7hIrbH36MKy09R8/VfAagLtkM0TwT3lW3B35yCwThBmIoqDv+D7CJkAUabI
         V3S9WRawWDacBh6AQvxtsuzT3G6dVKizmrmizcM5VTVlf5t0ZdrAFIdCAw8BMhYpgRo7
         7zr1+Cv3+feTCpCMtlK/WXXXZ0pvHaBgk684sk1CKTYT5RKi+Zj6F0mU6Cty4uQG9PpD
         6yQRT58QBoty9cz8e7va2lW7fVcpSEyXnXgVvLgHyKzLO6wswHhy1eA877Y98lQwoy/0
         RVt2LcppCCapVMcgRw1e/isYGAemyZ1GGARTwKcAqmP7umxVWFRY4nns0rEryT3ZdvHL
         8C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwi//Fxn+U3xRh4MtqF97UHRk3f4TrfspnqPiPDDzew=;
        b=NH0cXJS47QR2nn4+t7anoHK/65VersPKVXrpf7actIRrf/PNq40a+ZuWnbMBx9KT2j
         ixqhqawNqyQ58Zj83W/Z7wHbRzMLLGFHSPU8b+aKjgFtqoIk8XiMs4doAXk29EYZaz9c
         EJj1KUba8WV13qa7XzzWadotj25qHJIzeq7ny5dUxUS3hVsvaseAirz0dHRwezA/8xKj
         rW9+F5uDaaH8+zpUT9FzAcDCrp8VnIQvsCDA/mS4xL56YYMxL9+vsaApHsk3efkJvpxY
         c2RpgD4iocD1uVjbyVttSX/ME5OVxoPzo9+blD7tjc4FC/nUjlcDS07TImc5vbL5OyvH
         2lUA==
X-Gm-Message-State: AOAM530ppwfotX1wW/F1Mldp23WLG7J7etefZKYMxIeyzKEQwOxL0ipM
        F1KeUUxSoAhv3MfyX/N9O7axAZkerHitCSCz
X-Google-Smtp-Source: ABdhPJzvXSjv/T36RwiXE++1IHreOrnKO4qPQmaxOJNH2PbigM5e8lxVvflP5V8XwgZ5MJB7hawm2g==
X-Received: by 2002:a05:620a:222c:: with SMTP id n12mr3094551qkh.210.1597938384583;
        Thu, 20 Aug 2020 08:46:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 15sm2490963qkm.112.2020.08.20.08.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/12] btrfs: introduce BTRFS_NESTING_LEFT/BTRFS_NESTING_RIGHT
Date:   Thu, 20 Aug 2020 11:46:04 -0400
Message-Id: <07d7ef8f401ec5b0b24ae58b4da7f0f49c9651fc.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
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
index d8f0e128c7ba..a4b2439a398a 100644
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
index 5a4fdef197f5..3169c2bb6db9 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -27,6 +27,18 @@ enum btrfs_lock_nesting {
 	 */
 	BTRFS_NESTING_COW,
 
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
+
 	/*
 	 * We are limited to MAX_LOCKDEP_SUBLCLASSES number of subclasses, so
 	 * add this in here and add a static_assert to keep us from going over
-- 
2.24.1

