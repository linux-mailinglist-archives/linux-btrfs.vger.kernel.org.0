Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131B04BB695
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 11:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiBRKON (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 05:14:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiBRKOK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 05:14:10 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EF06CA4B;
        Fri, 18 Feb 2022 02:13:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4p-IfJ_1645179227;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V4p-IfJ_1645179227)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Feb 2022 18:13:51 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] btrfs: Fix non-kernel-doc comment
Date:   Fri, 18 Feb 2022 18:13:45 +0800
Message-Id: <20220218101345.125518-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes the following W=1 kernel build warning:

fs/btrfs/ioctl.c:1789: warning: This comment starts with '/**', but
isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Entry point to file defragmentation.

fs/btrfs/extent_map.c:390: warning: This comment starts with '/**', but
isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Add new extent map to the extent tree.

fs/btrfs/block-group.c:1743: warning: This comment starts with '/**',
but isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst
 * Map a physical disk address to a list of logical addresses.

fs/btrfs/extent_io.c:4923: warning: This comment starts with '/**', but
isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Walk the list of dirty pages of the given address space and write all
 * of them.

fs/btrfs/file-item.c:625: warning: This comment starts with '/**', but
isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Calculate checksums of the data contained inside a bio.

fs/btrfs/inode.c:3430: warning: This comment starts with '/**', but
isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Wait for flushing all delayed iputs

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/block-group.c | 2 +-
 fs/btrfs/extent_io.c   | 2 +-
 fs/btrfs/extent_map.c  | 2 +-
 fs/btrfs/file-item.c   | 2 +-
 fs/btrfs/inode.c       | 2 +-
 fs/btrfs/ioctl.c       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c22d287e020b..884002e510ec 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1739,7 +1739,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 	write_sequnlock(&fs_info->profiles_lock);
 }
 
-/**
+/*
  * Map a physical disk address to a list of logical addresses
  *
  * @fs_info:       the filesystem
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d5a8064e3206..2da140200de8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4919,7 +4919,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	return ret;
 }
 
-/**
+/*
  * Walk the list of dirty pages of the given address space and write all of them.
  *
  * @mapping: address space structure to write
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 6fee14ce2e6b..984f183413c2 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -386,7 +386,7 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
 	}
 }
 
-/**
+/*
  * Add new extent map to the extent tree
  *
  * @tree:	tree to insert new map in
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 364bfca1cc06..96b30369fa26 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -621,7 +621,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 	return ret;
 }
 
-/**
+/*
  * Calculate checksums of the data contained inside a bio
  *
  * @inode:	 Owner of the data inside the bio
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 44e8d28182b7..8ccc3818eebe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3430,7 +3430,7 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->delayed_iput_lock);
 }
 
-/**
+/*
  * Wait for flushing all delayed iputs
  *
  * @fs_info:  the filesystem
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 998bf48e5ce2..c84cc2efff77 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1785,7 +1785,7 @@ int btrfs_defrag_ioctl_args_to_ctrl(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-/**
+/*
  * Entry point to file defragmentation.
  *
  * @inode:	   inode to be defragged
-- 
2.20.1.7.g153144c

