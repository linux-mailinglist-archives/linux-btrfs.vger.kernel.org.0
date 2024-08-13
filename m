Return-Path: <linux-btrfs+bounces-7173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ADB950DF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 22:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86BE283CE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A961A7079;
	Tue, 13 Aug 2024 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv1ALKOB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA61A704C
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580929; cv=none; b=biMhRKNr2VMyGov3O0gA69sA3umMiMCn+YKq4meiqNpiP0Gz7bqi1l5KUG6lrtO3Iu3f6sznhTLplqsgmFaKfRJ2ceZAvltPPu4nY2e4fZtkgBpMF1gI8l8kKQn2AiI5zIosZMcCaK09MI5IEnU1nvTFdYryuPfVruxNYccbIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580929; c=relaxed/simple;
	bh=/QpSYBXZxqq8cC7vObgHtgfyIp9Xhix6zVvkB668hQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKOmpyLANxN9abEymZI+nqRKaRJWzLqxicWTPejLzddUydjfaYugqG1AC/NKRiECp8aO63G4bF0wAkCHHsDc5z33bHCoNc69dfftHITxexWc0Y3oT47E1tidohvtav3irD+1oLBbeunOoA10cCXGQd6Z5ViZ5IMZjUQQtxGLtbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv1ALKOB; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-5c6661bca43so3570585eaf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723580926; x=1724185726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYC939saW2kaH7ySIzvrlOu/HE0C3y2adVWhEi9AQtc=;
        b=Cv1ALKOBykbH8JuBI5WXY7/ZoALUSNrlb6RnEEko0LvEfA4EDT7zR2W9lIhS2tFG30
         GOfI82FggUatS6gwaZKtZJvZQNiyhvroFq3xMqiw2SoxCOc3b0e3GOy0NUPrdrQ8H1Rf
         h+/gR7QpsoN/fjm/7zbe1ttaI6667mkc+mWsXPkRmwa8Zp0238qdAglBcXnibk1JnQ9z
         UhC1Jn1l8TiDfnMZj0KCEZgJSYMk48fb9ueQsduTHajOXnyxURT/7q0Fvrd6zHjJfTPU
         yvQZFUYk/q2+iX/tsD+nYtvAjbQAFt7umuXYxp16eSSr9XYcJ0GQwKTJHgX7chP3UVLZ
         dBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580926; x=1724185726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYC939saW2kaH7ySIzvrlOu/HE0C3y2adVWhEi9AQtc=;
        b=oLf2c8g1sHTj/rWTfDXpd8CGYMK19KmJC2UgrNjEClp8p39hhB+pYzTrEXDBbNhQt0
         ftAnYaKJbjomKhw9c3GNWyC7BMIIvuKLK4OC7AS4Mi39V6xEj8C7r4PgpUmGOHMMgey1
         07zle8DyFdRNrjRYiecf9HxCLWsEu477uXyRAIWz0CwZWTsb5Gm7q/Ed+Be/ItaS3Oi4
         9Oj9g1xsZKYbhDbkD+nXEtaIEFOYjPIIJ2/PbPRibk2u6MmgeREqRofUvSWAbIH6i+pE
         F7jL9vrdvKPXOWgghoOFSRtS7a9R0KmIxEgKmrtympJP57SfNidPC0Fw+qQdMxJl1yzT
         Pcwg==
X-Gm-Message-State: AOJu0YwmM+qMEzPqJBpz6ohfl6SSddSnlXfXuOSC7JXdcpdtB6DUC5Hi
	T/Vlrxi51cEag9AEkE/dwi9WQcjLfADJj4byJF8esyZKxNgXouJ1dhLfrE1M
X-Google-Smtp-Source: AGHT+IGHdHBKZ6Iy83UyYqtU6V3x1OFWvZW3HJNy+j+7/ZLwdTxodg6uzZ62j5IoTdN73zjD3BvOKg==
X-Received: by 2002:a05:6820:2295:b0:5d5:c3a9:4010 with SMTP id 006d021491bc7-5da7c6ec41fmr1129549eaf.5.1723580925939;
        Tue, 13 Aug 2024 13:28:45 -0700 (PDT)
Received: from localhost (fwdproxy-eag-008.fbsv.net. [2a03:2880:3ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5da72dc20d2sm337395eaf.23.2024.08.13.13.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:28:45 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: remove conditional path allocation from read_locked_inode, add path allocation to iget
Date: Tue, 13 Aug 2024 13:27:33 -0700
Message-ID: <32dea3edada81f7901f7f7e39f4e3729888dea46.1723580508.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1723580508.git.loemra.dev@gmail.com>
References: <cover.1723580508.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the path allocation from inside btrfs_read_locked_inode to
btrfs_iget. This makes the code easier to reason about as it is clear
where the allocation occurs and who is in charge of freeing the path.
I have investigated all of the callers of btrfs_iget_path to make sure 
that it is never called with a null path with the expectation
of a path allocation. All of the null calls seem to come from btrfs_iget
so it makes sense to do the allocation within btrfs_iget.

---
 fs/btrfs/inode.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 07858d63378f..b89b4b1bd3da 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3790,10 +3790,9 @@ static int btrfs_init_file_extent_tree(struct btrfs_inode *inode)
  * read an inode from the btree into the in-memory inode
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
@@ -3813,18 +3812,10 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	if (!ret)
 		filled = true;
 
-	if (!path) {
-		path = btrfs_alloc_path();
-		if (!path)
-			return -ENOMEM;
-	}
-
 	btrfs_get_inode_key(BTRFS_I(inode), &location);
 
 	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
 	if (ret) {
-		if (path != in_path)
-			btrfs_free_path(path);
 		return ret;
 	}
 
@@ -3960,8 +3951,6 @@ static int btrfs_read_locked_inode(struct inode *inode,
 				  btrfs_ino(BTRFS_I(inode)),
 				  btrfs_root_id(root), ret);
 	}
-	if (path != in_path)
-		btrfs_free_path(path);
 
 	if (!maybe_acls)
 		cache_no_acl(inode);
@@ -5631,7 +5620,15 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 
 struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 {
-	return btrfs_iget_path(ino, root, NULL);
+	struct btrfs_path *path = btrfs_alloc_path();
+
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	struct inode *inode = btrfs_iget_path(ino, root, path);
+
+	btrfs_free_path(path);
+	return inode;
 }
 
 static struct inode *new_simple_dir(struct inode *dir,
-- 
2.43.5


