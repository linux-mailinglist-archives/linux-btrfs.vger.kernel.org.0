Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E470743920D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhJYJLF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:11:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhJYJLE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:11:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E18CE21639
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635152921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xk4g74V4Xe9orI4F1fCmRDj2jUnTg0YuaqRawEkZhq8=;
        b=RpNhX5zuDELGf+JpqvMOjRTtIZt2ET1Q7aSxVgEl+a1WRMxfBWnmSR2SligLSkMpl2hszl
        z20St/MeO6/iG8HChElHcqw4ILG1aFjc4lpTEgNjBQf3MkiBlHch/KY8eJPaqL7NyrrykZ
        pmBJNXtEkTCfUQNniDyYA2Aqo8D6kUM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A7CE13AAB
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iJR6MRh0dmHDPwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: move the BTRFS_SETGET_* functions to dedicated header
Date:   Mon, 25 Oct 2021 17:08:20 +0800
Message-Id: <20211025090821.65646-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025090821.65646-1-wqu@suse.com>
References: <20211025090821.65646-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS_SETGET_* macros are defining accessors we use to do the endian
convert.

It's not really ideal to put so many similar lines in ctree.h, so move
them to a dedicated header, accessors.h.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/accessors.h | 1004 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h     |  967 +---------------------------------------
 2 files changed, 1005 insertions(+), 966 deletions(-)
 create mode 100644 fs/btrfs/accessors.h

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
new file mode 100644
index 000000000000..8ed390aa4fce
--- /dev/null
+++ b/fs/btrfs/accessors.h
@@ -0,0 +1,1004 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_ACCESSORS_H
+#define BTRFS_ACCESSORS_H
+
+#include "ondisk_format.h"
+/* For extent_buffer */
+#include "extent_io.h"
+
+/*
+ * Various helpers to access the on-disk tree blocks
+ *
+ * We have extent_buffer structure to represent one tree block.
+ * But callers shouldn't just access extent_buffer directly, as we need to
+ * do endian convert and page mapping.
+ *
+ * To access one named structure, like btrfs_root_item, we need to either:
+ *
+ * - Get offset inside an tree block, then use accessors
+ *
+ *   struct btrfs_root_item *ri;
+ *   u64 generation;
+ *
+ *   ri = btrfs_item_ptr(extent_buffer, slot, struct btrfs_root_item);
+ *   generation = btrfs_disk_root_generation(tree_block, ri);
+ *
+ * - Copy the item into a memory, then use accessors on the memory directly
+ *   This is also calle the "STACK" way.
+ *
+ *   u8 buf[sizeof(struct btrfs_root_item)];
+ *   u64 generation;
+ *
+ *   read_extent_buffer(extent_buffer, btrfs_item_ptr_nr(extent_buffer, slot),
+ *			buffer, sizeof(struct btrfs_root_item));
+ *   btrfs_root_generation((struct btrfs_root_item *ri)(buf));
+ */
+
+struct btrfs_map_token {
+	struct extent_buffer *eb;
+	char *kaddr;
+	unsigned long offset;
+};
+
+static inline void btrfs_init_map_token(struct btrfs_map_token *token,
+					struct extent_buffer *eb)
+{
+	token->eb = eb;
+	token->kaddr = page_address(eb->pages[0]);
+	token->offset = 0;
+}
+
+/*
+ * Some macros to generate set/get functions for the struct fields.
+ * This assumes there is a lefoo_to_cpu() for every type, so lets make a simple
+ * one for u8:
+ */
+#define le8_to_cpu(v) (v)
+#define cpu_to_le8(v) (v)
+#define __le8 u8
+
+static inline u8 get_unaligned_le8(const void *p)
+{
+       return *(u8 *)p;
+}
+
+static inline void put_unaligned_le8(u8 val, void *p)
+{
+       *(u8 *)p = val;
+}
+
+#define read_eb_member(eb, ptr, type, member, result) (\
+	read_extent_buffer(eb, (char *)(result),			\
+			   ((unsigned long)(ptr)) +			\
+			    offsetof(type, member),			\
+			   sizeof(((type *)0)->member)))
+
+#define write_eb_member(eb, ptr, type, member, result) (\
+	write_extent_buffer(eb, (char *)(result),			\
+			   ((unsigned long)(ptr)) +			\
+			    offsetof(type, member),			\
+			   sizeof(((type *)0)->member)))
+
+#define DECLARE_BTRFS_SETGET_BITS(bits)					\
+u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
+			       const void *ptr, unsigned long off);	\
+void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
+			    const void *ptr, unsigned long off,		\
+			    u##bits val);				\
+u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
+			 const void *ptr, unsigned long off);		\
+void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
+		      unsigned long off, u##bits val);
+
+DECLARE_BTRFS_SETGET_BITS(8)
+DECLARE_BTRFS_SETGET_BITS(16)
+DECLARE_BTRFS_SETGET_BITS(32)
+DECLARE_BTRFS_SETGET_BITS(64)
+
+#define BTRFS_SETGET_FUNCS(name, type, member, bits)			\
+static inline u##bits btrfs_##name(const struct extent_buffer *eb,	\
+				   const type *s)			\
+{									\
+	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
+	return btrfs_get_##bits(eb, s, offsetof(type, member));		\
+}									\
+static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
+				    u##bits val)			\
+{									\
+	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
+	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
+}									\
+static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
+					 const type *s)			\
+{									\
+	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
+	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
+}									\
+static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
+					  type *s, u##bits val)		\
+{									\
+	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
+	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
+}
+
+#define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
+static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
+{									\
+	const type *p = page_address(eb->pages[0]) +			\
+			offset_in_page(eb->start);			\
+	return get_unaligned_le##bits(&p->member);			\
+}									\
+static inline void btrfs_set_##name(const struct extent_buffer *eb,	\
+				    u##bits val)			\
+{									\
+	type *p = page_address(eb->pages[0]) + offset_in_page(eb->start); \
+	put_unaligned_le##bits(val, &p->member);			\
+}
+
+#define BTRFS_SETGET_STACK_FUNCS(name, type, member, bits)		\
+static inline u##bits btrfs_##name(const type *s)			\
+{									\
+	return get_unaligned_le##bits(&s->member);			\
+}									\
+static inline void btrfs_set_##name(type *s, u##bits val)		\
+{									\
+	put_unaligned_le##bits(val, &s->member);			\
+}
+
+
+BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_FUNCS(device_bytes_used, struct btrfs_dev_item, bytes_used, 64);
+BTRFS_SETGET_FUNCS(device_io_align, struct btrfs_dev_item, io_align, 32);
+BTRFS_SETGET_FUNCS(device_io_width, struct btrfs_dev_item, io_width, 32);
+BTRFS_SETGET_FUNCS(device_start_offset, struct btrfs_dev_item,
+		   start_offset, 64);
+BTRFS_SETGET_FUNCS(device_sector_size, struct btrfs_dev_item, sector_size, 32);
+BTRFS_SETGET_FUNCS(device_id, struct btrfs_dev_item, devid, 64);
+BTRFS_SETGET_FUNCS(device_group, struct btrfs_dev_item, dev_group, 32);
+BTRFS_SETGET_FUNCS(device_seek_speed, struct btrfs_dev_item, seek_speed, 8);
+BTRFS_SETGET_FUNCS(device_bandwidth, struct btrfs_dev_item, bandwidth, 8);
+BTRFS_SETGET_FUNCS(device_generation, struct btrfs_dev_item, generation, 64);
+
+BTRFS_SETGET_STACK_FUNCS(stack_device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_total_bytes, struct btrfs_dev_item,
+			 total_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_bytes_used, struct btrfs_dev_item,
+			 bytes_used, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_io_align, struct btrfs_dev_item,
+			 io_align, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_device_io_width, struct btrfs_dev_item,
+			 io_width, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_device_sector_size, struct btrfs_dev_item,
+			 sector_size, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_device_id, struct btrfs_dev_item, devid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_group, struct btrfs_dev_item,
+			 dev_group, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_device_seek_speed, struct btrfs_dev_item,
+			 seek_speed, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_device_bandwidth, struct btrfs_dev_item,
+			 bandwidth, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_device_generation, struct btrfs_dev_item,
+			 generation, 64);
+
+static inline unsigned long btrfs_device_uuid(struct btrfs_dev_item *d)
+{
+	return (unsigned long)d + offsetof(struct btrfs_dev_item, uuid);
+}
+
+static inline unsigned long btrfs_device_fsid(struct btrfs_dev_item *d)
+{
+	return (unsigned long)d + offsetof(struct btrfs_dev_item, fsid);
+}
+
+BTRFS_SETGET_FUNCS(chunk_length, struct btrfs_chunk, length, 64);
+BTRFS_SETGET_FUNCS(chunk_owner, struct btrfs_chunk, owner, 64);
+BTRFS_SETGET_FUNCS(chunk_stripe_len, struct btrfs_chunk, stripe_len, 64);
+BTRFS_SETGET_FUNCS(chunk_io_align, struct btrfs_chunk, io_align, 32);
+BTRFS_SETGET_FUNCS(chunk_io_width, struct btrfs_chunk, io_width, 32);
+BTRFS_SETGET_FUNCS(chunk_sector_size, struct btrfs_chunk, sector_size, 32);
+BTRFS_SETGET_FUNCS(chunk_type, struct btrfs_chunk, type, 64);
+BTRFS_SETGET_FUNCS(chunk_num_stripes, struct btrfs_chunk, num_stripes, 16);
+BTRFS_SETGET_FUNCS(chunk_sub_stripes, struct btrfs_chunk, sub_stripes, 16);
+BTRFS_SETGET_FUNCS(stripe_devid, struct btrfs_stripe, devid, 64);
+BTRFS_SETGET_FUNCS(stripe_offset, struct btrfs_stripe, offset, 64);
+
+static inline char *btrfs_stripe_dev_uuid(struct btrfs_stripe *s)
+{
+	return (char *)s + offsetof(struct btrfs_stripe, dev_uuid);
+}
+
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_length, struct btrfs_chunk, length, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_owner, struct btrfs_chunk, owner, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_stripe_len, struct btrfs_chunk,
+			 stripe_len, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_io_align, struct btrfs_chunk,
+			 io_align, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_io_width, struct btrfs_chunk,
+			 io_width, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_sector_size, struct btrfs_chunk,
+			 sector_size, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_type, struct btrfs_chunk, type, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_num_stripes, struct btrfs_chunk,
+			 num_stripes, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_sub_stripes, struct btrfs_chunk,
+			 sub_stripes, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_devid, struct btrfs_stripe, devid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_offset, struct btrfs_stripe, offset, 64);
+
+static inline struct btrfs_stripe *btrfs_stripe_nr(struct btrfs_chunk *c,
+						   int nr)
+{
+	unsigned long offset = (unsigned long)c;
+	offset += offsetof(struct btrfs_chunk, stripe);
+	offset += nr * sizeof(struct btrfs_stripe);
+	return (struct btrfs_stripe *)offset;
+}
+
+static inline char *btrfs_stripe_dev_uuid_nr(struct btrfs_chunk *c, int nr)
+{
+	return btrfs_stripe_dev_uuid(btrfs_stripe_nr(c, nr));
+}
+
+static inline u64 btrfs_stripe_offset_nr(const struct extent_buffer *eb,
+					 struct btrfs_chunk *c, int nr)
+{
+	return btrfs_stripe_offset(eb, btrfs_stripe_nr(c, nr));
+}
+
+static inline u64 btrfs_stripe_devid_nr(const struct extent_buffer *eb,
+					 struct btrfs_chunk *c, int nr)
+{
+	return btrfs_stripe_devid(eb, btrfs_stripe_nr(c, nr));
+}
+
+/* struct btrfs_block_group_item */
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_used, struct btrfs_block_group_item,
+			 used, 64);
+BTRFS_SETGET_FUNCS(block_group_used, struct btrfs_block_group_item,
+			 used, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_chunk_objectid,
+			struct btrfs_block_group_item, chunk_objectid, 64);
+
+BTRFS_SETGET_FUNCS(block_group_chunk_objectid,
+		   struct btrfs_block_group_item, chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(block_group_flags,
+		   struct btrfs_block_group_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
+			struct btrfs_block_group_item, flags, 64);
+
+/* struct btrfs_free_space_info */
+BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
+		   extent_count, 32);
+BTRFS_SETGET_FUNCS(free_space_flags, struct btrfs_free_space_info, flags, 32);
+
+/* struct btrfs_inode_ref */
+BTRFS_SETGET_FUNCS(inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
+BTRFS_SETGET_FUNCS(inode_ref_index, struct btrfs_inode_ref, index, 64);
+
+/* struct btrfs_inode_extref */
+BTRFS_SETGET_FUNCS(inode_extref_parent, struct btrfs_inode_extref,
+		   parent_objectid, 64);
+BTRFS_SETGET_FUNCS(inode_extref_name_len, struct btrfs_inode_extref,
+		   name_len, 16);
+BTRFS_SETGET_FUNCS(inode_extref_index, struct btrfs_inode_extref, index, 64);
+
+/* struct btrfs_inode_item */
+BTRFS_SETGET_FUNCS(inode_generation, struct btrfs_inode_item, generation, 64);
+BTRFS_SETGET_FUNCS(inode_sequence, struct btrfs_inode_item, sequence, 64);
+BTRFS_SETGET_FUNCS(inode_transid, struct btrfs_inode_item, transid, 64);
+BTRFS_SETGET_FUNCS(inode_size, struct btrfs_inode_item, size, 64);
+BTRFS_SETGET_FUNCS(inode_nbytes, struct btrfs_inode_item, nbytes, 64);
+BTRFS_SETGET_FUNCS(inode_block_group, struct btrfs_inode_item, block_group, 64);
+BTRFS_SETGET_FUNCS(inode_nlink, struct btrfs_inode_item, nlink, 32);
+BTRFS_SETGET_FUNCS(inode_uid, struct btrfs_inode_item, uid, 32);
+BTRFS_SETGET_FUNCS(inode_gid, struct btrfs_inode_item, gid, 32);
+BTRFS_SETGET_FUNCS(inode_mode, struct btrfs_inode_item, mode, 32);
+BTRFS_SETGET_FUNCS(inode_rdev, struct btrfs_inode_item, rdev, 64);
+BTRFS_SETGET_FUNCS(inode_flags, struct btrfs_inode_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_generation, struct btrfs_inode_item,
+			 generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_sequence, struct btrfs_inode_item,
+			 sequence, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_transid, struct btrfs_inode_item,
+			 transid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_size, struct btrfs_inode_item, size, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_nbytes, struct btrfs_inode_item,
+			 nbytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_block_group, struct btrfs_inode_item,
+			 block_group, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_nlink, struct btrfs_inode_item, nlink, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_uid, struct btrfs_inode_item, uid, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_gid, struct btrfs_inode_item, gid, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_mode, struct btrfs_inode_item, mode, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_rdev, struct btrfs_inode_item, rdev, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_flags, struct btrfs_inode_item, flags, 64);
+BTRFS_SETGET_FUNCS(timespec_sec, struct btrfs_timespec, sec, 64);
+BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
+
+/* struct btrfs_dev_extent */
+BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent,
+		   chunk_tree, 64);
+BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
+		   chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(dev_extent_chunk_offset, struct btrfs_dev_extent,
+		   chunk_offset, 64);
+BTRFS_SETGET_FUNCS(dev_extent_length, struct btrfs_dev_extent, length, 64);
+BTRFS_SETGET_FUNCS(extent_refs, struct btrfs_extent_item, refs, 64);
+BTRFS_SETGET_FUNCS(extent_generation, struct btrfs_extent_item,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(extent_flags, struct btrfs_extent_item, flags, 64);
+
+BTRFS_SETGET_FUNCS(tree_block_level, struct btrfs_tree_block_info, level, 8);
+
+static inline void btrfs_tree_block_key(const struct extent_buffer *eb,
+					struct btrfs_tree_block_info *item,
+					struct btrfs_disk_key *key)
+{
+	read_eb_member(eb, item, struct btrfs_tree_block_info, key, key);
+}
+
+static inline void btrfs_set_tree_block_key(const struct extent_buffer *eb,
+					    struct btrfs_tree_block_info *item,
+					    struct btrfs_disk_key *key)
+{
+	write_eb_member(eb, item, struct btrfs_tree_block_info, key, key);
+}
+
+BTRFS_SETGET_FUNCS(extent_data_ref_root, struct btrfs_extent_data_ref,
+		   root, 64);
+BTRFS_SETGET_FUNCS(extent_data_ref_objectid, struct btrfs_extent_data_ref,
+		   objectid, 64);
+BTRFS_SETGET_FUNCS(extent_data_ref_offset, struct btrfs_extent_data_ref,
+		   offset, 64);
+BTRFS_SETGET_FUNCS(extent_data_ref_count, struct btrfs_extent_data_ref,
+		   count, 32);
+
+BTRFS_SETGET_FUNCS(shared_data_ref_count, struct btrfs_shared_data_ref,
+		   count, 32);
+
+BTRFS_SETGET_FUNCS(extent_inline_ref_type, struct btrfs_extent_inline_ref,
+		   type, 8);
+BTRFS_SETGET_FUNCS(extent_inline_ref_offset, struct btrfs_extent_inline_ref,
+		   offset, 64);
+
+static inline u32 btrfs_extent_inline_ref_size(int type)
+{
+	if (type == BTRFS_TREE_BLOCK_REF_KEY ||
+	    type == BTRFS_SHARED_BLOCK_REF_KEY)
+		return sizeof(struct btrfs_extent_inline_ref);
+	if (type == BTRFS_SHARED_DATA_REF_KEY)
+		return sizeof(struct btrfs_shared_data_ref) +
+		       sizeof(struct btrfs_extent_inline_ref);
+	if (type == BTRFS_EXTENT_DATA_REF_KEY)
+		return sizeof(struct btrfs_extent_data_ref) +
+		       offsetof(struct btrfs_extent_inline_ref, offset);
+	return 0;
+}
+
+/* struct btrfs_node */
+BTRFS_SETGET_FUNCS(key_blockptr, struct btrfs_key_ptr, blockptr, 64);
+BTRFS_SETGET_FUNCS(key_generation, struct btrfs_key_ptr, generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_key_blockptr, struct btrfs_key_ptr,
+			 blockptr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_key_generation, struct btrfs_key_ptr,
+			 generation, 64);
+
+static inline u64 btrfs_node_blockptr(const struct extent_buffer *eb, int nr)
+{
+	unsigned long ptr;
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	return btrfs_key_blockptr(eb, (struct btrfs_key_ptr *)ptr);
+}
+
+static inline void btrfs_set_node_blockptr(const struct extent_buffer *eb,
+					   int nr, u64 val)
+{
+	unsigned long ptr;
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	btrfs_set_key_blockptr(eb, (struct btrfs_key_ptr *)ptr, val);
+}
+
+static inline u64 btrfs_node_ptr_generation(const struct extent_buffer *eb, int nr)
+{
+	unsigned long ptr;
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	return btrfs_key_generation(eb, (struct btrfs_key_ptr *)ptr);
+}
+
+static inline void btrfs_set_node_ptr_generation(const struct extent_buffer *eb,
+						 int nr, u64 val)
+{
+	unsigned long ptr;
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	btrfs_set_key_generation(eb, (struct btrfs_key_ptr *)ptr, val);
+}
+
+static inline unsigned long btrfs_node_key_ptr_offset(int nr)
+{
+	return offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+}
+
+void btrfs_node_key(const struct extent_buffer *eb,
+		    struct btrfs_disk_key *disk_key, int nr);
+
+static inline void btrfs_set_node_key(const struct extent_buffer *eb,
+				      struct btrfs_disk_key *disk_key, int nr)
+{
+	unsigned long ptr;
+	ptr = btrfs_node_key_ptr_offset(nr);
+	write_eb_member(eb, (struct btrfs_key_ptr *)ptr,
+		       struct btrfs_key_ptr, key, disk_key);
+}
+
+/* struct btrfs_item */
+BTRFS_SETGET_FUNCS(item_offset, struct btrfs_item, offset, 32);
+BTRFS_SETGET_FUNCS(item_size, struct btrfs_item, size, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_item_offset, struct btrfs_item, offset, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_item_size, struct btrfs_item, size, 32);
+
+static inline unsigned long btrfs_item_nr_offset(int nr)
+{
+	return offsetof(struct btrfs_leaf, items) +
+		sizeof(struct btrfs_item) * nr;
+}
+
+static inline struct btrfs_item *btrfs_item_nr(int nr)
+{
+	return (struct btrfs_item *)btrfs_item_nr_offset(nr);
+}
+
+static inline u32 btrfs_item_end(const struct extent_buffer *eb,
+				 struct btrfs_item *item)
+{
+	return btrfs_item_offset(eb, item) + btrfs_item_size(eb, item);
+}
+
+static inline u32 btrfs_item_end_nr(const struct extent_buffer *eb, int nr)
+{
+	return btrfs_item_end(eb, btrfs_item_nr(nr));
+}
+
+static inline u32 btrfs_item_offset_nr(const struct extent_buffer *eb, int nr)
+{
+	return btrfs_item_offset(eb, btrfs_item_nr(nr));
+}
+
+static inline u32 btrfs_item_size_nr(const struct extent_buffer *eb, int nr)
+{
+	return btrfs_item_size(eb, btrfs_item_nr(nr));
+}
+
+static inline void btrfs_item_key(const struct extent_buffer *eb,
+			   struct btrfs_disk_key *disk_key, int nr)
+{
+	struct btrfs_item *item = btrfs_item_nr(nr);
+	read_eb_member(eb, item, struct btrfs_item, key, disk_key);
+}
+
+static inline void btrfs_set_item_key(struct extent_buffer *eb,
+			       struct btrfs_disk_key *disk_key, int nr)
+{
+	struct btrfs_item *item = btrfs_item_nr(nr);
+	write_eb_member(eb, item, struct btrfs_item, key, disk_key);
+}
+
+BTRFS_SETGET_FUNCS(dir_log_end, struct btrfs_dir_log_item, end, 64);
+
+/*
+ * struct btrfs_root_ref
+ */
+BTRFS_SETGET_FUNCS(root_ref_dirid, struct btrfs_root_ref, dirid, 64);
+BTRFS_SETGET_FUNCS(root_ref_sequence, struct btrfs_root_ref, sequence, 64);
+BTRFS_SETGET_FUNCS(root_ref_name_len, struct btrfs_root_ref, name_len, 16);
+
+/* struct btrfs_dir_item */
+BTRFS_SETGET_FUNCS(dir_data_len, struct btrfs_dir_item, data_len, 16);
+BTRFS_SETGET_FUNCS(dir_type, struct btrfs_dir_item, type, 8);
+BTRFS_SETGET_FUNCS(dir_name_len, struct btrfs_dir_item, name_len, 16);
+BTRFS_SETGET_FUNCS(dir_transid, struct btrfs_dir_item, transid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_type, struct btrfs_dir_item, type, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_data_len, struct btrfs_dir_item,
+			 data_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_name_len, struct btrfs_dir_item,
+			 name_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_transid, struct btrfs_dir_item,
+			 transid, 64);
+
+static inline void btrfs_dir_item_key(const struct extent_buffer *eb,
+				      const struct btrfs_dir_item *item,
+				      struct btrfs_disk_key *key)
+{
+	read_eb_member(eb, item, struct btrfs_dir_item, location, key);
+}
+
+static inline void btrfs_set_dir_item_key(struct extent_buffer *eb,
+					  struct btrfs_dir_item *item,
+					  const struct btrfs_disk_key *key)
+{
+	write_eb_member(eb, item, struct btrfs_dir_item, location, key);
+}
+
+BTRFS_SETGET_FUNCS(free_space_entries, struct btrfs_free_space_header,
+		   num_entries, 64);
+BTRFS_SETGET_FUNCS(free_space_bitmaps, struct btrfs_free_space_header,
+		   num_bitmaps, 64);
+BTRFS_SETGET_FUNCS(free_space_generation, struct btrfs_free_space_header,
+		   generation, 64);
+
+static inline void btrfs_free_space_key(const struct extent_buffer *eb,
+					const struct btrfs_free_space_header *h,
+					struct btrfs_disk_key *key)
+{
+	read_eb_member(eb, h, struct btrfs_free_space_header, location, key);
+}
+
+static inline void btrfs_set_free_space_key(struct extent_buffer *eb,
+					    struct btrfs_free_space_header *h,
+					    const struct btrfs_disk_key *key)
+{
+	write_eb_member(eb, h, struct btrfs_free_space_header, location, key);
+}
+
+/* struct btrfs_disk_key */
+BTRFS_SETGET_STACK_FUNCS(disk_key_objectid, struct btrfs_disk_key,
+			 objectid, 64);
+BTRFS_SETGET_STACK_FUNCS(disk_key_offset, struct btrfs_disk_key, offset, 64);
+BTRFS_SETGET_STACK_FUNCS(disk_key_type, struct btrfs_disk_key, type, 8);
+
+#ifdef __LITTLE_ENDIAN
+
+/*
+ * Optimized helpers for little-endian architectures where CPU and on-disk
+ * structures have the same endianness and we can skip conversions.
+ */
+
+static inline void btrfs_disk_key_to_cpu(struct btrfs_key *cpu_key,
+					 const struct btrfs_disk_key *disk_key)
+{
+	memcpy(cpu_key, disk_key, sizeof(struct btrfs_key));
+}
+
+static inline void btrfs_cpu_key_to_disk(struct btrfs_disk_key *disk_key,
+					 const struct btrfs_key *cpu_key)
+{
+	memcpy(disk_key, cpu_key, sizeof(struct btrfs_key));
+}
+
+static inline void btrfs_node_key_to_cpu(const struct extent_buffer *eb,
+					 struct btrfs_key *cpu_key, int nr)
+{
+	struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)cpu_key;
+
+	btrfs_node_key(eb, disk_key, nr);
+}
+
+static inline void btrfs_item_key_to_cpu(const struct extent_buffer *eb,
+					 struct btrfs_key *cpu_key, int nr)
+{
+	struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)cpu_key;
+
+	btrfs_item_key(eb, disk_key, nr);
+}
+
+static inline void btrfs_dir_item_key_to_cpu(const struct extent_buffer *eb,
+					     const struct btrfs_dir_item *item,
+					     struct btrfs_key *cpu_key)
+{
+	struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)cpu_key;
+
+	btrfs_dir_item_key(eb, item, disk_key);
+}
+
+#else
+
+static inline void btrfs_disk_key_to_cpu(struct btrfs_key *cpu,
+					 const struct btrfs_disk_key *disk)
+{
+	cpu->offset = le64_to_cpu(disk->offset);
+	cpu->type = disk->type;
+	cpu->objectid = le64_to_cpu(disk->objectid);
+}
+
+static inline void btrfs_cpu_key_to_disk(struct btrfs_disk_key *disk,
+					 const struct btrfs_key *cpu)
+{
+	disk->offset = cpu_to_le64(cpu->offset);
+	disk->type = cpu->type;
+	disk->objectid = cpu_to_le64(cpu->objectid);
+}
+
+static inline void btrfs_node_key_to_cpu(const struct extent_buffer *eb,
+					 struct btrfs_key *key, int nr)
+{
+	struct btrfs_disk_key disk_key;
+	btrfs_node_key(eb, &disk_key, nr);
+	btrfs_disk_key_to_cpu(key, &disk_key);
+}
+
+static inline void btrfs_item_key_to_cpu(const struct extent_buffer *eb,
+					 struct btrfs_key *key, int nr)
+{
+	struct btrfs_disk_key disk_key;
+	btrfs_item_key(eb, &disk_key, nr);
+	btrfs_disk_key_to_cpu(key, &disk_key);
+}
+
+static inline void btrfs_dir_item_key_to_cpu(const struct extent_buffer *eb,
+					     const struct btrfs_dir_item *item,
+					     struct btrfs_key *key)
+{
+	struct btrfs_disk_key disk_key;
+	btrfs_dir_item_key(eb, item, &disk_key);
+	btrfs_disk_key_to_cpu(key, &disk_key);
+}
+
+#endif
+
+/* struct btrfs_header */
+BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,
+			  generation, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
+BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
+			 generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header,
+			 nritems, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_header_bytenr, struct btrfs_header, bytenr, 64);
+
+static inline int btrfs_header_flag(const struct extent_buffer *eb, u64 flag)
+{
+	return (btrfs_header_flags(eb) & flag) == flag;
+}
+
+static inline void btrfs_set_header_flag(struct extent_buffer *eb, u64 flag)
+{
+	u64 flags = btrfs_header_flags(eb);
+	btrfs_set_header_flags(eb, flags | flag);
+}
+
+static inline void btrfs_clear_header_flag(struct extent_buffer *eb, u64 flag)
+{
+	u64 flags = btrfs_header_flags(eb);
+	btrfs_set_header_flags(eb, flags & ~flag);
+}
+
+static inline int btrfs_header_backref_rev(const struct extent_buffer *eb)
+{
+	u64 flags = btrfs_header_flags(eb);
+	return flags >> BTRFS_BACKREF_REV_SHIFT;
+}
+
+static inline void btrfs_set_header_backref_rev(struct extent_buffer *eb,
+						int rev)
+{
+	u64 flags = btrfs_header_flags(eb);
+	flags &= ~BTRFS_BACKREF_REV_MASK;
+	flags |= (u64)rev << BTRFS_BACKREF_REV_SHIFT;
+	btrfs_set_header_flags(eb, flags);
+}
+
+static inline int btrfs_is_leaf(const struct extent_buffer *eb)
+{
+	return btrfs_header_level(eb) == 0;
+}
+
+/* struct btrfs_root_item */
+BTRFS_SETGET_FUNCS(disk_root_generation, struct btrfs_root_item,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(disk_root_refs, struct btrfs_root_item, refs, 32);
+BTRFS_SETGET_FUNCS(disk_root_bytenr, struct btrfs_root_item, bytenr, 64);
+BTRFS_SETGET_FUNCS(disk_root_level, struct btrfs_root_item, level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(root_generation, struct btrfs_root_item,
+			 generation, 64);
+BTRFS_SETGET_STACK_FUNCS(root_bytenr, struct btrfs_root_item, bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(root_drop_level, struct btrfs_root_item, drop_level, 8);
+BTRFS_SETGET_STACK_FUNCS(root_level, struct btrfs_root_item, level, 8);
+BTRFS_SETGET_STACK_FUNCS(root_dirid, struct btrfs_root_item, root_dirid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_refs, struct btrfs_root_item, refs, 32);
+BTRFS_SETGET_STACK_FUNCS(root_flags, struct btrfs_root_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(root_used, struct btrfs_root_item, bytes_used, 64);
+BTRFS_SETGET_STACK_FUNCS(root_limit, struct btrfs_root_item, byte_limit, 64);
+BTRFS_SETGET_STACK_FUNCS(root_last_snapshot, struct btrfs_root_item,
+			 last_snapshot, 64);
+BTRFS_SETGET_STACK_FUNCS(root_generation_v2, struct btrfs_root_item,
+			 generation_v2, 64);
+BTRFS_SETGET_STACK_FUNCS(root_ctransid, struct btrfs_root_item,
+			 ctransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_otransid, struct btrfs_root_item,
+			 otransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_stransid, struct btrfs_root_item,
+			 stransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_rtransid, struct btrfs_root_item,
+			 rtransid, 64);
+
+/* struct btrfs_root_backup */
+BTRFS_SETGET_STACK_FUNCS(backup_tree_root, struct btrfs_root_backup,
+		   tree_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_tree_root_gen, struct btrfs_root_backup,
+		   tree_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_tree_root_level, struct btrfs_root_backup,
+		   tree_root_level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(backup_chunk_root, struct btrfs_root_backup,
+		   chunk_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_chunk_root_gen, struct btrfs_root_backup,
+		   chunk_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_chunk_root_level, struct btrfs_root_backup,
+		   chunk_root_level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(backup_extent_root, struct btrfs_root_backup,
+		   extent_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_extent_root_gen, struct btrfs_root_backup,
+		   extent_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_extent_root_level, struct btrfs_root_backup,
+		   extent_root_level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(backup_fs_root, struct btrfs_root_backup,
+		   fs_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_fs_root_gen, struct btrfs_root_backup,
+		   fs_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_fs_root_level, struct btrfs_root_backup,
+		   fs_root_level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(backup_dev_root, struct btrfs_root_backup,
+		   dev_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_dev_root_gen, struct btrfs_root_backup,
+		   dev_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_dev_root_level, struct btrfs_root_backup,
+		   dev_root_level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(backup_csum_root, struct btrfs_root_backup,
+		   csum_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_csum_root_gen, struct btrfs_root_backup,
+		   csum_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_csum_root_level, struct btrfs_root_backup,
+		   csum_root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(backup_total_bytes, struct btrfs_root_backup,
+		   total_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
+		   bytes_used, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_num_devices, struct btrfs_root_backup,
+		   num_devices, 64);
+
+/* struct btrfs_balance_item */
+BTRFS_SETGET_FUNCS(balance_flags, struct btrfs_balance_item, flags, 64);
+
+static inline void btrfs_balance_data(const struct extent_buffer *eb,
+				      const struct btrfs_balance_item *bi,
+				      struct btrfs_disk_balance_args *ba)
+{
+	read_eb_member(eb, bi, struct btrfs_balance_item, data, ba);
+}
+
+static inline void btrfs_set_balance_data(struct extent_buffer *eb,
+				  struct btrfs_balance_item *bi,
+				  const struct btrfs_disk_balance_args *ba)
+{
+	write_eb_member(eb, bi, struct btrfs_balance_item, data, ba);
+}
+
+static inline void btrfs_balance_meta(const struct extent_buffer *eb,
+				      const struct btrfs_balance_item *bi,
+				      struct btrfs_disk_balance_args *ba)
+{
+	read_eb_member(eb, bi, struct btrfs_balance_item, meta, ba);
+}
+
+static inline void btrfs_set_balance_meta(struct extent_buffer *eb,
+				  struct btrfs_balance_item *bi,
+				  const struct btrfs_disk_balance_args *ba)
+{
+	write_eb_member(eb, bi, struct btrfs_balance_item, meta, ba);
+}
+
+static inline void btrfs_balance_sys(const struct extent_buffer *eb,
+				     const struct btrfs_balance_item *bi,
+				     struct btrfs_disk_balance_args *ba)
+{
+	read_eb_member(eb, bi, struct btrfs_balance_item, sys, ba);
+}
+
+static inline void btrfs_set_balance_sys(struct extent_buffer *eb,
+				 struct btrfs_balance_item *bi,
+				 const struct btrfs_disk_balance_args *ba)
+{
+	write_eb_member(eb, bi, struct btrfs_balance_item, sys, ba);
+}
+
+/* struct btrfs_super_block */
+BTRFS_SETGET_STACK_FUNCS(super_bytenr, struct btrfs_super_block, bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(super_flags, struct btrfs_super_block, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(super_generation, struct btrfs_super_block,
+			 generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_root, struct btrfs_super_block, root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_sys_array_size,
+			 struct btrfs_super_block, sys_chunk_array_size, 32);
+BTRFS_SETGET_STACK_FUNCS(super_chunk_root_generation,
+			 struct btrfs_super_block, chunk_root_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_root_level, struct btrfs_super_block,
+			 root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(super_chunk_root, struct btrfs_super_block,
+			 chunk_root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_chunk_root_level, struct btrfs_super_block,
+			 chunk_root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(super_log_root, struct btrfs_super_block,
+			 log_root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_log_root_transid, struct btrfs_super_block,
+			 log_root_transid, 64);
+BTRFS_SETGET_STACK_FUNCS(super_log_root_level, struct btrfs_super_block,
+			 log_root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(super_total_bytes, struct btrfs_super_block,
+			 total_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(super_bytes_used, struct btrfs_super_block,
+			 bytes_used, 64);
+BTRFS_SETGET_STACK_FUNCS(super_sectorsize, struct btrfs_super_block,
+			 sectorsize, 32);
+BTRFS_SETGET_STACK_FUNCS(super_nodesize, struct btrfs_super_block,
+			 nodesize, 32);
+BTRFS_SETGET_STACK_FUNCS(super_stripesize, struct btrfs_super_block,
+			 stripesize, 32);
+BTRFS_SETGET_STACK_FUNCS(super_root_dir, struct btrfs_super_block,
+			 root_dir_objectid, 64);
+BTRFS_SETGET_STACK_FUNCS(super_num_devices, struct btrfs_super_block,
+			 num_devices, 64);
+BTRFS_SETGET_STACK_FUNCS(super_compat_flags, struct btrfs_super_block,
+			 compat_flags, 64);
+BTRFS_SETGET_STACK_FUNCS(super_compat_ro_flags, struct btrfs_super_block,
+			 compat_ro_flags, 64);
+BTRFS_SETGET_STACK_FUNCS(super_incompat_flags, struct btrfs_super_block,
+			 incompat_flags, 64);
+BTRFS_SETGET_STACK_FUNCS(super_csum_type, struct btrfs_super_block,
+			 csum_type, 16);
+BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
+			 cache_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
+BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
+			 uuid_tree_generation, 64);
+
+/* struct btrfs_file_extent_item */
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
+			 type, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_bytenr,
+			 struct btrfs_file_extent_item, disk_bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_offset,
+			 struct btrfs_file_extent_item, offset, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_generation,
+			 struct btrfs_file_extent_item, generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_num_bytes,
+			 struct btrfs_file_extent_item, num_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_ram_bytes,
+			 struct btrfs_file_extent_item, ram_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_num_bytes,
+			 struct btrfs_file_extent_item, disk_num_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression,
+			 struct btrfs_file_extent_item, compression, 8);
+
+BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
+BTRFS_SETGET_FUNCS(file_extent_disk_bytenr, struct btrfs_file_extent_item,
+		   disk_bytenr, 64);
+BTRFS_SETGET_FUNCS(file_extent_generation, struct btrfs_file_extent_item,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(file_extent_disk_num_bytes, struct btrfs_file_extent_item,
+		   disk_num_bytes, 64);
+BTRFS_SETGET_FUNCS(file_extent_offset, struct btrfs_file_extent_item,
+		  offset, 64);
+BTRFS_SETGET_FUNCS(file_extent_num_bytes, struct btrfs_file_extent_item,
+		   num_bytes, 64);
+BTRFS_SETGET_FUNCS(file_extent_ram_bytes, struct btrfs_file_extent_item,
+		   ram_bytes, 64);
+BTRFS_SETGET_FUNCS(file_extent_compression, struct btrfs_file_extent_item,
+		   compression, 8);
+BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
+		   encryption, 8);
+BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
+		   other_encoding, 16);
+
+/* btrfs_qgroup_status_item */
+BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(qgroup_status_version, struct btrfs_qgroup_status_item,
+		   version, 64);
+BTRFS_SETGET_FUNCS(qgroup_status_flags, struct btrfs_qgroup_status_item,
+		   flags, 64);
+BTRFS_SETGET_FUNCS(qgroup_status_rescan, struct btrfs_qgroup_status_item,
+		   rescan, 64);
+
+/* btrfs_qgroup_info_item */
+BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_rfer, struct btrfs_qgroup_info_item, rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_rfer_cmpr, struct btrfs_qgroup_info_item,
+		   rfer_cmpr, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_excl, struct btrfs_qgroup_info_item, excl, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_excl_cmpr, struct btrfs_qgroup_info_item,
+		   excl_cmpr, 64);
+
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_generation,
+			 struct btrfs_qgroup_info_item, generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_rfer, struct btrfs_qgroup_info_item,
+			 rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_rfer_cmpr,
+			 struct btrfs_qgroup_info_item, rfer_cmpr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_excl, struct btrfs_qgroup_info_item,
+			 excl, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_excl_cmpr,
+			 struct btrfs_qgroup_info_item, excl_cmpr, 64);
+
+/* btrfs_qgroup_limit_item */
+BTRFS_SETGET_FUNCS(qgroup_limit_flags, struct btrfs_qgroup_limit_item,
+		   flags, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_max_rfer, struct btrfs_qgroup_limit_item,
+		   max_rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_max_excl, struct btrfs_qgroup_limit_item,
+		   max_excl, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_rsv_rfer, struct btrfs_qgroup_limit_item,
+		   rsv_rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_rsv_excl, struct btrfs_qgroup_limit_item,
+		   rsv_excl, 64);
+
+/* btrfs_dev_replace_item */
+BTRFS_SETGET_FUNCS(dev_replace_src_devid,
+		   struct btrfs_dev_replace_item, src_devid, 64);
+BTRFS_SETGET_FUNCS(dev_replace_cont_reading_from_srcdev_mode,
+		   struct btrfs_dev_replace_item, cont_reading_from_srcdev_mode,
+		   64);
+BTRFS_SETGET_FUNCS(dev_replace_replace_state, struct btrfs_dev_replace_item,
+		   replace_state, 64);
+BTRFS_SETGET_FUNCS(dev_replace_time_started, struct btrfs_dev_replace_item,
+		   time_started, 64);
+BTRFS_SETGET_FUNCS(dev_replace_time_stopped, struct btrfs_dev_replace_item,
+		   time_stopped, 64);
+BTRFS_SETGET_FUNCS(dev_replace_num_write_errors, struct btrfs_dev_replace_item,
+		   num_write_errors, 64);
+BTRFS_SETGET_FUNCS(dev_replace_num_uncorrectable_read_errors,
+		   struct btrfs_dev_replace_item, num_uncorrectable_read_errors,
+		   64);
+BTRFS_SETGET_FUNCS(dev_replace_cursor_left, struct btrfs_dev_replace_item,
+		   cursor_left, 64);
+BTRFS_SETGET_FUNCS(dev_replace_cursor_right, struct btrfs_dev_replace_item,
+		   cursor_right, 64);
+
+BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_src_devid,
+			 struct btrfs_dev_replace_item, src_devid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cont_reading_from_srcdev_mode,
+			 struct btrfs_dev_replace_item,
+			 cont_reading_from_srcdev_mode, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_replace_state,
+			 struct btrfs_dev_replace_item, replace_state, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_time_started,
+			 struct btrfs_dev_replace_item, time_started, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_time_stopped,
+			 struct btrfs_dev_replace_item, time_stopped, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_num_write_errors,
+			 struct btrfs_dev_replace_item, num_write_errors, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_num_uncorrectable_read_errors,
+			 struct btrfs_dev_replace_item,
+			 num_uncorrectable_read_errors, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_left,
+			 struct btrfs_dev_replace_item, cursor_left, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_right,
+			 struct btrfs_dev_replace_item, cursor_right, 64);
+
+/* helper function to cast into the data area of the leaf. */
+#define btrfs_item_ptr(leaf, slot, type) \
+	((type *)(BTRFS_LEAF_DATA_OFFSET + \
+	btrfs_item_offset_nr(leaf, slot)))
+
+#define btrfs_item_ptr_offset(leaf, slot) \
+	((unsigned long)(BTRFS_LEAF_DATA_OFFSET + \
+	btrfs_item_offset_nr(leaf, slot)))
+
+#endif
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6d32ad7d9a8d..c3ec2eadfe20 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -28,6 +28,7 @@
 #include <linux/crc32c.h>
 #include <linux/iomap.h>
 #include "ondisk_format.h"
+#include "accessors.h"
 #include "extent-io-tree.h"
 #include "extent_io.h"
 #include "extent_map.h"
@@ -1328,119 +1329,9 @@ do {                                                                   \
 
 #define BTRFS_INODE_RO_FLAG_MASK	(BTRFS_INODE_RO_VERITY)
 
-struct btrfs_map_token {
-	struct extent_buffer *eb;
-	char *kaddr;
-	unsigned long offset;
-};
-
 #define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
 				((bytes) >> (fs_info)->sectorsize_bits)
 
-static inline void btrfs_init_map_token(struct btrfs_map_token *token,
-					struct extent_buffer *eb)
-{
-	token->eb = eb;
-	token->kaddr = page_address(eb->pages[0]);
-	token->offset = 0;
-}
-
-/* some macros to generate set/get functions for the struct fields.  This
- * assumes there is a lefoo_to_cpu for every type, so lets make a simple
- * one for u8:
- */
-#define le8_to_cpu(v) (v)
-#define cpu_to_le8(v) (v)
-#define __le8 u8
-
-static inline u8 get_unaligned_le8(const void *p)
-{
-       return *(u8 *)p;
-}
-
-static inline void put_unaligned_le8(u8 val, void *p)
-{
-       *(u8 *)p = val;
-}
-
-#define read_eb_member(eb, ptr, type, member, result) (\
-	read_extent_buffer(eb, (char *)(result),			\
-			   ((unsigned long)(ptr)) +			\
-			    offsetof(type, member),			\
-			   sizeof(((type *)0)->member)))
-
-#define write_eb_member(eb, ptr, type, member, result) (\
-	write_extent_buffer(eb, (char *)(result),			\
-			   ((unsigned long)(ptr)) +			\
-			    offsetof(type, member),			\
-			   sizeof(((type *)0)->member)))
-
-#define DECLARE_BTRFS_SETGET_BITS(bits)					\
-u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
-			       const void *ptr, unsigned long off);	\
-void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
-			    const void *ptr, unsigned long off,		\
-			    u##bits val);				\
-u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
-			 const void *ptr, unsigned long off);		\
-void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
-		      unsigned long off, u##bits val);
-
-DECLARE_BTRFS_SETGET_BITS(8)
-DECLARE_BTRFS_SETGET_BITS(16)
-DECLARE_BTRFS_SETGET_BITS(32)
-DECLARE_BTRFS_SETGET_BITS(64)
-
-#define BTRFS_SETGET_FUNCS(name, type, member, bits)			\
-static inline u##bits btrfs_##name(const struct extent_buffer *eb,	\
-				   const type *s)			\
-{									\
-	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
-	return btrfs_get_##bits(eb, s, offsetof(type, member));		\
-}									\
-static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
-				    u##bits val)			\
-{									\
-	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
-	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
-}									\
-static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
-					 const type *s)			\
-{									\
-	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
-	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
-}									\
-static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
-					  type *s, u##bits val)		\
-{									\
-	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
-	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
-}
-
-#define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
-static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
-{									\
-	const type *p = page_address(eb->pages[0]) +			\
-			offset_in_page(eb->start);			\
-	return get_unaligned_le##bits(&p->member);			\
-}									\
-static inline void btrfs_set_##name(const struct extent_buffer *eb,	\
-				    u##bits val)			\
-{									\
-	type *p = page_address(eb->pages[0]) + offset_in_page(eb->start); \
-	put_unaligned_le##bits(val, &p->member);			\
-}
-
-#define BTRFS_SETGET_STACK_FUNCS(name, type, member, bits)		\
-static inline u##bits btrfs_##name(const type *s)			\
-{									\
-	return get_unaligned_le##bits(&s->member);			\
-}									\
-static inline void btrfs_set_##name(type *s, u##bits val)		\
-{									\
-	put_unaligned_le##bits(val, &s->member);			\
-}
-
 static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
 					   struct btrfs_dev_item *s)
 {
@@ -1459,584 +1350,6 @@ static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 	btrfs_set_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes), val);
 }
 
-
-BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
-BTRFS_SETGET_FUNCS(device_bytes_used, struct btrfs_dev_item, bytes_used, 64);
-BTRFS_SETGET_FUNCS(device_io_align, struct btrfs_dev_item, io_align, 32);
-BTRFS_SETGET_FUNCS(device_io_width, struct btrfs_dev_item, io_width, 32);
-BTRFS_SETGET_FUNCS(device_start_offset, struct btrfs_dev_item,
-		   start_offset, 64);
-BTRFS_SETGET_FUNCS(device_sector_size, struct btrfs_dev_item, sector_size, 32);
-BTRFS_SETGET_FUNCS(device_id, struct btrfs_dev_item, devid, 64);
-BTRFS_SETGET_FUNCS(device_group, struct btrfs_dev_item, dev_group, 32);
-BTRFS_SETGET_FUNCS(device_seek_speed, struct btrfs_dev_item, seek_speed, 8);
-BTRFS_SETGET_FUNCS(device_bandwidth, struct btrfs_dev_item, bandwidth, 8);
-BTRFS_SETGET_FUNCS(device_generation, struct btrfs_dev_item, generation, 64);
-
-BTRFS_SETGET_STACK_FUNCS(stack_device_type, struct btrfs_dev_item, type, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_device_total_bytes, struct btrfs_dev_item,
-			 total_bytes, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_device_bytes_used, struct btrfs_dev_item,
-			 bytes_used, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_device_io_align, struct btrfs_dev_item,
-			 io_align, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_device_io_width, struct btrfs_dev_item,
-			 io_width, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_device_sector_size, struct btrfs_dev_item,
-			 sector_size, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_device_id, struct btrfs_dev_item, devid, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_device_group, struct btrfs_dev_item,
-			 dev_group, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_device_seek_speed, struct btrfs_dev_item,
-			 seek_speed, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_device_bandwidth, struct btrfs_dev_item,
-			 bandwidth, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_device_generation, struct btrfs_dev_item,
-			 generation, 64);
-
-static inline unsigned long btrfs_device_uuid(struct btrfs_dev_item *d)
-{
-	return (unsigned long)d + offsetof(struct btrfs_dev_item, uuid);
-}
-
-static inline unsigned long btrfs_device_fsid(struct btrfs_dev_item *d)
-{
-	return (unsigned long)d + offsetof(struct btrfs_dev_item, fsid);
-}
-
-BTRFS_SETGET_FUNCS(chunk_length, struct btrfs_chunk, length, 64);
-BTRFS_SETGET_FUNCS(chunk_owner, struct btrfs_chunk, owner, 64);
-BTRFS_SETGET_FUNCS(chunk_stripe_len, struct btrfs_chunk, stripe_len, 64);
-BTRFS_SETGET_FUNCS(chunk_io_align, struct btrfs_chunk, io_align, 32);
-BTRFS_SETGET_FUNCS(chunk_io_width, struct btrfs_chunk, io_width, 32);
-BTRFS_SETGET_FUNCS(chunk_sector_size, struct btrfs_chunk, sector_size, 32);
-BTRFS_SETGET_FUNCS(chunk_type, struct btrfs_chunk, type, 64);
-BTRFS_SETGET_FUNCS(chunk_num_stripes, struct btrfs_chunk, num_stripes, 16);
-BTRFS_SETGET_FUNCS(chunk_sub_stripes, struct btrfs_chunk, sub_stripes, 16);
-BTRFS_SETGET_FUNCS(stripe_devid, struct btrfs_stripe, devid, 64);
-BTRFS_SETGET_FUNCS(stripe_offset, struct btrfs_stripe, offset, 64);
-
-static inline char *btrfs_stripe_dev_uuid(struct btrfs_stripe *s)
-{
-	return (char *)s + offsetof(struct btrfs_stripe, dev_uuid);
-}
-
-BTRFS_SETGET_STACK_FUNCS(stack_chunk_length, struct btrfs_chunk, length, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_chunk_owner, struct btrfs_chunk, owner, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_chunk_stripe_len, struct btrfs_chunk,
-			 stripe_len, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_chunk_io_align, struct btrfs_chunk,
-			 io_align, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_chunk_io_width, struct btrfs_chunk,
-			 io_width, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_chunk_sector_size, struct btrfs_chunk,
-			 sector_size, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_chunk_type, struct btrfs_chunk, type, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_chunk_num_stripes, struct btrfs_chunk,
-			 num_stripes, 16);
-BTRFS_SETGET_STACK_FUNCS(stack_chunk_sub_stripes, struct btrfs_chunk,
-			 sub_stripes, 16);
-BTRFS_SETGET_STACK_FUNCS(stack_stripe_devid, struct btrfs_stripe, devid, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_stripe_offset, struct btrfs_stripe, offset, 64);
-
-static inline struct btrfs_stripe *btrfs_stripe_nr(struct btrfs_chunk *c,
-						   int nr)
-{
-	unsigned long offset = (unsigned long)c;
-	offset += offsetof(struct btrfs_chunk, stripe);
-	offset += nr * sizeof(struct btrfs_stripe);
-	return (struct btrfs_stripe *)offset;
-}
-
-static inline char *btrfs_stripe_dev_uuid_nr(struct btrfs_chunk *c, int nr)
-{
-	return btrfs_stripe_dev_uuid(btrfs_stripe_nr(c, nr));
-}
-
-static inline u64 btrfs_stripe_offset_nr(const struct extent_buffer *eb,
-					 struct btrfs_chunk *c, int nr)
-{
-	return btrfs_stripe_offset(eb, btrfs_stripe_nr(c, nr));
-}
-
-static inline u64 btrfs_stripe_devid_nr(const struct extent_buffer *eb,
-					 struct btrfs_chunk *c, int nr)
-{
-	return btrfs_stripe_devid(eb, btrfs_stripe_nr(c, nr));
-}
-
-/* struct btrfs_block_group_item */
-BTRFS_SETGET_STACK_FUNCS(stack_block_group_used, struct btrfs_block_group_item,
-			 used, 64);
-BTRFS_SETGET_FUNCS(block_group_used, struct btrfs_block_group_item,
-			 used, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_block_group_chunk_objectid,
-			struct btrfs_block_group_item, chunk_objectid, 64);
-
-BTRFS_SETGET_FUNCS(block_group_chunk_objectid,
-		   struct btrfs_block_group_item, chunk_objectid, 64);
-BTRFS_SETGET_FUNCS(block_group_flags,
-		   struct btrfs_block_group_item, flags, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
-			struct btrfs_block_group_item, flags, 64);
-
-/* struct btrfs_free_space_info */
-BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
-		   extent_count, 32);
-BTRFS_SETGET_FUNCS(free_space_flags, struct btrfs_free_space_info, flags, 32);
-
-/* struct btrfs_inode_ref */
-BTRFS_SETGET_FUNCS(inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
-BTRFS_SETGET_FUNCS(inode_ref_index, struct btrfs_inode_ref, index, 64);
-
-/* struct btrfs_inode_extref */
-BTRFS_SETGET_FUNCS(inode_extref_parent, struct btrfs_inode_extref,
-		   parent_objectid, 64);
-BTRFS_SETGET_FUNCS(inode_extref_name_len, struct btrfs_inode_extref,
-		   name_len, 16);
-BTRFS_SETGET_FUNCS(inode_extref_index, struct btrfs_inode_extref, index, 64);
-
-/* struct btrfs_inode_item */
-BTRFS_SETGET_FUNCS(inode_generation, struct btrfs_inode_item, generation, 64);
-BTRFS_SETGET_FUNCS(inode_sequence, struct btrfs_inode_item, sequence, 64);
-BTRFS_SETGET_FUNCS(inode_transid, struct btrfs_inode_item, transid, 64);
-BTRFS_SETGET_FUNCS(inode_size, struct btrfs_inode_item, size, 64);
-BTRFS_SETGET_FUNCS(inode_nbytes, struct btrfs_inode_item, nbytes, 64);
-BTRFS_SETGET_FUNCS(inode_block_group, struct btrfs_inode_item, block_group, 64);
-BTRFS_SETGET_FUNCS(inode_nlink, struct btrfs_inode_item, nlink, 32);
-BTRFS_SETGET_FUNCS(inode_uid, struct btrfs_inode_item, uid, 32);
-BTRFS_SETGET_FUNCS(inode_gid, struct btrfs_inode_item, gid, 32);
-BTRFS_SETGET_FUNCS(inode_mode, struct btrfs_inode_item, mode, 32);
-BTRFS_SETGET_FUNCS(inode_rdev, struct btrfs_inode_item, rdev, 64);
-BTRFS_SETGET_FUNCS(inode_flags, struct btrfs_inode_item, flags, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_generation, struct btrfs_inode_item,
-			 generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_sequence, struct btrfs_inode_item,
-			 sequence, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_transid, struct btrfs_inode_item,
-			 transid, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_size, struct btrfs_inode_item, size, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_nbytes, struct btrfs_inode_item,
-			 nbytes, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_block_group, struct btrfs_inode_item,
-			 block_group, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_nlink, struct btrfs_inode_item, nlink, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_uid, struct btrfs_inode_item, uid, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_gid, struct btrfs_inode_item, gid, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_mode, struct btrfs_inode_item, mode, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_rdev, struct btrfs_inode_item, rdev, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_flags, struct btrfs_inode_item, flags, 64);
-BTRFS_SETGET_FUNCS(timespec_sec, struct btrfs_timespec, sec, 64);
-BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
-
-/* struct btrfs_dev_extent */
-BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent,
-		   chunk_tree, 64);
-BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
-		   chunk_objectid, 64);
-BTRFS_SETGET_FUNCS(dev_extent_chunk_offset, struct btrfs_dev_extent,
-		   chunk_offset, 64);
-BTRFS_SETGET_FUNCS(dev_extent_length, struct btrfs_dev_extent, length, 64);
-BTRFS_SETGET_FUNCS(extent_refs, struct btrfs_extent_item, refs, 64);
-BTRFS_SETGET_FUNCS(extent_generation, struct btrfs_extent_item,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(extent_flags, struct btrfs_extent_item, flags, 64);
-
-BTRFS_SETGET_FUNCS(tree_block_level, struct btrfs_tree_block_info, level, 8);
-
-static inline void btrfs_tree_block_key(const struct extent_buffer *eb,
-					struct btrfs_tree_block_info *item,
-					struct btrfs_disk_key *key)
-{
-	read_eb_member(eb, item, struct btrfs_tree_block_info, key, key);
-}
-
-static inline void btrfs_set_tree_block_key(const struct extent_buffer *eb,
-					    struct btrfs_tree_block_info *item,
-					    struct btrfs_disk_key *key)
-{
-	write_eb_member(eb, item, struct btrfs_tree_block_info, key, key);
-}
-
-BTRFS_SETGET_FUNCS(extent_data_ref_root, struct btrfs_extent_data_ref,
-		   root, 64);
-BTRFS_SETGET_FUNCS(extent_data_ref_objectid, struct btrfs_extent_data_ref,
-		   objectid, 64);
-BTRFS_SETGET_FUNCS(extent_data_ref_offset, struct btrfs_extent_data_ref,
-		   offset, 64);
-BTRFS_SETGET_FUNCS(extent_data_ref_count, struct btrfs_extent_data_ref,
-		   count, 32);
-
-BTRFS_SETGET_FUNCS(shared_data_ref_count, struct btrfs_shared_data_ref,
-		   count, 32);
-
-BTRFS_SETGET_FUNCS(extent_inline_ref_type, struct btrfs_extent_inline_ref,
-		   type, 8);
-BTRFS_SETGET_FUNCS(extent_inline_ref_offset, struct btrfs_extent_inline_ref,
-		   offset, 64);
-
-static inline u32 btrfs_extent_inline_ref_size(int type)
-{
-	if (type == BTRFS_TREE_BLOCK_REF_KEY ||
-	    type == BTRFS_SHARED_BLOCK_REF_KEY)
-		return sizeof(struct btrfs_extent_inline_ref);
-	if (type == BTRFS_SHARED_DATA_REF_KEY)
-		return sizeof(struct btrfs_shared_data_ref) +
-		       sizeof(struct btrfs_extent_inline_ref);
-	if (type == BTRFS_EXTENT_DATA_REF_KEY)
-		return sizeof(struct btrfs_extent_data_ref) +
-		       offsetof(struct btrfs_extent_inline_ref, offset);
-	return 0;
-}
-
-/* struct btrfs_node */
-BTRFS_SETGET_FUNCS(key_blockptr, struct btrfs_key_ptr, blockptr, 64);
-BTRFS_SETGET_FUNCS(key_generation, struct btrfs_key_ptr, generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_key_blockptr, struct btrfs_key_ptr,
-			 blockptr, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_key_generation, struct btrfs_key_ptr,
-			 generation, 64);
-
-static inline u64 btrfs_node_blockptr(const struct extent_buffer *eb, int nr)
-{
-	unsigned long ptr;
-	ptr = offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
-	return btrfs_key_blockptr(eb, (struct btrfs_key_ptr *)ptr);
-}
-
-static inline void btrfs_set_node_blockptr(const struct extent_buffer *eb,
-					   int nr, u64 val)
-{
-	unsigned long ptr;
-	ptr = offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
-	btrfs_set_key_blockptr(eb, (struct btrfs_key_ptr *)ptr, val);
-}
-
-static inline u64 btrfs_node_ptr_generation(const struct extent_buffer *eb, int nr)
-{
-	unsigned long ptr;
-	ptr = offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
-	return btrfs_key_generation(eb, (struct btrfs_key_ptr *)ptr);
-}
-
-static inline void btrfs_set_node_ptr_generation(const struct extent_buffer *eb,
-						 int nr, u64 val)
-{
-	unsigned long ptr;
-	ptr = offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
-	btrfs_set_key_generation(eb, (struct btrfs_key_ptr *)ptr, val);
-}
-
-static inline unsigned long btrfs_node_key_ptr_offset(int nr)
-{
-	return offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
-}
-
-void btrfs_node_key(const struct extent_buffer *eb,
-		    struct btrfs_disk_key *disk_key, int nr);
-
-static inline void btrfs_set_node_key(const struct extent_buffer *eb,
-				      struct btrfs_disk_key *disk_key, int nr)
-{
-	unsigned long ptr;
-	ptr = btrfs_node_key_ptr_offset(nr);
-	write_eb_member(eb, (struct btrfs_key_ptr *)ptr,
-		       struct btrfs_key_ptr, key, disk_key);
-}
-
-/* struct btrfs_item */
-BTRFS_SETGET_FUNCS(item_offset, struct btrfs_item, offset, 32);
-BTRFS_SETGET_FUNCS(item_size, struct btrfs_item, size, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_item_offset, struct btrfs_item, offset, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_item_size, struct btrfs_item, size, 32);
-
-static inline unsigned long btrfs_item_nr_offset(int nr)
-{
-	return offsetof(struct btrfs_leaf, items) +
-		sizeof(struct btrfs_item) * nr;
-}
-
-static inline struct btrfs_item *btrfs_item_nr(int nr)
-{
-	return (struct btrfs_item *)btrfs_item_nr_offset(nr);
-}
-
-static inline u32 btrfs_item_end(const struct extent_buffer *eb,
-				 struct btrfs_item *item)
-{
-	return btrfs_item_offset(eb, item) + btrfs_item_size(eb, item);
-}
-
-static inline u32 btrfs_item_end_nr(const struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_end(eb, btrfs_item_nr(nr));
-}
-
-static inline u32 btrfs_item_offset_nr(const struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_offset(eb, btrfs_item_nr(nr));
-}
-
-static inline u32 btrfs_item_size_nr(const struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_size(eb, btrfs_item_nr(nr));
-}
-
-static inline void btrfs_item_key(const struct extent_buffer *eb,
-			   struct btrfs_disk_key *disk_key, int nr)
-{
-	struct btrfs_item *item = btrfs_item_nr(nr);
-	read_eb_member(eb, item, struct btrfs_item, key, disk_key);
-}
-
-static inline void btrfs_set_item_key(struct extent_buffer *eb,
-			       struct btrfs_disk_key *disk_key, int nr)
-{
-	struct btrfs_item *item = btrfs_item_nr(nr);
-	write_eb_member(eb, item, struct btrfs_item, key, disk_key);
-}
-
-BTRFS_SETGET_FUNCS(dir_log_end, struct btrfs_dir_log_item, end, 64);
-
-/*
- * struct btrfs_root_ref
- */
-BTRFS_SETGET_FUNCS(root_ref_dirid, struct btrfs_root_ref, dirid, 64);
-BTRFS_SETGET_FUNCS(root_ref_sequence, struct btrfs_root_ref, sequence, 64);
-BTRFS_SETGET_FUNCS(root_ref_name_len, struct btrfs_root_ref, name_len, 16);
-
-/* struct btrfs_dir_item */
-BTRFS_SETGET_FUNCS(dir_data_len, struct btrfs_dir_item, data_len, 16);
-BTRFS_SETGET_FUNCS(dir_type, struct btrfs_dir_item, type, 8);
-BTRFS_SETGET_FUNCS(dir_name_len, struct btrfs_dir_item, name_len, 16);
-BTRFS_SETGET_FUNCS(dir_transid, struct btrfs_dir_item, transid, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_dir_type, struct btrfs_dir_item, type, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_dir_data_len, struct btrfs_dir_item,
-			 data_len, 16);
-BTRFS_SETGET_STACK_FUNCS(stack_dir_name_len, struct btrfs_dir_item,
-			 name_len, 16);
-BTRFS_SETGET_STACK_FUNCS(stack_dir_transid, struct btrfs_dir_item,
-			 transid, 64);
-
-static inline void btrfs_dir_item_key(const struct extent_buffer *eb,
-				      const struct btrfs_dir_item *item,
-				      struct btrfs_disk_key *key)
-{
-	read_eb_member(eb, item, struct btrfs_dir_item, location, key);
-}
-
-static inline void btrfs_set_dir_item_key(struct extent_buffer *eb,
-					  struct btrfs_dir_item *item,
-					  const struct btrfs_disk_key *key)
-{
-	write_eb_member(eb, item, struct btrfs_dir_item, location, key);
-}
-
-BTRFS_SETGET_FUNCS(free_space_entries, struct btrfs_free_space_header,
-		   num_entries, 64);
-BTRFS_SETGET_FUNCS(free_space_bitmaps, struct btrfs_free_space_header,
-		   num_bitmaps, 64);
-BTRFS_SETGET_FUNCS(free_space_generation, struct btrfs_free_space_header,
-		   generation, 64);
-
-static inline void btrfs_free_space_key(const struct extent_buffer *eb,
-					const struct btrfs_free_space_header *h,
-					struct btrfs_disk_key *key)
-{
-	read_eb_member(eb, h, struct btrfs_free_space_header, location, key);
-}
-
-static inline void btrfs_set_free_space_key(struct extent_buffer *eb,
-					    struct btrfs_free_space_header *h,
-					    const struct btrfs_disk_key *key)
-{
-	write_eb_member(eb, h, struct btrfs_free_space_header, location, key);
-}
-
-/* struct btrfs_disk_key */
-BTRFS_SETGET_STACK_FUNCS(disk_key_objectid, struct btrfs_disk_key,
-			 objectid, 64);
-BTRFS_SETGET_STACK_FUNCS(disk_key_offset, struct btrfs_disk_key, offset, 64);
-BTRFS_SETGET_STACK_FUNCS(disk_key_type, struct btrfs_disk_key, type, 8);
-
-#ifdef __LITTLE_ENDIAN
-
-/*
- * Optimized helpers for little-endian architectures where CPU and on-disk
- * structures have the same endianness and we can skip conversions.
- */
-
-static inline void btrfs_disk_key_to_cpu(struct btrfs_key *cpu_key,
-					 const struct btrfs_disk_key *disk_key)
-{
-	memcpy(cpu_key, disk_key, sizeof(struct btrfs_key));
-}
-
-static inline void btrfs_cpu_key_to_disk(struct btrfs_disk_key *disk_key,
-					 const struct btrfs_key *cpu_key)
-{
-	memcpy(disk_key, cpu_key, sizeof(struct btrfs_key));
-}
-
-static inline void btrfs_node_key_to_cpu(const struct extent_buffer *eb,
-					 struct btrfs_key *cpu_key, int nr)
-{
-	struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)cpu_key;
-
-	btrfs_node_key(eb, disk_key, nr);
-}
-
-static inline void btrfs_item_key_to_cpu(const struct extent_buffer *eb,
-					 struct btrfs_key *cpu_key, int nr)
-{
-	struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)cpu_key;
-
-	btrfs_item_key(eb, disk_key, nr);
-}
-
-static inline void btrfs_dir_item_key_to_cpu(const struct extent_buffer *eb,
-					     const struct btrfs_dir_item *item,
-					     struct btrfs_key *cpu_key)
-{
-	struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)cpu_key;
-
-	btrfs_dir_item_key(eb, item, disk_key);
-}
-
-#else
-
-static inline void btrfs_disk_key_to_cpu(struct btrfs_key *cpu,
-					 const struct btrfs_disk_key *disk)
-{
-	cpu->offset = le64_to_cpu(disk->offset);
-	cpu->type = disk->type;
-	cpu->objectid = le64_to_cpu(disk->objectid);
-}
-
-static inline void btrfs_cpu_key_to_disk(struct btrfs_disk_key *disk,
-					 const struct btrfs_key *cpu)
-{
-	disk->offset = cpu_to_le64(cpu->offset);
-	disk->type = cpu->type;
-	disk->objectid = cpu_to_le64(cpu->objectid);
-}
-
-static inline void btrfs_node_key_to_cpu(const struct extent_buffer *eb,
-					 struct btrfs_key *key, int nr)
-{
-	struct btrfs_disk_key disk_key;
-	btrfs_node_key(eb, &disk_key, nr);
-	btrfs_disk_key_to_cpu(key, &disk_key);
-}
-
-static inline void btrfs_item_key_to_cpu(const struct extent_buffer *eb,
-					 struct btrfs_key *key, int nr)
-{
-	struct btrfs_disk_key disk_key;
-	btrfs_item_key(eb, &disk_key, nr);
-	btrfs_disk_key_to_cpu(key, &disk_key);
-}
-
-static inline void btrfs_dir_item_key_to_cpu(const struct extent_buffer *eb,
-					     const struct btrfs_dir_item *item,
-					     struct btrfs_key *key)
-{
-	struct btrfs_disk_key disk_key;
-	btrfs_dir_item_key(eb, item, &disk_key);
-	btrfs_disk_key_to_cpu(key, &disk_key);
-}
-
-#endif
-
-/* struct btrfs_header */
-BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,
-			  generation, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
-BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
-			 generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header,
-			 nritems, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_header_bytenr, struct btrfs_header, bytenr, 64);
-
-static inline int btrfs_header_flag(const struct extent_buffer *eb, u64 flag)
-{
-	return (btrfs_header_flags(eb) & flag) == flag;
-}
-
-static inline void btrfs_set_header_flag(struct extent_buffer *eb, u64 flag)
-{
-	u64 flags = btrfs_header_flags(eb);
-	btrfs_set_header_flags(eb, flags | flag);
-}
-
-static inline void btrfs_clear_header_flag(struct extent_buffer *eb, u64 flag)
-{
-	u64 flags = btrfs_header_flags(eb);
-	btrfs_set_header_flags(eb, flags & ~flag);
-}
-
-static inline int btrfs_header_backref_rev(const struct extent_buffer *eb)
-{
-	u64 flags = btrfs_header_flags(eb);
-	return flags >> BTRFS_BACKREF_REV_SHIFT;
-}
-
-static inline void btrfs_set_header_backref_rev(struct extent_buffer *eb,
-						int rev)
-{
-	u64 flags = btrfs_header_flags(eb);
-	flags &= ~BTRFS_BACKREF_REV_MASK;
-	flags |= (u64)rev << BTRFS_BACKREF_REV_SHIFT;
-	btrfs_set_header_flags(eb, flags);
-}
-
-static inline int btrfs_is_leaf(const struct extent_buffer *eb)
-{
-	return btrfs_header_level(eb) == 0;
-}
-
-/* struct btrfs_root_item */
-BTRFS_SETGET_FUNCS(disk_root_generation, struct btrfs_root_item,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(disk_root_refs, struct btrfs_root_item, refs, 32);
-BTRFS_SETGET_FUNCS(disk_root_bytenr, struct btrfs_root_item, bytenr, 64);
-BTRFS_SETGET_FUNCS(disk_root_level, struct btrfs_root_item, level, 8);
-
-BTRFS_SETGET_STACK_FUNCS(root_generation, struct btrfs_root_item,
-			 generation, 64);
-BTRFS_SETGET_STACK_FUNCS(root_bytenr, struct btrfs_root_item, bytenr, 64);
-BTRFS_SETGET_STACK_FUNCS(root_drop_level, struct btrfs_root_item, drop_level, 8);
-BTRFS_SETGET_STACK_FUNCS(root_level, struct btrfs_root_item, level, 8);
-BTRFS_SETGET_STACK_FUNCS(root_dirid, struct btrfs_root_item, root_dirid, 64);
-BTRFS_SETGET_STACK_FUNCS(root_refs, struct btrfs_root_item, refs, 32);
-BTRFS_SETGET_STACK_FUNCS(root_flags, struct btrfs_root_item, flags, 64);
-BTRFS_SETGET_STACK_FUNCS(root_used, struct btrfs_root_item, bytes_used, 64);
-BTRFS_SETGET_STACK_FUNCS(root_limit, struct btrfs_root_item, byte_limit, 64);
-BTRFS_SETGET_STACK_FUNCS(root_last_snapshot, struct btrfs_root_item,
-			 last_snapshot, 64);
-BTRFS_SETGET_STACK_FUNCS(root_generation_v2, struct btrfs_root_item,
-			 generation_v2, 64);
-BTRFS_SETGET_STACK_FUNCS(root_ctransid, struct btrfs_root_item,
-			 ctransid, 64);
-BTRFS_SETGET_STACK_FUNCS(root_otransid, struct btrfs_root_item,
-			 otransid, 64);
-BTRFS_SETGET_STACK_FUNCS(root_stransid, struct btrfs_root_item,
-			 stransid, 64);
-BTRFS_SETGET_STACK_FUNCS(root_rtransid, struct btrfs_root_item,
-			 rtransid, 64);
-
 static inline bool btrfs_root_readonly(const struct btrfs_root *root)
 {
 	/* Byte-swap the constant at compile time, root_item::flags is LE */
@@ -2049,100 +1362,6 @@ static inline bool btrfs_root_dead(const struct btrfs_root *root)
 	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_DEAD)) != 0;
 }
 
