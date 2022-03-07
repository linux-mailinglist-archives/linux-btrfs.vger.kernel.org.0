Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0F4D0AB5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbiCGWOa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiCGWO2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:28 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DC56752
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:33 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b13so13246200qkj.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aR5H67p80QaGm4kWm8hl8iHVfa74mei70hJM+qkVMew=;
        b=UsOWDOqdhGcbDBT8CmgIWeMMN98gE+FPlENYGXBR7sEEW5J4OuiWV/gJPRISSXWFVZ
         UUhzXeFMWJrSGX+cCByAT3s1U88NjtOaa1tychjzVf0pBRfG95x9sk+zt2MhWm5egntr
         9B+J5azVU3I+FYC5MO5BWeI59CIZkRzieoLA5tcIjkvGPBYQ/qrdux7e5mtG2S5m5UH2
         0YjCKNtyR56VcqnAJyEa+UjI0Ibr7YCMwLFginrUrnzppEKu97pJoaYXrdL8tD4wrIw3
         xBI9wLWuZ8qcMRJr/KasRiBm0GIU19Lruq4YDH16hV7mQ9ppI9KzfzD0U8UQO5ESG/DM
         9T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aR5H67p80QaGm4kWm8hl8iHVfa74mei70hJM+qkVMew=;
        b=I0TKsjeHFV5i0MEE0hGOVn4GBwUtAYt++UZ2PR5cb9E919j+HoczHqD4/O9KwVqptZ
         RkSb5J7FHLEwy9x5eGxiesV5QmRCM2kQ3xciiwCpy6ojCY1gxpx9zU6TjEomF1K3BhNz
         VFxphQEBWvcXlsdg13uYzFv4dzqSgh2wiWumGXYTtw6d4fv+t1N2pR3bHzRAvVPd7q2g
         fkKIKSOeS8z7XwUB9rys7XRbawVR0Z/JmNzzkdnTWgmBE2tqdAb6OBD13fQEncfRfJ/B
         bUyRYjmraVC1koWVWyHmIFSgjENP/qA1L7Rk9gmOFyBYzyubmb3TvkzDDaM7JJ831TVW
         lOnQ==
X-Gm-Message-State: AOAM530SxuY3/2f6kv+YCw68dVoh4qcXtPrSDV96ehww/TmuuHiICxCO
        sDMXFB08F3wB1Ai9EEg6jPkVpABX/Qqz613J
X-Google-Smtp-Source: ABdhPJxXwyKaT9YJ3q018t+cMI4VJwaQ32ThK03ZkaKVNFrj5LhT8Cel7xKn7b7hHQTVyEyF/WrvZA==
X-Received: by 2002:a37:6cd:0:b0:67b:118d:81e8 with SMTP id 196-20020a3706cd000000b0067b118d81e8mr6465479qkg.88.1646691212313;
        Mon, 07 Mar 2022 14:13:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l22-20020a05620a0c1600b0067b18b1b053sm2338277qki.78.2022.03.07.14.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/15] btrfs-progs: do not insert extent items for metadata for extent tree v2
Date:   Mon,  7 Mar 2022 17:13:12 -0500
Message-Id: <2d85cdac99c9105db48c7352ff2c8f61aa86b4ba.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
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

For extent tree v2 we are no longer tracking metadata blocks in the
extent tree, so simply skip this step and remove the space from the free
space tree and do the block group accounting.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 0db0f32d..89b286c6 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2392,6 +2392,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	ASSERT(sinfo);
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		goto alloc;
+
 	ins.objectid = node->bytenr;
 	if (skinny_metadata) {
 		ins.offset = ref->level;
@@ -2445,11 +2448,12 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_free_path(path);
 
-	ret = remove_from_free_space_tree(trans, ins.objectid, fs_info->nodesize);
+alloc:
+	ret = remove_from_free_space_tree(trans, node->bytenr, fs_info->nodesize);
 	if (ret)
 		return ret;
 
-	ret = update_block_group(trans, ins.objectid, fs_info->nodesize, 1, 0);
+	ret = update_block_group(trans, node->bytenr, fs_info->nodesize, 1, 0);
 	if (sinfo) {
 		if (fs_info->nodesize > sinfo->bytes_reserved) {
 			WARN_ON(1);
-- 
2.26.3

