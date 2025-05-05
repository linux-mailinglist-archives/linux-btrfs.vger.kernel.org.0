Return-Path: <linux-btrfs+bounces-13659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD367AA97E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 17:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E3117A3E6
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30F25F795;
	Mon,  5 May 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq0Xit3W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E882641FD
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460201; cv=none; b=ubMV4DF7C6cfbd3nP9zoBvbCJ2C3iF5mU6c6TF6HzFcN6bqvZKoH6bC5VvAFXDsgr02j2yG3B+jUOxahJPQHCKYItMwlsS976okYbKUlL9XeDY1RapyBe0nieeDx9+McywBFEzvbVLs+uOq5UEOcQErJUhMpFWnKmVj0hc63WPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460201; c=relaxed/simple;
	bh=x2DiU/elpTVHFabtT0i0O8ihBNjEloceYy3T+kGL7o8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YURV51oPqaHxi8nuchBOd2cFH6j/P1TRkCuK+M/o/M0of9/E7V6GgJgxsvf7uIEGfl7rh1BK12y89BAM5VUFOlC33C761ptjPmjVCrMeonKtObwSadbn/msfyTh78w7skORv7ZbJirHDLxczm7ogKuhy2xKN5DAkCFNmX5vHi9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq0Xit3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA58C4CEEF
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746460201;
	bh=x2DiU/elpTVHFabtT0i0O8ihBNjEloceYy3T+kGL7o8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Eq0Xit3WoEy5m+EhU/qC7GZ+PBJ2pd8MJfT8+jgFfmVD4pj+p3LefBnFo2PLuzCQW
	 dnvobrLVSnyhuhrA4vC29T3Z8qICo8cTJCCKcpUxyPs2sjm8t6IRhXLvAKM2KmT1Hq
	 AGHGarDQgg7jmtGTtdlauFNOPj3+4f9X+jS/TmXsh7S1qveGI5FF9uKHd6egTjnGBF
	 COnbC+b1cU6lc9BStXgB4HxEsK80nYgibJDMRnqG4aaI1kQ77aEp9rsv0X9rT86rXA
	 7nTRiwSStD8ks+qvgDMSN//pSIRXyK2d7ov0ZKtdtDGleMUWQaEW6Nlz5gPLUN6Zcz
	 etk2kB8U7RmBA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix discard worker infinite loop after disabling discard
Date: Mon,  5 May 2025 16:49:55 +0100
Message-Id: <363580a4634fb10d27f167814d9c8fcdb1a89e51.1746460035.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746460035.git.fdmanana@suse.com>
References: <cover.1746460035.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If the discard worker is running and there's currently only one block
group, that block group is a data block group, it's in the unused block
groups discard list and is being used (it got an extent allocated from it
after becoming unused), the worker can end up in an infinite loop if a
transaction abort happens or the async discard is disabled (during remount
or unmount for example).

This happens like this:

1) Task A, the discard worker, is at peek_discard_list() and
   find_next_block_group() returns block group X;

2) Block group X is in the unused block groups discard list (its discard
   index is BTRFS_DISCARD_INDEX_UNUSED) since at some point in the past
   it become an unused block group and was added to that list, but then
   later it got an extent allocated from it, so its ->used counter is not
   zero anymore;

3) The current transaction is aborted by task B and we end up at
   __btrfs_handle_fs_error() in the transaction abort path, where we call
   btrfs_discard_stop(), which clears BTRFS_FS_DISCARD_RUNNING from
   fs_info, and then at __btrfs_handle_fs_error() we set the fs to RO mode
   (setting SB_RDONLY in the super block's s_flags field);

4) Task A calls __add_to_discard_list() with the goal of moving the block
   group from the unused block groups discard list into another discard
   list, but at __add_to_discard_list() we end up doing nothing because
   btrfs_run_discard_work() returns false, since the super block has
   SB_RDONLY set in its flags and BTRFS_FS_DISCARD_RUNNING is not set
   anymore in fs_info->flags. So block group X remains in the unused block
   groups discard list;

