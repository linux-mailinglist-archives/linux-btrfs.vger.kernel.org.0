Return-Path: <linux-btrfs+bounces-7380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B0295A6A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 23:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB3DEB21432
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 21:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E610175D27;
	Wed, 21 Aug 2024 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At00u11Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32033170826
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275904; cv=none; b=tXc4hGFnzknJzOqgiB4Hrr1n3cITB3crjNKFzc7MSR7sjqTSP0H8fNMSvfnVa7dk59ytsqKNjGsTRjFmdGwfdSrDRq4sqhjFDwMrveBfppFV9FHJnh8ymaz6/n153g9XfgE3EYvgUIvGaBin1efZT9IilCSD6msO5OmbySU5i40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275904; c=relaxed/simple;
	bh=6NUqZFFotJ7a+vTI6RA7ZP93l32in7xlL4vO4v+kBF0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRRPh4XQ4ovHkOfFi7fli6D0uGywxajs54cPDsCHMkSKagTGxdSXZiNB+4FBb9VAcQKRCGsswvJWyMinNZCid+4yQKBB9/Zj7nKcFJ4jfeND97DyMcYCKAMe2tOIwV6kLgnvcroAmNklyR13/PYiMYhxN2lk4HVr8AU2YEI1ZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At00u11Y; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3dc16d00ba6so83431b6e.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724275902; x=1724880702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH2tPugReCLV+vXuyTlKLsYzPXJpHKCMfoAMe3V6dxU=;
        b=At00u11Y50ytHh4gAX1F+5RUTMftnw8fNO3JvqN6lRntnoyD1kaO+jcZ6bY9CDTmXh
         tGatrK+irJpJtEO9swBsakw1MW+p2VVCVN9+ulKTOqa3I6qDsn75mBVjUNSHtj8dwaWm
         YZzLXSfJLhuezpa92Hk/ZH6+n30DCFGYS+0eIkKTs9QUsqyqAnkOYJGGYJrdKCcQEYpr
         Hgyb3xyl+exNImxEd5gBQZuDQTjMNzjDSq3vOAqLPLq/z/WwMfIxvcqClnyv1R8OSk75
         LnB98vVVgX5FIYy/pzuocDaOOVGH2XqMTvQ8tPj1MdRtqOmO7GW5Y4nMJoo1WAlsgNR5
         fdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275902; x=1724880702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH2tPugReCLV+vXuyTlKLsYzPXJpHKCMfoAMe3V6dxU=;
        b=kgeE1neuwyN8QPTOpvebLIm/8JX+G13YfyLDOHLD4LhA13KkLLMxQ/+rHIaXvZmc9P
         9oesNZ7VB5uHBNQaTFTemerQIVknn+gZY1v+nzS1MYIH0qT0akFTniOE6ReUVaXYVFmF
         yfChdxYzw9tASoR0KdOeDzoJiz8dIJQ4oyZrWmm6o7ZujUJZg5CzOiQ/usTNAVd66EnQ
         7fcKgutwLLXkviKahNY6z4E1CkP0eJtK30Fd6tMx88kxUHJWMUfyZyE7Br3LOHUTFFV2
         NL16v+YNYsuB4LLxW9WD1lW/DHrRQQHt6uKcb8VxojDEaagIXlOFT/OZ6sCkDAqIQ+a4
         OyZQ==
X-Gm-Message-State: AOJu0Yz8JrGIQEDKeYXUZmmGXf19nglVBuvFW6KS3rSLter3E/fiOh/Z
	yAZInZjinPAUxI2wuy5ceFohJZk7ctFG+qn2yqq7dRhdWymKkYxo4SDSwxzP
X-Google-Smtp-Source: AGHT+IHmNHf5KYbAKLYBpYppYaIFagr5OwH7gU784x9s/NJaImfjEOt9dpI4xol7fF8Nbkxi2/pajQ==
X-Received: by 2002:a05:6808:3388:b0:3da:a032:24c5 with SMTP id 5614622812f47-3de195114b0mr3313233b6e.22.1724275901828;
        Wed, 21 Aug 2024 14:31:41 -0700 (PDT)
Received: from localhost (fwdproxy-eag-005.fbsv.net. [2a03:2880:3ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm38258b6e.17.2024.08.21.14.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:31:41 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 1/2] btrfs: move path allocation to btrfs_iget_path
Date: Wed, 21 Aug 2024 14:31:02 -0700
Message-ID: <00afd1d9ea73deccfff4ae7f107d63ddebcdd8dd.1724267937.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724267937.git.loemra.dev@gmail.com>
References: <cover.1724267937.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we're going to keep the conditional path allocation
does it still make sense to move the path allocation from
read_locked_inode?

My understanding of the benefits of moving the path allocation to
btrfs_iget is that there is no need for a conditional path allocation
and as a result the code is easier to reason about and
responsibilities are clearer.

I don't think it makes much of a difference at this point to allocate
in btrfs_iget_path vs. btrfs_read_locked_inode. If I'm missing
something please let me know.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/inode.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8ad540d6de25..74d23d0cd1eb9 100644
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
@@ -3813,20 +3812,11 @@ static int btrfs_read_locked_inode(struct inode *inode,
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
-	if (ret) {
-		if (path != in_path)
-			btrfs_free_path(path);
+	if (ret)
 		return ret;
-	}
 
 	leaf = path->nodes[0];
 
@@ -3960,8 +3950,6 @@ static int btrfs_read_locked_inode(struct inode *inode,
 				  btrfs_ino(BTRFS_I(inode)),
 				  btrfs_root_id(root), ret);
 	}
-	if (path != in_path)
-		btrfs_free_path(path);
 
 	if (!maybe_acls)
 		cache_no_acl(inode);
@@ -5596,8 +5584,9 @@ static struct inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
  * later.
  */
 struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
-			      struct btrfs_path *path)
+			      struct btrfs_path *in_path)
 {
+	struct btrfs_path *path = in_path;
 	struct inode *inode;
 	int ret;
 
@@ -5608,7 +5597,20 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
+	if (!path) {
+		path = btrfs_alloc_path();
+		if (!path) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+	}
+
 	ret = btrfs_read_locked_inode(inode, path);
+
+	if (path != in_path)
+		btrfs_free_path(path);
+
 	/*
 	 * ret > 0 can come from btrfs_search_slot called by
 	 * btrfs_read_locked_inode(), this means the inode item was not found.
-- 
2.43.5


