Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A24953A9D3
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355145AbiFAPQd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354999AbiFAPQc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 11:16:32 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5536291568
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 08:16:31 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id a9so1671268qvt.6
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q2Favr/DkwRhfo4kkGvQCPuO62DhKhe3iqh9ZFKwm8c=;
        b=JJHE7gfVnO/vsIV3D3DETGU2ZkbUarwSySJxAprElk8SHAmY47m+NQLy99kEpmH9A5
         o+yQz7w9WwNrWw7bJHiK50K0DoL47utKxRaFVuijcpd8qLi8T+M3mHU22uHBE+8t1HTW
         B1l9bfp3zsJV9a2hE4IFf9bnlNLDcmgom1W/X6dJCWcEm0QZ9dts91W9G0dpbHl+5P2R
         IoK/zjmiL+f83COHD5vsIIPbSbf5vIEi2rOlg/EkMcsN7ugI9J9qPlU7X3lWyoZDMLkE
         wlZNRswvvqeGEVtnKQfUzGclm9Ih8OXek7UhpbKnVEpB5ZzVtP0aYySoJw8iiGHpQ7DY
         3+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2Favr/DkwRhfo4kkGvQCPuO62DhKhe3iqh9ZFKwm8c=;
        b=bEdxVuJGaIqe5b4RwlcX+QkYHp2U6Xt+vr3ZdMsyw7VDLWjvm9f+YYspCPuEA6jkFJ
         SOhSd6K3oQJQJDhpKqLOToh3X8unM2RPbUPorqapMc/lL+7PcZ241Zo5cz+29DjgcTB8
         6XVxhpTpzCAVUYzV8gUAO6mDJ/3CYy6TbUnVPnpvJFNC0bLwArszj5IbF9nInTV+qasj
         LfIkz5lIbk9nS+NcDwFJ3ACClhJTIrcZHdpzprDYPwOnLf1WUZ3cSmKRJJh6srYvdxDG
         FRNNv0P9r/TpdNQms7aDRQRWKKPsaJyoqBsr5vKgKPc34FYaCNcyLjXopOFN8HkRf/7n
         veGQ==
X-Gm-Message-State: AOAM532Ui85QO95SqES4TqkIIAMpANy5ghcEl9xRNJuVHQFgverZ6Qmq
        T58mCN2q22r+KzB2fCIWfQBvrskPLYkYbg==
X-Google-Smtp-Source: ABdhPJw4IdbspZq5KbT/cPieFclttF7l2hhDXfcmBD5pg3aSBGGS3C1D06vc5HDVNn/0Qxr+sRkFSQ==
X-Received: by 2002:ad4:596d:0:b0:464:f983:f7bf with SMTP id eq13-20020ad4596d000000b00464f983f7bfmr2346902qvb.88.1654096589995;
        Wed, 01 Jun 2022 08:16:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a205b00b0069fc13ce235sm1333069qka.102.2022.06.01.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:16:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: fix deadlock with fsync+fiemap+full sync
Date:   Wed,  1 Jun 2022 11:16:25 -0400
Message-Id: <b069a36b638b96c599b5d31d46d789039341ad9f.1654096526.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1654096526.git.josef@toxicpanda.com>
References: <cover.1654096526.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are hitting the following deadlock in production occasionally

Task 1		Task 2		Task 3		Task 4		Task 5
		fsync(A)
		 start trans
						start commit
				falloc(A)
				 lock 5m-10m
				 start trans
				  wait for commit
fiemap(A)
 lock 0-10m
  wait for 5m-10m
   (have 0-5m locked)

		 have btrfs_need_log_full_commit
		  !full_sync
		  wait_ordered_extents
								finish_ordered_io(A)
								lock 0-5m
								DEADLOCK

We have an existing dependency of file extent lock -> transaction.
However in fsync if we tried to do the fast logging, but then had to
fall back to committing the transaction, we will be forced to call
btrfs_wait_ordered_range() to make sure all of our extents are updated.

This creates a dependency of transaction -> file extent lock, because
btrfs_finish_ordered_io() will need to take the file extent lock in
order to run the ordered extents.

Fix this by stopping the transaction if we have to do the full commit
and we attempted to do the fast logging.  Then attach to the transaction
and commit it if we need to.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 67 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1fd827b99c1b..9c799731cc70 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2323,25 +2323,62 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 
-	if (ret != BTRFS_NO_LOG_SYNC) {
+	if (ret == BTRFS_NO_LOG_SYNC) {
+		ret = btrfs_end_transaction(trans);
+		goto out;
+	}
+
+	/* We successfully logged the inode, attempt to sync the log. */
+	if (!ret) {
+		ret = btrfs_sync_log(trans, root, &ctx);
 		if (!ret) {
-			ret = btrfs_sync_log(trans, root, &ctx);
-			if (!ret) {
-				ret = btrfs_end_transaction(trans);
-				goto out;
-			}
-		}
-		if (!full_sync) {
-			ret = btrfs_wait_ordered_range(inode, start, len);
-			if (ret) {
-				btrfs_end_transaction(trans);
-				goto out;
-			}
+			ret = btrfs_end_transaction(trans);
+			goto out;
 		}
-		ret = btrfs_commit_transaction(trans);
-	} else {
+	}
+
+	/*
+	 * At this point we need to commit the transaction because we had
+	 * btrfs_need_log_full_commit() or some other error.
+	 *
+	 * If we didn't do a full sync we have to stop the trans handle, wait on
+	 * the ordered extents, start it again and commit the transaction.  If
+	 * we attempt to wait on the ordered extents here we could deadlock with
+	 * something like fallocate() that is holding the extent lock trying to
+	 * start a transaction while some other thread is trying to commit the
+	 * transaction while we (fsync) are currently holding the transaction
+	 * open.
+	 */
+	if (!full_sync) {
 		ret = btrfs_end_transaction(trans);
+		if (ret)
+			goto out;
+		ret = btrfs_wait_ordered_range(inode, start, len);
+		if (ret)
+			goto out;
+
+		/*
+		 * This is safe to use here because we're only interested in
+		 * making sure the transaction that had the ordered extents is
+		 * committed.  We aren't waiting on anything past this point,
+		 * we're purely getting the transaction and committing it.
+		 */
+		trans = btrfs_attach_transaction_barrier(root);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+
+			/*
+			 * We committed the transaction and there's no currently
+			 * running transaction, this means everything we care
+			 * about made it to disk and we are done.
+			 */
+			if (ret == -ENOENT)
+				ret = 0;
+			goto out;
+		}
 	}
+
+	ret = btrfs_commit_transaction(trans);
 out:
 	ASSERT(list_empty(&ctx.list));
 	err = file_check_and_advance_wb_err(file);
-- 
2.26.3

