Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456A229F952
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJ2X6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57573 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X6V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:21 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D03D5C009D;
        Thu, 29 Oct 2020 19:58:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=ksYImFW6lXcAU4pNykS8SPFd0D
        RQUpaAsetXXJYMSDs=; b=JKFGY3xIA/ANkJAGgEhX4nJHVVVrixccdEmpfaN30N
        XWhCq89wDnzTUukfQEyd5Jb3qIv41cchV2WXUbmkrZqFq90Gjgb3UJZ4buB5V0Hf
        5evBsSAU11uJtcCOZMFQk/Xr8slbWfwljyeiiPkYO+um6yibT/lFb5NldROUiMmz
        CNZC5vexq1v8pUe4+6UT/XhlGtFxpXHDxBJUsN4qkoW+IBX6Y1u/oxvM2wRbAjnp
        l2dm0k+J0NohWtAO3Q2rXOX3e6R6PhZH1w8hLpOIyeOY3KSKMWwv4n+DhyrEh4Gq
        Y5V0jEQN1uKqtmvFlTrYH5BONspmPQ5c5MyHkHpz6TGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ksYImFW6lXcAU4pNykS8SPFd0DRQUpaAsetXXJYMSDs=; b=T6+LwItQ
        WU1l1AGRdwiaJUIQZ2ZXZO9uNaV2BUTSjw2Jl8/35gkN7/h/bkeJ9GSJOgkxzWa/
        6mZSn+DzyPu87112rFC0F1fWp5d90MjUaT/aiNT6MIp1wsEkPZ5PVfpBBcFkXui4
        J783XibjjRyUuxHz91VEruo+NCzwuIPhHJ2bjry8ubVssOwJNb/LH2YUYrQo3gCU
        OYg3Zbci1uEhWLlQX6jOiMDtxXok8+cyPXUACvoiDdj/e60gGgsa5jglvJpw2kwU
        j24KLfh4+16KEgd/BzLijbpgQBi70e9QEe7SnW8FiQ4Wqa58WnpB9ky16Z9yRMT/
        KwFxp7Elh3afFQ==
X-ME-Sender: <xms:HFebXw5AY3jRUJScOn0pLt4VmSGHW0xEUteSzsy1bmhOYQjvASJkaQ>
    <xme:HFebXx72rOY9vZAA5dXRoJPAPPb-HHpwc8v6v0AMUBK3vCcS39WUftmwUCGRTypUS
    6I7gGNgM3MtkFunlJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:HFebX_cWzHs1dCQWSvlCcZ6pulnicsMLB-xRQUkgj6RIynEu1egoag>
    <xmx:HFebX1IdH7UPout7KZqjqOalx_cVow_OrxHjhAFmslm7bn7b1lrroA>
    <xmx:HFebX0LscnJf9gT24r3lS539iNXMmQW8nFSWWqlF1CS9YkZcvvQUsQ>
    <xmx:HFebX7mOQs3rx7XNQp5HOAa1exVNzp0NSVu1ZIxF45W0jJTEKwCyrw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id B2AC8328005D;
        Thu, 29 Oct 2020 19:58:19 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 06/10] btrfs: keep sb cache_generation consistent with space_cache
Date:   Thu, 29 Oct 2020 16:57:53 -0700
Message-Id: <4c580bccc9f08075226fc60b7703a001e7e2dee4.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1604015464.git.boris@bur.io>
References: <cover.1604015464.git.boris@bur.io>
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
 fs/btrfs/disk-io.c          |  7 +++++++
 fs/btrfs/free-space-cache.c | 28 ++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  3 +++
 fs/btrfs/super.c            | 10 +++++++---
 fs/btrfs/transaction.c      |  2 ++
 6 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8a83bce3225c..a99918b7a2af 100644
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
index d6b73701563c..a256b1a064a8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2965,6 +2965,12 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
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
@@ -3426,6 +3432,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			return ret;
 		}
 	}
+
 	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 
 clear_oneshot:
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 5ea36a06e514..5185e798cc57 100644
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
index 3d56b98e152d..95465c5a3166 100644
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
@@ -1859,6 +1857,8 @@ static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
 static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 					 unsigned long old_opts)
 {
+	bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
+
 	/*
 	 * We need to cleanup all defragable inodes if the autodefragment is
 	 * close or the filesystem is read only.
@@ -1875,6 +1875,10 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
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
index 8f70d7135497..0e85482b6713 100644
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

