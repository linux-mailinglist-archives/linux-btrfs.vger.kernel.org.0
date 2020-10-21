Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A717295505
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 01:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507024AbgJUXHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 19:07:14 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33247 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507008AbgJUXHO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 19:07:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 273BE12A9;
        Wed, 21 Oct 2020 19:07:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Oct 2020 19:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=cUalwwj9NKtu4
        GZyJd22wlWTDhhEwMEdZHSuXEnuKh0=; b=CxwJFQKR7q7tS1jQIpGJCfIAmIEWy
        8upJmxdYPLogsD33ffXXjx1s4wCdAb9lpcc52+XECxsUOnW05VzbhQHrwAtDPFB2
        VnMWgjziWCpRzMtKEPlWA+z7iwNJQX+UiCnmm+qhpqggim1QCH6XmarCfG2KiSvL
        TwcyTH6TqGOhVr5ug3aAkSlKEJFmoX06YvJjazv+gpLLPZQycuSKq6vNatmTcZUE
        8nFr6lNlLaCia8cLinJGfH5D2dWMXNstsJ41B0+N2prIHrP44hWLg8ZDUx9bjZlm
        MbUL/KxdwWV2Y0cGy673pNAagu+1slSRirlXs9L/jsPYYwoqLqtpGhzXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=cUalwwj9NKtu4GZyJd22wlWTDhhEwMEdZHSuXEnuKh0=; b=peY5HlJG
        wR70wrs2YkG+GAys3dwR7p2T5EuBnXUfqacXCwwgw+REx40DGQMSqgH8Y3ViNTma
        +hPURbqxHgXccJlPqoIgAfI65COhODfAmQN6qVauc8rimCL9wyY0HeIQu6KLZ0ND
        Ak8Kdd3SKxya1ULTV1nEyoza1puqltEgs3vlq835jPugOC1t0MKoCfUx0zVW1r3H
        siPa9wA6VygCLKr/FVlDtoSGxCn4WYUzh6MdGlMkz4az66YaIeJOGpxEHLGApsIQ
        5n35eQzvsyFK65VPuoai0hEvxIn64WM1FMW9evUJQwaetiDjO2gVQPEMy3muL9cD
        1amCgq9wW5Tziw==
X-ME-Sender: <xms:IL-QX-8PauHA04IrSsV_9N1retmOjo0MueTsMTssVF5e8DwLitHnrQ>
    <xme:IL-QX-uew35ZTj2FGxCjUohxNqitw00JAx4Rg2BDsXVHf_Scwjm3JBuneNQJfyIsv
    MdtFZwbu97iqf7Cn5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:IL-QX0AkFvzrf-zl3kg4larEJgi8lSNl6Zt384nXnGuI2Aukk0K4jw>
    <xmx:IL-QX2db4mkI46OqZyJ1dTZIU8o7VMcmaHA3aLcmGcij0g6NQrRmBQ>
    <xmx:IL-QXzM5t0TDDPNX_x5uRzvFjau_NFA3dESgbAYlB9ujCeY5JSMMJA>
    <xmx:IL-QX1WJ62R3_mAShCXHiduJcKJLKwv9dU-TCsX8N5t-CjsA1SgmXw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5607C3064674;
        Wed, 21 Oct 2020 19:07:12 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v4 4/8] btrfs: keep sb cache_generation consistent with space_cache
Date:   Wed, 21 Oct 2020 16:06:32 -0700
Message-Id: <99b747e128a4fa1891e6eef76c0fa1e9d65e8a7d.1603318242.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603318242.git.boris@bur.io>
References: <cover.1603318242.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When mounting, btrfs uses the cache_generation in the super block to
determine if space cache v1 is in use. However, by mounting with
nospace_cache or space_cache=v2, it is possible to disable space cache
v1, which does not result in un-setting cache_generation back to 0.

In order to base some logic, like mount option printing in /proc/mounts,
on the current state of the space cache rather than just the values of
the mount option, keep the value of cache_generation consistent with the
status of space cache v1.

