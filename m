Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86264D0A9D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245755AbiCGWMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbiCGWMT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:19 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC8D81896
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:24 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id t18so3663249qtw.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rpchLNxZ2YFN8sNQVTPTBKLgINOHwrU5vgt1oTinbEA=;
        b=SHSUY9i5OhvA0nkDbN/y3vbTchVKPG7TTchAaAQonViAbzBfjmrcCP9ORRoWi227xP
         RexBH0Yi8Y4NwTUW8LGpDxmOFGK5Jn4P4VIr4np5GWWmyCy3oVZ0k3cuG9WZ3viYG0eS
         aYNyhtwuiukzN59vtY1Uti945E4jgoD3O+FrkYKh5ZXu29nk91RgWEGhV6HpE1dGbLWa
         fcPwOI5s3GuDu46Cdb56rDAh9A8QyD0x+fkuGkKQAu0yKk9Ig9P1Ub/zz0yOCDDh+pru
         lFXcgmNK7sGMvlZR+oWHfJ5pr5hYQTXmh5wiofvulBhyaQYUlvytgdO8vnjwSPNGcZn1
         J6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpchLNxZ2YFN8sNQVTPTBKLgINOHwrU5vgt1oTinbEA=;
        b=DaUagwfxKotxI9W7KJmy+kJQ5m+TGwQXqGlQfMZIxSvTYTbBWjhEN5NFcrWjgTHR3C
         E2epqfN6FMZiUaN7Xi7JlnTy8zykgW1thpFzDOugaAe2LAdUy8IMs6UgpHFsGlkPqaXC
         t7HhH729eteIqzjnRhCGBQzMIXumKqqNweAoC+nahJsLVCuHgBCpfhQeVWCoo6/ecIe2
         uiYK2PM08jMrTl/ViiXy0SbbciHH1763QirvtF6wonzeRBJAYitamrlDgkDtXe8ZlPPN
         9Ef/gJO2UQaraYacRxhJc9DT5FuBDKj421zf/hJEQwMwWVUlTOPp3J7haKP/x5oyDhIo
         BnOA==
X-Gm-Message-State: AOAM5308zcLdBD38gWxfWcNdz+mduPwdnH9v41UgHPvRcww/Ar33PmVp
        HKRxX28oDZcuj/gbINAW5HFDTMXr9AffqjOi
X-Google-Smtp-Source: ABdhPJyuNe2jv3F7QJHjB2E7D6HQAcOoCIpmliIQ7tyMtxq/XvB3tuUkHRDs53wcCF+Eb5HF0/TJxw==
X-Received: by 2002:ac8:5812:0:b0:2dd:d9df:9742 with SMTP id g18-20020ac85812000000b002ddd9df9742mr11234190qtg.21.1646691083066;
        Mon, 07 Mar 2022 14:11:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w140-20020a376292000000b00648e88c1f05sm6958258qkb.67.2022.03.07.14.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 12/19] btrfs-progs: set the number of global roots in the super block
Date:   Mon,  7 Mar 2022 17:10:57 -0500
Message-Id: <1c28a05081455379be5d91ee760f9a03e4255e6a.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
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

In order to make sure the file system is consistent we need to record
the number of global roots we should have in the super block.  We could
infer this from the number of global roots we find, however this could
lead to interesting fuzzing problems, so add a source of truth to the
super block in order to make it easier to verify the file system is
consistent.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h   | 6 +++++-
 kernel-shared/disk-io.c | 4 ++++
 mkfs/common.c           | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index b12dbff1..90de7a65 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -463,13 +463,15 @@ struct btrfs_super_block {
 
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 
+	__le64 nr_global_roots;
+
 	__le64 block_group_root;
 	__le64 block_group_root_generation;
 	u8 block_group_root_level;
 
 	/* future expansion */
 	u8 reserved8[7];
-	__le64 reserved[25];
+	__le64 reserved[24];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
 	/* Padded to 4096 bytes */
@@ -2372,6 +2374,8 @@ BTRFS_SETGET_STACK_FUNCS(super_block_group_root_generation,
 			 block_group_root_generation, 64);
 BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level,
 			 struct btrfs_super_block, block_group_root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
+			 nr_global_roots, 64);
 
 static inline unsigned long btrfs_leaf_data(struct extent_buffer *l)
 {
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3d1157ad..fcef6e97 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1620,6 +1620,10 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 	if (ret)
 		goto out_devices;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		fs_info->nr_global_roots =
+			btrfs_super_nr_global_roots(fs_info->super_copy);
+
 	/*
 	 * fs_info->zone_size (and zoned) are not known before reading the
 	 * chunk tree, so it's 0 at this point. But, fs_info->zoned == 0
diff --git a/mkfs/common.c b/mkfs/common.c
index aa65543b..eac8c46c 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -355,6 +355,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		btrfs_set_super_cache_generation(&super, 0);
 	}
 	if (extent_tree_v2) {
+		btrfs_set_super_nr_global_roots(&super, 1);
 		btrfs_set_super_block_group_root(&super,
 						 cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
 		btrfs_set_super_block_group_root_generation(&super, 1);
-- 
2.26.3

