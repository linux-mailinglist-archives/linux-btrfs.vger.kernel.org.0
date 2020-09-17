Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A512A26E36C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIQSX1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 14:23:27 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38933 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbgIQSV2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 14:21:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 23BAE537;
        Thu, 17 Sep 2020 14:14:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Sep 2020 14:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ljwPCr2wNgfaD
        roqYAJiE1zm/3m2I/BNEh3PKlQLkFs=; b=UZ6Qt8K91EdEppan48kagyYI/2XNM
        H/sCEHdBOr2SHa4cijC4q7biVQdM6J0HlXFqVz2i1t+AzHMcNjtAjfAZjk5e3QTx
        9ihlANu8xXe+t8/a4gs0Yu3ahNSzp7wkpTfhYqt8pII1VcTY3qveomyYj8leI6X5
        gVfJ7f6UGxD/uT6wn3wT+147HizoL+FMZ+/joi7Q91kBsNRwM9ypW3/FdApA5Njz
        r5qYhROb3gsABq8J1dXvyWKyYcfWVEBCxzhPwXgwzy3LF8gXujSeW9Rb5AWY0jOd
        W6ndX0TI3xAXAo3QlTNk/DtukH5SePx72RqnFAJDHxBXr47X2XFcWWfuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ljwPCr2wNgfaDroqYAJiE1zm/3m2I/BNEh3PKlQLkFs=; b=ekIkmKW/
        q88TtZDZ9s5hzjC0D4tJdEW63TcmkhRRWYkkIcMZYlDDKsXl2bQNwaQfccWDvM9r
        QETOhTMEUxacCfm1Al85ztzaviTwKs7EEcUkooMkIRIpGVYtmZJwFnkilUHqV63L
        KGITy+t98S4nGfvueNfqBSY9YYUNu4939KwUtTXybTSeIOk0jZmob3lUQoEdAyaK
        7cZh8BwwwmC2mqRLEwkHnwVaiQ1rssATZzWO4bxbOTLz2ngTgV3Fczt/kyc/e8Zv
        XbdpgFJLTnnK+dVmEvpeOaRAlHgtJbtOM2T0NP4GfISf7xonpdZ5/b8ydxX2ZER5
        hx9hbukweFEpyA==
X-ME-Sender: <xms:b6djX95xiMSdsV11A1-tkQoH-1bujZmfG_7yn2OCyoqIMHzl2rf_CQ>
    <xme:b6djX64LBAnkebwP-DvRxbzi9LiGC7SgebJXteB0wAYKysWSHShum3gUos7mw-Bxu
    GR7raBYotnSQkIWpDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeetheehudfgleelhfehffettedtfeelvdfghfelke
    efgefgvdevgefffedvtdefgeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:b6djX0el_xjbw_dtvQAKFoMILglQWAljpHsjYxIxPQJggBckStEG3Q>
    <xmx:b6djX2KVrofB-Jq-AChhhcKb3yboUQVylt4w_Z2K8qKSSNKW3W4IZA>
    <xmx:b6djXxJrJ45dzb6OSVRCC3ofcR5yDxnP1EUrQVdWRHcEcH3327eVwA>
    <xmx:b6djXzyEKyVeGegllYB2qq1YkcWIdxib7X7ZMnnLtHl5HOGEvHrvKQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1BA253064680;
        Thu, 17 Sep 2020 14:14:07 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH 2/4] btrfs: use sb state to print space_cache mount option
Date:   Thu, 17 Sep 2020 11:13:39 -0700
Message-Id: <e7fe51d3013637cfe2bc9581983468d5940fdce5.1600282812.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1600282812.git.boris@bur.io>
References: <cover.1600282812.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To make the contents of /proc/mounts better match the actual state of
the file system, base the display of the space cache mount options off
the contents of the super block rather than the last mount options
passed in. Since there are many scenarios where the mount will ignore a
space cache option, simply showing the passed in option is misleading.

For example, if we mount with -o remount,space_cache=v2 on a read-write
file system without an existing free space tree, we won't build a free
space tree, but /proc/mounts will read space_cache=v2 (until we mount
again and it goes away)

