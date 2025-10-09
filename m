Return-Path: <linux-btrfs+bounces-17567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6751FBC7E11
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 10:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DC73E0277
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5EC2D5921;
	Thu,  9 Oct 2025 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XagQkyNV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BD2D7DE8
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996798; cv=none; b=bwCSa/tzij525OHeleGr9bTNUrt76bqRcEw1Wvt1q+4+ghZKH2ihnBDWYYJiwvBdBjLnpNmvBElEptyDvs1lNdkDmdfWpDGI66TVhiE1TrhQfpC/eGmKQVoFsPOlgd3kNYTp/9ZLtl6oI5mBMtN5UL1NttNf1cTgwfXcbbNnqsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996798; c=relaxed/simple;
	bh=CjghRbVJnrrRxsFC/uqUg1E0WT10jkJULO+lABGoVkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ4gYczQYFqpvTV5l0E/liPIXMGfQvnRp0JDD+zoxw4i9z/SDufq4cbmpB8cZMiMx8/9b7ra2YeAsTVb5vZLfznM9vDgrIzFUaQ1kSaxou2treAI+zeFprWIOPhKhGv/oQmB6hXQz/zfoSDL1GIhsPVgLrySuYEoFXj3dFJGX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XagQkyNV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso112554366b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 00:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996793; x=1760601593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qUy8w4oQhAgPl6fOZI4wnlmjsFcl6OG6QfU8CrT8Pk=;
        b=XagQkyNVxo10BmQPyZD+yu//5tUJ2oRbuqYr1gAYVHfL+oBGf2DHyKr5NUSSOpszo9
         XNVfIA7L2ILl3KlexyL25l2DusOVsoonl03HpxhblrhT/dSehwjKS4WCbhIuWCkU1sZz
         +yql5aQB76ryOHiSeI12l1yC8ghJFwdrGCCcfYtPTy91qDr3ksDgSx19jQIBI6I0Qrmb
         6jVvsF6aacudvR7O4N7kmfCLBUsV2jdX+n+evXIeoLGKN1p241aiIXIjDZp/h2cyiiuQ
         uWHjDw9pGWbQjxRdbbUchADmgaYabJOE075a81KPgOTaVMvpTKKn1pw+dy1b0nkFz57T
         rHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996793; x=1760601593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qUy8w4oQhAgPl6fOZI4wnlmjsFcl6OG6QfU8CrT8Pk=;
        b=jB4LEWmsHYcMrj53O194nglPDGw1cqM7bytdkxptLpsXrjQ53LYGgGWgfE0wllC5xg
         qubsnuQrYXLemQT6DruKVkF3aSgX2YjO12d/GZ4Ri0bub2V7h7YGYdc1oLUhdu/eV4Z1
         Q6VK8TSDEj+aV1J5TNZXtkyayoCAyqShJHVB6rGKAbO7kX9IGzRMxfjTP81CP39T6Imy
         iCJZOrIML2OKJxhIn9vmSUsP1UFtSCLWUyux7TfuBE1IJLX+ncBnkxEqeIz8rvdYUh8M
         bvVCm/nZK0ygoJ9hM3UBT54F190xLRB1ST0CP029Ttp+Le0ex6CiLQF/2IAbsSjcjtza
         WlDg==
X-Forwarded-Encrypted: i=1; AJvYcCXtRX4vLRdObrP47BzFOB8rpA1DtP2QNokAENaBdSO7eySH6lYnT1oW6uQTN9tPZENykx9upwUJGzdjjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09HWW/xZUPl2JLdvXx+UN9wK5EDg7onnJyO6cCWjVxr68l883
	dbKxiir57qhNYuzCPIRXF4hR0qGFY3cg9S8UDEnsceyI2wJNM7xAdS1L
