Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7076F4762F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhLOUPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhLOUPR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:17 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A68C06173E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:17 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id kj6so6072547qvb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V0kjVsFUz0tqC52KqiMsJlRvP4U/agB8FWZF1XL1JpE=;
        b=LKaV/r76e5PFxeHRy8LHFjfndUVhhGyE7V/u9fknjM9axPTG4QfBdHjas+K7qSbBh4
         Bbgs01q1mSznnKEnlgO5KKwJudavDqkxKS7bH6wG5UxVD3Z4s0f0CcqDfm2AxTqfSHaV
         8Yqb94t5YgY9QNux+Wpr1/l/3Jm+e/9zC2DlaPrHUoifD2gYqNm+aOKrNlgcmCV7tPGj
         wB9OHFUUjhOC97i8v4clvbA6AsQ3icDDwPzgUSeeDLtc7iwyXKyV+7/N1xmwOVXWjX4R
         XHvqrsFFu+fz+lghl0U7swQahGDQyCxLHoknQficcIZJBpinNfGkq6Q5y1+56NPEGqza
         9Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0kjVsFUz0tqC52KqiMsJlRvP4U/agB8FWZF1XL1JpE=;
        b=t0/C9CLDGwSQBRpbtbLzqMV4YeQBJ+rMan5qBizA3j4VkbNGHUQHS22zTJB8Yy8KRT
         3ILv8dhAhE4vge/grCWOWy7+tUVNGt+BokdVOG9mzkjasU6HG4d79jL+y0oU97VH50Gx
         gPimZzRNPQpzst6oAqcv21rEjUecP88S7ZhzqPzX7hTXUgQBpV27D/y9lshaxHBFjmmq
         d2U36zARrYcBa2eeYn4EWZ6M+Kd7dwOtJpdL3bxzZJaEaoE/jFXKHhmFYCWk0si0w2wF
         nGBPKjITS2GH9SzOInlm9qJImUV0VBXx59VgutCoxt5ZD0wHS9J/T76cvHRMUK/L0luf
         yZwA==
X-Gm-Message-State: AOAM531woFtwGWeu6RCu0dTGjS7XRsd/u+ZSXKNB4T66syf0dLFqZQAq
        SuUGnSWTX0LY3SJghClJT0L5GCoMhkSq3A==
X-Google-Smtp-Source: ABdhPJxx4mFguruhlng+0i3DLz0YcdOc/JDhUPYXGiGOvnB6ISS1V94bXK5UYb9eCsZYVpqVQU3qoQ==
X-Received: by 2002:a05:6214:29c4:: with SMTP id gh4mr12792784qvb.118.1639599315977;
        Wed, 15 Dec 2021 12:15:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l22sm2096129qtj.68.2021.12.15.12.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/15] btrfs-progs: deal with GC items in check
Date:   Wed, 15 Dec 2021 15:14:53 -0500
Message-Id: <e1e8a8d76d02dd1da99fa053d1ae16a8de91a3e2.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have a GC item then we can treat the inode record like it has an
ORPHAN item, simply ignore it if we have either the ORPHAN item or the
GC item.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c          | 55 ++++++++++++++++++++++++++++++++++++++++---
 check/mode-original.h |  1 +
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index cee7e7a0..16a27a5a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -627,6 +627,8 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 	if (errors & I_ERR_INVALID_NLINK)
 		fprintf(stderr, ", directory has invalid nlink %d",
 			rec->nlink);
+	if (errors & I_ERR_NO_GC_ITEM)
+		fprintf(stderr, ", no gc item");
 	fprintf(stderr, "\n");
 
 	/* Print the holes if needed */
@@ -884,6 +886,42 @@ static int check_orphan_item(struct btrfs_root *root, u64 ino)
 	return ret;
 }
 
