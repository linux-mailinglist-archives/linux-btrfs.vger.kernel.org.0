Return-Path: <linux-btrfs+bounces-13845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4C3AB0755
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 02:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9041C06D5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 00:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637863B2A0;
	Fri,  9 May 2025 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="uGsZg+r9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FBeBSfUT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B52208AD
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746752046; cv=none; b=pVKCSEYV4CPY8rBc9JTW4DlabvNAiiCColIup6NQbgiamHNmT0KKlJcLU4QSlPCVguJ+AHFsYqKoZ2zLkdIQMCkHgQoeojjsHlWXIdIGzhRLKbfBpRZTYtsHqvIdSSZWnK53OZeW9vCqJQv858AJrQPJPoYBxirxSSXo662/G1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746752046; c=relaxed/simple;
	bh=3cXX8o5Ej1Oa/TeG8n6bz2BiAyZfrVVTt3WOMjhk8eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhSTNEpNMMQPO6omUs5eZ/dkKPSu/kfHFk1Vak7fSX6a339C6pVsgKUzbfltQiu3443+ZFd4ADFFLzXUc5cRHvSDK0ujvTO8OSM3p4JIQYJ0Xdd9EWpnqLEoGxzced6GtOdpWH1Dp3oe9SXOrdS0x3/HNXAEChyKKXoEGEMVi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=uGsZg+r9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FBeBSfUT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A83751140146;
	Thu,  8 May 2025 20:54:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 08 May 2025 20:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1746752041; x=1746838441; bh=8zY6Si9e6FUkDvZQRkXCC
	ZOMunoMKXYOcJjXbMPOJp0=; b=uGsZg+r9HrfuLns5RzAwxJjwl9TtrZ6s+O2ec
	OS/Fkq+9P6JyRcPmF+UyfMvVO2Jpr8JX6iO07NYWYUts9GT7Ziu53HknFPMszndE
	I7UmQB5PevSSipXRwoWsiSVCkl0dSqTdWJc9tvVUWHEDZ9iSYLPLRfrERTP8YbJu
	Xdj/4nfDY/jZHid+xzq468buiBFQwTX0RsuytNWamacNWzTd7i3RWpzDJyUw+4AC
	jICyC071ktQ0diSkth3ZHipeb0/56O4cChk0v8McHfvf3/Qlky59RkJErXDE2PL5
	qZXjKyPzWMj01hjABBepvWOF/ADjBNvrsj/rb9BQP6QkTPu0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746752041; x=1746838441; bh=8zY6Si9e6FUkDvZQRkXCCZOMunoMKXYOcJj
	XbMPOJp0=; b=FBeBSfUTIJCiVeItIgFZDzDeVQuiQtO9IqIbPVQRRYj/0znqRuC
	xAOaPH3v6MquluLMI9eTKey9umMBF57soh0JuEUKe1JqTWYLz1NF1lv3y1fLhgBh
	jvoneMsbS2YsS9ayn6nLoxX+MSCKR+2XOYL1ZdYwXGvFoGTpt+TDyyTlghLLmlot
	GhWnSR6NgtFFJKmb3xavrmopRb5656j+p9ZN+zZmdKd57dG//iBCbHNcnEQGb1JN
	YgYwMC1hcP49PokhVEcHpUkupcLmUUM2WiayO+z9g6lhHOZLiSeAEwhFlJ/rO8yB
	bA+j9rCcBTj9TC0BTcsh/ug8YT11bShQ5Uw==
X-ME-Sender: <xms:KFIdaMWruMiHSLfWAwchAOP7ShiLdK8JeFPO4sl069yZxcSTkCQIsQ>
    <xme:KFIdaAk9htiGjndN8yeq-_ikXZ5qYcqKVmvAQqnUis4h6irqU9ZrXLD_f8IDRD8lp
    Te3Oxu6ryfOA8bvjLc>
X-ME-Received: <xmr:KFIdaAZrqtVi6GrazX22o5Dzhw3n7sX7tbiplK-Xc928TjQ_dbY1p_wf0D2UXjwhek6iYQ2Ad07XAPKJc_qUrHFeSpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcu
    oegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudduhfevvddugffgge
    fgkeeggfdvieejgfegkedvudetkeehhfdvffeugeevfedunecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhig
    qdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvg
    hlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgt
    ii
