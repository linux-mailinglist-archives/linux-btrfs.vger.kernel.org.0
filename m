Return-Path: <linux-btrfs+bounces-13409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF28A9BB7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 01:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6541B885CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 23:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1528468D;
	Thu, 24 Apr 2025 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="t7yiCgJi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ku2t2IUc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58E477111
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745538935; cv=none; b=c+Y3TInOBxRoCWeHHA+GhSTjgDnJRTX7Ty9FWa3RjKFuha/2lfIb7eersf9iqdeixcOKYqiGpBq3zHD+FxJZz3xXUIkRi8t4clqR9MTvBvm2ugf2FWnJ4KNCFB3eW+etFKdyqpKYnQypCLWpx+06bYSz2pjSdT35oxogOw7Sdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745538935; c=relaxed/simple;
	bh=6hPCn7qbHf7XGDhMEpY2fbNJ0ul/1Ga4WnWL5sT3bUQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JPk+LS0fARfhre1mHI5cmRg0mGl6aqhlmt3j3xtT3OWnZ9Qd3tTqxV6H5Wm1lTIXE4OnbCZZ/AmrjOAvZzDgOIUxtbruUvblAGP3dfImSP8LcAKprUQMYglYYFp4DRnxSAOYxHFhlxV+dDUZm5ki3Tvrr243PeEDXTpORSJTKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=t7yiCgJi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ku2t2IUc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id BE42E13801A8;
	Thu, 24 Apr 2025 19:55:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 24 Apr 2025 19:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1745538930; x=1745625330; bh=D8muCq3kABmUJA0/RYO40
	qds0Z0dwvRRshCXqXM5RfY=; b=t7yiCgJiIrvW/Lg1GA1tDqBXYpAzCSOJ6Nsly
	9lyPeToLK4T4wLGRqcGlAdJ6iZ9pAS35uZiuozaQ8PfxBgWr1EzeEacYACjWHAms
	Fg/e+Rj7TwRNvoO0d10MVZdHCgJLvECgpxsjyoDuQ+guQ7DCZOOSuu1Pj8vrvQur
	YWDEBEgPa63d2+KUuDfbgExDIkI5hCOTjmuJR3Hmuy4Ns4n2JhHIO23dw9NeJIQF
	C7I3ctOJdmIoDkZwxTbh8MqABiey1xDVHs2/A4Z3rl5RcTAKJmiGomh6QtRGXAx1
	waeaLZAou7O0tp1v62cUZZyl6KFZzV2S/eIZudneGmG/Vf4+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745538930; x=1745625330; bh=D8muCq3kABmUJA0/RYO40qds0Z0dwvRRshC
	XqXM5RfY=; b=ku2t2IUcm2Z3c7kB/5d1L5z0wCNOODz0khrde/Czy/ZKBnghl+H
	7GTbbkRm1ajyIfgrqiT5aN3RSQeaVYv/h5RCfOnrFXXmigFPS/3sN69bOwB7qi6P
	wXpkwtckOpQDPqa5iJQP6OUMw6j5EWBJkoS5EpAi0TVJHgJScuvtKdwlj4qlCzbA
	fRGeIDPGkea/omsrhWkcDUSzLg7WcUL5qE1izBwHn+zXWRsb9d117eQ5jhoqimD9
	enGFaZ+myQHRchYYdGNVp41T+3N/vcYQfiZl0DgFE7+gE3Ehy1OqfYaMMb86ahVP
	jSO8gX/R0S41LMv4yqgYvt7vNirVB5HXFHA==
X-ME-Sender: <xms:cs8KaFdtmDjB9iMQXlgGUfMX1SPKYLwOHME-C4Ay2VTo8tbXUBkbvg>
    <xme:cs8KaDPUTJGE_kSoI_bHbwchxPp1cq-GnHe8RjJEAofAFkk53DklFF4jDBhkpYrih
    ZGfyPZnKNWD4g_SA8k>
X-ME-Received: <xmr:cs8KaOiDwLSXEDUJ4yrTvBXVI-wklAlhzqadL0ju2okhh_5JIUh09G10FUZq9pwzfbQEstbdHnSwFJe1QqRqNf0kdSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelff
    evleeifefgjeejieegkeduudetfeekffeftefhvdejveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:cs8KaO8FPvs7M1FTOn236SJatFqTBSy2Jfqow_xvepz4kknUbZi-Iw>
    <xmx:cs8KaBsFVal3wvoNnHTudXUmg_RFaeqmSZhNAMK4oRRqWcqucZqM7w>
    <xmx:cs8KaNEKlBvPSyBF1jwpekRGxkADS4uDmm6d-z3rMq7IvbV9h2P0IQ>
    <xmx:cs8KaIPyCWmOnfzfo_qVmHQyGdrB2dF4oEQgbQ7eaMDy1yKqDVr_vA>
    <xmx:cs8KaFASrJHzhRzlBSKvRZtYqBg9oHCn8p-D9UYD9dslbX084zBVn-BN>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 19:55:30 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: track current commit duration in commit_stats
