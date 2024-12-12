Return-Path: <linux-btrfs+bounces-10291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DE39EE0A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA0A167C72
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B1420B7FE;
	Thu, 12 Dec 2024 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cIku0xaK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cIku0xaK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C02010F2;
	Thu, 12 Dec 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990037; cv=none; b=tgyu+Tp7zIyMTptnGMS0/12tOZ0gDuVQfmJApcamRFuj0bn/4/0hc46Thve6A7hxkNObFyfIYtSVaBYxjXPh4stV292itXYxsFtCiey76iKGchFfkWhtLkjxj29MZD4KlxZd50OMNZnGwKIZe7ERjjTKTkdoGtVzcaWeQyWuq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990037; c=relaxed/simple;
	bh=nSQSR2OE56OEdq4AS7bfxaaeFVSSkQvMdKJ/XkDrAj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALN8u8/0CySyDzhtKwLORT6sloSCq+OKOPSjQjY5WBUM3U/ug9tEev+GtUc+d5PqQCvLyoTsnAU/fUNqCk4lQ5LQ3r5qmHFCCrekKYVvYxjCrrF3EQBYpaNwRIDXQezFzJsfIgx7Mys3hij0JCHrpkEwsJvnkaWUVejjp4WimcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cIku0xaK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cIku0xaK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A823210F9;
	Thu, 12 Dec 2024 07:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733990032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SElNGVPU1HJwt+KS5yfQ+MDIq0++r3tNvtmwYphPTo8=;
	b=cIku0xaKGUDlDuR9qRsAOA/tZGzs4l+zvsc8yGEQylFq+CEe7Q6fyyVXjrxetcgvmgAbmn
	2ofSiMNT4M27bNg5K8g5TaJpmkAoGxD+o+tollancXVED5jkyyrpO8sqiZUCVe3KIWGyeQ
	LEvWSSB4LIVPQ+YCGUH2hRtnTpgY6vE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cIku0xaK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733990032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SElNGVPU1HJwt+KS5yfQ+MDIq0++r3tNvtmwYphPTo8=;
	b=cIku0xaKGUDlDuR9qRsAOA/tZGzs4l+zvsc8yGEQylFq+CEe7Q6fyyVXjrxetcgvmgAbmn
	2ofSiMNT4M27bNg5K8g5TaJpmkAoGxD+o+tollancXVED5jkyyrpO8sqiZUCVe3KIWGyeQ
	LEvWSSB4LIVPQ+YCGUH2hRtnTpgY6vE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5746C13508;
	Thu, 12 Dec 2024 07:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WPPPFJCWWmfMbwAAD6G6ig
	(envelope-from <neelx@suse.com>); Thu, 12 Dec 2024 07:53:52 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Omar Sandoval <osandov@fb.com>
Cc: Daniel Vacek <neelx@suse.com>,
	stable@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] btrfs: fix a race in encoded read
Date: Thu, 12 Dec 2024 08:53:02 +0100
Message-ID: <20241212075303.2538880-1-neelx@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A823210F9
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

While testing the encoded read feature the following crash was observed
and it can be reliably reproduced:

[ 2916.441731] Oops: general protection fault, probably for non-canonical address 0xa3f64e06d5eee2c7: 0000 [#1] PREEMPT_RT SMP NOPTI
[ 2916.441736] CPU: 5 UID: 0 PID: 592 Comm: kworker/u38:4 Kdump: loaded Not tainted 6.13.0-rc1+ #4
[ 2916.441739] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 2916.441740] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
[ 2916.441777] RIP: 0010:__wake_up_common+0x29/0xa0
[ 2916.441808] RSP: 0018:ffffaaec0128fd80 EFLAGS: 00010216
[ 2916.441810] RAX: 0000000000000001 RBX: ffff95a6429cf020 RCX: 0000000000000000
[ 2916.441811] RDX: a3f64e06d5eee2c7 RSI: 0000000000000003 RDI: ffff95a6429cf000
                    ^^^^^^^^^^^^^^^^
                    This comes from `priv->wait.head.next`

