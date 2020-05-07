Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4751C9C17
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgEGUUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:56138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUUX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5052CAD2C;
        Thu,  7 May 2020 20:20:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DF5FDDA732; Thu,  7 May 2020 22:19:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 02/19] btrfs: drop eb parameter from set/get token helpers
Date:   Thu,  7 May 2020 22:19:31 +0200
Message-Id: <b8b135176911726d988ea5f686b93fbd351e47e2.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that all set/get helpers use the eb from the token, we don't need to
pass it to many btrfs_token_*/btrfs_set_token_* helpers, saving some
stack space.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c        |  53 ++++++++---------
 fs/btrfs/ctree.h        |  27 ++++-----
 fs/btrfs/inode.c        |  71 +++++++++++------------
 fs/btrfs/struct-funcs.c |  12 ++--
 fs/btrfs/tree-log.c     | 125 ++++++++++++++++++----------------------
 5 files changed, 130 insertions(+), 158 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6c28efe5b14a..576111cdea1d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3517,9 +3517,9 @@ static int leaf_space_used(struct extent_buffer *l, int start, int nr)
 	btrfs_init_map_token(&token, l);
 	start_item = btrfs_item_nr(start);
 	end_item = btrfs_item_nr(end);
-	data_len = btrfs_token_item_offset(l, start_item, &token) +
-		btrfs_token_item_size(l, start_item, &token);
-	data_len = data_len - btrfs_token_item_offset(l, end_item, &token);
+	data_len = btrfs_token_item_offset(&token, start_item) +
+		btrfs_token_item_size(&token, start_item);
+	data_len = data_len - btrfs_token_item_offset(&token, end_item);
 	data_len += sizeof(struct btrfs_item) * nr;
 	WARN_ON(data_len < 0);
 	return data_len;
@@ -3650,8 +3650,8 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
 	for (i = 0; i < right_nritems; i++) {
 		item = btrfs_item_nr(i);
-		push_space -= btrfs_token_item_size(right, item, &token);
-		btrfs_set_token_item_offset(right, item, push_space, &token);
+		push_space -= btrfs_token_item_size(&token, item);
+		btrfs_set_token_item_offset(&token, item, push_space);
 	}
 
 	left_nritems -= push_items;
@@ -3859,10 +3859,9 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 
 		item = btrfs_item_nr(i);
 
-		ioff = btrfs_token_item_offset(left, item, &token);
-		btrfs_set_token_item_offset(left, item,
-		      ioff - (BTRFS_LEAF_DATA_SIZE(fs_info) - old_left_item_size),
-		      &token);
+		ioff = btrfs_token_item_offset(&token, item);
+		btrfs_set_token_item_offset(&token, item,
+		      ioff - (BTRFS_LEAF_DATA_SIZE(fs_info) - old_left_item_size));
 	}
 	btrfs_set_header_nritems(left, old_left_nritems + push_items);
 
@@ -3892,9 +3891,8 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	for (i = 0; i < right_nritems; i++) {
 		item = btrfs_item_nr(i);
 
-		push_space = push_space - btrfs_token_item_size(right,
-								item, &token);
-		btrfs_set_token_item_offset(right, item, push_space, &token);
+		push_space = push_space - btrfs_token_item_size(&token, item);
+		btrfs_set_token_item_offset(&token, item, push_space);
 	}
 
 	btrfs_mark_buffer_dirty(left);
@@ -4036,9 +4034,8 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 		struct btrfs_item *item = btrfs_item_nr(i);
 		u32 ioff;
 
-		ioff = btrfs_token_item_offset(right, item, &token);
-		btrfs_set_token_item_offset(right, item,
-					    ioff + rt_data_off, &token);
+		ioff = btrfs_token_item_offset(&token, item);
+		btrfs_set_token_item_offset(&token, item, ioff + rt_data_off);
 	}
 
 	btrfs_set_header_nritems(l, mid);
@@ -4541,9 +4538,8 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 		u32 ioff;
 		item = btrfs_item_nr(i);
 
-		ioff = btrfs_token_item_offset(leaf, item, &token);
-		btrfs_set_token_item_offset(leaf, item,
-					    ioff + size_diff, &token);
+		ioff = btrfs_token_item_offset(&token, item);
+		btrfs_set_token_item_offset(&token, item, ioff + size_diff);
 	}
 
 	/* shift the data */
@@ -4640,9 +4636,8 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 		u32 ioff;
 		item = btrfs_item_nr(i);
 
