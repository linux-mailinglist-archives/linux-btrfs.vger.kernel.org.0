Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E59109760
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 01:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKZA45 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 19:56:57 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39676 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKZA45 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 19:56:57 -0500
Received: by mail-pj1-f66.google.com with SMTP id v93so4173601pjb.6;
        Mon, 25 Nov 2019 16:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mK4YYpGvmcl+UsKcFd9/hDIZGDrUcsqxidj1mlw+fb8=;
        b=QRAHX5Pl00QYssmBGDmk7pRWuuWWlekSCNlCEOtKDozeT2ysH7Opo8K8MGMUZNZhFq
         QFToHuezpU2JFCR+m9OwkA1bsyGgfLCNFeb8z116rmzJFQfqTM8o8tXHsWQS8sutwouA
         ZpjQgwiqgLwcI4LeLlfIBIsnOOhx96x7JbOaGSiAqvrYTDy2pi8DVmCKgOxMKiTyScJa
         zKWjsdROZeY/AZDwvo/5DxfyfmcmgEM4b+lKLkoQPYc2z3JTfUDxNsQXy5DQKssk4za7
         k2PZ+vo2aRKPxu7zdgfYQ+OalPw8qo4agDnOrQsWhBIGCVJcATwe/OQIVcZCHd6ZLh4s
         pCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mK4YYpGvmcl+UsKcFd9/hDIZGDrUcsqxidj1mlw+fb8=;
        b=JpzT5t1yAfUytI8a3rnZTiKEdBO21cFQj6vhJJ9GwDH3Gcd8cNcr7smqiZGNmc1rSp
         itQ/bgcB8MTbcvmu1siiC4kXTXxwDKhW6mAGrmf87a8A1yq8emCap5sRLfvo/7c+t0S9
         xkQAJcMic04Xnen8Tg0FadMJoirBFYzqbTdS+ZISnTovFrIhf6kSt8X5C7Uw3VPnZnNz
         JhN0qPUn837dUYKf8IVM9dYdc46V9WKCWaqUcltgX8H5sIhmqhnxvEoDMMQ6X10cSkPQ
         wH4kOm8vL0TXjySMKs5tpmnVB0QkQA0QjVXsT0FJUBj7Rvg8qBN+1OEPyJoFd4O7aOSe
         VH6Q==
X-Gm-Message-State: APjAAAVcQv86kMVUXNOi/SKRGSdup+kOEuJ8tkQuSIXjsiFRkyfwRpnu
        ytxX+pS6D59crBjArgJFZCtxa5Ro
X-Google-Smtp-Source: APXvYqzgZGN9muTbJEbWi3FYhS6sG+SaYDD3YnVIgnxOAKlBZpTX51LjKgOluJ+5OsVlki9hFpr40g==
X-Received: by 2002:a17:90b:30cc:: with SMTP id hi12mr2676638pjb.80.1574729814960;
        Mon, 25 Nov 2019 16:56:54 -0800 (PST)
Received: from hephaestus.prv.suse.net ([186.212.48.108])
        by smtp.gmail.com with ESMTPSA id w15sm9421223pfi.168.2019.11.25.16.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 16:56:54 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com, Marcos Paulo de Souza <mpdesouza@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/2] btrfs: qgroup: Cleanup quota_root checks
Date:   Mon, 25 Nov 2019 21:58:50 -0300
Message-Id: <20191126005851.11813-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126005851.11813-1-marcos.souza.org@gmail.com>
References: <20191126005851.11813-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Remove some variables that are set only to be checked later, and never
used.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/qgroup.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d4282e12f2a6..417fafb4b4f6 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1243,7 +1243,6 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 			      u64 dst)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
@@ -1259,8 +1258,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 		return -ENOMEM;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	quota_root = fs_info->quota_root;
-	if (!quota_root) {
+	if (!fs_info->quota_root) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1307,7 +1305,6 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 				 u64 dst)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
@@ -1320,8 +1317,7 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	if (!tmp)
 		return -ENOMEM;
 
-	quota_root = fs_info->quota_root;
-	if (!quota_root) {
+	if (!fs_info->quota_root) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1387,11 +1383,11 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	int ret = 0;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	quota_root = fs_info->quota_root;
-	if (!quota_root) {
+	if (!fs_info->quota_root) {
 		ret = -EINVAL;
 		goto out;
 	}
+	quota_root = fs_info->quota_root;
 	qgroup = find_qgroup_rb(fs_info, qgroupid);
 	if (qgroup) {
 		ret = -EEXIST;
@@ -1416,14 +1412,12 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
 	struct btrfs_qgroup_list *list;
 	int ret = 0;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	quota_root = fs_info->quota_root;
-	if (!quota_root) {
+	if (!fs_info->quota_root) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1465,7 +1459,6 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 		       struct btrfs_qgroup_limit *limit)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
 	int ret = 0;
 	/* Sometimes we would want to clear the limit on this qgroup.
@@ -1475,8 +1468,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 	const u64 CLEAR_VALUE = -1;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	quota_root = fs_info->quota_root;
-	if (!quota_root) {
+	if (!fs_info->quota_root) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2578,10 +2570,9 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root = fs_info->quota_root;
 	int ret = 0;
 
-	if (!quota_root)
+	if (!fs_info->quota_root)
 		return ret;
 
 	spin_lock(&fs_info->qgroup_lock);
@@ -2875,7 +2866,6 @@ static bool qgroup_check_limits(struct btrfs_fs_info *fs_info,
 static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 			  enum btrfs_qgroup_rsv_type type)
 {
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 ref_root = root->root_key.objectid;
@@ -2894,8 +2884,7 @@ static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 		enforce = false;
 
 	spin_lock(&fs_info->qgroup_lock);
-	quota_root = fs_info->quota_root;
-	if (!quota_root)
+	if (!fs_info->quota_root)
 		goto out;
 
 	qgroup = find_qgroup_rb(fs_info, ref_root);
@@ -2962,7 +2951,6 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 			       u64 ref_root, u64 num_bytes,
 			       enum btrfs_qgroup_rsv_type type)
 {
-	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
 	struct ulist_node *unode;
 	struct ulist_iterator uiter;
@@ -2980,8 +2968,7 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 	}
 	spin_lock(&fs_info->qgroup_lock);
 
-	quota_root = fs_info->quota_root;
-	if (!quota_root)
+	if (!fs_info->quota_root)
 		goto out;
 
 	qgroup = find_qgroup_rb(fs_info, ref_root);
@@ -3681,7 +3668,6 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
 static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref_root,
 				int num_bytes)
 {
-	struct btrfs_root *quota_root = fs_info->quota_root;
 	struct btrfs_qgroup *qgroup;
 	struct ulist_node *unode;
 	struct ulist_iterator uiter;
@@ -3689,7 +3675,7 @@ static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref_root,
 
 	if (num_bytes == 0)
 		return;
-	if (!quota_root)
+	if (!fs_info->quota_root)
 		return;
 
 	spin_lock(&fs_info->qgroup_lock);
-- 
2.23.0