X-Gm-Gg: ASbGncsuZF+1wtj6+RsLjM5Bo1IodlonstmUXY7z7+b6ppxmIKy5LffvuK5r1zRkGh0
	QacTZRGp+qspTjfW4V4ksc8pJFw6b0FgcxKULFoin2s+hTiJk+URGuq/q2ZDE+9B7tlJxArSCHl
	IEG6priCqJ6qQE5cjM1PMQJleh4LQeEsNCgQMWMsa8trzNJsKl5muya6EnPMCmQLCqQppZwDz85
	f2wQ2jt/SHaNU70ExwFJKDUoaQT4T4omUP92+wQ48pY363PHGRmXDknDclx8guZ/yHWgaRJI4dM
	8pFwYJUpraLVAKKjLUNhc3esem+a2fjaDEx0eiDv60mEU1q5QOViwf8KwFh9dce+f1ZzIP277bc
	d/492aSJB/4tDHLcDT4YsyBisrJ3gHjmEReil3JaliZHUPXxoQ6XMGKh2TYksImhtyARpL5pL5a
	r5MBZVrePmDJY7vEBOcc3Ycg==
X-Google-Smtp-Source: AGHT+IGbrd08TTcAFiqwbpW9BDTUl/1zMbIp8ia/BbOIaKggRHixcVaV3Fgadc1Z9T3iA/deAE80rw==
X-Received: by 2002:a17:907:9702:b0:b3c:6093:679b with SMTP id a640c23a62f3a-b50ac2d58b3mr707002766b.36.1759996793003;
        Thu, 09 Oct 2025 00:59:53 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:52 -0700 (PDT)
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
Subject: [PATCH v7 08/14] smb: use the new ->i_state accessors
Date: Thu,  9 Oct 2025 09:59:22 +0200
Message-ID: <20251009075929.1203950-9-mjguzik@gmail.com>
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

 fs/smb/client/cifsfs.c |  2 +-
 fs/smb/client/inode.c  | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 1775c2b7528f..103289451bd7 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -484,7 +484,7 @@ cifs_evict_inode(struct inode *inode)
 {
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_state & I_PINNING_NETFS_WB)
+	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB)
 		cifs_fscache_unuse_inode_cookie(inode, true);
 	cifs_fscache_release_inode_cookie(inode);
 	clear_inode(inode);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 8bb544be401e..32d9054a77fc 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -101,7 +101,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 	cifs_dbg(FYI, "%s: revalidating inode %llu\n",
 		 __func__, cifs_i->uniqueid);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		cifs_dbg(FYI, "%s: inode %llu is new\n",
 			 __func__, cifs_i->uniqueid);
 		return;
@@ -146,7 +146,7 @@ cifs_nlink_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	 */
 	if (fattr->cf_flags & CIFS_FATTR_UNKNOWN_NLINK) {
 		/* only provide fake values on a new inode */
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read_once(inode) & I_NEW) {
 			if (fattr->cf_cifsattrs & ATTR_DIRECTORY)
 				set_nlink(inode, 2);
 			else
@@ -167,12 +167,12 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 
-	if (!(inode->i_state & I_NEW) &&
+	if (!(inode_state_read_once(inode) & I_NEW) &&
 	    unlikely(inode_wrong_type(inode, fattr->cf_mode))) {
 		CIFS_I(inode)->time = 0; /* force reval */
 		return -ESTALE;
 	}
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_once(inode) & I_NEW)
 		CIFS_I(inode)->netfs.zero_point = fattr->cf_eof;
 
 	cifs_revalidate_cache(inode, fattr);
@@ -194,7 +194,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 	inode->i_gid = fattr->cf_gid;
 
 	/* if dynperm is set, don't clobber existing mode */
-	if (inode->i_state & I_NEW ||
+	if (inode_state_read(inode) & I_NEW ||
 	    !(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DYNPERM))
 		inode->i_mode = fattr->cf_mode;
 
@@ -236,7 +236,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 
 	if (fattr->cf_flags & CIFS_FATTR_JUNCTION)
 		inode->i_flags |= S_AUTOMOUNT;
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		cifs_set_netfs_context(inode);
 		cifs_set_ops(inode);
 	}
@@ -1638,7 +1638,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 		cifs_fattr_to_inode(inode, fattr, false);
 		if (sb->s_flags & SB_NOATIME)
 			inode->i_flags |= S_NOATIME | S_NOCMTIME;
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read_once(inode) & I_NEW) {
 			inode->i_ino = hash;
 			cifs_fscache_get_inode_cookie(inode);
 			unlock_new_inode(inode);
-- 
2.34.1