Date: Thu, 24 Apr 2025 16:56:34 -0700
Message-ID: <6cb65fc2544863eb6b3ca48b094cf7004e06af69.1745538939.git.boris@bur.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When debugging/detecting outlier commit stalls, having an indicator that
we are currently in a long commit critical section can be very useful.
Extend the commit_stats sysfs file to also include the current commit
critical section duration.

Since this requires storing the last commit start time, use that rather
than a separate stack variable for storing the finished commit durations
as well.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/fs.h          |  2 ++
 fs/btrfs/sysfs.c       |  8 ++++++++
 fs/btrfs/transaction.c | 17 +++++++++--------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index bcca43046064..1f375170cdcb 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -419,6 +419,8 @@ struct btrfs_commit_stats {
 	u64 last_commit_dur;
 	/* The total commit duration in ns */
 	u64 total_commit_dur;
+	/* Start of the last critical section in ns. */
+	u64 start_time;
 };
 
 struct btrfs_fs_info {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b9af74498b0c..4e35b4bfffaa 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1138,13 +1138,21 @@ static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
 				       struct kobj_attribute *a, char *buf)
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	u64 now = ktime_get_ns();
+	u64 start_time = fs_info->commit_stats.start_time;
+	u64 pending = 0;
+
+	if (start_time)
+		pending = now - start_time;
 
 	return sysfs_emit(buf,
 		"commits %llu\n"
+		"cur_commit_ms %llu\n"
 		"last_commit_ms %llu\n"
 		"max_commit_ms %llu\n"
 		"total_commit_ms %llu\n",
 		fs_info->commit_stats.commit_count,
+		div_u64(pending, NSEC_PER_MSEC),
 		div_u64(fs_info->commit_stats.last_commit_dur, NSEC_PER_MSEC),
 		div_u64(fs_info->commit_stats.max_commit_dur, NSEC_PER_MSEC),
 		div_u64(fs_info->commit_stats.total_commit_dur, NSEC_PER_MSEC));
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 39e48bf610a1..02e6926d53bd 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2164,13 +2164,19 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
 	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
 }
 
-static void update_commit_stats(struct btrfs_fs_info *fs_info, ktime_t interval)
+static void update_commit_stats(struct btrfs_fs_info *fs_info)
 {
+	ktime_t now = ktime_get_ns();
+	ktime_t interval = now - fs_info->commit_stats.start_time;
+
+	ASSERT(fs_info->commit_stats.start_time);
+
 	fs_info->commit_stats.commit_count++;
 	fs_info->commit_stats.last_commit_dur = interval;
 	fs_info->commit_stats.max_commit_dur =
 			max_t(u64, fs_info->commit_stats.max_commit_dur, interval);
 	fs_info->commit_stats.total_commit_dur += interval;
+	fs_info->commit_stats.start_time = 0;
 }
 
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
@@ -2179,8 +2185,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	struct btrfs_transaction *cur_trans = trans->transaction;
 	struct btrfs_transaction *prev_trans = NULL;
 	int ret;
-	ktime_t start_time;
-	ktime_t interval;
 
 	ASSERT(refcount_read(&trans->use_count) == 1);
 	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
@@ -2314,7 +2318,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * Get the time spent on the work done by the commit thread and not
 	 * the time spent waiting on a previous commit
 	 */
-	start_time = ktime_get_ns();
+	fs_info->commit_stats.start_time = ktime_get_ns();
 
 	extwriter_counter_dec(cur_trans, trans->type);
 
@@ -2568,6 +2572,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	cur_trans->state = TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETED);
+	update_commit_stats(fs_info);
 
 	spin_lock(&fs_info->trans_lock);
 	list_del_init(&cur_trans->list);
@@ -2581,8 +2586,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	trace_btrfs_transaction_commit(fs_info);
 
-	interval = ktime_get_ns() - start_time;
-
 	btrfs_scrub_continue(fs_info);
 
 	if (current->journal_info == trans)
@@ -2590,8 +2593,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
 
-	update_commit_stats(fs_info, interval);
-
 	return ret;
 
 unlock_reloc:
-- 
2.49.0