X-ME-Proxy: <xmx:KFIdaLVhIjjJM1MQL5RLvxBFsnqWF_BV8HMovKdpOJXcg50thzNoHA>
    <xmx:KFIdaGn8iw8GIHM_PsnlRhBMm00D3GQWBu5WGIbMsNDL3ylwXLNYVg>
    <xmx:KFIdaAdrE6Op9lvGk7Y_-_Gvu1L8sszgAlWfJNIRfvEG1XhmsLtqJw>
    <xmx:KFIdaIFtfhDJ8Uwfqp80uHttpVFXJiZn3IHn6cTCZPIM0z3Y5u-Crw>
    <xmx:KVIdaFGK-BrDuuIfRoVJ7G6KG43GbfuEMdL1P7BrMzBPtY8r6_jTG9ie>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 20:54:00 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: dsterba@suse.cz
Subject: [PATCH v2] btrfs: track current commit duration in commit_stats
Date: Thu,  8 May 2025 17:54:41 -0700
Message-ID: <9ef37010df953138ae847e6d5e8ba12847321036.1746751867.git.boris@bur.io>
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

This also requires slightly moving up the timing of the stats updating
to *inside* the critical section to avoid the transaction T+1 setting
the critical_section_start_time to 0 before transaction T can update its
stats, which would trigger the new ASSERT. This is an improvement in and
of itself, as it makes the stats more accurately represent the true
critical section time. It may be yet better to pull the stats up to where
start_transaction gets unblocked, rather than the next commit, but this
seems like a good enough place as well.

Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
* Fix ASSERT triggered by multiple commits interleaving s.t. commit T+1
  reset the start time set by commit T before T could update the stats.
* Rename commit_stats variable to critical_section_start_time to
  differentiate from cur_trans->start_time.

 fs/btrfs/fs.h          |  2 ++
 fs/btrfs/sysfs.c       |  8 ++++++++
 fs/btrfs/transaction.c | 18 +++++++++---------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index cf805b4032af..6ae6203d2b9e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -419,6 +419,8 @@ struct btrfs_commit_stats {
 	u64 last_commit_dur;
 	/* The total commit duration in ns */
 	u64 total_commit_dur;
+	/* Start of the last critical section in ns. */
+	u64 critical_section_start_time;
 };
 
 struct btrfs_fs_info {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5d93d9dd2c12..04715201c643 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1138,13 +1138,21 @@ static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
 				       struct kobj_attribute *a, char *buf)
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	u64 now = ktime_get_ns();
+	u64 start_time = fs_info->commit_stats.critical_section_start_time;
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
index b96195d6480f..b518a6c3517b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2163,13 +2163,19 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
 	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
 }
 
-static void update_commit_stats(struct btrfs_fs_info *fs_info, ktime_t interval)
+static void update_commit_stats(struct btrfs_fs_info *fs_info)
 {
+	ktime_t now = ktime_get_ns();
+	ktime_t interval = now - fs_info->commit_stats.critical_section_start_time;
+
+	ASSERT(fs_info->commit_stats.critical_section_start_time);
+
 	fs_info->commit_stats.commit_count++;
 	fs_info->commit_stats.last_commit_dur = interval;
 	fs_info->commit_stats.max_commit_dur =
 			max_t(u64, fs_info->commit_stats.max_commit_dur, interval);
 	fs_info->commit_stats.total_commit_dur += interval;
+	fs_info->commit_stats.critical_section_start_time = 0;
 }
 
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
@@ -2178,8 +2184,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	struct btrfs_transaction *cur_trans = trans->transaction;
 	struct btrfs_transaction *prev_trans = NULL;
 	int ret;
-	ktime_t start_time;
-	ktime_t interval;
 
 	ASSERT(refcount_read(&trans->use_count) == 1);
 	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
@@ -2312,8 +2316,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * Get the time spent on the work done by the commit thread and not
 	 * the time spent waiting on a previous commit
 	 */
-	start_time = ktime_get_ns();
-
+	fs_info->commit_stats.critical_section_start_time = ktime_get_ns();
 	extwriter_counter_dec(cur_trans, trans->type);
 
 	ret = btrfs_start_delalloc_flush(fs_info);
@@ -2545,6 +2548,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	if (ret)
 		goto scrub_continue;
 
+	update_commit_stats(fs_info);
 	/*
 	 * We needn't acquire the lock here because there is no other task
 	 * which can change it.
@@ -2581,8 +2585,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	trace_btrfs_transaction_commit(fs_info);
 
-	interval = ktime_get_ns() - start_time;
-
 	btrfs_scrub_continue(fs_info);
 
 	if (current->journal_info == trans)
@@ -2590,8 +2592,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
 
-	update_commit_stats(fs_info, interval);
-
 	return ret;
 
 unlock_reloc:
-- 
2.49.0


