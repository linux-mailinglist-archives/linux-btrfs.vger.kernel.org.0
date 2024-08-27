Return-Path: <linux-btrfs+bounces-7585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D057961990
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DDBB21E12
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748931D4169;
	Tue, 27 Aug 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hAaZil78";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hAaZil78"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA31D415E
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795741; cv=none; b=V+xohiwKXSTtoxbCSZDN3EB7dMCqq0Tsvr0Kn3AuXJAY05ej4gecoSOMYyJvcdD4dDqRvPk3rcsX/nL+H6+ffassEtB5RWTKcTxC+yTgoAo576SlSGzQlvcZ6jTUHFPHvmIOnwPbNzgqr67tYjFqALVnHD4OABfkhPyPLDvxwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795741; c=relaxed/simple;
	bh=9p4BNJfSxJcvrT/Dqb5bIqHkaH3jgbhjeOmB4L5AQSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPArydPtcelS7/dGJagT36fAkUsQLV+/nxQid6DqxtQbOqLysVvWu0uY7u9AmkNHHHI4z6CFBi0ZH3bNNr3fczSD+YB8nitKMdleXFsC5Nj5CsCtGlg/8jva1m8qsLBz6wujkje9fQ4N1BQLF89QyUS3xZCLCcDMFeE1ly/b/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hAaZil78; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hAaZil78; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50AD21FB85;
	Tue, 27 Aug 2024 21:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVQf4f1VLlCwpccbwNAR7DRw7Csci34n6UCfEmgGzzI=;
	b=hAaZil78KhbSYmUIghXKTXWJHVps7TJGaM7gVrn7cDX0y8s6M06Z4QFUTsmbLlp23snpkl
	pzTwzOPuFqZcxqb4T4klofV0L/Mp4Ge6VjKdi7ttrUA3hsnaokCZmgh9aUNXz5TFGqg6Mc
	TnRLu5wT1JtrH0O2uwgO4JF+53gpc/g=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hAaZil78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVQf4f1VLlCwpccbwNAR7DRw7Csci34n6UCfEmgGzzI=;
	b=hAaZil78KhbSYmUIghXKTXWJHVps7TJGaM7gVrn7cDX0y8s6M06Z4QFUTsmbLlp23snpkl
	pzTwzOPuFqZcxqb4T4klofV0L/Mp4Ge6VjKdi7ttrUA3hsnaokCZmgh9aUNXz5TFGqg6Mc
	TnRLu5wT1JtrH0O2uwgO4JF+53gpc/g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49CAD13A20;
	Tue, 27 Aug 2024 21:55:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BAoBElpLzmatGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:38 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/12] btrfs: rename __btrfs_add_inode_defrag() and drop double underscores
Date: Tue, 27 Aug 2024 23:55:37 +0200
Message-ID: <b4a3f01fbdb139307ac735ab41dfe80f9729e3fe.1724795624.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724795623.git.dsterba@suse.com>
References: <cover.1724795623.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50AD21FB85
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The function does not follow the pattern where the underscores would be
justified, so rename it.

Also update the misleading comment, the passed item is not freed, that's
what the caller does.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index b735fce21f07..5258dd86dbd8 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -61,16 +61,14 @@ static int compare_inode_defrag(const struct inode_defrag *defrag1,
 }
 
 /*
- * Pop a record for an inode into the defrag tree.  The lock must be held
+ * Insert a record for an inode into the defrag tree.  The lock must be held
  * already.
  *
  * If you're inserting a record for an older transid than an existing record,
  * the transid already in the tree is lowered.
- *
- * If an existing record is found the defrag item you pass in is freed.
  */
-static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
-				    struct inode_defrag *defrag)
+static int btrfs_insert_inode_defrag(struct btrfs_inode *inode,
+				     struct inode_defrag *defrag)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct inode_defrag *entry;
@@ -157,7 +155,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 		 * and then re-read this inode, this new inode doesn't have
 		 * IN_DEFRAG flag. At the case, we may find the existed defrag.
 		 */
-		ret = __btrfs_add_inode_defrag(inode, defrag);
+		ret = btrfs_insert_inode_defrag(inode, defrag);
 		if (ret)
 			kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 	} else {
-- 
2.45.0


