Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD426E8346
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjDSVRk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDSVRi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:17:38 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED85544B9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:32 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id h14so1022626qvr.7
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939052; x=1684531052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNK1ytEqynut8/xqhmlUlW7nrCYp7tXHXPwhKYLodjA=;
        b=YpEJK9uLz+UhdMUYgp3yXpsNI8cg++vqJejCxxXPeAPzzVosFLQP7rU8pHA0zJMiCM
         qz/OnerJiWaf0rWatTPPUP42g+bveLBdcDqT0h64QG0p49ltL1/gNheZ5v8lbdRcbb4I
         JSuZLWXWxqj28bIP2i2SrXaDVYbL5jZReXbD1eL94/WYPv/7fZDsmQvw1hQyrqM+r138
         6FYOKw5bk/hpgCKxnrn2oN9NGMP3hxw2njYqCaJKSGAj72bHP7EWv3Lp6MKSbUrZeeZR
         WGFiAynxPGamF7VH/At2y6+JcywAz/b6B5vMm1NuHSka2xiDy7Ccl2tgcegM8m5YtPSo
         jBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939052; x=1684531052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNK1ytEqynut8/xqhmlUlW7nrCYp7tXHXPwhKYLodjA=;
        b=dYVcX0sVn5S4ElbiV4INOOpIMZMrWxE22jZokiwPUFKIza66o3buTC39kkDJVz/qE0
         FcjmkrpdIQpTkH86Qy5HM5W4NwDWep0g+7y7C6Xhh4L/MhBT/7RIAw0WmWsykwJALYef
         NYsrCFIqYJDWkWM47Iwf54psKI5RyK4YFhrUJkwDHG9OVupvjkkh0yiK6p/MjShZqBXK
         Irooe7xVZ0q3D9TSWYvCoa0bpG68k4c5XcZwP+jM/Y7dotXTBz5LgSXmfFBf0eEqSvda
         6Ql0ZyXY/CKBAbWYdUh7mB3jy7BZtUuvwe9ZmVmOer8x4A7xBtVIwWn0REWHah3hRQmE
         7BQQ==
X-Gm-Message-State: AAQBX9dtvtZmi5y7sBYPGClTq6pV32z5j+566aJO3gQcKAq8m5YlYjgS
        Q5FnIUALndlAqcs6LswMInm+QXgym1lByGqHc2xVng==
X-Google-Smtp-Source: AKy350b537EtRlv8tmdo/etb2dAZ/NIUCi36gFySyJIRsqx9hGJAEmszX0JLjGm0mnXOnlmJFCzvwA==
X-Received: by 2002:a05:6214:27ce:b0:5ef:8c85:6c67 with SMTP id ge14-20020a05621427ce00b005ef8c856c67mr12910952qvb.52.1681939051110;
        Wed, 19 Apr 2023 14:17:31 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w5-20020a0c8e45000000b005ef5b1006c5sm2810qvb.38.2023.04.19.14.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:17:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs-progs: sync accessors.[ch] from the kernel
Date:   Wed, 19 Apr 2023 17:17:16 -0400
Message-Id: <a75bbb5a3fa02fb5790369820486afe692fdd7fa.1681938911.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938911.git.josef@toxicpanda.com>
References: <cover.1681938911.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This syncs accessors.[ch] from the kernel.  For the most part
accessors.h will remain the same, there's just some helpers that need to
be adjusted for eb->data instead of eb->pages.  Additionally accessors.c
needed to be completely updated to deal with this as well.

This is a set of files where we will likely only sync the header going
forward, and leave the c file in place as it needs to be specific to
btrfs-progs.

This forced a few "unrelated" changes

 - Using btrfs_dir_item_ftype() instead of btrfs_dir_item_type().  This
   is due to the encryption changes, and was simpler to just do in this
   patch.
 - Adjusting some of the print tree code to use the actual helpers and
   not the btrfs-progs ones.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile                   |    1 +
 check/main.c               |    4 +-
 check/mode-common.c        |    4 +-
 check/mode-lowmem.c        |    6 +-
 cmds/restore.c             |    2 +-
 include/kerncompat.h       |    6 +-
 kernel-shared/accessors.c  |  117 ++++
 kernel-shared/accessors.h  | 1087 ++++++++++++++++++++++++++++++++++++
 kernel-shared/ctree.h      |  886 +----------------------------
 kernel-shared/dir-item.c   |    8 +-
 kernel-shared/inode.c      |    2 +-
 kernel-shared/print-tree.c |   16 +-
 mkfs/common.c              |    1 +
 13 files changed, 1241 insertions(+), 899 deletions(-)
 create mode 100644 kernel-shared/accessors.c
 create mode 100644 kernel-shared/accessors.h

diff --git a/Makefile b/Makefile
index 45e2e1e6..668f4e91 100644
--- a/Makefile
+++ b/Makefile
@@ -166,6 +166,7 @@ objects = \
 	kernel-lib/raid56.o	\
 	kernel-lib/rbtree.o	\
 	kernel-lib/tables.o	\
+	kernel-shared/accessors.o	\
 	kernel-shared/backref.o \
 	kernel-shared/ctree.o	\
 	kernel-shared/delayed-ref.o	\
