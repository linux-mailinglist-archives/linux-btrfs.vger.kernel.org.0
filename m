Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEDF79BDA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355564AbjIKWA4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjIKJv0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8909DE53
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 02:50:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-573e931433aso439483a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425859; x=1695030659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwQSoSJR+jSGtu7F9A/uGElinPV2h0dmFylLKakGH3E=;
        b=IA+xNJX9lpoZOvs70Szvr9jKE8+886p1h7TFx5fxt4u29LBTQ2nXb0/azdBeI05PIb
         sFudKsQ2IOM6VFAyL/QimZeubcMBNmk8fpH6+QuM90rZ5S9eGxOQpd+tGTHGuzCt/IzP
         e1beu0ffbKrkWa/Gi+8tjlnezoYcQ/4l6/mCZG/Ns/zS6i2rfhuQCcqjUT2RlAErK3Ez
         iGLCvdipvnx4txhKvlkfLzZTp/E/12Z0HpsQzvni6UhPUHXkyyDNOuYE3sgWBwRQZnzg
         8PISQ56FAZBJMqXNoaFsY+e4MndQdgLIH9b44YDrLaghg0AEvXtnj4/Cp+ou4Ly8ImCD
         1TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425859; x=1695030659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwQSoSJR+jSGtu7F9A/uGElinPV2h0dmFylLKakGH3E=;
        b=t+/k4jk4whqXAL8b9VoD+AAaGZ11TtIxg94rPZe/qwMcC1gjGQxnfIAmD4abLlCOob
         j+TKGpYavFAlLrVK0lQCVfcLZTIodeEvq2o2/zJu8K5DowwVEdqLo3CS+lKgA8r9Yjku
         DuSBIz5Fnq5c/8xD2DjtbKh1Bfx8w+ePClH1oOyRBjpLqzX7amVHFZOdBvsxhH47nwBM
         pCkUPZdbFS/+Q1OKTkEwmBkvFuURJam47LkQaUNpB7lB0eVMxqc+656qyZqH1ccPLnkC
         yQuBmW2QOgcyVamsXGEoQvZuXbDWn+WJb8nGm19hik5Il+RjAh/4wACse0AV80lCVWEQ
         h9vQ==
X-Gm-Message-State: AOJu0YxeupFxm4MoVBL7RZqKZiCZmbolS2zi3RXtOaCnLLcRr7epTuLo
        eGj4p7198pbjK1E3wHmH0nxMgw==
X-Google-Smtp-Source: AGHT+IFK0C5cGs7QePEp9uLcPywDnGod8IFfwet3Jfbl6uzPvoZmscAh5Bx6Hmh6im2BgxS0qDp7eg==
X-Received: by 2002:a05:6a20:4425:b0:14d:4ab5:5e3c with SMTP id ce37-20020a056a20442500b0014d4ab55e3cmr13477043pzb.1.1694425858977;
        Mon, 11 Sep 2023 02:50:58 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:50:58 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v6 38/45] fs: super: dynamically allocate the s_shrink
Date:   Mon, 11 Sep 2023 17:44:37 +0800
Message-Id: <20230911094444.68966-39-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the s_shrink, so that it can be freed asynchronously
via RCU. Then it doesn't need to wait for RCU read-side critical section
when releasing the struct super_block.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Chris Mason <clm@fb.com>
CC: Josef Bacik <josef@toxicpanda.com>
CC: David Sterba <dsterba@suse.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: linux-btrfs@vger.kernel.org
---
 fs/btrfs/super.c   |  2 +-
 fs/kernfs/mount.c  |  2 +-
 fs/proc/root.c     |  2 +-
 fs/super.c         | 33 ++++++++++++++++++---------------
 include/linux/fs.h |  2 +-
 5 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 09bfe68d2ea3..3b165d9967bb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1519,7 +1519,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 			error = -EBUSY;
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
-		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
+		shrinker_debugfs_rename(s->s_shrink, "sb-%s:%s", fs_type->name,
 					s->s_id);
 		btrfs_sb(s)->bdev_holder = fs_type;
 		error = btrfs_fill_super(s, fs_devices, data);
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index c4bf26142eec..79b96e74a8a0 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -265,7 +265,7 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_time_gran = 1;
 
 	/* sysfs dentries and inodes don't require IO to create */
