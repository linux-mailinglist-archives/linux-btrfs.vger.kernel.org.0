Return-Path: <linux-btrfs+bounces-7962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D169764BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 10:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EA01F246C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752D919049A;
	Thu, 12 Sep 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dJkkY1fu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dJkkY1fu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EDA18C915
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130384; cv=none; b=R1dl7Bu3sbaugz1DUcZelcJuaGPZ5IMSWfqeO99prwZkbeFAzjgpgLVk/OfuWpnz/iW3j2gUdSs9wdLfg0b8t+Wr+fAkHX228Q8IRAWOKz1swrGWja0PeighZ/5EhtIBCwVznsmwLtXgQYetL/jU2SbMJ6fp4FuG9nz8J5klzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130384; c=relaxed/simple;
	bh=ygdjnYt68hNNebHAGLdCcima0M8VumHdMqbWuBOnbpY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCfpqZ/ylDqAg4IPd7u8Y9Ek+LaiFoQB7fEUHhfGrwdUs1hhugZhC//BFAfsj9TnW/lEvTtMbVHiQMD6aR0E3VOJxiLUQBfbL700jIM/42SN8jCf2ewwpgY4WpBg37kHjrsR8rPxJn4Wl+/azIzLbbHDGmbeY/7UeR/qzL0jbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dJkkY1fu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dJkkY1fu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25EBA21AE9
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726130380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgLogpLrNmuiXcQ29TTOfdQCSjv9Q3EmHUUOxTRjeC4=;
	b=dJkkY1fu/tQlFLzZtdH8DTx8tgz3IB1/E+atO4vnIoxlOyrtS/oWGi1opfkX31tj2FX05O
	NptR/duN3jlFDjyQM7tPvXiKuFitdiczsk5lq+g1CR4H8Lz8PhVzW9v0nWGOFfJnUoIdgQ
	sYk5emn9jePP1fGUbWFXWm5Xdxko6nY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dJkkY1fu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726130380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgLogpLrNmuiXcQ29TTOfdQCSjv9Q3EmHUUOxTRjeC4=;
	b=dJkkY1fu/tQlFLzZtdH8DTx8tgz3IB1/E+atO4vnIoxlOyrtS/oWGi1opfkX31tj2FX05O
	NptR/duN3jlFDjyQM7tPvXiKuFitdiczsk5lq+g1CR4H8Lz8PhVzW9v0nWGOFfJnUoIdgQ
	sYk5emn9jePP1fGUbWFXWm5Xdxko6nY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6644313AD8
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SNzBCsuo4ma5EQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: check: detect deprecated inode cache
Date: Thu, 12 Sep 2024 18:09:19 +0930
Message-ID: <47f4b6fc31667eb3d8edc5a1a14ccb3e9f746317.1726130115.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726130115.git.wqu@suse.com>
References: <cover.1726130115.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25EBA21AE9
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

[BUG]
There are reports about deprecated inode cache causing newer kernels to
rejecting them.

Such inode cache is rarely utilized and already fully deprecated since
v5.11, and newer kernel will reject data extents of inode cache since
v6.11.

But original mode btrfs check won't detect nor report them as error.
Meanwhile lowmem mode can properly detect and report them:

 ERROR: root 5 INODE[18446744073709551604] nlink(1) not equal to inode_refs(0)
 ERROR: invalid imode mode bits: 00
 ERROR: invalid inode generation 18446744073709551604 or transid 1 for ino 18446744073709551605, expect [0, 72)
 ERROR: root 5 INODE[18446744073709551605] is orphan item

Since those inode cache paid no attention to properly maintain all the
numbers, they are easy targets for more recent lowmem mode.

[CAUSE]
For original mode, it has extra hardcoded hacks to avoid nlink checks
for inode cache inode.
Furthermore original mode doesn't check the mode bits nor its
generation.

[FIX]
For original mode, remove the hack for inode cache so that the
deprecated inode cache can be reported as an error.

