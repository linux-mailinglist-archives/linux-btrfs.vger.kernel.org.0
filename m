Return-Path: <linux-btrfs+bounces-16116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E37B295D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 02:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D2B1761FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 00:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D45B202987;
	Mon, 18 Aug 2025 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HPCvcMts";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HPCvcMts"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE481E2606
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755477140; cv=none; b=TQ4yY3eJXcxKsZp79KBbswNTAMiN/OPvwG1f9OYCEkIZ3BuCY61019NSvBpQpP15D/sSd5iK7DSSpUosuTvzn3LOL/OuD4D+Uk1w1dvTW7XV8zzqMM9qkXlNHIHkndHa2L+FZ3Lhh40AQYP4Poqar1Fd45E9bfeRtzjBNP/R+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755477140; c=relaxed/simple;
	bh=3QzgyNg3/ItQrCtZDvQC1qSqylR3teX/j2ewlMwxlgo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMI0HUJwOixf9snVkhQUMosq3p2EfEpCx6LH9lrmxGKrFQv4k6YV3//hPXateUwSNCisF9AGjBeB4Jw7mfuGzyU9J1OTIab/x8B6tdI/BAszQxFu+d+Jp7D2QSgDTIUo06GLEiBFc44hqHT6Fw2pdKfZUNeqUFHv1ADrhkU+eTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HPCvcMts; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HPCvcMts; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 065EC1F45F
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+9eCcXMxdH6FWPFX1rbG/39fFFuR2buU1K9VojpeEI=;
	b=HPCvcMtsfXykAAG/OxFPeaNOY6GoVezlB2QLPvxrvT8hP1qIUNkOnX5jEZX8NOAs8ceXio
	CTncLvpWwb2U5GwlVsnoD0AiklTqXDAjizngF5tG4cvli9mlfig0DO88tvTeOBHNPcqeuu
	mu5fr+9/I7jmqnMACiM7JtcM4WVke5g=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+9eCcXMxdH6FWPFX1rbG/39fFFuR2buU1K9VojpeEI=;
	b=HPCvcMtsfXykAAG/OxFPeaNOY6GoVezlB2QLPvxrvT8hP1qIUNkOnX5jEZX8NOAs8ceXio
	CTncLvpWwb2U5GwlVsnoD0AiklTqXDAjizngF5tG4cvli9mlfig0DO88tvTeOBHNPcqeuu
	mu5fr+9/I7jmqnMACiM7JtcM4WVke5g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41A0513686
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OD55AYp0omhWKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs-progs: mkfs/rootdir: enhance inode flags detection
Date: Mon, 18 Aug 2025 10:01:46 +0930
Message-ID: <bca072c44beddb9a61c0b57f12fc25656ba2e2dc.1755474438.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Currently for --inode-flags parameter, we save the full path of the host
fs into rootdir_inode_flags_entry sturcture, then compare each inode we hit
with that saved full path.

This string comparison can be time consuming (up to PATH_MAX
characters), and we're doing it for every inode.

On the other hand, nftw() also provides a stat structure of the current
inode, stat::st_dev and stat::st_ino pair can always uniquely locate an
inode in the host filesystem.

With that said, we can just save the st_dev/st_ino pair when validating
the inode flag parameters, and use st_dev/st_ino to check if we hit the
target inode.

This has two benefits:

- Reduce the memory usage of each rootdir_inode_flags_entry
  Now we need no full_path member, replacing it with two u64.
  This saves (4K - 16) bytes per rootdir_inode_flags_entry.

