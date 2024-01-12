Return-Path: <linux-btrfs+bounces-1407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30782BAF1
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 06:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB851F23E9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 05:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C975B5D4;
	Fri, 12 Jan 2024 05:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CSMfXhvp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CSMfXhvp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C385B5A3
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D55F22050
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 05:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705038226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ltOFMpobOG69SxP/ltnFGcSLDve0Jfc5e1YLuqdDols=;
	b=CSMfXhvpTMoYQODz3Z2ADsOEpIl3vlfZqWuVFfs/r65z/ID/Ng8IqLftf+lH+tKp2La2r/
	6cYGQYnE8JZ54enGkbkcQErhGquDvZX5Tft7mLRFP5+OtcJ5LpIjvS/h6adPVhkM1l6VaP
	dyx9c7RHtoW0fCx5iQGofSnw8qnA0V8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705038226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ltOFMpobOG69SxP/ltnFGcSLDve0Jfc5e1YLuqdDols=;
	b=CSMfXhvpTMoYQODz3Z2ADsOEpIl3vlfZqWuVFfs/r65z/ID/Ng8IqLftf+lH+tKp2La2r/
	6cYGQYnE8JZ54enGkbkcQErhGquDvZX5Tft7mLRFP5+OtcJ5LpIjvS/h6adPVhkM1l6VaP
	dyx9c7RHtoW0fCx5iQGofSnw8qnA0V8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1E75136A4
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 05:43:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qcAiGZHRoGUlfQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 05:43:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: convert-ext2: fix possible tree-checker error when converting a large fs
Date: Fri, 12 Jan 2024 16:13:27 +1030
Message-ID: <f238f09e92c4043d5e6892c322234515b260df20.1705038162.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CSMfXhvp
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 6D55F22050
X-Spam-Flag: NO

[BUG]
There is a report about failed btrfs-convert, which shows the following
error:

 corrupt leaf: root=5 block=5001928998912 slot=1 ino=89911763, invalid previous key objectid, have 89911762 expect 89911763
 ERROR: failed to copy ext2 inode 89911320: -5
 ERROR: error during copy_inodes -5
 WARNING: error during conversion, the original filesystem is not modified

[CAUSE]
Above error is triggered when checking the following items inside a
subvolume:

- inode ref
- dir item/index
- file extent
- xattr

This is to make sure these items have correct previous key.

However btrfs-convert is not following this requirement, it always
insert those items first, then create a btrfs_inode for it.

Thus it can lead to the error.

This can only happen for large fs, as for most cases we have all these
modified tree blocks cached, thus tree-checker won't be triggered.
But when the tree block cache is not hit, and we have to read from disk,
then such behavior can lead to above tree-checker error.

[FIX]
Make sure we insert the inode item first, then the file extents/dir
items/xattrs.
And after the file extents/dir items/xattrs inserted, we update the
existing inode (to update its size and bytes).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/source-ext2.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index cfffc9e21b2d..7e93b0901489 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -854,6 +854,8 @@ static int ext2_copy_single_inode(struct btrfs_trans_handle *trans,
 	int ret;
 	int s_inode_size;
 	struct btrfs_inode_item btrfs_inode;
+	struct btrfs_key inode_key;
+	struct btrfs_path path = { 0 };
 
 	if (ext2_inode->i_links_count == 0)
 		return 0;
@@ -875,6 +877,15 @@ static int ext2_copy_single_inode(struct btrfs_trans_handle *trans,
 	}
 	ext2_convert_inode_flags(&btrfs_inode, ext2_inode);
 
+	/*
+	 * The inode item must be inserted before any file extents/dir items/xattrs,
+	 * or we may trigger tree-checker. (File extents/dir items/xattrs require
+	 * the previous item has the same key objectid).
+	 */
+	ret = btrfs_insert_inode(trans, root, objectid, &btrfs_inode);
+	if (ret < 0)
+		return ret;
+
 	switch (ext2_inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		ret = ext2_create_file_extents(trans, root, objectid,
@@ -901,7 +912,25 @@ static int ext2_copy_single_inode(struct btrfs_trans_handle *trans,
 		if (ret)
 			return ret;
 	}
-	return btrfs_insert_inode(trans, root, objectid, &btrfs_inode);
+
+	/*
+	 * Update the inode item, as above insert never updates the inode's
+	 * nbytes and size.
+	 */
+	inode_key.objectid = objectid;
+	inode_key.type = BTRFS_INODE_ITEM_KEY;
+	inode_key.offset = 0;
+
+	ret = btrfs_lookup_inode(trans, root, &path, &inode_key, 1);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		return ret;
+	write_extent_buffer(path.nodes[0], &btrfs_inode,
+			    btrfs_item_ptr_offset(path.nodes[0], path.slots[0]),
+			    sizeof(btrfs_inode));
+	btrfs_release_path(&path);
+	return 0;
 }
 
 static bool ext2_is_special_inode(ext2_filsys ext2_fs, ext2_ino_t ino)
-- 
2.43.0