-/* struct btrfs_root_backup */
-BTRFS_SETGET_STACK_FUNCS(backup_tree_root, struct btrfs_root_backup,
-		   tree_root, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_tree_root_gen, struct btrfs_root_backup,
-		   tree_root_gen, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_tree_root_level, struct btrfs_root_backup,
-		   tree_root_level, 8);
-
-BTRFS_SETGET_STACK_FUNCS(backup_chunk_root, struct btrfs_root_backup,
-		   chunk_root, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_chunk_root_gen, struct btrfs_root_backup,
-		   chunk_root_gen, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_chunk_root_level, struct btrfs_root_backup,
-		   chunk_root_level, 8);
-
-BTRFS_SETGET_STACK_FUNCS(backup_extent_root, struct btrfs_root_backup,
-		   extent_root, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_extent_root_gen, struct btrfs_root_backup,
-		   extent_root_gen, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_extent_root_level, struct btrfs_root_backup,
-		   extent_root_level, 8);
-
-BTRFS_SETGET_STACK_FUNCS(backup_fs_root, struct btrfs_root_backup,
-		   fs_root, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_fs_root_gen, struct btrfs_root_backup,
-		   fs_root_gen, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_fs_root_level, struct btrfs_root_backup,
-		   fs_root_level, 8);
-
-BTRFS_SETGET_STACK_FUNCS(backup_dev_root, struct btrfs_root_backup,
-		   dev_root, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_dev_root_gen, struct btrfs_root_backup,
-		   dev_root_gen, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_dev_root_level, struct btrfs_root_backup,
-		   dev_root_level, 8);
-
-BTRFS_SETGET_STACK_FUNCS(backup_csum_root, struct btrfs_root_backup,
-		   csum_root, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_csum_root_gen, struct btrfs_root_backup,
-		   csum_root_gen, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_csum_root_level, struct btrfs_root_backup,
-		   csum_root_level, 8);
-BTRFS_SETGET_STACK_FUNCS(backup_total_bytes, struct btrfs_root_backup,
-		   total_bytes, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
-		   bytes_used, 64);
-BTRFS_SETGET_STACK_FUNCS(backup_num_devices, struct btrfs_root_backup,
-		   num_devices, 64);
-
-/* struct btrfs_balance_item */
-BTRFS_SETGET_FUNCS(balance_flags, struct btrfs_balance_item, flags, 64);
-
-static inline void btrfs_balance_data(const struct extent_buffer *eb,
-				      const struct btrfs_balance_item *bi,
-				      struct btrfs_disk_balance_args *ba)
-{
-	read_eb_member(eb, bi, struct btrfs_balance_item, data, ba);
-}
-
-static inline void btrfs_set_balance_data(struct extent_buffer *eb,
-				  struct btrfs_balance_item *bi,
-				  const struct btrfs_disk_balance_args *ba)
-{
-	write_eb_member(eb, bi, struct btrfs_balance_item, data, ba);
-}
-
-static inline void btrfs_balance_meta(const struct extent_buffer *eb,
-				      const struct btrfs_balance_item *bi,
-				      struct btrfs_disk_balance_args *ba)
-{
-	read_eb_member(eb, bi, struct btrfs_balance_item, meta, ba);
-}
-
-static inline void btrfs_set_balance_meta(struct extent_buffer *eb,
-				  struct btrfs_balance_item *bi,
-				  const struct btrfs_disk_balance_args *ba)
-{
-	write_eb_member(eb, bi, struct btrfs_balance_item, meta, ba);
-}
-
-static inline void btrfs_balance_sys(const struct extent_buffer *eb,
-				     const struct btrfs_balance_item *bi,
-				     struct btrfs_disk_balance_args *ba)
-{
-	read_eb_member(eb, bi, struct btrfs_balance_item, sys, ba);
-}
-
-static inline void btrfs_set_balance_sys(struct extent_buffer *eb,
-				 struct btrfs_balance_item *bi,
-				 const struct btrfs_disk_balance_args *ba)
-{
-	write_eb_member(eb, bi, struct btrfs_balance_item, sys, ba);
-}
-
 static inline void
 btrfs_disk_balance_args_to_cpu(struct btrfs_balance_args *cpu,
 			       const struct btrfs_disk_balance_args *disk)