- Reduce the runtime of inode comparison
  Instead of doing strcmp() for up to 4K bytes, it's just two u64
  comparison.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/rootdir.c | 28 +++++++++++++++++++---------
 mkfs/rootdir.h |  7 ++++---
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 90a79441fd80..4eb5ea142eba 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -1139,22 +1139,32 @@ int btrfs_mkfs_validate_inode_flags(const char *source_dir, struct list_head *in
 
 	list_for_each_entry(rif, inode_flags, list) {
 		char path[PATH_MAX];
+		char full_path[PATH_MAX];
 		struct rootdir_inode_flags_entry *rif2;
+		struct stat stbuf;
 		int ret;
 
 		if (path_cat_out(path, source_dir, rif->inode_path)) {
 			error("path invalid: %s", path);
 			return -EINTR;
 		}
-		if (!realpath(path, rif->full_path)) {
+		if (!realpath(path, full_path)) {
 			ret = -errno;
 			error("could not get canonical path: %s: %m", path);
 			return ret;
 		}
-		if (!path_exists(rif->full_path)) {
-			error("inode path does not exist: %s", rif->full_path);
+		if (!path_exists(full_path)) {
+			error("inode path does not exist: %s", full_path);
 			return -ENOENT;
 		}
+		ret = lstat(full_path, &stbuf);
+		if (ret < 0) {
+			ret = -errno;
+			error("failed to get stat of '%s': %m", full_path);
+			return ret;
+		}
+		rif->st_dev = stbuf.st_dev;
+		rif->st_ino = stbuf.st_ino;
 		list_for_each_entry(rif2, inode_flags, list) {
 			/*
 			 * Only compare entries before us. So we won't compare
@@ -1162,9 +1172,9 @@ int btrfs_mkfs_validate_inode_flags(const char *source_dir, struct list_head *in
 			 */
 			if (rif2 == rif)
 				break;
-			if (strcmp(rif2->full_path, rif->full_path) == 0) {
+			if (rif2->st_dev == rif->st_dev && rif2->st_ino == rif->st_ino) {
 				error("duplicated inode flag entries for %s",
-					rif->full_path);
+					full_path);
 				return -EEXIST;
 			}
 		}
@@ -1410,12 +1420,12 @@ static void update_inode_flags(const struct rootdir_inode_flags_entry *rif,
 }
 
 static void search_and_update_inode_flags(struct btrfs_inode_item *stack_inode,
-					  const char *full_path)
+					  const struct stat *st)
 {
 	struct rootdir_inode_flags_entry *rif;
 
 	list_for_each_entry(rif, g_inode_flags_list, list) {
-		if (strcmp(rif->full_path, full_path) == 0) {
+		if (rif->st_dev == st->st_dev && rif->st_ino == st->st_ino) {
 			update_inode_flags(rif, stack_inode);
 
 			list_del(&rif->list);
@@ -1493,7 +1503,7 @@ static int ftw_add_subvol(const char *full_path, const struct stat *st,
 	}
 	stat_to_inode_item(&inode_item, st);
 
-	search_and_update_inode_flags(&inode_item, full_path);
+	search_and_update_inode_flags(&inode_item, st);
 	btrfs_set_stack_inode_nlink(&inode_item, 1);
 	ret = update_inode_item(g_trans, new_root, &inode_item, ino);
 	if (ret < 0) {
@@ -1687,7 +1697,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 		return ret;
 	}
 	stat_to_inode_item(&inode_item, st);
-	search_and_update_inode_flags(&inode_item, full_path);
+	search_and_update_inode_flags(&inode_item, st);
 
 	ret = btrfs_insert_inode(g_trans, root, ino, &inode_item);
 	if (ret < 0) {
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index 927a0fa7ed69..87bfd4bd2a52 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -49,14 +49,15 @@ struct rootdir_subvol {
 };
 
 /*
- * Represent a flag for specified inode at @full_path.
+ * Represent a flag for specified inode at "$source_dir/$inode_path".
  */
 struct rootdir_inode_flags_entry {
 	struct list_head list;
-	/* Fully canonicalized path to the source file. */
-	char full_path[PATH_MAX];
 	/* Path inside the source directory. */
 	char inode_path[PATH_MAX];
+	/* st_dev and st_ino is going to uniquely determine an inode inside the host fs. */
+	dev_t st_dev;
+	ino_t st_ino;
 
 	bool nodatacow;
 	bool nodatasum;
-- 
2.50.1


