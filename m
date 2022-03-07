Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE74D0ADD
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbiCGWTC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343711AbiCGWTA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:19:00 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A858E43386
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:18:04 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id o22so4955407qta.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6dgYR1gcn9bN76MpcuDDYzF9DDslZ1KJWwNJxrsa4ZI=;
        b=RI49lx2HK46PS4zPB2x0pzhMVqkQctdEnJ6jVWeQewjDzlGJTSdAMR+gcneXv0My0e
         hEk+Oj+SpFxwY3C46cNDcEztJP/De58zyzcJdHQw+i5kWK27FX0tTazJR+DUUhHFA5rg
         AUoyG60/66UePwFhaS+vQVI9iYx5NU5Kl4l5d2nZ1+AklwLN98p/JfVx+ChyaDX6U5A9
         YYGKDAdRdnnhlNiur1hYF48nt7qa7XouMHtHNeQEQGy0Vyie9X0rXA6VhfavyymILyQ5
         riuTgWaFnc3Alf7PkmbnHbwQamQrDeUDRkVlnQQ3Yd4/04R3Rji5nbeIe/I8giVnY47G
         QmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dgYR1gcn9bN76MpcuDDYzF9DDslZ1KJWwNJxrsa4ZI=;
        b=TuRCdSa+oefn0iwe/bC9HAWauzj48UW3jVWW3Km12//ZbkbzU1mYlFt0dlbIHkXiHL
         SzNV8kSsH/1WmWFz1C7LgZXJcKFvrnPXjajBuL8YDq2MAMd9vETifoWZNsag6df0dbl5
         sKRKKrNTqVs+er8uVfuGrIcB3vdRLJxsK/nAGo+uY1SyGRICUF3QJlxhU+m48P1S75l2
         /aspjSLIk8rVIHCTalQu0SvyVMHs/KNeupfYR13wkUATCZka2baSPkweYjRVlkgkjXY8
         GG8CzjP/vIg3zk+laE8gDaEZDzcrL/JkSXOhQ23jfKIN3Wpwd8BTFMiAUN3s3DX6zdOm
         YOlA==
X-Gm-Message-State: AOAM531lKdoY+lQWoVcCTxxq6XAlBO6ZCy87BLeLbnoCHsnoCxJ723Ro
        YnukicfNnuxiOZKoFWPCRcaHOVRKYTCFq1NV
X-Google-Smtp-Source: ABdhPJz25W5U/Jutar91l0ODCMZyytDHuf9WgyRFm2K02TgFYdWgcLAcHit3pO8nlifVx3DifgCVrA==
X-Received: by 2002:a05:622a:1819:b0:2e0:6932:a249 with SMTP id t25-20020a05622a181900b002e06932a249mr4219042qtc.249.1646691483361;
        Mon, 07 Mar 2022 14:18:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e18-20020a05620a12d200b0066393782c89sm6579459qkl.64.2022.03.07.14.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:18:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/15] btrfs-progs: adjust the leaf/node math for header_v2
Date:   Mon,  7 Mar 2022 17:17:43 -0500
Message-Id: <7cdc743273c099e8cdb85b74d4b3165613ce48a6.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
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

With extent tree v2 we have a slightly larger header in all metadata
blocks, so adjust the leaf and node related math to take into account
the new header.

I had to move the header SETGET funcs hence the churn.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 174 +++++++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 78 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 0ee5357a..26a1db9a 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -590,6 +590,11 @@ struct btrfs_leaf {
 	struct btrfs_item items[];
 } __attribute__ ((__packed__));
 
