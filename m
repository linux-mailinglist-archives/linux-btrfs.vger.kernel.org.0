Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD64D0B26
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbiCGWed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiCGWeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:31 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA5A473BD
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:36 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id jo29so969338qvb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0DC51lpZxbZ7yw5Y+vIfK+FJGMZibwL+D3EiCfFFkKM=;
        b=2TwnX2lR4UjZBqinj5JsOdMbyGzP9s36iok9fPgoqM8Q3aFE0fCEHbG45xxlTnGgVs
         Acd+mkGVqLnrn7VkTdKnIcyDaAooRh25otA/l9nO8hOILwHXKwZq6xB7VutTtuvG6y9M
         Wm8IW8MbVGm269xqCusRYwYKnF8Kb80iO5A3vtwrawxYWjhiGiIxxKLlgeVG44fXfrIK
         BuPnci6ODdgm9URy/xs9zlnykqe5ucJsrjyNMrpT65B9keYR0v7X9aj0Z9zq9LGb5jCk
         91U9qEgK62IHbxV/kH8c5frjtRdrvPxc4fEyBDVCQVA/IylD+Ldro9uxElLC1NdImxHB
         uWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0DC51lpZxbZ7yw5Y+vIfK+FJGMZibwL+D3EiCfFFkKM=;
        b=A+ujsjVOC8oi11ZbKXBY6njfBODTQBCJidkpjRl4IZxwdDU2Cw2SG4qaE7MDSvbAHY
         ClKWYT3l86g6Y1g4h1RtamD+9kRERnq+PhpQ5YODHdY5izAIT6a/v1TVt6KlOC+6PNxU
         8b8/WcL6EN7eYKfAZgzuiRzti5pgTVDdrQNbIb3GjMp7wyu8iuMHPrWv1R+erkz9pGui
         Fp1liq9IJNxgE6RmfJo0Mzw+vFI92gq4Hz5RYQmo328YmZJjiNQTfMel8RgV9mw3TPXM
         YjIqawPpa5VX5He6D/bROkZnmuifTdwH9jKptLCkljZ6w3JM5koN/nXMZ5q6gE1M0tb+
         +g6A==
X-Gm-Message-State: AOAM533fLDi+vI5M1ub0mdeTYz+DvqK9laJuxG7zSESqbmxw1QBZNAPn
        a7ymnqBtKCmCS2tZ+go3fM5n8PKRciQRCc1X
X-Google-Smtp-Source: ABdhPJxTtOzeY9BGyvbUOqMMWi+yZboJ63HaoHYTFpRExLEFHeR3VzBB3GNxuyJYDUhYUg6YHCNOJw==
X-Received: by 2002:ad4:5bc6:0:b0:435:a8fa:2694 with SMTP id t6-20020ad45bc6000000b00435a8fa2694mr1142127qvt.13.1646692415748;
        Mon, 07 Mar 2022 14:33:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e18-20020a05620a12d200b0066393782c89sm6596991qkl.64.2022.03.07.14.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/12] btrfs: add a btrfs_node_key_ptr helper, convert the users
Date:   Mon,  7 Mar 2022 17:33:21 -0500
Message-Id: <7c1a75affdac4955ed9430845e9dd7ae30aaff28.1646692306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692306.git.josef@toxicpanda.com>
References: <cover.1646692306.git.josef@toxicpanda.com>
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

All of the node helpers are getting the pointer offset and then casting
to btrfs_key_ptr.  Instead do this with a helper similar to how we do it
with items and change all the helpers to use the new helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 819bd8631c4c..d5d52b907143 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1958,61 +1958,51 @@ BTRFS_SETGET_STACK_FUNCS(stack_key_blockptr, struct btrfs_key_ptr,
 BTRFS_SETGET_STACK_FUNCS(stack_key_generation, struct btrfs_key_ptr,
 			 generation, 64);
 
-static inline u64 btrfs_node_blockptr(const struct extent_buffer *eb, int nr)
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
+static inline u64 btrfs_node_blockptr(const struct extent_buffer *eb, int nr)
+{
+	return btrfs_key_blockptr(eb, btrfs_node_key_ptr(nr));
 }
 
 static inline void btrfs_set_node_blockptr(const struct extent_buffer *eb,
 					   int nr, u64 val)
 {
-	unsigned long ptr;
-	ptr = offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
-	btrfs_set_key_blockptr(eb, (struct btrfs_key_ptr *)ptr, val);
+	btrfs_set_key_blockptr(eb, btrfs_node_key_ptr(nr), val);
 }
 
 static inline u64 btrfs_node_ptr_generation(const struct extent_buffer *eb, int nr)
 {
-	unsigned long ptr;
-	ptr = offsetof(struct btrfs_node, ptrs) +
-		sizeof(struct btrfs_key_ptr) * nr;
-	return btrfs_key_generation(eb, (struct btrfs_key_ptr *)ptr);
+	return btrfs_key_generation(eb, btrfs_node_key_ptr(nr));
 }
 
 static inline void btrfs_set_node_ptr_generation(const struct extent_buffer *eb,
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
 
 static inline void btrfs_node_key(const struct extent_buffer *eb,
 				  struct btrfs_disk_key *disk_key, int nr)
 {
-	unsigned long ptr = btrfs_node_key_ptr_offset(nr);
-	read_eb_member(eb, (struct btrfs_key_ptr *)ptr, struct btrfs_key_ptr,
-		       key, disk_key);
+	read_eb_member(eb, btrfs_node_key_ptr(nr), struct btrfs_key_ptr, key,
+		       disk_key);
 }
 
 static inline void btrfs_set_node_key(const struct extent_buffer *eb,
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