diff --git a/check/main.c b/check/main.c
index b5748d85..5683fb1b 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1434,7 +1434,7 @@ static int process_dir_item(struct extent_buffer *eb,
 		btrfs_dir_item_key_to_cpu(eb, di, &location);
 		name_len = btrfs_dir_name_len(eb, di);
 		data_len = btrfs_dir_data_len(eb, di);
-		filetype = btrfs_dir_type(eb, di);
+		filetype = btrfs_dir_ftype(eb, di);
 
 		rec->found_size += name_len;
 		if (cur + sizeof(*di) + name_len > total ||
@@ -2135,7 +2135,7 @@ static int add_missing_dir_index(struct btrfs_root *root,
 	disk_key.offset = 0;
 
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_type(leaf, dir_item, imode_to_type(rec->imode));
+	btrfs_set_dir_flags(leaf, dir_item, imode_to_type(rec->imode));
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, backref->namelen);
 	name_ptr = (unsigned long)(dir_item + 1);
diff --git a/check/mode-common.c b/check/mode-common.c
index ef272368..412a9fd5 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -764,7 +764,7 @@ static int find_file_type_dir_index(struct btrfs_root *root, u64 ino, u64 dirid,
 	if (location.objectid != ino || location.type != BTRFS_INODE_ITEM_KEY ||
 	    location.offset != 0)
 		goto out;
-	filetype = btrfs_dir_type(path.nodes[0], di);
+	filetype = btrfs_dir_ftype(path.nodes[0], di);
 	if (filetype >= BTRFS_FT_MAX || filetype == BTRFS_FT_UNKNOWN)
 		goto out;
 	len = min_t(u32, BTRFS_NAME_LEN,
@@ -823,7 +823,7 @@ static int find_file_type_dir_item(struct btrfs_root *root, u64 ino, u64 dirid,
 		    location.type != BTRFS_INODE_ITEM_KEY ||
 		    location.offset != 0)
 			continue;
-		filetype = btrfs_dir_type(path.nodes[0], di);
+		filetype = btrfs_dir_ftype(path.nodes[0], di);
 		if (filetype >= BTRFS_FT_MAX || filetype == BTRFS_FT_UNKNOWN)
 			continue;
 		len = min_t(u32, BTRFS_NAME_LEN,
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 3cf8d97f..18eac047 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -868,7 +868,7 @@ loop:
 		    location.offset != 0)
 			goto next;
 
-		filetype = btrfs_dir_type(node, di);
+		filetype = btrfs_dir_ftype(node, di);
 		if (file_type != filetype)
 			goto next;
 
@@ -966,7 +966,7 @@ static int find_dir_item(struct btrfs_root *root, struct btrfs_key *key,
 		    location.offset != location_key->offset)
 			goto next;
 
-		filetype = btrfs_dir_type(node, di);
+		filetype = btrfs_dir_ftype(node, di);
 		if (file_type != filetype)
 			goto next;
 
@@ -1759,7 +1759,7 @@ begin:
 		(*size) += name_len;
 		read_extent_buffer(node, namebuf, (unsigned long)(di + 1),
 				   len);
-		filetype = btrfs_dir_type(node, di);
+		filetype = btrfs_dir_ftype(node, di);
 
 		if (di_key->type == BTRFS_DIR_ITEM_KEY &&
 		    di_key->offset != btrfs_name_hash(namebuf, len)) {
diff --git a/cmds/restore.c b/cmds/restore.c
index 02ff5e6a..da5bafd1 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -993,7 +993,7 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 		name_len = btrfs_dir_name_len(leaf, dir_item);
 		read_extent_buffer(leaf, filename, name_ptr, name_len);
 		filename[name_len] = '\0';
-		type = btrfs_dir_type(leaf, dir_item);
+		type = btrfs_dir_ftype(leaf, dir_item);
 		btrfs_dir_item_key_to_cpu(leaf, dir_item, &location);
 
 		/* full path from root of btrfs being restored */
diff --git a/include/kerncompat.h b/include/kerncompat.h
index d7eba985..42e81223 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -505,10 +505,6 @@ struct __una_u16 { __le16 x; } __attribute__((__packed__));
 struct __una_u32 { __le32 x; } __attribute__((__packed__));
 struct __una_u64 { __le64 x; } __attribute__((__packed__));
 
-#define get_unaligned_le8(p) (*((u8 *)(p)))
-#define get_unaligned_8(p) (*((u8 *)(p)))
-#define put_unaligned_le8(val,p) ((*((u8 *)(p))) = (val))
-#define put_unaligned_8(val,p) ((*((u8 *)(p))) = (val))
 #define get_unaligned_le16(p) le16_to_cpu(((const struct __una_u16 *)(p))->x)
 #define get_unaligned_16(p) (((const struct __una_u16 *)(p))->x)
 #define put_unaligned_le16(val,p) (((struct __una_u16 *)(p))->x = cpu_to_le16(val))
@@ -582,4 +578,6 @@ static inline bool sb_rdonly(struct super_block *sb)
 	return false;
 }
 
+#define unlikely(cond) (cond)
+
 #endif
diff --git a/kernel-shared/accessors.c b/kernel-shared/accessors.c
new file mode 100644
index 00000000..06c976a6
--- /dev/null
+++ b/kernel-shared/accessors.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2007 Oracle.  All rights reserved.
+ */
+
+#include "kerncompat.h"
+#include "messages.h"
+#include "ctree.h"
+#include "accessors.h"
+
+static bool check_setget_bounds(const struct extent_buffer *eb,
+				const void *ptr, unsigned off, int size)
+{
+	const unsigned long member_offset = (unsigned long)ptr + off;
+
+	if (unlikely(member_offset + size > eb->len)) {
+		btrfs_warn(eb->fs_info,
+		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
+			(member_offset > eb->len ? "start" : "end"),
+			(unsigned long)ptr, eb->start, member_offset, size);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * MODIFIED:
+ *  - We don't have eb->pages.
+ */
+void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *eb)
+{
+	token->eb = eb;
+	token->kaddr = eb->data;
+	token->offset = 0;
+}
+
+/*
+ * MODIFIED:
+ *  - We don't have eb->pages, simply wrap the set/get helpers.
+ */
+
+/*
+ * Macro templates that define helpers to read/write extent buffer data of a
+ * given size, that are also used via ctree.h for access to item members by
+ * specialized helpers.
+ *
+ * Generic helpers:
+ * - btrfs_set_8 (for 8/16/32/64)
+ * - btrfs_get_8 (for 8/16/32/64)
+ *
+ * Generic helpers with a token (cached address of the most recently accessed
+ * page):
+ * - btrfs_set_token_8 (for 8/16/32/64)
+ * - btrfs_get_token_8 (for 8/16/32/64)
+ *
+ * The set/get functions handle data spanning two pages transparently, in case
+ * metadata block size is larger than page.  Every pointer to metadata items is
+ * an offset into the extent buffer page array, cast to a specific type.  This
+ * gives us all the type checking.
+ *
+ * The extent buffer pages stored in the array pages do not form a contiguous
+ * phyusical range, but the API functions assume the linear offset to the range
+ * from 0 to metadata node size.
+ */
+
+#define DEFINE_BTRFS_SETGET_BITS(bits)					\
+u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
+			       const void *ptr, unsigned long off)	\
+{									\
+	const unsigned long member_offset = (unsigned long)ptr + off;	\
+	const int size = sizeof(u##bits);				\
+	ASSERT(token);							\
+	ASSERT(token->kaddr);						\
+	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
+	return get_unaligned_le##bits(token->kaddr + member_offset);	\
+}									\
+u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
+			 const void *ptr, unsigned long off)		\
+{									\
+	const unsigned long member_offset = (unsigned long)ptr + off;	\
+	const int size = sizeof(u##bits);				\
+	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
+	return get_unaligned_le##bits(eb->data + member_offset);	\
+}									\
+void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
+			    const void *ptr, unsigned long off,		\
+			    u##bits val)				\
+{									\
+	unsigned long member_offset = (unsigned long)ptr + off;		\
+	const int size = sizeof(u##bits);				\
+	ASSERT(token);							\
+	ASSERT(token->kaddr);						\
+	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
+	put_unaligned_le##bits(val, token->kaddr + member_offset);	\
+}									\
+void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
+		      unsigned long off, u##bits val)			\
+{									\
+	unsigned long member_offset = (unsigned long)ptr + off;		\
+	const int size = sizeof(u##bits);				\
+	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
+	put_unaligned_le##bits(val, (void *)eb->data + member_offset);	\
+}
+
+DEFINE_BTRFS_SETGET_BITS(8)
+DEFINE_BTRFS_SETGET_BITS(16)
+DEFINE_BTRFS_SETGET_BITS(32)
+DEFINE_BTRFS_SETGET_BITS(64)
+
+void btrfs_node_key(const struct extent_buffer *eb,
+		    struct btrfs_disk_key *disk_key, int nr)
+{
+	unsigned long ptr = btrfs_node_key_ptr_offset(eb, nr);
+	read_eb_member(eb, (struct btrfs_key_ptr *)ptr,
+		       struct btrfs_key_ptr, key, disk_key);
+}
diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
new file mode 100644
index 00000000..667dcbb8
--- /dev/null
+++ b/kernel-shared/accessors.h
@@ -0,0 +1,1087 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_ACCESSORS_H
+#define BTRFS_ACCESSORS_H
+
+struct btrfs_map_token {
+	struct extent_buffer *eb;
+	char *kaddr;
+	unsigned long offset;
+};
+
+void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *eb);
+
+/*
+ * Some macros to generate set/get functions for the struct fields.  This
+ * assumes there is a lefoo_to_cpu for every type, so lets make a simple one
+ * for u8:
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
+	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	return btrfs_get_##bits(eb, s, offsetof(type, member));		\
+}									\
+static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
+				    u##bits val)			\
+{									\
+	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
+}									\
+static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
+					 const type *s)			\
+{									\
+	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
+}									\
+static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
+					  type *s, u##bits val)		\
+{									\
+	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
+}
+
+/*
+ * MODIFIED:
+ *  - We have eb->data, not eb->pages[0]
+ */
+#define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
+static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
+{									\
+	const type *p = (type *)eb->data;				\
+	return get_unaligned_le##bits(&p->member);			\
+}									\
+static inline void btrfs_set_##name(const struct extent_buffer *eb,	\
+				    u##bits val)			\
+{									\
+	type *p = (type *)eb->data;					\
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
+static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
+					   struct btrfs_dev_item *s)
+{
+	static_assert(sizeof(u64) ==
+		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
+	return btrfs_get_64(eb, s, offsetof(struct btrfs_dev_item,
+					    total_bytes));
+}
+
+/*
+ * MODIFIED
+ *  - Removed WARN_ON(!IS_ALIGNED(val, eb->fs_info->sectorsize));
+ */
+static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
+						struct btrfs_dev_item *s,
+						u64 val)
+{
+	static_assert(sizeof(u64) ==
+		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
+	btrfs_set_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes), val);
+}
+
+BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_FUNCS(device_bytes_used, struct btrfs_dev_item, bytes_used, 64);
+BTRFS_SETGET_FUNCS(device_io_align, struct btrfs_dev_item, io_align, 32);
+BTRFS_SETGET_FUNCS(device_io_width, struct btrfs_dev_item, io_width, 32);
+BTRFS_SETGET_FUNCS(device_start_offset, struct btrfs_dev_item, start_offset, 64);
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
+BTRFS_SETGET_STACK_FUNCS(stack_device_group, struct btrfs_dev_item, dev_group, 32);
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
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_io_align, struct btrfs_chunk, io_align, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_io_width, struct btrfs_chunk, io_width, 32);
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
+static inline struct btrfs_stripe *btrfs_stripe_nr(struct btrfs_chunk *c, int nr)
+{
+	unsigned long offset = (unsigned long)c;
+
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
+static inline void btrfs_set_stripe_offset_nr(struct extent_buffer *eb,
+					      struct btrfs_chunk *c, int nr,
+					      u64 val)
+{
+	btrfs_set_stripe_offset(eb, btrfs_stripe_nr(c, nr), val);
+}
+
+static inline u64 btrfs_stripe_devid_nr(const struct extent_buffer *eb,
+					 struct btrfs_chunk *c, int nr)
+{
+	return btrfs_stripe_devid(eb, btrfs_stripe_nr(c, nr));
+}
+
+static inline void btrfs_set_stripe_devid_nr(struct extent_buffer *eb,
+					     struct btrfs_chunk *c, int nr,
+					     u64 val)
+{
+       btrfs_set_stripe_devid(eb, btrfs_stripe_nr(c, nr), val);
+}
+
+/* struct btrfs_block_group_item */
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_used, struct btrfs_block_group_item,
+			 used, 64);
+BTRFS_SETGET_FUNCS(block_group_used, struct btrfs_block_group_item, used, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_chunk_objectid,
+			struct btrfs_block_group_item, chunk_objectid, 64);
+
+BTRFS_SETGET_FUNCS(block_group_chunk_objectid,
+		   struct btrfs_block_group_item, chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(block_group_flags, struct btrfs_block_group_item, flags, 64);
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
+BTRFS_SETGET_STACK_FUNCS(stack_inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_ref_index, struct btrfs_inode_ref, index, 64);
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
+BTRFS_SETGET_STACK_FUNCS(stack_inode_nbytes, struct btrfs_inode_item, nbytes, 64);
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
+BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent, chunk_tree, 64);
+BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
+		   chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(dev_extent_chunk_offset, struct btrfs_dev_extent,
+		   chunk_offset, 64);
+BTRFS_SETGET_FUNCS(dev_extent_length, struct btrfs_dev_extent, length, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_extent_chunk_tree, struct btrfs_dev_extent,
+			 chunk_tree, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_extent_chunk_objectid, struct btrfs_dev_extent,
+			 chunk_objectid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_extent_chunk_offset, struct btrfs_dev_extent,
+			 chunk_offset, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dev_extent_length, struct btrfs_dev_extent, length, 64);
+
+BTRFS_SETGET_FUNCS(extent_refs, struct btrfs_extent_item, refs, 64);
+BTRFS_SETGET_FUNCS(extent_generation, struct btrfs_extent_item, generation, 64);
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
+BTRFS_SETGET_FUNCS(extent_data_ref_root, struct btrfs_extent_data_ref, root, 64);
+BTRFS_SETGET_FUNCS(extent_data_ref_objectid, struct btrfs_extent_data_ref,
+		   objectid, 64);
+BTRFS_SETGET_FUNCS(extent_data_ref_offset, struct btrfs_extent_data_ref,
+		   offset, 64);
+BTRFS_SETGET_FUNCS(extent_data_ref_count, struct btrfs_extent_data_ref, count, 32);
+
+BTRFS_SETGET_FUNCS(shared_data_ref_count, struct btrfs_shared_data_ref, count, 32);
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
+BTRFS_SETGET_STACK_FUNCS(stack_key_blockptr, struct btrfs_key_ptr, blockptr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_key_generation, struct btrfs_key_ptr,
+			 generation, 64);
+
+static inline u64 btrfs_node_blockptr(const struct extent_buffer *eb, int nr)
+{
+	unsigned long ptr;
+
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	return btrfs_key_blockptr(eb, (struct btrfs_key_ptr *)ptr);
+}
+
+static inline void btrfs_set_node_blockptr(const struct extent_buffer *eb,
+					   int nr, u64 val)
+{
+	unsigned long ptr;
+
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	btrfs_set_key_blockptr(eb, (struct btrfs_key_ptr *)ptr, val);
+}
+
+static inline u64 btrfs_node_ptr_generation(const struct extent_buffer *eb, int nr)
+{
+	unsigned long ptr;
+
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	return btrfs_key_generation(eb, (struct btrfs_key_ptr *)ptr);
+}
+
+static inline void btrfs_set_node_ptr_generation(const struct extent_buffer *eb,
+						 int nr, u64 val)
+{
+	unsigned long ptr;
+
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	btrfs_set_key_generation(eb, (struct btrfs_key_ptr *)ptr, val);
+}
+
+static inline unsigned long btrfs_node_key_ptr_offset(const struct extent_buffer *eb, int nr)
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
+
+	ptr = btrfs_node_key_ptr_offset(eb, nr);
+	write_eb_member(eb, (struct btrfs_key_ptr *)ptr,
+		        struct btrfs_key_ptr, key, disk_key);
+}
+
+/* struct btrfs_item */
+BTRFS_SETGET_FUNCS(raw_item_offset, struct btrfs_item, offset, 32);
+BTRFS_SETGET_FUNCS(raw_item_size, struct btrfs_item, size, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_item_offset, struct btrfs_item, offset, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_item_size, struct btrfs_item, size, 32);
+
+static inline unsigned long btrfs_item_nr_offset(const struct extent_buffer *eb, int nr)
+{
+	return offsetof(struct btrfs_leaf, items) +
+		sizeof(struct btrfs_item) * nr;
+}
+
+static inline struct btrfs_item *btrfs_item_nr(const struct extent_buffer *eb, int nr)
+{
+	return (struct btrfs_item *)btrfs_item_nr_offset(eb, nr);
+}
+
+#define BTRFS_ITEM_SETGET_FUNCS(member)						\
+static inline u32 btrfs_item_##member(const struct extent_buffer *eb, int slot)	\
+{										\
+	return btrfs_raw_item_##member(eb, btrfs_item_nr(eb, slot));		\
+}										\
+static inline void btrfs_set_item_##member(const struct extent_buffer *eb,	\
+					   int slot, u32 val)			\
+{										\
+	btrfs_set_raw_item_##member(eb, btrfs_item_nr(eb, slot), val);		\
+}										\
+static inline u32 btrfs_token_item_##member(struct btrfs_map_token *token,	\
+					    int slot)				\
+{										\
+	struct btrfs_item *item = btrfs_item_nr(token->eb, slot);		\
+	return btrfs_token_raw_item_##member(token, item);			\
+}										\
+static inline void btrfs_set_token_item_##member(struct btrfs_map_token *token,	\
+						 int slot, u32 val)		\
+{										\
+	struct btrfs_item *item = btrfs_item_nr(token->eb, slot);		\
+	btrfs_set_token_raw_item_##member(token, item, val);			\
+}
+
+BTRFS_ITEM_SETGET_FUNCS(offset)
+BTRFS_ITEM_SETGET_FUNCS(size);
+
+static inline u32 btrfs_item_data_end(const struct extent_buffer *eb, int nr)
+{
+	return btrfs_item_offset(eb, nr) + btrfs_item_size(eb, nr);
+}
+
+static inline void btrfs_item_key(const struct extent_buffer *eb,
+			   struct btrfs_disk_key *disk_key, int nr)
+{
+	struct btrfs_item *item = btrfs_item_nr(eb, nr);
+
+	read_eb_member(eb, item, struct btrfs_item, key, disk_key);
+}
+
+static inline void btrfs_set_item_key(struct extent_buffer *eb,
+				      struct btrfs_disk_key *disk_key, int nr)
+{
+	struct btrfs_item *item = btrfs_item_nr(eb, nr);
+
+	write_eb_member(eb, item, struct btrfs_item, key, disk_key);
+}
+
+BTRFS_SETGET_FUNCS(dir_log_end, struct btrfs_dir_log_item, end, 64);
+
+/* struct btrfs_root_ref */
+BTRFS_SETGET_FUNCS(root_ref_dirid, struct btrfs_root_ref, dirid, 64);
+BTRFS_SETGET_FUNCS(root_ref_sequence, struct btrfs_root_ref, sequence, 64);
+BTRFS_SETGET_FUNCS(root_ref_name_len, struct btrfs_root_ref, name_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_root_ref_dirid, struct btrfs_root_ref, dirid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_root_ref_sequence, struct btrfs_root_ref, sequence, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_root_ref_name_len, struct btrfs_root_ref, name_len, 16);
+
+/* struct btrfs_dir_item */
+BTRFS_SETGET_FUNCS(dir_data_len, struct btrfs_dir_item, data_len, 16);
+BTRFS_SETGET_FUNCS(dir_flags, struct btrfs_dir_item, type, 8);
+BTRFS_SETGET_FUNCS(dir_name_len, struct btrfs_dir_item, name_len, 16);
+BTRFS_SETGET_FUNCS(dir_transid, struct btrfs_dir_item, transid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_flags, struct btrfs_dir_item, type, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_data_len, struct btrfs_dir_item, data_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_name_len, struct btrfs_dir_item, name_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_transid, struct btrfs_dir_item, transid, 64);
+
+static inline u8 btrfs_dir_ftype(const struct extent_buffer *eb,
+				 const struct btrfs_dir_item *item)
+{
+	return btrfs_dir_flags_to_ftype(btrfs_dir_flags(eb, item));
+}
+
+static inline u8 btrfs_stack_dir_ftype(const struct btrfs_dir_item *item)
+{
+	return btrfs_dir_flags_to_ftype(btrfs_stack_dir_flags(item));
+}
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
+BTRFS_SETGET_STACK_FUNCS(disk_key_objectid, struct btrfs_disk_key, objectid, 64);
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
+
+	btrfs_node_key(eb, &disk_key, nr);
+	btrfs_disk_key_to_cpu(key, &disk_key);
+}
+
+static inline void btrfs_item_key_to_cpu(const struct extent_buffer *eb,
+					 struct btrfs_key *key, int nr)
+{
+	struct btrfs_disk_key disk_key;
+
+	btrfs_item_key(eb, &disk_key, nr);
+	btrfs_disk_key_to_cpu(key, &disk_key);
+}
+
+static inline void btrfs_dir_item_key_to_cpu(const struct extent_buffer *eb,
+					     const struct btrfs_dir_item *item,
+					     struct btrfs_key *key)
+{
+	struct btrfs_disk_key disk_key;
+
+	btrfs_dir_item_key(eb, item, &disk_key);
+	btrfs_disk_key_to_cpu(key, &disk_key);
+}
+
+#endif
+
+/* struct btrfs_header */
+BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header, generation, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
+BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
+			 generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header, nritems, 32);
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
+
+	btrfs_set_header_flags(eb, flags | flag);
+}
+
+static inline void btrfs_clear_header_flag(struct extent_buffer *eb, u64 flag)
+{
+	u64 flags = btrfs_header_flags(eb);
+
+	btrfs_set_header_flags(eb, flags & ~flag);
+}
+
+static inline int btrfs_header_backref_rev(const struct extent_buffer *eb)
+{
+	u64 flags = btrfs_header_flags(eb);
+
+	return flags >> BTRFS_BACKREF_REV_SHIFT;
+}
+
+static inline void btrfs_set_header_backref_rev(struct extent_buffer *eb, int rev)
+{
+	u64 flags = btrfs_header_flags(eb);
+
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
+BTRFS_SETGET_FUNCS(disk_root_generation, struct btrfs_root_item, generation, 64);
+BTRFS_SETGET_FUNCS(disk_root_refs, struct btrfs_root_item, refs, 32);
+BTRFS_SETGET_FUNCS(disk_root_bytenr, struct btrfs_root_item, bytenr, 64);
+BTRFS_SETGET_FUNCS(disk_root_level, struct btrfs_root_item, level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(root_generation, struct btrfs_root_item, generation, 64);
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
+BTRFS_SETGET_STACK_FUNCS(root_ctransid, struct btrfs_root_item, ctransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_otransid, struct btrfs_root_item, otransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_stransid, struct btrfs_root_item, stransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_rtransid, struct btrfs_root_item, rtransid, 64);
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
+					  struct btrfs_balance_item *bi,
+					  const struct btrfs_disk_balance_args *ba)
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
+					  struct btrfs_balance_item *bi,
+					  const struct btrfs_disk_balance_args *ba)
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
+					 struct btrfs_balance_item *bi,
+					 const struct btrfs_disk_balance_args *ba)
+{
+	write_eb_member(eb, bi, struct btrfs_balance_item, sys, ba);
+}
+
+static inline void btrfs_disk_balance_args_to_cpu(struct btrfs_balance_args *cpu,
+			       const struct btrfs_disk_balance_args *disk)
+{
+	memset(cpu, 0, sizeof(*cpu));
+
+	cpu->profiles = le64_to_cpu(disk->profiles);
+	cpu->usage = le64_to_cpu(disk->usage);
+	cpu->devid = le64_to_cpu(disk->devid);
+	cpu->pstart = le64_to_cpu(disk->pstart);
+	cpu->pend = le64_to_cpu(disk->pend);
+	cpu->vstart = le64_to_cpu(disk->vstart);
+	cpu->vend = le64_to_cpu(disk->vend);
+	cpu->target = le64_to_cpu(disk->target);
+	cpu->flags = le64_to_cpu(disk->flags);
+	cpu->limit = le64_to_cpu(disk->limit);
+	cpu->stripes_min = le32_to_cpu(disk->stripes_min);
+	cpu->stripes_max = le32_to_cpu(disk->stripes_max);
+}
+
+static inline void btrfs_cpu_balance_args_to_disk(
+				struct btrfs_disk_balance_args *disk,
+				const struct btrfs_balance_args *cpu)
+{
+	memset(disk, 0, sizeof(*disk));
+
+	disk->profiles = cpu_to_le64(cpu->profiles);
+	disk->usage = cpu_to_le64(cpu->usage);
+	disk->devid = cpu_to_le64(cpu->devid);
+	disk->pstart = cpu_to_le64(cpu->pstart);
+	disk->pend = cpu_to_le64(cpu->pend);
+	disk->vstart = cpu_to_le64(cpu->vstart);
+	disk->vend = cpu_to_le64(cpu->vend);
+	disk->target = cpu_to_le64(cpu->target);
+	disk->flags = cpu_to_le64(cpu->flags);
+	disk->limit = cpu_to_le64(cpu->limit);
+	disk->stripes_min = cpu_to_le32(cpu->stripes_min);
+	disk->stripes_max = cpu_to_le32(cpu->stripes_max);
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
+BTRFS_SETGET_STACK_FUNCS(super_log_root, struct btrfs_super_block, log_root, 64);
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
+BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
+			 nr_global_roots, 64);
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
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_generation,
+			 struct btrfs_qgroup_status_item, generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_version,
+			 struct btrfs_qgroup_status_item, version, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_flags,
+			 struct btrfs_qgroup_status_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_rescan,
+			 struct btrfs_qgroup_status_item, rescan, 64);
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
+BTRFS_SETGET_FUNCS(qgroup_limit_flags, struct btrfs_qgroup_limit_item, flags, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_max_rfer, struct btrfs_qgroup_limit_item,
+		   max_rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_max_excl, struct btrfs_qgroup_limit_item,
+		   max_excl, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_rsv_rfer, struct btrfs_qgroup_limit_item,
+		   rsv_rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_rsv_excl, struct btrfs_qgroup_limit_item,
+		   rsv_excl, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_flags,
+			 struct btrfs_qgroup_limit_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_rfer,
+			 struct btrfs_qgroup_limit_item, max_rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_excl,
+			 struct btrfs_qgroup_limit_item, max_excl, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_rfer,
+			 struct btrfs_qgroup_limit_item, rsv_rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_excl,
+			 struct btrfs_qgroup_limit_item, rsv_excl, 64);
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
+/* btrfs_verity_descriptor_item */
+BTRFS_SETGET_FUNCS(verity_descriptor_encryption, struct btrfs_verity_descriptor_item,
+		   encryption, 8);
+BTRFS_SETGET_FUNCS(verity_descriptor_size, struct btrfs_verity_descriptor_item,
+		   size, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
+			 struct btrfs_verity_descriptor_item, encryption, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
+			 struct btrfs_verity_descriptor_item, size, 64);
+
+/* Cast into the data area of the leaf. */
+#define btrfs_item_ptr(leaf, slot, type)				\
+	((type *)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)))
+
+#define btrfs_item_ptr_offset(leaf, slot)				\
+	((unsigned long)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)))
+
+#endif
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 1ac6ee3f..7a17dbe0 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -27,6 +27,7 @@
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
+#include "accessors.h"
 
 struct btrfs_root;
 struct btrfs_trans_handle;
