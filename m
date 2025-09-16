Return-Path: <linux-btrfs+bounces-16857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBA6B598A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 16:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD564E82B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9C634DCEB;
	Tue, 16 Sep 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7wk0/Ug"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451FD334372
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031190; cv=none; b=X8RE/Zsokr/PdToav8Wyep7Z1YY2cLXv+4oxmd5LQNXIzdmwZOgFTP1sLPquV0NWGBMNIBqXkGI4A1hGX8Hjmn1fcsS1AEQaDQIRjyWUhjBj1CBQbc0qQUB8xcuMhVJaRjQ7Cl/eXA4HSkVXpQM2dH+VTIaqt1cHPqsViYVRvHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031190; c=relaxed/simple;
	bh=Yt34Z65QEVjBY3vs7drEeyweXMdM1iPHPiVqjl9uXys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijzTD0NY6h1OE1Zh/juA/7eHutNUErfTfV9BYtUyjcLlkq3SOyvZQgtG5abfDYZNb+t1yRWXIedbyZuzQ5DGAKUOI6AhgdaaUDkG9+3+9lflh7qY/vTar8klYX83Ev7hAKfDTqpJOwp1msfDMUIC4NmHPXh7BJ1yeZqiqVInXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7wk0/Ug; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2f10502fso13430585e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031185; x=1758635985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObYBkDignaJBOFN/sAdt6zRe1zmiqWFfHHsl18X4Hr4=;
        b=V7wk0/UgOUBi3ueEEU+LXUqtB/Weg76XmS9vT2711ZjVaqkH3GWkv1kxx3dXkouPsy
         qcbsm25Fy9QNhmA8kg8dpDlVItHBg0DI/JgOCRsrY2Osl1ZZD7dlunq/8dXS1q3sL5eU
         FUnmBdSjow3L/WC6mAc64Nr+Vnae5k8KThZj1Mvr16Q6ie+0+1dSTYF+4PmlbP3p049G
         KN+gJwPKm45md4B4UEN+2a8zBamvAGQwYQnS74R+FN3IJ2r1jDRzxtFgcgHJJS2vI1oT
         zbZkXY8pHfJmVy7GJMz6tyTHzIM6sbM+ZHLE+v42zdBIldr3bBKT1fjZJcIS7kQ0QPNH
         m72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031185; x=1758635985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObYBkDignaJBOFN/sAdt6zRe1zmiqWFfHHsl18X4Hr4=;
        b=N43++nNN6dxe0Xs/hZm2C+LpLpXdFnb3Rov0zJI+GjR18Fle34pMrrBg2eH2nNp1NB
         dCM7GrL6jrlOjO+S/FDIBdMpyd9mpsLt8lJzwzk3WJQ3AUIwrc/UsW2neWITvZmDQAOY
         Ev7RvzbFK9Kf311DLtcnfgHQYFRkg9c6JZ7qpz/1X2ztuclix1hrkuGEC0K+/5/9vcYJ
         RQ+S6/uavhkY5W/awrcl+pH/AFe4h6FnsavsQGcvZb9nBD0slwfThYDTzHx+PNU0ZQu+
         O4gJK8xEgZlY6nBX+CJyluK4bWrZYigmd4igK+U1m5jq89jqNDT1OB5pO2mM9NsGDB3T
         lX5g==
X-Forwarded-Encrypted: i=1; AJvYcCUnVlunwW8g0bcXui01ejxhhcRJ8Tp6fqSGywotGQN6L4PhHcJgXv9pC378Mw4X/LhqZLeAW0/m/P5fdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6fUrxs5KDAc0mZCUt6VBnjttTA4N9GerfAgCn0wl/VLnTILX
	iiH4f9W4TmBMhIbt1fmDQXp13y/jCQz9gRAGY4zIuY4R4fwhaYX3YNcy
X-Gm-Gg: ASbGncsIQnSz23PA9/IDXyrIK1qvZnIij2rffHAE6B6YjpA5SfkqafraHpHcQZkopuh
	JVPcSwupoVEd36wI3DzAwcdcREXs2eMD9H46VnGjjFwaVk8MXts3pTT+qPE/TM+RiWibqAVbgqf
	oPi/Fmy9RsE0izLrfl/hy0sEQFxbuLaopET+pUtyC6WL47omwNFtNCG+vERWohfJvlNVDn/MouB
	zhCsb9mL0234ZT+XEhpGvSZE1Zobg3T2rpAcPot6hRE/8eytYRYZ3ZjzfNXGTjQyWXTh7/zmzvo
	4ui0lciAxzJZMkuE5s+cxDwGxAR2hL5y1jT6ih1e0SIsUoPrvCFZfJw0noScYdkFr3mupKd5npT
	81K4tb4tcLyNNmb8vwIXdnFbKN9VtFEEYUABsPNNEwV4LktCl8CkqnTkxq3oYVRMz1f4V7NqkWb
	KtXjSM06I=
X-Google-Smtp-Source: AGHT+IGgH2HnoMas7BAKGXCBN0be+CTcvCaVE6b26oEMoWsrV0RJv59JPtcah/8oOhuanNH0DCd/AQ==
X-Received: by 2002:a05:6000:4021:b0:3ce:f0a5:d594 with SMTP id ffacd0b85a97d-3e76578f304mr16479215f8f.13.1758031185077;
        Tue, 16 Sep 2025 06:59:45 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:44 -0700 (PDT)
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
Subject: [PATCH v4 06/12] nilfs2: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:54 +0200
Message-ID: <20250916135900.2170346-7-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
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
Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set_raw(inode, I_A | I_B)

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
2.43.0


