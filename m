Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C356F4FDF
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 08:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjECGEL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 02:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjECGEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 02:04:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E612D69
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 23:04:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95F1B222BB
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683093844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gc/DcSbgkZXnc9yM9UIWCvrDywEwKTPSSDEFALYanp4=;
        b=f3rdgFkb0tM7weLVKiNKIVDybw2YITyarTX836JK4lRhjgZYoLoicSl4bD+j3QL+sKk+Ta
        xrTs4NcccaOuQD6w3THsf4039+0r46RqRYs9zUFKKFTouVbPQ4MfMIVOHYJufCNXca5Deb
        R0rAGNGv94d1eWRYWPEkr+N22TXygcM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA49C139F8
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iCuJJ1P5UWSTJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:04:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/7] btrfs-progs: libbtrfs: remove the support for fs without uuid tree
Date:   Wed,  3 May 2023 14:03:38 +0800
Message-Id: <6e07c5dd154bc70f9f0a1f9c31cede88dd564bb3.1683093416.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683093416.git.wqu@suse.com>
References: <cover.1683093416.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since kernel 3.12, any btrfs mounted by a kernel would have an UUID
tree created, to record all the UUID of its subvolumes.

Without UUID tree, libbtrfs send functionality has to go through all the
subvolumes seen so far, and record those subvolumes' UUID internally so
that libbtrfs send can locate a desired subvolume.

