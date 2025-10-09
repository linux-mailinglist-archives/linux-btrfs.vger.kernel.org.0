Return-Path: <linux-btrfs+bounces-17572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BABEBC7E87
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 10:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A911019E8281
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88862E88B7;
	Thu,  9 Oct 2025 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF9Acp4Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B2025A2C7
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996806; cv=none; b=gfUaA02epkNpJL4iZV139kjnDelQuzrzW3L7RbIKguf5pA9rxl084SY8LLKQb96fkaUIGNRAFKPILZjt4I5SCRyKDWNUyDDPcv3kM++a3rOiWqJSFTuu6r8kCsWf7ydSuXYHgxMba8260hYlltgT6lpeFVii/Zp9oZQ9doS/AZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996806; c=relaxed/simple;
	bh=2QbAfN1sDtH46T0pCil6VIq2aE98LlEN+X//kMc9EFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nashJyBhtTSED97OgYFNlFGQkh4U24ZFMc4vVEv1cMiW06qoitOIYX46fsDTj45v1fbwnw7txBzIbRhsUHcJPTDrC5qPGdiE5HpWM1NBlU8kP+2WU+nySsFWRfZnmZg7kujTsaCtmSup+QlY6yj+Sfa2HKwZ7DMppwiLVk8q/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF9Acp4Z; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so1240894a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996801; x=1760601601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcQp0Bvlo76VjH/2Gk47KW1XiQMa/UaY/lp0sfvKhm8=;
        b=LF9Acp4Z0v/otroXtjSTqW3xlQnBsb7MuvlVLBETK5o+7XrUh5w5r5nGGSYpX1j0Bb
         7i053xdG/e+wuOcCAvQwYddSFkwGnz25Wg8cHVeNdeoN0oNfEnAdWYWt+YmT58C+xzn6
         CMq4s6GDjq71u5pQm/lSm+6kEXiOAoQ6RT6PyMX2bvbEifNZNEIhyse+aX4BdyD+okaa
         JEpzU+w0Ix2tp4ovi0zcNCQH8hLAvddj6vBhcTYVUwbFmb6gIwjoUogoICD+fou9CdLi
         mnNN5fyvNu5h2Kr7l8jB9SZJwUadhkVqj6p303P7nlH+j0ilcxwRQJaVtVVArL5gXomV
         Tq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996801; x=1760601601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcQp0Bvlo76VjH/2Gk47KW1XiQMa/UaY/lp0sfvKhm8=;
        b=heuMPP20J+dUyre2WCtyxhtuQXqkc1B5Y3Ho+43XtksEKjpvgvcOLa9gUj2KUHpWcJ
         3Z0PAt06IbO8H3EnJNRHcWrfoXStpkzL4kaTQRFRYYps2mrZWq4ddC7Y/5c7VcmdnIPh
         E4ZLiwBgIYJaZSc0q8lnjdlg8Yr9UA/2eD47eWU5bW2KDG9fhyRsKis6XqVVoqG+tzHi
         b/g2XGZN10UJZvWlLhSPnXr1EFmNJRkBt1THsRsKylJ+xvtKcCPht00AG/sROJ/k9DhD
         rrkSSkzQRYtmERNxacUNg8KG1JqY5DyV1DNfqPJbIdzI4WR5h9bwVEghDZ8jClWqW4GE
         asiw==
X-Forwarded-Encrypted: i=1; AJvYcCXXWow798ew1IRl9duNoGgHdhD8Td7FF+iL7/MnmyJu3TbZzfg3zCYzTM6YXcvyoLAjiSWy4bJ/pZ4f2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1LSOiGJBD83KbSWlKJKFUF4cRLMM3teYsiq91ApSgLl1kODt8
	/JNtRni/cRyca0xvcxAg3Pi8BVxI687BqeM6mz6tv+orruu2xCZh0iO8
X-Gm-Gg: ASbGnctQyhLuFmrp0ZHzFOztNXY31DLJkmqWW4N9Wz5li6woMBK5hZ2SSc1YhWbuZhl
	VsbPicqz2MkH8VDzwd0H84zROaZ7C8uf1J1V/Zwmx4C5QnlNCdCDow9L8VfLkFtNXJES0o/GcUK
	h5KYb+0zZjQkYH1hjUA1lIRs2hwt/emDzDlYePQKc6hWAQIjZWonmpEN2VlPcEwHmGU6zG9b6DO
	MDP4L2q7sWgsWY4az3cmdpbM46q2e+odieMq4aPsSWilkrbgLja3JSxt2D0giTVc3UTwpdoecp3
	eOrOUNZApCBIH5YkQ54vGDvHCYlPWFp4IiVGDciR7WRIwZH6nl08uG0bCgYWWzXW+Aw7Lp+2fVw
	K+uE07ZWqEimqsQsV16pMCiFzMN7pctnwjM5plGayu6KrCuaimFm5GhMAOOEVdMvW2f8OYhN7/D
	2edlHWd1w1+5ZxN/ZbdpM++Q==
