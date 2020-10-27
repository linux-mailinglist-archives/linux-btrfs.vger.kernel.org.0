Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B15C29CAF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832075AbgJ0VIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:08:53 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34277 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1832061AbgJ0VIw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:08:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 048AF5C0117;
        Tue, 27 Oct 2020 17:08:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ThwdYHydrVQyU
        qsOMCFpIcz6Ja6ne3cHeSySCeXXeTU=; b=TzaWOGtgWDpN03KcjX1yC/R6yfeAW
        WoIIqw/ITT1tT9k6tIW9WfpYg9FwPFWbYCM1WBIYZa64mNlL2q4Zp6YAES3eJM/m
        gs2lyJN1B3aoRdxOSpNFplBOgmjHe31S0begLIy1jbeXQmTKlFt5IsFwvjs+qFB+
        oo3ur+WTZWolC42YRcAwhc3v3heClLkeMHTXP4vgwgJNMfDideRscgfQFEtMINwL
        PQYSeu+tEkS/48ngLYTKXfJma9a5LbHDO3ws4KHtqoaOcQ1QiVLeesOF+KRv7yfs
        dOQErlu9W7FLLXABJxYd7Z1fxAW/5yDjE+T2RY49Eb7EBcY34bXvzK5Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ThwdYHydrVQyUqsOMCFpIcz6Ja6ne3cHeSySCeXXeTU=; b=DTFJNMmF
        m3aHEE2roXarH/8kkBh1Frzmq3HKy1EP0Zm1mmhXZI+lt8lqw+lGlSZRSmH7gUTr
        GKVkJXxKfu6kDzn89U3ZU5KtAr5S01txEYQvm0ggZ07i45usAf6mdHVPHCDAurm7
        fPJXrSqyQPevSIdbhaPnPaI59tGY63VdniL6Xsli9GZHFEPn7E44OExne5Ow8V4d
        CFOkqU/eExmW0lfHIM3d0+EZF1zk402rFsJwEsyXD7c8012vnWw2DYsE7qDJ3Rqj
        UJ1AebQfzwUqFjya3wTOqWFH5xmyEZQdD+gqe5KTCQQxWodpF/12NFIVJMYBEkYK
        c70sVPYMTQkI2w==
X-ME-Sender: <xms:YoyYX16MDZ_KLf7JUP4Dnzekkc-m5Fd8i8TwwhK19J3fEGiho2QhsA>
    <xme:YoyYXy5Ufxc2YrmFFUnjM9OvB0I6XMjTljW54VekwaeU9OVhyH8zSC7NFqASBWl_e
    1q36kUhkh5zPo8BSg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:YoyYX8eDoNzl3NGrmGLeueXshw9H1gtLvtHntXp1l924rQJnlcGxbg>
    <xmx:YoyYX-JRFHkzDVTSkCGIKulsGOK2xcnVTS6NHRXGEYoEE2ijzp15og>
    <xmx:YoyYX5Kt04OEzjyrCTfWHwlG9jGVqizj46x46SPE_O7XHF44nxc-iQ>
    <xmx:Y4yYX7yyme9qIfA10sUw6XElf7HAMduAWLGOx1PIwfF4ERdxRmSGag>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F50F328005A;
        Tue, 27 Oct 2020 17:08:50 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v5 06/10] btrfs: keep sb cache_generation consistent with space_cache
Date:   Tue, 27 Oct 2020 14:08:00 -0700
Message-Id: <0009ffbf033f66bf97ef104b02b301a3916078c0.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io>
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
index cf26ef5efb9f..e4e4982e1817 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2885,6 +2885,12 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
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
@@ -3346,6 +3352,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			return ret;
 		}
 	}
+
 	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 
 clear_oneshot:
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
index 85a0cf56cec5..58e54cd3c2c6 100644
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
@@ -1810,6 +1808,8 @@ static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
 static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 					 unsigned long old_opts)
 {
+	bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
+
 	/*
 	 * We need to cleanup all defragable inodes if the autodefragment is
 	 * close or the filesystem is read only.
@@ -1826,6 +1826,10 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
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