@@ -638,254 +639,16 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
  */
 #define BTRFS_STRING_ITEM_KEY	253
 
-#define read_eb_member(eb, ptr, type, member, result) (			\
-	read_extent_buffer(eb, (char *)(result),			\
-			   ((unsigned long)(ptr)) +			\
-			    offsetof(type, member),			\
-			   sizeof(((type *)0)->member)))
-
-#define write_eb_member(eb, ptr, type, member, result) (		\
-	write_extent_buffer(eb, (char *)(result),			\
-			   ((unsigned long)(ptr)) +			\
-			    offsetof(type, member),			\
-			   sizeof(((type *)0)->member)))
-
-#define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
-static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
-{									\
-	const struct btrfs_header *h = (struct btrfs_header *)eb->data;	\
-	return le##bits##_to_cpu(h->member);				\
-}									\
-static inline void btrfs_set_##name(struct extent_buffer *eb,		\
-				    u##bits val)			\
-{									\
-	struct btrfs_header *h = (struct btrfs_header *)eb->data;	\
-	h->member = cpu_to_le##bits(val);				\
-}
-
-#define BTRFS_SETGET_FUNCS(name, type, member, bits)			\
-static inline u##bits btrfs_##name(const struct extent_buffer *eb,	\
-				   const type *s)			\
-{									\
-	unsigned long offset = (unsigned long)s;			\
-	const type *p = (type *) (eb->data + offset);			\
-	return get_unaligned_le##bits(&p->member);			\
-}									\
-static inline void btrfs_set_##name(struct extent_buffer *eb,		\
-				    type *s, u##bits val)		\
-{									\
-	unsigned long offset = (unsigned long)s;			\
-	type *p = (type *) (eb->data + offset);				\
-	put_unaligned_le##bits(val, &p->member);			\
-}
-
-#define BTRFS_SETGET_STACK_FUNCS(name, type, member, bits)		\
-static inline u##bits btrfs_##name(const type *s)			\
-{									\
-	return le##bits##_to_cpu(s->member);				\
-}									\
-static inline void btrfs_set_##name(type *s, u##bits val)		\
-{									\
-	s->member = cpu_to_le##bits(val);				\
-}
-
-BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
-BTRFS_SETGET_FUNCS(device_total_bytes, struct btrfs_dev_item, total_bytes, 64);
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
-static inline char *btrfs_device_uuid(struct btrfs_dev_item *d)
-{
-	return (char *)d + offsetof(struct btrfs_dev_item, uuid);
-}
-
-static inline char *btrfs_device_fsid(struct btrfs_dev_item *d)
-{
-	return (char *)d + offsetof(struct btrfs_dev_item, fsid);
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
-static inline u64 btrfs_stripe_offset_nr(struct extent_buffer *eb,
-					 struct btrfs_chunk *c, int nr)
-{
-	return btrfs_stripe_offset(eb, btrfs_stripe_nr(c, nr));
-}
-
-static inline void btrfs_set_stripe_offset_nr(struct extent_buffer *eb,
-					     struct btrfs_chunk *c, int nr,
-					     u64 val)
-{
-	btrfs_set_stripe_offset(eb, btrfs_stripe_nr(c, nr), val);
-}
-
-static inline u64 btrfs_stripe_devid_nr(struct extent_buffer *eb,
-					 struct btrfs_chunk *c, int nr)
+static inline unsigned long btrfs_header_fsid(void)
 {
-	return btrfs_stripe_devid(eb, btrfs_stripe_nr(c, nr));
+	return offsetof(struct btrfs_header, fsid);
 }
 
-static inline void btrfs_set_stripe_devid_nr(struct extent_buffer *eb,
-					     struct btrfs_chunk *c, int nr,
-					     u64 val)
+static inline unsigned long btrfs_header_chunk_tree_uuid(struct extent_buffer *eb)
 {
-	btrfs_set_stripe_devid(eb, btrfs_stripe_nr(c, nr), val);
+	return offsetof(struct btrfs_header, chunk_tree_uuid);
 }
 
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
-/* extent tree v2 uses chunk_objectid for the global tree id. */
-BTRFS_SETGET_STACK_FUNCS(stack_block_group_global_tree_id,
-			 struct btrfs_block_group_item, chunk_objectid, 64);
-BTRFS_SETGET_FUNCS(block_group_global_tree_id, struct btrfs_block_group_item,
-		   chunk_objectid, 64);
-
-/* struct btrfs_free_space_info */
-BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
-		   extent_count, 32);
-BTRFS_SETGET_FUNCS(free_space_flags, struct btrfs_free_space_info, flags, 32);
-
-/* struct btrfs_inode_ref */
-BTRFS_SETGET_FUNCS(inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
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
-
-BTRFS_SETGET_STACK_FUNCS(stack_inode_generation,
-			 struct btrfs_inode_item, generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_sequence,
-			 struct btrfs_inode_item, sequence, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_transid,
-			 struct btrfs_inode_item, transid, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_size,
-			 struct btrfs_inode_item, size, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_nbytes,
-			 struct btrfs_inode_item, nbytes, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_block_group,
-			 struct btrfs_inode_item, block_group, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_nlink,
-			 struct btrfs_inode_item, nlink, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_uid,
-			 struct btrfs_inode_item, uid, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_gid,
-			 struct btrfs_inode_item, gid, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_mode,
-			 struct btrfs_inode_item, mode, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_rdev,
-			 struct btrfs_inode_item, rdev, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_inode_flags,
-			 struct btrfs_inode_item, flags, 64);
-
 static inline struct btrfs_timespec *
 btrfs_inode_atime(struct btrfs_inode_item *inode_item)
 {
@@ -918,399 +681,6 @@ btrfs_inode_otime(struct btrfs_inode_item *inode_item)
 	return (struct btrfs_timespec *)ptr;
 }
 
-BTRFS_SETGET_FUNCS(timespec_sec, struct btrfs_timespec, sec, 64);
-BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec,
-			 sec, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec,
-			 nsec, 32);
-
-/* struct btrfs_dev_extent */
-BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent,
-		   chunk_tree, 64);
-BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
-		   chunk_objectid, 64);
-BTRFS_SETGET_FUNCS(dev_extent_chunk_offset, struct btrfs_dev_extent,
-		   chunk_offset, 64);
-BTRFS_SETGET_FUNCS(dev_extent_length, struct btrfs_dev_extent, length, 64);
-
-BTRFS_SETGET_STACK_FUNCS(stack_dev_extent_length, struct btrfs_dev_extent,
-			 length, 64);
-
-static inline u8 *btrfs_dev_extent_chunk_tree_uuid(struct btrfs_dev_extent *dev)
-{
-	unsigned long ptr = offsetof(struct btrfs_dev_extent, chunk_tree_uuid);
-	return (u8 *)((unsigned long)dev + ptr);
-}
-
-
-/* struct btrfs_extent_item */
-BTRFS_SETGET_FUNCS(extent_refs, struct btrfs_extent_item, refs, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_extent_refs, struct btrfs_extent_item, refs, 64);
-BTRFS_SETGET_FUNCS(extent_generation, struct btrfs_extent_item,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(extent_flags, struct btrfs_extent_item, flags, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_extent_flags, struct btrfs_extent_item, flags, 64);
-
-BTRFS_SETGET_FUNCS(extent_refs_v0, struct btrfs_extent_item_v0, refs, 32);
-
-BTRFS_SETGET_FUNCS(tree_block_level, struct btrfs_tree_block_info, level, 8);
-
-static inline void btrfs_tree_block_key(struct extent_buffer *eb,
-					struct btrfs_tree_block_info *item,
-					struct btrfs_disk_key *key)
-{
-	read_eb_member(eb, item, struct btrfs_tree_block_info, key, key);
-}
-
-static inline void btrfs_set_tree_block_key(struct extent_buffer *eb,
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
-BTRFS_SETGET_STACK_FUNCS(stack_extent_inline_ref_type,
-			 struct btrfs_extent_inline_ref, type, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_extent_inline_ref_offset,
-			 struct btrfs_extent_inline_ref, offset, 64);
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
-	BUG();
-	return 0;
-}
-
-/* struct btrfs_node */
-BTRFS_SETGET_FUNCS(key_blockptr, struct btrfs_key_ptr, blockptr, 64);
-BTRFS_SETGET_FUNCS(key_generation, struct btrfs_key_ptr, generation, 64);
-
-static inline unsigned long btrfs_node_key_ptr_offset(const struct extent_buffer *eb, int nr)
-{
-	return offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
-}
-
-static inline struct btrfs_key_ptr *btrfs_node_key_ptr(const struct extent_buffer *eb, int nr)
-{
-	return (struct btrfs_key_ptr *)btrfs_node_key_ptr_offset(eb, nr);
-}
-
-static inline u64 btrfs_node_blockptr(struct extent_buffer *eb, int nr)
-{
-	return btrfs_key_blockptr(eb, btrfs_node_key_ptr(eb, nr));
-}
-
-static inline void btrfs_set_node_blockptr(struct extent_buffer *eb,
-					   int nr, u64 val)
-{
-	btrfs_set_key_blockptr(eb, btrfs_node_key_ptr(eb, nr), val);
-}
-
-static inline u64 btrfs_node_ptr_generation(struct extent_buffer *eb, int nr)
-{
-	return btrfs_key_generation(eb, btrfs_node_key_ptr(eb, nr));
-}
-
-static inline void btrfs_set_node_ptr_generation(struct extent_buffer *eb,
-						 int nr, u64 val)
-{
-	btrfs_set_key_generation(eb, btrfs_node_key_ptr(eb, nr), val);
-}
-
-static inline void btrfs_node_key(struct extent_buffer *eb,
-				  struct btrfs_disk_key *disk_key, int nr)
-{
-	read_eb_member(eb, btrfs_node_key_ptr(eb, nr), struct btrfs_key_ptr,
-		       key, disk_key);
-}
-
-static inline void btrfs_set_node_key(struct extent_buffer *eb,
-				      struct btrfs_disk_key *disk_key, int nr)
-{
-	write_eb_member(eb, btrfs_node_key_ptr(eb, nr), struct btrfs_key_ptr,
-			key, disk_key);
-}
-
-/* struct btrfs_item */
-BTRFS_SETGET_FUNCS(raw_item_offset, struct btrfs_item, offset, 32);
-BTRFS_SETGET_FUNCS(raw_item_size, struct btrfs_item, size, 32);
-
-static inline unsigned long btrfs_item_nr_offset(const struct extent_buffer *eb, int nr)
-{
-	return offsetof(struct btrfs_leaf, items) +
-		sizeof(struct btrfs_item) * nr;
-}
-
-static inline struct btrfs_item *btrfs_item_nr(const struct extent_buffer *eb, int nr)
-{
-	return (struct btrfs_item *)btrfs_item_nr_offset(eb, nr);
-}
-
-#define BTRFS_ITEM_SETGET_FUNCS(member)						\
-static inline u32 btrfs_item_##member(const struct extent_buffer *eb, int slot)	\
-{										\
-	return btrfs_raw_item_##member(eb, btrfs_item_nr(eb, slot));		\
-}										\
-static inline void btrfs_set_item_##member(struct extent_buffer *eb,		\
-					   int slot, u32 val)			\
-{										\
-	btrfs_set_raw_item_##member(eb, btrfs_item_nr(eb, slot), val);		\
-}
-
-BTRFS_ITEM_SETGET_FUNCS(size)
-BTRFS_ITEM_SETGET_FUNCS(offset)
-
-static inline u32 btrfs_item_data_end(struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_offset(eb, nr) + btrfs_item_size(eb, nr);
-}
-
-static inline void btrfs_item_key(struct extent_buffer *eb,
-			   struct btrfs_disk_key *disk_key, int nr)
-{
-	struct btrfs_item *item = btrfs_item_nr(eb, nr);
-	read_eb_member(eb, item, struct btrfs_item, key, disk_key);
-}
-
-static inline void btrfs_set_item_key(struct extent_buffer *eb,
-			       struct btrfs_disk_key *disk_key, int nr)
-{
-	struct btrfs_item *item = btrfs_item_nr(eb, nr);
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
-BTRFS_SETGET_STACK_FUNCS(stack_root_ref_dirid, struct btrfs_root_ref, dirid, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_root_ref_sequence, struct btrfs_root_ref, sequence, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_root_ref_name_len, struct btrfs_root_ref, name_len, 16);
-
-/* struct btrfs_dir_item */
-BTRFS_SETGET_FUNCS(dir_data_len, struct btrfs_dir_item, data_len, 16);
-BTRFS_SETGET_FUNCS(dir_type, struct btrfs_dir_item, type, 8);
-BTRFS_SETGET_FUNCS(dir_name_len, struct btrfs_dir_item, name_len, 16);
-BTRFS_SETGET_FUNCS(dir_transid, struct btrfs_dir_item, transid, 64);
-
-BTRFS_SETGET_STACK_FUNCS(stack_dir_data_len, struct btrfs_dir_item, data_len, 16);
-BTRFS_SETGET_STACK_FUNCS(stack_dir_type, struct btrfs_dir_item, type, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_dir_name_len, struct btrfs_dir_item, name_len, 16);
-BTRFS_SETGET_STACK_FUNCS(stack_dir_transid, struct btrfs_dir_item, transid, 64);
-
-static inline void btrfs_dir_item_key(struct extent_buffer *eb,
-				      struct btrfs_dir_item *item,
-				      struct btrfs_disk_key *key)
-{
-	read_eb_member(eb, item, struct btrfs_dir_item, location, key);
-}
-
-static inline void btrfs_set_dir_item_key(struct extent_buffer *eb,
-					  struct btrfs_dir_item *item,
-					  struct btrfs_disk_key *key)
-{
-	write_eb_member(eb, item, struct btrfs_dir_item, location, key);
-}
-
-/* struct btrfs_free_space_header */
-BTRFS_SETGET_FUNCS(free_space_entries, struct btrfs_free_space_header,
-		   num_entries, 64);
-BTRFS_SETGET_FUNCS(free_space_bitmaps, struct btrfs_free_space_header,
-		   num_bitmaps, 64);
-BTRFS_SETGET_FUNCS(free_space_generation, struct btrfs_free_space_header,
-		   generation, 64);
-
-static inline void btrfs_free_space_key(struct extent_buffer *eb,
-					struct btrfs_free_space_header *h,
-					struct btrfs_disk_key *key)
-{
-	read_eb_member(eb, h, struct btrfs_free_space_header, location, key);
-}
-
-static inline void btrfs_set_free_space_key(struct extent_buffer *eb,
-					    struct btrfs_free_space_header *h,
-					    struct btrfs_disk_key *key)
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
-static inline void btrfs_disk_key_to_cpu(struct btrfs_key *cpu,
-					 struct btrfs_disk_key *disk)
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
-static inline void btrfs_node_key_to_cpu(struct extent_buffer *eb,
-				  struct btrfs_key *key, int nr)
-{
-	struct btrfs_disk_key disk_key;
-	btrfs_node_key(eb, &disk_key, nr);
-	btrfs_disk_key_to_cpu(key, &disk_key);
-}
-
-static inline void btrfs_item_key_to_cpu(struct extent_buffer *eb,
-				  struct btrfs_key *key, int nr)
-{
-	struct btrfs_disk_key disk_key;
-	btrfs_item_key(eb, &disk_key, nr);
-	btrfs_disk_key_to_cpu(key, &disk_key);
-}
-
-static inline void btrfs_dir_item_key_to_cpu(struct extent_buffer *eb,
-				      struct btrfs_dir_item *item,
-				      struct btrfs_key *key)
-{
-	struct btrfs_disk_key disk_key;
-	btrfs_dir_item_key(eb, item, &disk_key);
-	btrfs_disk_key_to_cpu(key, &disk_key);
-}
-
-/* struct btrfs_header */
-BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,
-			  generation, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
-BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_header_bytenr, struct btrfs_header, bytenr, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header, nritems,
-			 32);
-BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
-			 generation, 64);
-
-static inline int btrfs_header_flag(struct extent_buffer *eb, u64 flag)
-{
-	return (btrfs_header_flags(eb) & flag) == flag;
-}
-
-static inline int btrfs_set_header_flag(struct extent_buffer *eb, u64 flag)
-{
-	u64 flags = btrfs_header_flags(eb);
-	btrfs_set_header_flags(eb, flags | flag);
-	return (flags & flag) == flag;
-}
-
-static inline int btrfs_clear_header_flag(struct extent_buffer *eb, u64 flag)
-{
-	u64 flags = btrfs_header_flags(eb);
-	btrfs_set_header_flags(eb, flags & ~flag);
-	return (flags & flag) == flag;
-}
-
-static inline int btrfs_header_backref_rev(struct extent_buffer *eb)
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
-static inline unsigned long btrfs_header_fsid(void)
-{
-	return offsetof(struct btrfs_header, fsid);
-}
-
-static inline unsigned long btrfs_header_chunk_tree_uuid(struct extent_buffer *eb)
-{
-	return offsetof(struct btrfs_header, chunk_tree_uuid);
-}
-
-static inline u8 *btrfs_header_csum(struct extent_buffer *eb)
-{
-	unsigned long ptr = offsetof(struct btrfs_header, csum);
-	return (u8 *)ptr;
-}
-
-static inline int btrfs_is_leaf(struct extent_buffer *eb)
-{
-	return (btrfs_header_level(eb) == 0);
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
 static inline struct btrfs_timespec* btrfs_root_ctime(
 		struct btrfs_root_item *root_item)
 {
@@ -1343,115 +713,12 @@ static inline struct btrfs_timespec* btrfs_root_rtime(
 	return (struct btrfs_timespec *)ptr;
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
-/* struct btrfs_super_block */
-
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
-BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
-			 uuid_tree_generation, 64);
-BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
-BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
-			 nr_global_roots, 64);
-
-static inline unsigned long btrfs_leaf_data(struct extent_buffer *l)
+static inline u8 *btrfs_dev_extent_chunk_tree_uuid(struct btrfs_dev_extent *dev)
 {
-	return offsetof(struct btrfs_leaf, items);
+	unsigned long ptr = offsetof(struct btrfs_dev_extent, chunk_tree_uuid);
+       return (u8 *)((unsigned long)dev + ptr);
 }
 
-/* struct btrfs_file_extent_item */
-BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item, type, 8);
-
 static inline unsigned long btrfs_file_extent_inline_start(struct
 						   btrfs_file_extent_item *e)
 {
@@ -1465,132 +732,6 @@ static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
 	return offsetof(struct btrfs_file_extent_item, disk_bytenr) + datasize;
 }
 