[ 2916.441823] Call Trace:
[ 2916.441833]  <TASK>
[ 2916.441881]  ? __wake_up_common+0x29/0xa0
[ 2916.441883]  __wake_up_common_lock+0x37/0x60
[ 2916.441887]  btrfs_encoded_read_endio+0x73/0x90 [btrfs]  <<< UAF of `priv` object,
[ 2916.441921]  btrfs_check_read_bio+0x321/0x500 [btrfs]        details below.
[ 2916.441947]  process_scheduled_works+0xc1/0x410
[ 2916.441960]  worker_thread+0x105/0x240

crash> btrfs_encoded_read_private.wait.head ffff95a6429cf000	# `priv` from RDI ^^
  wait.head = {
    next = 0xa3f64e06d5eee2c7,	# Corrupted as the object was already freed/reused.
    prev = 0xffff95a6429cf020	# Stale data still point to itself (`&priv->wait.head`
  }				  also in RBX ^^) ie. the list was free.

Possibly, this is easier (or even only?) reproducible on preemptible kernel.
It just happened to build an RT kernel for additional testing coverage.
Enabling slab debug gives us further related details, mostly confirming
what's expected:

[11:23:07] =============================================================================
[11:23:07] BUG kmalloc-64 (Not tainted): Poison overwritten
[11:23:07] -----------------------------------------------------------------------------

[11:23:07] 0xffff8fc7c5b6b542-0xffff8fc7c5b6b543 @offset=5442. First byte 0x4 instead of 0x6b
                            ^
     That makes two bytes into the `priv->wait.lock`

[11:23:07] FIX kmalloc-64: Restoring Poison 0xffff8fc7c5b6b542-0xffff8fc7c5b6b543=0x6b
[11:23:07] Allocated in btrfs_encoded_read_regular_fill_pages+0x5e/0x260 [btrfs] age=4 cpu=0 pid=18295
[11:23:07]  __kmalloc_cache_noprof+0x81/0x2a0
[11:23:07]  btrfs_encoded_read_regular_fill_pages+0x5e/0x260 [btrfs]
[11:23:07]  btrfs_encoded_read_regular+0xee/0x200 [btrfs]
[11:23:07]  btrfs_ioctl_encoded_read+0x477/0x600 [btrfs]
[11:23:07]  btrfs_ioctl+0xefe/0x2a00 [btrfs]
[11:23:07]  __x64_sys_ioctl+0xa3/0xc0
[11:23:07]  do_syscall_64+0x74/0x180
[11:23:07]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

  9121  	unsigned long i = 0;
  9122  	struct btrfs_bio *bbio;
  9123  	int ret;
  9124
* 9125  	priv = kmalloc(sizeof(struct btrfs_encoded_read_private), GFP_NOFS);
  9126  	if (!priv)
  9127  		return -ENOMEM;
  9128
  9129  	init_waitqueue_head(&priv->wait);

[11:23:07] Freed in btrfs_encoded_read_regular_fill_pages+0x1f9/0x260 [btrfs] age=4 cpu=0 pid=18295
[11:23:07]  btrfs_encoded_read_regular_fill_pages+0x1f9/0x260 [btrfs]
[11:23:07]  btrfs_encoded_read_regular+0xee/0x200 [btrfs]
[11:23:07]  btrfs_ioctl_encoded_read+0x477/0x600 [btrfs]
[11:23:07]  btrfs_ioctl+0xefe/0x2a00 [btrfs]
[11:23:07]  __x64_sys_ioctl+0xa3/0xc0
[11:23:07]  do_syscall_64+0x74/0x180
[11:23:07]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

  9171  		if (atomic_dec_return(&priv->pending) != 0)
  9172  			io_wait_event(priv->wait, !atomic_read(&priv->pending));
  9173  		/* See btrfs_encoded_read_endio() for ordering. */
  9174  		ret = blk_status_to_errno(READ_ONCE(priv->status));
