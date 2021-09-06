Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE57C4014CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 03:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351538AbhIFBhl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Sep 2021 21:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352952AbhIFBfn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Sep 2021 21:35:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87A5C03402D;
        Sun,  5 Sep 2021 18:26:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s11so5129723pgr.11;
        Sun, 05 Sep 2021 18:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=U5+OTcrgpUWYvSOZI25Dv1p9CkDmlMuTgp823JwS0Eo=;
        b=o4ueH59tFqroOxjL4Oac1yYTasmmrWP5A4eL3k+PVAgLcTPNiio3UpflbTK/Dz5f4t
         +mnYaCN8al7ZV6xvCaCtpRqIJUpbiI6HNPYVrBAaLG0PkM6dduwb+oODuphe1FdUR+T7
         dT1lRkc1p3zC3J281QU1hjy74vVOP7kM58Gx57Aeoi1sn9O3nDcuoEQJWJjn6ytRibrt
         2OB5wxr8tghOP8mLJCtYsjLEbN5xbUglhHa0H88SAfXYj3u+zBmrIwwHVeeYFneHpNHq
         OXUx4owGz/ahGhzT0Iu5WSid6ED9F2qEYju8Y/3pMubetW8h2H7wlK1v4Wo3+9ymYjwN
         Tmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U5+OTcrgpUWYvSOZI25Dv1p9CkDmlMuTgp823JwS0Eo=;
        b=RaOF07VFycV4SumxB63BQiItYwXWSekOQ4aV4mCBfGx/Z4yJ1Gw3ruPwQplqmxdyVe
         /aiS7VguEPsRbjdzLjBN1g6Q2GhRXE1M/+pQbhV9VtvkCkN5XgqRpiKxRHG+SDDxMODj
         Yy34oL2LcFl6f+z3HgAGDKyDYr2+6fyVeGw8PalGTKjQ9NYdFetjMmJLUWrwUmjyVc22
         JBARmaSjzPKxY4p/GwKUgN1dlzt4WLva4bRSlwq2ZEYS6j3KMSO2eyPELNw8T/6egayA
         Ev3MI4i9plXT5AWeQD7Aymr6xx/0YzDJtgXoJJOMG95CPeX1zB3yBOimsU2V5Jw6sKXF
         TP5w==
X-Gm-Message-State: AOAM530CC+piOLd3V55k92YSXQDWQ68s97GoiFeTPVA/7Xa7oLsGdAnu
        hS/Q7XHSYC9/8DTXvDBwiafgxhAH//A=
X-Google-Smtp-Source: ABdhPJxp90gkysPp87AozF1PGRbhDkRC/HlEK1Vhcths1EaumrYeqOHjwvwiWyDNN8Iodvaadu4WxQ==
X-Received: by 2002:a63:b218:: with SMTP id x24mr9353331pge.335.1630891577127;
        Sun, 05 Sep 2021 18:26:17 -0700 (PDT)
Received: from localhost (natp-s01-129-78-56-229.gw.usyd.edu.au. [129.78.56.229])
        by smtp.gmail.com with ESMTPSA id i7sm6836150pgd.56.2021.09.05.18.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 18:26:16 -0700 (PDT)
From:   Baptiste Lepers <baptiste.lepers@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Baptiste Lepers <baptiste.lepers@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: transaction: Fix misplaced barrier in btrfs_record_root_in_trans
Date:   Mon,  6 Sep 2021 11:25:59 +1000
Message-Id: <20210906012559.8605-1-baptiste.lepers@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Per comment, record_root_in_trans orders the writes of the root->state
and root->last_trans:
      set_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
      smp_wmb();
      root->last_trans = trans->transid;

But the barrier that enforces the order on the read side is misplaced:
     smp_rmb(); <-- misplaced
     if (root->last_trans == trans->transid &&
    <-- missing barrier here -->
            !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))

This patches fixes the ordering and wraps the racy accesses with
READ_ONCE and WRITE_ONCE calls to avoid load/store tearing.

Fixes: 7585717f304f5 ("Btrfs: fix relocation races")
Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
---
 fs/btrfs/transaction.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 14b9fdc8aaa9..a609222e6704 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -437,7 +437,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 				   (unsigned long)root->root_key.objectid,
 				   BTRFS_ROOT_TRANS_TAG);
 		spin_unlock(&fs_info->fs_roots_radix_lock);
-		root->last_trans = trans->transid;
+		WRITE_ONCE(root->last_trans, trans->transid);
 
 		/* this is pretty tricky.  We don't want to
 		 * take the relocation lock in btrfs_record_root_in_trans
@@ -489,7 +489,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	int ret;
+	int ret, last_trans;
 
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return 0;
@@ -498,8 +498,9 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 	 * see record_root_in_trans for comments about IN_TRANS_SETUP usage
 	 * and barriers
 	 */
+	last_trans = READ_ONCE(root->last_trans);
 	smp_rmb();
-	if (root->last_trans == trans->transid &&
+	if (last_trans == trans->transid &&
 	    !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))
 		return 0;
 
-- 
2.17.1