+static void check_inode_gc_item(struct btrfs_root *root, struct inode_record *rec)
+{
+	struct btrfs_root *gc_root;
+	struct rb_node *n;
+	struct btrfs_path path;
+	struct btrfs_key key = {
+		.objectid = root->root_key.objectid,
+		.type = BTRFS_GC_INODE_ITEM_KEY,
+		.offset = rec->ino,
+	};
+	int ret;
+
+	/*
+	 * We may choose to do something fancy with the location of our
+	 * GC_INODE_ITEM entries, so just search all of the gc roots for our
+	 * inode.
+	 */
+	for (n = rb_first(&gfs_info->global_roots_tree); n; n = rb_next(n)) {
+		gc_root = rb_entry(n, struct btrfs_root, rb_node);
+		if (gc_root->root_key.objectid != BTRFS_GC_TREE_OBJECTID)
+			continue;
+		btrfs_init_path(&path);
+		ret = btrfs_search_slot(NULL, gc_root, &key, &path, 0, 0);
+		btrfs_release_path(&path);
+
+		/*
+		 * Found our GC item, that means we don't need an orphan item so
+		 * we can clear both of these errors.
+		 */
+		if (ret == 0) {
+			rec->errors &= ~(I_ERR_NO_GC_ITEM | I_ERR_NO_ORPHAN_ITEM);
+			break;
+		}
+	}
+}
+
 static int process_inode_item(struct extent_buffer *eb,
 			      int slot, struct btrfs_key *key,
 			      struct shared_node *active_node)
@@ -907,8 +945,11 @@ static int process_inode_item(struct extent_buffer *eb,
 	if (btrfs_inode_flags(eb, item) & BTRFS_INODE_NODATASUM)
 		rec->nodatasum = 1;
 	rec->found_inode_item = 1;
-	if (rec->nlink == 0)
+	if (rec->nlink == 0) {
 		rec->errors |= I_ERR_NO_ORPHAN_ITEM;
+		if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+			rec->errors |= I_ERR_NO_GC_ITEM;
+	}
 	flags = btrfs_inode_flags(eb, item);
 	if (S_ISLNK(rec->imode) &&
 	    flags & (BTRFS_INODE_IMMUTABLE | BTRFS_INODE_APPEND))
@@ -2571,7 +2612,7 @@ static int repair_inode_no_item(struct btrfs_trans_handle *trans,
 	rec->found_dir_item = 1;
 	rec->imode = mode | btrfs_type_to_imode(filetype);
 	rec->nlink = 0;
-	rec->errors &= ~I_ERR_NO_INODE_ITEM;
+	rec->errors &= ~(I_ERR_NO_INODE_ITEM | I_ERR_NO_GC_ITEM);
 	/* Ensure the inode_nlinks repair function will be called */
 	rec->errors |= I_ERR_LINK_COUNT_WRONG;
 out:
@@ -3085,8 +3126,16 @@ static int check_inode_recs(struct btrfs_root *root,
 
 		if (rec->errors & I_ERR_NO_ORPHAN_ITEM) {
 			ret = check_orphan_item(root, rec->ino);
+
+			/*
+			 * If we have an orphan item we need to not have a gc
+			 * item.
+			 */
 			if (ret == 0)
-				rec->errors &= ~I_ERR_NO_ORPHAN_ITEM;
+				rec->errors &= ~(I_ERR_NO_ORPHAN_ITEM |
+						 I_ERR_NO_GC_ITEM);
+
+			check_inode_gc_item(root, rec);
 			if (can_free_inode_rec(rec)) {
 				free_inode_rec(rec);
 				continue;
diff --git a/check/mode-original.h b/check/mode-original.h
index cf06917c..b93d7cca 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -187,6 +187,7 @@ struct unaligned_extent_rec_t {
 #define I_ERR_INVALID_IMODE		(1 << 19)
 #define I_ERR_INVALID_GEN		(1 << 20)
 #define I_ERR_INVALID_NLINK		(1 << 21)
+#define I_ERR_NO_GC_ITEM		(1 << 22)
 
 struct inode_record {
 	struct list_head backrefs;
-- 
2.26.3