There is already mount logic based on the super block's cache_generation
and free space tree flag that helps decide a consistent setting for the
space cache options, so we just bring those further to the fore. For
free space tree, the flag is already consistent, so we just switch mount
option display to use it. cache_generation is not always reliably set
correctly, so we ensure that cache_generation > 0 iff the file system
is using space_cache v1. This requires committing a transaction on any
mount which changes whether we are using v1. (v1->nospace_cache, v1->v2,
nospace_cache->v1, v2->v1).

References: https://github.com/btrfs/btrfs-todo/issues/5
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c          | 11 +++++++++++
 fs/btrfs/free-space-cache.c | 20 ++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  2 ++
 fs/btrfs/super.c            | 15 ++++++++++-----
 fs/btrfs/transaction.c      |  2 ++
 5 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 71beb9493ab4..ade92e93e63f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3335,6 +3335,17 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
+	if ((bool)btrfs_test_opt(fs_info, SPACE_CACHE) !=
+	    btrfs_free_space_cache_v1_active(fs_info)) {
+		ret = btrfs_update_free_space_cache_v1_active(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "failed to update free space cache status: %d", ret);
+			close_ctree(fs_info);
+			return ret;
+		}
+	}
+
 	down_read(&fs_info->cleanup_work_sem);
 	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
 	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8759f5a1d6a0..25420d51039c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3995,6 +3995,26 @@ int btrfs_write_out_ino_cache(struct btrfs_root *root,
 	return ret;
 }
 
+bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info)
+{
+	return btrfs_super_cache_generation(fs_info->super_copy);
+}
+
+int btrfs_update_free_space_cache_v1_active(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+
+	/*
+	 * update_super_roots will appropriately set
+	 * fs_info->super_copy->cache_generation based on the SPACE_CACHE
+	 * option, so all we have to do is trigger a transaction commit.
+	 */
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+	return btrfs_commit_transaction(trans);
+}
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 /*
  * Use this if you need to make a bitmap or extent entry specifically, it
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index e3d5e0ad8f8e..5fbdbd2fe740 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -148,6 +148,8 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
 				   u64 maxlen, bool async);
 
+bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info);
+int btrfs_update_free_space_cache_v1_active(struct btrfs_fs_info *fs_info);
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int test_add_free_space_entry(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8dfd6089e31d..3dcb676fc50c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -512,7 +512,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *p, *num;
-	u64 cache_gen;
 	int intarg;
 	int ret = 0;
 	char *compress_type;
@@ -522,10 +521,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	bool saved_compress_force;
 	int no_compress = 0;
 
-	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
+	else if (btrfs_free_space_cache_v1_active(info))
 		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
 
 	/*
@@ -1430,9 +1428,9 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",discard=async");
 	if (!(info->sb->s_flags & SB_POSIXACL))
 		seq_puts(seq, ",noacl");
-	if (btrfs_test_opt(info, SPACE_CACHE))
+	if (btrfs_free_space_cache_v1_active(info))
 		seq_puts(seq, ",space_cache");
-	else if (btrfs_test_opt(info, FREE_SPACE_TREE))
+	else if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		seq_puts(seq, ",space_cache=v2");
 	else
 		seq_puts(seq, ",nospace_cache");
@@ -1870,6 +1868,13 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		if (!sb_rdonly(sb) || *flags & SB_RDONLY) {
 			btrfs_warn(fs_info,
 				   "Remounting with free space tree only supported from read-only to read-write");
+			/*
+			 * if we aren't building the free space tree, reset
+			 * the space cache options to what they were before
+			 */
+			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			if (btrfs_free_space_cache_v1_active(fs_info))
+				btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
 			create_fst = false;
 		}
 	}
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 52ada47aff50..7b4e5d031744 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1761,6 +1761,8 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
 	super->root_level = root_item->level;
 	if (btrfs_test_opt(fs_info, SPACE_CACHE))
 		super->cache_generation = root_item->generation;
+	else
+		super->cache_generation = 0;
 	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
 		super->uuid_tree_generation = root_item->generation;
 }
-- 
2.24.1

