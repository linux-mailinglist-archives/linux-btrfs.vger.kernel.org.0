Return-Path: <linux-btrfs+bounces-14164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82887ABF07A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 11:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81E03BDBCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3991259CAC;
	Wed, 21 May 2025 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XJmuziuV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rkfaas/4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4674259C8B
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821115; cv=none; b=FXSqsRriWd2n0Cad1cB8EWdOlu2UiscR2MOi53gXDeW71RTue2XPKf1gjcUxo4a25MTS64CmvhSojM3gpHCnUYXcz/8z2J/DkbZWfC7+0U4QLGj25lZnOyX62/kji0mbFII+7F+K5lXFqMfHTMC6YusLyQEQQZ9fN+KOVppeiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821115; c=relaxed/simple;
	bh=NVzTfb+b2M3ulDGqZ+veO/C2wnIxYYvjhxFGOeMxwB0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWdQIUUswTE/J2Oay16BWVZiBpjsisqTaAFf1k686DyL2MrSXM+9FPpweKkS7duv0gcG/2lKxj0MQNvf2MytIua+ZoJ+2+vGWxcUqgsKNl2bVzSEkyv1uDxfptU0MWRWRd9+ixgCQ9+/U2rrUgia0DCXFceMEaTsp4UhlPRvaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XJmuziuV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rkfaas/4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA6B7208F4
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YL7ZRMu5ceClfy+BJEG4SLsz2ZL/NF+wkmXdZ+DzVY=;
	b=XJmuziuVTP04vajA2+opGgFTB2UD2CpLj+mqk1Z9EYJRE/DUfsln/FjdGWXQxqzyaYnS7w
	yiwtp8iXIp1lKAQ4/7iSs1Ujk211uiybNcG4LxTrjtZyjhlVXu0dV0et28hsqXFb7OWeYX
	jU9Viq1LdSLSD5W9yQ7Tj2qVBcNxfK8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="rkfaas/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YL7ZRMu5ceClfy+BJEG4SLsz2ZL/NF+wkmXdZ+DzVY=;
	b=rkfaas/4mSG336rg6POCKYf+UtTEzQxMQZCc0WSmVnQsa622qbEmCTURl6o6GhPj9c0En+
	lad1pfdoKXUQA2WgjGwO2cwknJHfY9VraZc4G8cMHieulDzgn6yMyo98ZYORBL4v3cQ2oj
	EI6eYm3XvoIMGN/nyO2Ubf4eumZtxfo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3686713888
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0GPcOiOiLWgBRgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: mkfs: add --inode-flags option
Date: Wed, 21 May 2025 19:21:09 +0930
Message-ID: <4c45c113cac452569e5854d77b4ef160c28a35ae.1747820747.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747820747.git.wqu@suse.com>
References: <cover.1747820747.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EA6B7208F4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.com:dkim]

This new option allows end users to specify certain per-inode flags for
specified file/directory inside rootdir.

And mkfs will follow the kernel behavior by inheriting the inode flag
from the parent.

For example:

 rootdir
 |- file1
 |- file2
 |- dir1/
 |  |- file3
 |- subv/     << will be created as a subvolume using --subvol option
    |- dir2/
    |  |- file4
    |- file5