-		ioff = btrfs_token_item_offset(leaf, item, &token);
-		btrfs_set_token_item_offset(leaf, item,
-					    ioff - data_size, &token);
+		ioff = btrfs_token_item_offset(&token, item);
+		btrfs_set_token_item_offset(&token, item, ioff - data_size);
 	}
 
 	/* shift the data */
@@ -4718,9 +4713,9 @@ void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
 			u32 ioff;
 
 			item = btrfs_item_nr(i);
-			ioff = btrfs_token_item_offset(leaf, item, &token);
-			btrfs_set_token_item_offset(leaf, item,
-						    ioff - total_data, &token);
+			ioff = btrfs_token_item_offset(&token, item);
+			btrfs_set_token_item_offset(&token, item,
+						    ioff - total_data);
 		}
 		/* shift the items */
 		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot + nr),
@@ -4739,10 +4734,9 @@ void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
 		btrfs_cpu_key_to_disk(&disk_key, cpu_key + i);
 		btrfs_set_item_key(leaf, &disk_key, slot + i);
 		item = btrfs_item_nr(slot + i);
-		btrfs_set_token_item_offset(leaf, item,
-					    data_end - data_size[i], &token);
+		btrfs_set_token_item_offset(&token, item, data_end - data_size[i]);
 		data_end -= data_size[i];
-		btrfs_set_token_item_size(leaf, item, data_size[i], &token);
+		btrfs_set_token_item_size(&token, item, data_size[i]);
 	}
 
 	btrfs_set_header_nritems(leaf, nritems + nr);
@@ -4930,9 +4924,8 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			u32 ioff;
 
 			item = btrfs_item_nr(i);
-			ioff = btrfs_token_item_offset(leaf, item, &token);
-			btrfs_set_token_item_offset(leaf, item,
-						    ioff + dsize, &token);
+			ioff = btrfs_token_item_offset(&token, item);
+			btrfs_set_token_item_offset(&token, item, ioff + dsize);
 		}
 
 		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot),
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 03ea7370aea7..054ddb5d2425 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1340,7 +1340,7 @@ do {                                                                   \
 	 BTRFS_INODE_ROOT_ITEM_INIT)
 
 struct btrfs_map_token {
-	const struct extent_buffer *eb;
+	struct extent_buffer *eb;
 	char *kaddr;
 	unsigned long offset;
 };
@@ -1376,12 +1376,11 @@ static inline void btrfs_init_map_token(struct btrfs_map_token *token,
 			   sizeof(((type *)0)->member)))
 
 #define DECLARE_BTRFS_SETGET_BITS(bits)					\
-u##bits btrfs_get_token_##bits(const struct extent_buffer *eb,		\
-			       const void *ptr, unsigned long off,	\
-			       struct btrfs_map_token *token);		\
-void btrfs_set_token_##bits(struct extent_buffer *eb, const void *ptr,	\
-			    unsigned long off, u##bits val,		\
-			    struct btrfs_map_token *token);		\
+u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
+			       const void *ptr, unsigned long off);	\
+void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
+			    const void *ptr, unsigned long off,		\
+			    u##bits val);				\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off);		\
 void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
@@ -1405,19 +1404,17 @@ static inline void btrfs_set_##name(struct extent_buffer *eb, type *s,	\
 	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
 	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
 }									\
-static inline u##bits btrfs_token_##name(const struct extent_buffer *eb,\
-					 const type *s,			\
-					 struct btrfs_map_token *token)	\
+static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
+					 const type *s)			\
 {									\
 	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
-	return btrfs_get_token_##bits(eb, s, offsetof(type, member), token); \
+	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
 }									\
-static inline void btrfs_set_token_##name(struct extent_buffer *eb,	\
-					  type *s, u##bits val,		\
-                                         struct btrfs_map_token *token)	\
+static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
+					  type *s, u##bits val)		\
 {									\
 	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
-	btrfs_set_token_##bits(eb, s, offsetof(type, member), val, token); \
+	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
 }
 
 #define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cc94291fdd18..256eec4c85ae 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3354,43 +3354,40 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 
 	btrfs_init_map_token(&token, leaf);
 
