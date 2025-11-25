Return-Path: <linux-btrfs+bounces-19353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD30C8744D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 22:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AC844EB217
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAA02F5A2E;
	Tue, 25 Nov 2025 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gW2RK2eE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gW2RK2eE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FB3016E0
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107451; cv=none; b=W22YT3AdRhvgR26MUw+nDxuPDhkdVaxVj5snC65arUUjmQkHvs6Ikn+otFfsjEIx52a8rT+XsGAH+4gMP8CjNgWDS9ky6YEml8wjYNFPztU2H/ksI/H1UZk0QNGIVbS8RRA1TJCVA6Jpf9qlTYBWdLAN5czmFQ5Tn33y9BLOAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107451; c=relaxed/simple;
	bh=w/RyFvtDiajJk9cCVQNFhLcP8MOqBL/eZ6seTCOhhgM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S10jmzWTCHkKTF4a+EjghlmU/BxtZiGCdX/7H3OIyA0t0yTJdlEGB9Bs0cHhv++jQlWXRCfeBfn01LvJ8kHmGtv3gSJdM/Dsh5yU/0pOERZu44o6prhtUIo0P3hrEO48WS6qAy4If73GBdExXrU/QiqFvkTRyQcZw1xiR+yaeDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gW2RK2eE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gW2RK2eE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 33B265BD61
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764107442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k9zX9C8HfJasPlris8p2UbXIfyN5mGgK/j0VHVdpvY=;
	b=gW2RK2eElTRS1edZrYCP25h2BbKTOeB5d7fd9PqofXMJWxhiRD91mZc5SuhcmRmvefHqZH
	ZXsR/MJYFO20hPb5LY/aGYJp3R8o4It8f3rW6ACB6MaCpjGoOiedZgx0HUInT/Jr0Zl23P
	nXcW2lzIZiUOOGPLQCad0jvc37432YE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764107442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k9zX9C8HfJasPlris8p2UbXIfyN5mGgK/j0VHVdpvY=;
	b=gW2RK2eElTRS1edZrYCP25h2BbKTOeB5d7fd9PqofXMJWxhiRD91mZc5SuhcmRmvefHqZH
	ZXsR/MJYFO20hPb5LY/aGYJp3R8o4It8f3rW6ACB6MaCpjGoOiedZgx0HUInT/Jr0Zl23P
	nXcW2lzIZiUOOGPLQCad0jvc37432YE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 734A63EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AF3bDbEkJmkoDgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper
Date: Wed, 26 Nov 2025 08:20:21 +1030
Message-ID: <8922862996ef5e57e694de08dca430b372585728.1764106678.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764106678.git.wqu@suse.com>
References: <cover.1764106678.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
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
  There is a special case where we want to release the path early before
  the time consuming iterate_extent_inodes() call, thus that manual
  early release is kept as is, with an extra comment added.

- scrub_radi56_parity_stripe() in scrub.c

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h  |  9 +++++++++
 fs/btrfs/defrag.c |  5 +----
 fs/btrfs/inode.c  |  8 +++++---
 fs/btrfs/scrub.c  | 18 ++++++------------
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 692370fc07b2..d5bd01c4e414 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -85,6 +85,14 @@ struct btrfs_path {
 #define BTRFS_PATH_AUTO_FREE(path_name)					\
 	struct btrfs_path *path_name __free(btrfs_free_path) = NULL
 
+/*
+ * This defines an on-stack path that will be auto released exiting the scope.
+ *
+ * This one is compatible with any existing manual btrfs_release_path() calls.
+ */
+#define BTRFS_PATH_AUTO_RELEASE(path_name)					\
+	struct btrfs_path path_name __free(btrfs_release_path) = { 0 }
+
 /*
  * The state of btrfs root
  */
@@ -601,6 +609,7 @@ void btrfs_release_path(struct btrfs_path *p);
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
index 46b5d29f7e29..6ae94b7777bb 100644
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
@@ -285,11 +284,14 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
 				(ref_level ? "node" : "leaf"),
 				ref_level, ref_root);
 		}
-		btrfs_release_path(&path);
 	} else {
 		struct btrfs_backref_walk_ctx ctx = { 0 };
 		struct data_reloc_warn reloc_warn = { 0 };
 
+		/*
+		 * Do not hold the path as later iterate_extent_inodes() call
+		 * can be time consuming.
+		 */
 		btrfs_release_path(&path);
 
 		ctx.bytenr = found_key.objectid;
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


