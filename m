Return-Path: <linux-btrfs+bounces-16860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA49FB598C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 16:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0AA1884F11
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D363570B4;
	Tue, 16 Sep 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C21u3d19"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE1B353343
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031200; cv=none; b=oCAxQxb9cmOY/9eioDV2aNDuNF/lh99S/8VbvWFB/7V9cL+0ox1JBJbcQvaQl/toEFvhMcsvTkBFUuQAAenTNqMZnqsfGXdDlLG0koGUIVG3hnML4SHqmSHV9uEUEJq79zrmiOfZNnczzmjFtgKwHVyUxbpwhok8f2rt69Kir3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031200; c=relaxed/simple;
	bh=c+jscvVcjHEiu8psO35s6FUxxWLk6N1H5PVjaYHBuTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJlBqnzHg7Dvjab8+o9kvraA+9OKzW4dn/Z5Pb7h7MpTh5pOh/NkVfvhGPw6/IdD5yXCp/04sXOj16dk3LQ8WASKxLlinY4VWR1GsdYbbXp620M8preBT8JuvDWGbewjVXIf6SmOsrHorpiyK/L6JV/xx2iuodmc7wAMRMNKcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C21u3d19; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2c4c3853so13314725e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031197; x=1758635997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vENfTvsqrFJ9tJyBfgLNz2mb8wc8do/WZvddYLx/2MM=;
        b=C21u3d19x1DjsYLGY77AgVuGFJpc7Ig4fo4Ohm8jKWcl7iOvflvcwoJ48taJ4+fHLm
         tIdGWj1Za+IZGy/XPSuZty/tFmcdO9gKYqRvPzDG4iT2AAFWgiYbCa6zQVL1QjjdchTX
         /dAhqFk775dJjUo5Dobt1zHOXXoUVZkJ6hLgIjZTBWg4ztB+8AewMjOpnzltJlilhwHl
         0gfsMylQ001Vy1z2qGg6/HapEPCjePhuPj9OUpeXne4xp/jB1hdJ5OPPtc1GkVR/1UT0
         tvLara7/TZ0N5t5aa12RyY3LEr0f/nlndfwk7+cSe1jJmoGd4KvUQAVdffshf5o07KGd
         CYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031197; x=1758635997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vENfTvsqrFJ9tJyBfgLNz2mb8wc8do/WZvddYLx/2MM=;
        b=OOvRBjQtk6EMmZQVcRNrpDpBlP7fwOsdIE2GTggZwUo8SVHMFoZdP0B0y3AgrCiF61
         FzlycWCJJkgdYa6mXse1ckKwCKGS6rPj4bSE8hPoRzXtaunTbp7GLvUCqA6NXiBnU7NT
         U1wc3rfkVVNOmkem+50gzHechF8nOKV6n/6/Ya+r2JupDUOfmuq1Lfjrlx/K6cMbLiFs
         s25Es8rRNuCBAFg0ZOoRsmCPu4XfNDKm40cH8JAinqUs1E+qe+An5Bx/av8jVKakUFZI
         0Ur/Uz+wKRZGOe3F4HMf5stJCKFVoBZ5TINdjbrvqDWksXqkJJMLS1SMICgfUo6LCAON
         Aoxw==
X-Forwarded-Encrypted: i=1; AJvYcCV3LZXmMeqrNzmRjnnutWGHC9KKB17Tp3l0uyojEetgRZ5mdFZNjUuYBdhjX5THfUqnBj/OHi0mstlwFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVtIML9hb7lMZwIeVvx1/oXDM/+HWf9i2P406rIxvWijsO9FO
	r98WM7crcTL5gHasw+oFZzjcq4PT16NWZNLfQfIE0WCXWQY/Yi4IVwF+
X-Gm-Gg: ASbGnctlghuhdwg8D+0pT7c2x1+HX7IeJaIpH2PYSZ8D82pjBhQk6O1OUlye3qrY0Jt
	lAHFUswAqdvhQIHo47ABzFjM3ei66Gu6CA3cNbnTV17paWzMlSO4ZRXgiWpL6EWNXTkZsQ2W/T3
	pqTC3rYVbvBDDYvJ67hSTJbMhggyzsLB8AVb1UPsD8uMxINBJggJc74Gh7GwzJ0+7uw0EBs+lsf
	8CvAR73bXSzBF9v8MKZXe60GaaASi0DpjFErzxIyBaaw80q4vFOuodRqb4DAf595Y5YlSW/gLB+
	HgN+RwtaPqdinj1om9uQ+lezJVCGEf6NNg5LgHi/L2jHvRcAzKuh1pX3by2xqV0XyrHZaxSwUCs
	g+pPPbICh7FbkJLq2RcP1lXrx21toSrr2qcEhVkSVzTS5n33SXtd77B0QomDc2qBmhPJ4HWfO
X-Google-Smtp-Source: AGHT+IGywKOeZnJ30E7Ud2DvguwBt7x+jM+ZimZarnO2UYCjYh4k81VYRu4VVnkSvPh9Eqb3iEJtqg==
X-Received: by 2002:a05:600c:5254:b0:45f:284b:1d89 with SMTP id 5b1f17b1804b1-45f2a4f8bafmr97604315e9.25.1758031196860;
        Tue, 16 Sep 2025 06:59:56 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:56 -0700 (PDT)
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
Subject: [PATCH v4 09/12] f2fs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:57 +0200
Message-ID: <20250916135900.2170346-10-mjguzik@gmail.com>
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
 fs/f2fs/data.c  | 2 +-
 fs/f2fs/inode.c | 2 +-
 fs/f2fs/namei.c | 4 ++--
 fs/f2fs/super.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..9cc22322ce7f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4241,7 +4241,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	if (map.m_flags & F2FS_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
-	if ((inode->i_state & I_DIRTY_DATASYNC) ||
+	if ((inode_state_read_once(inode) & I_DIRTY_DATASYNC) ||
 	    offset + length > i_size_read(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..f1cda1900658 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -569,7 +569,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_once(inode) & I_NEW)) {
 		if (is_meta_ino(sbi, ino)) {
 			f2fs_err(sbi, "inaccessible inode: %lu, run fsck to repair", ino);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..7d977b80bae5 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -844,7 +844,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		f2fs_i_links_write(inode, false);
 
 		spin_lock(&inode->i_lock);
-		inode->i_state |= I_LINKABLE;
+		inode_state_add(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	} else {
 		if (file)
@@ -1057,7 +1057,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto put_out_dir;
 
 		spin_lock(&whiteout->i_lock);
-		whiteout->i_state &= ~I_LINKABLE;
+		inode_state_del(whiteout, I_LINKABLE);
 		spin_unlock(&whiteout->i_lock);
 
 		iput(whiteout);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2045642cfe3b..d8db9a4084fa 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1747,7 +1747,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	 *    - f2fs_gc -> iput -> evict
 	 *       - inode_wait_for_writeback(inode)
 	 */
-	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
+	if ((!inode_unhashed(inode) && inode_state_read(inode) & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
 			__iget(inode);
-- 
2.43.0


