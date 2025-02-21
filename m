Return-Path: <linux-btrfs+bounces-11704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED8A400AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 21:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA8E4409B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B346253339;
	Fri, 21 Feb 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aNy+Fkbw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yOcejOwN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aNy+Fkbw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yOcejOwN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADED1FBC86
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169279; cv=none; b=MPp6uqoeKAr4UaXOL1yQgkCr/ia1NBD0mJGl6Wf75jgZ7gZmc1YgS72z65vFnbcuGWn0FWJ7tapnaJD69E0apW3UbrpXbggbQqwz0p4ckMqWRnb8BmN0OV/yTveCCV1uE2mnpX057WHk60ZBVznfggN6t+LU7SJiqaryzhE4mH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169279; c=relaxed/simple;
	bh=Hw/+sxcxm8gh4d6Ebw2IJvTQK1YTcPnseDhihzVB3Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcSY6kKRoTuueU1yxaZzM0BUUXyce22oosBP98lJptpm8H5W6FKdUcfvMJ1ZtZu3c4hkTCS7FRCW3ghcYZx3Hyj3wfxYvRyRBWHDoKRqOnyGxpK0P8R6uQRYEiO0kcyzSFO601BBRZEzZwaqAz2WfaHsAk+5vtp+LT6z4ouPJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aNy+Fkbw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yOcejOwN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aNy+Fkbw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yOcejOwN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C51F71F791;
	Fri, 21 Feb 2025 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740169275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fO0x5GHKfx0+pKDyWRvf/dbGla2cjFtay3oRNtFMHVE=;
	b=aNy+Fkbw94y3l5q21aBDv5vesko5+7TaJjpGTVhJGKgKWzLjc2Y3eiFYKeww8BY1B07BUk
	Kpuy8d3GRy1Rdaw67rAkRQ4TPRBbyR+VFPGfQoh2sCqZmAKxVZOgJ9RNLUsWCb2qCPwow3
	/oJCluEjk6FYHHbk9vyNsNd7WwaVORU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740169275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fO0x5GHKfx0+pKDyWRvf/dbGla2cjFtay3oRNtFMHVE=;
	b=yOcejOwNqbQtJU4brcP4CK/7f4suxYAT3rHYEBvoubO6vmc8XGbpLpHg25WolE3p2s/AAi
	YVdHHs1lIL1MbCAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aNy+Fkbw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yOcejOwN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740169275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fO0x5GHKfx0+pKDyWRvf/dbGla2cjFtay3oRNtFMHVE=;
	b=aNy+Fkbw94y3l5q21aBDv5vesko5+7TaJjpGTVhJGKgKWzLjc2Y3eiFYKeww8BY1B07BUk
	Kpuy8d3GRy1Rdaw67rAkRQ4TPRBbyR+VFPGfQoh2sCqZmAKxVZOgJ9RNLUsWCb2qCPwow3
	/oJCluEjk6FYHHbk9vyNsNd7WwaVORU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740169275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fO0x5GHKfx0+pKDyWRvf/dbGla2cjFtay3oRNtFMHVE=;
	b=yOcejOwNqbQtJU4brcP4CK/7f4suxYAT3rHYEBvoubO6vmc8XGbpLpHg25WolE3p2s/AAi
	YVdHHs1lIL1MbCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B67713806;
	Fri, 21 Feb 2025 20:21:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WeTMGzvguGexcgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 21 Feb 2025 20:21:15 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/2] btrfs: add mapping_set_release_always to inode's mapping
Date: Fri, 21 Feb 2025 15:20:52 -0500
Message-ID: <77c012d4216eb9f04e1d3cb5991bdb2cd4e7d50d.1740168635.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740168635.git.rgoldwyn@suse.com>
References: <cover.1740168635.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C51F71F791
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Set mapping_set_release_always() on inode's address_space during
inode initialization so release_folio() is always called.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/file.c      | 2 +-
 fs/btrfs/inode.c     | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7b0aa332aedc..d1f9fad18f25 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -491,7 +491,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		return;
 
-	ASSERT(folio_test_private(folio));
+	ASSERT(mapping_release_always(folio->mapping));
 	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
 }
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2bf57f0e92d2..5808eb5bcd42 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -832,7 +832,7 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
 	 * The private flag check is essential for subpage as we need to store
 	 * extra bitmap using folio private.
 	 */
-	if (folio->mapping != inode->i_mapping || !folio_test_private(folio)) {
+	if (folio->mapping != inode->i_mapping || !mapping_release_always(folio->mapping)) {
 		folio_unlock(folio);
 		return -EAGAIN;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ace9a3ecdefa..6424d45c6baa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5602,6 +5602,8 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	btrfs_set_inode_number(BTRFS_I(inode), args->ino);
 	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
 
+	mapping_set_release_always(inode->i_mapping);
+
 	if (args->root && args->root == args->root->fs_info->tree_root &&
 	    args->ino != BTRFS_BTREE_INODE_OBJECTID)
 		set_bit(BTRFS_INODE_FREE_SPACE_INODE,
@@ -6673,6 +6675,7 @@ static int btrfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
 	inode->i_mapping->a_ops = &btrfs_aops;
+	mapping_set_release_always(inode->i_mapping);
 	return btrfs_create_common(dir, dentry, inode);
 }
 
-- 
2.48.1


