Return-Path: <linux-btrfs+bounces-16120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E0B295D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 02:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F283BEE76
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 00:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8651DFCE;
	Mon, 18 Aug 2025 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eDZo5yFy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eDZo5yFy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D36166F1A
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755477156; cv=none; b=dRbBmSJg8vpjs3NhDXZ3PBmwoHsMW+8MC3u6DwZ/ThA36WbyTPvwVULDbHUfErfy8jtYP1oPC50SZdOc0Kf5bongew6a4oZj0xJoeKzyaNwFBmbnhCqvSOLzOgOQKZSLchKxfgCm/ryassFGc9c/yHRd1jwjMmYwTtnCmmyVPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755477156; c=relaxed/simple;
	bh=6XFxqE9NNVmPjoJiNXXR+kpsaaX5msouA1O2/gwrYF4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFpQUbl0OBzIVNNOZMnvaXGr5wEI/6VP6HsKPOwl7RkhHNj4EN0Sx4RL5xKSHE53dXP9foDQbsHPLwI4u19qLbtzrFhjz0flDyVDpOlIpX3aPHx/8V+1WkNqxWm4ytMmat6EPBRUFp0nVdm/BtyQvSXuzBpHwvw/di5EwT+Qre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eDZo5yFy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eDZo5yFy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCACE218FF
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKHui6XICG8BeGBrK4NgxZtJoOnKuX2b8wbSxzopTW0=;
	b=eDZo5yFyCYVBlp1l1DJn/cztukL5Ktna5lpC2kJTRDdnd8WSAxX30V3XXupaPNruePGF8h
	1T5o4IF/RBYeOAmXsJHTDdVO5/gHzLYs3ZSRcTmgpWVttvlHV583ZzYlE4rRHrKD/bHQup
	7b/jHyw78PMGWoq3qSdGw5DjdRB88NU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eDZo5yFy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKHui6XICG8BeGBrK4NgxZtJoOnKuX2b8wbSxzopTW0=;
	b=eDZo5yFyCYVBlp1l1DJn/cztukL5Ktna5lpC2kJTRDdnd8WSAxX30V3XXupaPNruePGF8h
	1T5o4IF/RBYeOAmXsJHTDdVO5/gHzLYs3ZSRcTmgpWVttvlHV583ZzYlE4rRHrKD/bHQup
	7b/jHyw78PMGWoq3qSdGw5DjdRB88NU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04CA613686
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OJlBLoh0omhWKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs-progs: mkfs/rootdir: enhance subvols detection
Date: Mon, 18 Aug 2025 10:01:45 +0930
Message-ID: <4c5b7956de6ccf5368bb0efb295c4405e0857921.1755474438.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755474438.git.wqu@suse.com>
References: <cover.1755474438.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BCACE218FF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

Currently for --subvol parameter, we save the full path of the host fs
into rootdir_subvol sturcture, then compare each inode we hit with that
saved full path.

This string comparison can be time consuming (up to PATH_MAX
characters), and we're doing it for every directory inode.

On the other hand, nftw() also provides a stat structure of the current
inode, stat::st_dev and stat::st_ino pair can always uniquely locate an
inode in the host filesystem.

With that said, we can just save the st_dev/st_ino pair when validating
the subvol parameters, and use st_dev/st_ino to check if we hit the
target subvolume.

This has two benefits:

- Reduce the memory usage of each rootdir_subvol
  Now we need no full_path member, replacing it with two u64.
  This saves (4K - 16) bytes per rootdir_subvol.

