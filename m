Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B04469F5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhKEUsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhKEUsi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:38 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FFFC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:45:58 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id 8so8296384qty.10
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L/nYdpdG5bpBnjTH0NMaB2UpDSiLeRTeXvP2uidFDng=;
        b=58x/0b7PCCp8pYLa0Ax0YSX+oZB/UXaFNvdds8+Qh0mr35y0GJ2W5SHDxbSTubMFHB
         A1qj/+WZiWiyiQzptKpJ0/72pcDfC4vZKop0GrSf1PbcMh1rEYriXQTE/RrGe0BouGV4
         nQi2TU2z0opMnDz3zjFXjPXV50XmRqei7iAwiadm40X8BdVH3Tw7xltPn+70aLWswpyp
         FDIAy7Mc/zo3EGy/LOjvU5/o1FtWLpeyITlJjtoc+ZLu1kTTVp691+3998OSRvfTu68E
         50Ht8FkzAjE/8heJXbWcbT3CGqh9VOt40rVit7wkVoFPVY8HGC6sbSlCAwMdaT4H+k1w
         ffCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/nYdpdG5bpBnjTH0NMaB2UpDSiLeRTeXvP2uidFDng=;
        b=kpsYBr7DJCnUjbsdyK/6M5/nZDZKKzMuO8ytOPEI/czb/gSLzBY4E7D/wqxtUGzPZ5
         K9zLeL5v4uboAxT9KbTijnKP6lfWYorMaKqNjEGYinvI5MKoWmWjO3ZMklaoPCZJiiJh
         3mvHdymwShFI7IXz743WUGjo1TBSjjDjNPe/2VGd8RD/kPHtRzS0ULlMNT2VTKpnl3x/
         90p2HdHJWuVFSWgacdHeoPgCP4xaM2clstwuD8AsgUeylp7yGnEslTDfgYLmr77lF9b0
         JDvCAEiRDIae2xdIwhIpFX1rhjqkMy0Vhba8H8cRfNlSElH3QJHY7SX8bn+/Jo/OG4bI
         aB3Q==
X-Gm-Message-State: AOAM5331upTarEud5lc0UqTd0RlTi+WpcF6Yd40hcpJHjmQ6yzyEm7U5
        kpLxk9L0h25BKnvBbNtsYab1Hjj/9rwTRg==
X-Google-Smtp-Source: ABdhPJzJbGGRYSlMq7gKyRb4+d+2yPRazBsGwUK/hpAcRp/UWbbNKFV9NAb2RbMnLoEzNtgzP7wNzQ==
X-Received: by 2002:a05:622a:60f:: with SMTP id z15mr62701563qta.286.1636145156912;
        Fri, 05 Nov 2021 13:45:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id az39sm6430572qkb.2.2021.11.05.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:45:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/25] btrfs: pass fs_info to trace_btrfs_transaction_commit
Date:   Fri,  5 Nov 2021 16:45:29 -0400
Message-Id: <26fac9990c46aec3f1113f32afd280fae5ed38a5.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The root on the trans->root can be anything, and generally we're
committing from the transaction kthread so it's usually the tree_root.
Change this to just take an fs_info, and to maintain compatibility
simply put the ROOT_TREE_OBJECTID as the root objectid for the
tracepoint.  This will allow use to remove trans->root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c           |  2 +-
 fs/btrfs/transaction.c       |  4 ++--
 include/trace/events/btrfs.h | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4c4357724ed0..3bd3a06a9627 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4968,7 +4968,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 		spin_unlock(&fs_info->trans_lock);
 
 		btrfs_put_transaction(t);
-		trace_btrfs_transaction_commit(fs_info->tree_root);
+		trace_btrfs_transaction_commit(fs_info);
 		spin_lock(&fs_info->trans_lock);
 	}
 	spin_unlock(&fs_info->trans_lock);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index befe04019271..4738ad1d826e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1937,7 +1937,7 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
 	btrfs_put_transaction(cur_trans);
 	btrfs_put_transaction(cur_trans);
 
-	trace_btrfs_transaction_commit(trans->root);
+	trace_btrfs_transaction_commit(fs_info);
 
 	if (current->journal_info == trans)
 		current->journal_info = NULL;
@@ -2351,7 +2351,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	if (trans->type & __TRANS_FREEZABLE)
 		sb_end_intwrite(fs_info->sb);
 
-	trace_btrfs_transaction_commit(trans->root);
+	trace_btrfs_transaction_commit(fs_info);
 
 	btrfs_scrub_continue(fs_info);
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 8f58fd95efc7..0d729664b4b4 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -182,18 +182,18 @@ FLUSH_STATES
 
 TRACE_EVENT(btrfs_transaction_commit,
 
-	TP_PROTO(const struct btrfs_root *root),
+	TP_PROTO(const struct btrfs_fs_info *fs_info),
 
-	TP_ARGS(root),
+	TP_ARGS(fs_info),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  generation		)
 		__field(	u64,  root_objectid		)
 	),
 
-	TP_fast_assign_btrfs(root->fs_info,
-		__entry->generation	= root->fs_info->generation;
-		__entry->root_objectid	= root->root_key.objectid;
+	TP_fast_assign_btrfs(fs_info,
+		__entry->generation	= fs_info->generation;
+		__entry->root_objectid	= BTRFS_ROOT_TREE_OBJECTID;
 	),
 
 	TP_printk_btrfs("root=%llu(%s) gen=%llu",
-- 
2.26.3

