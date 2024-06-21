Return-Path: <linux-btrfs+bounces-5896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B60912D99
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 20:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27C628AEA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F20517BB01;
	Fri, 21 Jun 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="wx3hTMib"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926817A934
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996045; cv=none; b=YZUEsyh8xTqGj1svyCh9htsXjyt8KvZ481uHtolShrrgMwC4NA4lg8HsIIxiAMmblV/0bk5d3fC2hQRRdTs0EL0i3V78taeEErSZcaYJY9HYvGyjwVLCD4Kw6kNS3Eb8+DppZ0yE7a52FfcpzEjRYVugF1TRatGKsTvunVeyliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996045; c=relaxed/simple;
	bh=qBkbCCfsE59JPOBNJNJg0eWw59d5R7ZArDnd55kthmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAkF1Z/f7pTySlm/eIwsj23HMs1vuaHxK1lNuvm7yn0sb4sRgQekIk4GhPtRvdBNd6xitM4yXnpc2+wByQLr3dcJ6ZQKkojyhs/b1rk4DKRqSTXimU9FXthY2Sy+yu+ry5yPAaSuS+F05xCoSmDrLGJ5O2xFuohtq3ft9y5rO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=wx3hTMib; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70109d34a16so2086141b3a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718996039; x=1719600839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Cv8V4qAHRC0J8eWSewC87Q6QF+IjxXD2iNZ6IatKa8=;
        b=wx3hTMibOSF5MoiJEz5NWB4FXhgLhYAjC0EYapYvjYZR1ISP+bBtydNlxOYZBJ4J9k
         /x53wf9Uw8i0UqmavzPFgBvyXRieeCTPBRIPUd7gYkzgEfRXa+789lw5ZFJTkZ8BkKJY
         Ch3WPXtWtPaIMcf38SF/uMUoNr8q+vxl8xoxcVH3nI7Hc/L0Vfy5L5NF3Qj5xoHCLit/
         CvJeJtPKoTQ9xR8DnbKDl75KkVL5XutZEwRedeURzo37KLdVtGg2w6yiBDKLXP8APEaM
         swNSr6JEXMtJ5iup8qJKrjwVglisaoLt2Wg5pmZR/IdgZjDucJPvMb2tTV2krwqhSK2r
         dkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996039; x=1719600839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Cv8V4qAHRC0J8eWSewC87Q6QF+IjxXD2iNZ6IatKa8=;
        b=UzzJqfbV3vlT/lUvZ39PzmAgvFjQX66RmfolbZet2XdVzDwwG1FxJhaGpzyR0/zGEM
         VqQ91IQhOMHqG4aGfDt9044JqdgBGEiDFQf25jfjIQZhalUJvpF8u4/dGEYL07lOd1T8
         xa/kiWqMMX4+zA1h873wqxU5HLbre3ZrgwXkvkyJ6P39F7ivgQmsCUXm0dq7SF1YAF+Y
         ndcRAjGXPRAZUHr6Dv2wz6z9FEQAdzKIAewNtKVn5KhhrKsEzoDm9Wk975Vd20JxKoog
         Tiyt4hRMiMUYmpAoF5K3/crZNcLPpcPwRUg8vthCTRP3o/EUbIjfeSwEiKchY/ouxwKX
         ofpg==
X-Gm-Message-State: AOJu0YymtBQCPDy/G33Na3IdnzBO4V3jfLKLqn/eqVLfIQvHN+OQ6CkP
	VZ1vur5/EIMTL29JuMhaxeNpZKEws5YipHCDIDHJ+UT1ZYkZdfIbjVAfVKTBtiz77468bf8wzH7
	u
X-Google-Smtp-Source: AGHT+IHD9DWNqvI60m978FFdLXBQzlaetIBkfO+rzhLWaWHSGpDpXLmhOgXDfeOn0KVrwsnND8TXsg==
X-Received: by 2002:a05:6a20:30d4:b0:1b8:9d79:7839 with SMTP id adf61e73a8af0-1bcbb45f3f7mr9725210637.29.1718996038553;
        Fri, 21 Jun 2024 11:53:58 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:1ec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e06e7sm3957366a91.21.2024.06.21.11.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:53:57 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 7/8] btrfs-progs: subvol list: use libbtrfsutil
Date: Fri, 21 Jun 2024 11:53:36 -0700
Message-ID: <2217efdb8ade69714e7b84dcca002ecbb3044d77.1718995160.git.osandov@fb.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718995160.git.osandov@fb.com>
References: <cover.1718995160.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

btrfs subvol list has its own subvolume walking implementation that we
can replace with a libbtrfsutil subvolume iterator. Most of the changed
lines are removing the old implementation and mechanically updating the
comparators, filters, and printers to use libbtrfsutil's subvolume info.
The interesting parts are:

1. We can replace the red-black tree of subvolumes with an array that we
   qsort.
2. Listing deleted subvolumes needs a different codepath, but we don't
   need a filter for it anymore.
3. We need some hacks to maintain the weird path behavior documented in
   the previous commit.

In addition to removing a bunch of redundant code, this also prepares us
for allowing subvol list by unprivileged users in some cases.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 cmds/subvolume-list.c | 967 +++++++++++-------------------------------
 1 file changed, 259 insertions(+), 708 deletions(-)

diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 3b32a5ff..fa5082af 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -15,6 +15,7 @@
  */
 
 #include "kerncompat.h"
+#include <inttypes.h>
 #include <sys/ioctl.h>
 #include <getopt.h>
 #include <time.h>
@@ -26,6 +27,7 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <uuid/uuid.h>
+#include "libbtrfsutil/btrfsutil.h"
 #include "kernel-lib/rbtree.h"
 #include "kernel-lib/rbtree_types.h"
 #include "kernel-shared/accessors.h"
@@ -108,54 +110,14 @@ enum btrfs_list_layout {
 	BTRFS_LIST_LAYOUT_JSON
 };
 
