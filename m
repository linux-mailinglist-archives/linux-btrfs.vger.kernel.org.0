Return-Path: <linux-btrfs+bounces-17571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B837BC7E75
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 10:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF22189D0C6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 08:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79DD2E6CC4;
	Thu,  9 Oct 2025 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5K+GMVy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719172DFA25
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996804; cv=none; b=WEdAbuTbgrOshdyMGU7GNpWOxjaTvWL5ZKgiIX5fEfpacpcQ2kMmuiUx7aTJzFp+vaurLv9jMXOP3BMzb7gToVbz8yItVNHCbYPFYgTQs2zTg21M1jFpCpXpTRqNnWbXVnHHXZpS+NFfVsocVkIq1quHDFyosAKW7dIt1BHyw58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996804; c=relaxed/simple;
	bh=jQNHepm+GfxiH8iJqPWkaNzoPhlEV+QYfSEO5RaRoCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mm/GtIOSQSqqddJRXDT35e30gp2H8CVmAq1v4gYbrJAupog23QitS7mUepTMPC9U3UQh4KxjH+5a9HXcoM6aDXU2/1hK3QRxtj2G+IWaGftWWniWFUht6AllGxCp53wOkbyBezqf/0n2wmZghOs0MDmsDwsZcKE0yHKTEEWuJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5K+GMVy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b40f11a1027so109801766b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 01:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996798; x=1760601598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij6PghlUCkvZUM92+6FKF+AKyv5iaQdA6DsJZ2ToQxg=;
        b=c5K+GMVyvYS40R24tzKNe19Haju195Y5qlAxziozaALQvmrqE9I5VLb9jvbvL3ce0S
         9KJjhQJZc0VFZh1hu0PVkW30bq8WYihS0YgD7WOyxL9T2A2DT4OPO9gevJTckIpMfDur
         /4F/eAI9OI8Z/aJwx9rvfVTln4d1R/uvsYFQAMMiSNScOd5c2Mg0Z4lWxtbFfD2TkpVo
         UmaEhCgZ99AvhhNYboANd05myEtwvtiBHrUW5Nktd4C3ouEQhbnnFV0WxCxP8g+rIBPD
         qq2T2jcjtJY8imtE0I/20zxHlgHjUwvCudFbPpVoWJWr1HmZxlgv3+v568Zfs3a+Zmbr
         sBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996798; x=1760601598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ij6PghlUCkvZUM92+6FKF+AKyv5iaQdA6DsJZ2ToQxg=;
        b=ZZV1ZmgmAL8b4cRmCY2z1CO3T8z4OfLXvQgFVXwUISHrZp6d7Dkl1HvvEoosYusBea
         gcNvgKGnvlghsv9hzyGKkPQeWTphodPXilNWmTaxsUO+2VhwiKzMuAoSOWoaP02JbyM8
         SRf840MENV+PypGGf1yydx2ExRJJRFjtQEXr1rzdI2umNLUQhfR9J+UIOiQYpkpJQDCK
         hSWRng83X5aL7Dq8CS1vWNZce15IgeH0gnhwqlgJHMoXErNK7CnlxTTZn8T1jXE3dTwE
         8YPx7aETHavSeHxkrT6C7J3osNRx7BXhI7lIqX0GdnXiqB04WEQzeTkREXeyoBEQHj1e
         7JJw==
X-Forwarded-Encrypted: i=1; AJvYcCWeY7Nh26hCC5HHcjfIQ+d8pBRDw3ou0Vq2Jm+108erX2rUpwn5JIIJOUbL1q3EiY1u0LDbnZmHFSAiPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpANVZ4Tis7Ucsg11KvxBK22m9r2lzEEviFrWxyiwnUEn340XL
	KP8UkAjyGyrODLs0QTFcGQrbcKOnUIctK/Vw/nne/SQPY/g8LXHFFufW
