Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F766E8332
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjDSVOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDSVOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139E05BB2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:06 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id oo30so967320qvb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938845; x=1684530845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJFHYpzg/BWb0+L36ouRDJHQln9hI+T690Hv7pHjBKg=;
        b=AR8KJdM4EcHjURB0OJce+qHywHgwXwVY5Pue6fiQpXsYFoHc35MUPMc7VavxJjw/h8
         HXG2pgVtdEFxXmTJi2Ie1NbqBkspZMFkcTFk5j0Brlebv2nLm8kb28D/SN6ZsGuqE3x4
         xJ1EIgfCLRW1C8e3EZ5MuQQCuwIrNqrSjjvLa9fx8a62QCoE5c0YFrJyMZOvchb858uZ
         uyn2qqmfnwI+C7QCasPffxZm3AKUXieDoHx3ntzcPsOrKwJAUifG+Ce6gG7NPuGWWd+h
         zmuKgD2vvPfnkVg4RIohP9A3Ict6wT0grNXagpiAPoHet3srCCYbRrQTvgDdisurhy6+
         j+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938845; x=1684530845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJFHYpzg/BWb0+L36ouRDJHQln9hI+T690Hv7pHjBKg=;
        b=R99t3lmyYJA0bH0M4FdX6a/ISZjTN9aATCu51G1NJrC5I22EYkxV/vKXDwkD/xxwrJ
         XLwSAPPj8yTKh0dZeuZxFCC7yx5tOke7D9dxaP49oY9cZXnraZavm82Xe1PqdNj34TVt
         dKn7l+uITFaOTjp1u6GAGyxVNsv+SeIGZh65o19NKB0YxT6X+GPQ2tKZhqRzQPZQt7fv
         koMua900q7Lyz9XA4L+Y48hh+dHf0KNsJ/UYwOtMGGtsfsWOTVAXMDckhaVLVso9YJqw
         ceH6xJIqt8A/im0WjjPnm50SRNGZCFerYAmYW1aNZmsrRdxe19WucuyVI5UU2ziiVlTM
         oAjw==
X-Gm-Message-State: AAQBX9c0aZ/FsgdnFvTSxefu1+RBNU9CcaFsjwRjPcOTBM7lA8iSlDTp
        bLsMQie5Ha7nyS0I0xWokDnLbJ88WBfrGvcEi4l14Q==
X-Google-Smtp-Source: AKy350bux3JJbVAYGZZBEuCftweMRGgwjnhmJ4d4ZwCnNh1LLq9qHRbZ+Cvzo4Ee8MB0ZsJqIiNnTQ==
X-Received: by 2002:a05:6214:21e5:b0:5e9:752:766b with SMTP id p5-20020a05621421e500b005e90752766bmr33898628qvj.47.1681938845181;
        Wed, 19 Apr 2023 14:14:05 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x20-20020a0ce254000000b005f372f4a561sm1608qvl.35.2023.04.19.14.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:14:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/11] btrfs-progs: introduce UASSERT() for purely userspace code
Date:   Wed, 19 Apr 2023 17:13:46 -0400
Message-Id: <7d000d6803f9f2d4c02a858f5d0126dcb684a5c1.1681938648.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938648.git.josef@toxicpanda.com>
References: <cover.1681938648.git.josef@toxicpanda.com>
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

While syncing messages.[ch] I had to back out the ASSERT() code in
kerncompat.h, which means we now rely on the kernel code for ASSERT().
In order to maintain some semblance of separation introduce UASSERT()
and use that in all the purely userspace code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/clear-cache.c         |  4 ++--
 check/main.c                | 10 +++++-----
 check/mode-common.c         | 12 ++++++------
 check/mode-lowmem.c         | 20 ++++++++++----------
 cmds/filesystem-du.c        |  2 +-
 cmds/filesystem-usage.c     |  6 +++---
 cmds/qgroup.c               | 22 +++++++++++-----------
 cmds/replace.c              |  4 ++--
 cmds/rescue-chunk-recover.c |  6 +++---
 cmds/rescue.c               |  4 ++--
 cmds/subvolume-list.c       | 20 ++++++++++----------
 common/device-utils.c       |  4 ++--
 common/messages.h           |  6 ++++++
 common/units.c              |  4 ++--
 convert/common.c            |  4 ++--
 convert/main.c              |  2 +-
 image/main.c                |  2 +-
 libbtrfs/send-stream.c      |  3 ++-
 mkfs/main.c                 |  4 ++--
 19 files changed, 73 insertions(+), 66 deletions(-)

