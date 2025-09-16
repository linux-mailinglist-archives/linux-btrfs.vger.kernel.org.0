Return-Path: <linux-btrfs+bounces-16862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9150B598D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 16:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007481893BDA
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA25436808B;
	Tue, 16 Sep 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxR8ybYu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212FA35CEB7
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031209; cv=none; b=DGROcXXHNBC5zPF9k0PODDwjsNbmfDX/EHSM1Sq1V44IvcOcukz/z9AMKWjjwnU0aLJypId36YCHCczzCz4qk+nXPrOBS7LVzzi2rKqPOrkAa9Y0vjiOhVIyUxogWZnFqMmlkn11RAJ0hRN3G9BV24HXxVpnqJl7RVhVrzufylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031209; c=relaxed/simple;
	bh=9uB5tIoSu0Ihqwy/dzzpF33dCVQXqPEjiR4jiBdlE6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUQUyeOr7oRxDO2aBnK1+WdYiBekb7ZhbXEDkYrCoV/7ndUP1d1bmQ9N/yihRu1A11QUuYeHwv4i5YAL6A49WEKr/JWXXIv6Qh7yfQSbL/9cXQu0C9rJEzMsnILIfzF7hJtPL2za7FEePQAdlhufXKdcRfhMP2+xj4nvnxaIBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxR8ybYu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso33323235e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031204; x=1758636004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jXBWCescUObzsT6Su0exTy7Btg138NHvbE5HLT4Jeo=;
        b=lxR8ybYuXYa9qNaTZ+hqKLsxR/u6BY6zzV/gtp4yDl4JzRW+ztA7qdJaNySrU8LmcZ
         +FSmJWBbnjLDWgyo81qjnG8LLkp49YRNdYlJqvcNLp1+zhsno83coVbLSowVmYzeurvP
         XsYd6YlG2dkp1qWYP1If5nmE0BPIBxlP6+3WVOfS6fWAMuJASV8e6HHvYe6qc7kxCtMz
         5HAaBdC8JUnGb9Wy/Tj8Fc6l2KcFMwegRHdlBFMG2gPhJIngXhaUXjdOvXzJA8ybaSYe
         J3/HVLwK1FojmIoSbCzAg99/Fl9poOSdGL8rtQSt6SG5a0ebPl6+1AKIxIWjjcXLmRom
         jeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031204; x=1758636004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jXBWCescUObzsT6Su0exTy7Btg138NHvbE5HLT4Jeo=;
        b=TBf3AzYh3N7Z+RaXV/aE7t6jwqEBDcOXOl0yavYIqCB0s6VvjnO1J0reqfgm7if9fh
         mTnMHPL0sCH011pB/CuQ9C4HU8SM7JfExNktfoxGL7DtA00Lo/UeJXAxXbcIlhijdTLX
         gaUF3n5xlHM17IngeHqnUvC3+h8xpD69vqvrtTWN8jv95vITFjGmJ4TO7+UP73jL7jSX
         DjEhiI10cP38q3KufgSLo2CmrVfvwdw0I4W9F0T8h1VM3Dqp5qye4xutODmTqBrl3cZh
         PQUIaIzY5rXFjgzE+NcCt3RtXbdq3Hk9CNgwHnGaD4g68wfFMFzLDVbugFVIwGhVjxhC
         d2dw==
X-Forwarded-Encrypted: i=1; AJvYcCWLRlGeH7V78+bZ7d36C6VNUBUi+q0eRLBactAMGLeqEGx11tWYMyvjs9rMR6P/2fwNzFJeL8HdkoeGnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VF0WdG59UgyiCAll4xImf0I0+i/P0sXeAwB+J7O5cxNJjxZn
	GvXKTlnwJ0ELFekx8PkGhJGTbc59iS8lTNZsyhdDLhsk5Bw8N8KvfbFP
X-Gm-Gg: ASbGncsAqi/7QLgoOWwkBL1zie5MhH57rQQpY256f7Dx/2wclEO0PHxGPRtzsGB/LgC
	X7N+22Ofr7Mv4+eJkm1hRJPG9k1jbbzL58bVM0NIT6mPr9PHbyLmpdemllEeZ3fo0c4982WyVjU
	DAGj1DB81nf0RQxX2lxMGKSsIOVtbpE20Jni/SpNsK2t9ndRlmC+vyDmaCcSyzCNLRADQLDZrWc
	7HDMCNhERKtUDi+VemrsVwa+rEbtU3CSD3hMi7p79HfFsOFF+yh3DUZURwikyeS2aG4+f61plsO
	FYE50jzEw6hRQtnUXyvhRS6Bpb+2NzzRl5Jbfhb6356Lw/5afiA5eRp2frJf1A9vbXtP3d2S/KZ
	l4l+e0HkGYJeeMXfky9qF+VqXUpAEYKFYhqc8UE+uKPqyN/ApM9ro65IXfe9Po34J12FlK+qO
X-Google-Smtp-Source: AGHT+IHwPsVwzVQ+3BwThlohyBuVsh7mtJyWbIwjAmCzyS+IiOJcg7GYx0sFvI9t/faLf/pLubt0LQ==
X-Received: by 2002:a05:600c:190f:b0:45b:4282:7b60 with SMTP id 5b1f17b1804b1-460614f9f91mr11287815e9.34.1758031204161;
        Tue, 16 Sep 2025 07:00:04 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:00:03 -0700 (PDT)
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
Subject: [PATCH v4 11/12] overlayfs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:59 +0200
Message-ID: <20250916135900.2170346-12-mjguzik@gmail.com>
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
 fs/overlayfs/dir.c   |  2 +-
 fs/overlayfs/inode.c |  6 +++---
 fs/overlayfs/util.c  | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e..eb3419c25dfc 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -659,7 +659,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 		goto out_drop_write;
 
 	spin_lock(&inode->i_lock);
-	inode->i_state |= I_CREATING;
+	inode_state_add(inode, I_CREATING);
 	spin_unlock(&inode->i_lock);
 
 	inode_init_owner(&nop_mnt_idmap, inode, dentry->d_parent->d_inode, mode);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ecb9f2019395..3f7ef3dae5e5 100644
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
@@ -1299,7 +1299,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	if (upperdentry)
 		ovl_check_protattr(inode, upperdentry);
 
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_once(inode) & I_NEW)
 		unlock_new_inode(inode);
 out:
 	return inode;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index a33115e7384c..cfc7a7b00fba 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1019,8 +1019,8 @@ bool ovl_inuse_trylock(struct dentry *dentry)
 	bool locked = false;
 
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_state & I_OVL_INUSE)) {
-		inode->i_state |= I_OVL_INUSE;
+	if (!(inode_state_read(inode) & I_OVL_INUSE)) {
+		inode_state_add(inode, I_OVL_INUSE);
 		locked = true;
 	}
 	spin_unlock(&inode->i_lock);
@@ -1034,8 +1034,8 @@ void ovl_inuse_unlock(struct dentry *dentry)
 		struct inode *inode = d_inode(dentry);
 
 		spin_lock(&inode->i_lock);
-		WARN_ON(!(inode->i_state & I_OVL_INUSE));
-		inode->i_state &= ~I_OVL_INUSE;
+		WARN_ON(!(inode_state_read(inode) & I_OVL_INUSE));
+		inode_state_del(inode, I_OVL_INUSE);
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
2.43.0


