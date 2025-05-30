Return-Path: <linux-btrfs+bounces-14331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA250AC935D
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B822016541E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A631C861F;
	Fri, 30 May 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KjSAUgeS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KjSAUgeS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA351494A8
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621917; cv=none; b=SugHEOoBA6SMxBsFrp2eCCS+ab7K2LHVK5Twk/cXc+vE0wVYJtj1tAG/R5cyPlSabjc/aCbhSOA14dEIVmWXCINHopTAnMo6dyB2ZpbABZBTOR0ASWNIiCVvB4Q4FpWqwLjwFq5COVBz+P2gmQEc5lMRB/BDN3IAu1u88s6XlZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621917; c=relaxed/simple;
	bh=KBK4EBbPJRsAYZ03M5tssX32YFulwm/DuGYxJPI06I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5Qb/dCcX9s/1lYexKQ/EaLmJrCcRISm6348FXI8CGqcdTlM6xHamcF+DX/NAlisV/VyyXRdSf40dOwc/IB73XQtM17mO0/fRRNeYByz5cdxGAlDS4NxmQdoKMr143bBnHFHn5704qRoc9RqToPMWkBGvFLkqrTaQJt1KpKplks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KjSAUgeS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KjSAUgeS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C7EC21A4F;
	Fri, 30 May 2025 16:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4zJhr90tpozA6bHvoSq2HfV6EIAsVNz3IAmot3275o=;
	b=KjSAUgeSPnLesP34lgnSUB7nyDJQCcd3hNceM/4TstWmM8Joe+s0av+dCgIFs23kRxyU68
	8+BAsFDqF82Au32PsjnEzv+bHAMLHZw5xz+KDbpLNrkJHoQoMgLFvACmwFdrvWPVqitZa+
	GSE+JPByVl90G2KUD59ogR/y4EDVLFc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4zJhr90tpozA6bHvoSq2HfV6EIAsVNz3IAmot3275o=;
	b=KjSAUgeSPnLesP34lgnSUB7nyDJQCcd3hNceM/4TstWmM8Joe+s0av+dCgIFs23kRxyU68
	8+BAsFDqF82Au32PsjnEzv+bHAMLHZw5xz+KDbpLNrkJHoQoMgLFvACmwFdrvWPVqitZa+
	GSE+JPByVl90G2KUD59ogR/y4EDVLFc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 468A813889;
	Fri, 30 May 2025 16:18:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4P82EVXaOWjOZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:18:29 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 13/22] btrfs: rename err to ret in btrfs_setattr()
Date: Fri, 30 May 2025 18:18:29 +0200
Message-ID: <90f4749f28d18be3d66d8e5c8b22cfc2de326781.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0a2357f979f3..9d200f4246ba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5279,31 +5279,31 @@ static int btrfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	int err;
+	int ret;
 
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	err = setattr_prepare(idmap, dentry, attr);
-	if (err)
-		return err;
+	ret = setattr_prepare(idmap, dentry, attr);
+	if (ret)
+		return ret;
 
 	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
-		err = btrfs_setsize(inode, attr);
-		if (err)
-			return err;
+		ret = btrfs_setsize(inode, attr);
+		if (ret)
+			return ret;
 	}
 
 	if (attr->ia_valid) {
 		setattr_copy(idmap, inode, attr);
 		inode_inc_iversion(inode);
-		err = btrfs_dirty_inode(BTRFS_I(inode));
+		ret = btrfs_dirty_inode(BTRFS_I(inode));
 
-		if (!err && attr->ia_valid & ATTR_MODE)
-			err = posix_acl_chmod(idmap, dentry, inode->i_mode);
+		if (!ret && attr->ia_valid & ATTR_MODE)
+			ret = posix_acl_chmod(idmap, dentry, inode->i_mode);
 	}
 
-	return err;
+	return ret;
 }
 
 /*
-- 
2.47.1