-	btrfs_set_token_inode_uid(leaf, item, i_uid_read(inode), &token);
-	btrfs_set_token_inode_gid(leaf, item, i_gid_read(inode), &token);
-	btrfs_set_token_inode_size(leaf, item, BTRFS_I(inode)->disk_i_size,
-				   &token);
-	btrfs_set_token_inode_mode(leaf, item, inode->i_mode, &token);
-	btrfs_set_token_inode_nlink(leaf, item, inode->i_nlink, &token);
-
-	btrfs_set_token_timespec_sec(leaf, &item->atime,
-				     inode->i_atime.tv_sec, &token);
-	btrfs_set_token_timespec_nsec(leaf, &item->atime,
-				      inode->i_atime.tv_nsec, &token);
-
-	btrfs_set_token_timespec_sec(leaf, &item->mtime,
-				     inode->i_mtime.tv_sec, &token);
-	btrfs_set_token_timespec_nsec(leaf, &item->mtime,
-				      inode->i_mtime.tv_nsec, &token);
-
-	btrfs_set_token_timespec_sec(leaf, &item->ctime,
-				     inode->i_ctime.tv_sec, &token);
-	btrfs_set_token_timespec_nsec(leaf, &item->ctime,
-				      inode->i_ctime.tv_nsec, &token);
-
-	btrfs_set_token_timespec_sec(leaf, &item->otime,
-				     BTRFS_I(inode)->i_otime.tv_sec, &token);
-	btrfs_set_token_timespec_nsec(leaf, &item->otime,
-				      BTRFS_I(inode)->i_otime.tv_nsec, &token);
-
-	btrfs_set_token_inode_nbytes(leaf, item, inode_get_bytes(inode),
-				     &token);
-	btrfs_set_token_inode_generation(leaf, item, BTRFS_I(inode)->generation,
-					 &token);
-	btrfs_set_token_inode_sequence(leaf, item, inode_peek_iversion(inode),
-				       &token);
-	btrfs_set_token_inode_transid(leaf, item, trans->transid, &token);
-	btrfs_set_token_inode_rdev(leaf, item, inode->i_rdev, &token);
-	btrfs_set_token_inode_flags(leaf, item, BTRFS_I(inode)->flags, &token);
-	btrfs_set_token_inode_block_group(leaf, item, 0, &token);
+	btrfs_set_token_inode_uid(&token, item, i_uid_read(inode));
+	btrfs_set_token_inode_gid(&token, item, i_gid_read(inode));
+	btrfs_set_token_inode_size(&token, item, BTRFS_I(inode)->disk_i_size);
+	btrfs_set_token_inode_mode(&token, item, inode->i_mode);
+	btrfs_set_token_inode_nlink(&token, item, inode->i_nlink);
+
+	btrfs_set_token_timespec_sec(&token, &item->atime,
+				     inode->i_atime.tv_sec);
+	btrfs_set_token_timespec_nsec(&token, &item->atime,
+				      inode->i_atime.tv_nsec);
+
+	btrfs_set_token_timespec_sec(&token, &item->mtime,
+				     inode->i_mtime.tv_sec);
+	btrfs_set_token_timespec_nsec(&token, &item->mtime,
+				      inode->i_mtime.tv_nsec);
+
+	btrfs_set_token_timespec_sec(&token, &item->ctime,
+				     inode->i_ctime.tv_sec);
+	btrfs_set_token_timespec_nsec(&token, &item->ctime,
+				      inode->i_ctime.tv_nsec);
+
+	btrfs_set_token_timespec_sec(&token, &item->otime,
+				     BTRFS_I(inode)->i_otime.tv_sec);
+	btrfs_set_token_timespec_nsec(&token, &item->otime,
+				      BTRFS_I(inode)->i_otime.tv_nsec);
+
+	btrfs_set_token_inode_nbytes(&token, item, inode_get_bytes(inode));
+	btrfs_set_token_inode_generation(&token, item,
+					 BTRFS_I(inode)->generation);
+	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode));
+	btrfs_set_token_inode_transid(&token, item, trans->transid);
+	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
+	btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags);
+	btrfs_set_token_inode_block_group(&token, item, 0);
 }
 
 /*
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 7928d310f698..cebd0b5e4f37 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -38,9 +38,8 @@ static inline void put_unaligned_le8(u8 val, void *p)
  */
 
 #define DEFINE_BTRFS_SETGET_BITS(bits)					\