* 9175  		kfree(priv);
  9176  		return ret;
  9177  	}
  9178  }

`priv` was freed here but then after that it was further used. The report
is comming soon after, see below. Note that the report is a few seconds
delayed by the RCU stall timeout. (It is the same example as with the
GPF crash above, just that one was reported right away without any delay).

Due to the poison this time instead of the GPF exception as observed above
the UAF caused a CPU hard lockup (reported by the RCU stall check as this
was a VM):

[11:23:28] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[11:23:28] rcu:         0-...!: (1 GPs behind) idle=48b4/1/0x4000000000000000 softirq=0/0 fqs=5 rcuc=5254 jiffies(starved)
[11:23:28] rcu:         (detected by 1, t=5252 jiffies, g=1631241, q=250054 ncpus=8)
[11:23:28] Sending NMI from CPU 1 to CPUs 0:
[11:23:28] NMI backtrace for cpu 0
[11:23:28] CPU: 0 UID: 0 PID: 21445 Comm: kworker/u33:3 Kdump: loaded Tainted: G    B              6.13.0-rc1+ #4
[11:23:28] Tainted: [B]=BAD_PAGE
[11:23:28] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[11:23:28] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
[11:23:28] RIP: 0010:native_halt+0xa/0x10
[11:23:28] RSP: 0018:ffffb42ec277bc48 EFLAGS: 00000046
[11:23:28] Call Trace:
[11:23:28]  <TASK>
[11:23:28]  kvm_wait+0x53/0x60
[11:23:28]  __pv_queued_spin_lock_slowpath+0x2ea/0x350
[11:23:28]  _raw_spin_lock_irq+0x2b/0x40
[11:23:28]  rtlock_slowlock_locked+0x1f3/0xce0
[11:23:28]  rt_spin_lock+0x7b/0xb0
[11:23:28]  __wake_up_common_lock+0x23/0x60
[11:23:28]  btrfs_encoded_read_endio+0x73/0x90 [btrfs]  <<< UAF of `priv` object.
[11:23:28]  btrfs_check_read_bio+0x321/0x500 [btrfs]
[11:23:28]  process_scheduled_works+0xc1/0x410
[11:23:28]  worker_thread+0x105/0x240

  9105  		if (priv->uring_ctx) {
  9106  			int err = blk_status_to_errno(READ_ONCE(priv->status));
  9107  			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
  9108  			kfree(priv);
  9109  		} else {
* 9110  			wake_up(&priv->wait);	<<< So we know UAF/GPF happens here.
  9111  		}
  9112  	}
  9113  	bio_put(&bbio->bio);

Now, the wait queue here does not really guarantee a proper
synchronization between `btrfs_encoded_read_regular_fill_pages()`
and `btrfs_encoded_read_endio()` which eventually results in various
use-afer-free effects like general protection fault or CPU hard lockup.

Using plain wait queue without additional instrumentation on top of the
`pending` counter is simply insufficient in this context. The reason wait
queue fails here is because the lifespan of that structure is only within
the `btrfs_encoded_read_regular_fill_pages()` function. In such a case
plain wait queue cannot be used to synchronize for it's own destruction.

Fix this by correctly using completion instead.

Also, while the lifespan of the structures in sync case is strictly
limited within the `..._fill_pages()` function, there is no need to
allocate from slab. Stack can be safely used instead.

