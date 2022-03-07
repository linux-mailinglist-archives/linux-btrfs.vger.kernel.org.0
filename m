Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12BF4D0B2F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbiCGWeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343770AbiCGWem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:42 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0B056C06
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:47 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id j5so13232423qvs.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=c07p1kCh592hi27OmwfRWyd3fxBWsRY8d2qXElzIHmI=;
        b=H2p16WJxXUk/fbI3vo7S6kWkM77muPa419s21ExqY3ktwMg3lI3vV2A9xeYWV6JPbx
         0ZfdFCQ8Aw304QmLs+GuQ+QmFBi0enxCtAtKMxOaHHb2zl1Aq53WLvd15zTX7Y7Xl3ns
         pFNeIlCe2DZZovjfZ1mZNa5rOkOHx/eNODNf1IKEEsIdjmpjyYdFPdjqxDULSONVGYVf
         dzqJ/k93Q4iwT6qFzubH2ioQ1S8TjS/nQdlxVzGMmhgo9EKdX0+brqrl1a0udygyQMr5
         g04NW+eykLXqD4XHNlUYh2Ai+IBPdIm8u7+uBh9QDI35UU3QRzHns7HNTBqCz/oIlTVf
         k9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c07p1kCh592hi27OmwfRWyd3fxBWsRY8d2qXElzIHmI=;
        b=oQqNBTi53tVzV2tRq7TcMz+vbWdOha/k/BRxyzV1GRTYHoAmrH/jcbgLqoc3niJqgV
         KKmNp7NoQCZeO/BQRDwhp8UuNAN8kiQNjbtScGwD2B8+U08CpOtSkz+2D/vD4cBfgB/d
         up+9btHav84MRJWcLh9/NWw/d+Ew0WBHgt0Ca9aW1xnpN00qOaqQAA+vUv0Nek13jvH8
         KQTFeouGhoA1FsNMKey/57tWHO47HyOT17hn2iAVJmuzWpcm5JQJ6ysDWM0ZDvMabVnF
         01qjBetqRSwbCmjGokwnUMPZyaD54bgcG9ungSnaBEBQdCuuOysvsIU68oiXLv7ifxHN
         JRLg==
X-Gm-Message-State: AOAM531wAAy29LFAjjdtgVC/zu7KVbnZK74fQfbYw6TzndRl3TfDutpK
        8h62BXptodAjI5/BJSdK+mdgoBGr/Oh/S/j1
X-Google-Smtp-Source: ABdhPJwoUqy5IGrg2EXPSmbFIjfbvV06rUt9QqYHY4DYwZsxSq5PaDVbkuK54MC/TbCmwumxK1LSeA==
X-Received: by 2002:a05:6214:2684:b0:435:17c2:70fe with SMTP id gm4-20020a056214268400b0043517c270femr10406477qvb.78.1646692426541;
        Mon, 07 Mar 2022 14:33:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k125-20020a378883000000b006491db6dbb1sm6987915qkd.84.2022.03.07.14.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/12] btrfs: move BTRFS_LEAF related definitions below super SETGET funcs
Date:   Mon,  7 Mar 2022 17:33:29 -0500
Message-Id: <d9f03de2fc4315821bb84604f0f7e70614ef6682.1646692306.git.josef@toxicpanda.com>
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

We're going to need to do btrfs_fs_incompat(fs_info, EXTENT_TREE_V2),
which requires reading the super flags, so move these helpers below the
super SETGET funcs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 69 ++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f20ce33e5c68..8187e8ec457a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1430,41 +1430,6 @@ struct btrfs_file_private {
 	void *filldir_buf;
 };
 
-
-static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
-{
-
-	return info->nodesize - sizeof(struct btrfs_header);
-}
-
-static inline unsigned long BTRFS_LEAF_DATA_OFFSET(const struct extent_buffer *leaf)
-{
-	return offsetof(struct btrfs_leaf, items);
-}
-
-static inline u32 BTRFS_MAX_ITEM_SIZE(const struct btrfs_fs_info *info)
-{
-	return BTRFS_LEAF_DATA_SIZE(info) - sizeof(struct btrfs_item);
-}
-
-static inline u32 BTRFS_NODEPTRS_PER_BLOCK(const struct btrfs_fs_info *info)
-{
-	return BTRFS_LEAF_DATA_SIZE(info) / sizeof(struct btrfs_key_ptr);
-}
-
-#define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
-		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
-static inline u32 BTRFS_MAX_INLINE_DATA_SIZE(const struct btrfs_fs_info *info)
-{
-	return BTRFS_MAX_ITEM_SIZE(info) -
-	       BTRFS_FILE_EXTENT_INLINE_DATA_START;
-}
-
-static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
-{
-	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
-}
-
 /*
  * Flags for mount options.
  *
@@ -2219,6 +2184,40 @@ static inline void btrfs_set_item_key(struct extent_buffer *eb,
 	write_eb_member(eb, item, struct btrfs_item, key, disk_key);
 }
 
+static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
+{
+
+	return info->nodesize - sizeof(struct btrfs_header);
+}
+
+static inline unsigned long BTRFS_LEAF_DATA_OFFSET(const struct extent_buffer *leaf)
+{
+	return offsetof(struct btrfs_leaf, items);
+}
+
+static inline u32 BTRFS_MAX_ITEM_SIZE(const struct btrfs_fs_info *info)
+{
+	return BTRFS_LEAF_DATA_SIZE(info) - sizeof(struct btrfs_item);
+}
+
+static inline u32 BTRFS_NODEPTRS_PER_BLOCK(const struct btrfs_fs_info *info)
+{
+	return BTRFS_LEAF_DATA_SIZE(info) / sizeof(struct btrfs_key_ptr);
+}
+
+#define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
+		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
+static inline u32 BTRFS_MAX_INLINE_DATA_SIZE(const struct btrfs_fs_info *info)
+{
+	return BTRFS_MAX_ITEM_SIZE(info) -
+	       BTRFS_FILE_EXTENT_INLINE_DATA_START;
+}
+
+static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
+{
+	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
+}
+
 BTRFS_SETGET_FUNCS(dir_log_end, struct btrfs_dir_log_item, end, 64);
 
 /*
-- 
2.26.3

