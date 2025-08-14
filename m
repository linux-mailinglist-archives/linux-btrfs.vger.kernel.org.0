Return-Path: <linux-btrfs+bounces-16075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B83B25AD7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 07:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CFD887106
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 05:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866A22154F;
	Thu, 14 Aug 2025 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tdbe/vdu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tdbe/vdu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0522128B
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149638; cv=none; b=Rc58Dcov6HM4GLAktXEfF5v+Pq7TzG+3lpP8P6SF/q+Nw5hOv3gbOZ3/RqehIDv/GmhplZi8XBpGVDyoSSB1kBhntM3bvBRncXQ5laakidbqAuyb7Jli27uaFdZ10nZRAM9FSNYN1ATIQJyxBarIGy2nW9CfXwGvwqRAngo6UMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149638; c=relaxed/simple;
	bh=QZnAL+vqKwf2FefoULKLbnHFnPScbfq3Y1XG1xRSV8E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgR4OGKEbyq48YDKp2qIWylYFWAXqZj7rR3TNHaRtjEseclAJiCJq5G2OtVcBZrMH9FawRxtgcAqiZrUzF4tUtYR7+FKe61gfK+AWhhUogaKqm7oVXf0oJMwnavaPpGrupih5LWgu0hZyVPGr9TUyFjPSt/aaBeZR2aWfmm2g5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tdbe/vdu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tdbe/vdu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 154F11F7CB
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irfoXT1RMa5GzWgbiYe9GmK7/hgdz8hU/vYclvAWZ14=;
	b=tdbe/vduHH+Srqv+OD9xgp/BH5IIKjAyImNPdbsTzIk4QUULwNq5mAI/HLxCJGbYJMYg7K
	JSxETwT/25lj43M/cs0hqvt9paDVlRzVPCScspnPPFrDaJRyLU+QoaW3xdbzadtfUQkW3K
	1C3q4XqNr4g2rHscvwbXsNSNhp8v8o4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="tdbe/vdu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irfoXT1RMa5GzWgbiYe9GmK7/hgdz8hU/vYclvAWZ14=;
	b=tdbe/vduHH+Srqv+OD9xgp/BH5IIKjAyImNPdbsTzIk4QUULwNq5mAI/HLxCJGbYJMYg7K
	JSxETwT/25lj43M/cs0hqvt9paDVlRzVPCScspnPPFrDaJRyLU+QoaW3xdbzadtfUQkW3K
	1C3q4XqNr4g2rHscvwbXsNSNhp8v8o4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36DE413479
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ECY8ODp1nWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: add workspace manager initialization for zstd
Date: Thu, 14 Aug 2025 15:03:21 +0930
Message-ID: <db54546adb1bb51b2b9d1841520dbf9dc64adbed.1755148754.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755148754.git.wqu@suse.com>
References: <cover.1755148754.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 154F11F7CB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

This involves:

- Add zstd_alloc_workspace_manager() and zstd_free_workspace_manager()
  Those two functions will accept an fs_info pointer, and alloc/free
  fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD] pointer.

- Add btrfs_alloc_compress_wsm() and btrfs_free_compress_wsm()
  Those are helpers allocating the workspace managers for all
  algorithms.
  For now only zstd is supported, and the timing is a little unusual,
  the btrfs_alloc_compress_wsm() should only be called after the
  sectorsize being initialized.

  Meanwhile btrfs_free_fs_info_compress() is called in
  btrfs_free_fs_info().

- Move the definition of btrfs_compression_type to "fs.h"
  The reason is that "compression.h" has already included "fs.h", thus
  we can not just include "compression.h" to get the definition of
  BTRFS_NR_COMPRESS_TYPES to define fs_info::compr_wsm[].

For now the per-fs zstd workspace manager won't really have any effect,
and all compression is still going through the global workspace manager.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 18 ++++++++++++++
 fs/btrfs/compression.h | 15 ++++--------
 fs/btrfs/disk-io.c     |  4 ++++
 fs/btrfs/fs.h          | 13 +++++++++++
 fs/btrfs/zstd.c        | 53 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ddc18cec1e37..0ee8a17abc30 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1097,6 +1097,24 @@ int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
 	return ret;
 }
 