diff --git a/check/clear-cache.c b/check/clear-cache.c
index 0a3001a4..ecc95167 100644
--- a/check/clear-cache.c
+++ b/check/clear-cache.c
@@ -505,12 +505,12 @@ int truncate_free_ino_items(struct btrfs_root *root)
 			fi = btrfs_item_ptr(leaf, path.slots[0],
 					    struct btrfs_file_extent_item);
 			extent_type = btrfs_file_extent_type(leaf, fi);
-			ASSERT(extent_type == BTRFS_FILE_EXTENT_REG);
+			UASSERT(extent_type == BTRFS_FILE_EXTENT_REG);
 			extent_disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 			extent_num_bytes = btrfs_file_extent_disk_num_bytes (leaf, fi);
 			extent_offset = found_key.offset -
 					btrfs_file_extent_offset(leaf, fi);
-			ASSERT(extent_offset == 0);
+			UASSERT(extent_offset == 0);
 			ret = btrfs_free_extent(trans, root, extent_disk_bytenr,
 						extent_num_bytes, 0, root->objectid,
 						BTRFS_FREE_INO_OBJECTID, 0);
diff --git a/check/main.c b/check/main.c
index 9a7f40e7..1a9ad50c 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9680,14 +9680,14 @@ static int build_roots_info_cache(void)
 			rii->level = (u8)-1;
 			entry = &rii->cache_extent;
 			ret = insert_cache_extent(roots_info_cache, entry);
-			ASSERT(ret == 0);
+			UASSERT(ret == 0);
 		} else {
 			rii = container_of(entry, struct root_item_info,
 					   cache_extent);
 		}
 