When `mkfs.btrfs --rootdir rootdir --subvol subv --inode-flags
nodatacow:dir1 --inode-flags nodatacow:subv", then the following files
and directory will have *nodatacow* flag set:

- dir1
- file3
- subv
- dir2
- file4
- file5

For now only two flags are supported:

- nodatacow
  Disable data COW, implies *nodatasum* for regular files

- nodatasum
  Disable data checksum only.

This also works with --compress option, and files with nodatasum or
nodatacow flag will skip compression.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/mkfs.btrfs.rst |  35 ++++++++++
 mkfs/main.c                  | 120 ++++++++++++++++++++++++++++++++++-
 mkfs/rootdir.c               |  78 +++++++++++++++++++++--
 mkfs/rootdir.h               |  15 +++++
 4 files changed, 243 insertions(+), 5 deletions(-)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index 119e18b47541..e9458f70350e 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -213,6 +213,41 @@ OPTIONS
         :file:`hardlink1` and :file:`hardlink2` because :file:`hardlink3` will
         be inside a new subvolume.
 
+--inode-flags <flags>:<path>
+	Specify that *path* to have inode *flags*, other than the default one (which
+	implies data CoW and data checksum).  The option *--rootdir* must also be
+	specified.  This option can be speicified multiple times.
+
+	The supported flag(s) are:
+
+	* *nodatacow*: disable data CoW, implies *nodatasum* for regular files.
+	* *nodatasum*: disable data checksum only.
+
+	*flags* can be separated by comma (',').
+
+	Children inodes will inherit the flags from their parent inodes, like the
+	following case:
+
+        .. code-block:: none
+
+		rootdir/
+		|- file1
+		|- file2
+		|- dir/
+		   |- file3
+
+	In that case, if *--inode-flags nodatacow:dir* is specified, both
+	:file:`dir` and :file:`file3` will have the *nodatacow* flag.
+
+	And this option also works with *--subvol* option, but the inode flag of
+	each subvolume is independent and will not inherit from the parent directory.
+	(The same as the kernel behavior)
+
+        .. note::
+                Both *--inode-flags* and *--subvol* options are memory hungry,
+		will consume at least 8KiB for each option.
+		Please keep the usage of both options to minimal.
+
 --shrink
         Shrink the filesystem to its minimal size, only works with *--rootdir* option.
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 4c2ce98c784c..872f6872de77 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1164,6 +1164,63 @@ static int parse_subvolume(const char *path, struct list_head *subvols,
 	return 0;
 }
 
+static int parse_inode_flags(const char *option, struct list_head *inode_flags_list)
+{
+	struct rootdir_inode_flags_entry *entry = NULL;
+	char *colon;
+	char *dumpped = NULL;
+	char *token;
+	int ret;
+
+	dumpped = strdup(option);
+	if (!dumpped) {
+		ret = -ENOMEM;
+		error_msg(ERROR_MSG_MEMORY, NULL);
+		goto cleanup;
+	}
+	entry = calloc(1, sizeof(*entry));
+	if (!entry) {
+		ret = -ENOMEM;
+		error_msg(ERROR_MSG_MEMORY, NULL);
+		goto cleanup;
+	}
+	colon = strstr(dumpped, ":");
+	if (!colon) {
+		error("invalid option: %s", option);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	*colon = '\0';
+
+	token = strtok(dumpped, ",");
+	while (token) {
+		if (token == NULL)
+			break;
+		if (strcmp(token, "nodatacow") == 0) {
+			entry->nodatacow = true;
+		} else if (strcmp(token, "nodatasum") == 0) {
+			entry->nodatasum = true;
+		} else {
+			error("unknown flag: %s", token);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		token = strtok(NULL, ",");
+	}
+
+	if (arg_copy_path(entry->inode_path, colon + 1, sizeof(entry->inode_path))) {
+		error("--inode-flags path too long");
+		ret = -E2BIG;
+		goto cleanup;
+	}
+	list_add_tail(&entry->list, inode_flags_list);
+	return 0;
+cleanup:
+	free(dumpped);
+	free(entry);
+	return ret;
+}
+
 int BOX_MAIN(mkfs)(int argc, char **argv)
 {
 	char *file;
@@ -1206,10 +1263,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
 	char *source_dir = NULL;
 	struct rootdir_subvol *rds;
+	struct rootdir_inode_flags_entry *rif;
 	bool has_default_subvol = false;
 	enum btrfs_compression_type compression = BTRFS_COMPRESS_NONE;
 	unsigned int compression_level = 0;
 	LIST_HEAD(subvols);
+	LIST_HEAD(inode_flags_list);
 
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1223,6 +1282,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			GETOPT_VAL_CHECKSUM,
 			GETOPT_VAL_GLOBAL_ROOTS,
 			GETOPT_VAL_DEVICE_UUID,
+			GETOPT_VAL_INODE_FLAGS,
 			GETOPT_VAL_COMPRESS,
 		};
 		static const struct option long_options[] = {
@@ -1241,6 +1301,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "version", no_argument, NULL, 'V' },
 			{ "rootdir", required_argument, NULL, 'r' },
 			{ "subvol", required_argument, NULL, 'u' },
+			{ "inode-flags", required_argument, NULL, GETOPT_VAL_INODE_FLAGS },
 			{ "nodiscard", no_argument, NULL, 'K' },
 			{ "features", required_argument, NULL, 'O' },
 			{ "runtime-features", required_argument, NULL, 'R' },
@@ -1374,6 +1435,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case 'q':
 				bconf_be_quiet();
 				break;
+			case GETOPT_VAL_INODE_FLAGS:
+				ret = parse_inode_flags(optarg, &inode_flags_list);
+				if (ret)
+					goto error;
+				break;
 			case GETOPT_VAL_COMPRESS:
 				if (parse_compression(optarg, &compression, &compression_level)) {
 					ret = 1;
@@ -1438,6 +1504,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		ret = 1;
 		goto error;
 	}
+	if (!list_empty(&inode_flags_list) && source_dir == NULL) {
+		error("option --inode-flags must be used with --rootdir");
+		ret = 1;
+		goto error;
+	}
 
 	if (source_dir) {
 		char *canonical = realpath(source_dir, NULL);
@@ -1503,6 +1574,41 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
+	list_for_each_entry(rif, &inode_flags_list, list) {
+		char path[PATH_MAX];
+		struct rootdir_inode_flags_entry *rif2;
+
+		if (path_cat_out(path, source_dir, rif->inode_path)) {
+			ret = -EINVAL;
+			error("path invalid: %s", path);
+			goto error;
+		}
+		if (!realpath(path, rif->full_path)) {
+			ret = -errno;
+			error("could not get canonical path: %s: %m", path);
+			goto error;
+		}
+		if (!path_exists(rif->full_path)) {
+			ret = -ENOENT;
+			error("inode path does not exist: %s", rif->full_path);
+			goto error;
+		}
+		list_for_each_entry(rif2, &inode_flags_list, list) {
+			/*
+			 * Only compare entryies before us. So we won't compare
+			 * the same pair twice.
+			 */
+			if (rif2 == rif)
+				break;
+			if (strcmp(rif2->full_path, rif->full_path) == 0) {
+				error("duplicated inode flag entries for %s",
+					rif->full_path);
+				ret = -EEXIST;
+				goto error;
+			}
+		}
+	}
+
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
 
@@ -2084,9 +2190,15 @@ raid_groups:
 				   rds->is_default ? "" : " ",
 				   rds->dir);
 		}
+		list_for_each_entry(rif, &inode_flags_list, list) {
+			pr_verbose(LOG_DEFAULT, "  Inode flags (%s):  %s\n",
+				   rif->nodatacow ? "NODATACOW" : "",
+				   rif->inode_path);
+		}
 
 		ret = btrfs_mkfs_fill_dir(trans, source_dir, root,
-					  &subvols, compression,
+					  &subvols, &inode_flags_list,
+					  compression,
 					  compression_level);
 		if (ret) {
 			errno = -ret;
@@ -2229,6 +2341,12 @@ error:
 		list_del(&head->list);
 		free(head);
 	}
+	while (!list_empty(&inode_flags_list)) {
+		rif = list_entry(inode_flags_list.next,
+				 struct rootdir_inode_flags_entry, list);
+		list_del(&rif->list);
+		free(rif);
+	}
 
 	return !!ret;
 
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index eafad426295c..e9af72d3bf23 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -153,6 +153,7 @@ static struct rootdir_path current_path = {
 
 static struct btrfs_trans_handle *g_trans = NULL;
 static struct list_head *g_subvols;
+static struct list_head *g_inode_flags_list;
 static u64 next_subvol_id = BTRFS_FIRST_FREE_OBJECTID;
 static u64 default_subvol_id;
 static enum btrfs_compression_type g_compression;
@@ -1296,6 +1297,40 @@ static u8 ftype_to_btrfs_type(mode_t ftype)
 	return BTRFS_FT_UNKNOWN;
 }
 
+static void update_inode_flags(const struct rootdir_inode_flags_entry *rif,
+			       struct btrfs_inode_item *stack_inode)
+{
+	u64 inode_flags;
+
+	inode_flags = btrfs_stack_inode_flags(stack_inode);
+	if (rif->nodatacow) {
+		inode_flags |= BTRFS_INODE_NODATACOW;
+
+		if (S_ISREG(btrfs_stack_inode_mode(stack_inode)))
+			inode_flags |= BTRFS_INODE_NODATASUM;
+	}
+	if (rif->nodatasum)
+		inode_flags |= BTRFS_INODE_NODATASUM;
+
+	btrfs_set_stack_inode_flags(stack_inode, inode_flags);
+}
+
+static void search_and_update_inode_flags(struct btrfs_inode_item *stack_inode,
+					 const char *full_path)
+{
+	struct rootdir_inode_flags_entry *rif;
+
+	list_for_each_entry(rif, g_inode_flags_list, list) {
+		if (strcmp(rif->full_path, full_path) == 0) {
+			update_inode_flags(rif, stack_inode);
+
+			list_del(&rif->list);
+			free(rif);
+			return;
+		}
+	}
+}
+
 static int ftw_add_subvol(const char *full_path, const struct stat *st,
 			  int typeflag, struct FTW *ftwbuf,
 			  struct rootdir_subvol *subvol)
@@ -1354,6 +1389,7 @@ static int ftw_add_subvol(const char *full_path, const struct stat *st,
 	}
 	stat_to_inode_item(&inode_item, st);
 
+	search_and_update_inode_flags(&inode_item, full_path);
 	btrfs_set_stack_inode_nlink(&inode_item, 1);
 	ret = update_inode_item(g_trans, new_root, &inode_item, ino);
 	if (ret < 0) {
@@ -1373,6 +1409,31 @@ static int ftw_add_subvol(const char *full_path, const struct stat *st,
 	return 0;
 }
 
+static int read_inode_item(struct btrfs_root *root, struct btrfs_inode_item *inode_item,
+			   u64 ino)
+{
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = ino;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
+
+	read_extent_buffer(path.nodes[0], inode_item,
+			   btrfs_item_ptr_offset(path.nodes[0], path.slots[0]),
+			   sizeof(*inode_item));
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 static int ftw_add_inode(const char *full_path, const struct stat *st,
 			 int typeflag, struct FTW *ftwbuf)
 {
@@ -1520,6 +1581,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 		return ret;
 	}
 	stat_to_inode_item(&inode_item, st);
+	search_and_update_inode_flags(&inode_item, full_path);
 
 	ret = btrfs_insert_inode(g_trans, root, ino, &inode_item);
 	if (ret < 0) {
@@ -1552,11 +1614,17 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 	}
 
 	/*
-	 * btrfs_add_link() has increased the nlink to 1 in the metadata.
-	 * Also update the value in case we need to update the inode item
-	 * later.
+	 * btrfs_add_link() has increased the nlink, and may even updated the
+	 * inode flags (inheritted from the parent).
+	 * Read out the latest version of inode item.
 	 */
-	btrfs_set_stack_inode_nlink(&inode_item, 1);
+	ret = read_inode_item(root, &inode_item, ino);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to read inode item for subvol %llu inode %llu ('%s'): %m",
+			btrfs_root_id(root), ino, full_path);
+		return ret;
+	}
 
 	ret = add_xattr_item(g_trans, root, ino, full_path);
 	if (ret < 0) {
@@ -1649,6 +1717,7 @@ static int set_default_subvolume(struct btrfs_trans_handle *trans)
 
 int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir,
 			struct btrfs_root *root, struct list_head *subvols,
+			struct list_head *inode_flags_list,
 			enum btrfs_compression_type compression,
 			unsigned int compression_level)
 {
@@ -1695,6 +1764,7 @@ int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir
 
 	g_trans = trans;
 	g_subvols = subvols;
+	g_inode_flags_list = inode_flags_list;
 	g_compression = compression;
 	g_compression_level = compression_level;
 	INIT_LIST_HEAD(&current_path.inode_list);
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index b32fda5bfda8..f8b959f7a7c8 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -45,8 +45,23 @@ struct rootdir_subvol {
 	bool readonly;
 };
 
+/*
+ * Represent a flag for specified inode at @full_path.
+ */
+struct rootdir_inode_flags_entry {
+	struct list_head list;
+	/* Fully canonicalized path to the source file. */
+	char full_path[PATH_MAX];
+	/* Path inside the source directory. */
+	char inode_path[PATH_MAX];
+
+	bool nodatacow;
+	bool nodatasum;
+};
+
 int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir,
 			struct btrfs_root *root, struct list_head *subvols,
+			struct list_head *inode_flags_list,
 			enum btrfs_compression_type compression,
 			unsigned int compression_level);
 u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
-- 
2.49.0


