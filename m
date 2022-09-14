Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9135B8E0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiINRS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiINRS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:57 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DE08286D
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:48 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j8so1336023qvt.13
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=E9m943pwTF8KKgXfMPHsRfsZ3bOmXcuBJh4ALf4L80Q=;
        b=b7rFGY0uCqtIaNaKX+cc8p9ae2YsOastuXO60PF1TKGjAJn2d+KYcX20HbXqYI8Oox
         lS+tDWJGds2nOvOYhRsb/pKbZOYkXTPHEU9aBFek+BkrYSwgtW4sy0DWfHrEnGPuR/RG
         83g7pM6wK2mK587LFjuZGqzfQSshXySFTVf8y7gIQZOcsE5ZDk/7fPyHz0qkyN1pu0o7
         3nc2lqsdWrZKZpaKTadXNAcAVVRzH46W0V1nCfACS44TZGn02tNHExFSyvOtUfvpfhBI
         0p9f4j1lDJ6111KF3oXJ+IN0XPePTgE5MQHz9dg67oVccwUlryqhUk1QsKYdUSRA2/Xy
         rbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=E9m943pwTF8KKgXfMPHsRfsZ3bOmXcuBJh4ALf4L80Q=;
        b=5oAqQ5NMZXUbHy0dV/kiq9AI/MhT4UNskpuZVuGu4Pa6U2gVVxtO0VnowKMM2kcsk9
         ykoLhvd55e7cc0MTYIR9d59uN3xUqFOZUL3iBn+XmfvzXFOGpSUW4WD01+DwS5+G+XEq
         FF0nz7IdDY9DYPL6zCCXCpR5SMwbcYhjmSpXKFxQz8ZeNorKpL1knaI8H7eVyeV+YWup
         ndH8NcV4RlWpel5hwy9uIF+N9njYyNT3l5BjBbtwjO8XCclnN2gDME47BztgrqUMsszE
         FMHqYBiE4YdkTiUxvnGt9i5xZe++76S3nQ6GDuWPLoSn/Hc4Qcytls8Q9jS/A5JT3XZQ
         eIqg==
X-Gm-Message-State: ACgBeo2tmx8od0G7+a9ZfPXtDg2cc5rOCVyDSM5CY6VVr9MF7FCK/e22
        4B4mebphbtri2zCRrXomMq1Wj81l0gdUAA==
X-Google-Smtp-Source: AA6agR4zlpqv+8CEebxUDnE2GHiU+SSu8HD3hsknyuzomFoQzJNxTnaIp0MwybFOVBvgkZyOxn9zdA==
X-Received: by 2002:a05:6214:d88:b0:4ac:bb74:1584 with SMTP id e8-20020a0562140d8800b004acbb741584mr11510627qve.107.1663175925547;
        Wed, 14 Sep 2022 10:18:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u16-20020a37ab10000000b006b5c061844fsm2094612qke.49.2022.09.14.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/16] btrfs: move accessor helpers into item-accessors.h
Date:   Wed, 14 Sep 2022 13:18:21 -0400
Message-Id: <fbae95250ef7879e8b60fcf2b7fe81d42e0456b0.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
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

