Return-Path: <linux-btrfs+bounces-4793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C98BD9B0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 05:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CECB2849DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 03:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D85F4F1E4;
	Tue,  7 May 2024 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N7ofmuZA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N7ofmuZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382C8F59
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052202; cv=none; b=o3C/J6EKNos1ke/djOwLGq1MRCScx37NcL0US0qJz+iYpM5cBWFEbXwTrUSD2YmE/lMb3FbkhqznOpYn06i1wGm7xnJLfrkw5/4WuOQkjdrqDnKnRBTpo87h320SfwURJPiHV2mXG/sFB6+tBwRQZ7gXzaWCHvbmM1ayhnUhQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052202; c=relaxed/simple;
	bh=yyESevwEqkls5selzPLL/ElyiZlf3cGevu/9/m4wbuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7ZGPbiIXRIE9fz1PawboR2begLTlfkY69FYKh42ieHjNYpa7KG6iv0mb946C2l86efiTsX3SHQqDDomOjJ/4pBaiPnNXxAauqVdp9Gfq88SBuMH6CND3oHw3TTjzdchADqVlUz6CgWxF4JafcA6iAyOldgy4pkEDS8uK2v0fO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N7ofmuZA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N7ofmuZA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65FCD33845;
	Tue,  7 May 2024 03:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715052198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7udLJszg5+2qHaaozIKSf2aS76+CQ58ZvIdclp+fgdw=;
	b=N7ofmuZAPxuTt97PT+amR4vywKvbQVOMD+8JUCFqeqOhCnYJadz1SQreZoCfHNATEdXqMk
	Ulr8NnINDSUID2V3mI+onL3kZzMRKJJa4KV0lYz7fIKIVwndHDUvdKd3FDs0/7GXB2UZ0z
	UX0whcKaWUT3e0xsvT9VcpUiIRcZsqg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N7ofmuZA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715052198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7udLJszg5+2qHaaozIKSf2aS76+CQ58ZvIdclp+fgdw=;
	b=N7ofmuZAPxuTt97PT+amR4vywKvbQVOMD+8JUCFqeqOhCnYJadz1SQreZoCfHNATEdXqMk
	Ulr8NnINDSUID2V3mI+onL3kZzMRKJJa4KV0lYz7fIKIVwndHDUvdKd3FDs0/7GXB2UZ0z
	UX0whcKaWUT3e0xsvT9VcpUiIRcZsqg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE0D139CB;
	Tue,  7 May 2024 03:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +BqhMqSeOWa9WgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 07 May 2024 03:23:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Yordan <y16267966@gmail.com>
Subject: [PATCH 2/3] btrfs-progs: convert: rework file extent iteration to handle unwritten extents
Date: Tue,  7 May 2024 12:52:54 +0930
Message-ID: <bc92cbbcf4c530b18b27a4989767188ba8ea4f96.1715051693.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715051693.git.wqu@suse.com>
References: <cover.1715051693.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 65FCD33845
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

[BUG]
There is a bug report that btrfs-convert can not handle unwritten
extents (EXT2_EXTENT_FLAGS_UNINIT set, which is pretty much the same as
BTRFS_FILE_EXTENT_PREALLOC), which can cause the converted image to have
incorrect contents.

[CAUSE]
Currently we use ext2fs_block_iterate2() to go through all data extents
of an ext2 inode, but it doesn't provide the info on if the range is
unwritten or not.

Thus for unwritten extents, the results btrfs would just treat it as
regular extents, and read the contents from disk other than setting the
contents to zero.

[FIX]
Instead of the ext2fs_block_iterate2(), here we follow the debugfs'
"dump_extents" command, to use ext2fs_extent_*() helpers to go through
every data extent of the inode, that's if the inode support the
EXT4_EXTENTS_FL flag.

Now we can properly get the info of which extents are unwritten, and use
holes to replace those unwritten extents.

Reported-by: Yordan <y16267966@gmail.com>
Link: https://lore.kernel.org/all/d34c7d77a7f00c93bea6a4d6e83c7caf.mailbg@mail.bg/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/source-ext2.c | 116 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 7 deletions(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index bba81e4034fd..029fa198fc24 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -303,6 +303,88 @@ static int ext2_block_iterate_proc(ext2_filsys fs, blk_t *blocknr,
 	return 0;
 }
 