@@ -2183,62 +1402,11 @@ btrfs_cpu_balance_args_to_disk(struct btrfs_disk_balance_args *disk,
 	disk->stripes_max = cpu_to_le32(cpu->stripes_max);
 }
 
-/* struct btrfs_super_block */
-BTRFS_SETGET_STACK_FUNCS(super_bytenr, struct btrfs_super_block, bytenr, 64);
-BTRFS_SETGET_STACK_FUNCS(super_flags, struct btrfs_super_block, flags, 64);
-BTRFS_SETGET_STACK_FUNCS(super_generation, struct btrfs_super_block,
-			 generation, 64);
-BTRFS_SETGET_STACK_FUNCS(super_root, struct btrfs_super_block, root, 64);
-BTRFS_SETGET_STACK_FUNCS(super_sys_array_size,
-			 struct btrfs_super_block, sys_chunk_array_size, 32);
-BTRFS_SETGET_STACK_FUNCS(super_chunk_root_generation,
-			 struct btrfs_super_block, chunk_root_generation, 64);
-BTRFS_SETGET_STACK_FUNCS(super_root_level, struct btrfs_super_block,
-			 root_level, 8);
-BTRFS_SETGET_STACK_FUNCS(super_chunk_root, struct btrfs_super_block,
-			 chunk_root, 64);
-BTRFS_SETGET_STACK_FUNCS(super_chunk_root_level, struct btrfs_super_block,
-			 chunk_root_level, 8);
-BTRFS_SETGET_STACK_FUNCS(super_log_root, struct btrfs_super_block,
-			 log_root, 64);
-BTRFS_SETGET_STACK_FUNCS(super_log_root_transid, struct btrfs_super_block,
-			 log_root_transid, 64);
-BTRFS_SETGET_STACK_FUNCS(super_log_root_level, struct btrfs_super_block,
-			 log_root_level, 8);
-BTRFS_SETGET_STACK_FUNCS(super_total_bytes, struct btrfs_super_block,
-			 total_bytes, 64);
-BTRFS_SETGET_STACK_FUNCS(super_bytes_used, struct btrfs_super_block,
-			 bytes_used, 64);
-BTRFS_SETGET_STACK_FUNCS(super_sectorsize, struct btrfs_super_block,
-			 sectorsize, 32);
-BTRFS_SETGET_STACK_FUNCS(super_nodesize, struct btrfs_super_block,
-			 nodesize, 32);
-BTRFS_SETGET_STACK_FUNCS(super_stripesize, struct btrfs_super_block,
-			 stripesize, 32);
-BTRFS_SETGET_STACK_FUNCS(super_root_dir, struct btrfs_super_block,
-			 root_dir_objectid, 64);
-BTRFS_SETGET_STACK_FUNCS(super_num_devices, struct btrfs_super_block,
-			 num_devices, 64);
-BTRFS_SETGET_STACK_FUNCS(super_compat_flags, struct btrfs_super_block,
-			 compat_flags, 64);
-BTRFS_SETGET_STACK_FUNCS(super_compat_ro_flags, struct btrfs_super_block,
-			 compat_ro_flags, 64);
-BTRFS_SETGET_STACK_FUNCS(super_incompat_flags, struct btrfs_super_block,
-			 incompat_flags, 64);
-BTRFS_SETGET_STACK_FUNCS(super_csum_type, struct btrfs_super_block,
-			 csum_type, 16);
-BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
-			 cache_generation, 64);
-BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
-BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
-			 uuid_tree_generation, 64);
-
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
 const char *btrfs_super_csum_driver(u16 csum_type);
 size_t __attribute_const__ btrfs_get_num_csums(void);
 
