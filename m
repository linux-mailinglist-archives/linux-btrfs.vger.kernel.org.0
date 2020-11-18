Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF72B881E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgKRXGr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:47 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47931 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbgKRXGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:47 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 88710C26;
        Wed, 18 Nov 2020 18:07:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=NtYMKEr1oTPdgO9zfRrUA1bso9
        gwh9bSN2J2t4mN214=; b=U4mmKK1MAtLuHjNn6vmNx8jQhaGfDCB4QW1tRk7pxH
        +8Fj+HmjBfHGij3SHcTkx0NT17Yp/DwHjwk6WMh7sQVvwo64FMXttm7fXFhvgsrj
        wqH/ln78vjPXWsWlfoe99mcHt9o3YmLyj9SbynsXlN7h8kbyRVj7xi/8rL8s3lwN
        Fei3gDHm46YxtW0T2DELat6G2mN6uaB8eD5t1FKO5v4p8fgoXQfgOpb/Toy6Wy+O
        E1j4EgYRmP5zSoOMcUM5k6xKIOD6eCWxCvWXqsx2FRTiVgPF/H45qCFISbItFgQw
        VqXqyLUEhVZkwaAF8mgTXUPk91MEolCw94f6oxliI6Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=NtYMKEr1oTPdgO9zfRrUA1bso9gwh9bSN2J2t4mN214=; b=p5gvfLQ3
        hPREmumtAfUx34VHbj0yt8y0zOUyxNIJX7ubRa9dj1N60QXRHmuX3/kOcEitlz6V
        hGCA4zMHzJAk5Um3zhW+t6xpu79B5WFja5RGy+RoLycFP932EyTzPlnswEwhuWbE
        I+6pK5v55bnp0Oq1SaXDRAGDX9SXOdZB8qK+P/6q39PFt/mS8Ga7Rz5UY82cu1uL
        +hAVexv//zPaXr+hyvHNCnREPriI+1dGOYWVmT6mhtH2/sTX/pVHpUHV//Vb6OBC
        RgNAJhCzjZJ73JugwnnUMK5RJT7kQqJnxIjPH6ZQIktRngFIvc+gHLgHl8zzql9b
        fG+BdMHSu0/wiQ==
X-ME-Sender: <xms:F6m1X0PvgYP2mSukwlGuZ0nRJZvg3bej-hmkULTYANflbXE3Xphp5g>
    <xme:F6m1X68tA6_IiwrDscF2EOSjSGlm8Aj1nS9fnesHdXv4-KgeL2ZO0jc8MTbTUQR8n
    cypiAN04t1xUveNIhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:F6m1X7QFGjYCsuqTrxfQVHXqKUwLCGrt6TMvRqb-AZnQT_5wHk5Ijw>
    <xmx:F6m1X8uRBwlG_2ypBP3SbIsDS7atPanJwO8k4BmTlXrpAOBChOF-zw>
    <xmx:F6m1X8c5nVLJpPuWenxOHILeaxgHrEJvr9fgq6sVC5CWPNXhb89lUQ>
    <xmx:F6m1X2rH10MdpsZnukmdVSqVU73SchpLT6DwEV3LCGq-MqBaoznjQw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E576328005E;
        Wed, 18 Nov 2020 18:07:02 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 07/12] btrfs: keep sb cache_generation consistent with space_cache
Date:   Wed, 18 Nov 2020 15:06:22 -0800
Message-Id: <0f6e0287a267344f285cc458919e1c5595dfd26d.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
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
 fs/btrfs/super.c            | 10 +++++++---
 fs/btrfs/transaction.c      |  2 ++
 6 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cb90a870b235..318303f53529 100644
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
index 64e5707f008b..fea467c421e7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2902,6 +2902,7 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 {
 	int ret;
+	bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
 	bool clear_free_space_tree = false;
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
@@ -2955,6 +2956,12 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
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
@@ -3418,6 +3425,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			return ret;
 		}
 	}
+
 	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 
 clear_oneshot:
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 572c75d2169b..48f7bd050909 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3971,6 +3971,34 @@ int btrfs_write_out_ino_cache(struct btrfs_root *root,
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
index bf8d127d2407..8f4bc5781cd3 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -149,6 +149,9 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
 				   u64 maxlen, bool async);
 
+bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info);
+int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info,
+					 bool active);
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int test_add_free_space_entry(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index cca00cc0c98c..ff19f900cee1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -547,7 +547,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *p, *num;
-	u64 cache_gen;
 	int intarg;
 	int ret = 0;
 	char *compress_type;
@@ -557,10 +556,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	bool saved_compress_force;
 	int no_compress = 0;
 
-	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
+	else if (btrfs_free_space_cache_v1_active(info))
 		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
 
 	/*
@@ -1857,6 +1855,8 @@ static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
 static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 					 unsigned long old_opts)
 {
+	bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
+
 	/*
 	 * We need to cleanup all defragable inodes if the autodefragment is
 	 * close or the filesystem is read only.
@@ -1873,6 +1873,10 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 	else if (btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
 		 !btrfs_test_opt(fs_info, DISCARD_ASYNC))
 		btrfs_discard_cleanup(fs_info);
+
+	/* If we toggled space cache */
+	if (cache_opt != btrfs_free_space_cache_v1_active(fs_info))
+		btrfs_set_free_space_cache_v1_active(fs_info, cache_opt);
 }
 
 static int btrfs_remount(struct super_block *sb, int *flags, char *data)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0e4063651047..43253b9996c3 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1801,6 +1801,8 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
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

