Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D48445CD8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 01:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhKEADB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 20:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhKEADA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 20:03:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C96BC061714
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 17:00:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f5so6798713pgc.12
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Nov 2021 17:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYgr+k74JBjR9MNgAm6JwZAR89Qft3pxtejNxGP6vSs=;
        b=GnezObqorQI1A4+/c3U7h/yCKtcHC9QBJvwHoV0Nzx0GRfday2/a64MOi19FJFme83
         Ta3/abtFs/EEckkN7LrQxCZQegamMfcI+qfGSghNuuXGhTGTdExz35GgGNJTH+/BeSIH
         ekNT6NA8oXxxO65u1zh8PWHMKzc0yoo5tDOb92/5HLHSlNf5l0DQeJxW0QZDwtVUvodI
         Osov/ac24BlwShYwfeHFYfuiXMqLV32+kMVIvp3mC0pL/UiK3M9ZhB969sEAqzyW9OSF
         ZQ04VGwvvKdB1Dorq1RfyrZgYXjIFx4YFs1dA35sBfCJWGdJYGZK0fSojxJVQRVCMNeH
         +tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYgr+k74JBjR9MNgAm6JwZAR89Qft3pxtejNxGP6vSs=;
        b=yTQ4rCknIDDbT+pl4PDABZCFx73x+oD5b/Bp9oq5eqMfN1lh6OB2/v/RF9O8+rwLTX
         xmg9sGwJU/PRFf5xNnX2XYw/ZVdAOfqsKBrOvnMITlbsFyGZtE244xsEldEGOjQQCdK5
         YJuWGzkziW9bSolF/qumpQQk1UZXUOKcx9nTL8jT9jTl6IiF5QU9zx/7IRGq1+LBrMYa
         LtdyZXJ6UJF43STpFnC74coXRJvz3WwwRAO/ZpEb+ylJxf5El062W0xwhaxswf/cjJ7h
         NbsN0OOhxn9jWVxqPI8J6SmORbTaleGKU7KZJVLTETnqH9kb4RkvcbcOmxzi05KtC6JT
         Mfsw==
X-Gm-Message-State: AOAM532tYL28cQqJlJ8k8mwpz8SXcKKOYBlbu9ySH7gJdFbXfY1bR5aa
        Mf0zXl9lG1FK4xA3temjduhOfuecYUgbpw==
X-Google-Smtp-Source: ABdhPJyeGn5OAww3aso+7V0/HYV54Y5S9I7RcqgXAD9+b4Jax10uoW29qEp+4RDqDnRxHmBxq919ug==
X-Received: by 2002:a05:6a00:a23:b0:43d:e856:a3d4 with SMTP id p35-20020a056a000a2300b0043de856a3d4mr55822427pfh.17.1636070420519;
        Thu, 04 Nov 2021 17:00:20 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:294c])
        by smtp.gmail.com with ESMTPSA id b28sm4620962pgn.67.2021.11.04.17.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 17:00:20 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: send: remove unused type parameter to iterate_inode_ref_t
