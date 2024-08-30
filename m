Return-Path: <linux-btrfs+bounces-7700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939D7966A69
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 22:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98881C2165B
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEC51BF7FC;
	Fri, 30 Aug 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtVNtTgS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5D1BD503
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049534; cv=none; b=cFbg+J7i83LAbO+zRnzUq6EkHyxhqWJ2CNWA6DMEjlrpryA5q0+j/YTwvseFgQeX/Uw+x+FGjg43q038f/gTINPQ7LT4jmw2+MO2w+3UB0Wq9m062vxuEuYLYfdSQRa1sLauS4YOXG9CSoHSLvFWueS8V5iUSoy7CloV4GeZ4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049534; c=relaxed/simple;
	bh=kqu3UFTtViNPx941VnSyTnq23AgoM4A1L59U+vZjIVs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQXi7pF/zmTVmKrdjw69wU3gGFBrodHEukv1sRD8liUL83XbBpuVtjy6WrWvEa3B+Uvb5We5+e/uYHlvQwakP2MPa7YI6ilE5EtuaolpPIXYcCTX5QrzvQVUvSiFdt4BbNJo6OfuuRig/IZMcdx88O2HGm+Tbl8UheBXEOS3c3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtVNtTgS; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-70f60d73436so1298570a34.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049532; x=1725654332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/R6c+2xa/lb1gVE0PSUlSGWED0gxm7v/GXUI9/6qG58=;
        b=QtVNtTgSSkbSyypcQfyOmksGpftb0wCvkrsrD3T3ouA0ajT+k67S16MPPpUibRsZOO
         Ly/aaf01xkh8sR4XXI0rJeN2pxND5Gx5oYB7QsBQJU8xrXckEZmac9VL9NZ/swseWt34
         XiKEfNTZQMpQLyTUEUBnq/aU4tq2A5/KHum4J7QGaMo6lrF/FfDJDg2acqt9OgM5esJH
         WDX1i3Z1XzobAPVnOlOLoCI6ILxIV0vWT2Dm+fq+bFwNZoD1EUsPegu5qc3YQvpqw99F
         Zv1Kf1nNFFSED5fGxdnFm0Wi0nJJBWxLvAL1EjbRWjVMd8xfROIIhbB3dt0SIt9NJI/6
         P5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049532; x=1725654332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/R6c+2xa/lb1gVE0PSUlSGWED0gxm7v/GXUI9/6qG58=;
        b=VHCcLKriHsqJng/SYDomHmdM7kcx671OKTdvJtpEjw/Ya82HQKXQDZ18AdLMZNkifB
         0qFDCxsAhtSjMbZAyQBROXWdcYL/8kzSBOVhcpCweslMUh7CvA2RGNzs7G2Wf7t/e+qO
         AJdaNl8X12OdD6coTn6dLwr1PXwghKIUSbjxHPAsl/9F87dyC083LImP+1dYxqA9/YmE
         mmk9UDa8UV39o/hROpzgE69Uz3kjtbm7yGr1qde9gz8Knau6HKvIfkCBXr0AVY+s48N4
         sbtPrF6ic8rSuXh18GZtsWP5RtrNxPpvdyRzhf72wGHhRcSd1+ERC2Hpe/9Ny2hdBYOk
         mcVA==
X-Gm-Message-State: AOJu0YxgV8R2hvCKqYf1N8xxwskQHhHL5JxAKmMbdbbXqLMzcZ3m0Xjc
	PheHz6yADhTa1/+yiJLGr/fD8hIhkiKbsdbVhQ3v0Xy1sHdc3JtFVftnmyK8
X-Google-Smtp-Source: AGHT+IHlJ3awfdTBkv6FbNc7yhKVaS8X+h02MxCREtDrcQ+GuV7VDsohHN/QQkAICO04Z0TgZTDsfw==
X-Received: by 2002:a05:6830:6991:b0:6f9:6577:71c3 with SMTP id 46e09a7af769-70f5c353e80mr7093055a34.6.1725049532115;
        Fri, 30 Aug 2024 13:25:32 -0700 (PDT)
Received: from localhost (fwdproxy-eag-114.fbsv.net. [2a03:2880:3ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671cf763sm629840a34.80.2024.08.30.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:25:31 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 2/2] btrfs: remove conditional path allocation
Date: Fri, 30 Aug 2024 13:24:55 -0700
Message-ID: <070163e08339759d751bf956bd7084772efbb074.1724970046.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724970046.git.loemra.dev@gmail.com>
References: <cover.1724970046.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove conditional path allocation from btrfs_read_locked_inode. Add
an ASSERT(path) to indicate it should never be called with a NULL path.

Call btrfs_read_locked_inode directly from btrfs_iget. This causes
code duplication between btrfs_iget and btrfs_iget_path, but I
think this is justifiable as it removes the need for conditionally
allocating the path inside of read_locked_inode. This makes the code
easier to reason about and makes it clear who has the responsibility of
allocating and freeing the path.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/inode.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index df0fe5e79ea2..a4b4e4190624 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3821,10 +3821,9 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
  * on failure clean up the inode
  */
 static int btrfs_read_locked_inode(struct inode *inode,
-				   struct btrfs_path *in_path)
+				   struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct btrfs_path *path = in_path;
 	struct extent_buffer *leaf;
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -3844,18 +3843,12 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	if (!ret)
 		filled = true;
 
-	if (!path) {
-		path = btrfs_alloc_path();
-		if (!path)
-			goto error;
-	}
+	ASSERT(path);
 
 	btrfs_get_inode_key(BTRFS_I(inode), &location);
 
 	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
 	if (ret) {
-		if (path != in_path)
-			btrfs_free_path(path);
 		/*
 		 * ret > 0 can come from btrfs_search_slot called by
 		 * btrfs_lookup_inode(), this means the inode was not found.
@@ -3997,8 +3990,6 @@ static int btrfs_read_locked_inode(struct inode *inode,
 				  btrfs_ino(BTRFS_I(inode)),
 				  btrfs_root_id(root), ret);
 	}
-	if (path != in_path)
-		btrfs_free_path(path);
 
 	if (!maybe_acls)
 		cache_no_acl(inode);
@@ -5608,9 +5599,8 @@ static struct inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
 
 /*
  * Get an inode object given its inode number and corresponding root.
- * Path can be preallocated to prevent recursing back to iget through
- * allocator. NULL is also valid but may require an additional allocation
- * later.
+ * Path is preallocated to prevent recursing back to iget through
+ * allocator.
  */
 struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 			      struct btrfs_path *path)
@@ -5633,9 +5623,35 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	return inode;
 }
 
+/*
+ * Get an inode object given its inode number and corresponding root.
+ */
 struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 {
-	return btrfs_iget_path(ino, root, NULL);
+	struct inode *inode;
+	struct btrfs_path *path;
+	int ret;
+
+	inode = btrfs_iget_locked(ino, root);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	if (!(inode->i_state & I_NEW))
+		return inode;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	ret = btrfs_read_locked_inode(inode, path);
+
+	btrfs_free_path(path);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	unlock_new_inode(inode);
+	return inode;
 }
 
 static struct inode *new_simple_dir(struct inode *dir,
-- 
2.43.5


