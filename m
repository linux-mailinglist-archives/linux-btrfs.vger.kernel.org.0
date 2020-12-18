Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0E32DE9BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 20:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733157AbgLRTZx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 14:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgLRTZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 14:25:53 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155D5C061248
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:38 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id 7so2104023qtp.1
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2xJ+yz7g3j1yJ2RKE5h2nxhFWYtKIZLg1oF/4Ca3RgI=;
        b=Z3+P3XnPxAzhQLHnWRK3cyiy5j9sfdFafJ3+OTQkCzPqgLrbhgIZPiLMeiBOhdqJOG
         LK9A9KPbbhg59T2/QYAZwbD+8bjBi36r16kXWzxHH6+jJiaOatpw3ijBlBYEN8JoaXEu
         JRKHHkngba7mvqaY0/2sokrhrlR7WqtWliXcPbCgCjQfkkI2hsdwTPrMlueehl2QNa/g
         c5Ws45blk5lRn2S/rIf3aocfYchy2Rr1+oZMJWiJS1bqtKxvtTNgTUSWur4R7b7La7D1
         b+xcau6JANDPDuEL6ikVe96Obm83b/nOzr+LS7Uk1Vr0m6nAAzEnlsWauve/A/khcsmH
         H82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2xJ+yz7g3j1yJ2RKE5h2nxhFWYtKIZLg1oF/4Ca3RgI=;
        b=MJA4j6fMInaxHghyBJHa0LFKxY5L0+N9/vm8fjrs/nZc/jUTd+LE01N1Q84FsMCOxE
         85h6peG9uPJzIRXWvo7lQcW54pQUpyj1DjxZbeUtpdvKsTzCQjd/k9BnzTnML3aDDGZp
         XtQh4i12m3wtixKhYjVBOCaIr+Rs5NvYcjbzy8ACPMOnlFfaCm1dnB2dxtWvQq397t7X
         A6AnkyoTLzcwSQhhBeQE5HLiTtIpYi8tpMk9iH5voJ3tvrFWYcaQr1KPiuHHcE/4lYRu
         NIAbuTcwdFd+/Wljkd7uC5wanD5vkjPhpdt48dtGgNET9eEEeRcYkJyVmKsP2f9v/5ns
         EVIg==
X-Gm-Message-State: AOAM533H0CI1FYX3rSnSXAEBlRkO28J86YdxeZ8TBDP7Vlqlfb7mFQAZ
        t3UYXRcZcVWVf+oVpWpoIsKQsuYcWvcuQsTA
X-Google-Smtp-Source: ABdhPJzo4fEGLgsXmPkZFD/FSAgrgizAuYA5dGSkMcicm5kkCbDbXS6vendrCdHc7G4u/QIBoVr1mA==
X-Received: by 2002:a05:622a:213:: with SMTP id b19mr5476038qtx.199.1608319476933;
        Fri, 18 Dec 2020 11:24:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a194sm5897774qkc.70.2020.12.18.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:24:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 5/8] btrfs: move delayed ref flushing for qgroup into qgroup helper
Date:   Fri, 18 Dec 2020 14:24:23 -0500
Message-Id: <fd22f767d5867daf79da60faad9818e5202fe714.1608319304.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608319304.git.josef@toxicpanda.com>
References: <cover.1608319304.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commit d67263354541 ("btrfs: qgroup: Make snapshot accounting work
with new extent-oriented qgroup.") added a flush of the delayed refs
during snapshot creation in order to get the qgroup accounting properly.
However this code has changed and been moved to it's own helper that is
skipped if qgroups are turned off.  Move the flushing to the helper, as
we do not need it when qgroups are turned off.

Also add a comment explaining why it exists, and why it doesn't actually
save us.  This will be helpful later when we try to fix qgroup
accounting properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 4776e055f7f9..5738763c514b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1433,6 +1433,23 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 */
 	record_root_in_trans(trans, src, 1);
 
+	/*
+	 * btrfs_qgroup_inherit relies on a consistent view of the usage for the
+	 * src root, so we must run the delayed refs here.
+	 *
+	 * However this isn't particularly fool proof, because there's no
+	 * synchronization keeping us from changing the tree after this point
+	 * before we do the qgroup_inherit, or even from making changes while
+	 * we're doing the qgroup_inherit.  But that's a problem for the future,
+	 * for now flush the delayed refs to narrow the race window where the
+	 * qgroup counters could end up wrong.
+	 */
+	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+
 	/*
 	 * We are going to commit transaction, see btrfs_commit_transaction()
 	 * comment for reason locking tree_log_mutex
@@ -1686,12 +1703,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
 	/*
 	 * Do special qgroup accounting for snapshot, as we do some qgroup
 	 * snapshot hack to do fast snapshot.
-- 
2.26.2

