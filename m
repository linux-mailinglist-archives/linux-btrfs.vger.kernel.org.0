Return-Path: <linux-btrfs+bounces-11617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED8A3D5D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29FD3BB54A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2351F2377;
	Thu, 20 Feb 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Lx1R93eA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Lx1R93eA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09A1EB188
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045670; cv=none; b=B/5Uiy0kpzaiMXBSZhjmch/IS0pyXIslDW4kvqmVip8abTERBxj2CzchiQcu/vtMJWm0o5MUbayVTy9YBnQphUePQbUabLK9i9vHvL8MjCwscFqilpBKdw03Sj70gJXyB3dqagXTKK35hHg5U7W6xSoltG1ZjRp9zK7BixiVafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045670; c=relaxed/simple;
	bh=LFFCPAyq9ugz1Psd0kjARBt/HNf3FKwNglZwJQSV+6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFDbJOtUDCW1d5rsRZ0gEdNQWVSGMIL0rTVzRkBLxOs3BZjfowhznDrZ5KutHl6BzN00ejE40564eFflaKnpQzbb/xm/CUhYsAXDTYr4V1YNbyU5tDFRyOqZeiLHh/FFN2GvAZV0f7staEWmUzHQ4PyoZvhzeqwSHtax7CesNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Lx1R93eA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Lx1R93eA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72D3E1F387;
	Thu, 20 Feb 2025 10:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m16ANTKBBt8srqA1zNFdsnIRsYqZrNHwf8Ao+23PZvE=;
	b=Lx1R93eAmomX7PP2TxpG/ThdhBMpOxHx/YZwuHsz7E7GQ+bBvnZMRNKu1M+fO3Zy9+ORgo
	JfwskWFATEkYXVfrxSz1JrMuO1mCCZc6kPIuTvTDwYstp18U/Np5HE800zhx0ZYk2quUuV
	SiHYZ0ndCuxj71Cg776P7WuVQClY2m8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m16ANTKBBt8srqA1zNFdsnIRsYqZrNHwf8Ao+23PZvE=;
	b=Lx1R93eAmomX7PP2TxpG/ThdhBMpOxHx/YZwuHsz7E7GQ+bBvnZMRNKu1M+fO3Zy9+ORgo
	JfwskWFATEkYXVfrxSz1JrMuO1mCCZc6kPIuTvTDwYstp18U/Np5HE800zhx0ZYk2quUuV
	SiHYZ0ndCuxj71Cg776P7WuVQClY2m8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6123013301;
	Thu, 20 Feb 2025 10:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hZ+0F2L9tmdlfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:06 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/22] btrfs: pass struct btrfs_inode to btrfs_inode_type()
Date: Thu, 20 Feb 2025 11:01:02 +0100
Message-ID: <11129f738f5fd6aeccea7c7f2e2630d49c03203d.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740045551.git.dsterba@suse.com>
References: <cover.1740045551.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Pass a struct btrfs_inode to btrfs_inode() as it's an internal
interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac4dfb896d0f..ef02ba48522a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5721,9 +5721,9 @@ static_assert(BTRFS_FT_FIFO == FT_FIFO);
 static_assert(BTRFS_FT_SOCK == FT_SOCK);
 static_assert(BTRFS_FT_SYMLINK == FT_SYMLINK);
 
-static inline u8 btrfs_inode_type(struct inode *inode)
+static inline u8 btrfs_inode_type(const struct btrfs_inode *inode)
 {
-	return fs_umode_to_ftype(inode->i_mode);
+	return fs_umode_to_ftype(inode->vfs_inode.i_mode);
 }
 
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
@@ -5749,10 +5749,10 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 			return inode;
 
 		/* Do extra check against inode mode with di_type */
-		if (btrfs_inode_type(inode) != di_type) {
+		if (btrfs_inode_type(BTRFS_I(inode)) != di_type) {
 			btrfs_crit(fs_info,
 "inode mode mismatch with dir: inode mode=0%o btrfs type=%u dir type=%u",
-				  inode->i_mode, btrfs_inode_type(inode),
+				  inode->i_mode, btrfs_inode_type(BTRFS_I(inode)),
 				  di_type);
 			iput(inode);
 			return ERR_PTR(-EUCLEAN);
@@ -6553,7 +6553,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		return ret;
 
 	ret = btrfs_insert_dir_item(trans, name, parent_inode, &key,
-				    btrfs_inode_type(&inode->vfs_inode), index);
+				    btrfs_inode_type(inode), index);
 	if (ret == -EEXIST || ret == -EOVERFLOW)
 		goto fail_dir_item;
 	else if (ret) {
-- 
2.47.1