5) Task A then does a goto into the 'again' label, calls
   find_next_block_group() again we gets block group X again. Then it
   repeats the previous steps over and over since there are not other
   block groups in the discard lists and block group X is never moved
   out of the unused block groups discard list since
   btrfs_run_discard_work() keeps return false and there
   __add_to_discard_list() doesn't move block group X out of that discard
   list.

When this happens we can get a soft lockup report like this:

   [   71.957163][    C0] watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u4:3:97]
   [   71.957169][    C0] Modules linked in: xfs af_packet rfkill (...)
   [   71.957236][    C0] CPU: 0 UID: 0 PID: 97 Comm: kworker/u4:3 Tainted: G        W          6.14.2-1-default #1 openSUSE Tumbleweed 968795ef2b1407352128b466fe887416c33af6fa
   [   71.957241][    C0] Tainted: [W]=WARN
   [   71.957242][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
   [   71.957244][    C0] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
   [   71.957307][    C0] RIP: 0010:btrfs_discard_workfn+0xc4/0x400 [btrfs]
   [   71.957355][    C0] Code: c1 01 48 83 (...)
   [   71.957357][    C0] RSP: 0018:ffffafaec03efe08 EFLAGS: 00000246
   [   71.957359][    C0] RAX: ffff897045500000 RBX: ffff8970413ed8d0 RCX: 0000000000000000
   [   71.957360][    C0] RDX: 0000000000000001 RSI: ffff8970413ed8d0 RDI: 0000000a8f1272ad
   [   71.957361][    C0] RBP: 0000000a9d61c60e R08: ffff897045500140 R09: 8080808080808080
   [   71.957362][    C0] R10: ffff897040276800 R11: fefefefefefefeff R12: ffff8970413ed860
   [   71.957363][    C0] R13: ffff897045500000 R14: ffff8970413ed868 R15: 0000000000000000
   [   71.957368][    C0] FS:  0000000000000000(0000) GS:ffff89707bc00000(0000) knlGS:0000000000000000
   [   71.957369][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   [   71.957370][    C0] CR2: 00005605bcc8d2f0 CR3: 000000010376a001 CR4: 0000000000770ef0
   [   71.957373][    C0] PKRU: 55555554
   [   71.957374][    C0] Call Trace:
   [   71.957377][    C0]  <TASK>
   [   71.957381][    C0]  process_one_work+0x17e/0x330
   [   71.957386][    C0]  worker_thread+0x2ce/0x3f0
   [   71.957389][    C0]  ? __pfx_worker_thread+0x10/0x10
   [   71.957391][    C0]  kthread+0xef/0x220
   [   71.957394][    C0]  ? __pfx_kthread+0x10/0x10
   [   71.957397][    C0]  ret_from_fork+0x34/0x50
   [   71.957401][    C0]  ? __pfx_kthread+0x10/0x10
   [   71.957403][    C0]  ret_from_fork_asm+0x1a/0x30
   [   71.957410][    C0]  </TASK>
   [   71.957412][    C0] Kernel panic - not syncing: softlockup: hung tasks
   [   71.987152][    C0] CPU: 0 UID: 0 PID: 97 Comm: kworker/u4:3 Tainted: G        W    L     6.14.2-1-default #1 openSUSE Tumbleweed 968795ef2b1407352128b466fe887416c33af6fa
   [   71.989063][    C0] Tainted: [W]=WARN, [L]=SOFTLOCKUP
   [   71.989934][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
   [   71.991832][    C0] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
   [   71.992925][    C0] Call Trace:
   [   71.993601][    C0]  <IRQ>
   [   71.994202][    C0]  dump_stack_lvl+0x5a/0x80
   [   71.994923][    C0]  panic+0x10b/0x2da
   [   71.995582][    C0]  watchdog_timer_fn.cold+0x9a/0xa1
   [   71.996366][    C0]  ? __pfx_watchdog_timer_fn+0x10/0x10
   [   71.997148][    C0]  __hrtimer_run_queues+0x132/0x2a0
   [   71.997913][    C0]  hrtimer_interrupt+0xff/0x230
   [   71.998630][    C0]  __sysvec_apic_timer_interrupt+0x55/0x100
   [   71.999435][    C0]  sysvec_apic_timer_interrupt+0x6c/0x90
   [   72.000208][    C0]  </IRQ>
   [   72.000732][    C0]  <TASK>
   [   72.001250][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
   [   72.002056][    C0] RIP: 0010:btrfs_discard_workfn+0xc4/0x400 [btrfs]
   [   72.002950][    C0] Code: c1 01 48 83 (...)
   [   72.005191][    C0] RSP: 0018:ffffafaec03efe08 EFLAGS: 00000246
   [   72.006011][    C0] RAX: ffff897045500000 RBX: ffff8970413ed8d0 RCX: 0000000000000000
   [   72.006978][    C0] RDX: 0000000000000001 RSI: ffff8970413ed8d0 RDI: 0000000a8f1272ad
   [   72.007939][    C0] RBP: 0000000a9d61c60e R08: ffff897045500140 R09: 8080808080808080
   [   72.008895][    C0] R10: ffff897040276800 R11: fefefefefefefeff R12: ffff8970413ed860
   [   72.009861][    C0] R13: ffff897045500000 R14: ffff8970413ed868 R15: 0000000000000000
   [   72.010825][    C0]  ? btrfs_discard_workfn+0x51/0x400 [btrfs 23b01089228eb964071fb7ca156eee8cd3bf996f]
   [   72.011978][    C0]  process_one_work+0x17e/0x330
   [   72.012663][    C0]  worker_thread+0x2ce/0x3f0
   [   72.013325][    C0]  ? __pfx_worker_thread+0x10/0x10
   [   72.014044][    C0]  kthread+0xef/0x220
   [   72.014647][    C0]  ? __pfx_kthread+0x10/0x10
   [   72.015302][    C0]  ret_from_fork+0x34/0x50
   [   72.015939][    C0]  ? __pfx_kthread+0x10/0x10
   [   72.016592][    C0]  ret_from_fork_asm+0x1a/0x30
   [   72.017281][    C0]  </TASK>
   [   72.017931][    C0] Kernel Offset: 0x15000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
   [   72.019478][    C0] Rebooting in 90 seconds..

So fix this by making sure we move a block group out of the unused block
groups discard list when calling __add_to_discard_list().

Fixes: 2bee7eb8bb81 ("btrfs: discard one region at a time in async discard")
Link: https://bugzilla.suse.com/show_bug.cgi?id=1242012
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/discard.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index d6eef4bd9e9d..de23c4b3515e 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -94,8 +94,6 @@ static void __add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				  struct btrfs_block_group *block_group)
 {
 	lockdep_assert_held(&discard_ctl->lock);
-	if (!btrfs_run_discard_work(discard_ctl))
-		return;
 
 	if (list_empty(&block_group->discard_list) ||
 	    block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
@@ -118,6 +116,9 @@ static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	if (!btrfs_is_block_group_data_only(block_group))
 		return;
 
+	if (!btrfs_run_discard_work(discard_ctl))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 	__add_to_discard_list(discard_ctl, block_group);
 	spin_unlock(&discard_ctl->lock);
@@ -244,6 +245,18 @@ static struct btrfs_block_group *peek_discard_list(
 		    block_group->used != 0) {
 			if (btrfs_is_block_group_data_only(block_group)) {
 				__add_to_discard_list(discard_ctl, block_group);
+				/*
+				 * The block group must have been moved to other
+				 * discard list even if discard was disabled in
+				 * the meantime or a transaction abort happened,
+				 * otherwise we can end up in an infinite loop,
+				 * always jumping into the 'again' label and
+				 * keep getting this block group over and over
+				 * in case there are no other block groups in
+				 * the discard lists.
+				 */
+				ASSERT(block_group->discard_index !=
+				       BTRFS_DISCARD_INDEX_UNUSED);
 			} else {
 				list_del_init(&block_group->discard_list);
 				btrfs_put_block_group(block_group);
-- 
2.47.2


