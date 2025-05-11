Return-Path: <linux-btrfs+bounces-13864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA6AB26F3
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 May 2025 08:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F01A1897917
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 May 2025 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C9119E97A;
	Sun, 11 May 2025 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mp7oLqoc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mp7oLqoc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D09172BD5
	for <linux-btrfs@vger.kernel.org>; Sun, 11 May 2025 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746946135; cv=none; b=qvm9gnf/KdrFiOKAVFKjQHqfGyEkWSuzVtJI0oRvsxoF5r72yVBX//GsnPeTIW+9HTj+pBCDd4GXEYnlnaQn5HCyN9vLP2xAgjJPnuFYGYC0nL5pWGC0FTuQdxJ6mVo85Eo52mc2BqT9uJGH58mv6o6hDLQbjw5brcuDYz0tF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746946135; c=relaxed/simple;
	bh=8papjk8Cy4BY7Q6lD7xnchgqIyYadgjg4g7jMFX5TRs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy34G5z2sQPsKYdYbBpSH32UuZKczOyV0GwKzYVlz+TSzjiedz6C4AHJ3zNcwwaj81dHh7AgrFcm1+qd+BTFMyxKMzy/Dj8wiKf2b+xkbR7fsBaeZpP8QXJLUyuXivf+gB1BrHkJ/W+cLKNOfD3a/jAmfAsc7LkqMnTyxnAPUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mp7oLqoc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mp7oLqoc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C49C721175
	for <linux-btrfs@vger.kernel.org>; Sun, 11 May 2025 06:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746946126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UByntW3C51CBjqO1cx+3mTPbGiMB5y488KBlvRyu3cI=;
	b=mp7oLqoczBDhcIV0G9aObAv/CKLUnQBqmGUpnt8AyAlGBmi94nw8qGl/onu/Dyt5vYII5A
	UcDoHW3r+EHzWotfCfsT37FMiZY2/PqhXDJ7HA4onGnvDMnEJDYTdUHkyv7yMOpm1LzEdx
	6iAtH5yPXr4oAyjB9+nDbtlTC65kD2w=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mp7oLqoc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746946126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UByntW3C51CBjqO1cx+3mTPbGiMB5y488KBlvRyu3cI=;
	b=mp7oLqoczBDhcIV0G9aObAv/CKLUnQBqmGUpnt8AyAlGBmi94nw8qGl/onu/Dyt5vYII5A
	UcDoHW3r+EHzWotfCfsT37FMiZY2/PqhXDJ7HA4onGnvDMnEJDYTdUHkyv7yMOpm1LzEdx
	6iAtH5yPXr4oAyjB9+nDbtlTC65kD2w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E566137E8
	for <linux-btrfs@vger.kernel.org>; Sun, 11 May 2025 06:48:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qLgEMU1IIGh5BwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 11 May 2025 06:48:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: fix a bug in btrfs_find_item()
Date: Sun, 11 May 2025 16:18:20 +0930
Message-ID: <fde9730c75ba419688c3f0503ce4eb9ef24af93e.1746945864.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746945864.git.wqu@suse.com>
References: <cover.1746945864.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C49C721175
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.01

[BUG]
There is a seldomly utilized function, btrfs_find_item(), which has no
document and is not behaving correctly.

Inside backref.c, iterate_inode_refs() and btrfs_ref_to_path() both
utilize this function, to find the parent inode.

However btrfs_find_item() will never return 0 if @ioff is passed as 0
for such usage, result early failure for all kinds of inode iteration
functions.

[CAUSE]
Both functions pass 0 as the @ioff parameter initially, e.g:

 We have the following fs tree root:

  	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 3 transid 9 size 6 nbytes 16384
		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x0(none)
	item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
		index 0 namelen 2 name: ..
	item 2 key (256 DIR_ITEM 2507850652) itemoff 16078 itemsize 33
		location key (257 INODE_ITEM 0) type FILE
		transid 9 data_len 0 name_len 3
		name: foo
	item 3 key (256 DIR_INDEX 2) itemoff 16045 itemsize 33
		location key (257 INODE_ITEM 0) type FILE
		transid 9 data_len 0 name_len 3
		name: foo
	item 4 key (257 INODE_ITEM 0) itemoff 15885 itemsize 160
		generation 9 transid 9 size 16384 nbytes 16384
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 4 flags 0x0(none)
	item 5 key (257 INODE_REF 256) itemoff 15872 itemsize 13
		index 2 namelen 3 name: foo
	item 6 key (257 EXTENT_DATA 0) itemoff 15819 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 13631488 nr 16384
		extent data offset 0 nr 16384 ram 16384
		extent compression 0 (none)

  Then we call paths_from_inode() with:
  - @inum = 257
  - ipath = {.fs_root = 5}

  Then we got the following sequence:

  iterate_irefs(257, fs_root, inode_to_path)
  |- iterate_inode_refs()
     |- inode_ref_info()
        |- btrfs_find_item(257, 0, fs_root)
	|  Returned 1, with @found_key updated to
	|  (257, INODE_REF, 256).

  This makes iterate_irefs() exit immediately, but obviously that
  btrfs_find_item() call is to find any INODE_REF, not to find the
  exact match.

[FIX]
If btrfs_find_item() found an item matching the objectid and type, then
it should return 0 other than 1.

Fix it and keep the behavior the same across btrfs-progs and the kernel.

Since we're here, also add some comments explaining the function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 3184c916175e..f90de606e7b1 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1246,6 +1246,17 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 	}
 }
 
+/*
+ * Find the first key in @fs_root that matches all the following conditions:
+ *
+ * - key.obojectid == @iobjectid
+ * - key.type == @key_type
+ * - key.offset >= ioff
+ *
+ * Return 0 if such key can be found, and @found_key is updated.
+ * Return >0 if no such key can be found.
+ * Return <0 for critical errors.
+ */
 int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
 		u64 iobjectid, u64 ioff, u8 key_type,
 		struct btrfs_key *found_key)
@@ -1280,10 +1291,10 @@ int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
 
 	btrfs_item_key_to_cpu(eb, found_key, path->slots[0]);
 	if (found_key->type != key.type ||
-			found_key->objectid != key.objectid) {
+	    found_key->objectid != key.objectid)
 		ret = 1;
-		goto out;
-	}
+	else
+		ret = 0;
 
 out:
 	if (path != found_path)
-- 
2.49.0