-BTRFS_SETGET_FUNCS(file_extent_disk_bytenr, struct btrfs_file_extent_item,
-		   disk_bytenr, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_bytenr, struct btrfs_file_extent_item,
-		   disk_bytenr, 64);
-BTRFS_SETGET_FUNCS(file_extent_generation, struct btrfs_file_extent_item,
-		   generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_generation, struct btrfs_file_extent_item,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(file_extent_disk_num_bytes, struct btrfs_file_extent_item,
-		   disk_num_bytes, 64);
-BTRFS_SETGET_FUNCS(file_extent_offset, struct btrfs_file_extent_item,
-		  offset, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_offset, struct btrfs_file_extent_item,
-		  offset, 64);
-BTRFS_SETGET_FUNCS(file_extent_num_bytes, struct btrfs_file_extent_item,
-		   num_bytes, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_num_bytes, struct btrfs_file_extent_item,
-		   num_bytes, 64);
-BTRFS_SETGET_FUNCS(file_extent_ram_bytes, struct btrfs_file_extent_item,
-		   ram_bytes, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_ram_bytes, struct btrfs_file_extent_item,
-		   ram_bytes, 64);
-BTRFS_SETGET_FUNCS(file_extent_compression, struct btrfs_file_extent_item,
-		   compression, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression, struct btrfs_file_extent_item,
-		   compression, 8);
-BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
-		   encryption, 8);
-BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
-		   other_encoding, 16);
-
-/* btrfs_qgroup_status_item */
-BTRFS_SETGET_FUNCS(qgroup_status_version, struct btrfs_qgroup_status_item,
-		   version, 64);
-BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(qgroup_status_flags, struct btrfs_qgroup_status_item,
-		   flags, 64);
-BTRFS_SETGET_FUNCS(qgroup_status_rescan, struct btrfs_qgroup_status_item,
-		   rescan, 64);
-
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_version,
-			 struct btrfs_qgroup_status_item, version, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_generation,
-			 struct btrfs_qgroup_status_item, generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_flags,
-			 struct btrfs_qgroup_status_item, flags, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_rescan,
-			 struct btrfs_qgroup_status_item, rescan, 64);
-
-/* btrfs_qgroup_info_item */
-BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_rfer, struct btrfs_qgroup_info_item,
-		   rfer, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_rfer_cmpr,
-		   struct btrfs_qgroup_info_item, rfer_cmpr, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_excl, struct btrfs_qgroup_info_item,
-		   excl, 64);
-BTRFS_SETGET_FUNCS(qgroup_info_excl_cmpr,
-		   struct btrfs_qgroup_info_item, excl_cmpr, 64);
-
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_generation,
-			 struct btrfs_qgroup_info_item, generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_rfer,
-			 struct btrfs_qgroup_info_item, rfer, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_rfer_cmpr,
-		   struct btrfs_qgroup_info_item, rfer_cmpr, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_excl,
-			 struct btrfs_qgroup_info_item, excl, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_excl_cmpr,
-		   struct btrfs_qgroup_info_item, excl_cmpr, 64);
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
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_flags,
-			 struct btrfs_qgroup_limit_item, flags, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_rfer,
-			 struct btrfs_qgroup_limit_item, max_rfer, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_excl,
-			 struct btrfs_qgroup_limit_item, max_excl, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_rfer,
-			 struct btrfs_qgroup_limit_item, rsv_rfer, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_excl,
-			 struct btrfs_qgroup_limit_item, rsv_excl, 64);
-
-/* btrfs_balance_item */
-BTRFS_SETGET_FUNCS(balance_item_flags, struct btrfs_balance_item, flags, 64);
-
-static inline struct btrfs_disk_balance_args* btrfs_balance_item_data(
-		struct extent_buffer *eb, struct btrfs_balance_item *bi)
-{
-	unsigned long offset = (unsigned long)bi;
-	struct btrfs_balance_item *p;
-	p = (struct btrfs_balance_item *)(eb->data + offset);
-	return &p->data;
-}
-
-static inline struct btrfs_disk_balance_args* btrfs_balance_item_meta(
-		struct extent_buffer *eb, struct btrfs_balance_item *bi)
-{
-	unsigned long offset = (unsigned long)bi;
-	struct btrfs_balance_item *p;
-	p = (struct btrfs_balance_item *)(eb->data + offset);
-	return &p->meta;
-}
-
-static inline struct btrfs_disk_balance_args* btrfs_balance_item_sys(
-		struct extent_buffer *eb, struct btrfs_balance_item *bi)
-{
-	unsigned long offset = (unsigned long)bi;
-	struct btrfs_balance_item *p;
-	p = (struct btrfs_balance_item *)(eb->data + offset);
-	return &p->sys;
-}
-
 static inline u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
 					const struct btrfs_dev_stats_item *ptr,
 					int index)