+struct btrfs_leaf_v2 {
+	struct btrfs_header_v2 header;
+	struct btrfs_item items[];
+} __attribute__ ((__packed__));
+
 /*
  * all non-leaf blocks are nodes, they hold only keys and pointers to
  * other blocks
@@ -605,6 +610,11 @@ struct btrfs_node {
 	struct btrfs_key_ptr ptrs[];
 } __attribute__ ((__packed__));
 
+struct btrfs_node_v2 {
+	struct btrfs_header_v2 header;
+	struct btrfs_key_ptr ptrs[];
+} __attribute__ ((__packed__));
+
 /*
  * btrfs_paths remember the path taken from the root down to the leaf.
  * level 0 is always the leaf, and nodes[1...BTRFS_MAX_LEVEL] will point
@@ -1613,6 +1623,80 @@ static inline void btrfs_set_##name(type *s, u##bits val)		\
 	s->member = cpu_to_le##bits(val);				\
 }
 
+/* struct btrfs_header */
+BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,
+			  generation, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
+BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
+BTRFS_SETGET_HEADER_FUNCS(header_snapshot_id, struct btrfs_header_v2,
+			  snapshot_id, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_bytenr, struct btrfs_header, bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header, nritems,
+			 32);
+BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
+			 generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_snapshot_id, struct btrfs_header_v2,
+			 snapshot_id, 64);
+
+static inline int btrfs_header_flag(const struct extent_buffer *eb, u64 flag)
+{
+	return (btrfs_header_flags(eb) & flag) == flag;
+}
+
+static inline int btrfs_set_header_flag(struct extent_buffer *eb, u64 flag)
+{
+	u64 flags = btrfs_header_flags(eb);
+	btrfs_set_header_flags(eb, flags | flag);
+	return (flags & flag) == flag;
+}
+
+static inline int btrfs_clear_header_flag(struct extent_buffer *eb, u64 flag)
+{
+	u64 flags = btrfs_header_flags(eb);
+	btrfs_set_header_flags(eb, flags & ~flag);
+	return (flags & flag) == flag;
+}
+
+static inline int btrfs_header_backref_rev(struct extent_buffer *eb)
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
+static inline unsigned long btrfs_header_fsid(void)
+{
+	return offsetof(struct btrfs_header, fsid);
+}
+
+static inline unsigned long btrfs_header_chunk_tree_uuid(struct extent_buffer *eb)
+{
+	return offsetof(struct btrfs_header, chunk_tree_uuid);
+}
+
+static inline u8 *btrfs_header_csum(struct extent_buffer *eb)
+{
+	unsigned long ptr = offsetof(struct btrfs_header, csum);
+	return (u8 *)ptr;
+}
+
+static inline int btrfs_is_leaf(struct extent_buffer *eb)
+{
+	return (btrfs_header_level(eb) == 0);
+}
+
 BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
 BTRFS_SETGET_FUNCS(device_total_bytes, struct btrfs_dev_item, total_bytes, 64);
 BTRFS_SETGET_FUNCS(device_bytes_used, struct btrfs_dev_item, bytes_used, 64);
@@ -1942,8 +2026,12 @@ BTRFS_SETGET_FUNCS(key_generation, struct btrfs_key_ptr, generation, 64);
 
 static inline unsigned long btrfs_node_key_ptr_offset(const struct extent_buffer *eb, int nr)
 {
-	return offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
+	unsigned long offset;
+	if (btrfs_header_flag(eb, BTRFS_HEADER_FLAG_V2))
+		offset = offsetof(struct btrfs_node_v2, ptrs);
+	else
+		offset = offsetof(struct btrfs_node, ptrs);
+	return offset + sizeof(struct btrfs_key_ptr) * nr;
 }
 
 static inline struct btrfs_key_ptr *btrfs_node_key_ptr(const struct extent_buffer *eb, int nr)
@@ -1993,8 +2081,12 @@ BTRFS_SETGET_FUNCS(raw_item_size, struct btrfs_item, size, 32);
 
 static inline unsigned long btrfs_item_nr_offset(const struct extent_buffer *eb, int nr)
 {
-	return offsetof(struct btrfs_leaf, items) +
-		sizeof(struct btrfs_item) * nr;
+	unsigned long offset;
+	if (btrfs_header_flag(eb, BTRFS_HEADER_FLAG_V2))
+		offset = offsetof(struct btrfs_leaf_v2, items);
+	else
+		offset = offsetof(struct btrfs_leaf, items);
+	return offset + sizeof(struct btrfs_item) * nr;
 }
 
 static inline struct btrfs_item *btrfs_item_nr(const struct extent_buffer *eb, int nr)
@@ -2142,80 +2234,6 @@ static inline void btrfs_dir_item_key_to_cpu(struct extent_buffer *eb,
 	btrfs_disk_key_to_cpu(key, &disk_key);
 }
 
-/* struct btrfs_header */
-BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,
-			  generation, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
-BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
-BTRFS_SETGET_HEADER_FUNCS(header_snapshot_id, struct btrfs_header_v2,
-			  snapshot_id, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_bytenr, struct btrfs_header, bytenr, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header, nritems,
-			 32);
-BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
-			 generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_snapshot_id, struct btrfs_header_v2,
-			 snapshot_id, 64);
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
 /* struct btrfs_root_item */
 BTRFS_SETGET_FUNCS(disk_root_generation, struct btrfs_root_item,
 		   generation, 64);
-- 
2.26.3