X-Google-Smtp-Source: AGHT+IHI7X0nz7MjsrUKXypB4cmDE9TvfyLdOuNT3vqztpfqSus7Fl9xUq6dWkzlfRFPUljWQHHtvA==
X-Received: by 2002:a17:907:9447:b0:b04:3302:d7a8 with SMTP id a640c23a62f3a-b50aca012f2mr709847066b.58.1759996801156;
        Thu, 09 Oct 2025 01:00:01 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:00:00 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v7 12/14] nilfs2: use the new ->i_state accessors
Date: Thu,  9 Oct 2025 09:59:26 +0200
Message-ID: <20251009075929.1203950-13-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

cheat sheet:

If ->i_lock is held, then:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)

 fs/nilfs2/cpfile.c |  2 +-
 fs/nilfs2/dat.c    |  2 +-
 fs/nilfs2/ifile.c  |  2 +-
 fs/nilfs2/inode.c  | 10 +++++-----
 fs/nilfs2/sufile.c |  2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index bcc7d76269ac..4bbdc832d7f2 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -1148,7 +1148,7 @@ int nilfs_cpfile_read(struct super_block *sb, size_t cpsize,
 	cpfile = nilfs_iget_locked(sb, NULL, NILFS_CPFILE_INO);
 	if (unlikely(!cpfile))
 		return -ENOMEM;
-	if (!(cpfile->i_state & I_NEW))
+	if (!(inode_state_read_once(cpfile) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(cpfile, NILFS_MDT_GFP, 0);
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index c664daba56ae..674380837ab9 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -506,7 +506,7 @@ int nilfs_dat_read(struct super_block *sb, size_t entry_size,
 	dat = nilfs_iget_locked(sb, NULL, NILFS_DAT_INO);
 	if (unlikely(!dat))
 		return -ENOMEM;
-	if (!(dat->i_state & I_NEW))
+	if (!(inode_state_read_once(dat) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(dat, NILFS_MDT_GFP, sizeof(*di));
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index c4cd4a4dedd0..99eb8a59009e 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -188,7 +188,7 @@ int nilfs_ifile_read(struct super_block *sb, struct nilfs_root *root,
 	ifile = nilfs_iget_locked(sb, root, NILFS_IFILE_INO);
 	if (unlikely(!ifile))
 		return -ENOMEM;
-	if (!(ifile->i_state & I_NEW))
+	if (!(inode_state_read_once(ifile) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(ifile, NILFS_MDT_GFP,
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 87ddde159f0c..51bde45d5865 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -365,7 +365,7 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 
  failed_after_creation:
 	clear_nlink(inode);
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_once(inode) & I_NEW)
 		unlock_new_inode(inode);
 	iput(inode);  /*
 		       * raw_inode will be deleted through
@@ -562,7 +562,7 @@ struct inode *nilfs_iget(struct super_block *sb, struct nilfs_root *root,
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_once(inode) & I_NEW)) {
 		if (!inode->i_nlink) {
 			iput(inode);
 			return ERR_PTR(-ESTALE);
@@ -591,7 +591,7 @@ struct inode *nilfs_iget_for_gc(struct super_block *sb, unsigned long ino,
 	inode = iget5_locked(sb, ino, nilfs_iget_test, nilfs_iget_set, &args);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
 	err = nilfs_init_gcinode(inode);
@@ -631,7 +631,7 @@ int nilfs_attach_btree_node_cache(struct inode *inode)
 				  nilfs_iget_set, &args);
 	if (unlikely(!btnc_inode))
 		return -ENOMEM;
-	if (btnc_inode->i_state & I_NEW) {
+	if (inode_state_read_once(btnc_inode) & I_NEW) {
 		nilfs_init_btnc_inode(btnc_inode);
 		unlock_new_inode(btnc_inode);
 	}
@@ -686,7 +686,7 @@ struct inode *nilfs_iget_for_shadow(struct inode *inode)
 			       nilfs_iget_set, &args);
 	if (unlikely(!s_inode))
 		return ERR_PTR(-ENOMEM);
-	if (!(s_inode->i_state & I_NEW))
+	if (!(inode_state_read_once(s_inode) & I_NEW))
 		return inode;
 
 	NILFS_I(s_inode)->i_flags = 0;
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 330f269abedf..83f93337c01b 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -1226,7 +1226,7 @@ int nilfs_sufile_read(struct super_block *sb, size_t susize,
 	sufile = nilfs_iget_locked(sb, NULL, NILFS_SUFILE_INO);
 	if (unlikely(!sufile))
 		return -ENOMEM;
-	if (!(sufile->i_state & I_NEW))
+	if (!(inode_state_read_once(sufile) & I_NEW))
 		goto out;
 
 	err = nilfs_mdt_init(sufile, NILFS_MDT_GFP, sizeof(*sui));
-- 
2.34.1


