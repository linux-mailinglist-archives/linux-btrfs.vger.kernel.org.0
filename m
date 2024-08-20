Return-Path: <linux-btrfs+bounces-7344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B9958F13
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 22:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972761F23D64
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 20:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEC51C37A4;
	Tue, 20 Aug 2024 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azGRy6tO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5881C37A3
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184831; cv=none; b=ovUgWKMXKdRnE2ieE6Pe8103S0orldNgkJmrQeBXUodXvRNww/qXzI0qI000dZlIkT35dhOfhI4DxvafTEEyeOwhdQwIIrq4punQK8MjFohJQo3h3rBnbQEO9ZVNDy16yO1pZNk7Q4kIDzc2SVWWJkylHmXA4MJZ8f8Yn8re6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184831; c=relaxed/simple;
	bh=O8V3eH/rKGr520DaDTqY9ch+GuZcFemzL+NKd8NLHWs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRqsenXzSoEPXKshKz2Wl8iTETLqMWOAmBIqvi/Ek0zrRuokCvFt3oku0vzMDalgJa3V069M6z0RXdxJuC3jL+ir5SHaLkgYomvforHAXzO9rpNLzAab4SIDvWhkCGykOgsLyaidFR/05hSR6MtSaORM2VPPiTwzAlATlgtOIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azGRy6tO; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-3db18c4927bso3351560b6e.1
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724184829; x=1724789629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+AJcbxw1ym5nhBriORjo5dFxe1Q9MhybF9bfCe6J2w=;
        b=azGRy6tOdHXoCACNoUB7iSXeK59YMNjfltfKX1iVX2WZM8f4OeIny7Pqgy9ewuRDfN
         AKHedI5Fe+XMv1zEk+2PcQYLUy1Ca/Va6tdKibg1D7vhrv7nZ5N1REcAsAeUTUkhZNZo
         OPGDMlLnUwSCaQaVZ1FV79zH8yreAk2OGdpOczJ8DdjwzJ092UptNdtEV067bfAgdrsl
         SwTIJekWtFxejtuuz+DRuL8ZnybS4ESzxO70+NBw6rMcmr3TO5845qY/Ylf9lZHxZWcx
         KM6oQmyIHHAPm5IKJl52MLLEz1Ol0Ake+Xm+nbKcbO1x8ftxoEg7MbRvQwtjuX1cBo1Y
         fNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724184829; x=1724789629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+AJcbxw1ym5nhBriORjo5dFxe1Q9MhybF9bfCe6J2w=;
        b=v0FKEzZyJKnhieDrwMkR8HNuWWItgz+2x71D4FwsDAz2vEe71Ewjb1X90ZQEODl4QE
         Wke44dbaNM2VQ5qaouqq7dmpMtdqfHQgE9RYB/NW0y64r8oxH0Vbsmz2sm/GfYaYfBhD
         u5SWnSYgM9zj4ZwjP6shIkh6eSo9U2LXLgADfb/nXUNZa+3a4SndYPwu+FgvrQSrXTde
         uQQxFYggc/lHVlXZGBiOHsPtllVEW2Czfw7LQNZX0sTJAhudPJAY5TV+6TnWG30H07b+
         JkYlSxZGq4kZ2nCU1PZDmY3hPUuAe8E5X3YO2grYxG3bmtqQ/1digv+S4rF1XKH6Cvld
         pNCQ==
X-Gm-Message-State: AOJu0YzvwhqGASKtHul3RtKDw1e1F5k/9hMfABP1HQbj4gsZDMHVorww
	mwIBolaWXAjDw3GiSNLfII5Bp//vRoww4MKlieq5pCrZbbuM5HZNjrO4MLJj
X-Google-Smtp-Source: AGHT+IHc6DJ0r9GLYffwn7Sjbbn82jPts1a4hsL9uTsRAPlqu9ec6sbPYJZWMl6ajOGoSJPcHAKxPw==
X-Received: by 2002:a05:6808:f04:b0:3d5:64f3:df63 with SMTP id 5614622812f47-3de194f5de4mr560229b6e.17.1724184828804;
        Tue, 20 Aug 2024 13:13:48 -0700 (PDT)
Received: from localhost (fwdproxy-eag-007.fbsv.net. [2a03:2880:3ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd4236b798sm2329116b6e.5.2024.08.20.13.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 13:13:48 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs: remove conditional path allocation from read_locked_inode, add path allocation to iget
Date: Tue, 20 Aug 2024 13:13:18 -0700
Message-ID: <652ef8f5f0b46c2488a2f72bf34a83d9bc8357db.1724184314.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724184314.git.loemra.dev@gmail.com>
References: <cover.1724184314.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the path allocation from inside btrfs_read_locked_inode
to btrfs_iget. This makes the code easier to reason about as it is
clear where the allocation occurs and who is in charge of freeing the
path. I have investigated all of the callers of btrfs_iget_path to make
sure that it is never called with a null path with the expectation
of a path allocation. All of the null calls seem to come from btrfs_iget
so it makes sense to do the allocation within btrfs_iget.

---
 fs/btrfs/inode.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8ad540d6de2..f2959803f9d7 100644
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
@@ -3813,20 +3812,13 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	if (!ret)
 		filled = true;
 
-	if (!path) {
-		path = btrfs_alloc_path();
-		if (!path)
-			return -ENOMEM;
-	}
+	ASSERT(path);
 
 	btrfs_get_inode_key(BTRFS_I(inode), &location);
 
 	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
-	if (ret) {
-		if (path != in_path)
-			btrfs_free_path(path);
+	if (ret)
 		return ret;
-	}
 
 	leaf = path->nodes[0];
 
@@ -3960,8 +3952,6 @@ static int btrfs_read_locked_inode(struct inode *inode,
 				  btrfs_ino(BTRFS_I(inode)),
 				  btrfs_root_id(root), ret);
 	}
-	if (path != in_path)
-		btrfs_free_path(path);
 
 	if (!maybe_acls)
 		cache_no_acl(inode);
@@ -5632,7 +5622,17 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 
 struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 {
-	return btrfs_iget_path(ino, root, NULL);
+	struct btrfs_path *path;
+	struct inode *inode;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	inode = btrfs_iget_path(ino, root, path);
+
+	btrfs_free_path(path);
+	return inode;
 }
 
 static struct inode *new_simple_dir(struct inode *dir,
-- 
2.43.5