This is a large patch, but because they're all macros it's impossible to
split up.  Simply copy all of the item accessors in ctree.h and paste
them in item-accessors.h, and then update any files to include the
header so everything compiles.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c                     |    1 +
 fs/btrfs/block-group.c                 |    1 +
 fs/btrfs/block-rsv.c                   |    1 +
 fs/btrfs/check-integrity.c             |    1 +
 fs/btrfs/ctree.h                       | 1090 ------------------------
 fs/btrfs/delayed-inode.c               |    1 +
 fs/btrfs/dev-replace.c                 |    1 +
 fs/btrfs/dir-item.c                    |    1 +
 fs/btrfs/disk-io.c                     |    1 +
 fs/btrfs/export.c                      |    1 +
 fs/btrfs/extent-tree.c                 |    1 +
 fs/btrfs/extent_io.c                   |    1 +
 fs/btrfs/file-item.c                   |    1 +
 fs/btrfs/file.c                        |    1 +
 fs/btrfs/free-space-cache.c            |    1 +
 fs/btrfs/free-space-tree.c             |    1 +
 fs/btrfs/fs.c                          |    1 +
 fs/btrfs/inode-item.c                  |    1 +
 fs/btrfs/ioctl.c                       |    1 +
 fs/btrfs/item-accessors.h              | 1090 ++++++++++++++++++++++++
 fs/btrfs/print-tree.c                  |    1 +
 fs/btrfs/props.c                       |    1 +
 fs/btrfs/qgroup.c                      |    1 +
 fs/btrfs/ref-verify.c                  |    1 +
 fs/btrfs/reflink.c                     |    1 +
 fs/btrfs/relocation.c                  |    1 +
 fs/btrfs/root-tree.c                   |    1 +
 fs/btrfs/scrub.c                       |    1 +
 fs/btrfs/send.c                        |    1 +
 fs/btrfs/space-info.c                  |    1 +
 fs/btrfs/super.c                       |    1 +
 fs/btrfs/sysfs.c                       |    1 +
 fs/btrfs/tests/extent-buffer-tests.c   |    1 +
 fs/btrfs/tests/free-space-tree-tests.c |    1 +
 fs/btrfs/tests/inode-tests.c           |    1 +
 fs/btrfs/tests/qgroup-tests.c          |    1 +
 fs/btrfs/transaction.c                 |    1 +
 fs/btrfs/tree-checker.c                |    1 +
 fs/btrfs/tree-defrag.c                 |    1 +
 fs/btrfs/tree-mod-log.c                |    1 +
 fs/btrfs/uuid-tree.c                   |    2 +-
 fs/btrfs/verity.c                      |    1 +
 fs/btrfs/volumes.c                     |    1 +
 fs/btrfs/xattr.c                       |    1 +
 fs/btrfs/zoned.c                       |    1 +
 45 files changed, 1133 insertions(+), 1091 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index d2a33c4d2f35..959f234a670f 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -16,6 +16,7 @@
 #include "misc.h"
 #include "tree-mod-log.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /* Just an arbitrary number so we can be sure this happened */
 #define BACKREF_FOUND_SHARED 6
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 510d58290edc..20da92ae5c6b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -18,6 +18,7 @@
 #include "raid56.h"
 #include "zoned.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 #ifdef CONFIG_BTRFS_DEBUG
 int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 6dad02dd1d63..8144b9225207 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -8,6 +8,7 @@
 #include "block-group.h"
 #include "disk-io.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * HOW DO BLOCK RESERVES WORK
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 60ff8ce1820e..f42b2697d888 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -93,6 +93,7 @@
 #include "check-integrity.h"
 #include "rcu-string.h"
 #include "compression.h"
+#include "item-accessors.h"
 
 #define BTRFSIC_BLOCK_HASHTABLE_SIZE 0x10000
 #define BTRFSIC_BLOCK_LINK_HASHTABLE_SIZE 0x10000
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 324400c5597f..8271b3dccf16 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1151,8 +1151,6 @@ static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
 	return info->nodesize - sizeof(struct btrfs_header);
 }
 
