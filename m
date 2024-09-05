Return-Path: <linux-btrfs+bounces-7845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0E696CC1D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 03:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7B91F27637
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 01:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2D18F40;
	Thu,  5 Sep 2024 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bb9DlFrN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bb9DlFrN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8979DC
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498834; cv=none; b=Swsoo2PuQOmBIh9rjzscEbGfGTvbkh+7z6sKt4J+wBpx/zMjxgamZFSFCyzEtcRXwFVHwYllUXc5VAQp5Xqzra5v7UVst2so71Q65A5k6L5yUSSYLJ4gd6x7QfG/vmNc7Rs0YQDIh5oKxkmfjvbW0CqH49b9S06ihS6cITIhgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498834; c=relaxed/simple;
	bh=3SemLpMbxOjY3l4ZgvUZiMNUAuW62W8y7VM2Ruo9c6Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQ3ifAlt8OQCmtqQXFfY8ty5Fk0qnLWSqkjao6MaJNhO6yngn8Z4+KRvQf3957/eYZ9HmMv0LBkvimPn2KsaEiJE6tYvVVDlmZfuXjs5uMRvsazJ0Ep08WW6pVLXsS930LWuLAGZj8MQg6OYibBk+vkHKeydy/XNs4151RiVnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bb9DlFrN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bb9DlFrN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BE5E21A00
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725498830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1e0TrzUsYMos6YwtndrYPh2pr7jNyVnN6mKPOdHCNw=;
	b=Bb9DlFrNmVW+PwhNKzwMILktqxcyxunGJAtooQYLsGa2upoFS/Zk74gESZWb2nlxmH91gi
	uxjMzv+rnihm1rEdLi/zYke0QULFeaB0rg5qQjlNoHxm491fXfskb916GnaoieQOnLKVry
	BhuSIJGIlK/r3mtt9+zn3nRsnOufqr4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725498830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1e0TrzUsYMos6YwtndrYPh2pr7jNyVnN6mKPOdHCNw=;
	b=Bb9DlFrNmVW+PwhNKzwMILktqxcyxunGJAtooQYLsGa2upoFS/Zk74gESZWb2nlxmH91gi
	uxjMzv+rnihm1rEdLi/zYke0QULFeaB0rg5qQjlNoHxm491fXfskb916GnaoieQOnLKVry
	BhuSIJGIlK/r3mtt9+zn3nRsnOufqr4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDDA213508
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mMM4IM0F2WbMKQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2024 01:13:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs-progs: check/lowmem: detect invalid file extents for symbolic links
Date: Thu,  5 Sep 2024 10:43:23 +0930
Message-ID: <f33f44f9e7c886343b9fab5aa72d6ebf1c9faa82.1725498618.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725498618.git.wqu@suse.com>
References: <cover.1725498618.git.wqu@suse.com>
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
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
There is a recent bug that btrfs/012 fails and kernel rejects to read a
symbolic link which is backed by a regular extent.

Furthremore in that case, "btrfs check --mode=lowmem" doesn't detect such
problem at all.

[CAUSE]
For symbolic links, we only allow inline extents, and this means we should
only have a symbolic link target which is smaller than 4K.

But lowmem mode btrfs check doesn't handle symbolic link inodes any
differently, thus it doesn't check if the file extents are inlined or not,
nor reporting this problem as an error.

[FIX]
When processing data extents, if we find the owning inode is a symbolic
link, and the file extent is regular/preallocated, report an error for
the bad file extent item.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index a9908eaf629d..4b6faccacbbc 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -3351,6 +3351,31 @@ out_no_release:
 	return err;
 }
 
+static int read_inode_item(struct btrfs_root *root,
+			   u64 ino, struct btrfs_inode_item *ret_ii)
+{
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key = {
+		.objectid = ino,
+		.type = BTRFS_INODE_ITEM_KEY,
+		.offset = 0
+	};
+	int ret;
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
+
+	read_extent_buffer(path.nodes[0], ret_ii,
+			   btrfs_item_ptr_offset(path.nodes[0], path.slots[0]),
+			   sizeof(*ret_ii));
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 /*
  * Check EXTENT_DATA item, mainly for its dbackref in extent tree
  *
@@ -3371,6 +3396,7 @@ static int check_extent_data_item(struct btrfs_root *root,
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
 	struct btrfs_extent_data_ref *dref;
+	struct btrfs_inode_item inode_item;
 	u64 owner;
 	u64 disk_bytenr;
 	u64 disk_num_bytes;
@@ -3400,6 +3426,24 @@ static int check_extent_data_item(struct btrfs_root *root,
 	extent_num_bytes = btrfs_file_extent_num_bytes(eb, fi);
 	offset = btrfs_file_extent_offset(eb, fi);
 
+	/*
+	 * There is a regular/preallocated data extent. Make sure the owning
+	 * inode is not a symbolic link.
+	 * As symbolic links can only have inline data extents.
+	 */
+	ret = read_inode_item(root, fi_key.objectid, &inode_item);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to grab the inode item for inode %llu: %m",
+		      fi_key.objectid);
+		err |= INODE_ITEM_MISSING;
+	}
+	if (S_ISLNK(inode_item.mode)) {
+		error("symbolic link at root %lld ino %llu has regular/preallocated extents",
+		      root->root_key.objectid, fi_key.objectid);
+		err |= FILE_EXTENT_ERROR;
+	}
+
 	/* Check unaligned disk_bytenr, disk_num_bytes and num_bytes */
 	if (!IS_ALIGNED(disk_bytenr, gfs_info->sectorsize)) {
 		error(
-- 
2.46.0


