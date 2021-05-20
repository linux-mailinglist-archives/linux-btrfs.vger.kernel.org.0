Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC58838B2F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhETPXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhETPW7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 11:22:59 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCBBC061760
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 08:21:38 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c13so7615576qvx.5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7MRqdURhlNmo4Uv4roqnoChci+go5O7uI4HORybQxAg=;
        b=x2SI9jdNwhMcgpNsRt+w3yoLF+JlagfvzCXgQgqU9RtqbrbnGOY8Vy8p62IEzevjcz
         8YhFILnhSDKSFwOVoRnP29Cl2CeDYeliiZKc8BkIeLQZXwwHOaRMpHq5WStyqmKJH/fK
         9Kejcd0G9IjvFVeQWZX1ygYaOuYDa6TbcUVfmjEXJrdeoVOO6HY9In+BLYioFffhhrr6
         WM1qGfQjss7agp53X3uaQwGVHBFK6qLV6LpCdFgJFvShje5vSCXikNo9iV71vXJEIKbB
         rmCc0UTYHamof/Fn9i79GcUQ40QFwm51FtnfNvvEIQl3++k7/cFcqrGTvYK7KIGUvuwq
         sVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7MRqdURhlNmo4Uv4roqnoChci+go5O7uI4HORybQxAg=;
        b=M08GkDUsvQB6y0+RTGcQlHg6aRBYi5oYySz+dr3LkCc/yStBPQfRJHWUq/cbDbmvTE
         ytcB9rAKyZNPFJVO5s0gOJshaSG4CRrshRRa8OZ4Y7cacl/2RLOndVuvZdeaoRGtE0eD
         HLQ1tFYAONlXgXxMf7RtR8YEreNklVTfMpdkUTr7pDDYJl3QN1m9sWThoFZW6SJh8N2z
         XchCe+h/5H4sXhABxprQgCB4F2lxQMywMDoqx+bG0cf+KFq2urikICvh2nwe8OM7gDM6
         0UP0OTbd9BW02nHk2Ut7E1zzwqVXDZbDBoB6M6liCxN9FyO/Xs8dR5SUz8q6vZRQneeA
         A6rw==
X-Gm-Message-State: AOAM533dCVSjPyFwWBuXqrgKRLD2wdlqPxyA1w+6U9kP0nz2K32tSY18
        W3PyW47pMuCJgKwT1qNfag5RPIRqqhue2Q==
X-Google-Smtp-Source: ABdhPJw37jK6RxT0H+kijNRaZwXQEFkww8pUSJ9rvgSKUZ2MLHt4OEkZ6IhdBVFY3R3k6zJmoYhlHw==
X-Received: by 2002:ad4:56a8:: with SMTP id bd8mr6208143qvb.9.1621524097158;
        Thu, 20 May 2021 08:21:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h65sm2315848qkd.112.2021.05.20.08.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:21:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: always abort the transaction if we abort a trans handle
Date:   Thu, 20 May 2021 11:21:31 -0400
Message-Id: <d794156bd3368d635913610dbe03c1fc727e297f.1621523846.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1621523846.git.josef@toxicpanda.com>
References: <cover.1621523846.git.josef@toxicpanda.com>
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
index 24b5e54935a9..790de24576ac 100644
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