-u##bits btrfs_get_token_##bits(const struct extent_buffer *eb,		\
-			       const void *ptr, unsigned long off,	\
-			       struct btrfs_map_token *token)		\
+u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
+			       const void *ptr, unsigned long off)	\
 {									\
 	unsigned long part_offset = (unsigned long)ptr;			\
 	unsigned long offset = part_offset + off;			\
@@ -53,7 +52,6 @@ u##bits btrfs_get_token_##bits(const struct extent_buffer *eb,		\
 	u##bits res;							\
 									\
 	ASSERT(token);							\
-	ASSERT(token->eb == eb);					\
 									\
 	if (token->kaddr && token->offset <= offset &&			\
 	   (token->offset + PAGE_SIZE >= offset + size)) {	\
@@ -101,10 +99,9 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	res = get_unaligned_le##bits(p + off);				\
 	return res;							\
 }									\
-void btrfs_set_token_##bits(struct extent_buffer *eb,			\
+void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 			    const void *ptr, unsigned long off,		\
-			    u##bits val,				\
-			    struct btrfs_map_token *token)		\
+			    u##bits val)				\
 {									\
 	unsigned long part_offset = (unsigned long)ptr;			\
 	unsigned long offset = part_offset + off;			\
@@ -116,7 +113,6 @@ void btrfs_set_token_##bits(struct extent_buffer *eb,			\
 	int size = sizeof(u##bits);					\
 									\
 	ASSERT(token);							\
-	ASSERT(token->eb == eb);					\
 									\
 	if (token->kaddr && token->offset <= offset &&			\
 	   (token->offset + PAGE_SIZE >= offset + size)) {	\
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 39ec25518ec2..ee1c627bd618 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -509,8 +509,8 @@ static noinline int overwrite_item(struct btrfs_trans_handle *trans,
 				struct btrfs_map_token token;
 
 				btrfs_init_map_token(&token, dst_eb);
-				btrfs_set_token_inode_size(dst_eb, dst_item,
-							   ino_size, &token);
+				btrfs_set_token_inode_size(&token, dst_item,
+							   ino_size);
 			}
 			goto no_copy;
 		}
@@ -3852,44 +3852,41 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 		 * just to say 'this inode exists' and a logging
 		 * to say 'update this inode with these values'
 		 */
-		btrfs_set_token_inode_generation(leaf, item, 0, &token);
-		btrfs_set_token_inode_size(leaf, item, logged_isize, &token);
+		btrfs_set_token_inode_generation(&token, item, 0);
+		btrfs_set_token_inode_size(&token, item, logged_isize);
 	} else {
-		btrfs_set_token_inode_generation(leaf, item,
-						 BTRFS_I(inode)->generation,
-						 &token);
-		btrfs_set_token_inode_size(leaf, item, inode->i_size, &token);
-	}
-
-	btrfs_set_token_inode_uid(leaf, item, i_uid_read(inode), &token);
-	btrfs_set_token_inode_gid(leaf, item, i_gid_read(inode), &token);
-	btrfs_set_token_inode_mode(leaf, item, inode->i_mode, &token);
-	btrfs_set_token_inode_nlink(leaf, item, inode->i_nlink, &token);
-
-	btrfs_set_token_timespec_sec(leaf, &item->atime,
-				     inode->i_atime.tv_sec, &token);
-	btrfs_set_token_timespec_nsec(leaf, &item->atime,
-				      inode->i_atime.tv_nsec, &token);
-
-	btrfs_set_token_timespec_sec(leaf, &item->mtime,
-				     inode->i_mtime.tv_sec, &token);
-	btrfs_set_token_timespec_nsec(leaf, &item->mtime,
-				      inode->i_mtime.tv_nsec, &token);
-
-	btrfs_set_token_timespec_sec(leaf, &item->ctime,
-				     inode->i_ctime.tv_sec, &token);
-	btrfs_set_token_timespec_nsec(leaf, &item->ctime,
-				      inode->i_ctime.tv_nsec, &token);
-
-	btrfs_set_token_inode_nbytes(leaf, item, inode_get_bytes(inode),
-				     &token);
-
-	btrfs_set_token_inode_sequence(leaf, item,
-				       inode_peek_iversion(inode), &token);
-	btrfs_set_token_inode_transid(leaf, item, trans->transid, &token);
-	btrfs_set_token_inode_rdev(leaf, item, inode->i_rdev, &token);
-	btrfs_set_token_inode_flags(leaf, item, BTRFS_I(inode)->flags, &token);
-	btrfs_set_token_inode_block_group(leaf, item, 0, &token);
+		btrfs_set_token_inode_generation(&token, item,
+						 BTRFS_I(inode)->generation);
+		btrfs_set_token_inode_size(&token, item, inode->i_size);
+	}
+
+	btrfs_set_token_inode_uid(&token, item, i_uid_read(inode));
+	btrfs_set_token_inode_gid(&token, item, i_gid_read(inode));
+	btrfs_set_token_inode_mode(&token, item, inode->i_mode);
+	btrfs_set_token_inode_nlink(&token, item, inode->i_nlink);
+
+	btrfs_set_token_timespec_sec(&token, &item->atime,
+				     inode->i_atime.tv_sec);
+	btrfs_set_token_timespec_nsec(&token, &item->atime,
+				      inode->i_atime.tv_nsec);
+
+	btrfs_set_token_timespec_sec(&token, &item->mtime,
+				     inode->i_mtime.tv_sec);
+	btrfs_set_token_timespec_nsec(&token, &item->mtime,
+				      inode->i_mtime.tv_nsec);
+
+	btrfs_set_token_timespec_sec(&token, &item->ctime,
+				     inode->i_ctime.tv_sec);
+	btrfs_set_token_timespec_nsec(&token, &item->ctime,
+				      inode->i_ctime.tv_nsec);
+
+	btrfs_set_token_inode_nbytes(&token, item, inode_get_bytes(inode));
+
+	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode));
+	btrfs_set_token_inode_transid(&token, item, trans->transid);
+	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
+	btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags);
+	btrfs_set_token_inode_block_group(&token, item, 0);
 }
 
 static int log_inode_item(struct btrfs_trans_handle *trans,
@@ -4163,43 +4160,35 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	fi = btrfs_item_ptr(leaf, path->slots[0],
 			    struct btrfs_file_extent_item);
 
-	btrfs_set_token_file_extent_generation(leaf, fi, trans->transid,
-					       &token);
+	btrfs_set_token_file_extent_generation(&token, fi, trans->transid);
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-		btrfs_set_token_file_extent_type(leaf, fi,
-						 BTRFS_FILE_EXTENT_PREALLOC,
-						 &token);
+		btrfs_set_token_file_extent_type(&token, fi,
+						 BTRFS_FILE_EXTENT_PREALLOC);
 	else
-		btrfs_set_token_file_extent_type(leaf, fi,
-						 BTRFS_FILE_EXTENT_REG,
-						 &token);
+		btrfs_set_token_file_extent_type(&token, fi,
+						 BTRFS_FILE_EXTENT_REG);
 
 	block_len = max(em->block_len, em->orig_block_len);
 	if (em->compress_type != BTRFS_COMPRESS_NONE) {
-		btrfs_set_token_file_extent_disk_bytenr(leaf, fi,
-							em->block_start,
-							&token);
-		btrfs_set_token_file_extent_disk_num_bytes(leaf, fi, block_len,
-							   &token);
+		btrfs_set_token_file_extent_disk_bytenr(&token, fi,
+							em->block_start);
+		btrfs_set_token_file_extent_disk_num_bytes(&token, fi, block_len);
 	} else if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-		btrfs_set_token_file_extent_disk_bytenr(leaf, fi,
+		btrfs_set_token_file_extent_disk_bytenr(&token, fi,
 							em->block_start -
-							extent_offset, &token);
-		btrfs_set_token_file_extent_disk_num_bytes(leaf, fi, block_len,
-							   &token);
+							extent_offset);
+		btrfs_set_token_file_extent_disk_num_bytes(&token, fi, block_len);
 	} else {
-		btrfs_set_token_file_extent_disk_bytenr(leaf, fi, 0, &token);
-		btrfs_set_token_file_extent_disk_num_bytes(leaf, fi, 0,
-							   &token);
-	}
-
-	btrfs_set_token_file_extent_offset(leaf, fi, extent_offset, &token);
-	btrfs_set_token_file_extent_num_bytes(leaf, fi, em->len, &token);
-	btrfs_set_token_file_extent_ram_bytes(leaf, fi, em->ram_bytes, &token);
-	btrfs_set_token_file_extent_compression(leaf, fi, em->compress_type,
-						&token);
-	btrfs_set_token_file_extent_encryption(leaf, fi, 0, &token);
-	btrfs_set_token_file_extent_other_encoding(leaf, fi, 0, &token);
+		btrfs_set_token_file_extent_disk_bytenr(&token, fi, 0);
+		btrfs_set_token_file_extent_disk_num_bytes(&token, fi, 0);
+	}
+
+	btrfs_set_token_file_extent_offset(&token, fi, extent_offset);
+	btrfs_set_token_file_extent_num_bytes(&token, fi, em->len);
+	btrfs_set_token_file_extent_ram_bytes(&token, fi, em->ram_bytes);
+	btrfs_set_token_file_extent_compression(&token, fi, em->compress_type);
+	btrfs_set_token_file_extent_encryption(&token, fi, 0);
+	btrfs_set_token_file_extent_other_encoding(&token, fi, 0);
 	btrfs_mark_buffer_dirty(leaf);
 
 	btrfs_release_path(path);
-- 
2.25.0

