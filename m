Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E3148950
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391949AbgAXOeP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:34:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43722 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404665AbgAXOeK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:34:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so1619568qtj.10
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gDXEsKWmN9OUY0khkSOaMhJZiAuwsok1866a6a1RcM4=;
        b=CXb2dltM7fNjKeqszjuW4fAsK1NEqjk2+J4JRs/cpXEVgF1xxCsIDnAOEQE1815nIr
         7QtfCNxq8sAYTea4IcyRPz94ipgPr/lUvi5wYeOcXYLQICbAzAVWvXlCM4z3pex3z65Z
         YT7elYrHWXg8W6WCWRLtCPyvILkvvZDvwnmG0OIXrO748Mp3knCMmCygK+fO25DcWm+z
         gwjV0Lrp49EBzEE1L4y9+8Mm4Q/+G+086qx9VbIteQ7jrp/GEw9Om56IbBjWJmRtL5GZ
         YY+d6vY+jARRLjk1OeFgS9xTzUqkI90snGLPSQNwjnrP7lnc9+JNiaKZIHzxMIoLQl5v
         g4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDXEsKWmN9OUY0khkSOaMhJZiAuwsok1866a6a1RcM4=;
        b=jpJvxU3w/kztV2QAfjdlxQuCBz2lsUmI6BaWUL2AzqOvYhyTyX7qg+mj1a0hmJv2d0
         +x9try+jk+WFzI1z2ou5qu/mC2RnwYVKKByxGDJb3EqeDfvpftMWYDBUuK/XNZMlLX4u
         hhQY1wD6e2O0Ex0giYDdjTt2m+QcAjR86qNC5kPbUcMS3RGJStMjrEmzE0kKWZtg7yRX
         yaSQhZvuvkZO2wzpZyPnbAqdmoXWcAH/CGaj1OZWiQyy7AsStXguLcyZbAVi+1BYuwQq
         d5yo82DXcsHJg9mtuboZHAobxtg68GmCrbYOatffdcHAKDQQlSBIqskBZC0rCm3scMlZ
         eEqg==
X-Gm-Message-State: APjAAAVihz+wIUS28aG368+oHHpZHC2BA1bc9UWb0w+IN0zPhQUIGFdD
        uVZnb7uIBtG/RunNNzm5fiVV0Vbr4ZZ+dA==
X-Google-Smtp-Source: APXvYqwQlfe0x6a2oEjsKJ2Rxo29po1s4CejJ4Ol4596iuje/2twXi8JmRIU7wwezKav3LB18greKw==
X-Received: by 2002:ac8:5548:: with SMTP id o8mr2466561qtr.338.1579876449744;
        Fri, 24 Jan 2020 06:34:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t38sm3485352qta.78.2020.01.24.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:34:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 36/44] btrfs: move free_fs_info
Date:   Fri, 24 Jan 2020 09:32:53 -0500
Message-Id: <20200124143301.2186319-37-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to start freeing roots and doing other complicated things in
free_fs_info, so we need to move it to disk-io.c and export it in order
to use things lik btrfs_put_fs_root().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   | 17 -----------------
 fs/btrfs/disk-io.c | 18 ++++++++++++++++++
 fs/btrfs/disk-io.h |  1 +
 fs/btrfs/super.c   |  6 +++---
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f90b82050d2d..68510af4cacf 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2697,23 +2697,6 @@ static inline int btrfs_need_cleaner_sleep(struct btrfs_fs_info *fs_info)
 	return fs_info->sb->s_flags & SB_RDONLY || btrfs_fs_closing(fs_info);
 }
 
-static inline void free_fs_info(struct btrfs_fs_info *fs_info)
-{
-	kfree(fs_info->balance_ctl);
-	kfree(fs_info->delayed_root);
-	kfree(fs_info->extent_root);
-	kfree(fs_info->tree_root);
-	kfree(fs_info->chunk_root);
-	kfree(fs_info->dev_root);
-	kfree(fs_info->csum_root);
-	kfree(fs_info->quota_root);
-	kfree(fs_info->uuid_root);
-	kfree(fs_info->free_space_root);
-	kfree(fs_info->super_copy);
-	kfree(fs_info->super_for_commit);
-	kvfree(fs_info);
-}
-
 /* tree mod log functions from ctree.c */
 u64 btrfs_get_tree_mod_seq(struct btrfs_fs_info *fs_info,
 			   struct seq_list *elem);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5f672f016ed8..c605be6ba889 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1523,6 +1523,24 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
+{
+	kfree(fs_info->balance_ctl);
+	kfree(fs_info->delayed_root);
+	kfree(fs_info->extent_root);
+	kfree(fs_info->tree_root);
+	kfree(fs_info->chunk_root);
+	kfree(fs_info->dev_root);
+	kfree(fs_info->csum_root);
+	kfree(fs_info->quota_root);
+	kfree(fs_info->uuid_root);
+	kfree(fs_info->free_space_root);
+	kfree(fs_info->super_copy);
+	kfree(fs_info->super_for_commit);
+	kvfree(fs_info);
+}
+
+
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *location,
 				     bool check_ref)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 8add2e14aab1..97e7ac474a52 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -68,6 +68,7 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key,
 				     bool check_ref);
 
+void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5c3a1b7de6ee..0c81456df23e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1580,7 +1580,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 
 	if (s->s_root) {
 		btrfs_close_devices(fs_devices);
-		free_fs_info(fs_info);
+		btrfs_free_fs_info(fs_info);
 		if ((flags ^ s->s_flags) & SB_RDONLY)
 			error = -EBUSY;
 	} else {
@@ -1603,7 +1603,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 error_close_devices:
 	btrfs_close_devices(fs_devices);
 error_fs_info:
-	free_fs_info(fs_info);
+	btrfs_free_fs_info(fs_info);
 error_sec_opts:
 	security_free_mnt_opts(&new_sec_opts);
 	return ERR_PTR(error);
@@ -2169,7 +2169,7 @@ static void btrfs_kill_super(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	kill_anon_super(sb);
-	free_fs_info(fs_info);
+	btrfs_free_fs_info(fs_info);
 }
 
 static struct file_system_type btrfs_fs_type = {
-- 
2.24.1