Since commit 194b90aa2c5a ("btrfs-progs: libbtrfs: remove declarations
without exports in send-utils") we're deprecating this old interface
already, meaning deprecated users won't be able to build its own
subvolume list already.

And we received no error report on this so far.

So let's finish the cleanup by removing the support for fs without an UUID
tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 libbtrfs/send-utils.c | 396 ------------------------------------------
 libbtrfs/send-utils.h |  20 ---
 2 files changed, 416 deletions(-)

diff --git a/libbtrfs/send-utils.c b/libbtrfs/send-utils.c
index 831ec0dc1222..74bf86be7673 100644
--- a/libbtrfs/send-utils.c
+++ b/libbtrfs/send-utils.c
@@ -199,73 +199,6 @@ static int btrfs_read_root_item(int mnt_fd, u64 root_id,
 	return 0;
 }
 
-#ifdef BTRFS_COMPAT_SEND_NO_UUID_TREE
-static struct rb_node *tree_insert(struct rb_root *root,
-				   struct subvol_info *si,
-				   enum subvol_search_type type)
-{
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent = NULL;
-	struct subvol_info *entry;
-	__s64 comp;
-
-	while (*p) {
-		parent = *p;
-		if (type == subvol_search_by_received_uuid) {
-			entry = rb_entry(parent, struct subvol_info,
-					rb_received_node);
-
-			comp = memcmp(entry->received_uuid, si->received_uuid,
-					BTRFS_UUID_SIZE);
-			if (!comp) {
-				if (entry->stransid < si->stransid)
-					comp = -1;
-				else if (entry->stransid > si->stransid)
-					comp = 1;
-				else
-					comp = 0;
-			}
-		} else if (type == subvol_search_by_uuid) {
-			entry = rb_entry(parent, struct subvol_info,
-					rb_local_node);
-			comp = memcmp(entry->uuid, si->uuid, BTRFS_UUID_SIZE);
-		} else if (type == subvol_search_by_root_id) {
-			entry = rb_entry(parent, struct subvol_info,
-					rb_root_id_node);
-			comp = entry->root_id - si->root_id;
-		} else if (type == subvol_search_by_path) {
-			entry = rb_entry(parent, struct subvol_info,
-					rb_path_node);
-			comp = strcmp(entry->path, si->path);
-		} else {
-			BUG();
-		}
-
-		if (comp < 0)
-			p = &(*p)->rb_left;
-		else if (comp > 0)
-			p = &(*p)->rb_right;
-		else
-			return parent;
-	}
-
-	if (type == subvol_search_by_received_uuid) {
-		rb_link_node(&si->rb_received_node, parent, p);
-		rb_insert_color(&si->rb_received_node, root);
-	} else if (type == subvol_search_by_uuid) {
-		rb_link_node(&si->rb_local_node, parent, p);
-		rb_insert_color(&si->rb_local_node, root);
-	} else if (type == subvol_search_by_root_id) {
-		rb_link_node(&si->rb_root_id_node, parent, p);
-		rb_insert_color(&si->rb_root_id_node, root);
-	} else if (type == subvol_search_by_path) {
-		rb_link_node(&si->rb_path_node, parent, p);
-		rb_insert_color(&si->rb_path_node, root);
-	}
-	return NULL;
-}
-#endif
-
 int btrfs_subvolid_resolve(int fd, char *path, size_t path_len, u64 subvol_id)
 {
 	if (path_len < 1)
@@ -364,114 +297,6 @@ static int btrfs_subvolid_resolve_sub(int fd, char *path, size_t *path_len,
 	return 0;
 }
 
-#ifdef BTRFS_COMPAT_SEND_NO_UUID_TREE
-static int count_bytes(void *buf, int len, char b)
-{
-	int cnt = 0;
-	int i;
-
-	for (i = 0; i < len; i++) {
-		if (((char *)buf)[i] == b)
-			cnt++;
-	}
-	return cnt;
-}
-
-void subvol_uuid_search_add(struct subvol_uuid_search *s,
-			    struct subvol_info *si)
-{
-	int cnt;
-
-	tree_insert(&s->root_id_subvols, si, subvol_search_by_root_id);
-	tree_insert(&s->path_subvols, si, subvol_search_by_path);
-
-	cnt = count_bytes(si->uuid, BTRFS_UUID_SIZE, 0);
-	if (cnt != BTRFS_UUID_SIZE)
-		tree_insert(&s->local_subvols, si, subvol_search_by_uuid);
-	cnt = count_bytes(si->received_uuid, BTRFS_UUID_SIZE, 0);
-	if (cnt != BTRFS_UUID_SIZE)
-		tree_insert(&s->received_subvols, si,
-				subvol_search_by_received_uuid);
-}
-
-static struct subvol_info *tree_search(struct rb_root *root,
-				       u64 root_id, const u8 *uuid,
-				       u64 stransid, const char *path,
-				       enum subvol_search_type type)
-{
-	struct rb_node *n = root->rb_node;
-	struct subvol_info *entry;
-	__s64 comp;
-
-	while (n) {
-		if (type == subvol_search_by_received_uuid) {
-			entry = rb_entry(n, struct subvol_info,
-					rb_received_node);
-			comp = memcmp(entry->received_uuid, uuid,
-					BTRFS_UUID_SIZE);
-			if (!comp) {
-				if (entry->stransid < stransid)
-					comp = -1;
-				else if (entry->stransid > stransid)
-					comp = 1;
-				else
-					comp = 0;
-			}
-		} else if (type == subvol_search_by_uuid) {
-			entry = rb_entry(n, struct subvol_info, rb_local_node);
-			comp = memcmp(entry->uuid, uuid, BTRFS_UUID_SIZE);
-		} else if (type == subvol_search_by_root_id) {
-			entry = rb_entry(n, struct subvol_info,
-					 rb_root_id_node);
-			comp = entry->root_id - root_id;
-		} else if (type == subvol_search_by_path) {
-			entry = rb_entry(n, struct subvol_info, rb_path_node);
-			comp = strcmp(entry->path, path);
-		} else {
-			BUG();
-		}
-		if (comp < 0)
-			n = n->rb_left;
-		else if (comp > 0)
-			n = n->rb_right;
-		else
-			return entry;
-	}
-	return NULL;
-}
-
-/*
- * this function will be only called if kernel doesn't support uuid tree.
- */
-static struct subvol_info *subvol_uuid_search_old(struct subvol_uuid_search *s,
-				       u64 root_id, const u8 *uuid, u64 transid,
-				       const char *path,
-				       enum subvol_search_type type)
-{
-	struct rb_root *root;
-	if (type == subvol_search_by_received_uuid)
-		root = &s->received_subvols;
-	else if (type == subvol_search_by_uuid)
-		root = &s->local_subvols;
-	else if (type == subvol_search_by_root_id)
-		root = &s->root_id_subvols;
-	else if (type == subvol_search_by_path)
-		root = &s->path_subvols;
-	else
-		return NULL;
-	return tree_search(root, root_id, uuid, transid, path, type);
-}
-#else
-void subvol_uuid_search_add(struct subvol_uuid_search *s,
-			    struct subvol_info *si)
-{
-	if (si) {
-		free(si->path);
-		free(si);
-	}
-}
-#endif
-
 static struct subvol_info *subvol_uuid_search2(struct subvol_uuid_search *s,
 				       u64 root_id, const u8 *uuid, u64 transid,
 				       const char *path,
@@ -569,11 +394,6 @@ static struct subvol_info *subvol_uuid_search2(struct subvol_uuid_search *s,
 	struct btrfs_root_item root_item;
 	struct subvol_info *info = NULL;
 
-#ifdef BTRFS_COMPAT_SEND_NO_UUID_TREE
-	if (!s->uuid_tree_existed)
-		return subvol_uuid_search_old(s, root_id, uuid, transid,
-					     path, type);
-#endif
 	switch (type) {
 	case subvol_search_by_received_uuid:
 		ret = btrfs_uuid_tree_lookup_any(s->mnt_fd, uuid,
@@ -640,219 +460,3 @@ out:
 
 	return info;
 }
-
-#ifdef BTRFS_COMPAT_SEND_NO_UUID_TREE
-static int is_uuid_tree_supported(int fd)
-{
-	int ret;
-	struct btrfs_ioctl_search_args args;
-	struct btrfs_ioctl_search_key *sk = &args.key;
-
-	memset(&args, 0, sizeof(args));
-
-	sk->tree_id = BTRFS_ROOT_TREE_OBJECTID;
-
-	sk->min_objectid = BTRFS_UUID_TREE_OBJECTID;
-	sk->max_objectid = BTRFS_UUID_TREE_OBJECTID;
-	sk->max_type = BTRFS_ROOT_ITEM_KEY;
-	sk->min_type = BTRFS_ROOT_ITEM_KEY;
-	sk->max_offset = (u64)-1;
-	sk->max_transid = (u64)-1;
-	sk->nr_items = 1;
-
-	ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
-	if (ret < 0)
-		return ret;
-
-	/* the ioctl returns the number of item it found in nr_items */
-	if (sk->nr_items == 0)
-		return 0;
-
-	return 1;
-}
-
-/*
- * this function is mainly used to read all root items
- * it will be only used when we use older kernel which uuid
- * tree is not supported yet
- */
-int subvol_uuid_search_init(int mnt_fd, struct subvol_uuid_search *s)
-{
-	int ret;
-	struct btrfs_ioctl_search_args args;
-	struct btrfs_ioctl_search_key *sk = &args.key;
-	struct btrfs_ioctl_search_header *sh;
-	struct btrfs_root_item *root_item_ptr;
-	struct btrfs_root_item root_item = {};
-	struct subvol_info *si = NULL;
-	int root_item_valid = 0;
-	unsigned long off = 0;
-	int i;
-
-	s->mnt_fd = mnt_fd;
-
-	s->root_id_subvols = RB_ROOT;
-	s->local_subvols = RB_ROOT;
-	s->received_subvols = RB_ROOT;
-	s->path_subvols = RB_ROOT;
-
-	ret = is_uuid_tree_supported(mnt_fd);
-	if (ret < 0) {
-		fprintf(stderr,
-			"ERROR: check if we support uuid tree fails - %m\n");
-		return ret;
-	} else if (ret) {
-		/* uuid tree is supported */
-		s->uuid_tree_existed = 1;
-		return 0;
-	}
-	memset(&args, 0, sizeof(args));
-
-	sk->tree_id = BTRFS_ROOT_TREE_OBJECTID;
-
-	sk->max_objectid = (u64)-1;
-	sk->max_offset = (u64)-1;
-	sk->max_transid = (u64)-1;
-	sk->min_type = BTRFS_ROOT_ITEM_KEY;
-	sk->max_type = BTRFS_ROOT_BACKREF_KEY;
-	sk->nr_items = 4096;
-
-	while (1) {
-		ret = ioctl(mnt_fd, BTRFS_IOC_TREE_SEARCH, &args);
-		if (ret < 0) {
-			fprintf(stderr, "ERROR: can't perform the search - %m\n");
-			return ret;
-		}
-		if (sk->nr_items == 0)
-			break;
-
-		off = 0;
-
-		for (i = 0; i < sk->nr_items; i++) {
-			sh = (struct btrfs_ioctl_search_header *)(args.buf +
-								  off);
-			off += sizeof(*sh);
-
-			if ((btrfs_search_header_objectid(sh) != 5 &&
-			     btrfs_search_header_objectid(sh)
-			     < BTRFS_FIRST_FREE_OBJECTID) ||
-			    btrfs_search_header_objectid(sh)
-			    > BTRFS_LAST_FREE_OBJECTID) {
-				goto skip;
-			}
-
-			if (btrfs_search_header_type(sh)
-			    == BTRFS_ROOT_ITEM_KEY) {
-				/* older kernels don't have uuids+times */
-				if (btrfs_search_header_len(sh)
-				    < sizeof(root_item)) {
-					root_item_valid = 0;
-					goto skip;
-				}
-				root_item_ptr = (struct btrfs_root_item *)
-						(args.buf + off);
-				memcpy(&root_item, root_item_ptr,
-						sizeof(root_item));
-				root_item_valid = 1;
-			} else if (btrfs_search_header_type(sh)
-				   == BTRFS_ROOT_BACKREF_KEY ||
-				   root_item_valid) {
-				char path_buf[PATH_MAX];
-				char *path;
-
-				if (!root_item_valid)
-					goto skip;
-
-				ret = btrfs_subvolid_resolve(mnt_fd, path_buf,
-						sizeof(path_buf),
-						btrfs_search_header_objectid(sh));
-				if (ret < 0) {
-					errno = -ret;
-					fprintf(stderr, "ERROR: unable to "
-							"resolve path "
-							"for root %llu: %m\n",
-						btrfs_search_header_objectid(sh));
-					goto out;
-				}
-				path = strdup(path_buf);
-
-				si = calloc(1, sizeof(*si));
-				si->root_id = btrfs_search_header_objectid(sh);
-				memcpy(si->uuid, root_item.uuid,
-						BTRFS_UUID_SIZE);
-				memcpy(si->parent_uuid, root_item.parent_uuid,
-						BTRFS_UUID_SIZE);
-				memcpy(si->received_uuid,
-						root_item.received_uuid,
-						BTRFS_UUID_SIZE);
-				si->ctransid = btrfs_root_ctransid(&root_item);
-				si->otransid = btrfs_root_otransid(&root_item);
-				si->stransid = btrfs_root_stransid(&root_item);
-				si->rtransid = btrfs_root_rtransid(&root_item);
-				si->path = path;
-				subvol_uuid_search_add(s, si);
-				root_item_valid = 0;
-			} else {
-				goto skip;
-			}
-
-skip:
-			off += btrfs_search_header_len(sh);
-
-			/*
-			 * record the mins in sk so we can make sure the
-			 * next search doesn't repeat this root
-			 */
-			sk->min_objectid = btrfs_search_header_objectid(sh);
-			sk->min_offset = btrfs_search_header_offset(sh);
-			sk->min_type = btrfs_search_header_type(sh);
-		}
-		sk->nr_items = 4096;
-		if (sk->min_offset < (u64)-1)
-			sk->min_offset++;
-		else if (sk->min_objectid < (u64)-1) {
-			sk->min_objectid++;
-			sk->min_offset = 0;
-			sk->min_type = 0;
-		} else
-			break;
-	}
-
-out:
-	return ret;
-}
-
-void subvol_uuid_search_finit(struct subvol_uuid_search *s)
-{
-	struct rb_root *root = &s->root_id_subvols;
-	struct rb_node *node;
-
-	if (!s->uuid_tree_existed)
-		return;
-
-	while ((node = rb_first(root))) {
-		struct subvol_info *entry =
-			rb_entry(node, struct subvol_info, rb_root_id_node);
-
-		free(entry->path);
-		rb_erase(node, root);
-		free(entry);
-	}
-
-	s->root_id_subvols = RB_ROOT;
-	s->local_subvols = RB_ROOT;
-	s->received_subvols = RB_ROOT;
-	s->path_subvols = RB_ROOT;
-}
-#else
-int subvol_uuid_search_init(int mnt_fd, struct subvol_uuid_search *s)
-{
-	s->mnt_fd = mnt_fd;
-
-	return 0;
-}
-
-void subvol_uuid_search_finit(struct subvol_uuid_search *s)
-{
-}
-#endif
diff --git a/libbtrfs/send-utils.h b/libbtrfs/send-utils.h
index b39ee9255598..be6f91b1d7bb 100644
--- a/libbtrfs/send-utils.h
+++ b/libbtrfs/send-utils.h
@@ -35,12 +35,6 @@
 extern "C" {
 #endif
 
-/*
- * Compatibility code for kernels < 3.12; the UUID tree is not available there
- * and we have to do the slow search. This should be deprecated someday.
- */
-#define BTRFS_COMPAT_SEND_NO_UUID_TREE 1
-
 enum subvol_search_type {
 	subvol_search_by_root_id,
 	subvol_search_by_uuid,
@@ -49,12 +43,6 @@ enum subvol_search_type {
 };
 
 struct subvol_info {
-#ifdef BTRFS_COMPAT_SEND_NO_UUID_TREE
-	struct rb_node rb_root_id_node;
-	struct rb_node rb_local_node;
-	struct rb_node rb_received_node;
-	struct rb_node rb_path_node;
-#endif
 
 	u64 root_id;
 	u8 uuid[BTRFS_UUID_SIZE];
@@ -70,14 +58,6 @@ struct subvol_info {
 
 struct subvol_uuid_search {
 	int mnt_fd;
-#ifdef BTRFS_COMPAT_SEND_NO_UUID_TREE
-	int uuid_tree_existed;
-
-	struct rb_root root_id_subvols;
-	struct rb_root local_subvols;
-	struct rb_root received_subvols;
-	struct rb_root path_subvols;
-#endif
 };
 
 int subvol_uuid_search_init(int mnt_fd, struct subvol_uuid_search *s);
-- 
2.39.2

