Return-Path: <linux-btrfs+bounces-14339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50BEAC936C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34CBA207B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F66B23278D;
	Fri, 30 May 2025 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n3MvLya5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n3MvLya5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E11A5B85
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621953; cv=none; b=dcfV+gYqUZMD3+Nk7xQl++Dm5In3GDCqI1IV3nfzFNGYLTSejKjd1fJTIHh0ivn4Mcg0IbuBa1591RUeCnb/4QJB79nSIBKTFE84X/ZMqB1/or/nJABSXHePRwRvLhWVxH3sNbLnbFdl6ICFmKUp9lCDGElj/E9V1LEzMZh2pHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621953; c=relaxed/simple;
	bh=kcsakJfpEvehtQ6JtnVyODb4c4oweLGMFA3w18pMPTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3MOxXl8Psg7CwkT5b0D3WflORYhV8fH/dpZnP909IdRW8CQOvYJceq7tlUdxn0nzGr4z9F+Bdeus+H4DDys9RYj54aW+3GHAqETTaoRCNfcSbehOGar4jheMY37gRlXAqSkGYruPLVtk5dRKfvJ7BkpX2h0OV9tYlbhJlX/kvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n3MvLya5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n3MvLya5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43C791FC04;
	Fri, 30 May 2025 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaqrgIhaAoMbV2kjGwqxsvNo4Yi+io4QXUoeVtSikvY=;
	b=n3MvLya53RFoYmw5Fo3PInu1zBCpWK0lb8NKavBM5VC9cSV2j4dwxBA7ZXilbLfFkkHoiB
	imioPJHlzjKm0uafA6n2+voCkV54NNHHDVi2bsu4LC2vCpcHt2cEh7EymxkE+AeFyk09ac
	v/IVek9NYN4oee28w7bL4Ict4+u/EdA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaqrgIhaAoMbV2kjGwqxsvNo4Yi+io4QXUoeVtSikvY=;
	b=n3MvLya53RFoYmw5Fo3PInu1zBCpWK0lb8NKavBM5VC9cSV2j4dwxBA7ZXilbLfFkkHoiB
	imioPJHlzjKm0uafA6n2+voCkV54NNHHDVi2bsu4LC2vCpcHt2cEh7EymxkE+AeFyk09ac
	v/IVek9NYN4oee28w7bL4Ict4+u/EdA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C03E13889;
	Fri, 30 May 2025 16:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4ASlDnjaOWgdaAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:19:04 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 21/22] btrfs: rename err to ret in btrfs_create_common()
Date: Fri, 30 May 2025 18:19:03 +0200
Message-ID: <9d7617d6a311a5b5c3636785520def7c5722ee64.1748621715.git.dsterba@suse.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a91ee8155376..e989649b5050 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6738,20 +6738,20 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 	};
 	unsigned int trans_num_items;
 	struct btrfs_trans_handle *trans;
-	int err;
+	int ret;
 
-	err = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
-	if (err)
+	ret = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
+	if (ret)
 		goto out_inode;
 
 	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_new_inode_args;
 	}
 
-	err = btrfs_create_new_inode(trans, &new_inode_args);
-	if (!err)
+	ret = btrfs_create_new_inode(trans, &new_inode_args);
+	if (!ret)
 		d_instantiate_new(dentry, inode);
 
 	btrfs_end_transaction(trans);
@@ -6759,9 +6759,9 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 out_new_inode_args:
 	btrfs_new_inode_args_destroy(&new_inode_args);
 out_inode:
-	if (err)
+	if (ret)
 		iput(inode);
-	return err;
+	return ret;
 }
 
 static int btrfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
-- 
2.47.1


