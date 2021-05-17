Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4908A383A10
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbhEQQhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbhEQQg4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 12:36:56 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B831C080AA6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 08:34:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f29so6198591qka.0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Zw++QkId+e6D+1uVpLw/2CXw+hq9cM4r3xuCv5kNqs=;
        b=lO0kE/LATtan2o6+zU5GIhHSXtVww6EkjPIbvkpdi7uu06Lqq4IM9As+RjMedKbWce
         W17FqfRp3HsbXa9rx+12WrmNSJU6f4knfKQvtwFHzMQuQ0NLT68CWwBKdOpMj7u44EP6
         ziti2NoYYzNZ33QdABgD1hlIlrY7NxRNsj8bk+EAyNUJvAlbWYOKo6dCdtE8A1NVfajR
         sOm+OwYo32yi+NAFVVnC10WqmpeiTW/VmSaaUVVuYsInjE9WA/xzBemG0TPXlfMQpdcs
         s4xSvOEV6E9zWyjCrksBgAq3xvCwkwZeq+pOcjJGe2nHmn0vL0SjEpnTRjluMszDOFUD
         btqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Zw++QkId+e6D+1uVpLw/2CXw+hq9cM4r3xuCv5kNqs=;
        b=N4KzP3P2BzWETCV7SaItukwN3HRO5H08dzTXVf19R7b2EqTkxufzz+1w/SBELS4oUy
         m7eH0E8epPowy8mSDZ/CcCbfJUtMqPPki8tw82RL8o3wuwAmX8O+F9fi8wWe/prHaBti
         ILdOdbzhfA4ssxcbn2YwYFkP2KaxKIlMO95pycw/x/+i/pr/vPr8YjuwVIqBUNf3/GeN
         OUdBbo2o3/tPOQKllUwjGpSMipHSA3L3P9iWMFKjtgOQTBv7OBAFBwo4PwzC0MScSp8J
         xiItgUsjNyNvox8DtLFGA1hp1LxbKogGrZrTuUrZHBWrWwmzLUix7usGpCUZOQrGeA11
         QKRw==
X-Gm-Message-State: AOAM531858JQ+f144PkbIKmwe6Y9jFhmE9sCbftbCiSgEZzzaE6iQGSz
        bXECQcNnYyL+bWsFk6mnYjkGjOIjoAY2cw==
X-Google-Smtp-Source: ABdhPJzyaf6SQn1B7nn2oDfongS2873WAFHR5zkOybDmV8uF9wZAWxgHZmqMktNr3t61AQ5SMVC72g==
X-Received: by 2002:a37:6249:: with SMTP id w70mr426285qkb.27.1621265682258;
        Mon, 17 May 2021 08:34:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j9sm11189356qtl.15.2021.05.17.08.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:34:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: always abort the transaction if we abort a trans handle
Date:   Mon, 17 May 2021 11:34:40 -0400
Message-Id: <e106a478e2d238b7315a19f62fabeae8e9bbb51f.1621265669.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While stress testing our error handling I noticed that sometimes we
would still commit the transaction even though we had aborted the
transaction.

Currently we track if a trans handle has dirtied any metadata, and if it
hasn't we mark the FS as having an error (so no new transactions can be
started), but we will allow the current transaction to complete as we do
not mark the transaction itself as having been aborted.

This sounds good in theory, but we were not properly tracking IO errors
in btrfs_finish_ordered_io, and thus committing the transaction with
bogus free space data.  This isn't necessarily a problem per-se with the
free space cache, as the other guards in place would have kept us from
accepting the free space cache as valid, but hi-lights a real world case
where we had a bug and could have corrupted the filesystem because of
it.

This "skip abort on empty trans handle" is nice in theory, but assumes
we have perfect error handling everywhere, which we clearly do not.
Also we do not allow further transactions to be started, so all this
does is save the last transaction that was happening, which doesn't
necessarily gain us anything other than the potential for real
corruption.

Remove this particular bit of code, if we decide we need to abort the
transaction then abort the current one and keep us from doing real harm
to the file system, regardless of whether this specific trans handle
dirtied anything or not.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c       |  5 +----
 fs/btrfs/extent-tree.c |  1 -
 fs/btrfs/super.c       | 11 -----------
 fs/btrfs/transaction.c |  8 --------
 fs/btrfs/transaction.h |  1 -
 5 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a484fb72a01f..4bc3ca2cbd7d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -596,7 +596,6 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		       trans->transid, fs_info->generation);
 
 	if (!should_cow_block(trans, root, buf)) {
-		trans->dirty = true;
 		*cow_ret = buf;
 		return 0;
 	}
@@ -1788,10 +1787,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			 * then we don't want to set the path blocking,
 			 * so we test it here
 			 */
-			if (!should_cow_block(trans, root, b)) {
-				trans->dirty = true;
+			if (!should_cow_block(trans, root, b))
 				goto cow_done;
-			}
 
 			/*
 			 * must have write locks on this node and the
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f1d15b68994a..b84bbc24ff57 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4784,7 +4784,6 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		set_extent_dirty(&trans->transaction->dirty_pages, buf->start,
 			 buf->start + buf->len - 1, GFP_NOFS);
 	}
-	trans->dirty = true;
 	/* this returns a buffer locked for blocking */
 	return buf;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4a396c1147f1..bc613218c8c5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -299,17 +299,6 @@ void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
 	WRITE_ONCE(trans->aborted, errno);
-	/* Nothing used. The other threads that have joined this
-	 * transaction may be able to continue. */
-	if (!trans->dirty && list_empty(&trans->new_bgs)) {
-		const char *errstr;
-
-		errstr = btrfs_decode_error(errno);
-		btrfs_warn(fs_info,
-		           "%s:%d: Aborting unused transaction(%s).",
-		           function, line, errstr);
-		return;
-	}
 	WRITE_ONCE(trans->transaction->aborted, errno);
 	/* Wake up anybody who may be waiting on this transaction */
 	wake_up(&fs_info->transaction_wait);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f75de9f6c0ad..e0a82aa7da89 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2074,14 +2074,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	ASSERT(refcount_read(&trans->use_count) == 1);
 
-	/*
-	 * Some places just start a transaction to commit it.  We need to make
-	 * sure that if this commit fails that the abort code actually marks the
-	 * transaction as failed, so set trans->dirty to make the abort code do
-	 * the right thing.
-	 */
-	trans->dirty = true;
-
 	/* Stop the commit early if ->aborted is set */
 	if (TRANS_ABORTED(cur_trans)) {
 		ret = cur_trans->aborted;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 364cfbb4c5c5..c49e2266b28b 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -143,7 +143,6 @@ struct btrfs_trans_handle {
 	bool allocating_chunk;
 	bool can_flush_pending_bgs;
 	bool reloc_reserved;
-	bool dirty;
 	bool in_fsync;
 	struct btrfs_root *root;
 	struct btrfs_fs_info *fs_info;
-- 
2.26.3