-
 /*
  * The leaf data grows from end-to-front in the node.
  * this returns the address of the start of the last item,
@@ -2253,24 +1421,6 @@ static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
 	return btrfs_item_offset_nr(leaf, nr - 1);
 }
 
-/* struct btrfs_file_extent_item */
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
-			 type, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_bytenr,
-			 struct btrfs_file_extent_item, disk_bytenr, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_offset,
-			 struct btrfs_file_extent_item, offset, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_generation,
-			 struct btrfs_file_extent_item, generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_num_bytes,
-			 struct btrfs_file_extent_item, num_bytes, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_ram_bytes,
-			 struct btrfs_file_extent_item, ram_bytes, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_num_bytes,
-			 struct btrfs_file_extent_item, disk_num_bytes, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression,
-			 struct btrfs_file_extent_item, compression, 8);
-
 static inline unsigned long
 btrfs_file_extent_inline_start(const struct btrfs_file_extent_item *e)
 {
@@ -2282,26 +1432,6 @@ static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
 	return BTRFS_FILE_EXTENT_INLINE_DATA_START + datasize;
 }
 
-BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
-BTRFS_SETGET_FUNCS(file_extent_disk_bytenr, struct btrfs_file_extent_item,
-		   disk_bytenr, 64);
-BTRFS_SETGET_FUNCS(file_extent_generation, struct btrfs_file_extent_item,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(file_extent_disk_num_bytes, struct btrfs_file_extent_item,
-		   disk_num_bytes, 64);
-BTRFS_SETGET_FUNCS(file_extent_offset, struct btrfs_file_extent_item,
-		  offset, 64);
-BTRFS_SETGET_FUNCS(file_extent_num_bytes, struct btrfs_file_extent_item,
-		   num_bytes, 64);
-BTRFS_SETGET_FUNCS(file_extent_ram_bytes, struct btrfs_file_extent_item,
-		   ram_bytes, 64);
-BTRFS_SETGET_FUNCS(file_extent_compression, struct btrfs_file_extent_item,
-		   compression, 8);
-BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
-		   encryption, 8);
-BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
-		   other_encoding, 16);
-
 /*
  * this returns the number of bytes used by the item on disk, minus the
  * size of any extent headers.  If a file is compressed on disk, this is
@@ -2314,101 +1444,6 @@ static inline u32 btrfs_file_extent_inline_item_len(
 	return btrfs_item_size(eb, e) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
 }
 
-/* btrfs_qgroup_status_item */
-BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(qgroup_status_version, struct btrfs_qgroup_status_item,
-		   version, 64);
-BTRFS_SETGET_FUNCS(qgroup_status_flags, struct btrfs_qgroup_status_item,
-		   flags, 64);
-BTRFS_SETGET_FUNCS(qgroup_status_rescan, struct btrfs_qgroup_status_item,
-		   rescan, 64);
-
-/* btrfs_qgroup_info_item */
-BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_rfer, struct btrfs_qgroup_info_item, rfer, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_rfer_cmpr, struct btrfs_qgroup_info_item,
-		   rfer_cmpr, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_excl, struct btrfs_qgroup_info_item, excl, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_excl_cmpr, struct btrfs_qgroup_info_item,
-		   excl_cmpr, 64);
-
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_generation,
-			 struct btrfs_qgroup_info_item, generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_rfer, struct btrfs_qgroup_info_item,
-			 rfer, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_rfer_cmpr,
-			 struct btrfs_qgroup_info_item, rfer_cmpr, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_excl, struct btrfs_qgroup_info_item,
-			 excl, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_excl_cmpr,
-			 struct btrfs_qgroup_info_item, excl_cmpr, 64);
-
-/* btrfs_qgroup_limit_item */
-BTRFS_SETGET_FUNCS(qgroup_limit_flags, struct btrfs_qgroup_limit_item,
-		   flags, 64);
-BTRFS_SETGET_FUNCS(qgroup_limit_max_rfer, struct btrfs_qgroup_limit_item,
-		   max_rfer, 64);
-BTRFS_SETGET_FUNCS(qgroup_limit_max_excl, struct btrfs_qgroup_limit_item,
-		   max_excl, 64);
-BTRFS_SETGET_FUNCS(qgroup_limit_rsv_rfer, struct btrfs_qgroup_limit_item,
-		   rsv_rfer, 64);
-BTRFS_SETGET_FUNCS(qgroup_limit_rsv_excl, struct btrfs_qgroup_limit_item,
-		   rsv_excl, 64);
-
-/* btrfs_dev_replace_item */
-BTRFS_SETGET_FUNCS(dev_replace_src_devid,
-		   struct btrfs_dev_replace_item, src_devid, 64);
-BTRFS_SETGET_FUNCS(dev_replace_cont_reading_from_srcdev_mode,
-		   struct btrfs_dev_replace_item, cont_reading_from_srcdev_mode,
-		   64);
-BTRFS_SETGET_FUNCS(dev_replace_replace_state, struct btrfs_dev_replace_item,
-		   replace_state, 64);
-BTRFS_SETGET_FUNCS(dev_replace_time_started, struct btrfs_dev_replace_item,
-		   time_started, 64);
-BTRFS_SETGET_FUNCS(dev_replace_time_stopped, struct btrfs_dev_replace_item,
-		   time_stopped, 64);
-BTRFS_SETGET_FUNCS(dev_replace_num_write_errors, struct btrfs_dev_replace_item,
-		   num_write_errors, 64);
-BTRFS_SETGET_FUNCS(dev_replace_num_uncorrectable_read_errors,
-		   struct btrfs_dev_replace_item, num_uncorrectable_read_errors,
-		   64);
-BTRFS_SETGET_FUNCS(dev_replace_cursor_left, struct btrfs_dev_replace_item,
-		   cursor_left, 64);
-BTRFS_SETGET_FUNCS(dev_replace_cursor_right, struct btrfs_dev_replace_item,
-		   cursor_right, 64);
-
-BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_src_devid,
-			 struct btrfs_dev_replace_item, src_devid, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cont_reading_from_srcdev_mode,
-			 struct btrfs_dev_replace_item,
-			 cont_reading_from_srcdev_mode, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_replace_state,
-			 struct btrfs_dev_replace_item, replace_state, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_time_started,
-			 struct btrfs_dev_replace_item, time_started, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_time_stopped,
-			 struct btrfs_dev_replace_item, time_stopped, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_num_write_errors,
-			 struct btrfs_dev_replace_item, num_write_errors, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_num_uncorrectable_read_errors,
-			 struct btrfs_dev_replace_item,
-			 num_uncorrectable_read_errors, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_left,
-			 struct btrfs_dev_replace_item, cursor_left, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_right,
-			 struct btrfs_dev_replace_item, cursor_right, 64);
-
-/* helper function to cast into the data area of the leaf. */
-#define btrfs_item_ptr(leaf, slot, type) \
-	((type *)(BTRFS_LEAF_DATA_OFFSET + \
-	btrfs_item_offset_nr(leaf, slot)))
-
-#define btrfs_item_ptr_offset(leaf, slot) \
-	((unsigned long)(BTRFS_LEAF_DATA_OFFSET + \
-	btrfs_item_offset_nr(leaf, slot)))
-
 static inline u32 btrfs_crc32c(u32 crc, const void *address, unsigned length)
 {
 	return crc32c(crc, address, length);
-- 
2.33.1

