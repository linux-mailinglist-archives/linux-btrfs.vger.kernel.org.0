Return-Path: <linux-btrfs+bounces-19330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D213C83F33
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 09:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1DE34E73F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9A32D8390;
	Tue, 25 Nov 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RFDdUA5R";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RFDdUA5R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56127D77D
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058822; cv=none; b=cjXBwbmWfErzaSDPtPuovUZ4X16DhDFE7bzw0sWrveC9e0GZcou3SAVx/wiA6Z2gE4pPIMqgg5pe7G3Eiqh4UavfMyasqIoBk/Xp5jq/M/U9dZJeUnft+wnco3WcuYYaRT7XhYu7lukKyWobECGfh0cxD3c7z+fDOIgpa0NBdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058822; c=relaxed/simple;
	bh=ltCLKsBCMO/Py4xvxNHgm195mUUBZ7ZuhttcLoA98AU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OB+N8+tYOXSgvjpTlAKtKE2RMfWTEZ1KrCFueZ8F4rJIvzRrboszYYoX7Asxxysn3R2L9bTXebR5ua4YQENWj93Nay3oZ9qS8HcQXKr8AdAsFXMNGqqJilLQpl2EL4fSKsrcbP/HuNrivJB7QIf8+K6RVQRa0/IBMXQT8htkvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RFDdUA5R; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RFDdUA5R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A860121C1C
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764058818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22Jq9HNlJWoG4UAsyinO2fQBIqsV4aH+MaXGKDEwArA=;
	b=RFDdUA5RTqH3L0KqDcKMSwiP3t84yGhlpN4ZgUx9Y5LVRhdP7QMkXigdprA+/ZHk8NXid6
	4HsLw9VEjAUiKk5mv0hvVE+DVaR+UaQyp/yqsbyP+p6pa2PjIYWrS80WLP2vGp+bGZrrSk
	D2ELcT5BT0dorN5fV+kXBeTNEZzoxC4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764058818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22Jq9HNlJWoG4UAsyinO2fQBIqsV4aH+MaXGKDEwArA=;
	b=RFDdUA5RTqH3L0KqDcKMSwiP3t84yGhlpN4ZgUx9Y5LVRhdP7QMkXigdprA+/ZHk8NXid6
	4HsLw9VEjAUiKk5mv0hvVE+DVaR+UaQyp/yqsbyP+p6pa2PjIYWrS80WLP2vGp+bGZrrSk
	D2ELcT5BT0dorN5fV+kXBeTNEZzoxC4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8EB63EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WFuaKsFmJWlRfwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper
Date: Tue, 25 Nov 2025 18:49:57 +1030
Message-ID: <f1be8250618a68c9abf1be7f3af416ccfad3784b.1764058736.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764058736.git.wqu@suse.com>
References: <cover.1764058736.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

There are already several bugs with on-stack btrfs_path involved, even
it is already a little safer than btrfs_path pointers (only leaks the
extent buffers, not the btrfs_path structure itself)

- Patch "btrfs: make sure extent and csum paths are always released in
  scrub_raid56_parity_stripe()"
  Which is going into v6.19 release cycle.

- Patch "btrfs: fix a potential path leak in print_datA_reloc_error()"
  The previous patch in the series.

Thus there is a real need to apply auto release for those on-stack paths.

This patch introduces a new macro, BTRFS_PATH_AUTO_RELEASE(), which
defines one on-stack btrfs_path structure, initialize it all to 0, then
call btrfs_release_path() on it when exiting the scope.

This will applies to all 3 on-stack path usages:

- defrag_get_extent() in defrag.c

- print_data_reloc_error() in inode.c