Date:   Thu,  4 Nov 2021 17:00:13 -0700
Message-Id: <88987f23b18227e63459842e29f4b70fb5223ef4.1636070238.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1636070238.git.osandov@fb.com>
References: <cover.1636070238.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Again, I don't think this was ever used since iterate_dir_item() is only
used for xattrs. No functional change.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9df4203edb19..9221f6189084 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1004,7 +1004,7 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 typedef int (*iterate_dir_item_t)(int num, struct btrfs_key *di_key,
 				  const char *name, int name_len,
 				  const char *data, int data_len,
-				  u8 type, void *ctx);
+				  void *ctx);
 
 /*
  * Helper function to iterate the entries in ONE btrfs_dir_item.
@@ -1030,7 +1030,6 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 	u32 total;
 	int slot;
 	int num;
-	u8 type;
 
 	/*
 	 * Start with a small buffer (1 page). If later we end up needing more
@@ -1057,10 +1056,9 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 	while (cur < total) {
 		name_len = btrfs_dir_name_len(eb, di);
 		data_len = btrfs_dir_data_len(eb, di);
-		type = btrfs_dir_type(eb, di);
 		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
 
-		if (type == BTRFS_FT_XATTR) {
+		if (btrfs_dir_type(eb, di) == BTRFS_FT_XATTR) {
 			if (name_len > XATTR_NAME_MAX) {
 				ret = -ENAMETOOLONG;
 				goto out;
@@ -1110,7 +1108,7 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 		cur += len;
 
 		ret = iterate(num, &di_key, buf, name_len, buf + name_len,
-				data_len, type, ctx);
+			      data_len, ctx);
 		if (ret < 0)
 			goto out;
 		if (ret) {
@@ -4647,9 +4645,8 @@ static int send_remove_xattr(struct send_ctx *sctx,
 }
 
 static int __process_new_xattr(int num, struct btrfs_key *di_key,
-			       const char *name, int name_len,
-			       const char *data, int data_len,
-			       u8 type, void *ctx)
+			       const char *name, int name_len, const char *data,
+			       int data_len, void *ctx)
 {
 	int ret;
 	struct send_ctx *sctx = ctx;
@@ -4693,8 +4690,7 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 
 static int __process_deleted_xattr(int num, struct btrfs_key *di_key,
 				   const char *name, int name_len,
-				   const char *data, int data_len,
-				   u8 type, void *ctx)
+				   const char *data, int data_len, void *ctx)
 {
 	int ret;
 	struct send_ctx *sctx = ctx;
@@ -4739,10 +4735,9 @@ struct find_xattr_ctx {
 	int found_data_len;
 };
 
-static int __find_xattr(int num, struct btrfs_key *di_key,
-			const char *name, int name_len,
-			const char *data, int data_len,
-			u8 type, void *vctx)
+static int __find_xattr(int num, struct btrfs_key *di_key, const char *name,
+			int name_len, const char *data, int data_len,
+			void *vctx)
 {
 	struct find_xattr_ctx *ctx = vctx;
 
@@ -4792,7 +4787,7 @@ static int find_xattr(struct btrfs_root *root,
 static int __process_changed_new_xattr(int num, struct btrfs_key *di_key,
 				       const char *name, int name_len,
 				       const char *data, int data_len,
-				       u8 type, void *ctx)
+				       void *ctx)
 {
 	int ret;
 	struct send_ctx *sctx = ctx;
@@ -4804,12 +4799,12 @@ static int __process_changed_new_xattr(int num, struct btrfs_key *di_key,
 			 &found_data_len);
 	if (ret == -ENOENT) {
 		ret = __process_new_xattr(num, di_key, name, name_len, data,
-				data_len, type, ctx);
+					  data_len, ctx);
 	} else if (ret >= 0) {
 		if (data_len != found_data_len ||
 		    memcmp(data, found_data, data_len)) {
 			ret = __process_new_xattr(num, di_key, name, name_len,
-					data, data_len, type, ctx);
+						  data, data_len, ctx);
 		} else {
 			ret = 0;
 		}
@@ -4822,7 +4817,7 @@ static int __process_changed_new_xattr(int num, struct btrfs_key *di_key,
 static int __process_changed_deleted_xattr(int num, struct btrfs_key *di_key,
 					   const char *name, int name_len,
 					   const char *data, int data_len,
-					   u8 type, void *ctx)
+					   void *ctx)
 {
 	int ret;
 	struct send_ctx *sctx = ctx;
@@ -4831,7 +4826,7 @@ static int __process_changed_deleted_xattr(int num, struct btrfs_key *di_key,
 			 name, name_len, NULL, NULL);
 	if (ret == -ENOENT)
 		ret = __process_deleted_xattr(num, di_key, name, name_len, data,
-				data_len, type, ctx);
+					      data_len, ctx);
 	else if (ret >= 0)
 		ret = 0;
 
-- 
2.33.1

