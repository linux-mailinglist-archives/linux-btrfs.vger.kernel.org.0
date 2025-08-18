Return-Path: <linux-btrfs+bounces-16117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89705B295D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 02:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265CC7AE240
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 00:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379EC1E2606;
	Mon, 18 Aug 2025 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lFcQKBRY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lFcQKBRY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB51F2BAB
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755477143; cv=none; b=qffWCtWWON+DngA4b+67GnvsvtYKWGlJUQ1/N4/r7hohOfH5/gVLryvww6naxVQACAQAhVwCxLyY9RvvJTflDfwTYXV61uNCsVlsIHu1Sg+Yt+okojPMDXtelHcsuyPPY1go6XWyem8UlwIPf28I94JBm0AHR87V13uVNZRjFbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755477143; c=relaxed/simple;
	bh=+C8ubo0z42gRfqu7TK0gcZH7mXwdBrpl2a1IqReKCls=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLuwifccUPHlflBc4/+Y9BwlXpihUr8u456z8/7/NIe2tDJ5qEbmT5gB/fvlbHKSNzdiDXnfxNEA2iPq/zrnWc79NI2SMtwVk8vGKhIXqMULE3Bida+PHCvC2MqnHzGYZdBg86lUJUrSQ11qhi5qU858V/GqWk6Sze3fCJMNdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lFcQKBRY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lFcQKBRY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FB4E218FB
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEx9ZNFCArTuBUtv+zwBQbxqy7zF/D05Z/mYcvb6mD4=;
	b=lFcQKBRYEJRpDUi1lYV3WXZj3L6DEWPh/kotSapszuQgvDJvNEsPFrunqUHqH3F4rOENiE
	xqBb4ygzrpf008nIZOjuVW/KhYhqNsmU1nZsjFYTpxB/2rP6641ABfCO5ug49JtJ7+i1ky
	s85e7dC8YR3VIfik/ko4TGa5WgEubaI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lFcQKBRY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEx9ZNFCArTuBUtv+zwBQbxqy7zF/D05Z/mYcvb6mD4=;
	b=lFcQKBRYEJRpDUi1lYV3WXZj3L6DEWPh/kotSapszuQgvDJvNEsPFrunqUHqH3F4rOENiE
	xqBb4ygzrpf008nIZOjuVW/KhYhqNsmU1nZsjFYTpxB/2rP6641ABfCO5ug49JtJ7+i1ky
	s85e7dC8YR3VIfik/ko4TGa5WgEubaI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B53213686
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ULNhE4Z0omhWKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs-progs: mkfs/rootdir: extract subvol validation code into a helper
Date: Mon, 18 Aug 2025 10:01:43 +0930
Message-ID: <b17145d6a4910f6d0788017457a910816f0ccf6f.1755474438.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 4FB4E218FB
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

Currently we do the validation of subvolume parameters inside
mkfs/main.c, but considering all things like structure rootdir_subvol
are all inside rootdir.[ch], it's better to move the validation part
into rootdir.[ch].

Extract the validation part into a helper,
btrfs_mkfs_validate_subvols(), into rootdir.[ch].

Furthermore since we're here, also slightly enhance the duplicated
subvolume check, so that the runtime is halved.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c    | 47 +++--------------------------------------------
 mkfs/rootdir.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 mkfs/rootdir.h |  2 ++
 3 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 546cc74735a9..bde897afd029 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1527,50 +1527,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
-	list_for_each_entry(rds, &subvols, list) {
-		char path[PATH_MAX];
-		struct rootdir_subvol *rds2;
-
-		if (path_cat_out(path, source_dir, rds->dir)) {
-			error("path invalid: %s", path);
-			ret = 1;
-			goto error;
-		}
-
-		if (!realpath(path, rds->full_path)) {
-			error("could not get canonical path: %s", rds->dir);
-			ret = 1;
-			goto error;
-		}
-
-		if (!path_exists(rds->full_path)) {
-			error("subvolume path does not exist: %s", rds->dir);
-			ret = 1;
-			goto error;
-		}
-
-		if (!path_is_dir(rds->full_path)) {
-			error("subvolume is not a directory: %s", rds->dir);
-			ret = 1;
-			goto error;
-		}
-
-		if (!path_is_in_dir(source_dir, rds->full_path)) {
-			error("subvolume %s is not a child of %s", rds->dir, source_dir);
-			ret = 1;
-			goto error;
-		}
-
-		for (rds2 = list_first_entry(&subvols, struct rootdir_subvol, list);
-		     rds2 != rds;
-		     rds2 = list_next_entry(rds2, list)) {
-			if (strcmp(rds2->full_path, rds->full_path) == 0) {
-				error("subvolume specified more than once: %s", rds->dir);
-				ret = 1;
-				goto error;
-			}
-		}
-	}
+	ret = btrfs_mkfs_validate_subvols(source_dir, &subvols);
+	if (ret < 0)
+		goto error;
 
 	list_for_each_entry(rif, &inode_flags_list, list) {
 		char path[PATH_MAX];
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 8d626f104701..e9d5c6bed0c4 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -1077,6 +1077,52 @@ out:
 }
 #endif
 
+int btrfs_mkfs_validate_subvols(const char *source_dir, struct list_head *subvols)
+{
+	struct rootdir_subvol *rds;
+
+	list_for_each_entry(rds, subvols, list) {
+		char path[PATH_MAX];
+		struct rootdir_subvol *rds2;
+		int ret;
+
+		ret = path_cat_out(path, source_dir, rds->dir);
+		if (ret < 0) {
+			errno = -ret;
+			error("path invalid '%s': %m", path);
+			return ret;
+		}
+		if (!realpath(path, rds->full_path)) {
+			ret = -errno;
+			error("could not get canonical path of '%s': %m", rds->dir);
+			return ret;
+		}
+		ret = path_exists(rds->full_path);
+		if (ret < 0) {
+			error("subvolume path does not exist: %s", rds->dir);
+			return ret;
+		}
+		ret = path_is_dir(rds->full_path);
+		if (ret < 0) {
+			error("subvolume is not a directory: %s", rds->dir);
+			return ret;
+		}
+		list_for_each_entry(rds2, subvols, list) {
+			/*
+			 * Only compare entries before us, So we won't compare
+			 * the same pair twice.
+			 */
+			if (rds2 == rds)
+				break;
+			if (strcmp(rds2->full_path, rds->full_path) == 0) {
+				error("subvolume specified more than once: %s", rds->dir);
+				return -EINVAL;
+			}
+		}
+	}
+	return 0;
+}
+
 static int add_file_items(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root,
 			  struct btrfs_inode_item *btrfs_inode, u64 objectid,
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index f8b959f7a7c8..c9761e090984 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -39,6 +39,7 @@ struct btrfs_root;
 
 struct rootdir_subvol {
 	struct list_head list;
+	/* The path inside the source_dir. */
 	char dir[PATH_MAX];
 	char full_path[PATH_MAX];
 	bool is_default;
@@ -59,6 +60,7 @@ struct rootdir_inode_flags_entry {
 	bool nodatasum;
 };
 
+int btrfs_mkfs_validate_subvols(const char *source_dir, struct list_head *subvols);
 int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir,
 			struct btrfs_root *root, struct list_head *subvols,
 			struct list_head *inode_flags_list,
-- 
2.50.1


