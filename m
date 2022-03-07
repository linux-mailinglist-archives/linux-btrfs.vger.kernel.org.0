Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320D64D0B2B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbiCGWen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343787AbiCGWel (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:41 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779014F458
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:46 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id b12so13292517qvk.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uYfHwHKs4UbEj0NN4QTiyInYtBiXlPu7eS0eQhQvVkg=;
        b=eCZz0+iqLkzs4IeR/6Rfzi5kyc08sovj08ISDx8Dkg3j5899uR/KgHF87jqhOlPjPN
         sWmBuLVJZiG2DhGFPsFdMhMG/TcAB4MScUS1PaMIGgX93ec96H7fuNeLFRQhh1Hkj5YF
         zGxfXM2qOWOPTuqU2as1L/Ex0t/BnFulwZirbgdqk8GdIoGPykl9Bb4/BHg2GJR/ZfcK
         1w/bmJaZW0VIZesypEqFb2jop3ecK0UriF4BPXIV40dfofZS6swGIHSDuOFUjZMHCPuJ
         DA804dZqA89yC4F4sUaNeEMVgkXf+Kl0Iz7HUvfLdRWb0xpDIGVIKtgqbDCozJBpHe7o
         7HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYfHwHKs4UbEj0NN4QTiyInYtBiXlPu7eS0eQhQvVkg=;
        b=Ov3egbjOJUomvR3DsKZEwZQfBlMXzofr4OLVzbEziTUfdF32acUlr8kOadz15zmgzO
         bvkYPFF2fgK/wI15j9kXAq9X9HJRg6M8IgkhV+vGjHQ4R3XB+qXMeyVw9Gzkxi+XlY6D
         z3GeWxUpLL7aPibRvfkjZkWGWGHVvP31s44ER12Y6FD0CpWBh/M7zIdmx8gd2QVGxpaO
         UKCGmxYYIVClNuaTQY/WkgaQq7o875xbjxo2e57Em2AgLXQvi7YsWmeTA0d9PsYEqHvS
         EFnG5cb82H58wW09CNOhOx71HpX06pxOY0mfRsGwK/Apf8IhJL4h8mqrvBP0Wc6AbCkz
         YjHw==
X-Gm-Message-State: AOAM5337h0/YinOcgzv8a4JHZ9jzRbO+g9DdA8HH31l55Iio+1V2seBn
        REVN/+fLM/kM8Yiq05jVJYlQsrEa0jK764P7
X-Google-Smtp-Source: ABdhPJx8iS51+OKFS2tIMFmAB785HWlO5yM5OkQ8tE+AyqNHmuanohuLF8ZUqtlbvvXXD8nydWhVig==
X-Received: by 2002:a05:6214:27c4:b0:435:4c2b:be19 with SMTP id ge4-20020a05621427c400b004354c2bbe19mr10060387qvb.34.1646692425301;
        Mon, 07 Mar 2022 14:33:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g202-20020a379dd3000000b0047d87ec72bbsm6882800qke.28.2022.03.07.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/12] btrfs: move the super SETGET funcs
Date:   Mon,  7 Mar 2022 17:33:28 -0500
Message-Id: <eb83cc79b901786fead16b64e908c35c6d9bba5c.1646692306.git.josef@toxicpanda.com>
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

Some of the helpers are going to need to check fs_incompat flags, so we
need these helpers to be higher up in ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 158 +++++++++++++++++++++++------------------------
 1 file changed, 79 insertions(+), 79 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 57b68115fa1e..f20ce33e5c68 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1769,6 +1769,85 @@ static inline void btrfs_set_header_backref_rev(struct extent_buffer *eb,
 	btrfs_set_header_flags(eb, flags);
 }
 
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
+BTRFS_SETGET_STACK_FUNCS(super_log_root_transid, struct btrfs_super_block,
+			 log_root_transid, 64);
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
+BTRFS_SETGET_STACK_FUNCS(super_block_group_root, struct btrfs_super_block,
+			 block_group_root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_block_group_root_generation,
+			 struct btrfs_super_block,
+			 block_group_root_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level, struct btrfs_super_block,
+			 block_group_root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
+			 nr_global_roots, 64);
+
+#define btrfs_fs_incompat(fs_info, opt) \
+	__btrfs_fs_incompat((fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
+
+static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
+{
+	struct btrfs_super_block *disk_super;
+	disk_super = fs_info->super_copy;
+	return !!(btrfs_super_incompat_flags(disk_super) & flag);
+}
+
+#define btrfs_fs_compat_ro(fs_info, opt) \
+	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
+
+static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
+{
+	struct btrfs_super_block *disk_super;
+	disk_super = fs_info->super_copy;
+	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
+}
+
 static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
 					   struct btrfs_dev_item *s)
 {
@@ -2489,65 +2568,6 @@ btrfs_cpu_balance_args_to_disk(struct btrfs_disk_balance_args *disk,
 	disk->stripes_max = cpu_to_le32(cpu->stripes_max);
 }
 
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
-BTRFS_SETGET_STACK_FUNCS(super_log_root_transid, struct btrfs_super_block,
-			 log_root_transid, 64);
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
-BTRFS_SETGET_STACK_FUNCS(super_block_group_root, struct btrfs_super_block,
-			 block_group_root, 64);
-BTRFS_SETGET_STACK_FUNCS(super_block_group_root_generation,
-			 struct btrfs_super_block,
-			 block_group_root_generation, 64);
-BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level, struct btrfs_super_block,
-			 block_group_root_level, 8);
-BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
-			 nr_global_roots, 64);
-
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
 const char *btrfs_super_csum_driver(u16 csum_type);
@@ -3773,16 +3793,6 @@ static inline void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info,
 	}
 }
 
-#define btrfs_fs_incompat(fs_info, opt) \
-	__btrfs_fs_incompat((fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
-
-static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
-{
-	struct btrfs_super_block *disk_super;
-	disk_super = fs_info->super_copy;
-	return !!(btrfs_super_incompat_flags(disk_super) & flag);
-}
-
 #define btrfs_set_fs_compat_ro(__fs_info, opt) \
 	__btrfs_set_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, \
 				 #opt)
@@ -3835,16 +3845,6 @@ static inline void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info,
 	}
 }
 
-#define btrfs_fs_compat_ro(fs_info, opt) \
-	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
-
-static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
-{
-	struct btrfs_super_block *disk_super;
-	disk_super = fs_info->super_copy;
-	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
-}
-
 /* acl.c */
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
-- 
2.26.3