- scrub_radi56_parity_stripe() in scrub.c

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h  |  5 +++++
 fs/btrfs/defrag.c |  5 +----
 fs/btrfs/inode.c  |  6 +-----
 fs/btrfs/scrub.c  | 18 ++++++------------
 4 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 692370fc07b2..4ab27673bd9c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -85,6 +85,10 @@ struct btrfs_path {
 #define BTRFS_PATH_AUTO_FREE(path_name)					\
 	struct btrfs_path *path_name __free(btrfs_free_path) = NULL
 
+/* This defines an on-stack path that will be auto released exiting the scope. */
+#define BTRFS_PATH_AUTO_RELEASE(path_name)					\
+	struct btrfs_path path_name __free(btrfs_release_path) = { 0 }
+
 /*
  * The state of btrfs root
  */
@@ -601,6 +605,7 @@ void btrfs_release_path(struct btrfs_path *p);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
 DEFINE_FREE(btrfs_free_path, struct btrfs_path *, btrfs_free_path(_T))
+DEFINE_FREE(btrfs_release_path, struct btrfs_path, btrfs_release_path(&_T))
 
 int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   struct btrfs_path *path, int slot, int nr);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 2e3c011d410a..02a2e7736da0 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -610,7 +610,7 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_file_extent_item *fi;
-	struct btrfs_path path = { 0 };
+	BTRFS_PATH_AUTO_RELEASE(path);
 	struct extent_map *em;
 	struct btrfs_key key;
 	u64 ino = btrfs_ino(inode);
@@ -721,16 +721,13 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 		if (ret > 0)
 			goto not_found;
 	}
-	btrfs_release_path(&path);
 	return em;
 
 not_found:
-	btrfs_release_path(&path);
 	btrfs_free_extent_map(em);
 	return NULL;
 
 err:
-	btrfs_release_path(&path);
 	btrfs_free_extent_map(em);
 	return ERR_PTR(ret);
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 46b5d29f7e29..eaf6179692b3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -217,7 +217,7 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
 				   int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_path path = { 0 };
+	BTRFS_PATH_AUTO_RELEASE(path);
 	struct btrfs_key found_key = { 0 };
 	struct extent_buffer *eb;
 	struct btrfs_extent_item *ei;
@@ -255,7 +255,6 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
 	if (ret < 0) {
 		btrfs_err_rl(fs_info, "failed to lookup extent item for logical %llu: %d",
 			     logical, ret);
-		btrfs_release_path(&path);
 		return;
 	}
 	eb = path.nodes[0];
@@ -285,13 +284,10 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
 				(ref_level ? "node" : "leaf"),
 				ref_level, ref_root);
 		}
-		btrfs_release_path(&path);
 	} else {
 		struct btrfs_backref_walk_ctx ctx = { 0 };
 		struct data_reloc_warn reloc_warn = { 0 };
 
-		btrfs_release_path(&path);
-
 		ctx.bytenr = found_key.objectid;
 		ctx.extent_item_pos = logical - found_key.objectid;
 		ctx.fs_info = fs_info;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 41ead4a929b0..de09cfeb3bf1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2173,8 +2173,8 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 				      u64 full_stripe_start)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_path extent_path = { 0 };
-	struct btrfs_path csum_path = { 0 };
+	BTRFS_PATH_AUTO_RELEASE(extent_path);
+	BTRFS_PATH_AUTO_RELEASE(csum_path);
 	struct scrub_stripe *stripe;
 	bool all_empty = true;
 	const int data_stripes = nr_data_stripes(map);
@@ -2226,7 +2226,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 				full_stripe_start + btrfs_stripe_nr_to_offset(i),
 				BTRFS_STRIPE_LEN, stripe);
 		if (ret < 0)
-			goto out;
+			return ret;
 		/*
 		 * No extent in this data stripe, need to manually mark them
 		 * initialized to make later read submission happy.
@@ -2248,10 +2248,8 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 			break;
 		}
 	}
-	if (all_empty) {
-		ret = 0;
-		goto out;
-	}
+	if (all_empty)
+		return 0;
 
 	for (int i = 0; i < data_stripes; i++) {
 		stripe = &sctx->raid56_data_stripes[i];
@@ -2292,8 +2290,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 "scrub: unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
 				  full_stripe_start, i, stripe->nr_sectors,
 				  &error);
-			ret = -EIO;
-			goto out;
+			return ret;
 		}
 		bitmap_or(&extent_bitmap, &extent_bitmap, &has_extent,
 			  stripe->nr_sectors);
@@ -2302,9 +2299,6 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	/* Now we can check and regenerate the P/Q stripe. */
 	ret = scrub_raid56_cached_parity(sctx, scrub_dev, map, full_stripe_start,
 					 &extent_bitmap);
-out:
-	btrfs_release_path(&extent_path);
-	btrfs_release_path(&csum_path);
 	return ret;
 }
 
-- 
2.52.0


