Return-Path: <linux-btrfs+bounces-21785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFFqHUMzl2kcvgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21785-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:58:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E7A16071A
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26B983002A28
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C86347FCC;
	Thu, 19 Feb 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgT9783q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3126CE05
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771516730; cv=none; b=SxwsNVYBDK3eLJ+Ej9yT94HMpwEC7vDRbftZQZ/vIsMoeRcX6NiWBeDzKBy6Yi9qAq0J1oU1Zmea4J0YHNfTKPyFol/3Ls2jx3eQhgoXQRFxW8PbbxR4oXfdiRycdfBR4Mui0hAg2FDs+5A9YpDy/RPkdtgiVY7RBm/8VfiXDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771516730; c=relaxed/simple;
	bh=kp8VBsZayOtQTSlHfvMniPatuhcKlfvpSP5W4aKKuYc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hwoPoVxbf0VJi3jnY7KqDZvEHQHfexaWD4fDGspWwie9NtY/L1HDn+ce7zny/djixVS24H+ltKZKz/2KjMaZmgqVFvX3wqHLb1KRoB6NxMoTDbETsIA4gASLYV0zbYE0F/8s6wBZbgUNefO6tNrtJdSvegkgOUdlSo48rTWGQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgT9783q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D50C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771516729;
	bh=kp8VBsZayOtQTSlHfvMniPatuhcKlfvpSP5W4aKKuYc=;
	h=From:To:Subject:Date:From;
	b=GgT9783q1BBb1+dyjvL18oO1fgXyIfue5r3bJwpw0tQ7rMsJj57eDKCmvOJZL5S8g
	 jSxSsal7Nr2JjEone2dcdBvWAjt4B/K2LwESY7BFVthaqdV+UMzES0v/2tEkaZ904K
	 4Azse0YMtqQlj1U0NKwYNT5mTl3TPkmZTV+LsQ+OcgAM15pqpYRftrWDqFLu4Hnwoh
	 N/PHKifJAQX1zCp7rl1Kz51MSnpe62FHMvVbJa/htb1UnYXyzLqdP6ybbSwHLUhNPe
	 v/82vHaspMyli7wRurWjvq6EuHMX7bcf15tWPdTxIOvd5V7v66KWGIArTF6aIdE++w
	 RH5DG8eHdKsYw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: constify arguments of some functions
Date: Thu, 19 Feb 2026 15:58:46 +0000
Message-ID: <582d0b842cfeed8e97eedf8eabf18b9ebb47cc7b.1771516468.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21785-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 13E7A16071A
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

There are several functions that take pointer arguments but don't need to
modify the objects they point to, so add the const qualifiers.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c    | 6 +++---
 fs/btrfs/disk-io.h    | 2 +-
 fs/btrfs/fs.h         | 4 ++--
 fs/btrfs/misc.h       | 3 ++-
 fs/btrfs/space-info.c | 6 +++---
 fs/btrfs/space-info.h | 2 +-
 fs/btrfs/super.h      | 2 +-
 7 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 536f431e8844..966e55c7af6e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -728,7 +728,7 @@ void btrfs_global_root_delete(struct btrfs_root *root)
 }
 
 struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
-				     struct btrfs_key *key)
+				     const struct btrfs_key *key)
 {
 	struct rb_node *node;
 	struct btrfs_root *root = NULL;
@@ -765,7 +765,7 @@ static u64 btrfs_global_root_id(struct btrfs_fs_info *fs_info, u64 bytenr)
 
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 {
-	struct btrfs_key key = {
+	const struct btrfs_key key = {
 		.objectid = BTRFS_CSUM_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
 		.offset = btrfs_global_root_id(fs_info, bytenr),
@@ -776,7 +776,7 @@ struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 {
-	struct btrfs_key key = {
+	const struct btrfs_key key = {
 		.objectid = BTRFS_EXTENT_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
 		.offset = btrfs_global_root_id(fs_info, bytenr),
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 163f5114973a..2742e6aac7dd 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -76,7 +76,7 @@ struct btrfs_root *btrfs_get_fs_root_commit_root(struct btrfs_fs_info *fs_info,
 int btrfs_global_root_insert(struct btrfs_root *root);
 void btrfs_global_root_delete(struct btrfs_root *root);
 struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
-				     struct btrfs_key *key);
+				     const struct btrfs_key *key);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 3de3b517810e..f2f4d5b747c5 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -966,13 +966,13 @@ struct btrfs_fs_info {
 #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
 					   struct inode *: (_inode)))->root->fs_info)
 
-static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
+static inline gfp_t btrfs_alloc_write_mask(const struct address_space *mapping)
 {
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
 }
 
 /* Return the minimal folio size of the fs. */
-static inline unsigned int btrfs_min_folio_size(struct btrfs_fs_info *fs_info)
+static inline unsigned int btrfs_min_folio_size(const struct btrfs_fs_info *fs_info)
 {
 	return 1U << (PAGE_SHIFT + fs_info->block_min_order);
 }
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 12c5a9d6564f..40433a86fe49 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -28,7 +28,8 @@
 	name = (1U << __ ## name ## _BIT),              \
 	__ ## name ## _SEQ = __ ## name ## _BIT
 
-static inline phys_addr_t bio_iter_phys(struct bio *bio, struct bvec_iter *iter)
+static inline phys_addr_t bio_iter_phys(const struct bio *bio,
+					const struct bvec_iter *iter)
 {
 	struct bio_vec bv = bio_iter_iovec(bio, *iter);
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b174c68a5ebb..a61947fd5a1a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -412,10 +412,10 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	up_write(&space_info->groups_sem);
 }
 
-struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
+struct btrfs_space_info *btrfs_find_space_info(const struct btrfs_fs_info *info,
 					       u64 flags)
 {
-	struct list_head *head = &info->space_info;
+	const struct list_head *head = &info->space_info;
 	struct btrfs_space_info *found;
 
 	flags &= BTRFS_BLOCK_GROUP_TYPE_MASK;
@@ -427,7 +427,7 @@ struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 	return NULL;
 }
 
-static u64 calc_effective_data_chunk_size(struct btrfs_fs_info *fs_info)
+static u64 calc_effective_data_chunk_size(const struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_space_info *data_sinfo;
 	u64 data_chunk_size;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 174b1ecf63be..24f45072ca4b 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -292,7 +292,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 				struct btrfs_block_group *block_group);
 void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 					u64 chunk_size);
-struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
+struct btrfs_space_info *btrfs_find_space_info(const struct btrfs_fs_info *info,
 					       u64 flags);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index d80a86acfbbe..f85f8a8a7bfe 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -18,7 +18,7 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
 void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info);
 
-static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
+static inline struct btrfs_fs_info *btrfs_sb(const struct super_block *sb)
 {
 	return sb->s_fs_info;
 }
-- 
2.47.2


