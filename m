Return-Path: <linux-btrfs+bounces-16895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB48B813EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 19:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA47E16C988
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 17:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB512FE07F;
	Wed, 17 Sep 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fpiVzZzH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fpiVzZzH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF72773CE
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131667; cv=none; b=U9wU5PIvB8pUosBmcTha1K7QBPv1x9n6f1ebsPA2UBMV19081fqjNpSILnGKO0Z5JdN5XAbwVDmu07pCrBszJQY8IDm35TNsGUfZUPbwHU2fvHimn7aok5tacyFHaeIdL9joC3RHNDm3u50S+3X+l/2oiT8nhy9K3yeg8RlpwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131667; c=relaxed/simple;
	bh=Hum8Dw5tYf6vI/Dz3kOJhP3XtcVonuRwxtPJb3JXPxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0M8EzlZHSRr+sQj1dtDXzQ5Dvd3odkZWsO+5WDmcxPx8eSTDztJx2k6KwS+YnzuOiwm/hlX7RdH081jAU4sQHfk5menFiffc1IB3PlcHIBTyYF4zcyfGlwK69aMLhFquYK+g5LywCHzwG4rssyXK5t/wX2rhVe0oRmZ6bDt/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fpiVzZzH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fpiVzZzH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B36DF221F2;
	Wed, 17 Sep 2025 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758131650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpn4U8NrTSb7HZonNSnJChByw9VYkrykw+QMZ9opddM=;
	b=fpiVzZzHVbCXAu9zpeu22+JpNgyO7iVI4k9DE6qRyPcXxqQGLPR6QM0ymaaaYiqh2Wzng1
	D5GFFPXPUb0yDik9+y9MLPF5uNkegXMGoLCKt6kAkXjIeCZoljwTns3sN+61xIUZ3t2h51
	q0PUpVSWw3KCv2kJnoaQi788ES+U394=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758131650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpn4U8NrTSb7HZonNSnJChByw9VYkrykw+QMZ9opddM=;
	b=fpiVzZzHVbCXAu9zpeu22+JpNgyO7iVI4k9DE6qRyPcXxqQGLPR6QM0ymaaaYiqh2Wzng1
	D5GFFPXPUb0yDik9+y9MLPF5uNkegXMGoLCKt6kAkXjIeCZoljwTns3sN+61xIUZ3t2h51
	q0PUpVSWw3KCv2kJnoaQi788ES+U394=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB4FA137C3;
	Wed, 17 Sep 2025 17:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0iHQKcL1ymiMSgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 17 Sep 2025 17:54:10 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: add unlikely annotations to branches leading to EIO
Date: Wed, 17 Sep 2025 19:53:55 +0200
Message-ID: <19737210cd022e912091fa25dcddf6fda23ce36f.1758130856.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758130856.git.dsterba@suse.com>
References: <cover.1758130856.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c         |  4 ++--
 fs/btrfs/bio.c             |  4 ++--
 fs/btrfs/ctree.c           |  8 ++++----
 fs/btrfs/defrag.c          |  2 +-
 fs/btrfs/dev-replace.c     |  6 ++----
 fs/btrfs/disk-io.c         | 24 ++++++++++++------------
 fs/btrfs/extent-tree.c     |  4 ++--
 fs/btrfs/extent_io.c       |  2 +-
 fs/btrfs/extent_map.c      |  2 +-
 fs/btrfs/file.c            |  2 +-
 fs/btrfs/free-space-tree.c | 12 ++++++------
 fs/btrfs/inode.c           | 12 ++++++------
 fs/btrfs/qgroup.c          |  4 ++--
 fs/btrfs/raid56.c          | 14 +++++++-------
 fs/btrfs/relocation.c      |  6 +++---
 fs/btrfs/scrub.c           | 14 +++++++-------
 fs/btrfs/send.c            | 10 +++++-----
 fs/btrfs/zoned.c           | 36 ++++++++++++++++++------------------
 fs/btrfs/zstd.c            |  2 +-
 19 files changed, 83 insertions(+), 85 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 650083e0f1cb8b..2ab550a1e715a7 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -859,7 +859,7 @@ static int add_missing_keys(struct btrfs_fs_info *fs_info,
 			free_pref(ref);
 			return PTR_ERR(eb);
 		}