-/*
- * one of these for each root we find.
- */
 struct root_info {
-	struct rb_node rb_node;
-	struct rb_node sort_node;
-
-	/* this root's id */
-	u64 root_id;
-
-	/* equal the offset of the root's key */
-	u64 root_offset;
-
-	/* flags of the root */
-	u64 flags;
-
-	/* the id of the root that references this one */
-	u64 ref_tree;
-
-	/* the dir id we're in from ref_tree */
-	u64 dir_id;
-
-	u64 top_id;
-
-	/* generation when the root is created or last updated */
-	u64 gen;
-
-	/* creation generation of this root in sec*/
-	u64 ogen;
-
-	/* creation time of this root in sec*/
-	time_t otime;
-
-	u8 uuid[BTRFS_UUID_SIZE];
-	u8 puuid[BTRFS_UUID_SIZE];
-	u8 ruuid[BTRFS_UUID_SIZE];
-
-	/* path from the subvol we live in to this root, including the
-	 * root's name.  This is null until we do the extra lookup ioctl.
-	 */
+	struct btrfs_util_subvolume_info info;
 	char *path;
+};
 
-	/* the name of this root in the directory it lives in */
-	char *name;
-
-	char *full_path;
-
-	int deleted;
+struct subvol_list {
+	size_t num;
+	struct root_info subvols[];
 };
 
 typedef int (*btrfs_list_filter_func)(struct root_info *, u64);
@@ -212,7 +174,7 @@ enum btrfs_list_filter_enum {
 	BTRFS_LIST_FILTER_CGEN_MORE,
 	BTRFS_LIST_FILTER_TOPID_EQUAL,
 	BTRFS_LIST_FILTER_FULL_PATH,
-	BTRFS_LIST_FILTER_DELETED,
+	BTRFS_LIST_FILTER_REMOVE_PATH_PREFIX,
 	BTRFS_LIST_FILTER_MAX,
 };
 
@@ -224,16 +186,6 @@ enum btrfs_list_comp_enum {
 	BTRFS_LIST_COMP_MAX,
 };
 
