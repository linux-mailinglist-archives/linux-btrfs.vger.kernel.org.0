Return-Path: <linux-btrfs+bounces-16076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D72B25AD2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 07:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA00F2A781A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 05:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474AF22836C;
	Thu, 14 Aug 2025 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nNRS0tdI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rIdDcLNN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45F22759B
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149643; cv=none; b=W7OjzdSmzsGnb2f0A8Wv+ss0sfqig3CyCQVS3c/fpJWXpA2GADMHY7Xkk6fNxTSnHqU8JejrLL2YynFVY3M9kZta4gBTyLxDYcotgUTzacovnkXT4krNfIDMn3IEeWOtQ/D57Z+CCsCfHNh5+eoRD5xHqSOBuW6DdM8AIyDFlcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149643; c=relaxed/simple;
	bh=fN7EX4bRBa5uhE21Qnnd7EN9BBnr3BI7v5V7GGjU4Xs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCksRDwe+voohEJkbHoPmwZ5OCubTGTVryA4r4hroWN+8DsY0siOZhohjvf8i7OsOz6vICE6J7eplvLWyy4gITd2BXcl+1/CfWNm7Vjh9H6CDctVGpr0lx0W+EpaJCONW37V6AX52rKS5wpqtqQabXJ1O60c81slQiqkYLAoWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nNRS0tdI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rIdDcLNN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E779921B46
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBmPGa5umoW3Yj15Wysd+NNtgwE8fIp8Mwe1zFqDTVI=;
	b=nNRS0tdIh22qCwuq+lKIyt/J6hm+ajmuBOhmuFu97UMj5pGjGQYhl78eHdYL3NC+gFYVTN
	a2syJ1pAsWg7AetipRKkWP+LcM4rNhnDykvUuRPwZF8LaoUdG4/VO8FewUBCYKBBEJN797
	6bsT2nSZXcrECjqn97+kSW/bH47VC5Q=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rIdDcLNN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBmPGa5umoW3Yj15Wysd+NNtgwE8fIp8Mwe1zFqDTVI=;
	b=rIdDcLNNXgz08zZTVdQ/xKBKpyjYregOujtPEyurV/YBLwvJdhHETy6Y7Wkq68gNWRmnfU
	fhTARqCCiPjYDuo9lFTPS44dkrg6Ac3VlHJXsnlDUkcYgJ0NakjX6e8dQPjR5belL1ZGBG
	W03LW4x00OCqxEHFZYZikxMbFatB/uw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08EDD13479
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oHkELT11nWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: migrate to use per-fs workspace manager
Date: Thu, 14 Aug 2025 15:03:23 +0930
Message-ID: <fdd226e695d85ca1f940ee51f90b48f7d1d37df3.1755148754.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: E779921B46
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

There are several interfaces involved for each algorithm:

- alloc workspace
  All algorithms allocate a workspace without the need for workspace
  manager.
  So no change needs to be done.

- get workspace
  This involves checking the workspace manager to find a free one, and
  if not, allocate a new one.

  For none and lzo, they share the same generic btrfs_get_workspace()
  helper, only needs to update that function to use the per-fs manager.

  For zlib it uses a wrapper around btrfs_get_workspace(), so no special
  work needed.

  For zstd, update zstd_find_workspace() and zstd_get_workspace() to
  utilize the per-fs manager.

- put workspace
  For none/zlib/lzo they share the same btrfs_put_workspace(), update
  that function to use the per-fs manager.

  For zstd, it's zstd_put_workspace(), the same update.

- zstd specific timer
  This is the timer to reclaim workspace, change it to grab the per-fs
  workspace manager instead.