+int btrfs_alloc_compress_wsm(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	ret = zstd_alloc_workspace_manager(fs_info);
+	if (ret < 0)
+		goto error;
+	return 0;
+error:
+	btrfs_free_compress_wsm(fs_info);
+	return ret;
+}
+
+void btrfs_free_compress_wsm(struct btrfs_fs_info *fs_info)
+{
+	zstd_free_workspace_manager(fs_info);
+}
+
 int __init btrfs_init_compress(void)
 {
 	if (bioset_init(&btrfs_compressed_bioset, BIO_POOL_SIZE,
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 62c304767d3a..40cb21e85dee 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -89,6 +89,9 @@ static inline u32 btrfs_calc_input_length(struct folio *folio, u64 range_end, u6
 	return min(range_end, folio_end(folio)) - cur;
 }
 
+int btrfs_alloc_compress_wsm(struct btrfs_fs_info *fs_info);
+void btrfs_free_compress_wsm(struct btrfs_fs_info *fs_info);
+
 int __init btrfs_init_compress(void);
 void __cold btrfs_exit_compress(void);
 
@@ -112,16 +115,6 @@ int btrfs_compress_str2level(unsigned int type, const char *str);
 struct folio *btrfs_alloc_compr_folio(void);
 void btrfs_free_compr_folio(struct folio *folio);
 
-enum btrfs_compression_type {
-	BTRFS_COMPRESS_NONE  = 0,
-	BTRFS_COMPRESS_ZLIB  = 1,
-	BTRFS_COMPRESS_LZO   = 2,
-	BTRFS_COMPRESS_ZSTD  = 3,
-	BTRFS_NR_COMPRESS_TYPES = 4,
-
-	BTRFS_DEFRAG_DONT_COMPRESS,
-};
-
 struct workspace_manager {
 	struct list_head idle_ws;
 	spinlock_t ws_lock;
@@ -188,6 +181,8 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zstd_decompress(struct list_head *ws, const u8 *data_in,
 		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen);
+int zstd_alloc_workspace_manager(struct btrfs_fs_info *fs_info);
+void zstd_free_workspace_manager(struct btrfs_fs_info *fs_info);
 void zstd_init_workspace_manager(struct btrfs_fs_info *fs_info);
 void zstd_cleanup_workspace_manager(void);
 struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 34e81ca2fc79..1094a052e9db 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1248,6 +1248,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 
 	if (fs_info->fs_devices)
 		btrfs_close_devices(fs_info->fs_devices);
+	btrfs_free_compress_wsm(fs_info);
 	percpu_counter_destroy(&fs_info->stats_read_blocks);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
@@ -3411,6 +3412,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	fs_info->max_inline = min_t(u64, fs_info->max_inline, fs_info->sectorsize);
 
+	ret = btrfs_alloc_compress_wsm(fs_info);
+	if (ret)
+		goto fail_sb_buffer;
 	ret = btrfs_init_workqueues(fs_info);
 	if (ret)
 		goto fail_sb_buffer;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 90148e6ff120..1679fb24803c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -305,6 +305,16 @@ enum {
 #define BTRFS_WARNING_COMMIT_INTERVAL	(300)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
 
+enum btrfs_compression_type {
+	BTRFS_COMPRESS_NONE  = 0,
+	BTRFS_COMPRESS_ZLIB  = 1,
+	BTRFS_COMPRESS_LZO   = 2,
+	BTRFS_COMPRESS_ZSTD  = 3,
+	BTRFS_NR_COMPRESS_TYPES = 4,
+
+	BTRFS_DEFRAG_DONT_COMPRESS,
+};
+
 struct btrfs_dev_replace {
 	/* See #define above */
 	u64 replace_state;
@@ -507,6 +517,9 @@ struct btrfs_fs_info {
 	u64 last_trans_log_full_commit;
 	unsigned long long mount_opt;
 
+	/* Compress related structures. */
+	void *compr_wsm[BTRFS_NR_COMPRESS_TYPES];
+
 	int compress_type;
 	int compress_level;
 	u32 commit_interval;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 24bf5cfaecec..24898aee3ee0 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -182,6 +182,36 @@ static void zstd_calc_ws_mem_sizes(void)
 	}
 }
 
+int zstd_alloc_workspace_manager(struct btrfs_fs_info *fs_info)
+{
+	struct zstd_workspace_manager *zwsm;
+	struct list_head *ws;
+
+	ASSERT(fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD] == NULL);
+	zwsm = kzalloc(sizeof(*zwsm), GFP_KERNEL);
+	if (!zwsm)
+		return -ENOMEM;
+	zstd_calc_ws_mem_sizes();
+	zwsm->ops = &btrfs_zstd_compress;
+	spin_lock_init(&zwsm->lock);
+	init_waitqueue_head(&zwsm->wait);
+	timer_setup(&zwsm->timer, zstd_reclaim_timer_fn, 0);
+
+	INIT_LIST_HEAD(&zwsm->lru_list);
+	for (int i = 0; i < ZSTD_BTRFS_MAX_LEVEL; i++)
+		INIT_LIST_HEAD(&zwsm->idle_ws[i]);
+	fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD] = zwsm;
+
+	ws = zstd_alloc_workspace(fs_info, ZSTD_BTRFS_MAX_LEVEL);
+	if (IS_ERR(ws)) {
+		btrfs_warn(NULL, "cannot preallocate zstd compression workspace");
+	} else {
+		set_bit(ZSTD_BTRFS_MAX_LEVEL - 1, &zwsm->active_map);
+		list_add(ws, &zwsm->idle_ws[ZSTD_BTRFS_MAX_LEVEL - 1]);
+	}
+	return 0;
+}
+
 void zstd_init_workspace_manager(struct btrfs_fs_info *fs_info)
 {
 	struct list_head *ws;
@@ -207,6 +237,29 @@ void zstd_init_workspace_manager(struct btrfs_fs_info *fs_info)
 	}
 }
 
+void zstd_free_workspace_manager(struct btrfs_fs_info *fs_info)
+{
+	struct zstd_workspace_manager *zwsm = fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD];
+	struct workspace *workspace;
+
+	if (!zwsm)
+		return;
+	fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD] = NULL;
+	spin_lock_bh(&zwsm->lock);
+	for (int i = 0; i < ZSTD_BTRFS_MAX_LEVEL; i++) {
+		while (!list_empty(&zwsm->idle_ws[i])) {
+			workspace = container_of(zwsm->idle_ws[i].next,
+						 struct workspace, list);
+			list_del(&workspace->list);
+			list_del(&workspace->lru_list);
+			zstd_free_workspace(&workspace->list);
+		}
+	}
+	spin_unlock_bh(&zwsm->lock);
+	timer_delete_sync(&zwsm->timer);
+	kfree(zwsm);
+}
+
 void zstd_cleanup_workspace_manager(void)
 {
 	struct workspace *workspace;
-- 
2.50.1


