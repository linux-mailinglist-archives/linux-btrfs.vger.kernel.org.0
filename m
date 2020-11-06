Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98782A9F11
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 22:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgKFV1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 16:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgKFV1r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 16:27:47 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353A8C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 13:27:47 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id h12so1821400qtc.9
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 13:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ghQS6Do6CuNVWWi9iBxLp/2521WKLl8Rw6DQCnt+CJA=;
        b=Dvkqf2PaeyJumeHiJ7QufloUwhXN8O4CnOer7OX2GNwGOhNVN5rlAqIfyxtIrmWdKH
         Pc5qXTOKByKVgmoddvSne3pyMnRicMN7DCQG0l7DolD1tkml/17J1uV6SFraS3xpmWGH
         +9jpCxY/iIDhZ5XaSeByaSK6NZvMnn5JdSYAfSpxHTHCGlYle0oWoS18YNE+f0AlVevA
         R0AgS8sdesbz9EGownO+YWvbv++7GfbBQtmP14hsK3ZirQ6xc0pO9ctsKO/73hLb4SON
         385AQx/KQgJ7L9MUQrte2+ESR073cT21Qi3qgQPtMzB20r+mao2wLf5i0HGb2fDp236B
         IuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghQS6Do6CuNVWWi9iBxLp/2521WKLl8Rw6DQCnt+CJA=;
        b=b0CkbtD4ceWslmEwUqeGUvpAdcDs/LPr7PxoKT4mGOXETT2rvD3KJR5z+NgeTpW0wS
         QxiRYlAu3QvoaY5biQMOnMZ+kBuXRLOt+V0KO4fDW7t4eWkOyCKP0kD5RSTFykeW3PH4
         7pMjgpWspL6gEB9ELbwR/IuX9cGFHmHGKOZpDfcREQcnbAqvklI2cf7tyUg8Ko304/NX
         6PGLNxPLTNfHcvlyoYvGCUmFgSkaLlSWDpEv2Uw4PkeqMDPSip7ptGzYaY0yqfc7W4pZ
         nAuC3azn9qAE22G/0CT3mtE/dxwNmPn+kJx7MxLwiz4TE2YEWrBYopeOr8Z5g7F2vdXz
         13+g==
X-Gm-Message-State: AOAM533HoMdKiQ9sMrctPiJjoOHRtYuVWo3fxpx74LH9cLwM/LbX4ugV
        Eo2N5qZeslATBVHdJCDbE559U/EmyEaYbVCs
X-Google-Smtp-Source: ABdhPJxsgY1Mf6uosjsDM7ZSY8ilhwEX8Wr8rcjN308xgKRZP0kOd012B+flDR9dznd9B2qylcMPaA==
X-Received: by 2002:ac8:4252:: with SMTP id r18mr3472683qtm.26.1604698066087;
        Fri, 06 Nov 2020 13:27:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p136sm1339116qke.25.2020.11.06.13.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:27:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: remove the recursion handling code in locking.c
Date:   Fri,  6 Nov 2020 16:27:32 -0500
Message-Id: <c04e7bd2e5294b23eadbcafedca7214f7894c9e9.1604697895.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604697895.git.josef@toxicpanda.com>
References: <cover.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we're no longer using recursion, rip out all of the supporting
code.  Follow up patches will clean up the callers of these functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/locking.c | 63 ++--------------------------------------------
 1 file changed, 2 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index d477df1c67db..9b66154803a7 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -28,40 +28,16 @@
  * Additionally we need one level nesting recursion, see below. The rwsem
  * implementation does opportunistic spinning which reduces number of times the
  * locking task needs to sleep.
- *
- *
- * Lock recursion
- * --------------
- *
- * A write operation on a tree might indirectly start a look up on the same
- * tree.  This can happen when btrfs_cow_block locks the tree and needs to
- * lookup free extents.
- *
- * btrfs_cow_block
- *   ..
- *   alloc_tree_block_no_bg_flush
- *     btrfs_alloc_tree_block
- *       btrfs_reserve_extent
- *         ..
- *         load_free_space_cache
- *           ..
- *           btrfs_lookup_file_extent
- *             btrfs_search_slot
- *
  */
 
 /*
  * __btrfs_tree_read_lock: Lock the extent buffer for read.
  * @eb:  the eb to be locked
  * @nest: the nesting level to be used for lockdep
- * @recurse: if this lock is able to be recursed
+ * @recurse: unused.
  *
  * This takes the read lock on the extent buffer, using the specified nesting
  * level for lockdep purposes.
- *
- * If you specify recurse = true, then we will allow this to be taken if we
- * currently own the lock already.  This should only be used in specific
- * usecases, and the subsequent unlock will not change the state of the lock.
  */
 void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest,
 			    bool recurse)
@@ -71,31 +47,7 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
 	if (trace_btrfs_tree_read_lock_enabled())
 		start_ns = ktime_get_ns();
 
-	if (unlikely(recurse)) {
-		/* First see if we can grab the lock outright */
-		if (down_read_trylock(&eb->lock))
-			goto out;
-
-		/*
-		 * Ok still doesn't necessarily mean we are already holding the
-		 * lock, check the owner.
-		 */
-		if (eb->lock_owner != current->pid) {
-			down_read_nested(&eb->lock, nest);
-			goto out;
-		}
-
-		/*
-		 * Ok we have actually recursed, but we should only be recursing
-		 * once, so blow up if we're already recursed, otherwise set
-		 * ->lock_recursed and carry on.
-		 */
-		BUG_ON(eb->lock_recursed);
-		eb->lock_recursed = true;
-		goto out;
-	}
 	down_read_nested(&eb->lock, nest);
-out:
 	eb->lock_owner = current->pid;
 	trace_btrfs_tree_read_lock(eb, start_ns);
 }
@@ -136,22 +88,11 @@ int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 }
 
 /*
- * Release read lock.  If the read lock was recursed then the lock stays in the
- * original state that it was before it was recursively locked.
+ * Release read lock.
  */
 void btrfs_tree_read_unlock(struct extent_buffer *eb)
 {
 	trace_btrfs_tree_read_unlock(eb);
-	/*
-	 * if we're nested, we have the write lock.  No new locking
-	 * is needed as long as we are the lock owner.
-	 * The write unlock will do a barrier for us, and the lock_recursed
-	 * field only matters to the lock owner.
-	 */
-	if (eb->lock_recursed && current->pid == eb->lock_owner) {
-		eb->lock_recursed = false;
-		return;
-	}
 	eb->lock_owner = 0;
 	up_read(&eb->lock);
 }
-- 
2.26.2