Now all workspace are managed by the per-fs manager.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 18 +++++------
 fs/btrfs/zstd.c        | 71 +++++++++++++++++++++++-------------------
 2 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8a7b2b802ddd..4c5a9d6c22ef 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -875,7 +875,7 @@ static void btrfs_cleanup_workspace_manager(int type)
  */
 struct list_head *btrfs_get_workspace(struct btrfs_fs_info *fs_info, int type, int level)
 {
-	struct workspace_manager *wsm;
+	struct workspace_manager *wsm = fs_info->compr_wsm[type];
 	struct list_head *workspace;
 	int cpus = num_online_cpus();
 	unsigned nofs_flag;
@@ -885,7 +885,7 @@ struct list_head *btrfs_get_workspace(struct btrfs_fs_info *fs_info, int type, i
 	wait_queue_head_t *ws_wait;
 	int *free_ws;
 
-	wsm = btrfs_compress_op[type]->workspace_manager;
+	ASSERT(wsm);
 	idle_ws	 = &wsm->idle_ws;
 	ws_lock	 = &wsm->ws_lock;
 	total_ws = &wsm->total_ws;
@@ -974,19 +974,19 @@ static struct list_head *get_workspace(struct btrfs_fs_info *fs_info, int type,
  */
 void btrfs_put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_head *ws)
 {
-	struct workspace_manager *wsm;
+	struct workspace_manager *gwsm = fs_info->compr_wsm[type];
 	struct list_head *idle_ws;
 	spinlock_t *ws_lock;
 	atomic_t *total_ws;
 	wait_queue_head_t *ws_wait;
 	int *free_ws;
 
-	wsm = btrfs_compress_op[type]->workspace_manager;
-	idle_ws	 = &wsm->idle_ws;
-	ws_lock	 = &wsm->ws_lock;
-	total_ws = &wsm->total_ws;
-	ws_wait	 = &wsm->ws_wait;
-	free_ws	 = &wsm->free_ws;
+	ASSERT(gwsm);
+	idle_ws	 = &gwsm->idle_ws;
+	ws_lock	 = &gwsm->ws_lock;
+	total_ws = &gwsm->total_ws;
+	ws_wait	 = &gwsm->ws_wait;
+	free_ws	 = &gwsm->free_ws;
 
 	spin_lock(ws_lock);
 	if (*free_ws <= num_online_cpus()) {
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 24898aee3ee0..41019fcebc13 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -112,19 +112,19 @@ static inline int clip_level(int level)
  */
 static void zstd_reclaim_timer_fn(struct timer_list *timer)
 {
+	struct zstd_workspace_manager *zwsm =
+		container_of(timer, struct zstd_workspace_manager, timer);
 	unsigned long reclaim_threshold = jiffies - ZSTD_BTRFS_RECLAIM_JIFFIES;
 	struct list_head *pos, *next;
 
-	ASSERT(timer == &wsm.timer);
+	spin_lock(&zwsm->lock);
 
-	spin_lock(&wsm.lock);
-
-	if (list_empty(&wsm.lru_list)) {
-		spin_unlock(&wsm.lock);
+	if (list_empty(&zwsm->lru_list)) {
+		spin_unlock(&zwsm->lock);
 		return;
 	}
 
-	list_for_each_prev_safe(pos, next, &wsm.lru_list) {
+	list_for_each_prev_safe(pos, next, &zwsm->lru_list) {
 		struct workspace *victim = container_of(pos, struct workspace,
 							lru_list);
 		int level;
@@ -141,15 +141,15 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 		list_del(&victim->list);
 		zstd_free_workspace(&victim->list);
 
-		if (list_empty(&wsm.idle_ws[level]))
-			clear_bit(level, &wsm.active_map);
+		if (list_empty(&zwsm->idle_ws[level]))
+			clear_bit(level, &zwsm->active_map);
 
 	}
 
-	if (!list_empty(&wsm.lru_list))
-		mod_timer(&wsm.timer, jiffies + ZSTD_BTRFS_RECLAIM_JIFFIES);
+	if (!list_empty(&zwsm->lru_list))
+		mod_timer(&zwsm->timer, jiffies + ZSTD_BTRFS_RECLAIM_JIFFIES);
 
-	spin_unlock(&wsm.lock);
+	spin_unlock(&zwsm->lock);
 }
 
 /*
@@ -292,29 +292,31 @@ void zstd_cleanup_workspace_manager(void)
  * offer the opportunity to reclaim the workspace in favor of allocating an
  * appropriately sized one in the future.
  */
-static struct list_head *zstd_find_workspace(int level)
+static struct list_head *zstd_find_workspace(struct btrfs_fs_info *fs_info, int level)
 {
+	struct zstd_workspace_manager *zwsm = fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD];
 	struct list_head *ws;
 	struct workspace *workspace;
 	int i = clip_level(level);
 
-	spin_lock_bh(&wsm.lock);
-	for_each_set_bit_from(i, &wsm.active_map, ZSTD_BTRFS_MAX_LEVEL) {
-		if (!list_empty(&wsm.idle_ws[i])) {
-			ws = wsm.idle_ws[i].next;
+	ASSERT(zwsm);
+	spin_lock_bh(&zwsm->lock);
+	for_each_set_bit_from(i, &zwsm->active_map, ZSTD_BTRFS_MAX_LEVEL) {
+		if (!list_empty(&zwsm->idle_ws[i])) {
+			ws = zwsm->idle_ws[i].next;
 			workspace = list_to_workspace(ws);
 			list_del_init(ws);
 			/* keep its place if it's a lower level using this */
 			workspace->req_level = level;
 			if (clip_level(level) == workspace->level)
 				list_del(&workspace->lru_list);
-			if (list_empty(&wsm.idle_ws[i]))
-				clear_bit(i, &wsm.active_map);
-			spin_unlock_bh(&wsm.lock);
+			if (list_empty(&zwsm->idle_ws[i]))
+				clear_bit(i, &zwsm->active_map);
+			spin_unlock_bh(&zwsm->lock);
 			return ws;
 		}
 	}
-	spin_unlock_bh(&wsm.lock);
+	spin_unlock_bh(&zwsm->lock);
 
 	return NULL;
 }
@@ -331,15 +333,18 @@ static struct list_head *zstd_find_workspace(int level)
  */
 struct list_head *zstd_get_workspace(struct btrfs_fs_info *fs_info, int level)
 {
+	struct zstd_workspace_manager *zwsm = fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD];
 	struct list_head *ws;
 	unsigned int nofs_flag;
 
+	ASSERT(zwsm);
+
 	/* level == 0 means we can use any workspace */
 	if (!level)
 		level = 1;
 
 again:
-	ws = zstd_find_workspace(level);
+	ws = zstd_find_workspace(fs_info, level);
 	if (ws)
 		return ws;
 
@@ -350,9 +355,9 @@ struct list_head *zstd_get_workspace(struct btrfs_fs_info *fs_info, int level)
 	if (IS_ERR(ws)) {
 		DEFINE_WAIT(wait);
 
-		prepare_to_wait(&wsm.wait, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(&zwsm->wait, &wait, TASK_UNINTERRUPTIBLE);
 		schedule();
-		finish_wait(&wsm.wait, &wait);
+		finish_wait(&zwsm->wait, &wait);
 
 		goto again;
 	}
@@ -373,32 +378,34 @@ struct list_head *zstd_get_workspace(struct btrfs_fs_info *fs_info, int level)
  */
 void zstd_put_workspace(struct btrfs_fs_info *fs_info, struct list_head *ws)
 {
+	struct zstd_workspace_manager *zwsm = fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD];
 	struct workspace *workspace = list_to_workspace(ws);
 
-	spin_lock_bh(&wsm.lock);
+	ASSERT(zwsm);
+	spin_lock_bh(&zwsm->lock);
 
 	/* A node is only taken off the lru if we are the corresponding level */
 	if (clip_level(workspace->req_level) == workspace->level) {
 		/* Hide a max level workspace from reclaim */
-		if (list_empty(&wsm.idle_ws[ZSTD_BTRFS_MAX_LEVEL - 1])) {
+		if (list_empty(&zwsm->idle_ws[ZSTD_BTRFS_MAX_LEVEL - 1])) {
 			INIT_LIST_HEAD(&workspace->lru_list);
 		} else {
 			workspace->last_used = jiffies;
-			list_add(&workspace->lru_list, &wsm.lru_list);
-			if (!timer_pending(&wsm.timer))
-				mod_timer(&wsm.timer,
+			list_add(&workspace->lru_list, &zwsm->lru_list);
+			if (!timer_pending(&zwsm->timer))
+				mod_timer(&zwsm->timer,
 					  jiffies + ZSTD_BTRFS_RECLAIM_JIFFIES);
 		}
 	}
 
-	set_bit(workspace->level, &wsm.active_map);
-	list_add(&workspace->list, &wsm.idle_ws[workspace->level]);
+	set_bit(workspace->level, &zwsm->active_map);
+	list_add(&workspace->list, &zwsm->idle_ws[workspace->level]);
 	workspace->req_level = 0;
 
-	spin_unlock_bh(&wsm.lock);
+	spin_unlock_bh(&zwsm->lock);
 
 	if (workspace->level == clip_level(ZSTD_BTRFS_MAX_LEVEL))
-		cond_wake_up(&wsm.wait);
+		cond_wake_up(&zwsm->wait);
 }
 
 void zstd_free_workspace(struct list_head *ws)
-- 
2.50.1


