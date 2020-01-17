Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50E21412F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgAQV1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:10 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36184 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgAQV1J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id i13so22918225qtr.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CEEjqzHddXivirFJ90inNwdr2z1tu5HoVIVN1fx4ua8=;
        b=C1ahinKQQhmFOXjT83F7NpuD2NTRXvVeLXDj2uyWTrceYIbTqI3IvtSn32z7KycjI6
         xBP5jjdGlEbMCTlS/cw/gPaIE0E/MWro8WrXuoz2qrVdmlpynHC4lpu5qFkb2xnXI5XU
         QE2vw6sB3mYhSe+oy/TYjQlVZPcu1E333KsJiHSNPVtCaC9JedgpaoF6OirOihMV2WGD
         d/HVf7He1YqotYwQBja5lcecNwGbnozN6ToiSPiklMYDXBzUk8vW3lm9Umqnl2bfbfAb
         oirOgBx28cCNFyz+LPBArfGXWx/MAQ9syDN/Ups4uXGygZNgEfQpVGZB+TIExYCmZh8Z
         RhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEEjqzHddXivirFJ90inNwdr2z1tu5HoVIVN1fx4ua8=;
        b=UhlMl+YNv6zJjxOcXEowuB+/jD0X/rUNeTDodqEsCUievMNYv9WE/f16cHvMajEjvW
         lTIRwPTZ9LNQkiDlJVhUKk9k0x7JbZpITAXS3MizqbC5WFPeSi0ZQkxLgNsKcSxjxlzJ
         jhXr0Qve8ptMwXImEDNaJpw6sFWnDLAA9HSmTMKqdzDPqRhySFZvri4Q+cOLKo0cDwn7
         Sthl7Y6XLw5VB1YzhOthEcWHBa+9hFOV8eyFDEOVwymF/lfOFjpww+aQ4A8fEZko7DBZ
         DcQV8Mif9UoZhxlw3zBeMDpwNCerGDXVjUDBZaBqTTEpjBUADnzq03ocxmPXETDpU45T
         6HTQ==
X-Gm-Message-State: APjAAAVpMWS//WBGydkC4k8Ol4GDnysbQgH692lFpgOu6amdZibt0gF0
        eAtRkFIwfVvHzQgE9ncLS7RAsuYz7KsQnA==
X-Google-Smtp-Source: APXvYqxp5m9x7kKa2aui66ZlYTHnKjieUGl4+8r+XXMROHRS0Y95m4M8S02LW2jc5h860p8v1rfmTw==
X-Received: by 2002:ac8:59:: with SMTP id i25mr9492994qtg.110.1579296427877;
        Fri, 17 Jan 2020 13:27:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p126sm12371261qke.108.2020.01.17.13.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 36/43] btrfs: hold a ref on the root in open_ctree
Date:   Fri, 17 Jan 2020 16:25:55 -0500
Message-Id: <20200117212602.6737-37-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup the fs_root and put it in our fs_info directly, we should hold
a ref on this root for the lifetime of the fs_info.  Rework the free'ing
function so that it calls btrfs_put_fs_root() on the root at free time
with all of the other global trees.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   | 17 -----------------
 fs/btrfs/disk-io.c | 26 ++++++++++++++++++++++++++
 fs/btrfs/disk-io.h |  1 +
 fs/btrfs/super.c   |  6 +++---
 4 files changed, 30 insertions(+), 20 deletions(-)

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
index 5f672f016ed8..433c29ddfca7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1523,6 +1523,25 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
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
+	btrfs_put_fs_root(fs_info->fs_root);
+	kvfree(fs_info);
+}
+
+
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *location,
 				     bool check_ref)
@@ -3185,6 +3204,13 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_qgroup;
 	}
 
+	if (!btrfs_grab_fs_root(fs_info->fs_root)) {
+		fs_info->fs_root = NULL;
+		err = -ENOENT;
+		btrfs_warn(fs_info, "failed to grab a ref on the fs tree");
+		goto fail_qgroup;
+	}
+
 	if (sb_rdonly(sb))
 		return 0;
 
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

