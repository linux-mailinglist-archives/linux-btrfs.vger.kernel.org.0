Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E7C4D0AD7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbiCGWS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbiCGWS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:18:57 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D023EF15
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:18:01 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id d84so13269297qke.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IFK5UbO8H/hKaz9x8Ur9RSNtHds0QEKQ16t0T9wLXu4=;
        b=oKX+sN9wVm4pTWpPayFCqh3fh7QCuAThEOu9H9vCDXsx3mPdfBX48+tJTUnHkpIdfv
         1lyhbvF88deoZMZgP5n0fSrrqp2BUjT0nbuOHD90Gfa+sjzNljo6T9r/v2ymZvJJN6RT
         EGFLYL3Y2YZa6CIq0VKddQSGEh3vERRrBC1jyzeyKhvJCqahcriwiyu+uKtuqRIJuWV2
         nP4KMs3PWUSjbkjxahq4Tq4gBBQD9gtDiYMy4E/6Wr05A8s5dN7r3QPeugjUu51/oAhX
         1s5wz6RZh7ZoQfxtLhOiNg+RoA9RikeC2IGtwxMafMhCgWB36cLUtopIh2XtqFlFzerM
         P+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFK5UbO8H/hKaz9x8Ur9RSNtHds0QEKQ16t0T9wLXu4=;
        b=SH04mwxceTZIboB3CBaW7mnQnyetz/8woV3B/x3BdlI5VhubZGW/yrbLkkEWm31wXy
         VLN/Q2pb5PYTrxWQKOUbYT/dBrc8KNRFSEQHLvhWEu6bZuEZciwPXYnx4h6HYtdXBcsU
         4V1Z+yTGkE9tuJXhMtGPuJpZIrBqisRb3s5fzrNtyxE7Qd56/vPsvLgkUSOar8yF2jD0
         tL2edThayOteyzbSPa6i3/Rxn2OL1EulcobTS72ueq9P1tAFUh//c8ZxL0Y/4QKwGl2u
         fA1i3G6/5XDRwEx742jjYRcbRHDH0zypnJ59O2QD+4COLbX3J04yaBqyZuymIZXZ7sNV
         cKFg==
X-Gm-Message-State: AOAM531qxLWZRpJ31zrYcDGv+CQ4Hi47TuCD7k7HxJcvmKtZoisNB6X/
        pNVZ8OAdUcLs+3Z3Rl6yoT7RAQEU1sWzZpij
X-Google-Smtp-Source: ABdhPJxn5ehxxpmv8/fiqtXceSNffn1mkZniumSGUe9cUMJH6b/aiQ0N2fUW3TCX33TYgFTZ42SJaQ==
X-Received: by 2002:a05:620a:bc6:b0:67c:ce55:d2d4 with SMTP id s6-20020a05620a0bc600b0067cce55d2d4mr1122850qki.175.1646691480563;
        Mon, 07 Mar 2022 14:18:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r184-20020ae9ddc1000000b0067ca2630aa8sm487830qkf.114.2022.03.07.14.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:18:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/15] btrfs-progs: add snapshot_id to the btrfs_header
Date:   Mon,  7 Mar 2022 17:17:41 -0500
Message-Id: <7e34f77485b09a60857761b92ddcce4fe1ef892a.1646691255.git.josef@toxicpanda.com>
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

Add a new btrfs_header_v2 which has the original header and an
additional snapshot_id field for tracking the snapshot the block was
created in.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index f3343840..7d4fd491 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -328,6 +328,7 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 
 #define BTRFS_HEADER_FLAG_WRITTEN		(1ULL << 0)
 #define BTRFS_HEADER_FLAG_RELOC			(1ULL << 1)
+#define BTRFS_HEADER_FLAG_V2			(1ULL << 2)
 #define BTRFS_SUPER_FLAG_SEEDING		(1ULL << 32)
 #define BTRFS_SUPER_FLAG_METADUMP		(1ULL << 33)
 #define BTRFS_SUPER_FLAG_METADUMP_V2		(1ULL << 34)
@@ -361,6 +362,11 @@ struct btrfs_header {
 	u8 level;
 } __attribute__ ((__packed__));
 
+struct btrfs_header_v2 {
+	struct btrfs_header header_v1;
+	__le64 snapshot_id;
+} __attribute__ ((__packed__));
+
 static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 {
 	return nodesize - sizeof(struct btrfs_header);
@@ -1569,13 +1575,13 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
 static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
 {									\
-	const struct btrfs_header *h = (struct btrfs_header *)eb->data;	\
+	const type *h = (type *)eb->data;				\
 	return le##bits##_to_cpu(h->member);				\
 }									\
 static inline void btrfs_set_##name(struct extent_buffer *eb,		\
 				    u##bits val)			\
 {									\
-	struct btrfs_header *h = (struct btrfs_header *)eb->data;	\
+	type *h = (type *)eb->data;					\
 	h->member = cpu_to_le##bits(val);				\
 }
 
@@ -2142,12 +2148,16 @@ BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
 BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
 BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
 BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
+BTRFS_SETGET_HEADER_FUNCS(header_snapshot_id, struct btrfs_header_v2,
+			  snapshot_id, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_header_bytenr, struct btrfs_header, bytenr, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header, nritems,
 			 32);
 BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
 			 generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_snapshot_id, struct btrfs_header_v2,
+			 snapshot_id, 64);
 
 static inline int btrfs_header_flag(struct extent_buffer *eb, u64 flag)
 {
-- 
2.26.3