@@ -1599,7 +740,7 @@ static inline u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
 
 	read_extent_buffer(eb, &val,
 			   offsetof(struct btrfs_dev_stats_item, values) +
-			    ((unsigned long)ptr) + (index * sizeof(u64)),
+			   ((unsigned long)ptr) + (index * sizeof(u64)),
 			   sizeof(val));
 	return val;
 }
@@ -1661,15 +802,6 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
 	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
 }
 
-/* helper function to cast into the data area of the leaf. */
-#define btrfs_item_ptr(leaf, slot, type) \
-	((type *)(btrfs_leaf_data(leaf) + \
-	btrfs_item_offset(leaf, slot)))
-
-#define btrfs_item_ptr_offset(leaf, slot) \
-	((unsigned long)(btrfs_leaf_data(leaf) + \
-	btrfs_item_offset(leaf, slot)))
-
 u64 btrfs_name_hash(const char *name, int len);
 u64 btrfs_extref_hash(u64 parent_objectid, const char *name, int len);
 
diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index 27dfb362..ef49441c 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -89,7 +89,7 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	btrfs_cpu_key_to_disk(&disk_key, &location);
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_type(leaf, dir_item, BTRFS_FT_XATTR);
+	btrfs_set_dir_flags(leaf, dir_item, BTRFS_FT_XATTR);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
 	btrfs_set_dir_data_len(leaf, dir_item, data_len);
 	name_ptr = (unsigned long)(dir_item + 1);
