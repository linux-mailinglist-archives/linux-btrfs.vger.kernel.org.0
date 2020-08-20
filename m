Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AA024C272
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgHTPqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbgHTPqf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:35 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621D3C061386
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so1877048qki.12
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E1BnQjLRyPdPVvlqCTsIJo8aHNHUGAbxWu32a/Fmvs0=;
        b=nA4OIIrdx+JgzFAE5zFUbbg/rUKo+u9JWM/ZGYJ3tjOybhUy178n5LZdevU8V0TqOX
         q4dSH/sk3sjHgENg/+23P420lFs2FGf7L7bH49+6lnJ4KvDLcrx+OlvtvloWGmU0riZo
         a8veOXIFxwKKF7uG/u2x2Ps9Cv7whD0GqqzHgISB5ru3JIAUN7mLkr476A/anjKaSy/w
         CNc3l+qwQClk2IOYPYtjUyi9DyBaZqCMftUfDVvDzQDp3UANZFWxbkUEpiCPas8POovS
         sfjTPYlB63BanTcB/oEnaqaq5OOksJvQHic5qfPJwipGed8cUBTDBEFMtWcReRlCczbm
         /1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1BnQjLRyPdPVvlqCTsIJo8aHNHUGAbxWu32a/Fmvs0=;
        b=BErT6Cf6aKZpnQ9fOx3yioVVYBHwzbPRujD4DlDl8zqhDnqgqwC9yVM04RRVcxgMwv
         oQjQ/XR1TwKfZWBblm3KSR9dw6yi23JkNaCcf27K3WOsLksl2iHcVzXVLc7zui6/P28l
         52DznlszGb3U0q8v0HgXz6vzsaugYVTI0QuIXRD1NR5lgAAZKsnsAYcQVR6UWrnMgIpt
         BSc3eFSW3nC8cFjr0PG4LNuNtc0vpJB43+uGAjB8ekbW8bq0ATUnRzuQO3yNfnI+GZEY
         Qumm5C/gLMAfUZ678dUN30afLvOBF1VHl+zEG4EP1kEozbu/i4wPIqbCCwX7Hs5JEUPB
         lbXA==
X-Gm-Message-State: AOAM530e0jTvLKz4dbdNqoKYI43Ga0bzGrc1LL+WDIcj2csx9qe69e2d
        00tYnr3KfiD7dsEKBbZefl7bYnZWJgSPrn0z
X-Google-Smtp-Source: ABdhPJxqGIb7pHfiMt0eIu/AIMeN/dzPEDKIdWP/9E9Ug7zFAaOFF9iGuPgdjpBQkP9ISNc7U5v+kA==
X-Received: by 2002:a37:ac8:: with SMTP id 191mr3135725qkk.293.1597938386499;
        Thu, 20 Aug 2020 08:46:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p12sm2331911qkk.118.2020.08.20.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/12] btrfs: introduce BTRFS_NESTING_LEFT/RIGHT_COW
Date:   Thu, 20 Aug 2020 11:46:05 -0400
Message-Id: <a228e8b88622403f98fcb46d5e7d4a4746192483.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For similar reasons as BTRFS_NESTING_COW, we need
BTRFS_NESTING_LEFT/RIGHT_COW.  The pattern is this

lock leaf -> BTRFS_NESTING_NORMAL
  cow leaf -> BTRFS_NESTING_COW
    split leaf
      lock left -> BTRFS_NESTING_LEFT
        cow left -> BTRFS_NESTING_LEFT_COW

We need this in order to indicate to lockdep that these locks are
discrete and are being taken in a safe order.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   | 12 ++++++------
 fs/btrfs/locking.h |  8 ++++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a4b2439a398a..ae5e3f1056d8 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1900,7 +1900,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_set_lock_blocking_write(left);
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left,
-				       BTRFS_NESTING_COW);
+				       BTRFS_NESTING_LEFT_COW);
 		if (wret) {
 			ret = wret;
 			goto enospc;
@@ -1916,7 +1916,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_set_lock_blocking_write(right);
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right,
-				       BTRFS_NESTING_COW);
+				       BTRFS_NESTING_RIGHT_COW);
 		if (wret) {
 			ret = wret;
 			goto enospc;
@@ -2085,7 +2085,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		} else {
 			ret = btrfs_cow_block(trans, root, left, parent,
 					      pslot - 1, &left,
-					      BTRFS_NESTING_COW);
+					      BTRFS_NESTING_LEFT_COW);
 			if (ret)
 				wret = 1;
 			else {
@@ -2140,7 +2140,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		} else {
 			ret = btrfs_cow_block(trans, root, right,
 					      parent, pslot + 1,
-					      &right, BTRFS_NESTING_COW);
+					      &right, BTRFS_NESTING_RIGHT_COW);
 			if (ret)
 				wret = 1;
 			else {
@@ -3751,7 +3751,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	/* cow and double check */
 	ret = btrfs_cow_block(trans, root, right, upper,
-			      slot + 1, &right, BTRFS_NESTING_COW);
+			      slot + 1, &right, BTRFS_NESTING_RIGHT_COW);
 	if (ret)
 		goto out_unlock;
 
@@ -3987,7 +3987,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	/* cow and double check */
 	ret = btrfs_cow_block(trans, root, left,
 			      path->nodes[1], slot - 1, &left,
-			      BTRFS_NESTING_COW);
+			      BTRFS_NESTING_LEFT_COW);
 	if (ret) {
 		/* we hit -ENOSPC, but it isn't fatal here */
 		if (ret == -ENOSPC)
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 3169c2bb6db9..a88c6f59f616 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -39,6 +39,14 @@ enum btrfs_lock_nesting {
 	BTRFS_NESTING_LEFT,
 	BTRFS_NESTING_RIGHT,
 
+	/*
+	 * When splitting we will be holding a lock on the left/right node when
+	 * we need to cow that node, thus we need a new set of subclasses for
+	 * these two operations.
+	 */
+	BTRFS_NESTING_LEFT_COW,
+	BTRFS_NESTING_RIGHT_COW,
+
 	/*
 	 * We are limited to MAX_LOCKDEP_SUBLCLASSES number of subclasses, so
 	 * add this in here and add a static_assert to keep us from going over
-- 
2.24.1

