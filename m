Return-Path: <linux-btrfs+bounces-405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A957FB4A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 09:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BCD1F20F72
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA291DDCF;
	Tue, 28 Nov 2023 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866F619BD
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 00:45:24 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25CAB1F37E;
	Tue, 28 Nov 2023 08:45:21 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 986FC139FC;
	Tue, 28 Nov 2023 08:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oDoNDp+oZWXSRAAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 28 Nov 2023 08:45:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: william.brown@suse.com
Subject: [PATCH 1/3] btrfs-progs: separate root attributes into a dedicated structure from root_info
Date: Tue, 28 Nov 2023 19:14:51 +1030
Message-ID: <68a035cadd5eb2e80dda85eeb630031234ac1a93.1701160698.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701160698.git.wqu@suse.com>
References: <cover.1701160698.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++++++++++++
X-Spam-Score: 25.58
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	spf=fail (smtp-out2.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 25CAB1F37E
X-Spamd-Result: default: False [25.58 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_SPAM_SHORT(1.98)[0.660];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 BAYES_SPAM(5.10)[99.99%];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

Currently root_info structure contains both the rb-tree structures like
rb_node and sort_node, and the info to describe all the attributes of
the subvolume.

For the incoming expansion on subvolume attributes, we want to parse
those info through a proper structure (without the unnecessary
rb_nodes), other than over a dozen parameters.

Thus this patch would separate the root attributes into root_attr
structure, and root_info would just hold a root_attr structure inside
it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/subvolume-list.c | 330 ++++++++++++++++++++++--------------------
 1 file changed, 170 insertions(+), 160 deletions(-)

diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 5a91f41da998..e0a1c5d4f626 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -102,12 +102,9 @@ enum btrfs_list_layout {
 };
 
 /*
- * one of these for each root we find.
+ * Describle all the info we found for a subvolume.
  */
-struct root_info {
-	struct rb_node rb_node;
-	struct rb_node sort_node;
-
+struct root_attr {
 	/* this root's id */
 	u64 root_id;
 
@@ -146,14 +143,24 @@ struct root_info {
 	/* the name of this root in the directory it lives in */
 	char *name;
 
+	/* length of the above name. */
+	int name_len;
+
 	char *full_path;
 
 	int deleted;
 };
 
-typedef int (*btrfs_list_filter_func)(struct root_info *, u64);
-typedef int (*btrfs_list_comp_func)(const struct root_info *a,
-				    const struct root_info *b);
+struct root_info {
+	struct rb_node rb_node;
+	struct rb_node sort_node;
+
+	struct root_attr attrs;
+};
+
+typedef int (*btrfs_list_filter_func)(struct root_attr *, u64);
+typedef int (*btrfs_list_comp_func)(const struct root_attr *a,
+				    const struct root_attr *b);
 
 struct btrfs_list_filter {
 	btrfs_list_filter_func filter_func;
@@ -309,8 +316,8 @@ static void btrfs_list_setup_print_column(enum btrfs_list_column_enum column)
 		btrfs_list_columns[i].need_print = 1;
 }
 
-static int comp_entry_with_rootid(const struct root_info *entry1,
-				  const struct root_info *entry2)
+static int comp_entry_with_rootid(const struct root_attr *entry1,
+				  const struct root_attr *entry2)
 {
 	if (entry1->root_id > entry2->root_id)
 		return 1;
@@ -319,8 +326,8 @@ static int comp_entry_with_rootid(const struct root_info *entry1,
 	return 0;
 }
 
-static int comp_entry_with_gen(const struct root_info *entry1,
-			       const struct root_info *entry2)
+static int comp_entry_with_gen(const struct root_attr *entry1,
+			       const struct root_attr *entry2)
 {
 	if (entry1->gen > entry2->gen)
 		return 1;
@@ -329,8 +336,8 @@ static int comp_entry_with_gen(const struct root_info *entry1,
 	return 0;
 }
 
-static int comp_entry_with_ogen(const struct root_info *entry1,
-				const struct root_info *entry2)
+static int comp_entry_with_ogen(const struct root_attr *entry1,
+				const struct root_attr *entry2)
 {
 	if (entry1->ogen > entry2->ogen)
 		return 1;
@@ -339,8 +346,8 @@ static int comp_entry_with_ogen(const struct root_info *entry1,
 	return 0;
 }
 
-static int comp_entry_with_path(const struct root_info *entry1,
-				const struct root_info *entry2)
+static int comp_entry_with_path(const struct root_attr *entry1,
+				const struct root_attr *entry2)
 {
 	if (strcmp(entry1->full_path, entry2->full_path) > 0)
 		return 1;
@@ -420,13 +427,13 @@ static int sort_comp(const struct root_info *entry1, const struct root_info *ent
 	int i, ret = 0;
 
 	if (!set || !set->ncomps)
-		return comp_entry_with_rootid(entry1, entry2);
+		return comp_entry_with_rootid(&entry1->attrs, &entry2->attrs);
 
 	for (i = 0; i < set->ncomps; i++) {
 		if (!set->comps[i].comp_func)
 			break;
 
-		ret = set->comps[i].comp_func(entry1, entry2);
+		ret = set->comps[i].comp_func(&entry1->attrs, &entry2->attrs);
 		if (set->comps[i].is_descending)
 			ret = -ret;
 		if (ret)
@@ -437,7 +444,7 @@ static int sort_comp(const struct root_info *entry1, const struct root_info *ent
 	}
 
 	if (!rootid_compared)
-		ret = comp_entry_with_rootid(entry1, entry2);
+		ret = comp_entry_with_rootid(&entry1->attrs, &entry2->attrs);
 
 	return ret;
 }
@@ -486,7 +493,7 @@ static int root_tree_insert(struct rb_root *root_tree,
 		parent = *p;
 		curr = to_root_info(parent);
 
-		ret = comp_entry_with_rootid(ins, curr);
+		ret = comp_entry_with_rootid(&ins->attrs, &curr->attrs);
 		if (ret < 0)
 			p = &(*p)->rb_left;
 		else if (ret > 0)
@@ -509,7 +516,7 @@ static struct root_info *root_tree_search(struct rb_root *root_tree,
 {
 	struct rb_node *n = root_tree->rb_node;
 	struct root_info *entry;
-	struct root_info tmp;
+	struct root_attr tmp;
 	int ret;
 
 	tmp.root_id = root_id;
@@ -517,7 +524,7 @@ static struct root_info *root_tree_search(struct rb_root *root_tree,
 	while(n) {
 		entry = to_root_info(n);
 
-		ret = comp_entry_with_rootid(&tmp, entry);
+		ret = comp_entry_with_rootid(&tmp, &entry->attrs);
 		if (ret < 0)
 			n = n->rb_left;
 		else if (ret > 0)
@@ -534,43 +541,47 @@ static int update_root(struct rb_root *root_lookup,
 		       time_t otime, u8 *uuid, u8 *puuid, u8 *ruuid)
 {
 	struct root_info *ri;
+	struct root_attr *attrs;
 
 	ri = root_tree_search(root_lookup, root_id);
-	if (!ri || ri->root_id != root_id)
+	if (!ri || ri->attrs.root_id != root_id)
 		return -ENOENT;
-	if (name && name_len > 0) {
-		free(ri->name);
 
-		ri->name = malloc(name_len + 1);
-		if (!ri->name) {
+	attrs = &ri->attrs;
+	if (name && name_len > 0) {
+		free(attrs->name);
+
+		attrs->name = malloc(name_len + 1);
+		if (!attrs->name) {
 			error_msg(ERROR_MSG_MEMORY, NULL);
 			exit(1);
 		}
-		strncpy(ri->name, name, name_len);
-		ri->name[name_len] = 0;
+		strncpy(attrs->name, name, name_len);
+		attrs->name[name_len] = 0;
+		attrs->name_len = name_len;
 	}
 	if (ref_tree)
-		ri->ref_tree = ref_tree;
+		attrs->ref_tree = ref_tree;
 	if (root_offset)
-		ri->root_offset = root_offset;
+		attrs->root_offset = root_offset;
 	if (flags)
-		ri->flags = flags;
+		attrs->flags = flags;
 	if (dir_id)
-		ri->dir_id = dir_id;
+		attrs->dir_id = dir_id;
 	if (gen)
-		ri->gen = gen;
+		attrs->gen = gen;
 	if (ogen)
-		ri->ogen = ogen;
-	if (!ri->ogen && root_offset)
-		ri->ogen = root_offset;
+		attrs->ogen = ogen;
+	if (!attrs->ogen && root_offset)
+		attrs->ogen = root_offset;
 	if (otime)
-		ri->otime = otime;
+		attrs->otime = otime;
 	if (uuid)
-		memcpy(&ri->uuid, uuid, BTRFS_UUID_SIZE);
+		memcpy(&attrs->uuid, uuid, BTRFS_UUID_SIZE);
 	if (puuid)
-		memcpy(&ri->puuid, puuid, BTRFS_UUID_SIZE);
+		memcpy(&attrs->puuid, puuid, BTRFS_UUID_SIZE);
 	if (ruuid)
-		memcpy(&ri->ruuid, ruuid, BTRFS_UUID_SIZE);
+		memcpy(&attrs->ruuid, ruuid, BTRFS_UUID_SIZE);
 
 	return 0;
 }
@@ -578,18 +589,7 @@ static int update_root(struct rb_root *root_lookup,
 /*
  * add_root - update the existed root, or allocate a new root and insert it
  *	      into the lookup tree.
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
+ * attrs: the description for the new root.
  */
 static int add_root(struct rb_root *root_lookup,
 		    u64 root_id, u64 ref_tree, u64 root_offset, u64 flags,
@@ -597,6 +597,7 @@ static int add_root(struct rb_root *root_lookup,
 		    time_t otime, u8 *uuid, u8 *puuid, u8 *ruuid)
 {
 	struct root_info *ri;
+	struct root_attr *attrs;
 	int ret;
 
 	ret = update_root(root_lookup, root_id, ref_tree, root_offset, flags,
@@ -610,42 +611,44 @@ static int add_root(struct rb_root *root_lookup,
 		error_msg(ERROR_MSG_MEMORY, NULL);
 		exit(1);
 	}
-	ri->root_id = root_id;
+	attrs = &ri->attrs;
+	attrs->root_id = root_id;
 
 	if (name && name_len > 0) {
-		ri->name = malloc(name_len + 1);
-		if (!ri->name) {
+		attrs->name = malloc(name_len + 1);
+		if (!attrs->name) {
 			error_msg(ERROR_MSG_MEMORY, NULL);
 			exit(1);
 		}
-		strncpy(ri->name, name, name_len);
-		ri->name[name_len] = 0;
+		strncpy(attrs->name, name, name_len);
+		attrs->name[name_len] = 0;
+		attrs->name_len = name_len;
 	}
 	if (ref_tree)
-		ri->ref_tree = ref_tree;
+		attrs->ref_tree = ref_tree;
 	if (dir_id)
-		ri->dir_id = dir_id;
+		attrs->dir_id = dir_id;
 	if (root_offset)
-		ri->root_offset = root_offset;
+		attrs->root_offset = root_offset;
 	if (flags)
-		ri->flags = flags;
+		attrs->flags = flags;
 	if (gen)
-		ri->gen = gen;
+		attrs->gen = gen;
 	if (ogen)
-		ri->ogen = ogen;
-	if (!ri->ogen && root_offset)
-		ri->ogen = root_offset;
+		attrs->ogen = ogen;
+	if (!attrs->ogen && root_offset)
+		attrs->ogen = root_offset;
 	if (otime)
-		ri->otime = otime;
+		attrs->otime = otime;
 
 	if (uuid)
-		memcpy(&ri->uuid, uuid, BTRFS_UUID_SIZE);
+		memcpy(&attrs->uuid, uuid, BTRFS_UUID_SIZE);
 
 	if (puuid)
-		memcpy(&ri->puuid, puuid, BTRFS_UUID_SIZE);
+		memcpy(&attrs->puuid, puuid, BTRFS_UUID_SIZE);
 
 	if (ruuid)
-		memcpy(&ri->ruuid, ruuid, BTRFS_UUID_SIZE);
+		memcpy(&attrs->ruuid, ruuid, BTRFS_UUID_SIZE);
 
 	ret = root_tree_insert(root_lookup, ri);
 	if (ret < 0) {
@@ -672,9 +675,9 @@ static void free_root_info(struct rb_node *node)
 	struct root_info *ri;
 
 	ri = to_root_info(node);
-	free(ri->name);
-	free(ri->path);
-	free(ri->full_path);
+	free(ri->attrs.name);
+	free(ri->attrs.path);
+	free(ri->attrs.full_path);
 	free(ri);
 }
 
@@ -691,6 +694,7 @@ static int resolve_root(struct rb_root *rl, struct root_info *ri,
 	char *full_path = NULL;
 	int len = 0;
 	struct root_info *found;
+	struct root_attr *attrs;
 
 	/*
 	 * we go backwards from the root_info object and add pathnames
@@ -702,16 +706,17 @@ static int resolve_root(struct rb_root *rl, struct root_info *ri,
 		u64 next;
 		int add_len;
 
+		attrs = &found->attrs;
 		/*
 		 * ref_tree = 0 indicates the subvolume
 		 * has been deleted.
 		 */
-		if (!found->ref_tree) {
+		if (!attrs->ref_tree) {
 			free(full_path);
 			return -ENOENT;
 		}
 
-		add_len = strlen(found->path);
+		add_len = strlen(attrs->path);
 
 		if (full_path) {
 			/* room for / and for null */
@@ -722,19 +727,19 @@ static int resolve_root(struct rb_root *rl, struct root_info *ri,
 			}
 			memcpy(tmp + add_len + 1, full_path, len);
 			tmp[add_len] = '/';
-			memcpy(tmp, found->path, add_len);
+			memcpy(tmp, attrs->path, add_len);
 			tmp [add_len + len + 1] = '\0';
 			free(full_path);
 			full_path = tmp;
 			len += add_len + 1;
 		} else {
-			full_path = strdup(found->path);
+			full_path = strdup(attrs->path);
 			len = add_len;
 		}
-		if (!ri->top_id)
-			ri->top_id = found->ref_tree;
+		if (!ri->attrs.top_id)
+			ri->attrs.top_id = attrs->ref_tree;
 
-		next = found->ref_tree;
+		next = attrs->ref_tree;
 		if (next == top_id)
 			break;
 		/*
@@ -754,7 +759,7 @@ static int resolve_root(struct rb_root *rl, struct root_info *ri,
 		}
 	}
 
-	ri->full_path = full_path;
+	ri->attrs.full_path = full_path;
 
 	return 0;
 }
@@ -769,25 +774,26 @@ static int resolve_root(struct rb_root *rl, struct root_info *ri,
 static int lookup_ino_path(int fd, struct root_info *ri)
 {
 	struct btrfs_ioctl_ino_lookup_args args;
+	struct root_attr *attrs = &ri->attrs;
 	int ret;
 
-	if (ri->path)
+	if (attrs->path)
 		return 0;
 
-	if (!ri->ref_tree)
+	if (!attrs->ref_tree)
 		return -ENOENT;
 
 	memset(&args, 0, sizeof(args));
-	args.treeid = ri->ref_tree;
-	args.objectid = ri->dir_id;
+	args.treeid = attrs->ref_tree;
+	args.objectid = attrs->dir_id;
 
 	ret = ioctl(fd, BTRFS_IOC_INO_LOOKUP, &args);
 	if (ret < 0) {
 		if (errno == ENOENT) {
-			ri->ref_tree = 0;
+			attrs->ref_tree = 0;
 			return -ENOENT;
 		}
-		error("failed to lookup path for root %llu: %m", ri->ref_tree);
+		error("failed to lookup path for root %llu: %m", attrs->ref_tree);
 		return ret;
 	}
 
@@ -796,17 +802,17 @@ static int lookup_ino_path(int fd, struct root_info *ri)
 		 * we're in a subdirectory of ref_tree, the kernel ioctl
 		 * puts a / in there for us
 		 */
-		ri->path = malloc(strlen(ri->name) + strlen(args.name) + 1);
-		if (!ri->path) {
+		attrs->path = malloc(strlen(attrs->name) + strlen(args.name) + 1);
+		if (!attrs->path) {
 			error_msg(ERROR_MSG_MEMORY, NULL);
 			exit(1);
 		}
-		strcpy(ri->path, args.name);
-		strcat(ri->path, ri->name);
+		strcpy(attrs->path, args.name);
+		strcat(attrs->path, attrs->name);
 	} else {
 		/* we're at the root of ref_tree */
-		ri->path = strdup(ri->name);
-		if (!ri->path) {
+		attrs->path = strdup(attrs->name);
+		if (!attrs->path) {
 			perror("strdup failed");
 			exit(1);
 		}
@@ -932,87 +938,87 @@ static int list_subvol_search(int fd, struct rb_root *root_lookup)
 	return 0;
 }
 
-static int filter_by_rootid(struct root_info *ri, u64 data)
+static int filter_by_rootid(struct root_attr *ra, u64 data)
 {
-	return ri->root_id == data;
+	return ra->root_id == data;
 }
 
-static int filter_snapshot(struct root_info *ri, u64 data)
+static int filter_snapshot(struct root_attr *ra, u64 data)
 {
-	return !!ri->root_offset;
+	return !!ra->root_offset;
 }
 
-static int filter_flags(struct root_info *ri, u64 flags)
+static int filter_flags(struct root_attr *ra, u64 flags)
 {
-	return ri->flags & flags;
+	return ra->flags & flags;
 }
 
-static int filter_gen_more(struct root_info *ri, u64 data)
+static int filter_gen_more(struct root_attr *ra, u64 data)
 {
-	return ri->gen >= data;
+	return ra->gen >= data;
 }
 
-static int filter_gen_less(struct root_info *ri, u64 data)
+static int filter_gen_less(struct root_attr *ra, u64 data)
 {
-	return ri->gen <= data;
+	return ra->gen <= data;
 }
 
-static int filter_gen_equal(struct root_info  *ri, u64 data)
+static int filter_gen_equal(struct root_attr *ra, u64 data)
 {
-	return ri->gen == data;
+	return ra->gen == data;
 }
 
-static int filter_cgen_more(struct root_info *ri, u64 data)
+static int filter_cgen_more(struct root_attr *ra, u64 data)
 {
-	return ri->ogen >= data;
+	return ra->ogen >= data;
 }
 
-static int filter_cgen_less(struct root_info *ri, u64 data)
+static int filter_cgen_less(struct root_attr *ra, u64 data)
 {
-	return ri->ogen <= data;
+	return ra->ogen <= data;
 }
 
-static int filter_cgen_equal(struct root_info *ri, u64 data)
+static int filter_cgen_equal(struct root_attr *ra, u64 data)
 {
-	return ri->ogen == data;
+	return ra->ogen == data;
 }
 
-static int filter_topid_equal(struct root_info *ri, u64 data)
+static int filter_topid_equal(struct root_attr *ra, u64 data)
 {
-	return ri->top_id == data;
+	return ra->top_id == data;
 }
 
-static int filter_full_path(struct root_info *ri, u64 data)
+static int filter_full_path(struct root_attr *ra, u64 data)
 {
-	if (ri->full_path && ri->top_id != data) {
+	if (ra->full_path && ra->top_id != data) {
 		char *tmp;
 		char p[] = "<FS_TREE>";
 		int add_len = strlen(p);
-		int len = strlen(ri->full_path);
+		int len = strlen(ra->full_path);
 
 		tmp = malloc(len + add_len + 2);
 		if (!tmp) {
 			error_msg(ERROR_MSG_MEMORY, NULL);
 			exit(1);
 		}
-		memcpy(tmp + add_len + 1, ri->full_path, len);
+		memcpy(tmp + add_len + 1, ra->full_path, len);
 		tmp[len + add_len + 1] = '\0';
 		tmp[add_len] = '/';
 		memcpy(tmp, p, add_len);
-		free(ri->full_path);
-		ri->full_path = tmp;
+		free(ra->full_path);
+		ra->full_path = tmp;
 	}
 	return 1;
 }
 
-static int filter_by_parent(struct root_info *ri, u64 data)
+static int filter_by_parent(struct root_attr *ra, u64 data)
 {
-	return !uuid_compare(ri->puuid, (u8 *)(unsigned long)data);
+	return !uuid_compare(ra->puuid, (u8 *)(unsigned long)data);
 }
 
-static int filter_deleted(struct root_info *ri, u64 data)
+static int filter_deleted(struct root_attr *ra, u64 data)
 {
-	return ri->deleted;
+	return ra->deleted;
 }
 
 static btrfs_list_filter_func all_filter_funcs[] = {
@@ -1075,7 +1081,7 @@ static void btrfs_list_setup_filter(struct btrfs_list_filter_set **filter_set,
 	set->nfilters++;
 }
 
-static int filter_root(struct root_info *ri,
+static int filter_root(struct root_attr *ra,
 		       struct btrfs_list_filter_set *set)
 {
 	int i, ret;
@@ -1083,16 +1089,16 @@ static int filter_root(struct root_info *ri,
 	if (!set)
 		return 1;
 
-	if (set->only_deleted && !ri->deleted)
+	if (set->only_deleted && !ra->deleted)
 		return 0;
 
-	if (!set->only_deleted && ri->deleted)
+	if (!set->only_deleted && ra->deleted)
 		return 0;
 
 	for (i = 0; i < set->nfilters; i++) {
 		if (!set->filters[i].filter_func)
 			break;
-		ret = set->filters[i].filter_func(ri, set->filters[i].data);
+		ret = set->filters[i].filter_func(ra, set->filters[i].data);
 		if (!ret)
 			return 0;
 	}
@@ -1113,24 +1119,26 @@ static void filter_and_sort_subvol(struct rb_root *all_subvols,
 
 	n = rb_last(all_subvols);
 	while (n) {
+		struct root_attr *attrs;
 		entry = to_root_info(n);
+		attrs = &entry->attrs;
 
 		ret = resolve_root(all_subvols, entry, top_id);
 		if (ret == -ENOENT) {
-			if (entry->root_id != BTRFS_FS_TREE_OBJECTID) {
-				entry->full_path = strdup("DELETED");
-				entry->deleted = 1;
+			if (attrs->root_id != BTRFS_FS_TREE_OBJECTID) {
+				attrs->full_path = strdup("DELETED");
+				attrs->deleted = 1;
 			} else {
 				/*
 				 * The full path is not supposed to be printed,
 				 * but we don't want to print an empty string,
 				 * in case it appears somewhere.
 				 */
-				entry->full_path = strdup("TOPLEVEL");
-				entry->deleted = 0;
+				attrs->full_path = strdup("TOPLEVEL");
+				attrs->deleted = 0;
 			}
 		}
-		ret = filter_root(entry, filter_set);
+		ret = filter_root(attrs, filter_set);
 		if (ret)
 			sort_tree_insert(sort_tree, entry, comp_set);
 		n = rb_prev(n);
@@ -1142,59 +1150,60 @@ static void print_subvolume_column(struct root_info *subv,
 {
 	char tstr[256];
 	char uuidparse[BTRFS_UUID_UNPARSED_SIZE];
+	struct root_attr *attrs = &subv->attrs;
 
 	UASSERT(0 <= column && column < BTRFS_LIST_ALL);
 
 	switch (column) {
 	case BTRFS_LIST_OBJECTID:
-		pr_verbose(LOG_DEFAULT, "%llu", subv->root_id);
+		pr_verbose(LOG_DEFAULT, "%llu", attrs->root_id);
 		break;
 	case BTRFS_LIST_GENERATION:
-		pr_verbose(LOG_DEFAULT, "%llu", subv->gen);
+		pr_verbose(LOG_DEFAULT, "%llu", attrs->gen);
 		break;
 	case BTRFS_LIST_OGENERATION:
-		pr_verbose(LOG_DEFAULT, "%llu", subv->ogen);
+		pr_verbose(LOG_DEFAULT, "%llu", attrs->ogen);
 		break;
 	case BTRFS_LIST_PARENT:
-		pr_verbose(LOG_DEFAULT, "%llu", subv->ref_tree);
+		pr_verbose(LOG_DEFAULT, "%llu", attrs->ref_tree);
 		break;
 	case BTRFS_LIST_TOP_LEVEL:
-		pr_verbose(LOG_DEFAULT, "%llu", subv->top_id);
+		pr_verbose(LOG_DEFAULT, "%llu", attrs->top_id);
 		break;
 	case BTRFS_LIST_OTIME:
-		if (subv->otime) {
+		if (attrs->otime) {
 			struct tm tm;
 
-			localtime_r(&subv->otime, &tm);
+			localtime_r(&attrs->otime, &tm);
 			strftime(tstr, 256, "%Y-%m-%d %X", &tm);
 		} else
 			strcpy(tstr, "-");
 		pr_verbose(LOG_DEFAULT, "%s", tstr);
 		break;
 	case BTRFS_LIST_UUID:
-		if (uuid_is_null(subv->uuid))
+		if (uuid_is_null(attrs->uuid))
 			strcpy(uuidparse, "-");
 		else
-			uuid_unparse(subv->uuid, uuidparse);
+			uuid_unparse(attrs->uuid, uuidparse);
 		pr_verbose(LOG_DEFAULT, "%-36s", uuidparse);
 		break;
 	case BTRFS_LIST_PUUID:
-		if (uuid_is_null(subv->puuid))
+		if (uuid_is_null(attrs->puuid))
 			strcpy(uuidparse, "-");
 		else
-			uuid_unparse(subv->puuid, uuidparse);
+			uuid_unparse(attrs->puuid, uuidparse);
 		pr_verbose(LOG_DEFAULT, "%-36s", uuidparse);
 		break;
 	case BTRFS_LIST_RUUID:
-		if (uuid_is_null(subv->ruuid))
+		if (uuid_is_null(attrs->ruuid))
 			strcpy(uuidparse, "-");
 		else
-			uuid_unparse(subv->ruuid, uuidparse);
+			uuid_unparse(attrs->ruuid, uuidparse);
 		pr_verbose(LOG_DEFAULT, "%-36s", uuidparse);
 		break;
 	case BTRFS_LIST_PATH:
-		BUG_ON(!subv->full_path);
-		pr_verbose(LOG_DEFAULT, "%s", subv->full_path);
+		BUG_ON(!attrs->full_path);
+		pr_verbose(LOG_DEFAULT, "%s", attrs->full_path);
 		break;
 	default:
 		break;
@@ -1288,41 +1297,42 @@ static void print_subvol_json_key(struct format_ctx *fctx,
 				  const enum btrfs_list_column_enum column)
 {
 	const char *column_name;
+	struct root_attr const *attrs = &subv->attrs;
 
 	UASSERT(0 <= column && column < BTRFS_LIST_ALL);
 
 	column_name = btrfs_list_columns[column].name;
 	switch (column) {
 	case BTRFS_LIST_OBJECTID:
-		fmt_print(fctx, column_name, subv->root_id);
+		fmt_print(fctx, column_name, attrs->root_id);
 		break;
 	case BTRFS_LIST_GENERATION:
-		fmt_print(fctx, column_name, subv->gen);
+		fmt_print(fctx, column_name, attrs->gen);
 		break;
 	case BTRFS_LIST_OGENERATION:
-		fmt_print(fctx, column_name, subv->ogen);
+		fmt_print(fctx, column_name, attrs->ogen);
 		break;
 	case BTRFS_LIST_PARENT:
-		fmt_print(fctx, column_name, subv->ref_tree);
+		fmt_print(fctx, column_name, attrs->ref_tree);
 		break;
 	case BTRFS_LIST_TOP_LEVEL:
-		fmt_print(fctx, column_name, subv->top_id);
+		fmt_print(fctx, column_name, attrs->top_id);
 		break;
 	case BTRFS_LIST_OTIME:
-		fmt_print(fctx, column_name, subv->otime);
+		fmt_print(fctx, column_name, attrs->otime);
 		break;
 	case BTRFS_LIST_UUID:
-		fmt_print(fctx, column_name, subv->uuid);
+		fmt_print(fctx, column_name, attrs->uuid);
 		break;
 	case BTRFS_LIST_PUUID:
-		fmt_print(fctx, column_name, subv->puuid);
+		fmt_print(fctx, column_name, attrs->puuid);
 		break;
 	case BTRFS_LIST_RUUID:
-		fmt_print(fctx, column_name, subv->ruuid);
+		fmt_print(fctx, column_name, attrs->ruuid);
 		break;
 	case BTRFS_LIST_PATH:
-		BUG_ON(!subv->full_path);
-		fmt_print(fctx, column_name, subv->full_path);
+		BUG_ON(!attrs->full_path);
+		fmt_print(fctx, column_name, attrs->full_path);
 		break;
 	default:
 		break;
@@ -1366,7 +1376,7 @@ static void print_all_subvol_info(struct rb_root *sorted_tree,
 		entry = to_root_info_sorted(n);
 
 		/* The toplevel subvolume is not listed by default */
-		if (entry->root_id == BTRFS_FS_TREE_OBJECTID)
+		if (entry->attrs.root_id == BTRFS_FS_TREE_OBJECTID)
 			goto next;
 
 		switch (layout) {
-- 
2.42.1