@@ -141,7 +141,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, struct btrfs_root
 	leaf = path->nodes[0];
 	btrfs_cpu_key_to_disk(&disk_key, location);
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_type(leaf, dir_item, type);
+	btrfs_set_dir_flags(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
 	name_ptr = (unsigned long)(dir_item + 1);
@@ -170,7 +170,7 @@ insert:
 	leaf = path->nodes[0];
 	btrfs_cpu_key_to_disk(&disk_key, location);
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_type(leaf, dir_item, type);
+	btrfs_set_dir_flags(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
 	name_ptr = (unsigned long)(dir_item + 1);
@@ -292,7 +292,7 @@ static int verify_dir_item(struct btrfs_root *root,
 		    struct btrfs_dir_item *dir_item)
 {
 	u16 namelen = BTRFS_NAME_LEN;
-	u8 type = btrfs_dir_type(leaf, dir_item);
+	u8 type = btrfs_dir_ftype(leaf, dir_item);
 
 	if (type == BTRFS_FT_XATTR)
 		namelen = XATTR_NAME_MAX;
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index d1786c7a..1430cf33 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -548,7 +548,7 @@ int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		 */
 		btrfs_dir_item_key_to_cpu(path->nodes[0], dir_item, &found_key);
 		ret_ino = found_key.objectid;
-		if (btrfs_dir_type(path->nodes[0], dir_item) != BTRFS_FT_DIR)
+		if (btrfs_dir_ftype(path->nodes[0], dir_item) != BTRFS_FT_DIR)
 			ret = -EEXIST;
 		goto out;
 	}
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 37a1f74c..b5343462 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -27,11 +27,12 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/compression.h"
 #include "common/utils.h"
+#include "accessors.h"
 
 static void print_dir_item_type(struct extent_buffer *eb,
                                 struct btrfs_dir_item *di)
 {
-	u8 type = btrfs_dir_type(eb, di);
+	u8 type = btrfs_dir_ftype(eb, di);
 	static const char* dir_item_str[] = {
 		[BTRFS_FT_REG_FILE]	= "FILE",
 		[BTRFS_FT_DIR] 		= "DIR",
@@ -959,15 +960,20 @@ static void print_disk_balance_args(struct btrfs_disk_balance_args *ba)
 static void print_balance_item(struct extent_buffer *eb,
 		struct btrfs_balance_item *bi)
 {
+	struct btrfs_disk_balance_args ba;
+
 	printf("\t\tbalance status flags %llu\n",
-			btrfs_balance_item_flags(eb, bi));
+			btrfs_balance_flags(eb, bi));
 
 	printf("\t\tDATA\n");
-	print_disk_balance_args(btrfs_balance_item_data(eb, bi));
+	btrfs_balance_data(eb, bi, &ba);
+	print_disk_balance_args(&ba);
 	printf("\t\tMETADATA\n");
-	print_disk_balance_args(btrfs_balance_item_meta(eb, bi));
+	btrfs_balance_meta(eb, bi, &ba);
+	print_disk_balance_args(&ba);
 	printf("\t\tSYSTEM\n");
-	print_disk_balance_args(btrfs_balance_item_sys(eb, bi));
+	btrfs_balance_sys(eb, bi, &ba);
+	print_disk_balance_args(&ba);
 }
 
 static void print_dev_stats(struct extent_buffer *eb,
diff --git a/mkfs/common.c b/mkfs/common.c
index 40d07deb..3c3e6bec 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -39,6 +39,7 @@
 #include "common/open-utils.h"
 #include "mkfs/common.h"
 #include "kernel-shared/uapi/btrfs.h"
+#include "kernel-shared/accessors.h"
 
 static u64 reference_root_table[] = {
 	[MKFS_ROOT_TREE]	=	BTRFS_ROOT_TREE_OBJECTID,
-- 
2.40.0