-	sb->s_shrink.seeks = 0;
+	sb->s_shrink->seeks = 0;
 
 	/* get root inode, initialize and unlock it */
 	down_read(&kf_root->kernfs_rwsem);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 9191248f2dac..b55dbc70287b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -188,7 +188,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
 
 	/* procfs dentries and inodes don't require IO to create */
-	s->s_shrink.seeks = 0;
+	s->s_shrink->seeks = 0;
 
 	pde_get(&proc_root);
 	root_inode = proc_get_inode(s, &proc_root);
diff --git a/fs/super.c b/fs/super.c
index 2d762ce67f6e..adadf6689611 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -191,7 +191,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	long	dentries;
 	long	inodes;
 
-	sb = container_of(shrink, struct super_block, s_shrink);
+	sb = shrink->private_data;
 
 	/*
 	 * Deadlock avoidance.  We may hold various FS locks, and we don't want
@@ -244,7 +244,7 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	struct super_block *sb;
 	long	total_objects = 0;
 
-	sb = container_of(shrink, struct super_block, s_shrink);
+	sb = shrink->private_data;
 
 	/*
 	 * We don't call super_trylock_shared() here as it is a scalability
@@ -306,7 +306,7 @@ static void destroy_unused_super(struct super_block *s)
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
-	free_prealloced_shrinker(&s->s_shrink);
+	shrinker_free(s->s_shrink);
 	/* no delays needed */
 	destroy_super_work(&s->destroy_work);
 }
@@ -383,16 +383,19 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_min = TIME64_MIN;
 	s->s_time_max = TIME64_MAX;
 
-	s->s_shrink.seeks = DEFAULT_SEEKS;
-	s->s_shrink.scan_objects = super_cache_scan;
-	s->s_shrink.count_objects = super_cache_count;
-	s->s_shrink.batch = 1024;
-	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
-	if (prealloc_shrinker(&s->s_shrink, "sb-%s", type->name))
+	s->s_shrink = shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
+				     "sb-%s", type->name);
+	if (!s->s_shrink)
 		goto fail;
-	if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
+
+	s->s_shrink->scan_objects = super_cache_scan;
+	s->s_shrink->count_objects = super_cache_count;
+	s->s_shrink->batch = 1024;
+	s->s_shrink->private_data = s;
+
+	if (list_lru_init_memcg(&s->s_dentry_lru, s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
+	if (list_lru_init_memcg(&s->s_inode_lru, s->s_shrink))
 		goto fail;
 	return s;
 
@@ -477,7 +480,7 @@ void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
-		unregister_shrinker(&s->s_shrink);
+		shrinker_free(s->s_shrink);
 		fs->kill_sb(s);
 
 		kill_super_notify(s);
@@ -818,7 +821,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(s->s_type);
-	register_shrinker_prepared(&s->s_shrink);
+	shrinker_register(s->s_shrink);
 	return s;
 
 share_extant_sb:
@@ -901,7 +904,7 @@ struct super_block *sget(struct file_system_type *type,
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
-	register_shrinker_prepared(&s->s_shrink);
+	shrinker_register(s->s_shrink);
 	return s;
 }
 EXPORT_SYMBOL(sget);
@@ -1522,7 +1525,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 
 	snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
-	shrinker_debugfs_rename(&sb->s_shrink, "sb-%s:%s", sb->s_type->name,
+	shrinker_debugfs_rename(sb->s_shrink, "sb-%s:%s", sb->s_type->name,
 				sb->s_id);
 	sb_set_blocksize(sb, block_size(bdev));
 	return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4aeb3fa11927..801ff3d66caa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1265,7 +1265,7 @@ struct super_block {
 
 	const struct dentry_operations *s_d_op; /* default d_op for dentries */
 
-	struct shrinker s_shrink;	/* per-sb shrinker handle */
+	struct shrinker *s_shrink;	/* per-sb shrinker handle */
 
 	/* Number of inodes with nlink == 0 but still referenced */
 	atomic_long_t s_remove_count;
-- 
2.30.2

