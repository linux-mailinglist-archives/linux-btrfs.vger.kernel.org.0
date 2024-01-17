Return-Path: <linux-btrfs+bounces-1524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC8D830BB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 18:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4D6B21AB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804A422613;
	Wed, 17 Jan 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oqLyBeFb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oqLyBeFb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAA225A6
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511438; cv=none; b=ZLY0Bix+QhNqQNx/mTHsrZ+CQM9Hqdj2fKttT9YGZ2tgfR1IKeKOoMBX0Z33xviXrng2dEWCtGsb6maw4rWMIoQDvGONqOduFSXT53FpwKMoQZqAuFGVDRhUKBBa52CMHkY4naqRx8MWVwsGXa9oAR1REZckXjY7n2J3zCrG9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511438; c=relaxed/simple;
	bh=GWrtICo/WvnNCZozoLtQdcKtReHpJ+v35+5BCo8T5Hc=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Level:
	 X-Spam-Flag:X-Spam-Score; b=WJGx5PNidqZ7IiB1lUdzzUOssHu8C6a3bkrA9uoT19P19iAm20j/17/drn1K6rxGCzDIFDuDpg9pGu/1n8qddrS33ZRWqpXqvm/brE11g9LRhFeSOVVLbjFKxbV4imSGp5Wm0BuDu4Zpv1uJR0Gh7NPiz5/l0eF6rTFV02e9vIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oqLyBeFb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oqLyBeFb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1336D21E5A;
	Wed, 17 Jan 2024 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705511435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UhKnbiwlfWcDl+KmbHGu6v2IBqNI7t1jkASRHQQBRo=;
	b=oqLyBeFbM6n4McoUmW+ySNL2fkmqlcPdJYo4M9dj858OY2hH+OfDQmbcLpT47WwuppiqKK
	6T1WPjwdez3Ocd1iFyqgMYxUKy1SUZW5cbVeIyucV27FPhJXkVevQbJwNZ5/UBNxWhXLRI
	e59IyliKQk0vG4VEPgvUMYhAufiMhy4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705511435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UhKnbiwlfWcDl+KmbHGu6v2IBqNI7t1jkASRHQQBRo=;
	b=oqLyBeFbM6n4McoUmW+ySNL2fkmqlcPdJYo4M9dj858OY2hH+OfDQmbcLpT47WwuppiqKK
	6T1WPjwdez3Ocd1iFyqgMYxUKy1SUZW5cbVeIyucV27FPhJXkVevQbJwNZ5/UBNxWhXLRI
	e59IyliKQk0vG4VEPgvUMYhAufiMhy4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0786B13482;
	Wed, 17 Jan 2024 17:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SMXTAQsKqGU9UwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 17 Jan 2024 17:10:35 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: replace sb::s_blocksize by fs_info::sectorsize
Date: Wed, 17 Jan 2024 18:10:17 +0100
Message-ID: <0f6cc13dce98488133a9546470a602a75275b467.1705511340.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1705511340.git.dsterba@suse.com>
References: <cover.1705511340.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

The block size stored in the super block is used by subsystems outside
of btrfs and it's a copy of fs_info::sectorsize. Unify that to always
use our sectorsize, with the exception of mount where we first need to
use fixed values (4K) until we read the super block and can set the
sectorsize.

Replace all uses, in most cases it's fewer pointer indirections.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c   | 2 ++
 fs/btrfs/extent_io.c | 4 ++--
 fs/btrfs/inode.c     | 2 +-
 fs/btrfs/ioctl.c     | 2 +-
 fs/btrfs/reflink.c   | 6 +++---
 fs/btrfs/send.c      | 2 +-
 fs/btrfs/super.c     | 2 +-
 7 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6e17496769ff..51c6127508af 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2831,6 +2831,7 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	int ret;
 
 	fs_info->sb = sb;
+	/* Temporary fixed values for block size until we read the superblock. */
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
 	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
@@ -3348,6 +3349,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
 
+	/* Update the values for the current filesystem. */
 	sb->s_blocksize = sectorsize;
 	sb->s_blocksize_bits = blksize_bits(sectorsize);
 	memcpy(&sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 48ece936d733..cbf2feab2f8b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1035,7 +1035,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	int ret = 0;
 	size_t pg_offset = 0;
 	size_t iosize;
-	size_t blocksize = inode->i_sb->s_blocksize;
+	size_t blocksize = fs_info->sectorsize;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
 	ret = set_page_extent_mapped(page);
@@ -2325,7 +2325,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	struct extent_state *cached_state = NULL;
 	u64 start = folio_pos(folio);
 	u64 end = start + folio_size(folio) - 1;
-	size_t blocksize = folio->mapping->host->i_sb->s_blocksize;
+	size_t blocksize = btrfs_sb(folio->mapping->host->i_sb)->sectorsize;
 
 	/* This function is only called for the btree inode */
 	ASSERT(tree->owner == IO_TREE_BTREE_INODE_IO);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7199670599d9..5919731c4355 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8686,7 +8686,7 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 	u64 delalloc_bytes;
 	u64 inode_bytes;
 	struct inode *inode = d_inode(path->dentry);
-	u32 blocksize = inode->i_sb->s_blocksize;
+	u32 blocksize = btrfs_sb(inode->i_sb)->sectorsize;
 	u32 bi_flags = BTRFS_I(inode)->flags;
 	u32 bi_ro_flags = BTRFS_I(inode)->ro_flags;
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dfed9dd9c2d7..58e0c59bc4cd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -528,7 +528,7 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 	 * block group is in the logical address space, which can be any
 	 * sectorsize aligned bytenr in  the range [0, U64_MAX].
 	 */
-	if (range.len < fs_info->sb->s_blocksize)
+	if (range.len < fs_info->sectorsize)
 		return -EINVAL;
 
 	range.minlen = max(range.minlen, minlen);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index ae90894dc7dc..e38cb40e150c 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -663,7 +663,7 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 				   struct inode *dst, u64 dst_loff)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(src)->root->fs_info;
-	const u64 bs = fs_info->sb->s_blocksize;
+	const u64 bs = fs_info->sectorsize;
 	int ret;
 
 	/*
@@ -730,7 +730,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	int ret;
 	int wb_ret;
 	u64 len = olen;
-	u64 bs = fs_info->sb->s_blocksize;
+	u64 bs = fs_info->sectorsize;
 
 	/*
 	 * VFS's generic_remap_file_range_prep() protects us from cloning the
@@ -796,7 +796,7 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
-	u64 bs = BTRFS_I(inode_out)->root->fs_info->sb->s_blocksize;
+	u64 bs = BTRFS_I(inode_out)->root->fs_info->sectorsize;
 	u64 wb_len;
 	int ret;
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7902298c1f25..141ab89fb63e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6140,7 +6140,7 @@ static int send_write_or_clone(struct send_ctx *sctx,
 	int ret = 0;
 	u64 offset = key->offset;
 	u64 end;
-	u64 bs = sctx->send_root->fs_info->sb->s_blocksize;
+	u64 bs = sctx->send_root->fs_info->sectorsize;
 
 	end = min_t(u64, btrfs_file_extent_end(path), sctx->cur_inode_size);
 	if (offset >= end)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 101f786963d4..c45fdaf24cd1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1767,7 +1767,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
-	buf->f_bsize = dentry->d_sb->s_blocksize;
+	buf->f_bsize = fs_info->sectorsize;
 	buf->f_namelen = BTRFS_NAME_LEN;
 
 	/* We treat it as constant endianness (it doesn't matter _which_)
-- 
2.42.1