-#define BTRFS_LEAF_DATA_OFFSET		offsetof(struct btrfs_leaf, items)
-
 static inline u32 BTRFS_MAX_ITEM_SIZE(const struct btrfs_fs_info *info)
 {
 	return BTRFS_LEAF_DATA_SIZE(info) - sizeof(struct btrfs_item);
@@ -1179,1094 +1177,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
 				((bytes) >> (fs_info)->sectorsize_bits)
 
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
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
-	return btrfs_get_##bits(eb, s, offsetof(type, member));		\
-}									\
-static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
-				    u##bits val)			\
-{									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
-	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
-}									\
-static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
-					 const type *s)			\
-{									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
-	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
-}									\
-static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
-					  type *s, u##bits val)		\
-{									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
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
-static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
-					   struct btrfs_dev_item *s)
-{
-	static_assert(sizeof(u64) ==
-		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
-	return btrfs_get_64(eb, s, offsetof(struct btrfs_dev_item,
-					    total_bytes));
-}
-static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
-						struct btrfs_dev_item *s,
-						u64 val)
-{
-	static_assert(sizeof(u64) ==
-		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
-	WARN_ON(!IS_ALIGNED(val, eb->fs_info->sectorsize));
-	btrfs_set_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes), val);
-}
-
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
-BTRFS_SETGET_FUNCS(raw_item_offset, struct btrfs_item, offset, 32);
-BTRFS_SETGET_FUNCS(raw_item_size, struct btrfs_item, size, 32);
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
-#define BTRFS_ITEM_SETGET_FUNCS(member)						\
-static inline u32 btrfs_item_##member(const struct extent_buffer *eb,		\
-				      int slot)					\
-{										\
-	return btrfs_raw_item_##member(eb, btrfs_item_nr(slot));		\
-}										\
-static inline void btrfs_set_item_##member(const struct extent_buffer *eb,	\
-					   int slot, u32 val)			\
-{										\
-	btrfs_set_raw_item_##member(eb, btrfs_item_nr(slot), val);		\
-}										\
-static inline u32 btrfs_token_item_##member(struct btrfs_map_token *token,	\
-					    int slot)				\
-{										\
-	struct btrfs_item *item = btrfs_item_nr(slot);				\
-	return btrfs_token_raw_item_##member(token, item);			\
-}										\
-static inline void btrfs_set_token_item_##member(struct btrfs_map_token *token,	\
-						 int slot, u32 val)		\
-{										\
-	struct btrfs_item *item = btrfs_item_nr(slot);				\
-	btrfs_set_token_raw_item_##member(token, item, val);			\
-}
-
-BTRFS_ITEM_SETGET_FUNCS(offset)
-BTRFS_ITEM_SETGET_FUNCS(size);
-
-static inline u32 btrfs_item_data_end(const struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_offset(eb, nr) + btrfs_item_size(eb, nr);
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
-static inline bool btrfs_root_readonly(const struct btrfs_root *root)
-{
-	/* Byte-swap the constant at compile time, root_item::flags is LE */
-	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_RDONLY)) != 0;
-}
-
-static inline bool btrfs_root_dead(const struct btrfs_root *root)
-{
-	/* Byte-swap the constant at compile time, root_item::flags is LE */
-	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_DEAD)) != 0;
-}
-
-static inline u64 btrfs_root_id(const struct btrfs_root *root)
-{
-	return root->root_key.objectid;
-}
-
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
-static inline void
-btrfs_disk_balance_args_to_cpu(struct btrfs_balance_args *cpu,
-			       const struct btrfs_disk_balance_args *disk)
-{
-	memset(cpu, 0, sizeof(*cpu));
-
-	cpu->profiles = le64_to_cpu(disk->profiles);
-	cpu->usage = le64_to_cpu(disk->usage);
-	cpu->devid = le64_to_cpu(disk->devid);
-	cpu->pstart = le64_to_cpu(disk->pstart);
-	cpu->pend = le64_to_cpu(disk->pend);
-	cpu->vstart = le64_to_cpu(disk->vstart);
-	cpu->vend = le64_to_cpu(disk->vend);
-	cpu->target = le64_to_cpu(disk->target);
-	cpu->flags = le64_to_cpu(disk->flags);
-	cpu->limit = le64_to_cpu(disk->limit);
-	cpu->stripes_min = le32_to_cpu(disk->stripes_min);
-	cpu->stripes_max = le32_to_cpu(disk->stripes_max);
-}
-
-static inline void
-btrfs_cpu_balance_args_to_disk(struct btrfs_disk_balance_args *disk,
-			       const struct btrfs_balance_args *cpu)
-{
-	memset(disk, 0, sizeof(*disk));
-
-	disk->profiles = cpu_to_le64(cpu->profiles);
-	disk->usage = cpu_to_le64(cpu->usage);
-	disk->devid = cpu_to_le64(cpu->devid);
-	disk->pstart = cpu_to_le64(cpu->pstart);
-	disk->pend = cpu_to_le64(cpu->pend);
-	disk->vstart = cpu_to_le64(cpu->vstart);
-	disk->vend = cpu_to_le64(cpu->vend);
-	disk->target = cpu_to_le64(cpu->target);
-	disk->flags = cpu_to_le64(cpu->flags);
-	disk->limit = cpu_to_le64(cpu->limit);
-	disk->stripes_min = cpu_to_le32(cpu->stripes_min);
-	disk->stripes_max = cpu_to_le32(cpu->stripes_max);
-}
-
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
-int btrfs_super_csum_size(const struct btrfs_super_block *s);
-const char *btrfs_super_csum_name(u16 csum_type);
-const char *btrfs_super_csum_driver(u16 csum_type);
-size_t __attribute_const__ btrfs_get_num_csums(void);
-
-
-/*
- * The leaf data grows from end-to-front in the node.
- * this returns the address of the start of the last item,
- * which is the stop of the leaf data stack
- */
-static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
-{
-	u32 nr = btrfs_header_nritems(leaf);
-
-	if (nr == 0)
-		return BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
-	return btrfs_item_offset(leaf, nr - 1);
-}
-
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
-static inline unsigned long
-btrfs_file_extent_inline_start(const struct btrfs_file_extent_item *e)
-{
-	return (unsigned long)e + BTRFS_FILE_EXTENT_INLINE_DATA_START;
-}
-
-static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
-{
-	return BTRFS_FILE_EXTENT_INLINE_DATA_START + datasize;
-}
-
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
-/*
- * this returns the number of bytes used by the item on disk, minus the
- * size of any extent headers.  If a file is compressed on disk, this is
- * the compressed size
- */
-static inline u32 btrfs_file_extent_inline_item_len(
-						const struct extent_buffer *eb,
-						int nr)
-{
-	return btrfs_item_size(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
-}
-
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
-/* btrfs_verity_descriptor_item */
-BTRFS_SETGET_FUNCS(verity_descriptor_encryption, struct btrfs_verity_descriptor_item,
-		   encryption, 8);
-BTRFS_SETGET_FUNCS(verity_descriptor_size, struct btrfs_verity_descriptor_item,
-		   size, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
-			 struct btrfs_verity_descriptor_item, encryption, 8);
-BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
-			 struct btrfs_verity_descriptor_item, size, 64);
-
-/* helper function to cast into the data area of the leaf. */
-#define btrfs_item_ptr(leaf, slot, type) \
-	((type *)(BTRFS_LEAF_DATA_OFFSET + \
-	btrfs_item_offset(leaf, slot)))
-
-#define btrfs_item_ptr_offset(leaf, slot) \
-	((unsigned long)(BTRFS_LEAF_DATA_OFFSET + \
-	btrfs_item_offset(leaf, slot)))
-
 static inline u32 btrfs_crc32c(u32 crc, const void *address, unsigned length)
 {
 	return crc32c(crc, address, length);
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 8acb3785ad6e..aa79445ad722 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -17,6 +17,7 @@
 #include "inode-item.h"
 #include "space-info.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 #define BTRFS_DELAYED_WRITEBACK		512
 #define BTRFS_DELAYED_BACKGROUND	128
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 348aef453e69..c6222057f655 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -24,6 +24,7 @@
 #include "zoned.h"
 #include "block-group.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * Device replace overview
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index e53640dfacca..fb88f3d4c8cd 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -7,6 +7,7 @@
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
+#include "item-accessors.h"
 
 /*
  * insert a name into a directory, doing overflow properly if there is a hash
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 719c00757579..124c210c4e02 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -44,6 +44,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 1d4c2397d0d6..1ee7a552f7d0 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -7,6 +7,7 @@
 #include "btrfs_inode.h"
 #include "print-tree.h"
 #include "export.h"
+#include "item-accessors.h"
 
 #define BTRFS_FID_SIZE_NON_CONNECTABLE (offsetof(struct btrfs_fid, \
 						 parent_objectid) / 4)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 37f9f074da33..7cf7844c9dba 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -37,6 +37,7 @@
 #include "zoned.h"
 #include "dev-replace.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c11c05ea099d..b1d57727be02 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -31,6 +31,7 @@
 #include "block-group.h"
 #include "compression.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 07cfffabbe84..7bd6e1b91495 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -18,6 +18,7 @@
 #include "print-tree.h"
 #include "compression.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
 				   sizeof(struct btrfs_item) * 2) / \
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7fc77b454d8e..c395bf8e7522 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -31,6 +31,7 @@
 #include "reflink.h"
 #include "subpage.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index b472da0e9d1b..c0853b5e0dd1 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -26,6 +26,7 @@
 #include "subpage.h"
 #include "inode-item.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 5e0829456eb9..758662aef880 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -13,6 +13,7 @@
 #include "transaction.h"
 #include "block-group.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 32fbc7f55730..a95d86679d14 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -3,6 +3,7 @@
 #include "btrfs-printk.h"
 #include "ctree.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name)
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 02cd4210edf3..d5df6a1c4301 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -10,6 +10,7 @@
 #include "transaction.h"
 #include "print-tree.h"
 #include "space-info.h"
+#include "item-accessors.h"
 
 struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 						   int slot, const char *name,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e8b5dc147637..09d0ea32f6c4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -51,6 +51,7 @@
 #include "block-group.h"
 #include "subpage.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/item-accessors.h b/fs/btrfs/item-accessors.h
index 1f40aa503047..333120ef616a 100644
--- a/fs/btrfs/item-accessors.h
+++ b/fs/btrfs/item-accessors.h
@@ -9,6 +9,1096 @@ struct btrfs_map_token {
 	unsigned long offset;
 };
 
+#define BTRFS_LEAF_DATA_OFFSET		offsetof(struct btrfs_leaf, items)
+
 void btrfs_init_map_token(struct btrfs_map_token *token,
 			  struct extent_buffer *eb);
+
+/* some macros to generate set/get functions for the struct fields.  This
+ * assumes there is a lefoo_to_cpu for every type, so lets make a simple
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
+static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
+					   struct btrfs_dev_item *s)
+{
+	static_assert(sizeof(u64) ==
+		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
+	return btrfs_get_64(eb, s, offsetof(struct btrfs_dev_item,
+					    total_bytes));
+}
+static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
+						struct btrfs_dev_item *s,
+						u64 val)
+{
+	static_assert(sizeof(u64) ==
+		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
+	WARN_ON(!IS_ALIGNED(val, eb->fs_info->sectorsize));
+	btrfs_set_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes), val);
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
+BTRFS_SETGET_FUNCS(raw_item_offset, struct btrfs_item, offset, 32);
+BTRFS_SETGET_FUNCS(raw_item_size, struct btrfs_item, size, 32);
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
+#define BTRFS_ITEM_SETGET_FUNCS(member)						\
+static inline u32 btrfs_item_##member(const struct extent_buffer *eb,		\
+				      int slot)					\
+{										\
+	return btrfs_raw_item_##member(eb, btrfs_item_nr(slot));		\
+}										\
+static inline void btrfs_set_item_##member(const struct extent_buffer *eb,	\
+					   int slot, u32 val)			\
+{										\
+	btrfs_set_raw_item_##member(eb, btrfs_item_nr(slot), val);		\
+}										\
+static inline u32 btrfs_token_item_##member(struct btrfs_map_token *token,	\
+					    int slot)				\
+{										\
+	struct btrfs_item *item = btrfs_item_nr(slot);				\
+	return btrfs_token_raw_item_##member(token, item);			\
+}										\
+static inline void btrfs_set_token_item_##member(struct btrfs_map_token *token,	\
+						 int slot, u32 val)		\
+{										\
+	struct btrfs_item *item = btrfs_item_nr(slot);				\
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
+static inline bool btrfs_root_readonly(const struct btrfs_root *root)
+{
+	/* Byte-swap the constant at compile time, root_item::flags is LE */
+	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_RDONLY)) != 0;
+}
+
+static inline bool btrfs_root_dead(const struct btrfs_root *root)
+{
+	/* Byte-swap the constant at compile time, root_item::flags is LE */
+	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_DEAD)) != 0;
+}
+
+static inline u64 btrfs_root_id(const struct btrfs_root *root)
+{
+	return root->root_key.objectid;
+}
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
+static inline void
+btrfs_disk_balance_args_to_cpu(struct btrfs_balance_args *cpu,
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
+static inline void
+btrfs_cpu_balance_args_to_disk(struct btrfs_disk_balance_args *disk,
+			       const struct btrfs_balance_args *cpu)
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
+BTRFS_SETGET_STACK_FUNCS(super_log_root, struct btrfs_super_block,
+			 log_root, 64);
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
+int btrfs_super_csum_size(const struct btrfs_super_block *s);
+const char *btrfs_super_csum_name(u16 csum_type);
+const char *btrfs_super_csum_driver(u16 csum_type);
+size_t __attribute_const__ btrfs_get_num_csums(void);
+
+
+/*
+ * The leaf data grows from end-to-front in the node.
+ * this returns the address of the start of the last item,
+ * which is the stop of the leaf data stack
+ */
+static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
+{
+	u32 nr = btrfs_header_nritems(leaf);
+
+	if (nr == 0)
+		return BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
+	return btrfs_item_offset(leaf, nr - 1);
+}
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
+static inline unsigned long
+btrfs_file_extent_inline_start(const struct btrfs_file_extent_item *e)
+{
+	return (unsigned long)e + BTRFS_FILE_EXTENT_INLINE_DATA_START;
+}
+
+static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
+{
+	return BTRFS_FILE_EXTENT_INLINE_DATA_START + datasize;
+}
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
+/*
+ * this returns the number of bytes used by the item on disk, minus the
+ * size of any extent headers.  If a file is compressed on disk, this is
+ * the compressed size
+ */
+static inline u32 btrfs_file_extent_inline_item_len(
+						const struct extent_buffer *eb,
+						int nr)
+{
+	return btrfs_item_size(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
+}
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
+/* helper function to cast into the data area of the leaf. */
+#define btrfs_item_ptr(leaf, slot, type) \
+	((type *)(BTRFS_LEAF_DATA_OFFSET + \
+	btrfs_item_offset(leaf, slot)))
+
+#define btrfs_item_ptr_offset(leaf, slot) \
+	((unsigned long)(BTRFS_LEAF_DATA_OFFSET + \
+	btrfs_item_offset(leaf, slot)))
 #endif /* BTRFS_ITEM_ACCESSORS_H */
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 40576965d3da..ae3c2738422e 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -7,6 +7,7 @@
 #include "ctree.h"
 #include "disk-io.h"
 #include "print-tree.h"
+#include "item-accessors.h"
 
 struct root_name_map {
 	u64 id;
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index f95bc8e8d90a..53bab37f328f 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -13,6 +13,7 @@
 #include "compression.h"
 #include "space-info.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 #define BTRFS_PROP_HANDLERS_HT_BITS 8
 static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 041e4b368ea8..e98e57266e12 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -25,6 +25,7 @@
 #include "sysfs.h"
 #include "tree-mod-log.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * Helpers to access qgroup reservation
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index eddeb8885701..6b163ac13704 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -12,6 +12,7 @@
 #include "delayed-ref.h"
 #include "ref-verify.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * Used to keep track the roots and number of refs each root has for a given
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 6bc2231a7874..ff0edd68ec30 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -10,6 +10,7 @@
 #include "reflink.h"
 #include "transaction.h"
 #include "subpage.h"
+#include "item-accessors.h"
 
 #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5198dde6ad97..f33d6bb1cfe6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -29,6 +29,7 @@
 #include "inode-item.h"
 #include "space-info.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * Relocation overview
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 04b94727373f..5b8e01f46b2d 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -13,6 +13,7 @@
 #include "qgroup.h"
 #include "space-info.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * Read a root item from the tree. In case we detect a root item smaller then
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c758d8ff2e69..d5c23faceb8e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -22,6 +22,7 @@
 #include "block-group.h"
 #include "zoned.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4ef4167072b8..a82e84094016 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -27,6 +27,7 @@
 #include "compression.h"
 #include "xattr.h"
 #include "print-tree.h"
+#include "item-accessors.h"
 
 /*
  * Maximum number of references an extent can have in order for us to attempt to
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 46be83bd4d70..62e8e7a379b1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -11,6 +11,7 @@
 #include "block-group.h"
 #include "zoned.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * HOW DOES SPACE RESERVATION WORK
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 63a639056882..a7ce6f4889db 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -52,6 +52,7 @@
 #include "raid56.h"
 #include "space-info.h"
 #include "fs.h"
+#include "item-accessors.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 6a7ab762a543..7c5a8d77f2a7 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -24,6 +24,7 @@
 #include "qgroup.h"
 #include "misc.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * Structure name                       Path
diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/extent-buffer-tests.c
index b7d181a08eab..5df542b889c8 100644
--- a/fs/btrfs/tests/extent-buffer-tests.c
+++ b/fs/btrfs/tests/extent-buffer-tests.c
@@ -8,6 +8,7 @@
 #include "../ctree.h"
 #include "../extent_io.h"
 #include "../disk-io.h"
+#include "../item-accessors.h"
 
 static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 {
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index 13734ed43bfc..fcf9257435ca 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -10,6 +10,7 @@
 #include "../free-space-tree.h"
 #include "../transaction.h"
 #include "../block-group.h"
+#include "../item-accessors.h"
 
 struct free_space_extent {
 	u64 start;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index b1c88dd187cb..d3178abb8996 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -11,6 +11,7 @@
 #include "../extent_io.h"
 #include "../volumes.h"
 #include "../compression.h"
+#include "../item-accessors.h"
 
 static void insert_extent(struct btrfs_root *root, u64 start, u64 len,
 			  u64 ram_bytes, u64 offset, u64 disk_bytenr,
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 09b45c3d8386..4095224d9e2c 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -11,6 +11,7 @@
 #include "../qgroup.h"
 #include "../backref.h"
 #include "../fs.h"
+#include "../item-accessors.h"
 
 static int insert_normal_tree_ref(struct btrfs_root *root, u64 bytenr,
 				  u64 num_bytes, u64 parent, u64 root_objectid)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 37d0baaa41d8..f14bd5b39a09 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -24,6 +24,7 @@
 #include "space-info.h"
 #include "zoned.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index ec7de2a42b99..99c761ae0352 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -27,6 +27,7 @@
 #include "misc.h"
 #include "btrfs_inode.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * Error message should follow the following format:
diff --git a/fs/btrfs/tree-defrag.c b/fs/btrfs/tree-defrag.c
index b6cf39f4e7e4..b07479d2f900 100644
--- a/fs/btrfs/tree-defrag.c
+++ b/fs/btrfs/tree-defrag.c
@@ -9,6 +9,7 @@
 #include "print-tree.h"
 #include "transaction.h"
 #include "locking.h"
+#include "item-accessors.h"
 
 /*
  * Defrag all the leaves in a given btree.
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 523a184d10cc..862b5df3ed62 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -4,6 +4,7 @@
 #include "tree-mod-log.h"
 #include "disk-io.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 struct tree_mod_root {
 	u64 logical;
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index a24c5b13cf85..e62c88b920ba 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -11,7 +11,7 @@
 #include "disk-io.h"
 #include "print-tree.h"
 #include "fs.h"
-
+#include "item-accessors.h"
 
 static void btrfs_uuid_to_key(u8 *uuid, u8 type, struct btrfs_key *key)
 {
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 5b38625f915e..30488102c2da 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -17,6 +17,7 @@
 #include "disk-io.h"
 #include "locking.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /*
  * Implementation of the interface defined in struct fsverity_operations.
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1938fbf49507..09c1434c3cae 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -34,6 +34,7 @@
 #include "discard.h"
 #include "zoned.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 static struct bio_set btrfs_bioset;
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 69ead7e90478..4d7e295414b5 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -20,6 +20,7 @@
 #include "disk-io.h"
 #include "props.h"
 #include "locking.h"
+#include "item-accessors.h"
 
 int btrfs_getxattr(struct inode *inode, const char *name,
 				void *buffer, size_t size)
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 19b533a5766d..4d6647925545 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -16,6 +16,7 @@
 #include "dev-replace.h"
 #include "space-info.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
-- 
2.26.3