-		ASSERT(rii->cache_extent.start == root_id);
-		ASSERT(rii->cache_extent.size == 1);
+		UASSERT(rii->cache_extent.start == root_id);
+		UASSERT(rii->cache_extent.size == 1);
 
 		if (level > rii->level || rii->level == (u8)-1) {
 			rii->level = level;
@@ -9726,8 +9726,8 @@ static int maybe_repair_root_item(struct btrfs_path *path,
 	}
 
 	rii = container_of(entry, struct root_item_info, cache_extent);
-	ASSERT(rii->cache_extent.start == root_id);
-	ASSERT(rii->cache_extent.size == 1);
+	UASSERT(rii->cache_extent.start == root_id);
+	UASSERT(rii->cache_extent.size == 1);
 
 	if (rii->node_count != 1) {
 		fprintf(stderr,
diff --git a/check/mode-common.c b/check/mode-common.c
index c8ac235d..ef272368 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -224,8 +224,8 @@ int check_prealloc_extent_written(u64 disk_bytenr, u64 num_bytes)
 
 		iref = (struct btrfs_extent_inline_ref *)ptr;
 		type = btrfs_extent_inline_ref_type(path.nodes[0], iref);
-		ASSERT(type == BTRFS_EXTENT_DATA_REF_KEY ||
-		       type == BTRFS_SHARED_DATA_REF_KEY);
+		UASSERT(type == BTRFS_EXTENT_DATA_REF_KEY ||
+			type == BTRFS_SHARED_DATA_REF_KEY);
 
 		if (type == BTRFS_EXTENT_DATA_REF_KEY) {
 			struct btrfs_extent_data_ref *dref;
@@ -398,7 +398,7 @@ int insert_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_timespec_sec(&ii.mtime, now);
 
 	ret = btrfs_insert_inode(trans, root, ino, &ii);
-	ASSERT(!ret);
+	UASSERT(!ret);
 
 	warning("root %llu inode %llu recreating inode item, this may "
 		"be incomplete, please check permissions and content after "
@@ -985,7 +985,7 @@ int repair_imode_common(struct btrfs_root *root, struct btrfs_path *path)
 	int ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	ASSERT(key.type == BTRFS_INODE_ITEM_KEY);
+	UASSERT(key.type == BTRFS_INODE_ITEM_KEY);
 	if (root->objectid == BTRFS_ROOT_TREE_OBJECTID) {
 		/* In root tree we only have two possible imode */
 		if (key.objectid == BTRFS_ROOT_TREE_OBJECTID)
@@ -1033,7 +1033,7 @@ int check_repair_free_space_inode(struct btrfs_path *path)
 	int ret = 0;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	ASSERT(key.type == BTRFS_INODE_ITEM_KEY && is_fstree(key.objectid));
+	UASSERT(key.type == BTRFS_INODE_ITEM_KEY && is_fstree(key.objectid));
 	iitem = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			       struct btrfs_inode_item);
 	mode = btrfs_inode_mode(path->nodes[0], iitem);
@@ -1607,7 +1607,7 @@ static int get_num_devs_in_chunk_tree(struct btrfs_fs_info *fs_info)
 		return ret;
 
 	/* We should be the first slot, and chunk tree should not be empty*/
-	ASSERT(path.slots[0] == 0 && btrfs_header_nritems(path.nodes[0]));
+	UASSERT(path.slots[0] == 0 && btrfs_header_nritems(path.nodes[0]));
 
 	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 10258d34..f0e5f8d6 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -833,7 +833,7 @@ static int find_dir_index(struct btrfs_root *root, u64 dirid, u64 location_id,
 	int slot;
 	int ret;
 
-	ASSERT(index_ret);
+	UASSERT(index_ret);
 
 	/* search from the last index */
 	key.objectid = dirid;
@@ -1029,7 +1029,7 @@ static int repair_ternary_lowmem(struct btrfs_root *root, u64 dir_ino, u64 ino,
 		stage++;
 
 	/* stage must be smllarer than 3 */
-	ASSERT(stage < 3);
+	UASSERT(stage < 3);
 
 	trans = btrfs_start_transaction(root, 1);
 	if (stage == 2) {
@@ -1351,7 +1351,7 @@ static int find_inode_ref(struct btrfs_root *root, struct btrfs_key *key,
 	int slot;
 	int ret;
 
-	ASSERT(index_ret);
+	UASSERT(index_ret);
 
 	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, root, key, &path, 0, 0);
@@ -1945,7 +1945,7 @@ recover:
 	recover_ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 
 	/* This really shouldn't happen, or we have a big problem */
-	ASSERT(recover_ret == 0);
+	UASSERT(recover_ret == 0);
 	return ret;
 }
 
@@ -2193,7 +2193,7 @@ static int __count_dir_isize(struct btrfs_root *root, u64 ino, int type,
 	int cur = 0;
 	int total = 0;
 
-	ASSERT(size_ret);
+	UASSERT(size_ret);
 	*size_ret = 0;
 
 	key.objectid = ino;
@@ -2247,7 +2247,7 @@ static int count_dir_isize(struct btrfs_root *root, u64 ino, u64 *size)
 	u64 index_size;
 	int ret;
 
-	ASSERT(size);
+	UASSERT(size);
 	ret = __count_dir_isize(root, ino, BTRFS_DIR_ITEM_KEY, &item_size);
 	if (ret)
 		goto out;
@@ -2451,7 +2451,7 @@ static int repair_inode_nlinks_lowmem(struct btrfs_root *root,
 	btrfs_item_key_to_cpu(path->nodes[0], &old_key, path->slots[0]);
 
 	if (name && namelen) {
-		ASSERT(namelen <= BTRFS_NAME_LEN);
+		UASSERT(namelen <= BTRFS_NAME_LEN);
 		memcpy(namebuf, name, namelen);
 		name_len = namelen;
 	} else {
@@ -2550,7 +2550,7 @@ static int repair_inode_gen_lowmem(struct btrfs_root *root,
 	}
 	transid = trans->transid;
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	ASSERT(key.type == BTRFS_INODE_ITEM_KEY);
+	UASSERT(key.type == BTRFS_INODE_ITEM_KEY);
 
 	btrfs_release_path(path);
 
@@ -4188,8 +4188,8 @@ static int repair_extent_item_generation(struct btrfs_path *path)
 	int ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	ASSERT(key.type == BTRFS_METADATA_ITEM_KEY ||
-	       key.type == BTRFS_EXTENT_ITEM_KEY);
+	UASSERT(key.type == BTRFS_METADATA_ITEM_KEY ||
+		key.type == BTRFS_EXTENT_ITEM_KEY);
 
 	get_extent_item_generation(key.objectid, &new_gen);
 	ret = avoid_extents_overwrite();
diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
index 0e1210e0..33b6d901 100644
--- a/cmds/filesystem-du.c
+++ b/cmds/filesystem-du.c
@@ -87,7 +87,7 @@ static int add_shared_extent(u64 start, u64 len, struct rb_root *root)
 {
 	struct shared_extent *sh;
 
-	ASSERT(len != 0);
+	UASSERT(len != 0);
 
 	sh = calloc(1, sizeof(*sh));
 	if (!sh)
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index e483c104..d1e7eed1 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -383,15 +383,15 @@ static void get_raid56_space_info(struct btrfs_ioctl_space_args *sargs,
 		size = info_ptr->size / (info_ptr->num_stripes - parities_count);
 
 		if (info_ptr->type & BTRFS_BLOCK_GROUP_DATA) {
-			ASSERT(l_data_ratio >= 0);
+			UASSERT(l_data_ratio >= 0);
 			*r_data_chunks += size;
 			*r_data_used += size * l_data_ratio;
 		} else if (info_ptr->type & BTRFS_BLOCK_GROUP_METADATA) {
-			ASSERT(l_metadata_ratio >= 0);
+			UASSERT(l_metadata_ratio >= 0);
 			*r_metadata_chunks += size;
 			*r_metadata_used += size * l_metadata_ratio;
 		} else if (info_ptr->type & BTRFS_BLOCK_GROUP_SYSTEM) {
-			ASSERT(l_system_ratio >= 0);
+			UASSERT(l_system_ratio >= 0);
 			*r_system_chunks += size;
 			*r_system_used += size * l_system_ratio;
 		}
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 49014d57..125362b8 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -222,7 +222,7 @@ static void qgroup_setup_print_column(enum btrfs_qgroup_column_enum column)
 {
 	int i;
 
-	ASSERT(0 <= column && column <= BTRFS_QGROUP_ALL);
+	UASSERT(0 <= column && column <= BTRFS_QGROUP_ALL);
 
 	if (column < BTRFS_QGROUP_ALL) {
 		btrfs_qgroup_columns[column].need_print = 1;
@@ -332,7 +332,7 @@ static void print_qgroup_column(struct btrfs_qgroup *qgroup,
 	int unit_mode = btrfs_qgroup_columns[column].unit_mode;
 	int max_len = btrfs_qgroup_columns[column].max_len;
 
-	ASSERT(0 <= column && column < BTRFS_QGROUP_ALL);
+	UASSERT(0 <= column && column < BTRFS_QGROUP_ALL);
 
 	switch (column) {
 
@@ -617,9 +617,9 @@ static int qgroup_setup_comparer(struct btrfs_qgroup_comparer_set **comp_set,
 	struct btrfs_qgroup_comparer_set *set = *comp_set;
 	int size;
 
-	ASSERT(set != NULL);
-	ASSERT(comparer < BTRFS_QGROUP_COMP_MAX);
-	ASSERT(set->ncomps <= set->total);
+	UASSERT(set != NULL);
+	UASSERT(comparer < BTRFS_QGROUP_COMP_MAX);
+	UASSERT(set->ncomps <= set->total);
 
 	if (set->ncomps == set->total) {
 		void *tmp;
@@ -641,7 +641,7 @@ static int qgroup_setup_comparer(struct btrfs_qgroup_comparer_set **comp_set,
 		*comp_set = set;
 	}
 
-	ASSERT(set->comps[set->ncomps].comp_func == NULL);
+	UASSERT(set->comps[set->ncomps].comp_func == NULL);
 
 	set->comps[set->ncomps].comp_func = all_comp_funcs[comparer];
 	set->comps[set->ncomps].is_descending = is_descending;
@@ -1014,9 +1014,9 @@ static int qgroup_setup_filter(struct btrfs_qgroup_filter_set **filter_set,
 	struct btrfs_qgroup_filter_set *set = *filter_set;
 	int size;
 
-	ASSERT(set != NULL);
-	ASSERT(filter < BTRFS_QGROUP_FILTER_MAX);
-	ASSERT(set->nfilters <= set->total);
+	UASSERT(set != NULL);
+	UASSERT(filter < BTRFS_QGROUP_FILTER_MAX);
+	UASSERT(set->nfilters <= set->total);
 
 	if (set->nfilters == set->total) {
 		void *tmp;
@@ -1038,7 +1038,7 @@ static int qgroup_setup_filter(struct btrfs_qgroup_filter_set **filter_set,
 		*filter_set = set;
 	}
 
-	ASSERT(set->filters[set->nfilters].filter_func == NULL);
+	UASSERT(set->filters[set->nfilters].filter_func == NULL);
 	set->filters[set->nfilters].filter_func = all_filter_funcs[filter];
 	set->filters[set->nfilters].data = data;
 	set->nfilters++;
@@ -1114,7 +1114,7 @@ static void __update_columns_max_len(struct btrfs_qgroup *bq,
 	int len;
 	unsigned unit_mode = btrfs_qgroup_columns[column].unit_mode;
 
-	ASSERT(0 <= column && column < BTRFS_QGROUP_ALL);
+	UASSERT(0 <= column && column < BTRFS_QGROUP_ALL);
 
 	switch (column) {
 
diff --git a/cmds/replace.c b/cmds/replace.c
index ad914306..2748b7fb 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -519,7 +519,7 @@ time2string(char *buf, size_t s, __u64 t)
 	time_t t_time_t;
 
 	t_time_t = (time_t)t;
-	ASSERT((__u64)t_time_t == t);
+	UASSERT((__u64)t_time_t == t);
 	localtime_r(&t_time_t, &t_tm);
 	strftime(buf, s, "%e.%b %T", &t_tm);
 	return buf;
@@ -529,7 +529,7 @@ static char *
 progress2string(char *buf, size_t s, int progress_1000)
 {
 	snprintf(buf, s, "%d.%01d%%", progress_1000 / 10, progress_1000 % 10);
-	ASSERT(s > 0);
+	UASSERT(s > 0);
 	buf[s - 1] = '\0';
 	return buf;
 }
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 500509fd..6a1b6734 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1455,7 +1455,7 @@ open_ctree_with_broken_chunk(struct recover_control *rc)
 		goto out_devices;
 	}
 
-	ASSERT(!memcmp(disk_super->fsid, rc->fs_devices->fsid, BTRFS_FSID_SIZE));
+	UASSERT(!memcmp(disk_super->fsid, rc->fs_devices->fsid, BTRFS_FSID_SIZE));
 	fs_info->sectorsize = btrfs_super_sectorsize(disk_super);
 	fs_info->nodesize = btrfs_super_nodesize(disk_super);
 	fs_info->stripesize = btrfs_super_stripesize(disk_super);
@@ -1467,7 +1467,7 @@ open_ctree_with_broken_chunk(struct recover_control *rc)
 	features = btrfs_super_incompat_flags(disk_super);
 
 	if (features & BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
-		ASSERT(!memcmp(disk_super->metadata_uuid,
+		UASSERT(!memcmp(disk_super->metadata_uuid,
 			       fs_info->fs_devices->metadata_uuid,
 			       BTRFS_FSID_SIZE));
 
@@ -1869,7 +1869,7 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum,
 	int csum_size = 0;
 	u8 expected_csum[BTRFS_CSUM_SIZE];
 
-	ASSERT(0);
+	UASSERT(0);
 
 	data = malloc(len);
 	if (!data)
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 28a54a65..cbeaa6f2 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -322,8 +322,8 @@ static int clear_uuid_tree(struct btrfs_fs_info *fs_info)
 		ret = btrfs_search_slot(trans, uuid_root, &key, &path, -1, 1);
 		if (ret < 0)
 			goto out;
-		ASSERT(ret > 0);
-		ASSERT(path.slots[0] == 0);
+		UASSERT(ret > 0);
+		UASSERT(path.slots[0] == 0);
 
 		nr = btrfs_header_nritems(path.nodes[0]);
 		if (nr == 0) {
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 750fc4e6..e0a7b339 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -284,7 +284,7 @@ void btrfs_list_setup_print_column(enum btrfs_list_column_enum column)
 {
 	int i;
 
-	ASSERT(0 <= column && column <= BTRFS_LIST_ALL);
+	UASSERT(0 <= column && column <= BTRFS_LIST_ALL);
 
 	if (column < BTRFS_LIST_ALL) {
 		btrfs_list_columns[column].need_print = 1;
@@ -367,9 +367,9 @@ static int btrfs_list_setup_comparer(struct btrfs_list_comparer_set **comp_set,
 	struct btrfs_list_comparer_set *set = *comp_set;
 	int size;
 
-	ASSERT(set != NULL);
-	ASSERT(comparer < BTRFS_LIST_COMP_MAX);
-	ASSERT(set->ncomps <= set->total);
+	UASSERT(set != NULL);
+	UASSERT(comparer < BTRFS_LIST_COMP_MAX);
+	UASSERT(set->ncomps <= set->total);
 
 	if (set->ncomps == set->total) {
 		void *tmp;
@@ -391,7 +391,7 @@ static int btrfs_list_setup_comparer(struct btrfs_list_comparer_set **comp_set,
 		*comp_set = set;
 	}
 
-	ASSERT(set->comps[set->ncomps].comp_func == NULL);
+	UASSERT(set->comps[set->ncomps].comp_func == NULL);
 
 	set->comps[set->ncomps].comp_func = all_comp_funcs[comparer];
 	set->comps[set->ncomps].is_descending = is_descending;
@@ -1027,9 +1027,9 @@ static void btrfs_list_setup_filter(struct btrfs_list_filter_set **filter_set,
 	struct btrfs_list_filter_set *set = *filter_set;
 	int size;
 
-	ASSERT(set != NULL);
-	ASSERT(filter < BTRFS_LIST_FILTER_MAX);
-	ASSERT(set->nfilters <= set->total);
+	UASSERT(set != NULL);
+	UASSERT(filter < BTRFS_LIST_FILTER_MAX);
+	UASSERT(set->nfilters <= set->total);
 
 	if (set->nfilters == set->total) {
 		void *tmp;
@@ -1051,7 +1051,7 @@ static void btrfs_list_setup_filter(struct btrfs_list_filter_set **filter_set,
 		*filter_set = set;
 	}
 
-	ASSERT(set->filters[set->nfilters].filter_func == NULL);
+	UASSERT(set->filters[set->nfilters].filter_func == NULL);
 
 	if (filter == BTRFS_LIST_FILTER_DELETED)
 		set->only_deleted = 1;
@@ -1129,7 +1129,7 @@ static void print_subvolume_column(struct root_info *subv,
 	char tstr[256];
 	char uuidparse[BTRFS_UUID_UNPARSED_SIZE];
 
-	ASSERT(0 <= column && column < BTRFS_LIST_ALL);
+	UASSERT(0 <= column && column < BTRFS_LIST_ALL);
 
 	switch (column) {
 	case BTRFS_LIST_OBJECTID:
diff --git a/common/device-utils.c b/common/device-utils.c
index cb1a7a9d..2e8aeb8b 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -539,7 +539,7 @@ ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t offset)
 	int ret;
 	ssize_t ret_rw;
 
-	ASSERT(rw == READ || rw == WRITE);
+	UASSERT(rw == READ || rw == WRITE);
 
 	if (fstat(fd, &stat_buf) == -1) {
 		error("fstat failed: %m");
@@ -579,7 +579,7 @@ ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t offset)
 	}
 
 	if (rw == WRITE) {
-		ASSERT(iosize == count);
+		UASSERT(iosize == count);
 		memcpy(bounce_buf, buf, count);
 		ret_rw = pwrite(fd, bounce_buf, iosize, offset);
 	} else {
diff --git a/common/messages.h b/common/messages.h
index da97c045..b512544f 100644
--- a/common/messages.h
+++ b/common/messages.h
@@ -145,4 +145,10 @@ enum common_error {
 __attribute__ ((format (printf, 2, 3)))
 void error_msg(enum common_error error, const char *msg, ...);
 
+#ifndef BTRFS_DISABLE_BACKTRACE
+#define	UASSERT(c) assert_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
+#else
+#define UASSERT(c) assert(c)
+#endif
+
 #endif
diff --git a/common/units.c b/common/units.c
index 8d708cdd..27eac098 100644
--- a/common/units.c
+++ b/common/units.c
@@ -79,7 +79,7 @@ int pretty_size_snprintf(u64 size, char *str, size_t str_size, unsigned unit_mod
 	/* Unknown mode */
 	if (!base) {
 		internal_error("unknown unit base, mode %u", unit_mode);
-		ASSERT(0);
+		UASSERT(0);
 		return -1;
 	}
 
@@ -135,7 +135,7 @@ int pretty_size_snprintf(u64 size, char *str, size_t str_size, unsigned unit_mod
 	if (num_divs >= ARRAY_SIZE(unit_suffix_binary)) {
 		str[0] = '\0';
 		internal_error("unsupported unit suffix, index %d", num_divs);
-		ASSERT(0);
+		UASSERT(0);
 		return -1;
 	}
 
diff --git a/convert/common.c b/convert/common.c
index 1a85085f..f104d93f 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -44,7 +44,7 @@ static int reserve_free_space(struct cache_tree *free_tree, u64 len,
 	struct cache_extent *cache;
 	int found = 0;
 
-	ASSERT(ret_start != NULL);
+	UASSERT(ret_start != NULL);
 	cache = first_cache_extent(free_tree);
 	while (cache) {
 		if (cache->size > len) {
@@ -807,7 +807,7 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 	int ret;
 
 	/* Source filesystem must be opened, checked and analyzed in advance */
-	ASSERT(!cache_tree_empty(used_space));
+	UASSERT(!cache_tree_empty(used_space));
 
 	/*
 	 * reserve space for temporary superblock first
diff --git a/convert/main.c b/convert/main.c
index 3f54ea30..16520914 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1167,7 +1167,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	if (ret)
 		goto fail;
 
-	ASSERT(cctx.total_bytes != 0);
+	UASSERT(cctx.total_bytes != 0);
 	blocksize = cctx.blocksize;
 	if (blocksize < 4096) {
 		error("block size is too small: %u < 4096", blocksize);
diff --git a/image/main.c b/image/main.c
index 43ee660d..7fa215c1 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1399,7 +1399,7 @@ static int restore_one_work(struct mdrestore_struct *mdres,
 	int compress_method = mdres->compress_method;
 	int ret;
 
-	ASSERT(is_power_of_2(bufsize));
+	UASSERT(is_power_of_2(bufsize));
 
 	if (compress_method == COMPRESS_ZLIB) {
 		strm.zalloc = Z_NULL;
diff --git a/libbtrfs/send-stream.c b/libbtrfs/send-stream.c
index 2e89814a..16aef3ab 100644
--- a/libbtrfs/send-stream.c
+++ b/libbtrfs/send-stream.c
@@ -26,6 +26,7 @@
 #include "libbtrfs/send-stream.h"
 #include "libbtrfs/ctree.h"
 #include "libbtrfs/crc32c.h"
+#include "common/messages.h"
 
 struct btrfs_send_stream {
 	char read_buf[BTRFS_SEND_BUF_SIZE];
@@ -108,7 +109,7 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 
 	memset(sctx->cmd_attrs, 0, sizeof(sctx->cmd_attrs));
 
-	ASSERT(sizeof(*sctx->cmd_hdr) <= sizeof(sctx->read_buf));
+	UASSERT(sizeof(*sctx->cmd_hdr) <= sizeof(sctx->read_buf));
 	ret = read_buf(sctx, sctx->read_buf, sizeof(*sctx->cmd_hdr));
 	if (ret < 0)
 		goto out;
diff --git a/mkfs/main.c b/mkfs/main.c
index 686c6b2f..4856cf96 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -272,7 +272,7 @@ static int __recow_root(struct btrfs_trans_handle *trans, struct btrfs_root *roo
 			goto out;
 		ret = 0;
 		btrfs_item_key_to_cpu(path.nodes[0], &found_key, 0);
-		ASSERT(btrfs_comp_cpu_keys(&key, &found_key) == 0);
+		UASSERT(btrfs_comp_cpu_keys(&key, &found_key) == 0);
 
 next:
 		ret = btrfs_next_leaf(root, &path);
@@ -782,7 +782,7 @@ static int create_uuid_tree(struct btrfs_trans_handle *trans)
 	};
 	int ret = 0;
 
-	ASSERT(fs_info->uuid_root == NULL);
+	UASSERT(fs_info->uuid_root == NULL);
 	root = btrfs_create_tree(trans, fs_info, &key);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
-- 
2.39.1