- Reduce the runtime of direct inode comparison
  Instead of doing strcmp() for up to 4K bytes, it's just two u64
  comparison.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/rootdir.c | 52 +++++++++++++++++++++++++++++++++++---------------
 mkfs/rootdir.h |  4 +++-
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 1fc050f3ab1b..90a79441fd80 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -1083,6 +1083,8 @@ int btrfs_mkfs_validate_subvols(const char *source_dir, struct list_head *subvol
 
 	list_for_each_entry(rds, subvols, list) {
 		char path[PATH_MAX];
+		char full_path[PATH_MAX];
+		struct stat stbuf;
 		struct rootdir_subvol *rds2;
 		int ret;
 
@@ -1092,21 +1094,29 @@ int btrfs_mkfs_validate_subvols(const char *source_dir, struct list_head *subvol
 			error("path invalid '%s': %m", path);
 			return ret;
 		}
-		if (!realpath(path, rds->full_path)) {
+		if (!realpath(path, full_path)) {
 			ret = -errno;
 			error("could not get canonical path of '%s': %m", rds->dir);
 			return ret;
 		}
-		ret = path_exists(rds->full_path);
+		ret = path_exists(full_path);
 		if (ret < 0) {
 			error("subvolume path does not exist: %s", rds->dir);
 			return ret;
 		}
-		ret = path_is_dir(rds->full_path);
+		ret = path_is_dir(full_path);
 		if (ret < 0) {
 			error("subvolume is not a directory: %s", rds->dir);
 			return ret;
 		}
+		ret = lstat(full_path, &stbuf);
+		if (ret < 0) {
+			ret = -errno;
+			error("failed to get stat of '%s': %m", full_path);
+			return ret;
+		}
+		rds->st_dev = stbuf.st_dev;
+		rds->st_ino = stbuf.st_ino;
 		list_for_each_entry(rds2, subvols, list) {
 			/*
 			 * Only compare entries before us, So we won't compare
@@ -1114,7 +1124,7 @@ int btrfs_mkfs_validate_subvols(const char *source_dir, struct list_head *subvol
 			 */
 			if (rds2 == rds)
 				break;
-			if (strcmp(rds2->full_path, rds->full_path) == 0) {
+			if (rds2->st_dev == rds->st_dev && rds2->st_ino == rds->st_ino) {
 				error("subvolume specified more than once: %s", rds->dir);
 				return -EINVAL;
 			}
@@ -1424,15 +1434,26 @@ static int ftw_add_subvol(const char *full_path, const struct stat *st,
 	struct btrfs_root *new_root;
 	struct inode_entry *parent;
 	struct btrfs_inode_item inode_item = { 0 };
+	char *path_dump;
+	char *base_path;
 	u64 subvol_id, ino;
 
 	subvol_id = next_subvol_id++;
+	path_dump = strdup(full_path);
+	if (!path_dump)
+		return -ENOMEM;
+	base_path = path_basename(path_dump);
+	if (!base_path) {
+		ret = -errno;
+		error("failed to get basename of '%s': %m", path_dump);
+		goto out;
+	}
 
 	ret = btrfs_make_subvolume(g_trans, subvol_id, subvol->readonly);
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to create subvolume: %m");
-		return ret;
+		goto out;
 	}
 
 	if (subvol->is_default)
@@ -1447,19 +1468,18 @@ static int ftw_add_subvol(const char *full_path, const struct stat *st,
 		ret = PTR_ERR(new_root);
 		errno = -ret;
 		error("unable to read fs root id %llu: %m", subvol_id);
-		return ret;
+		goto out;
 	}
 
 	parent = rootdir_path_last(&current_path);
 
 	ret = btrfs_link_subvolume(g_trans, parent->root, parent->ino,
-				   path_basename(subvol->full_path),
-				   strlen(path_basename(subvol->full_path)),
+				   base_path, strlen(base_path),
 				   new_root);
 	if (ret) {
 		errno = -ret;
-		error("unable to link subvolume %s: %m", path_basename(subvol->full_path));
-		return ret;
+		error("unable to link subvolume %s: %m", base_path);
+		goto out;
 	}
 
 	ino = btrfs_root_dirid(&new_root->root_item);
@@ -1469,7 +1489,7 @@ static int ftw_add_subvol(const char *full_path, const struct stat *st,
 		errno = -ret;
 		error("failed to add xattr item for the top level inode in subvol %llu: %m",
 		      subvol_id);
-		return ret;
+		goto out;
 	}
 	stat_to_inode_item(&inode_item, st);
 
@@ -1479,7 +1499,7 @@ static int ftw_add_subvol(const char *full_path, const struct stat *st,
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to update root dir for root %llu: %m", subvol_id);
-		return ret;
+		goto out;
 	}
 
 	ret = rootdir_path_push(&current_path, new_root, ino);
@@ -1487,10 +1507,12 @@ static int ftw_add_subvol(const char *full_path, const struct stat *st,
 		errno = -ret;
 		error("failed to allocate new entry for subvolume %llu ('%s'): %m",
 		      subvol_id, full_path);
-		return ret;
+		goto out;
 	}
 
-	return 0;
+out:
+	free(path_dump);
+	return ret;
 }
 
 static int read_inode_item(struct btrfs_root *root, struct btrfs_inode_item *inode_item,
@@ -1611,7 +1633,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 
 	if (S_ISDIR(st->st_mode)) {
 		list_for_each_entry(rds, g_subvols, list) {
-			if (!strcmp(full_path, rds->full_path)) {
+			if (st->st_dev == rds->st_dev && st->st_ino == rds->st_ino) {
 				ret = ftw_add_subvol(full_path, st, typeflag,
 						     ftwbuf, rds);
 
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index cbb83355ee9b..927a0fa7ed69 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -41,7 +41,9 @@ struct rootdir_subvol {
 	struct list_head list;
 	/* The path inside the source_dir. */
 	char dir[PATH_MAX];
-	char full_path[PATH_MAX];
+	/* st_dev and st_ino is going to uniquely determine an inode inside the host fs. */
+	dev_t st_dev;
+	ino_t st_ino;
 	bool is_default;
 	bool readonly;
 };
-- 
2.50.1