For both modes, add extra global message to direct the affected users to
use 'btrfs rescue clear-ino-cache' to clear the deprecated cache.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          | 12 +++++++++---
 check/mode-lowmem.c   |  9 +++++++++
 check/mode-original.h |  1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index d4108b7315e0..4f5bce15521e 100644
--- a/check/main.c
+++ b/check/main.c
@@ -86,6 +86,7 @@ bool no_holes = false;
 bool is_free_space_tree = false;
 bool init_extent_tree = false;
 bool check_data_csum = false;
+static bool found_free_ino_cache = false;
 struct cache_tree *roots_info_cache = NULL;
 
 enum btrfs_check_mode {
@@ -606,6 +607,8 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 	fprintf(stderr, "root %llu inode %llu errors %x",
 		root_objectid, rec->ino, rec->errors);
 
+	if (errors & I_ERR_DEPRECATED_FREE_INO)
+		fprintf(stderr, ", deprecated free inode cache");
 	if (errors & I_ERR_NO_INODE_ITEM)
 		fprintf(stderr, ", no inode item");
 	if (errors & I_ERR_NO_ORPHAN_ITEM)
@@ -773,9 +776,6 @@ static struct inode_record *get_inode_rec(struct cache_tree *inode_cache,
 		node->cache.size = 1;
 		node->data = rec;
 
-		if (ino == BTRFS_FREE_INO_OBJECTID)
-			rec->found_link = 1;
-
 		ret = insert_cache_extent(inode_cache, &node->cache);
 		if (ret) {
 			free(rec);
@@ -3224,6 +3224,10 @@ static int check_inode_recs(struct btrfs_root *root,
 			}
 		}
 
+		if (rec->ino == BTRFS_FREE_INO_OBJECTID) {
+			rec->errors |= I_ERR_DEPRECATED_FREE_INO;
+			found_free_ino_cache = true;
+		}
 		if (!rec->found_inode_item)
 			rec->errors |= I_ERR_NO_INODE_ITEM;
 		if (rec->found_link != rec->nlink)
@@ -10834,6 +10838,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 
 	ret = do_check_fs_roots(&root_cache);
 	task_stop(g_task_ctx.info);
+	if (found_free_ino_cache)
+		printf("deprecated inode cache can be removed by 'btrfs rescue clear-ino-cache'\n");
 	err |= !!ret;
 	if (ret) {
 		error("errors found in fs roots");
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 4b6faccacbbc..4eb0b5b64223 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -44,6 +44,7 @@
 
 static u64 last_allocated_chunk;
 static u64 total_used = 0;
+static bool found_free_ino_cache = false;
 
 static int calc_extent_flag(struct btrfs_root *root, struct extent_buffer *eb,
 			    u64 *flags_ret)
@@ -2629,6 +2630,12 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 		return err;
 	}
 
+	if (inode_id == BTRFS_FREE_INO_OBJECTID) {
+		error("subvolume %lld has deprecated inode cache",
+			root->root_key.objectid);
+		found_free_ino_cache = true;
+	}
+
 	is_orphan = has_orphan_item(root, inode_id);
 	ii = btrfs_item_ptr(node, slot, struct btrfs_inode_item);
 	isize = btrfs_inode_size(node, ii);
@@ -5616,6 +5623,8 @@ next:
 
 out:
 	btrfs_release_path(&path);
+	if (found_free_ino_cache)
+		printf("deprecated inode cache can be removed by 'btrfs rescue clear-ino-cache'\n");
 	return err;
 }
 
diff --git a/check/mode-original.h b/check/mode-original.h
index ac8de57cc5d4..949d75513f9b 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -189,6 +189,7 @@ struct unaligned_extent_rec_t {
 #define I_ERR_INVALID_GEN		(1U << 20)
 #define I_ERR_INVALID_NLINK		(1U << 21)
 #define I_ERR_INVALID_XATTR		(1U << 22)
+#define I_ERR_DEPRECATED_FREE_INO	(1U << 23)
 
 struct inode_record {
 	struct list_head backrefs;
-- 
2.46.0