Fixes: 1881fba89bd5 ("btrfs: add BTRFS_IOC_ENCODED_READ ioctl")
CC: stable@vger.kernel.org # 5.18+
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/inode.c | 62 ++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fa648ab6fe806..61e0fd5c6a15f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9078,7 +9078,7 @@ static ssize_t btrfs_encoded_read_inline(
 }
 
 struct btrfs_encoded_read_private {
-	wait_queue_head_t wait;
+	struct completion *sync_read;
 	void *uring_ctx;
 	atomic_t pending;
 	blk_status_t status;
@@ -9090,23 +9090,22 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 
 	if (bbio->bio.bi_status) {
 		/*
-		 * The memory barrier implied by the atomic_dec_return() here
-		 * pairs with the memory barrier implied by the
-		 * atomic_dec_return() or io_wait_event() in
-		 * btrfs_encoded_read_regular_fill_pages() to ensure that this
-		 * write is observed before the load of status in
-		 * btrfs_encoded_read_regular_fill_pages().
+		 * The memory barrier implied by the
+		 * atomic_dec_and_test() here pairs with the memory
+		 * barrier implied by the atomic_dec_and_test() in
+		 * btrfs_encoded_read_regular_fill_pages() to ensure
+		 * that this write is observed before the load of
+		 * status in btrfs_encoded_read_regular_fill_pages().
 		 */
 		WRITE_ONCE(priv->status, bbio->bio.bi_status);
 	}
 	if (atomic_dec_and_test(&priv->pending)) {
-		int err = blk_status_to_errno(READ_ONCE(priv->status));
-
 		if (priv->uring_ctx) {
+			int err = blk_status_to_errno(READ_ONCE(priv->status));
 			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
 			kfree(priv);
 		} else {
-			wake_up(&priv->wait);
+			complete(priv->sync_read);
 		}
 	}
 	bio_put(&bbio->bio);
@@ -9117,16 +9116,21 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  struct page **pages, void *uring_ctx)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_encoded_read_private *priv;
+	struct completion sync_read;
+	struct btrfs_encoded_read_private sync_priv, *priv;
 	unsigned long i = 0;
 	struct btrfs_bio *bbio;
-	int ret;
 
-	priv = kmalloc(sizeof(struct btrfs_encoded_read_private), GFP_NOFS);
-	if (!priv)
-		return -ENOMEM;
+	if (uring_ctx) {
+		priv = kmalloc(sizeof(struct btrfs_encoded_read_private), GFP_NOFS);
+		if (!priv)
+			return -ENOMEM;
+	} else {
+		priv = &sync_priv;
+		init_completion(&sync_read);
+		priv->sync_read = &sync_read;
+	}
 
-	init_waitqueue_head(&priv->wait);
 	atomic_set(&priv->pending, 1);
 	priv->status = 0;
 	priv->uring_ctx = uring_ctx;
@@ -9158,23 +9162,23 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	atomic_inc(&priv->pending);
 	btrfs_submit_bbio(bbio, 0);
 
-	if (uring_ctx) {
-		if (atomic_dec_return(&priv->pending) == 0) {
-			ret = blk_status_to_errno(READ_ONCE(priv->status));
-			btrfs_uring_read_extent_endio(uring_ctx, ret);
+	if (atomic_dec_and_test(&priv->pending)) {
+		if (uring_ctx) {
+			int err = blk_status_to_errno(READ_ONCE(priv->status));
+			btrfs_uring_read_extent_endio(uring_ctx, err);
 			kfree(priv);
-			return ret;
+			return err;
+		} else {
+			complete(&sync_read);
 		}
+	}
 
+	if (uring_ctx)
 		return -EIOCBQUEUED;
-	} else {
-		if (atomic_dec_return(&priv->pending) != 0)
-			io_wait_event(priv->wait, !atomic_read(&priv->pending));
-		/* See btrfs_encoded_read_endio() for ordering. */
-		ret = blk_status_to_errno(READ_ONCE(priv->status));
-		kfree(priv);
-		return ret;
-	}
+
+	wait_for_completion_io(&sync_read);
+	/* See btrfs_encoded_read_endio() for ordering. */
+	return blk_status_to_errno(READ_ONCE(priv->status));
 }
 
 ssize_t btrfs_encoded_read_regular(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.45.2


