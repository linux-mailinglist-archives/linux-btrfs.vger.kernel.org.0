Return-Path: <linux-btrfs+bounces-7757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765FF969148
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 04:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADBB1C22959
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 02:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709CA1CCEDF;
	Tue,  3 Sep 2024 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bhZv7cBy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g5c+NQOQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27513D503
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725329101; cv=none; b=IcW5GBVt+6H1/RrbB1hJMpHhDlcGXh+lWGMhVFv286A8Gs2GP9AHLUXRm7FM1BHUQLNnKTOgKhvoAMy3DDW+x7nzrbw1L9sHARYOasi3gBuozdIy6gS07vsx9Sdt8qIpbsDWKPB0ClaVG2U2gqDa3xBnhuD8syJ0LdJ8BWVDhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725329101; c=relaxed/simple;
	bh=tLoR68gJBNhEt0sQPfwHtVjREnYv1zI1wHI4arW5Qyw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nnYddiFpuOgQkd/oai66SrusuzsNrAYCrtgIOQirPdozpxZMa+Vx3rkqcjloNT1Bo6sORTLcYE38iALulvLx2gv5VuOUONK7e6M+x0s8J4q321zw5iNUI7WEpAo1d3Kb6dPmLV69rI/IjiFUOQwpPMd7nl5v/kYkrdDHwW83CWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bhZv7cBy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g5c+NQOQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0A1B21B5A
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 02:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725329097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OnE+g8a/QVjZTz+SZzpIwqC1X0mEVCsrbHEDeFc9gWk=;
	b=bhZv7cByMzP0Q2SKNrznJhdQhPF3tMyayaUSkvGsoX+N4q5CjvH0ThUxCbEa5jjgZs2ITB
	7jlqpHTz0e2JXA25pzBcRHzPWQndDZanSZNGoL5I5p2WLN5qaL8b7/uNDao0JZw4Ydn4e3
	Xd4AVKUlCL7EHAD2Av9puTkfPjln0+E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725329096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OnE+g8a/QVjZTz+SZzpIwqC1X0mEVCsrbHEDeFc9gWk=;
	b=g5c+NQOQcCIiLSbGVrdkSetPpcnpcrOLSD4YjjBn3QPZsXbmHc9bXoPR2weeR+syTNhUJn
	7pIwtxmsmZ00G39KgEPfRzb2sbMfutY43fhuZj+cFOA2a2vDRJqfUgnVny01+7M9KiEI9O
	D5xA+fL+zwdmoQOdLc3Gwb1TyG+5XkY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9C931351A
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 02:04:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jUMTIsdu1mZndAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 02:04:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: convert: fix inline extent size for symbol link
Date: Tue,  3 Sep 2024 11:34:33 +0930
Message-ID: <08ff5d66302e6b84481fda9d50d53bb50a519fd3.1725329062.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
For btrfs converted from ext* or reiserfs, the inlined data extent is
always one byte larger than the inode size:

	item 10 key (267 INODE_ITEM 0) itemoff 15543 itemsize 160
		generation 1 transid 1 size 4 nbytes 5
		block group 0 mode 120777 links 1 uid 0 gid 0 rdev 0
		sequence 0 flags 0x0(none)
	item 11 key (267 INODE_REF 256) itemoff 15529 itemsize 14
		index 3 namelen 4 name: path
	item 12 key (267 EXTENT_DATA 0) itemoff 15503 itemsize 26
		generation 4 type 0 (inline)
		inline extent data size 5 ram_bytes 5 compression 0 (none)

[CAUSE]
Inside the symbol link creation path for each fs, they all create the
inline data extent with a tailing NUL ('\0').

This is different from what btrfs kernel module does:

	item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
		generation 9 transid 9 size 4 nbytes 4
		block group 0 mode 120777 links 1 uid 0 gid 0 rdev 0
		sequence 0 flags 0x0(none)
	item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
		index 2 namelen 4 name: path
	item 6 key (257 EXTENT_DATA 0) itemoff 15844 itemsize 25
		generation 9 type 0 (inline)
		inline extent data size 4 ram_bytes 4 compression 0 (none)

[FIX]
Thankfully this is not a big deal, kernel properly reads the content and
use inode size to determine the proper link target.

Just align the btrfs-progs convert behavior to the kernel one.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/source-ext2.c     | 4 ++--
 convert/source-reiserfs.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index acba5db7ee81..d5d6b165a62d 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -489,8 +489,8 @@ static int ext2_create_symlink(struct btrfs_trans_handle *trans,
 	pathname = (char *)&(ext2_inode->i_block[0]);
 	BUG_ON(pathname[inode_size] != 0);
 	ret = btrfs_insert_inline_extent(trans, root, objectid, 0,
-					 pathname, inode_size + 1);
-	btrfs_set_stack_inode_nbytes(btrfs_inode, inode_size + 1);
+					 pathname, inode_size);
+	btrfs_set_stack_inode_nbytes(btrfs_inode, inode_size);
 	return ret;
 }
 
diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
index 3edc72ed08a5..e2f07bfda188 100644
--- a/convert/source-reiserfs.c
+++ b/convert/source-reiserfs.c
@@ -538,8 +538,8 @@ static int reiserfs_copy_symlink(struct btrfs_trans_handle *trans,
 	len = get_ih_item_len(tp_item_head(&path));
 
 	ret = btrfs_insert_inline_extent(trans, root, objectid, 0,
-					 symlink, len + 1);
-	btrfs_set_stack_inode_nbytes(btrfs_inode, len + 1);
+					 symlink, len);
+	btrfs_set_stack_inode_nbytes(btrfs_inode, len);
 fail:
 	pathrelse(&path);
 	return ret;
-- 
2.46.0


