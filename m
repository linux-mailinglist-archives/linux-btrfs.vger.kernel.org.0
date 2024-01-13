Return-Path: <linux-btrfs+bounces-1421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBED082C833
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 01:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADF91C227D7
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 00:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F17436C;
	Sat, 13 Jan 2024 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="njV1DBOh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="njV1DBOh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C46364
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFD4F1F44E
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 00:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705104406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v8U9Yp3Skhjse+ItRul8drCcj3LaGrfhH+SLcpsGHIA=;
	b=njV1DBOhVmJZZYW5Z/FKqkxIEDSi5tymw+GYe6IeZ+RY/JA6WFlS2EFQELizbKYWkKm6Xl
	PFgqiwPVx6GozNRnYYia5xjrjoSwo2gq+acBacPbUK5umfi4YEq/pCOqZ0LOpgMpQhjOxP
	OLvbXS3xgVLrtMcK0aHZmYDenyuLUHs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705104406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v8U9Yp3Skhjse+ItRul8drCcj3LaGrfhH+SLcpsGHIA=;
	b=njV1DBOhVmJZZYW5Z/FKqkxIEDSi5tymw+GYe6IeZ+RY/JA6WFlS2EFQELizbKYWkKm6Xl
	PFgqiwPVx6GozNRnYYia5xjrjoSwo2gq+acBacPbUK5umfi4YEq/pCOqZ0LOpgMpQhjOxP
	OLvbXS3xgVLrtMcK0aHZmYDenyuLUHs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6F2713649
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 00:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sGGUIxXUoWX9FQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 00:06:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: convert-ext2: insert a dummy inode item before inode ref
Date: Sat, 13 Jan 2024 10:36:27 +1030
Message-ID: <6f4ac3afeeef5410d70713bb2fe07245f5817fb6.1705104367.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=njV1DBOh
X-Spamd-Result: default: False [1.69 / 50.00];
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
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: AFD4F1F44E
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

[BUG]
There is a report about failed btrfs-convert, which shows the following
error:

  Create btrfs metadata
  corrupt leaf: root=5 block=5001931145216 slot=1 ino=89911763, invalid previous key objectid, have 89911762 expect 89911763
  leaf 5001931145216 items 336 free space 7 generation 90 owner FS_TREE
  leaf 5001931145216 flags 0x1(WRITTEN) backref revision 1
  fs uuid 8b69f018-37c3-4b30-b859-42ccfcbe2449
  chunk uuid 448ce78c-ea41-49f6-99dc-46ad80b93da9
          item 0 key (89911762 INODE_REF 3858733) itemoff 16222 itemsize 61
                  index 171 namelen 51 name: [FILENAME1]
          item 1 key (89911763 INODE_REF 3858733) itemoff 16161 itemsize 61
                  index 103 namelen 51 name: [FILENAME2]

[CAUSE]
When iterating a directory, btrfs-convert would insert the DIR_ITEMs,
along with the INODE_REF of that inode.

This leads to above stray INODE_REFs, and trigger the tree-checker.

This can only happen for large fs, as for most cases we have all these
modified tree blocks cached, thus tree-checker won't be triggered.
But when the tree block cache is not hit, and we have to read from disk,
then such behavior can lead to above tree-checker error.

[FIX]
Insert a dummy INODE_ITEM for the INODE_REF first, the inode items would
be updated when iterating the child inode of the directory.

Issue: #731
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/source-ext2.c | 30 ++++++++++++++++++++----------
 convert/source-fs.c   | 13 +++++++++++++
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index 7e93b0901489..f56d79734715 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -857,6 +857,10 @@ static int ext2_copy_single_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_key inode_key;
 	struct btrfs_path path = { 0 };

+	inode_key.objectid = objectid;
+	inode_key.type = BTRFS_INODE_ITEM_KEY;
+	inode_key.offset = 0;
+
 	if (ext2_inode->i_links_count == 0)
 		return 0;

@@ -878,13 +882,23 @@ static int ext2_copy_single_inode(struct btrfs_trans_handle *trans,
 	ext2_convert_inode_flags(&btrfs_inode, ext2_inode);

 	/*
-	 * The inode item must be inserted before any file extents/dir items/xattrs,
-	 * or we may trigger tree-checker. (File extents/dir items/xattrs require
-	 * the previous item has the same key objectid).
+	 * The inode may already be created (with dummy contents), in that
+	 * case we don't need to do anything yet.
+	 * The inode item would be updated at the end anyway.
 	 */
-	ret = btrfs_insert_inode(trans, root, objectid, &btrfs_inode);
-	if (ret < 0)
-		return ret;
+	ret = btrfs_lookup_inode(trans, root, &path, &inode_key, 1);
+	btrfs_release_path(&path);
+	if (ret > 0) {
+		/*
+		 * No inode item yet, the inode item must be inserted before
+		 * any file extents/dir items/xattrs, or we may trigger
+		 * tree-checker. (File extents/dir items/xattrs require the
+		 * previous item has the same key objectid).
+		 */
+		ret = btrfs_insert_inode(trans, root, objectid, &btrfs_inode);
+		if (ret < 0)
+			return ret;
+	}

 	switch (ext2_inode->i_mode & S_IFMT) {
 	case S_IFREG:
@@ -917,10 +931,6 @@ static int ext2_copy_single_inode(struct btrfs_trans_handle *trans,
 	 * Update the inode item, as above insert never updates the inode's
 	 * nbytes and size.
 	 */
-	inode_key.objectid = objectid;
-	inode_key.type = BTRFS_INODE_ITEM_KEY;
-	inode_key.offset = 0;
-
 	ret = btrfs_lookup_inode(trans, root, &path, &inode_key, 1);
 	if (ret > 0)
 		ret = -ENOENT;
diff --git a/convert/source-fs.c b/convert/source-fs.c
index fe1ff7d0d795..ff6912dfa21f 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -183,6 +183,7 @@ int convert_insert_dirent(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	u64 inode_size;
+	struct btrfs_inode_item dummy_iitem = { 0 };
 	struct btrfs_key location = {
 		.objectid = objectid,
 		.offset = 0,
@@ -193,6 +194,18 @@ int convert_insert_dirent(struct btrfs_trans_handle *trans,
 				    dir, &location, file_type, index_cnt);
 	if (ret)
 		return ret;
+	/*
+	 * We must have an INOTE_ITEM before INODE_REF, or tree-checker won't
+	 * be happy.
+	 * The content of the INODE_ITEM would be properly updated when iterating
+	 * that child inode.
+	 */
+	ret = btrfs_insert_inode(trans, root, objectid, &dummy_iitem);
+	/* The inode item is already there, just skip it. */
+	if (ret == -EEXIST)
+		ret = 0;
+	if (ret < 0)
+		return ret;
 	ret = btrfs_insert_inode_ref(trans, root, name, name_len,
 				     objectid, dir, index_cnt);
 	if (ret)
--
2.43.0


