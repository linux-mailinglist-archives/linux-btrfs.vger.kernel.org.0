Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64D34C048F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiBVW1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiBVW1J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:27:09 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D42716B
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:43 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id z66so1833886qke.10
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W5JgDZ47PpKoS6/RBeTTl9F5vSjrYJh0ABGY/tAhVo4=;
        b=T2paVEZ58A6UuSpF3DekoCC2AU2bs3b0Ch6zApipJPsgALyBiv73smbETxZ7Nyltfv
         Pd12IEShHkFbgnZlzEx9hQ9SfF+GG6/yAPoNXntCfEa19V8i0wMvIlKvvLl7LY2J22Nw
         f/R9N2OBKRCfYoCBD0eu4Uis8NJHJGLgV8cdjVdawkgknTyD5L3KRmSs4HNoohDPdLqV
         z9r03DtX9RSbr4weQHPif/DTuNCPj+TIlcETml8LQh4AbGfcqtzOF2jlcWrs4QQd6R4i
         JSaKFbrzLoh9XKn4mnP+ef+rtd+VkDaUCLOfNHvagqrNc7yAKGWXfNdDGg/LV/ELCp4X
         oZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W5JgDZ47PpKoS6/RBeTTl9F5vSjrYJh0ABGY/tAhVo4=;
        b=4D4XOIM6MaLCDKHltsdncaFfPpMfQgGTIlJxz4rTw2kz7tkNadLxI4a5i9LRMx9xf0
         Vc2+14LWSa4uYdKSoYkQd9/fguYwEHBfguvhkpp8YpvzR4sNtGW3tPeH9VkP90VFsXfD
         D/pENWzNZChlB8/2j1fZjZtY/ya/dxe5InafP6u3YGfiFSCcZFP8HtgWu94QoiGZolKN
         PFRWcQnLsV2HQePRm6LCENeW7DipyCVdWmsCG2yBWEknipr2eQis14AUnf51HuFP3uxu
         zrtAWpmxP/M4TZON085M1gmsMMB054IrOjrhErEjq+iejaXWeMJ5ZwE2KZSy03vCUSIz
         iF5A==
X-Gm-Message-State: AOAM530BbVrFzSuA4ZWhbgp4uCPyGkvcWsqi3JiJXt4kuOYH7Go6XGLB
        T1aDGf3Cg+JoijFAAIBrxOSkgv20Z0/7skZ3
X-Google-Smtp-Source: ABdhPJzfboFo/WAafGhzcLKtVHmhp66B4kC8NOWG/IoD2Gb+eROeBSFGZYM+S+U3R+7viYNsbqo3IQ==
X-Received: by 2002:a05:620a:1a08:b0:648:ac5c:37eb with SMTP id bk8-20020a05620a1a0800b00648ac5c37ebmr11275700qkb.49.1645568802032;
        Tue, 22 Feb 2022 14:26:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t19sm816035qtx.68.2022.02.22.14.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/13] btrfs-progs: rework the btrfs_node accessors to match the item accessors
Date:   Tue, 22 Feb 2022 17:26:22 -0500
Message-Id: <0e2f3e99b79aa4502f5ef94e2b9c42f2c99cc20e.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
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

We are duplicating the offsetof(btrfs_node, key_ptr) logic everywhere,
instead use the helper to do this work for us, and make all the node
accessors use the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 49 +++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 8b654dde..464a0f74 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1921,62 +1921,51 @@ BTRFS_SETGET_FUNCS(ref_count_v0, struct btrfs_extent_ref_v0, count, 32);
 BTRFS_SETGET_FUNCS(key_blockptr, struct btrfs_key_ptr, blockptr, 64);
 BTRFS_SETGET_FUNCS(key_generation, struct btrfs_key_ptr, generation, 64);
 
-static inline u64 btrfs_node_blockptr(struct extent_buffer *eb, int nr)
+static inline unsigned long btrfs_node_key_ptr_offset(int nr)
 {
-	unsigned long ptr;
-	ptr = offsetof(struct btrfs_node, ptrs) +
+	return offsetof(struct btrfs_node, ptrs) +
 		sizeof(struct btrfs_key_ptr) * nr;
-	return btrfs_key_blockptr(eb, (struct btrfs_key_ptr *)ptr);
+}
+
+static inline struct btrfs_key_ptr *btrfs_node_key_ptr(int nr)
+{
+	return (struct btrfs_key_ptr *)btrfs_node_key_ptr_offset(nr);
+}
+
+static inline u64 btrfs_node_blockptr(struct extent_buffer *eb, int nr)
+{
+	return btrfs_key_blockptr(eb, btrfs_node_key_ptr(nr));
 }
 
 static inline void btrfs_set_node_blockptr(struct extent_buffer *eb,
 					   int nr, u64 val)
 {
-	unsigned long ptr;
-	ptr = offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
-	btrfs_set_key_blockptr(eb, (struct btrfs_key_ptr *)ptr, val);
+	btrfs_set_key_blockptr(eb, btrfs_node_key_ptr(nr), val);
 }
 
 static inline u64 btrfs_node_ptr_generation(struct extent_buffer *eb, int nr)
 {
-	unsigned long ptr;
-	ptr = offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
-	return btrfs_key_generation(eb, (struct btrfs_key_ptr *)ptr);
+	return btrfs_key_generation(eb, btrfs_node_key_ptr(nr));
 }
 
 static inline void btrfs_set_node_ptr_generation(struct extent_buffer *eb,
 						 int nr, u64 val)
 {
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
+	btrfs_set_key_generation(eb, btrfs_node_key_ptr(nr), val);
 }
 
 static inline void btrfs_node_key(struct extent_buffer *eb,
 				  struct btrfs_disk_key *disk_key, int nr)
 {
-	unsigned long ptr;
-	ptr = btrfs_node_key_ptr_offset(nr);
-	read_eb_member(eb, (struct btrfs_key_ptr *)ptr,
-		       struct btrfs_key_ptr, key, disk_key);
+	read_eb_member(eb, btrfs_node_key_ptr(nr), struct btrfs_key_ptr, key,
+		       disk_key);
 }
 
 static inline void btrfs_set_node_key(struct extent_buffer *eb,
 				      struct btrfs_disk_key *disk_key, int nr)
 {
-	unsigned long ptr;
-	ptr = btrfs_node_key_ptr_offset(nr);
-	write_eb_member(eb, (struct btrfs_key_ptr *)ptr,
-		       struct btrfs_key_ptr, key, disk_key);
+	write_eb_member(eb, btrfs_node_key_ptr(nr), struct btrfs_key_ptr, key,
+			disk_key);
 }
 
 /* struct btrfs_item */
-- 
2.26.3