-		if (!extent_buffer_uptodate(eb)) {
+		if (unlikely(!extent_buffer_uptodate(eb))) {
 			free_pref(ref);
 			free_extent_buffer(eb);
 			return -EIO;
@@ -1614,7 +1614,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 					ret = PTR_ERR(eb);
 					goto out;
 				}
-				if (!extent_buffer_uptodate(eb)) {
+				if (unlikely(!extent_buffer_uptodate(eb))) {
 					free_extent_buffer(eb);
 					ret = -EIO;
 					goto out;
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 909b208f9ef3c8..79419f4ea0b323 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -822,8 +822,8 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	if (ret < 0)
 		goto out_counter_dec;
 
-	if (!smap.dev->bdev ||
-	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &smap.dev->dev_state)) {
+	if (unlikely(!smap.dev->bdev ||
+		     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &smap.dev->dev_state))) {
 		ret = -EIO;
 		goto out_counter_dec;
 	}
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1b6c3c0273f5dd..4257a4707e29cb 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -844,7 +844,7 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 			     &check);
 	if (IS_ERR(eb))
 		return eb;
-	if (!extent_buffer_uptodate(eb)) {
+	if (unlikely(!extent_buffer_uptodate(eb))) {
 		free_extent_buffer(eb);
 		return ERR_PTR(-EIO);
 	}
@@ -1571,7 +1571,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	 * and give up so that our caller doesn't loop forever
 	 * on our EAGAINs.
 	 */
-	if (!extent_buffer_uptodate(tmp)) {
+	if (unlikely(!extent_buffer_uptodate(tmp))) {
 		ret = -EIO;
 		goto out;
 	}
@@ -1752,7 +1752,7 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 	 * The root may have failed to write out at some point, and thus is no
 	 * longer valid, return an error in this case.
 	 */
-	if (!extent_buffer_uptodate(b)) {
+	if (unlikely(!extent_buffer_uptodate(b))) {
 		if (root_lock)
 			btrfs_tree_unlock_rw(b, root_lock);
 		free_extent_buffer(b);
@@ -2260,7 +2260,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 
 again:
 	b = btrfs_get_old_root(root, time_seq);
-	if (!b) {
+	if (unlikely(!b)) {
 		ret = -EIO;
 		goto done;
 	}
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 84ba9906f0d818..7b277934f66f92 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -924,7 +924,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 			folio_put(folio);
 			goto again;
 		}
-		if (!folio_test_uptodate(folio)) {
+		if (unlikely(!folio_test_uptodate(folio))) {
 			folio_unlock(folio);
 			folio_put(folio);
 			return ERR_PTR(-EIO);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index b37e9a893b918a..a4eaef60549eed 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -177,8 +177,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		 * allow 'btrfs dev replace_cancel' if src/tgt device is
 		 * missing
 		 */
-		if (!dev_replace->srcdev &&
-		    !btrfs_test_opt(fs_info, DEGRADED)) {
+		if (unlikely(!dev_replace->srcdev && !btrfs_test_opt(fs_info, DEGRADED))) {
 			ret = -EIO;
 			btrfs_warn(fs_info,
 			   "cannot mount because device replace operation is ongoing and");
@@ -186,8 +185,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 			   "srcdev (devid %llu) is missing, need to run 'btrfs dev scan'?",
 			   src_devid);
 		}
-		if (!dev_replace->tgtdev &&
-		    !btrfs_test_opt(fs_info, DEGRADED)) {
+		if (unlikely(!dev_replace->tgtdev && !btrfs_test_opt(fs_info, DEGRADED))) {
 			ret = -EIO;
 			btrfs_warn(fs_info,
 			   "cannot mount because device replace operation is ongoing and");
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c4996a5269832..f4ba53114fe2d1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -370,21 +370,21 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 	ASSERT(check);
 
 	found_start = btrfs_header_bytenr(eb);
-	if (found_start != eb->start) {
+	if (unlikely(found_start != eb->start)) {
 		btrfs_err_rl(fs_info,
 			"bad tree block start, mirror %u want %llu have %llu",
 			     eb->read_mirror, eb->start, found_start);
 		ret = -EIO;
 		goto out;
 	}
-	if (check_tree_block_fsid(eb)) {
+	if (unlikely(check_tree_block_fsid(eb))) {
 		btrfs_err_rl(fs_info, "bad fsid on logical %llu mirror %u",
 			     eb->start, eb->read_mirror);
 		ret = -EIO;
 		goto out;
 	}
 	found_level = btrfs_header_level(eb);
-	if (found_level >= BTRFS_MAX_LEVEL) {
+	if (unlikely(found_level >= BTRFS_MAX_LEVEL)) {
 		btrfs_err(fs_info,
 			"bad tree block level, mirror %u level %d on logical %llu",
 			eb->read_mirror, btrfs_header_level(eb), eb->start);
@@ -410,7 +410,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 		}
 	}
 
-	if (found_level != check->level) {
+	if (unlikely(found_level != check->level)) {
 		btrfs_err(fs_info,
 		"level verify failed on logical %llu mirror %u wanted %u found %u",
 			  eb->start, eb->read_mirror, check->level, found_level);
@@ -1047,7 +1047,7 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 		root->node = NULL;
 		goto fail;
 	}
-	if (!btrfs_buffer_uptodate(root->node, generation, false)) {
+	if (unlikely(!btrfs_buffer_uptodate(root->node, generation, false))) {
 		ret = -EIO;
 		goto fail;
 	}
@@ -2059,7 +2059,7 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 	u64 bytenr = btrfs_super_log_root(disk_super);
 	int level = btrfs_super_log_root_level(disk_super);
 
-	if (fs_devices->rw_devices == 0) {
+	if (unlikely(fs_devices->rw_devices == 0)) {
 		btrfs_warn(fs_info, "log replay required on RO media");
 		return -EIO;
 	}
@@ -2080,7 +2080,7 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 		btrfs_put_root(log_tree_root);
 		return ret;
 	}
-	if (!extent_buffer_uptodate(log_tree_root->node)) {
+	if (unlikely(!extent_buffer_uptodate(log_tree_root->node))) {
 		btrfs_err(fs_info, "failed to read log tree");
 		btrfs_put_root(log_tree_root);
 		return -EIO;
@@ -2642,7 +2642,7 @@ static int load_super_root(struct btrfs_root *root, u64 bytenr, u64 gen, int lev
 		root->node = NULL;
 		return ret;
 	}
-	if (!extent_buffer_uptodate(root->node)) {
+	if (unlikely(!extent_buffer_uptodate(root->node))) {
 		free_extent_buffer(root->node);
 		root->node = NULL;
 		return -EIO;
@@ -3460,7 +3460,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * below in btrfs_init_dev_replace().
 	 */
 	btrfs_free_extra_devids(fs_devices);
-	if (!fs_devices->latest_dev->bdev) {
+	if (unlikely(!fs_devices->latest_dev->bdev)) {
 		btrfs_err(fs_info, "failed to read devices");
 		ret = -EIO;
 		goto fail_tree_roots;
@@ -3954,7 +3954,7 @@ static int barrier_all_devices(struct btrfs_fs_info *info)
 	 * Checks last_flush_error of disks in order to determine the device
 	 * state.
 	 */
-	if (errors_wait && !btrfs_check_rw_degradable(info, NULL))
+	if (unlikely(errors_wait && !btrfs_check_rw_degradable(info, NULL)))
 		return -EIO;
 
 	return 0;
@@ -4067,7 +4067,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 		if (ret)
 			total_errors++;
 	}
-	if (total_errors > max_errors) {
+	if (unlikely(total_errors > max_errors)) {
 		btrfs_err(fs_info, "%d errors while writing supers",
 			  total_errors);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
@@ -4092,7 +4092,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 			total_errors++;
 	}
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-	if (total_errors > max_errors) {
+	if (unlikely(total_errors > max_errors)) {
 		btrfs_handle_fs_error(fs_info, -EIO,
 				      "%d errors while writing supers",
 				      total_errors);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index df3ac2fa600000..f189a0bfeda5b7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5638,7 +5638,7 @@ static int maybe_drop_reference(struct btrfs_trans_handle *trans, struct btrfs_r
 		ref.parent = path->nodes[level]->start;
 	} else {
 		ASSERT(btrfs_root_id(root) == btrfs_header_owner(path->nodes[level]));
-		if (btrfs_root_id(root) != btrfs_header_owner(path->nodes[level])) {
+		if (unlikely(btrfs_root_id(root) != btrfs_header_owner(path->nodes[level]))) {
 			btrfs_err(root->fs_info, "mismatched block owner");
 			return -EIO;
 		}
@@ -5774,7 +5774,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	level--;
 	ASSERT(level == btrfs_header_level(next));
-	if (level != btrfs_header_level(next)) {
+	if (unlikely(level != btrfs_header_level(next))) {
 		btrfs_err(root->fs_info, "mismatched level");
 		ret = -EIO;
 		goto out_unlock;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca7174fa024056..d1e8d44c8ade30 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3867,7 +3867,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
 		return ret;
 
 	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_READING, TASK_UNINTERRUPTIBLE);
-	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
+	if (unlikely(!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags)))
 		return -EIO;
 	return 0;
 }
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index ac28eee7ae32c5..c1e5c7c158b80a 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1057,7 +1057,7 @@ int btrfs_split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pr
 	btrfs_lock_extent(&inode->io_tree, start, start + len - 1, NULL);
 	write_lock(&em_tree->lock);
 	em = btrfs_lookup_extent_mapping(em_tree, start, len);
-	if (!em) {
+	if (unlikely(!em)) {
 		ret = -EIO;
 		goto out_unlock;
 	}
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4daec404fec621..e7765578349b6d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -815,7 +815,7 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
 	if (ret)
 		return ret;
 	folio_lock(folio);
-	if (!folio_test_uptodate(folio)) {
+	if (unlikely(!folio_test_uptodate(folio))) {
 		folio_unlock(folio);
 		return -EIO;
 	}
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index eba7f22ae49c67..2fee9f3b60d439 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -137,12 +137,12 @@ static int btrfs_search_prev_slot(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		return ret;
 
-	if (ret == 0) {
+	if (unlikely(ret == 0)) {
 		DEBUG_WARN();
 		return -EIO;
 	}
 
-	if (p->slots[0] == 0) {
+	if (unlikely(p->slots[0] == 0)) {
 		DEBUG_WARN("no previous slot found");
 		return -EIO;
 	}
@@ -293,7 +293,7 @@ int btrfs_convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	expected_extent_count = btrfs_free_space_extent_count(leaf, info);
 	btrfs_release_path(path);
 
-	if (extent_count != expected_extent_count) {
+	if (unlikely(extent_count != expected_extent_count)) {
 		btrfs_err(fs_info,
 			  "incorrect extent count for %llu; counted %u, expected %u",
 			  block_group->start, extent_count,
@@ -465,7 +465,7 @@ int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 		start_bit = find_next_bit_le(bitmap, nrbits, end_bit);
 	}
 
-	if (extent_count != expected_extent_count) {
+	if (unlikely(extent_count != expected_extent_count)) {
 		btrfs_err(fs_info,
 			  "incorrect extent count for %llu; counted %u, expected %u",
 			  block_group->start, extent_count,
@@ -1611,7 +1611,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 		extent_count++;
 	}
 
-	if (extent_count != expected_extent_count) {
+	if (unlikely(extent_count != expected_extent_count)) {
 		btrfs_err(fs_info,
 			  "incorrect extent count for %llu; counted %u, expected %u",
 			  block_group->start, extent_count,
@@ -1672,7 +1672,7 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 		extent_count++;
 	}
 
-	if (extent_count != expected_extent_count) {
+	if (unlikely(extent_count != expected_extent_count)) {
 		btrfs_err(fs_info,
 			  "incorrect extent count for %llu; counted %u, expected %u",
 			  block_group->start, extent_count,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6e7cf240d8ae9b..27226e7761aead 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3102,7 +3102,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	if (!freespace_inode)
 		btrfs_lockdep_acquire(fs_info, btrfs_ordered_extent);
 
-	if (test_bit(BTRFS_ORDERED_IOERR, &ordered_extent->flags)) {
+	if (unlikely(test_bit(BTRFS_ORDERED_IOERR, &ordered_extent->flags))) {
 		ret = -EIO;
 		goto out;
 	}
@@ -3368,7 +3368,7 @@ int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8
 			   const u8 * const csum_expected)
 {
 	btrfs_calculate_block_csum(fs_info, paddr, csum);
-	if (memcmp(csum, csum_expected, fs_info->csum_size))
+	if (unlikely(memcmp(csum, csum_expected, fs_info->csum_size) != 0))
 		return -EIO;
 	return 0;
 }
@@ -4840,7 +4840,7 @@ static int truncate_block_zero_beyond_eof(struct btrfs_inode *inode, u64 start)
 			folio_put(folio);
 			goto again;
 		}
-		if (!folio_test_uptodate(folio)) {
+		if (unlikely(!folio_test_uptodate(folio))) {
 			ret = -EIO;
 			goto out_unlock;
 		}
@@ -4984,7 +4984,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
 			folio_put(folio);
 			goto again;
 		}
-		if (!folio_test_uptodate(folio)) {
+		if (unlikely(!folio_test_uptodate(folio))) {
 			ret = -EIO;
 			goto out_unlock;
 		}
@@ -7177,7 +7177,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 insert:
 	ret = 0;
 	btrfs_release_path(path);
-	if (em->start > start || btrfs_extent_map_end(em) <= start) {
+	if (unlikely(em->start > start || btrfs_extent_map_end(em) <= start)) {
 		btrfs_err(fs_info,
 			  "bad extent! em: [%llu %llu] passed [%llu %llu]",
 			  em->start, em->len, start, len);
@@ -9296,7 +9296,7 @@ static ssize_t btrfs_encoded_read_inline(
 	ret = btrfs_lookup_file_extent(NULL, root, path, btrfs_ino(inode),
 				       extent_start, 0);
 	if (ret) {
-		if (ret > 0) {
+		if (unlikely(ret > 0)) {
 			/* The extent item disappeared? */
 			return -EIO;
 		}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8154393449b841..4c6097b7e56afb 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2538,7 +2538,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 		return -EUCLEAN;
 	}
 
-	if (!extent_buffer_uptodate(src_eb) || !extent_buffer_uptodate(dst_eb)) {
+	if (unlikely(!extent_buffer_uptodate(src_eb) || !extent_buffer_uptodate(dst_eb))) {
 		ret = -EIO;
 		goto out;
 	}
@@ -4843,7 +4843,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		reloc_eb = NULL;
 		goto free_out;
 	}
-	if (!extent_buffer_uptodate(reloc_eb)) {
+	if (unlikely(!extent_buffer_uptodate(reloc_eb))) {
 		ret = -EIO;
 		goto free_out;
 	}
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2b4f577dcf39de..56dd7ed219bbc5 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1167,7 +1167,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 		/* Check if we have reached tolerance early. */
 		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
 							 NULL, NULL);
-		if (found_errors > rbio->bioc->max_errors)
+		if (unlikely(found_errors > rbio->bioc->max_errors))
 			return -EIO;
 		return 0;
 	}
@@ -1847,7 +1847,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	if (!found_errors)
 		return 0;
 
-	if (found_errors > rbio->bioc->max_errors)
+	if (unlikely(found_errors > rbio->bioc->max_errors))
 		return -EIO;
 
 	/*
@@ -2399,7 +2399,7 @@ static void rmw_rbio(struct btrfs_raid_bio *rbio)
 		int found_errors;
 
 		found_errors = get_rbio_veritical_errors(rbio, sectornr, NULL, NULL);
-		if (found_errors > rbio->bioc->max_errors) {
+		if (unlikely(found_errors > rbio->bioc->max_errors)) {
 			ret = -EIO;
 			break;
 		}
@@ -2688,7 +2688,7 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 
 		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
 							 &faila, &failb);
-		if (found_errors > rbio->bioc->max_errors) {
+		if (unlikely(found_errors > rbio->bioc->max_errors)) {
 			ret = -EIO;
 			goto out;
 		}
@@ -2712,7 +2712,7 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 		 * data, so the capability of the repair is declined.  (In the
 		 * case of RAID5, we can not repair anything.)
 		 */
-		if (dfail > rbio->bioc->max_errors - 1) {
+		if (unlikely(dfail > rbio->bioc->max_errors - 1)) {
 			ret = -EIO;
 			goto out;
 		}
@@ -2729,7 +2729,7 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 		 * scrubbing parity, luckily, use the other one to repair the
 		 * data, or we can not repair the data stripe.
 		 */
-		if (failp != rbio->scrubp) {
+		if (unlikely(failp != rbio->scrubp)) {
 			ret = -EIO;
 			goto out;
 		}
@@ -2820,7 +2820,7 @@ static void scrub_rbio(struct btrfs_raid_bio *rbio)
 		int found_errors;
 
 		found_errors = get_rbio_veritical_errors(rbio, sector_nr, NULL, NULL);
-		if (found_errors > rbio->bioc->max_errors) {
+		if (unlikely(found_errors > rbio->bioc->max_errors)) {
 			ret = -EIO;
 			break;
 		}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6c9ac749d7dc1c..e5b3d3382bc24b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2277,7 +2277,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 		bytenr = btrfs_node_blockptr(upper->eb, slot);
 		if (lowest) {
-			if (bytenr != node->bytenr) {
+			if (unlikely(bytenr != node->bytenr)) {
 				btrfs_err(root->fs_info,
 		"lowest leaf/node mismatch: bytenr %llu node->bytenr %llu slot %d upper %llu",
 					  bytenr, node->bytenr, slot,
@@ -2454,7 +2454,7 @@ static int get_tree_block_key(struct btrfs_fs_info *fs_info,
 	eb = read_tree_block(fs_info, block->bytenr, &check);
 	if (IS_ERR(eb))
 		return PTR_ERR(eb);
-	if (!extent_buffer_uptodate(eb)) {
+	if (unlikely(!extent_buffer_uptodate(eb))) {
 		free_extent_buffer(eb);
 		return -EIO;
 	}
@@ -2839,7 +2839,7 @@ static int relocate_one_folio(struct reloc_control *rc,
 	if (!folio_test_uptodate(folio)) {
 		btrfs_read_folio(NULL, folio);
 		folio_lock(folio);
-		if (!folio_test_uptodate(folio)) {
+		if (unlikely(!folio_test_uptodate(folio))) {
 			ret = -EIO;
 			goto release_folio;
 		}
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 1b0f57c68226b4..2cf7058f084f46 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1983,7 +1983,7 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 		 * metadata, we should immediately abort.
 		 */
 		for (int i = 0; i < nr_stripes; i++) {
-			if (stripe_has_metadata_error(&sctx->stripes[i])) {
+			if (unlikely(stripe_has_metadata_error(&sctx->stripes[i]))) {
 				ret = -EIO;
 				goto out;
 			}
@@ -2177,7 +2177,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		 * As we may hit an empty data stripe while it's missing.
 		 */
 		bitmap_and(&error, &error, &has_extent, stripe->nr_sectors);
-		if (!bitmap_empty(&error, stripe->nr_sectors)) {
+		if (unlikely(!bitmap_empty(&error, stripe->nr_sectors))) {
 			btrfs_err(fs_info,
 "scrub: unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
 				  full_stripe_start, i, stripe->nr_sectors,
@@ -2871,8 +2871,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		btrfs_put_block_group(cache);
 		if (ret)
 			break;
-		if (sctx->is_dev_replace &&
-		    atomic64_read(&dev_replace->num_write_errors) > 0) {
+		if (unlikely(sctx->is_dev_replace &&
+			     atomic64_read(&dev_replace->num_write_errors) > 0)) {
 			ret = -EIO;
 			break;
 		}
@@ -2902,7 +2902,7 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
 	if (ret < 0)
 		return ret;
 	ret = btrfs_check_super_csum(fs_info, sb);
-	if (ret != 0) {
+	if (unlikely(ret != 0)) {
 		btrfs_err_rl(fs_info,
 		  "scrub: super block at physical %llu devid %llu has bad csum",
 			physical, dev->devid);
@@ -3078,8 +3078,8 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	}
 
 	mutex_lock(&fs_info->scrub_lock);
-	if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
-	    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &dev->dev_state)) {
+	if (unlikely(!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
+		     test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &dev->dev_state))) {
 		mutex_unlock(&fs_info->scrub_lock);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 		ret = -EIO;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index a4b88f58f6b421..d71c4859b3598e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -646,7 +646,7 @@ static int write_buf(struct file *filp, const void *buf, u32 len, loff_t *off)
 		ret = kernel_write(filp, buf + pos, len - pos, off);
 		if (ret < 0)
 			return ret;
-		if (ret == 0)
+		if (unlikely(ret == 0))
 			return -EIO;
 		pos += ret;
 	}
@@ -1733,7 +1733,7 @@ static int read_symlink(struct btrfs_root *root,
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
-	if (ret) {
+	if (unlikely(ret)) {
 		/*
 		 * An empty symlink inode. Can happen in rare error paths when
 		 * creating a symlink (transaction committed before the inode
@@ -5252,7 +5252,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 		if (!folio_test_uptodate(folio)) {
 			btrfs_read_folio(NULL, folio);
 			folio_lock(folio);
-			if (!folio_test_uptodate(folio)) {
+			if (unlikely(!folio_test_uptodate(folio))) {
 				folio_unlock(folio);
 				btrfs_err(fs_info,
 			"send: IO error at offset %llu for inode %llu root %llu",
@@ -7034,7 +7034,7 @@ static int changed_ref(struct send_ctx *sctx,
 {
 	int ret = 0;
 
-	if (sctx->cur_ino != sctx->cmp_key->objectid) {
+	if (unlikely(sctx->cur_ino != sctx->cmp_key->objectid)) {
 		inconsistent_snapshot_error(sctx, result, "reference");
 		return -EIO;
 	}
@@ -7062,7 +7062,7 @@ static int changed_xattr(struct send_ctx *sctx,
 {
 	int ret = 0;
 
-	if (sctx->cur_ino != sctx->cmp_key->objectid) {
+	if (unlikely(sctx->cur_ino != sctx->cmp_key->objectid)) {
 		inconsistent_snapshot_error(sctx, result, "xattr");
 		return -EIO;
 	}
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 746ddc76100301..3b1746029bc8e0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -274,7 +274,7 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 		return ret;
 	}
 	*nr_zones = ret;
-	if (!ret)
+	if (unlikely(!ret))
 		return -EIO;
 
 	/* Populate cache */
@@ -503,7 +503,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		sector = zones[nr_zones - 1].start + zones[nr_zones - 1].len;
 	}
 
-	if (nreported != zone_info->nr_zones) {
+	if (unlikely(nreported != zone_info->nr_zones)) {
 		btrfs_err(device->fs_info,
 				 "inconsistent number of zones on %s (%u/%u)",
 				 rcu_dereference(device->name), nreported,
@@ -513,7 +513,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	}
 
 	if (max_active_zones) {
-		if (nactive > max_active_zones) {
+		if (unlikely(nactive > max_active_zones)) {
 			btrfs_err(device->fs_info,
 			"zoned: %u active zones on %s exceeds max_active_zones %u",
 					 nactive, rcu_dereference(device->name),
@@ -895,7 +895,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 				  zones);
 	if (ret < 0)
 		return ret;
-	if (ret != BTRFS_NR_SB_LOG_ZONES)
+	if (unlikely(ret != BTRFS_NR_SB_LOG_ZONES))
 		return -EIO;
 
 	return sb_log_location(bdev, zones, rw, bytenr_ret);
@@ -1351,7 +1351,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 		return 0;
 	}
 
-	if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
+	if (unlikely(zone.type == BLK_ZONE_TYPE_CONVENTIONAL)) {
 		btrfs_err(fs_info,
 		"zoned: unexpected conventional zone %llu on device %s (devid %llu)",
 			zone.start << SECTOR_SHIFT, rcu_dereference(device->name),
@@ -1393,7 +1393,7 @@ static int btrfs_load_block_group_single(struct btrfs_block_group *bg,
 					 struct zone_info *info,
 					 unsigned long *active)
 {
-	if (info->alloc_offset == WP_MISSING_DEV) {
+	if (unlikely(info->alloc_offset == WP_MISSING_DEV)) {
 		btrfs_err(bg->fs_info,
 			"zoned: cannot recover write pointer for zone %llu",
 			info->physical);
@@ -1422,13 +1422,13 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 
 	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
 
-	if (zone_info[0].alloc_offset == WP_MISSING_DEV) {
+	if (unlikely(zone_info[0].alloc_offset == WP_MISSING_DEV)) {
 		btrfs_err(bg->fs_info,
 			  "zoned: cannot recover write pointer for zone %llu",
 			  zone_info[0].physical);
 		return -EIO;
 	}
-	if (zone_info[1].alloc_offset == WP_MISSING_DEV) {
+	if (unlikely(zone_info[1].alloc_offset == WP_MISSING_DEV)) {
 		btrfs_err(bg->fs_info,
 			  "zoned: cannot recover write pointer for zone %llu",
 			  zone_info[1].physical);
@@ -1441,14 +1441,14 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 	if (zone_info[1].alloc_offset == WP_CONVENTIONAL)
 		zone_info[1].alloc_offset = last_alloc;
 
-	if (zone_info[0].alloc_offset != zone_info[1].alloc_offset) {
+	if (unlikely(zone_info[0].alloc_offset != zone_info[1].alloc_offset)) {
 		btrfs_err(bg->fs_info,
 			  "zoned: write pointer offset mismatch of zones in DUP profile");
 		return -EIO;
 	}
 
 	if (test_bit(0, active) != test_bit(1, active)) {
-		if (!btrfs_zone_activate(bg))
+		if (unlikely(!btrfs_zone_activate(bg)))
 			return -EIO;
 	} else if (test_bit(0, active)) {
 		set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
@@ -1483,16 +1483,16 @@ static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
 		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
 			zone_info[i].alloc_offset = last_alloc;
 
-		if ((zone_info[0].alloc_offset != zone_info[i].alloc_offset) &&
-		    !btrfs_test_opt(fs_info, DEGRADED)) {
+		if (unlikely((zone_info[0].alloc_offset != zone_info[i].alloc_offset) &&
+			     !btrfs_test_opt(fs_info, DEGRADED))) {
 			btrfs_err(fs_info,
 			"zoned: write pointer offset mismatch of zones in %s profile",
 				  btrfs_bg_type_to_raid_name(map->type));
 			return -EIO;
 		}
 		if (test_bit(0, active) != test_bit(i, active)) {
-			if (!btrfs_test_opt(fs_info, DEGRADED) &&
-			    !btrfs_zone_activate(bg)) {
+			if (unlikely(!btrfs_test_opt(fs_info, DEGRADED) &&
+				     !btrfs_zone_activate(bg))) {
 				return -EIO;
 			}
 		} else {
@@ -1548,7 +1548,7 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 		}
 
 		if (test_bit(0, active) != test_bit(i, active)) {
-			if (!btrfs_zone_activate(bg))
+			if (unlikely(!btrfs_zone_activate(bg)))
 				return -EIO;
 		} else {
 			if (test_bit(0, active))
@@ -1580,7 +1580,7 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 			continue;
 
 		if (test_bit(0, active) != test_bit(i, active)) {
-			if (!btrfs_zone_activate(bg))
+			if (unlikely(!btrfs_zone_activate(bg)))
 				return -EIO;
 		} else {
 			if (test_bit(0, active))
@@ -1637,7 +1637,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		return 0;
 
 	/* Sanity check */
-	if (!IS_ALIGNED(length, fs_info->zone_size)) {
+	if (unlikely(!IS_ALIGNED(length, fs_info->zone_size))) {
 		btrfs_err(fs_info,
 		"zoned: block group %llu len %llu unaligned to zone size %llu",
 			  logical, length, fs_info->zone_size);
@@ -1750,7 +1750,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		return -EINVAL;
 	}
 
-	if (cache->alloc_offset > cache->zone_capacity) {
+	if (unlikely(cache->alloc_offset > cache->zone_capacity)) {
 		btrfs_err(fs_info,
 "zoned: invalid write pointer %llu (larger than zone capacity %llu) in block group %llu",
 			  cache->alloc_offset, cache->zone_capacity,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index b11a87842cdaef..c7996772ba3c4a 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -651,7 +651,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
 			kunmap_local(workspace->in_buf.src);
 			folio_in_index++;
-			if (folio_in_index >= total_folios_in) {
+			if (unlikely(folio_in_index >= total_folios_in)) {
 				workspace->in_buf.src = NULL;
 				ret = -EIO;
 				goto done;
-- 
2.51.0


