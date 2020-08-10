Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14A1240AA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgHJPnM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgHJPnL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:43:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2266CC061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l64so8714609qkb.8
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zFmQ5ifW3GmwSlj9rU7NJYZUbXsc2cV3XVoy5vWcPwM=;
        b=IAO3V2C/TV57hCWWUMqrsgM4Yj7tWpIR1Uo8xU3Br/r5YXTBUFR3VmhfGcv3Rx/gsH
         dUp3mscQlfGn6Kb5+JMOBoSOBSQYpYT/fQ6Gb6aLh3xlNaJNJs3v+NeYRVMPXR7AvrOj
         CEedUgfi3kPMBjZ5mSDqhi9qD3bqGwL9yw3EhcsdSN6MashTtPfBLJ5bn/KWveQMANVx
         vKaW2b/t8swSU3p0DZiv+JV2cTE0Mn7HlLEagK2KWGhFRboCRKfsyjXkfPo9ugXXQRGx
         M8QnTV8KkSafuOcl81z6OCHxmfF85KUQdWPLm38HttFVNc0oSbKxAUiZ+ENF90p8Ue1u
         YNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFmQ5ifW3GmwSlj9rU7NJYZUbXsc2cV3XVoy5vWcPwM=;
        b=pUPs1WQQATxzx5LauY5JY5Sf8LRheAwH2zAa0BBPDfEfhEhQciAL8TjNk7ZMySM8Sr
         pbCviwcJSC+2jkRPMV9xZaTdu3kPllDudVQ4rjyrVmAGFblGtBN9RonFHtMIlOcv7lXi
         ztwNn24t3b7fPGAfaFtlivJeOLNsOulc6ip8ZmPIekJtUD7dqCBy9v/cCtcjRNabwVeH
         fvFsfBzTYG/V0CUIDf9OY/6M8c5jCrOc7syeczOoE0ikST80HYCIljr9qKCrcdAF9SuL
         Mw/vJMqAht7vJ8hZLDYoQhKuy0izEgDhDcDnb5uvf3G/avfAP8NgCJpBnrh5Bpi8H62b
         bawQ==
X-Gm-Message-State: AOAM533J60xoE4IRdS5xuM+lPKEH1rrxFTMaow7Ifw41q4dx8bXrb8Q9
        7SsB398UHWOvMeHchJzjp31G9BpAz559kA==
X-Google-Smtp-Source: ABdhPJzTaCA8ERd2usg9d/UhVR4koHAu8FY0QnoY2p1cVaidYmD7SMPLU/ZdX/jqKMKUl3mF7OTzpQ==
X-Received: by 2002:a05:620a:b8d:: with SMTP id k13mr27285937qkh.450.1597074189930;
        Mon, 10 Aug 2020 08:43:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m17sm16292612qkn.45.2020.08.10.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:43:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/17] btrfs: introduce BTRFS_NESTING_LEFT/RIGHT_COW
Date:   Mon, 10 Aug 2020 11:42:37 -0400
Message-Id: <20200810154242.782802-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
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
index ea5412cd0f62..6b63b3bcacd4 100644
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
index f93e3e10ddbd..31a87477b889 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -38,6 +38,14 @@ enum btrfs_lock_nesting {
 	 */
 	BTRFS_NESTING_LEFT,
 	BTRFS_NESTING_RIGHT,
+
+	/*
+	 * When splitting we will be holding a lock on the left/right node when
+	 * we need to cow that node, thus we need a new set of subclasses for
+	 * these two operations.
+	 */
+	BTRFS_NESTING_LEFT_COW,
+	BTRFS_NESTING_RIGHT_COW,
 };
 
 struct btrfs_path;
-- 
2.24.1

