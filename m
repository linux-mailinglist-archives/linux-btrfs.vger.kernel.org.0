Return-Path: <linux-btrfs+bounces-404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA57FB4A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 09:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3012A1C21004
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 08:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F3C1BDF8;
	Tue, 28 Nov 2023 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ujTgZhTX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E11194
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 00:45:24 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B6F22191E;
	Tue, 28 Nov 2023 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701161123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUgn9MC7LXRMWyQDfRAzXqZRA6B3sYYLUBVRIn+B4Xc=;
	b=ujTgZhTXwCBvyhyEIJLHOlXQ5cKtZHJzKQ0hl2MFeJX7r+0MRv2QoxoLIEZjc2nLF27Zfs
	snmwY3rmth1G+ViBYACzISDjdojjAL8SNOqWYtMSJAF7baxcUQjcjQuHp6i8f1HWrar0VU
	FfL5sPMbygmGHXmi6A2NtNihUXNP7Y8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DF31C139FC;
	Tue, 28 Nov 2023 08:45:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cBvgIKGoZWXSRAAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 28 Nov 2023 08:45:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: william.brown@suse.com
Subject: [PATCH 2/3] btrfs-progs: use root_attr structure to pass various attributes
Date: Tue, 28 Nov 2023 19:14:52 +1030
Message-ID: <0d32a74f55755f42ccb96c80471f76abd6cdaaec.1701160698.git.wqu@suse.com>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 9.00
X-Spamd-Result: default: False [9.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[99.99%];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

Currently for the following functions, we have at least 14 parameters,
just to describle various attributes:

- update_root()
- add_root()
- add_root_backref()

With the recent introduce of root_attr structure, we can easily replace
those parameters with a root_attr structure pointer.

Furthermore, since add_root() and update_root() are both updating the
same structure, we can also extract a update_root_attr() helper, to
remove the duplicated code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/subvolume-list.c | 188 ++++++++++++++++--------------------------
 1 file changed, 72 insertions(+), 116 deletions(-)

diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index e0a1c5d4f626..e05f7228b889 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -535,54 +535,57 @@ static struct root_info *root_tree_search(struct rb_root *root_tree,
 	return NULL;
 }
 
-static int update_root(struct rb_root *root_lookup,
-		       u64 root_id, u64 ref_tree, u64 root_offset, u64 flags,
-		       u64 dir_id, char *name, int name_len, u64 ogen, u64 gen,
-		       time_t otime, u8 *uuid, u8 *puuid, u8 *ruuid)
+/* Update the root attributes of @found to @new, except the rootid. */
+static void update_root_attr(struct root_attr *found,
+			     const struct root_attr *new)
 {
-	struct root_info *ri;
-	struct root_attr *attrs;
+	if (new->name && new->name_len > 0) {
+		free(found->name);
 
-	ri = root_tree_search(root_lookup, root_id);
-	if (!ri || ri->attrs.root_id != root_id)
-		return -ENOENT;
-
-	attrs = &ri->attrs;
-	if (name && name_len > 0) {
-		free(attrs->name);
-
-		attrs->name = malloc(name_len + 1);
-		if (!attrs->name) {
+		found->name = malloc(new->name_len + 1);
+		if (!found->name) {
 			error_msg(ERROR_MSG_MEMORY, NULL);
 			exit(1);
 		}
-		strncpy(attrs->name, name, name_len);
-		attrs->name[name_len] = 0;
-		attrs->name_len = name_len;
+		strncpy(found->name, new->name, new->name_len);
+		found->name[new->name_len] = '\0';
+		found->name_len = new->name_len;
 	}
-	if (ref_tree)
-		attrs->ref_tree = ref_tree;
-	if (root_offset)
-		attrs->root_offset = root_offset;
-	if (flags)
-		attrs->flags = flags;
-	if (dir_id)
-		attrs->dir_id = dir_id;
-	if (gen)
-		attrs->gen = gen;
-	if (ogen)
-		attrs->ogen = ogen;
-	if (!attrs->ogen && root_offset)
-		attrs->ogen = root_offset;
-	if (otime)
-		attrs->otime = otime;
-	if (uuid)
-		memcpy(&attrs->uuid, uuid, BTRFS_UUID_SIZE);
-	if (puuid)
-		memcpy(&attrs->puuid, puuid, BTRFS_UUID_SIZE);
-	if (ruuid)
-		memcpy(&attrs->ruuid, ruuid, BTRFS_UUID_SIZE);
+	if (new->ref_tree)
+		found->ref_tree = new->ref_tree;
+	if (new->root_offset)
+		found->root_offset = new->root_offset;
+	if (new->flags)
+		found->flags = new->flags;
+	if (new->dir_id)
+		found->dir_id = new->dir_id;
+	if (new->gen)
+		found->gen = new->gen;
+	if (new->ogen)
+		found->ogen = new->ogen;
+	if (!found->ogen && new->root_offset)
+		found->ogen = new->root_offset;
+	if (new->otime)
+		found->otime = new->otime;
+	if (new->uuid[0])
+		memcpy(&found->uuid, new->uuid, BTRFS_UUID_SIZE);
+	if (new->puuid[0])
+		memcpy(&found->puuid, new->puuid, BTRFS_UUID_SIZE);
+	if (new->ruuid[0])
+		memcpy(&found->ruuid, new->ruuid, BTRFS_UUID_SIZE);
 
+}
+
+static int update_root(struct rb_root *root_lookup,
+		       struct root_attr const *new)
+{
+	struct root_info *ri;
+
+	ri = root_tree_search(root_lookup, new->root_id);
+	if (!ri || ri->attrs.root_id != new->root_id)
+		return -ENOENT;
+
+	update_root_attr(&ri->attrs, new);
 	return 0;
 }
 
@@ -591,18 +594,12 @@ static int update_root(struct rb_root *root_lookup,
  *	      into the lookup tree.
  * attrs: the description for the new root.
  */
-static int add_root(struct rb_root *root_lookup,
-		    u64 root_id, u64 ref_tree, u64 root_offset, u64 flags,
-		    u64 dir_id, char *name, int name_len, u64 ogen, u64 gen,
-		    time_t otime, u8 *uuid, u8 *puuid, u8 *ruuid)
+static int add_root(struct rb_root *root_lookup, const struct root_attr *new)
 {
 	struct root_info *ri;
-	struct root_attr *attrs;
 	int ret;
 
-	ret = update_root(root_lookup, root_id, ref_tree, root_offset, flags,
-			  dir_id, name, name_len, ogen, gen, otime,
-			  uuid, puuid, ruuid);
+	ret = update_root(root_lookup, new);
 	if (!ret)
 		return 0;
 
@@ -611,49 +608,14 @@ static int add_root(struct rb_root *root_lookup,
 		error_msg(ERROR_MSG_MEMORY, NULL);
 		exit(1);
 	}
-	attrs = &ri->attrs;
-	attrs->root_id = root_id;
+	ri->attrs.root_id = new->root_id;
 
-	if (name && name_len > 0) {
-		attrs->name = malloc(name_len + 1);
-		if (!attrs->name) {
-			error_msg(ERROR_MSG_MEMORY, NULL);
-			exit(1);
-		}
-		strncpy(attrs->name, name, name_len);
-		attrs->name[name_len] = 0;
-		attrs->name_len = name_len;
-	}
-	if (ref_tree)
-		attrs->ref_tree = ref_tree;
-	if (dir_id)
-		attrs->dir_id = dir_id;
-	if (root_offset)
-		attrs->root_offset = root_offset;
-	if (flags)
-		attrs->flags = flags;
-	if (gen)
-		attrs->gen = gen;
-	if (ogen)
-		attrs->ogen = ogen;
-	if (!attrs->ogen && root_offset)
-		attrs->ogen = root_offset;
-	if (otime)
-		attrs->otime = otime;
-
-	if (uuid)
-		memcpy(&attrs->uuid, uuid, BTRFS_UUID_SIZE);
-
-	if (puuid)
-		memcpy(&attrs->puuid, puuid, BTRFS_UUID_SIZE);
-
-	if (ruuid)
-		memcpy(&attrs->ruuid, ruuid, BTRFS_UUID_SIZE);
+	update_root_attr(&ri->attrs, new);
 
 	ret = root_tree_insert(root_lookup, ri);
 	if (ret < 0) {
 		errno = -ret;
-		error("failed to insert subvolume %llu to tree: %m", root_id);
+		error("failed to insert subvolume %llu to tree: %m", new->root_id);
 		exit(1);
 	}
 	return 0;
@@ -666,8 +628,15 @@ static int add_root(struct rb_root *root_lookup,
 static int add_root_backref(struct rb_root *root_lookup, u64 root_id,
 		u64 ref_tree, u64 dir_id, char *name, int name_len)
 {
-	return add_root(root_lookup, root_id, ref_tree, 0, 0, dir_id, name,
-			name_len, 0, 0, 0, NULL, NULL, NULL);
+	struct root_attr tmp = { 0 };
+
+	tmp.root_id = root_id;
+	tmp.ref_tree = ref_tree;
+	tmp.dir_id = dir_id;
+	tmp.name = name;
+	tmp.name_len = name_len;
+
+	return add_root(root_lookup, &tmp);
 }
 
 static void free_root_info(struct rb_node *node)
@@ -832,9 +801,6 @@ static int list_subvol_search(int fd, struct rb_root *root_lookup)
 	int name_len;
 	char *name;
 	u64 dir_id;
-	u64 gen = 0;
-	u64 ogen;
-	u64 flags;
 	int i;
 
 	root_lookup->rb_node = NULL;
@@ -878,39 +844,29 @@ static int list_subvol_search(int fd, struct rb_root *root_lookup)
 			} else if (sh.type == BTRFS_ROOT_ITEM_KEY &&
 				   (sh.objectid >= BTRFS_FIRST_FREE_OBJECTID ||
 				    sh.objectid == BTRFS_FS_TREE_OBJECTID)) {
-				time_t otime;
-				u8 uuid[BTRFS_UUID_SIZE];
-				u8 puuid[BTRFS_UUID_SIZE];
-				u8 ruuid[BTRFS_UUID_SIZE];
+				struct root_attr tmp = { 0 };
 
 				ri = (struct btrfs_root_item *)(args.buf + off);
-				gen = btrfs_root_generation(ri);
-				flags = btrfs_root_flags(ri);
+				tmp.root_id = sh.objectid;
+				tmp.root_offset = sh.offset;
+				tmp.gen = btrfs_root_generation(ri);
+				tmp.flags = btrfs_root_flags(ri);
 				if(sh.len >= sizeof(struct btrfs_root_item)) {
 					/*
 					 * The new full btrfs_root_item with
 					 * timestamp and UUID.
+					 *
+					 * For older v0 root item, those info is
+					 * not in root_item, and would remain 0.
 					 */
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
+					tmp.otime = btrfs_stack_timespec_sec(&ri->otime);
+					tmp.ogen = btrfs_root_otransid(ri);
+					memcpy(tmp.uuid, ri->uuid, BTRFS_UUID_SIZE);
+					memcpy(tmp.puuid, ri->parent_uuid, BTRFS_UUID_SIZE);
+					memcpy(tmp.ruuid, ri->received_uuid, BTRFS_UUID_SIZE);
 				}
 
-				add_root(root_lookup, sh.objectid, 0,
-					 sh.offset, flags, 0, NULL, 0, ogen,
-					 gen, otime, uuid, puuid, ruuid);
+				add_root(root_lookup, &tmp);
 			}
 
 			off += sh.len;
-- 
2.42.1