X-Gm-Gg: ASbGnctqq6xhlrKDWeYz87sg3xOKfnVsuozwW2dpkbpjHaOlLKP3Poww/lG3as0s84k
	qMjwLdJxv7UpmDIsVV4ze1hDjVL4YxoHMXOERpQfoub4ehabxsPZj9zH+IpSLzjUEJoiR0o4zvw
	8k0UyYMTcmMUgMySj38mtdYWFGJwziIxZMc/TO+maRGC6oedz1GrwbbpYjm12DK8mESQDXlK4fC
	8+hT0jypjZOP2tkpeIhq7iw/kuSRQYWAM98OheybqG4oHQ+bRbNm6Cbs0LERzECh8MevbVZCCZ2
	amMuTUzhC7GJZy0kTJ6e0fXPinGj8or4EwN3cAW82onZoVWKP+5sXoUypsL/S+u4UbplG1OW5mm
	CXYT4e49X88uflTmwIIBTrpEcd2dcTXJJ5O1itd1Jq85vHwlTzOuURq/zovAbcRXzfKt+7AVNgk
	H+uyxKTD7lnfpzZ4VpCv7S5Q==
X-Google-Smtp-Source: AGHT+IF3XO1P9pAg2+/sOoYw+aIYYoO0vgMYpDeSqig4GnRovdBm66KN0sJELngmUliGaQKvYfh3Bw==
X-Received: by 2002:a17:906:c144:b0:b04:48b5:6e8a with SMTP id a640c23a62f3a-b50aa292fb7mr691075466b.7.1759996798297;
        Thu, 09 Oct 2025 00:59:58 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:57 -0700 (PDT)
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
Subject: [PATCH v7 11/14] overlayfs: use the new ->i_state accessors
Date: Thu,  9 Oct 2025 09:59:25 +0200
Message-ID: <20251009075929.1203950-12-mjguzik@gmail.com>
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

 fs/overlayfs/dir.c   |  2 +-
 fs/overlayfs/inode.c |  6 +++---
 fs/overlayfs/util.c  | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a5e9ddf3023b..83b955a1d55c 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -686,7 +686,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 		goto out_drop_write;
 
 	spin_lock(&inode->i_lock);
-	inode->i_state |= I_CREATING;
+	inode_state_set(inode, I_CREATING);
 	spin_unlock(&inode->i_lock);
 
 	inode_init_owner(&nop_mnt_idmap, inode, dentry->d_parent->d_inode, mode);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index aaa4cf579561..b7938dd43b95 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1149,7 +1149,7 @@ struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir)
 	if (!trap)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(trap->i_state & I_NEW)) {
+	if (!(inode_state_read_once(trap) & I_NEW)) {
 		/* Conflicting layer roots? */
 		iput(trap);
 		return ERR_PTR(-ELOOP);
@@ -1240,7 +1240,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 		inode = ovl_iget5(sb, oip->newinode, key);
 		if (!inode)
 			goto out_err;
-		if (!(inode->i_state & I_NEW)) {
+		if (!(inode_state_read_once(inode) & I_NEW)) {
 			/*
 			 * Verify that the underlying files stored in the inode
 			 * match those in the dentry.
@@ -1300,7 +1300,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	if (upperdentry)
 		ovl_check_protattr(inode, upperdentry);
 
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_once(inode) & I_NEW)
 		unlock_new_inode(inode);
 out:
 	return inode;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f76672f2e686..2da1c035f716 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1019,8 +1019,8 @@ bool ovl_inuse_trylock(struct dentry *dentry)
 	bool locked = false;
 
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_state & I_OVL_INUSE)) {
-		inode->i_state |= I_OVL_INUSE;
+	if (!(inode_state_read(inode) & I_OVL_INUSE)) {
+		inode_state_set(inode, I_OVL_INUSE);
 		locked = true;
 	}
 	spin_unlock(&inode->i_lock);
@@ -1034,8 +1034,8 @@ void ovl_inuse_unlock(struct dentry *dentry)
 		struct inode *inode = d_inode(dentry);
 
 		spin_lock(&inode->i_lock);
-		WARN_ON(!(inode->i_state & I_OVL_INUSE));
-		inode->i_state &= ~I_OVL_INUSE;
+		WARN_ON(!(inode_state_read(inode) & I_OVL_INUSE));
+		inode_state_clear(inode, I_OVL_INUSE);
 		spin_unlock(&inode->i_lock);
 	}
 }
@@ -1046,7 +1046,7 @@ bool ovl_is_inuse(struct dentry *dentry)
 	bool inuse;
 
 	spin_lock(&inode->i_lock);
-	inuse = (inode->i_state & I_OVL_INUSE);
+	inuse = (inode_state_read(inode) & I_OVL_INUSE);
 	spin_unlock(&inode->i_lock);
 
 	return inuse;
-- 
2.34.1