We ensure that cache_generation > 0 iff the file system is using
space_cache v1. This requires committing a transaction on any mount
which changes whether we are using v1. (v1->nospace_cache, v1->v2,
nospace_cache->v1, v2->v1).

Since the mechanism for writing out the cache generation is transaction
commit, but we want some finer grained control over when we un-set it,
we can't just rely on the SPACE_CACHE mount option, and introduce an
fs_info flag that mount can use when it wants to unset the generation.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ctree.h            |  3 +++
 fs/btrfs/disk-io.c          |  8 ++++++++
 fs/btrfs/free-space-cache.c | 28 ++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  3 +++
 fs/btrfs/super.c            |  4 +---
 fs/btrfs/transaction.c      |  2 ++
 6 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aac3d6f4e35b..0ee85bf82cab 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -559,6 +559,9 @@ enum {
 
 	/* Indicate that the discard workqueue can service discards. */
 	BTRFS_FS_DISCARD_RUNNING,
+
+	/* Indicate that we need to cleanup space cache v1 */
+	BTRFS_FS_CLEANUP_SPACE_CACHE_V1,
 };
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5fe0a2640c8a..f645ffdd2c7e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2821,6 +2821,7 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
 int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 {
 	int ret;
+	bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
 
 	ret = btrfs_cleanup_fs_roots(fs_info);
 	if (ret)
@@ -2853,6 +2854,12 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 		}
 	}
 
+	if (cache_opt != btrfs_free_space_cache_v1_active(fs_info)) {
+		ret = btrfs_set_free_space_cache_v1_active(fs_info, cache_opt);
+		if (ret)
+			goto out;
+	}
+
 	ret = btrfs_resume_balance_async(fs_info);
 	if (ret)
 		goto out;
@@ -3335,6 +3342,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			return ret;
 		}
 	}
+
 	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 
 	/*
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index af0013d3df63..3acf935536ea 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3992,6 +3992,34 @@ int btrfs_write_out_ino_cache(struct btrfs_root *root,
 	return ret;
 }
 
+bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info)
+{
+	return btrfs_super_cache_generation(fs_info->super_copy);
+}
+
+int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info,
+					 bool active)
+{
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	/*
+	 * update_super_roots will appropriately set
+	 * fs_info->super_copy->cache_generation based on the SPACE_CACHE
+	 * option, so all we have to do is trigger a transaction commit.
+	 */
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	if (!active)
+		set_bit(BTRFS_FS_CLEANUP_SPACE_CACHE_V1, &fs_info->flags);
+
+	ret = btrfs_commit_transaction(trans);
+	clear_bit(BTRFS_FS_CLEANUP_SPACE_CACHE_V1, &fs_info->flags);
+	return ret;
+}
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 /*
  * Use this if you need to make a bitmap or extent entry specifically, it
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index e3d5e0ad8f8e..5c546898ded9 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -148,6 +148,9 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
 				   u64 maxlen, bool async);
 
+bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info);
+int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info,
+					 bool active);
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int test_add_free_space_entry(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 56bfa23bc52f..fd3dbf419072 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -511,7 +511,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *p, *num;
-	u64 cache_gen;
 	int intarg;
 	int ret = 0;
 	char *compress_type;
@@ -521,10 +520,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	bool saved_compress_force;
 	int no_compress = 0;
 
-	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
+	else if (btrfs_free_space_cache_v1_active(info))
 		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
 
 	/*
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 52ada47aff50..c350fc59784b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1761,6 +1761,8 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
 	super->root_level = root_item->level;
 	if (btrfs_test_opt(fs_info, SPACE_CACHE))
 		super->cache_generation = root_item->generation;
+	else if (test_bit(BTRFS_FS_CLEANUP_SPACE_CACHE_V1, &fs_info->flags))
+		super->cache_generation = 0;
 	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
 		super->uuid_tree_generation = root_item->generation;
 }
-- 
2.24.1

