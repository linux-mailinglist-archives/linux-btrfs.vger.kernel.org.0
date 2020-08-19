Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525C424A17A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgHSOQv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 10:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgHSOQs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 10:16:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760CC2076E;
        Wed, 19 Aug 2020 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597846607;
        bh=8DPsRnor12v9Pb8VDrFGF+YIO51Lu+LBxl/J6UN3O4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LK1hSdAZVL/0Fd4AtD1pI03/B05OF5KwmVX3n3qHNLzWJZNg8PfXbq3mxZkh5pSk3
         uYxq2MtVx1Pvkhm7ZvhJkjkXBAGCMxVQCqA3jS/pRjhwbX074PffRSEnhw4k9h+HKW
         qAOwuCNbAeQQoqi02Viv8jvVUfxPpirf8664fxp4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] fs/btrfs: Fix -Wignored-qualifiers warnings
Date:   Wed, 19 Aug 2020 17:16:29 +0300
Message-Id: <20200819141630.1338693-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819141630.1338693-1-leon@kernel.org>
References: <20200819141630.1338693-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Change function declarations to avoid the following GCC warnings
while compiling with W=1 level.

 In file included from fs/btrfs/volumes.c:28:
 fs/btrfs/sysfs.h:16:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    16 | const char * const btrfs_feature_set_name(enum btrfs_feature_set set);
       | ^~~~~
 In file included from fs/btrfs/ioctl.c:29:
 fs/btrfs/ctree.h:2265:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
  2265 | size_t __const btrfs_get_num_csums(void);
       |        ^~~~~~~

Fixes: f7cea56c0fff ("btrfs: sysfs: export supported checksums")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 fs/btrfs/ctree.c | 2 +-
 fs/btrfs/ctree.h | 2 +-
 fs/btrfs/sysfs.c | 2 +-
 fs/btrfs/sysfs.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 70e49d8d4f6c..9d71d44137a5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -68,7 +68,7 @@ const char *btrfs_super_csum_driver(u16 csum_type)
 		btrfs_csums[csum_type].name;
 }

-size_t __const btrfs_get_num_csums(void)
+__attribute_const__ size_t btrfs_get_num_csums(void)
 {
 	return ARRAY_SIZE(btrfs_csums);
 }
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9c7e466f27a9..e4fd6ad48799 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2262,7 +2262,7 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
 const char *btrfs_super_csum_driver(u16 csum_type);
-size_t __const btrfs_get_num_csums(void);
+__attribute_const__ size_t btrfs_get_num_csums(void);


 /*
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d3652bcc2a86..c22b7f47f6f8 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -973,7 +973,7 @@ static const char * const btrfs_feature_set_names[FEAT_MAX] = {
 	[FEAT_INCOMPAT]	 = "incompat",
 };

-const char * const btrfs_feature_set_name(enum btrfs_feature_set set)
+const char *btrfs_feature_set_name(enum btrfs_feature_set set)
 {
 	return btrfs_feature_set_names[set];
 }
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index cf839c46a131..e6eac2811f92 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -13,7 +13,7 @@ enum btrfs_feature_set {
 };

 char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags);
-const char * const btrfs_feature_set_name(enum btrfs_feature_set set);
+const char *btrfs_feature_set_name(enum btrfs_feature_set set);
 int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device);
 int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
--
2.26.2

