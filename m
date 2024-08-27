Return-Path: <linux-btrfs+bounces-7584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D75B96198F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E061B285275
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C611D4143;
	Tue, 27 Aug 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aDONwQF6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aDONwQF6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C81D3652
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795739; cv=none; b=SzQGiaQxlK0wDfm2+HKFnkqK33Pj1YDsSdP6BtoMUdjgFHdN0jPw99RMcCPgWtIeaB2vj+L1cdrUFYmQXfej6wqDykopLxyYvusWlAl74BOgvkk70vvuz0gugb0wUaFK/VOw/5vQQAxc8dEDB6fOi5ZqyKJOX0CoxU14jLxuOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795739; c=relaxed/simple;
	bh=FD3UI7HIStretQV7Qce5SmIqQPP9i5At5YC8Jz5vX6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ2mAzdSHjb7bqPwRy802Se1BaSu8o5mNcaBX+tpSq69jy/9NuC4IrM3KsEen9qocynPYzj33Y1BKfscO+yn4X6MsmjHKDVWrwfbeDbDpPh2rVcCzizXBwhLFv1TzjD7CcaMuMHzoD16Gq+NFNdBDXY/Z+MGa/AB6ibD6px39CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aDONwQF6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aDONwQF6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D71E621B30;
	Tue, 27 Aug 2024 21:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slM3tmncjSXqojuAq31FCcmDBeX7RbvZSbn/a2l7j/Y=;
	b=aDONwQF6g2Iytu1ge530cDoatkx5QjoaLzER3HGncfCc+O0tBb4vounhBUhrPOMxRU4ZxT
	xKXDlxgRrS17J4FtslKdsTgrDqHSvrwd9mHw6bd5yfZqyWzW/0ztrzfUhyZqLW2lU3vM6t
	KWoLllH/4NTQo1AE6nBa6I2sGQpypMU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slM3tmncjSXqojuAq31FCcmDBeX7RbvZSbn/a2l7j/Y=;
	b=aDONwQF6g2Iytu1ge530cDoatkx5QjoaLzER3HGncfCc+O0tBb4vounhBUhrPOMxRU4ZxT
	xKXDlxgRrS17J4FtslKdsTgrDqHSvrwd9mHw6bd5yfZqyWzW/0ztrzfUhyZqLW2lU3vM6t
	KWoLllH/4NTQo1AE6nBa6I2sGQpypMU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0B1D13A20;
	Tue, 27 Aug 2024 21:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kzXxMldLzmaoGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:35 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/12] btrfs: rename __need_auto_defrag() and drop double underscores
Date: Tue, 27 Aug 2024 23:55:35 +0200
Message-ID: <c6d88537eb7b80174f6fbcdcf31d01d1f652c9ca.1724795624.git.dsterba@suse.com>
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

The function does not follow the pattern where the underscores would be
justified, so rename it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index e4bb5a8651f3..b735fce21f07 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -107,7 +107,7 @@ static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
 	return 0;
 }
 
-static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
+static inline int need_auto_defrag(struct btrfs_fs_info *fs_info)
 {
 	if (!btrfs_test_opt(fs_info, AUTO_DEFRAG))
 		return 0;
@@ -130,7 +130,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 	u64 transid;
 	int ret;
 
-	if (!__need_auto_defrag(fs_info))
+	if (!need_auto_defrag(fs_info))
 		return 0;
 
 	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
@@ -245,7 +245,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 again:
 	if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
 		goto cleanup;
-	if (!__need_auto_defrag(fs_info))
+	if (!need_auto_defrag(fs_info))
 		goto cleanup;
 
 	/* Get the inode */
@@ -306,7 +306,7 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 		if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
 			break;
 
-		if (!__need_auto_defrag(fs_info))
+		if (!need_auto_defrag(fs_info))
 			break;
 
 		/* find an inode to defrag */
-- 
2.45.0