-static inline struct root_info *to_root_info(struct rb_node *node)
-{
-	return rb_entry(node, struct root_info, rb_node);
-}
-
-static inline struct root_info *to_root_info_sorted(struct rb_node *node)
-{
-	return rb_entry(node, struct root_info, sort_node);
-}
-
 static struct {
 	char	*name;
 	char	*column_name;
@@ -317,9 +269,9 @@ static void btrfs_list_setup_print_column(enum btrfs_list_column_enum column)
 static int comp_entry_with_rootid(const struct root_info *entry1,
 				  const struct root_info *entry2)
 {
-	if (entry1->root_id > entry2->root_id)
+	if (entry1->info.id > entry2->info.id)
 		return 1;
-	else if (entry1->root_id < entry2->root_id)
+	else if (entry1->info.id < entry2->info.id)
 		return -1;
 	return 0;
 }
@@ -327,9 +279,9 @@ static int comp_entry_with_rootid(const struct root_info *entry1,
 static int comp_entry_with_gen(const struct root_info *entry1,
 			       const struct root_info *entry2)
 {
-	if (entry1->gen > entry2->gen)
+	if (entry1->info.generation > entry2->info.generation)
 		return 1;
-	else if (entry1->gen < entry2->gen)
+	else if (entry1->info.generation < entry2->info.generation)
 		return -1;
 	return 0;
 }
@@ -337,9 +289,9 @@ static int comp_entry_with_gen(const struct root_info *entry1,
 static int comp_entry_with_ogen(const struct root_info *entry1,
 				const struct root_info *entry2)
 {
-	if (entry1->ogen > entry2->ogen)
+	if (entry1->info.otransid > entry2->info.otransid)
 		return 1;
-	else if (entry1->ogen < entry2->ogen)
+	else if (entry1->info.otransid < entry2->info.otransid)
 		return -1;
 	return 0;
 }
@@ -347,9 +299,9 @@ static int comp_entry_with_ogen(const struct root_info *entry1,
 static int comp_entry_with_path(const struct root_info *entry1,
 				const struct root_info *entry2)
 {
-	if (strcmp(entry1->full_path, entry2->full_path) > 0)
+	if (strcmp(entry1->path, entry2->path) > 0)
 		return 1;
-	else if (strcmp(entry1->full_path, entry2->full_path) < 0)
+	else if (strcmp(entry1->path, entry2->path) < 0)
 		return -1;
 	return 0;
 }
@@ -418,9 +370,9 @@ static int btrfs_list_setup_comparer(struct btrfs_list_comparer_set **comp_set,
 	return 0;
 }
 
-static int sort_comp(const struct root_info *entry1, const struct root_info *entry2,
-		     struct btrfs_list_comparer_set *set)
+static int sort_comp(const void *entry1, const void *entry2, void *arg)
 {
+	struct btrfs_list_comparer_set *set = arg;
 	bool rootid_compared = false;
 	int i, ret = 0;
 
@@ -447,567 +399,96 @@ static int sort_comp(const struct root_info *entry1, const struct root_info *ent
 	return ret;
 }
 
-static int sort_tree_insert(struct rb_root *sort_tree,
-			    struct root_info *ins,
-			    struct btrfs_list_comparer_set *comp_set)
+static void sort_subvols(struct btrfs_list_comparer_set *comp_set,
+			 struct subvol_list *subvols)
 {
-	struct rb_node **p = &sort_tree->rb_node;
-	struct rb_node *parent = NULL;
-	struct root_info *curr;
-	int ret;
-
-	while (*p) {
-		parent = *p;
-		curr = to_root_info_sorted(parent);
-
-		ret = sort_comp(ins, curr, comp_set);
-		if (ret < 0)
-			p = &(*p)->rb_left;
-		else if (ret > 0)
-			p = &(*p)->rb_right;
-		else
-			return -EEXIST;
-	}
-
-	rb_link_node(&ins->sort_node, parent, p);
-	rb_insert_color(&ins->sort_node, sort_tree);
-	return 0;
-}
-
-/*
- * insert a new root into the tree.  returns the existing root entry
- * if one is already there.  Both root_id and ref_tree are used
- * as the key
- */
-static int root_tree_insert(struct rb_root *root_tree,
-			    struct root_info *ins)
-{
-	struct rb_node **p = &root_tree->rb_node;
-	struct rb_node * parent = NULL;
-	struct root_info *curr;
-	int ret;
-
-	while(*p) {
-		parent = *p;
-		curr = to_root_info(parent);
-
-		ret = comp_entry_with_rootid(ins, curr);
-		if (ret < 0)
-			p = &(*p)->rb_left;
-		else if (ret > 0)
-			p = &(*p)->rb_right;
-		else
-			return -EEXIST;
-	}
-
-	rb_link_node(&ins->rb_node, parent, p);
-	rb_insert_color(&ins->rb_node, root_tree);
-	return 0;
-}
-
-/*
- * find a given root id in the tree.  We return the smallest one,
- * rb_next can be used to move forward looking for more if required
- */
-static struct root_info *root_tree_search(struct rb_root *root_tree,
-					  u64 root_id)
-{
-	struct rb_node *n = root_tree->rb_node;
-	struct root_info *entry;
-	struct root_info tmp;
-	int ret;
-
-	tmp.root_id = root_id;
-
-	while(n) {
-		entry = to_root_info(n);
-
-		ret = comp_entry_with_rootid(&tmp, entry);
-		if (ret < 0)
-			n = n->rb_left;
-		else if (ret > 0)
-			n = n->rb_right;
-		else
-			return entry;
-	}
-	return NULL;
-}
-
-static int update_root(struct rb_root *root_lookup,
-		       u64 root_id, u64 ref_tree, u64 root_offset, u64 flags,
-		       u64 dir_id, char *name, int name_len, u64 ogen, u64 gen,
-		       time_t otime, u8 *uuid, u8 *puuid, u8 *ruuid)
-{
-	struct root_info *ri;
-
-	ri = root_tree_search(root_lookup, root_id);
-	if (!ri || ri->root_id != root_id)
-		return -ENOENT;
-	if (name && name_len > 0) {
-		free(ri->name);
-
-		ri->name = malloc(name_len + 1);
-		if (!ri->name) {
-			error_msg(ERROR_MSG_MEMORY, NULL);
-			exit(1);
-		}
-		strncpy_null(ri->name, name, name_len);
-	}
-	if (ref_tree)
-		ri->ref_tree = ref_tree;
-	if (root_offset)
-		ri->root_offset = root_offset;
-	if (flags)
-		ri->flags = flags;
-	if (dir_id)
-		ri->dir_id = dir_id;
-	if (gen)
-		ri->gen = gen;
-	if (ogen)
-		ri->ogen = ogen;
-	if (!ri->ogen && root_offset)
-		ri->ogen = root_offset;
-	if (otime)
-		ri->otime = otime;
-	if (uuid)
-		memcpy(&ri->uuid, uuid, BTRFS_UUID_SIZE);
-	if (puuid)
-		memcpy(&ri->puuid, puuid, BTRFS_UUID_SIZE);
-	if (ruuid)
-		memcpy(&ri->ruuid, ruuid, BTRFS_UUID_SIZE);
-
-	return 0;
-}
-
-/*
- * add_root - update the existed root, or allocate a new root and insert it
- *	      into the lookup tree.
- * root_id: object id of the root
- * ref_tree: object id of the referring root.
- * root_offset: offset value of the root'key
- * dir_id: inode id of the directory in ref_tree where this root can be found.
- * name: the name of root_id in that directory
- * name_len: the length of name
- * ogen: the original generation of the root
- * gen: the current generation of the root
- * otime: the original time (creation time) of the root
- * uuid: uuid of the root
- * puuid: uuid of the root parent if any
- * ruuid: uuid of the received subvol, if any
- */
-static int add_root(struct rb_root *root_lookup,
-		    u64 root_id, u64 ref_tree, u64 root_offset, u64 flags,
-		    u64 dir_id, char *name, int name_len, u64 ogen, u64 gen,
-		    time_t otime, u8 *uuid, u8 *puuid, u8 *ruuid)
-{
-	struct root_info *ri;
-	int ret;
-
-	ret = update_root(root_lookup, root_id, ref_tree, root_offset, flags,
-			  dir_id, name, name_len, ogen, gen, otime,
-			  uuid, puuid, ruuid);
-	if (!ret)
-		return 0;
-
-	ri = calloc(1, sizeof(*ri));
-	if (!ri) {
-		error_msg(ERROR_MSG_MEMORY, NULL);
-		exit(1);
-	}
-	ri->root_id = root_id;
-
-	if (name && name_len > 0) {
-		ri->name = malloc(name_len + 1);
-		if (!ri->name) {
-			error_msg(ERROR_MSG_MEMORY, NULL);
-			exit(1);
-		}
-		strncpy_null(ri->name, name, name_len);
-	}
-	if (ref_tree)
-		ri->ref_tree = ref_tree;
-	if (dir_id)
-		ri->dir_id = dir_id;
-	if (root_offset)
-		ri->root_offset = root_offset;
-	if (flags)
-		ri->flags = flags;
-	if (gen)
-		ri->gen = gen;
-	if (ogen)
-		ri->ogen = ogen;
-	if (!ri->ogen && root_offset)
-		ri->ogen = root_offset;
-	if (otime)
-		ri->otime = otime;
-
-	if (uuid)
-		memcpy(&ri->uuid, uuid, BTRFS_UUID_SIZE);
-
-	if (puuid)
-		memcpy(&ri->puuid, puuid, BTRFS_UUID_SIZE);
-
-	if (ruuid)
-		memcpy(&ri->ruuid, ruuid, BTRFS_UUID_SIZE);
-
-	ret = root_tree_insert(root_lookup, ri);
-	if (ret < 0) {
-		errno = -ret;
-		error("failed to insert subvolume %llu to tree: %m", root_id);
-		exit(1);
-	}
-	return 0;
-}
-
-/*
- * Simplified add_root for back references, omits the uuid and original info
- * parameters, root offset and flags.
- */
-static int add_root_backref(struct rb_root *root_lookup, u64 root_id,
-		u64 ref_tree, u64 dir_id, char *name, int name_len)
-{
-	return add_root(root_lookup, root_id, ref_tree, 0, 0, dir_id, name,
-			name_len, 0, 0, 0, NULL, NULL, NULL);
-}
-
-static void free_root_info(struct rb_node *node)
-{
-	struct root_info *ri;
-
-	ri = to_root_info(node);
-	free(ri->name);
-	free(ri->path);
-	free(ri->full_path);
-	free(ri);
-}
-
-/*
- * for a given root_info, search through the root_lookup tree to construct
- * the full path name to it.
- *
- * This can't be called until all the root_info->path fields are filled
- * in by lookup_ino_path
- */
-static int resolve_root(struct rb_root *rl, struct root_info *ri,
-		       u64 top_id)
-{
-	char *full_path = NULL;
-	int len = 0;
-	struct root_info *found;
-
-	/*
-	 * we go backwards from the root_info object and add pathnames
-	 * from parent directories as we go.
-	 */
-	found = ri;
-	while (1) {
-		char *tmp;
-		u64 next;
-		int add_len;
-
-		/*
-		 * ref_tree = 0 indicates the subvolume
-		 * has been deleted.
-		 */
-		if (!found->ref_tree) {
-			free(full_path);
-			return -ENOENT;
-		}
-
-		add_len = strlen(found->path);
-
-		if (full_path) {
-			/* room for / and for null */
-			tmp = malloc(add_len + 2 + len);
-			if (!tmp) {
-				error_msg(ERROR_MSG_MEMORY, NULL);
-				exit(1);
-			}
-			memcpy(tmp + add_len + 1, full_path, len);
-			tmp[add_len] = '/';
-			memcpy(tmp, found->path, add_len);
-			tmp [add_len + len + 1] = '\0';
-			free(full_path);
-			full_path = tmp;
-			len += add_len + 1;
-		} else {
-			full_path = strdup(found->path);
-			len = add_len;
-		}
-		if (!ri->top_id)
-			ri->top_id = found->ref_tree;
-
-		next = found->ref_tree;
-		if (next == top_id)
-			break;
-		/*
-		* if the ref_tree = BTRFS_FS_TREE_OBJECTID,
-		* we are at the top
-		*/
-		if (next == BTRFS_FS_TREE_OBJECTID)
-			break;
-		/*
-		* if the ref_tree wasn't in our tree of roots, the
-		* subvolume was deleted.
-		*/
-		found = root_tree_search(rl, next);
-		if (!found) {
-			free(full_path);
-			return -ENOENT;
-		}
-	}
-
-	ri->full_path = full_path;
-
-	return 0;
-}
-
-/*
- * for a single root_info, ask the kernel to give us a path name
- * inside it's ref_root for the dir_id where it lives.
- *
- * This fills in root_info->path with the path to the directory and and
- * appends this root's name.
- */
-static int lookup_ino_path(int fd, struct root_info *ri)
-{
-	struct btrfs_ioctl_ino_lookup_args args;
-	int ret;
-
-	if (ri->path)
-		return 0;
-
-	if (!ri->ref_tree)
-		return -ENOENT;
-
-	memset(&args, 0, sizeof(args));
-	args.treeid = ri->ref_tree;
-	args.objectid = ri->dir_id;
-
-	ret = ioctl(fd, BTRFS_IOC_INO_LOOKUP, &args);
-	if (ret < 0) {
-		if (errno == ENOENT) {
-			ri->ref_tree = 0;
-			return -ENOENT;
-		}
-		error("failed to lookup path for root %llu: %m", ri->ref_tree);
-		return ret;
-	}
-
-	if (args.name[0]) {
-		/*
-		 * we're in a subdirectory of ref_tree, the kernel ioctl
-		 * puts a / in there for us
-		 */
-		ri->path = malloc(strlen(ri->name) + strlen(args.name) + 1);
-		if (!ri->path) {
-			error_msg(ERROR_MSG_MEMORY, NULL);
-			exit(1);
-		}
-		strcpy(ri->path, args.name);
-		strcat(ri->path, ri->name);
-	} else {
-		/* we're at the root of ref_tree */
-		ri->path = strdup(ri->name);
-		if (!ri->path) {
-			perror("strdup failed");
-			exit(1);
-		}
-	}
-	return 0;
-}
-
-static int list_subvol_search(int fd, struct rb_root *root_lookup)
-{
-	int ret;
-	struct btrfs_tree_search_args args;
-	struct btrfs_ioctl_search_key *sk;
-	struct btrfs_root_ref *ref;
-	struct btrfs_root_item *ri;
-	unsigned long off;
-	int name_len;
-	char *name;
-	u64 dir_id;
-	u64 gen = 0;
-	u64 ogen;
-	u64 flags;
-	int i;
-
-	root_lookup->rb_node = NULL;
-
-	memset(&args, 0, sizeof(args));
-	sk = btrfs_tree_search_sk(&args);
-	sk->tree_id = BTRFS_ROOT_TREE_OBJECTID;
-	/* Search both live and deleted subvolumes */
-	sk->min_type = BTRFS_ROOT_ITEM_KEY;
-	sk->max_type = BTRFS_ROOT_BACKREF_KEY;
-	sk->min_objectid = BTRFS_FS_TREE_OBJECTID;
-	sk->max_objectid = BTRFS_LAST_FREE_OBJECTID;
-	sk->max_offset = (u64)-1;
-	sk->max_transid = (u64)-1;
-
-	while(1) {
-		sk->nr_items = 4096;
-		ret = btrfs_tree_search_ioctl(fd, &args);
-		if (ret < 0)
-			return ret;
-		if (sk->nr_items == 0)
-			break;
-
-		off = 0;
-
-		/*
-		 * for each item, pull the key out of the header and then
-		 * read the root_ref item it contains
-		 */
-		for (i = 0; i < sk->nr_items; i++) {
-			struct btrfs_ioctl_search_header sh;
-
-			memcpy(&sh, btrfs_tree_search_data(&args, off), sizeof(sh));
-			off += sizeof(sh);
-			if (sh.type == BTRFS_ROOT_BACKREF_KEY) {
-				ref = btrfs_tree_search_data(&args, off);
-				name_len = btrfs_stack_root_ref_name_len(ref);
-				name = (char *)(ref + 1);
-				dir_id = btrfs_stack_root_ref_dirid(ref);
-
-				add_root_backref(root_lookup, sh.objectid,
-						sh.offset, dir_id, name,
-						name_len);
-			} else if (sh.type == BTRFS_ROOT_ITEM_KEY &&
-				   (sh.objectid >= BTRFS_FIRST_FREE_OBJECTID ||
-				    sh.objectid == BTRFS_FS_TREE_OBJECTID)) {
-				time_t otime;
-				u8 uuid[BTRFS_UUID_SIZE];
-				u8 puuid[BTRFS_UUID_SIZE];
-				u8 ruuid[BTRFS_UUID_SIZE];
-
-				ri = btrfs_tree_search_data(&args, off);
-				gen = btrfs_root_generation(ri);
-				flags = btrfs_root_flags(ri);
-				if(sh.len >= sizeof(struct btrfs_root_item)) {
-					/*
-					 * The new full btrfs_root_item with
-					 * timestamp and UUID.
-					 */
-					otime = btrfs_stack_timespec_sec(&ri->otime);
-					ogen = btrfs_root_otransid(ri);
-					memcpy(uuid, ri->uuid, BTRFS_UUID_SIZE);
-					memcpy(puuid, ri->parent_uuid, BTRFS_UUID_SIZE);
-					memcpy(ruuid, ri->received_uuid, BTRFS_UUID_SIZE);
-				} else {
-					/*
-					 * The old v0 root item, which doesn't
-					 * have timestamp nor UUID.
-					 */
-					otime = 0;
-					ogen = 0;
-					memset(uuid, 0, BTRFS_UUID_SIZE);
-					memset(puuid, 0, BTRFS_UUID_SIZE);
-					memset(ruuid, 0, BTRFS_UUID_SIZE);
-				}
-
-				add_root(root_lookup, sh.objectid, 0,
-					 sh.offset, flags, 0, NULL, 0, ogen,
-					 gen, otime, uuid, puuid, ruuid);
-			}
-
-			off += sh.len;
-
-			sk->min_objectid = sh.objectid;
-			sk->min_type = sh.type;
-			sk->min_offset = sh.offset;
-		}
-		sk->min_offset++;
-		if (!sk->min_offset)
-			sk->min_type++;
-		else
-			continue;
-
-		if (sk->min_type > BTRFS_ROOT_BACKREF_KEY) {
-			sk->min_type = BTRFS_ROOT_ITEM_KEY;
-			sk->min_objectid++;
-		} else
-			continue;
-
-		if (sk->min_objectid > sk->max_objectid)
-			break;
-	}
-
-	return 0;
+	qsort_r(subvols->subvols, subvols->num, sizeof(subvols->subvols[0]),
+		sort_comp, comp_set);
 }
 
 static int filter_snapshot(struct root_info *ri, u64 data)
 {
-	return !!ri->root_offset;
+	return !uuid_is_null(ri->info.parent_uuid);
 }
 
 static int filter_flags(struct root_info *ri, u64 flags)
 {
-	return ri->flags & flags;
+	return ri->info.flags & flags;
 }
 
 static int filter_gen_more(struct root_info *ri, u64 data)
 {
-	return ri->gen >= data;
+	return ri->info.generation >= data;
 }
 
 static int filter_gen_less(struct root_info *ri, u64 data)
 {
-	return ri->gen <= data;
+	return ri->info.generation <= data;
 }
 
 static int filter_gen_equal(struct root_info  *ri, u64 data)
 {
-	return ri->gen == data;
+	return ri->info.generation == data;
 }
 
 static int filter_cgen_more(struct root_info *ri, u64 data)
 {
-	return ri->ogen >= data;
+	return ri->info.otransid >= data;
 }
 
 static int filter_cgen_less(struct root_info *ri, u64 data)
 {
-	return ri->ogen <= data;
+	return ri->info.otransid <= data;
 }
 
 static int filter_cgen_equal(struct root_info *ri, u64 data)
 {
-	return ri->ogen == data;
+	return ri->info.otransid == data;
 }
 
 static int filter_topid_equal(struct root_info *ri, u64 data)
 {
-	return ri->top_id == data;
+	/* See the comment in print_subvolume_column() about top level. */
+	return ri->info.parent_id == data;
 }
 
 static int filter_full_path(struct root_info *ri, u64 data)
 {
-	if (ri->full_path && ri->top_id != data) {
+	/*
+	 * If this subvolume's parent is not the subvolume containing the path
+	 * given on the command line, prepend "<FS_TREE>/". This behavior is
+	 * nonsense, but we keep it for backwards compatibility. It was
+	 * introduced by the same change to top level mentioned in
+	 * print_subvolume_column().
+	 */
+	if (ri->info.parent_id != data) {
 		char *tmp;
-		char p[] = "<FS_TREE>";
-		int add_len = strlen(p);
-		int len = strlen(ri->full_path);
+		int ret;
 
-		tmp = malloc(len + add_len + 2);
-		if (!tmp) {
-			error_msg(ERROR_MSG_MEMORY, NULL);
+		ret = asprintf(&tmp, "<FS_TREE>/%s", ri->path);
+		if (ret == -1) {
+			error("out of memory");
 			exit(1);
 		}
-		memcpy(tmp + add_len + 1, ri->full_path, len);
-		tmp[len + add_len + 1] = '\0';
-		tmp[add_len] = '/';
-		memcpy(tmp, p, add_len);
-		free(ri->full_path);
-		ri->full_path = tmp;
+
+		free(ri->path);
+		ri->path = tmp;
 	}
 	return 1;
 }
 
-static int filter_deleted(struct root_info *ri, u64 data)
+static int filter_remove_path_prefix(struct root_info *ri, u64 data)
 {
-	return ri->deleted;
+	/*
+	 * If this subvolume is a descendant of the given path, remove that path
+	 * prefix. Otherwise, leave it alone. This is also nonsense that we keep
+	 * for backwards compatibility.
+	 */
+	const char *prefix = (const char *)data;
+	size_t len = strlen(prefix);
+	if (strncmp(ri->path, prefix, len) == 0 && ri->path[len] == '/')
+		memmove(ri->path, &ri->path[len + 1], strlen(ri->path) - len);
+	return 1;
 }
 
 static btrfs_list_filter_func all_filter_funcs[] = {
@@ -1021,7 +502,7 @@ static btrfs_list_filter_func all_filter_funcs[] = {
 	[BTRFS_LIST_FILTER_CGEN_EQUAL]          = filter_cgen_equal,
 	[BTRFS_LIST_FILTER_TOPID_EQUAL]		= filter_topid_equal,
 	[BTRFS_LIST_FILTER_FULL_PATH]		= filter_full_path,
-	[BTRFS_LIST_FILTER_DELETED]		= filter_deleted,
+	[BTRFS_LIST_FILTER_REMOVE_PATH_PREFIX]	= filter_remove_path_prefix,
 };
 
 /*
@@ -1060,9 +541,6 @@ static void btrfs_list_setup_filter(struct btrfs_list_filter_set **filter_set,
 
 	UASSERT(set->filters[set->nfilters].filter_func == NULL);
 
-	if (filter == BTRFS_LIST_FILTER_DELETED)
-		set->only_deleted = 1;
-
 	set->filters[set->nfilters].filter_func = all_filter_funcs[filter];
 	set->filters[set->nfilters].data = data;
 	set->nfilters++;
@@ -1076,12 +554,6 @@ static int filter_root(struct root_info *ri,
 	if (!set)
 		return 1;
 
-	if (set->only_deleted && !ri->deleted)
-		return 0;
-
-	if (!set->only_deleted && ri->deleted)
-		return 0;
-
 	for (i = 0; i < set->nfilters; i++) {
 		if (!set->filters[i].filter_func)
 			break;
@@ -1092,44 +564,6 @@ static int filter_root(struct root_info *ri,
 	return 1;
 }
 
-static void filter_and_sort_subvol(struct rb_root *all_subvols,
-				    struct rb_root *sort_tree,
-				    struct btrfs_list_filter_set *filter_set,
-				    struct btrfs_list_comparer_set *comp_set,
-				    u64 top_id)
-{
-	struct rb_node *n;
-	struct root_info *entry;
-	int ret;
-
-	sort_tree->rb_node = NULL;
-
-	n = rb_last(all_subvols);
-	while (n) {
-		entry = to_root_info(n);
-
-		ret = resolve_root(all_subvols, entry, top_id);
-		if (ret == -ENOENT) {
-			if (entry->root_id != BTRFS_FS_TREE_OBJECTID) {
-				entry->full_path = strdup("DELETED");
-				entry->deleted = 1;
-			} else {
-				/*
-				 * The full path is not supposed to be printed,
-				 * but we don't want to print an empty string,
-				 * in case it appears somewhere.
-				 */
-				entry->full_path = strdup("TOPLEVEL");
-				entry->deleted = 0;
-			}
-		}
-		ret = filter_root(entry, filter_set);
-		if (ret)
-			sort_tree_insert(sort_tree, entry, comp_set);
-		n = rb_prev(n);
-	}
-}
-
 static void print_subvolume_column(struct root_info *subv,
 				   enum btrfs_list_column_enum column)
 {
@@ -1140,54 +574,58 @@ static void print_subvolume_column(struct root_info *subv,
 
 	switch (column) {
 	case BTRFS_LIST_OBJECTID:
-		pr_verbose(LOG_DEFAULT, "%llu", subv->root_id);
+		pr_verbose(LOG_DEFAULT, "%" PRIu64, subv->info.id);
 		break;
 	case BTRFS_LIST_GENERATION:
-		pr_verbose(LOG_DEFAULT, "%llu", subv->gen);
+		pr_verbose(LOG_DEFAULT, "%" PRIu64, subv->info.generation);
 		break;
 	case BTRFS_LIST_OGENERATION:
-		pr_verbose(LOG_DEFAULT, "%llu", subv->ogen);
+		pr_verbose(LOG_DEFAULT, "%" PRIu64, subv->info.otransid);
 		break;
 	case BTRFS_LIST_PARENT:
-		pr_verbose(LOG_DEFAULT, "%llu", subv->ref_tree);
-		break;
+	/*
+	 * Top level used to mean something else, but since 4f5ebb3ef553
+	 * ("Btrfs-progs: fix to make list specified directory's subvolumes
+	 * work") it was always set to the parent ID. See
+	 * https://lore.kernel.org/all/bdd9af61-b408-c8d2-6697-84230b0bcf89@gmail.com/.
+	 */
 	case BTRFS_LIST_TOP_LEVEL:
-		pr_verbose(LOG_DEFAULT, "%llu", subv->top_id);
+		pr_verbose(LOG_DEFAULT, "%" PRIu64, subv->info.parent_id);
 		break;
 	case BTRFS_LIST_OTIME:
-		if (subv->otime) {
+		if (subv->info.otime.tv_sec) {
 			struct tm tm;
 
-			localtime_r(&subv->otime, &tm);
+			localtime_r(&subv->info.otime.tv_sec, &tm);
 			strftime(tstr, 256, "%Y-%m-%d %X", &tm);
 		} else
 			strcpy(tstr, "-");
 		pr_verbose(LOG_DEFAULT, "%s", tstr);
 		break;
 	case BTRFS_LIST_UUID:
-		if (uuid_is_null(subv->uuid))
+		if (uuid_is_null(subv->info.uuid))
 			strcpy(uuidparse, "-");
 		else
-			uuid_unparse(subv->uuid, uuidparse);
+			uuid_unparse(subv->info.uuid, uuidparse);
 		pr_verbose(LOG_DEFAULT, "%-36s", uuidparse);
 		break;
 	case BTRFS_LIST_PUUID:
-		if (uuid_is_null(subv->puuid))
+		if (uuid_is_null(subv->info.parent_uuid))
 			strcpy(uuidparse, "-");
 		else
-			uuid_unparse(subv->puuid, uuidparse);
+			uuid_unparse(subv->info.parent_uuid, uuidparse);
 		pr_verbose(LOG_DEFAULT, "%-36s", uuidparse);
 		break;
 	case BTRFS_LIST_RUUID:
-		if (uuid_is_null(subv->ruuid))
+		if (uuid_is_null(subv->info.received_uuid))
 			strcpy(uuidparse, "-");
 		else
-			uuid_unparse(subv->ruuid, uuidparse);
+			uuid_unparse(subv->info.received_uuid, uuidparse);
 		pr_verbose(LOG_DEFAULT, "%-36s", uuidparse);
 		break;
 	case BTRFS_LIST_PATH:
-		BUG_ON(!subv->full_path);
-		pr_verbose(LOG_DEFAULT, "%s", subv->full_path);
+		BUG_ON(!subv->path);
+		pr_verbose(LOG_DEFAULT, "%s", subv->path);
 		break;
 	default:
 		break;
@@ -1270,35 +708,34 @@ static void print_subvol_json_key(struct format_ctx *fctx,
 	column_name = btrfs_list_columns[column].name;
 	switch (column) {
 	case BTRFS_LIST_OBJECTID:
-		fmt_print(fctx, column_name, subv->root_id);
+		fmt_print(fctx, column_name, subv->info.id);
 		break;
 	case BTRFS_LIST_GENERATION:
-		fmt_print(fctx, column_name, subv->gen);
+		fmt_print(fctx, column_name, subv->info.generation);
 		break;
 	case BTRFS_LIST_OGENERATION:
-		fmt_print(fctx, column_name, subv->ogen);
+		fmt_print(fctx, column_name, subv->info.otransid);
 		break;
 	case BTRFS_LIST_PARENT:
-		fmt_print(fctx, column_name, subv->ref_tree);
-		break;
+	/* See the comment in print_subvolume_column() about top level. */
 	case BTRFS_LIST_TOP_LEVEL:
-		fmt_print(fctx, column_name, subv->top_id);
+		fmt_print(fctx, column_name, subv->info.parent_id);
 		break;
 	case BTRFS_LIST_OTIME:
-		fmt_print(fctx, column_name, subv->otime);
+		fmt_print(fctx, column_name, subv->info.otime.tv_sec);
 		break;
 	case BTRFS_LIST_UUID:
-		fmt_print(fctx, column_name, subv->uuid);
+		fmt_print(fctx, column_name, subv->info.uuid);
 		break;
 	case BTRFS_LIST_PUUID:
-		fmt_print(fctx, column_name, subv->puuid);
+		fmt_print(fctx, column_name, subv->info.parent_uuid);
 		break;
 	case BTRFS_LIST_RUUID:
-		fmt_print(fctx, column_name, subv->ruuid);
+		fmt_print(fctx, column_name, subv->info.received_uuid);
 		break;
 	case BTRFS_LIST_PATH:
-		BUG_ON(!subv->full_path);
-		fmt_print(fctx, column_name, subv->full_path);
+		BUG_ON(!subv->path);
+		fmt_print(fctx, column_name, subv->path);
 		break;
 	default:
 		break;
@@ -1323,10 +760,10 @@ static void print_one_subvol_info_json(struct format_ctx *fctx,
 }
 
 
-static void print_all_subvol_info(struct rb_root *sorted_tree,
+static void print_all_subvol_info(struct subvol_list *subvols,
 		  enum btrfs_list_layout layout)
 {
-	struct rb_node *n;
+	size_t i;
 	struct root_info *entry;
 	struct format_ctx fctx;
 
@@ -1337,13 +774,8 @@ static void print_all_subvol_info(struct rb_root *sorted_tree,
 		fmt_print_start_group(&fctx, "subvolume-list", JSON_TYPE_ARRAY);
 	}
 
-	n = rb_first(sorted_tree);
-	while (n) {
-		entry = to_root_info_sorted(n);
-
-		/* The toplevel subvolume is not listed by default */
-		if (entry->root_id == BTRFS_FS_TREE_OBJECTID)
-			goto next;
+	for (i = 0; i < subvols->num; i++) {
+		entry = &subvols->subvols[i];
 
 		switch (layout) {
 		case BTRFS_LIST_LAYOUT_DEFAULT:
@@ -1356,8 +788,6 @@ static void print_all_subvol_info(struct rb_root *sorted_tree,
 			print_one_subvol_info_json(&fctx, entry);
 			break;
 		}
-next:
-		n = rb_next(n);
 	}
 
 	if (layout == BTRFS_LIST_LAYOUT_JSON) {
@@ -1366,61 +796,170 @@ next:
 	}
 }
 
-static int btrfs_list_subvols(int fd, struct rb_root *root_lookup)
+static void free_subvol_list(struct subvol_list *subvols)
 {
-	int ret;
-	struct rb_node *n;
+	size_t i;
 
-	ret = list_subvol_search(fd, root_lookup);
+	if (subvols) {
+		for (i = 0; i < subvols->num; i++)
+			free(subvols->subvols[i].path);
+		free(subvols);
+	}
+}
+
+static struct subvol_list *btrfs_list_deleted_subvols(int fd,
+				struct btrfs_list_filter_set *filter_set)
+{
+	struct subvol_list *subvols = NULL;
+	uint64_t *ids = NULL;
+	size_t i, n;
+	enum btrfs_util_error err;
+	int ret = -1;
+
+	err = btrfs_util_deleted_subvolumes_fd(fd, &ids, &n);
+	if (err) {
+		error_btrfs_util(err);
+		return NULL;
+	}
+
+	subvols = malloc(sizeof(*subvols) + n * sizeof(subvols->subvols[0]));
+	if (!subvols) {
+		error("out of memory");
+		goto out;
+	}
+
+	subvols->num = 0;
+	for (i = 0; i < n; i++) {
+		struct root_info *subvol = &subvols->subvols[subvols->num];
+
+		err = btrfs_util_subvolume_info_fd(fd, ids[i], &subvol->info);
+		if (err == BTRFS_UTIL_ERROR_SUBVOLUME_NOT_FOUND) {
+			/*
+			 * The subvolume might have been cleaned up since it was
+			 * returned.
+			 */
+			continue;
+		} else if (err) {
+			error_btrfs_util(err);
+			goto out;
+		}
+
+		subvol->path = strdup("DELETED");
+		if (!subvol->path)
+			goto out;
+
+		if (!filter_root(subvol, filter_set)) {
+			free(subvol->path);
+			continue;
+		}
+
+		subvols->num++;
+	}
+
+	ret = 0;
+out:
 	if (ret) {
-		error("can't perform the search: %m");
-		return ret;
+		free_subvol_list(subvols);
+		subvols = NULL;
+	}
+	free(ids);
+	return subvols;
+}
+
+static struct subvol_list *btrfs_list_subvols(int fd,
+				struct btrfs_list_filter_set *filter_set)
+{
+	struct subvol_list *subvols;
+	size_t capacity = 4;
+	struct btrfs_util_subvolume_iterator *iter;
+	enum btrfs_util_error err;
+	int ret = -1;
+
+	subvols = malloc(sizeof(*subvols) +
+			 capacity * sizeof(subvols->subvols[0]));
+	if (!subvols) {
+		error("out of memory");
+		return NULL;
+	}
+	subvols->num = 0;
+
+	err = btrfs_util_create_subvolume_iterator_fd(fd,
+						      BTRFS_FS_TREE_OBJECTID, 0,
+						      &iter);
+	if (err) {
+		iter = NULL;
+		error_btrfs_util(err);
+		goto out;
 	}
 
-	/*
-	 * now we have an rbtree full of root_info objects, but we need to fill
-	 * in their path names within the subvol that is referencing each one.
-	 */
-	n = rb_first(root_lookup);
-	while (n) {
-		struct root_info *entry;
+	for (;;) {
+		struct root_info subvol;
 
-		entry = to_root_info(n);
-		ret = lookup_ino_path(fd, entry);
-		if (ret && ret != -ENOENT)
-			return ret;
-		n = rb_next(n);
+		err = btrfs_util_subvolume_iterator_next_info(iter,
+							      &subvol.path,
+							      &subvol.info);
+		if (err == BTRFS_UTIL_ERROR_STOP_ITERATION) {
+			break;
+		} else if (err) {
+			error_btrfs_util(err);
+			goto out;
+		}
+
+		if (!filter_root(&subvol, filter_set)) {
+			free(subvol.path);
+			continue;
+		}
+
+		if (subvols->num >= capacity) {
+			struct subvol_list *new_subvols;
+			size_t new_capacity = max_t(size_t, 1, capacity * 2);
+
+			new_subvols = realloc(subvols,
+					      sizeof(*new_subvols) +
+					      new_capacity *
+					      sizeof(new_subvols->subvols[0]));
+			if (!new_subvols) {
+				error("out of memory");
+				free(subvol.path);
+				goto out;
+			}
+
+			subvols = new_subvols;
+			capacity = new_capacity;
+		}
+
+		subvols->subvols[subvols->num] = subvol;
+		subvols->num++;
 	}
 
-	return 0;
+	ret = 0;
+out:
+	if (iter)
+		btrfs_util_destroy_subvolume_iterator(iter);
+	if (ret) {
+		free_subvol_list(subvols);
+		subvols = NULL;
+	}
+	return subvols;
 }
 
 static int btrfs_list_subvols_print(int fd, struct btrfs_list_filter_set *filter_set,
 		       struct btrfs_list_comparer_set *comp_set,
-		       enum btrfs_list_layout layout, int full_path)
+		       enum btrfs_list_layout layout)
 {
-	struct rb_root root_lookup;
-	struct rb_root root_sort;
-	int ret = 0;
-	u64 top_id = 0;
+	struct subvol_list *subvols;
 
-	if (full_path) {
-		ret = lookup_path_rootid(fd, &top_id);
-		if (ret) {
-			errno = -ret;
-			error("cannot resolve rootid for path: %m");
-			return ret;
-		}
-	}
+	if (filter_set->only_deleted)
+		subvols = btrfs_list_deleted_subvols(fd, filter_set);
+	else
+		subvols = btrfs_list_subvols(fd, filter_set);
+	if (!subvols)
+		return -1;
 
-	ret = btrfs_list_subvols(fd, &root_lookup);
-	if (ret)
-		return ret;
-	filter_and_sort_subvol(&root_lookup, &root_sort, filter_set,
-				 comp_set, top_id);
+	sort_subvols(comp_set, subvols);
 
-	print_all_subvol_info(&root_sort, layout);
-	rb_free_nodes(&root_lookup, free_root_info);
+	print_all_subvol_info(subvols, layout);
+	free_subvol_list(subvols);
 
 	return 0;
 }
@@ -1555,6 +1094,7 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 	u64 flags = 0;
 	int fd = -1;
 	u64 top_id;
+	char *top_path = NULL;
 	int ret = -1, uerr = 0;
 	char *subvol;
 	bool is_list_all = false;
@@ -1588,9 +1128,7 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 			btrfs_list_setup_print_column(BTRFS_LIST_OGENERATION);
 			break;
 		case 'd':
-			btrfs_list_setup_filter(&filter_set,
-						BTRFS_LIST_FILTER_DELETED,
-						0);
+			filter_set->only_deleted = 1;
 			break;
 		case 'g':
 			btrfs_list_setup_print_column(BTRFS_LIST_GENERATION);
@@ -1686,6 +1224,19 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 		btrfs_list_setup_filter(&filter_set,
 					BTRFS_LIST_FILTER_TOPID_EQUAL,
 					top_id);
+	else if (!filter_set->only_deleted) {
+		enum btrfs_util_error err;
+
+		err = btrfs_util_subvolume_get_path_fd(fd, top_id, &top_path);
+		if (err) {
+			ret = -1;
+			error_btrfs_util(err);
+			goto out;
+		}
+		btrfs_list_setup_filter(&filter_set,
+					BTRFS_LIST_FILTER_REMOVE_PATH_PREFIX,
+					(u64)top_path);
+	}
 
 	/* by default we shall print the following columns*/
 	btrfs_list_setup_print_column(BTRFS_LIST_OBJECTID);
@@ -1696,10 +1247,10 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 	if (bconf.output_format == CMD_FORMAT_JSON)
 		layout = BTRFS_LIST_LAYOUT_JSON;
 
-	ret = btrfs_list_subvols_print(fd, filter_set, comparer_set,
-			layout, !is_list_all && !is_only_in_path);
+	ret = btrfs_list_subvols_print(fd, filter_set, comparer_set, layout);
 
 out:
+	free(top_path);
 	close(fd);
 	if (filter_set)
 		free(filter_set);
-- 
2.45.2


