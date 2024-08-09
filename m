Return-Path: <linux-btrfs+bounces-7078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B521A94D908
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 01:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C583B225DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 23:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12316D4E5;
	Fri,  9 Aug 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O35PwDBm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF43168490
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723245191; cv=none; b=UEn0wE1RMh5Jx4ixaRNLa109o192DkM5uQBxSLWd2j5SLsEnkOSKwqzF2diVC7IOp4eSYR1ueQSzNUyztAKL8zqCUqG9Z8R1xsWp39OC3QFk4ti7L9eNY7R85cDqf5cDLOBUPDffAnRosY33ukGlt/31rqbiw2KzAyoGmUPv5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723245191; c=relaxed/simple;
	bh=XogM9MZf83Rh04Ww8e2u/feKdrAGX7dYiHwjV043OC8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0BcCcRcZjhcwdbiuTKjooC2rqI1KtoBvFZJP+KS4pEr7MdJ6VBensSyr63H4iG3pqbaeyo/xbBuptSVNds1U0xGWNH4l8sHxVHSzXV4NnnQ2am0pDMvmtUU4bSBTH+clV5e3RnhbwK+08pEiL2JfIrLi9nQdRL3wu50Mq671cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O35PwDBm; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3db35ec5688so1553123b6e.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2024 16:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723245188; x=1723849988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvDzw+bJFK2QkWo1B/Ta98uLYB+B9NbfDHmU+mKJV7o=;
        b=O35PwDBmV8m+/Z+pNbKpuojfUcEB/vdYMZKwPwmwOpgYtbq74DYrP66eqqZik8XYRt
         FV7GMx4mYR1YikO6RrBPclRuWObNPum1F0qa3zeVFeISDgZN42v6kvr5qCMbHomvTGdZ
         mGaC9iEEXOCaRMA3WGXKdUmLk/3HkRWn2m+sZYxxFlVvi539JlN2PMSxlnwIVYyMmPEy
         2QBySs0WSyML9DwoZZRfOeZMP0ZjzMP84YGqJrOMOwK7oOBgW9e1pmkA0UW0ZDRSF5Ho
         VIGPIE9PV9K4vap0dMi8E076VhsHbkbLzupM/KSR2ctmHET5m7DK3GNtKPahle2lQfBV
         TqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723245188; x=1723849988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvDzw+bJFK2QkWo1B/Ta98uLYB+B9NbfDHmU+mKJV7o=;
        b=h+zuNhFfAdtn9fFz2CuE0aSreHLmpIPE4iYGfHDq/2liZ1dGe71q1Tf5BjY1858FY3
         nJ5Q/L8OTv3kzgaEyXS2G/je1tNxi/PbC/2mBeIAySOvRaQ1j6Mvy6CWEEKVJ8h7zcwQ
         ahpHoTJ4BgfQscHkJgPVI98W4gnsimoaGy7i7RMqXgKZsoGim1FWH99+n3oTlb5XkuD9
         NsXaSGUHGBqIcAEFSlEk4ff4706TkdukPHJAIPx42zUaIO7w3vRvH1wiVrp9C2BZgKyU
         e5qN6A2qsUtQ4QghKvE08u+jkokxm43j4MMMfGp+1Fm7afz2Z/CgH1D62C5unYwR2XgS
         OstQ==
X-Gm-Message-State: AOJu0YyvnIJghgToyj3u6VOEWPomFjXhRYm2oaGwWti60QP40X6Ydqsu
	PEn7F26saRgJkip1Q1GlIaxtbxMrw5xMkMffwAycVnYf0INLFTzUTZ0181yC
X-Google-Smtp-Source: AGHT+IHGDwh6Y76WQMyE/G1t8C0BUFbyVasw2HbBvJcJ4g0W0gcq1Jp/coCCPOpenXFJeIIkXdKg5g==
X-Received: by 2002:a05:6808:1782:b0:3d8:4603:e7a3 with SMTP id 5614622812f47-3dc41677437mr3656109b6e.1.1723245188015;
        Fri, 09 Aug 2024 16:13:08 -0700 (PDT)
Received: from localhost (fwdproxy-eag-112.fbsv.net. [2a03:2880:3ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd060bc058sm142655b6e.48.2024.08.09.16.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:13:07 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: use __free to automatically free btrfs_path on exit
Date: Fri,  9 Aug 2024 16:11:49 -0700
Message-ID: <d7b68e60fac6c4d73214854f08cf755f781edf00.1723245033.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1723245033.git.loemra.dev@gmail.com>
References: <cover.1723245033.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces the __free attribute to xattr.c. Marks the path variable in
the btrfs_getxattr(), btrfs_setxattr(), and btrfs_listxattr() functions
with the __free(btrfs_free_path) attribute. When a variable is marked
with the __free attribute, the kernel will automatically call the
specified function (in this case, btrfs_free_path()) on the variable
when it goes out of scope. This ensures that the memory allocated for
the variable is properly released, preventing potential memory leaks. By
using the __free attribute, we can simplify the code and reduce the risk
of memory-related bugs.

Test Plan:
Built and booted the kernel with patch applied
Ran btrfs/fstests to make sure that no regressions were introduced

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/xattr.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 738c7bb8ea7c..a8d5db02202b 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -29,9 +29,8 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_path *path;
+	struct btrfs_path *path __free(btrfs_free_path) = NULL;
 	struct extent_buffer *leaf;
-	int ret = 0;
 	unsigned long data_ptr;
 
 	path = btrfs_alloc_path();
@@ -42,24 +41,20 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
 	di = btrfs_lookup_xattr(NULL, root, path, btrfs_ino(BTRFS_I(inode)),
 			name, strlen(name), 0);
 	if (!di) {
-		ret = -ENODATA;
-		goto out;
+		return -ENODATA;
 	} else if (IS_ERR(di)) {
-		ret = PTR_ERR(di);
-		goto out;
+		return PTR_ERR(di);
 	}
 
 	leaf = path->nodes[0];
 	/* if size is 0, that means we want the size of the attr */
 	if (!size) {
-		ret = btrfs_dir_data_len(leaf, di);
-		goto out;
+		return btrfs_dir_data_len(leaf, di);
 	}
 
 	/* now get the data out of our dir_item */
 	if (btrfs_dir_data_len(leaf, di) > size) {
-		ret = -ERANGE;
-		goto out;
+		return -ERANGE;
 	}
 
 	/*
@@ -73,11 +68,7 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
 				   btrfs_dir_name_len(leaf, di));
 	read_extent_buffer(leaf, buffer, data_ptr,
 			   btrfs_dir_data_len(leaf, di));
-	ret = btrfs_dir_data_len(leaf, di);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return btrfs_dir_data_len(leaf, di);
 }
 
 int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
@@ -86,7 +77,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 	struct btrfs_dir_item *di = NULL;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	struct btrfs_path *path __free(btrfs_free_path) = NULL;
 	size_t name_len = strlen(name);
 	int ret = 0;
 
@@ -214,7 +205,6 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		 */
 	}
 out:
-	btrfs_free_path(path);
 	if (!ret) {
 		set_bit(BTRFS_INODE_COPY_EVERYTHING,
 			&BTRFS_I(inode)->runtime_flags);
@@ -280,7 +270,7 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	struct btrfs_key key;
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_path *path;
+	struct btrfs_path *path __free(btrfs_free_path) = NULL;
 	int iter_ret = 0;
 	int ret = 0;
 	size_t total_size = 0, size_left = size;
@@ -356,8 +346,6 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	else
 		ret = total_size;
 
-	btrfs_free_path(path);
-
 	return ret;
 }
 
-- 
2.43.5