+static int iterate_one_file_extent(struct blk_iterate_data *data,
+				   u64 filepos, u64 len, u64 disk_bytenr,
+				   bool prealloced)
+{
+	const int sectorsize = data->trans->fs_info->sectorsize;
+	const int sectorbits = ilog2(sectorsize);
+	int ret;
+
+	UASSERT(len > 0);
+	for (int i = 0; i < len; i += sectorsize) {
+		/*
+		 * Just treat preallocated extent as hole.
+		 *
+		 * As there is no way to utilize the preallocated space, since
+		 * any file extent would also be shared by ext2 image.
+		 */
+		if (prealloced)
+			ret = block_iterate_proc(0,
+				(filepos + i) >> sectorbits, data);
+		else
+			ret = block_iterate_proc(
+				(disk_bytenr + i) >> sectorbits,
+				(filepos + i) >> sectorbits, data);
+
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int iterate_file_extents(struct blk_iterate_data *data,
+				ext2_filsys ext2fs, ext2_ino_t ext2_ino,
+				u32 convert_flags)
+{
+	ext2_extent_handle_t handle = NULL;
+	struct ext2fs_extent extent;
+	const int sectorsize = data->trans->fs_info->sectorsize;
+	const int sectorbits = ilog2(sectorsize);
+	int op = EXT2_EXTENT_ROOT;
+	errcode_t errcode;
+	int ret = 0;
+
+	errcode = ext2fs_extent_open(ext2fs, ext2_ino, &handle);
+	if (errcode) {
+		error("failed to open ext2 inode %u: %s", ext2_ino,
+		      error_message(errcode));
+		return -EIO;
+	}
+	while (1) {
+		u64 disk_bytenr;
+		u64 filepos;
+		u64 len;
+
+		errcode = ext2fs_extent_get(handle, op, &extent);
+		if (errcode == EXT2_ET_EXTENT_NO_NEXT)
+			break;
+		if (errcode) {
+			data->errcode = errcode;
+			ret = -EIO;
+			goto out;
+		}
+		op = EXT2_EXTENT_NEXT;
+
+		if (extent.e_flags & EXT2_EXTENT_FLAGS_SECOND_VISIT)
+			continue;
+		if (!(extent.e_flags & EXT2_EXTENT_FLAGS_LEAF))
+			continue;
+
+		filepos = extent.e_lblk << sectorbits;
+		len = extent.e_len << sectorbits;
+		disk_bytenr = extent.e_pblk << sectorbits;
+
+		ret = iterate_one_file_extent(data, filepos, len, disk_bytenr,
+				extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT);
+		if (ret < 0)
+			goto out;
+	}
+out:
+	ext2fs_extent_free(handle);
+	return ret;
+}
+
 /*
  * traverse file's data blocks, record these data blocks as file extents.
  */
@@ -315,6 +397,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 	int ret;
 	char *buffer = NULL;
 	errcode_t err;
+	struct ext2_inode ext2_inode = { 0 };
 	u32 last_block;
 	u32 sectorsize = root->fs_info->sectorsize;
 	u64 inode_size = btrfs_stack_inode_size(btrfs_inode);
@@ -323,10 +406,32 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
 			convert_flags & CONVERT_FLAG_DATACSUM);
 
-	err = ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
-				    NULL, ext2_block_iterate_proc, &data);
-	if (err)
-		goto error;
+	err = ext2fs_read_inode(ext2_fs, ext2_ino, &ext2_inode);
+	if (err) {
+		error("failed to read ext2 inode %u: %s",
+			ext2_ino, error_message(err));
+		return -EIO;
+	}
+	/*
+	 * For inodes without extent block maps, go with the older
+	 * ext2fs_block_iterate2().
+	 * Otherwise use ext2fs_extent_*() based solution, as that can provide
+	 * UNINIT extent flags.
+	 */
+	if ((ext2_inode.i_flags & EXT4_EXTENTS_FL) == 0) {
+		err = ext2fs_block_iterate2(ext2_fs, ext2_ino,
+					    BLOCK_FLAG_DATA_ONLY, NULL,
+					    ext2_block_iterate_proc, &data);
+		if (err) {
+			error("ext2fs_block_iterate2: %s", error_message(err));
+			return -EIO;
+		}
+	} else {
+		ret = iterate_file_extents(&data, ext2_fs, ext2_ino,
+					   convert_flags);
+		if (ret < 0)
+			goto fail;
+	}
 	ret = data.errcode;
 	if (ret)
 		goto fail;
@@ -366,9 +471,6 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 fail:
 	free(buffer);
 	return ret;
-error:
-	error("ext2fs_block_iterate2: %s", error_message(err));
-	return -1;
 }
 
 static int ext2_create_symlink(struct btrfs_trans_handle *trans,
-- 
2.45.0


