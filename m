Return-Path: <linux-btrfs+bounces-20406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EA9D137EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A31B03136FB1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5264A2DCF6C;
	Mon, 12 Jan 2026 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvFuzqfJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25C2DEA8C;
	Mon, 12 Jan 2026 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229928; cv=none; b=eVGgn8S0aX7lnSwRsuBgfSoNXeyAq48tMLadgCbyyBoG6g6K6RvuRBjmdHNcsiTeF5t+KOfYTqDzXMucJojwyhdCkuh3ZxJ5/At1iWFfRCvuHaxI9+PIYH1jBlA8daAtD5bwEdC6nxzivm8oASSeIYyT22ib4zL1YAT//lVJpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229928; c=relaxed/simple;
	bh=9ufFQrLplOWQaQsN4QFutvJ+PkbTL1HroOqWQdJrCUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaYxISMfMizw57ls0S6l+m8KkvSA775EEoJ+0h3UYLyhUDPCG4FxyD35fR3a7TTFYLE2v2TCOwkyqYtg/ufSs8oTNEMt6UCxXX/CkYst3iVhanh9oXwPWhOT6qy9fXl2wzYr9RijEhzluXhRzVciqpKM9YzgXOCTwC6c5n1uGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvFuzqfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17682C16AAE;
	Mon, 12 Jan 2026 14:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229927;
	bh=9ufFQrLplOWQaQsN4QFutvJ+PkbTL1HroOqWQdJrCUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvFuzqfJNQNNmyPtsDLCYuVR3S8tCXfKYFgdU2rjZQQwkFCGHpU//+wGHDpLoaLI2
	 NeIAFWxDDQ0TjsFG3q+jl0e1K0eQ7YnkCLeYnPRNXOGvycWsrO1TN6030I4XxGy3pO
	 SbvkgKc2d8e0apQjON5kfeWFs5cHHPI2QcLXRZT6KPpiPMCnl4hNVTMmwtWtw+quMv
	 P/NWGMbKnQOigPH5XFrVSNWF6FCAlkiB1LTejT+wyaKQqPTxNJJGBwYDlGIbk4cvtq
	 VASIjc5VzA1KjtFhJlr2/JCP2/TWilmWBSWH1zSuyZ1y/xi8btQkwnWNKM5rgypuqc
	 Ank2auTBHm+kA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] btrfs: fix deadlock in wait_current_trans() due to ignored transaction type
Date: Mon, 12 Jan 2026 09:58:06 -0500
Message-ID: <20260112145840.724774-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112145840.724774-1-sashal@kernel.org>
References: <20260112145840.724774-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Robbie Ko <robbieko@synology.com>

[ Upstream commit 5037b342825df7094a4906d1e2a9674baab50cb2 ]

When wait_current_trans() is called during start_transaction(), it
currently waits for a blocked transaction without considering whether
the given transaction type actually needs to wait for that particular
transaction state. The btrfs_blocked_trans_types[] array already defines
which transaction types should wait for which transaction states, but
this check was missing in wait_current_trans().

This can lead to a deadlock scenario involving two transactions and
pending ordered extents:

  1. Transaction A is in TRANS_STATE_COMMIT_DOING state

  2. A worker processing an ordered extent calls start_transaction()
     with TRANS_JOIN

  3. join_transaction() returns -EBUSY because Transaction A is in
     TRANS_STATE_COMMIT_DOING

  4. Transaction A moves to TRANS_STATE_UNBLOCKED and completes

  5. A new Transaction B is created (TRANS_STATE_RUNNING)

  6. The ordered extent from step 2 is added to Transaction B's
     pending ordered extents

  7. Transaction B immediately starts commit by another task and
     enters TRANS_STATE_COMMIT_START

  8. The worker finally reaches wait_current_trans(), sees Transaction B
     in TRANS_STATE_COMMIT_START (a blocked state), and waits
     unconditionally

  9. However, TRANS_JOIN should NOT wait for TRANS_STATE_COMMIT_START
     according to btrfs_blocked_trans_types[]

  10. Transaction B is waiting for pending ordered extents to complete

  11. Deadlock: Transaction B waits for ordered extent, ordered extent
      waits for Transaction B

This can be illustrated by the following call stacks:
  CPU0                              CPU1
                                    btrfs_finish_ordered_io()
                                      start_transaction(TRANS_JOIN)
                                        join_transaction()
                                          # -EBUSY (Transaction A is
                                          # TRANS_STATE_COMMIT_DOING)
  # Transaction A completes
  # Transaction B created
  # ordered extent added to
  # Transaction B's pending list
  btrfs_commit_transaction()
    # Transaction B enters
    # TRANS_STATE_COMMIT_START
    # waiting for pending ordered
    # extents
                                        wait_current_trans()
                                          # waits for Transaction B
                                          # (should not wait!)

Task bstore_kv_sync in btrfs_commit_transaction waiting for ordered
extents:

  __schedule+0x2e7/0x8a0
  schedule+0x64/0xe0
  btrfs_commit_transaction+0xbf7/0xda0 [btrfs]
  btrfs_sync_file+0x342/0x4d0 [btrfs]
  __x64_sys_fdatasync+0x4b/0x80
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Task kworker in wait_current_trans waiting for transaction commit:

  Workqueue: btrfs-syno_nocow btrfs_work_helper [btrfs]
  __schedule+0x2e7/0x8a0
  schedule+0x64/0xe0
  wait_current_trans+0xb0/0x110 [btrfs]
  start_transaction+0x346/0x5b0 [btrfs]
  btrfs_finish_ordered_io.isra.0+0x49b/0x9c0 [btrfs]
  btrfs_work_helper+0xe8/0x350 [btrfs]
  process_one_work+0x1d3/0x3c0
  worker_thread+0x4d/0x3e0
  kthread+0x12d/0x150
  ret_from_fork+0x1f/0x30

Fix this by passing the transaction type to wait_current_trans() and
checking btrfs_blocked_trans_types[cur_trans->state] against the given
type before deciding to wait. This ensures that transaction types which
are allowed to join during certain blocked states will not unnecessarily
wait and cause deadlocks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## COMPREHENSIVE ANALYSIS

### What the Bug Is

The deadlock occurs because `wait_current_trans()` ignores the
transaction type when deciding whether to wait:

1. `join_transaction()` correctly uses
   `btrfs_blocked_trans_types[cur_trans->state] & type` to return
   `-EBUSY`
2. But `wait_current_trans()` waits **unconditionally** whenever a
   transaction is blocked

Looking at `btrfs_blocked_trans_types[]`:
- `TRANS_STATE_COMMIT_START` only blocks `__TRANS_START |
  __TRANS_ATTACH`
- `__TRANS_JOIN` is NOT blocked during `TRANS_STATE_COMMIT_START`

The deadlock: `TRANS_JOIN` from ordered extent processing waits for a
transaction in `COMMIT_START` state (which it shouldn't), while that
transaction waits for the ordered extent to complete.

### Technical Assessment

**The Fix:**
- Adds `type` parameter to `wait_current_trans()`
- Adds check: `btrfs_blocked_trans_types[cur_trans->state] & type`
- Updates 3 call sites to pass the type

**Lines of actual change**: ~6 lines of logic change
**Files changed**: 1 (fs/btrfs/transaction.c)
**Risk level**: LOW - the fix makes behavior *more restrictive* about
when to wait, aligning with already-defined semantics

### Stable Kernel Criteria Assessment

| Criterion | Assessment |
|-----------|------------|
| Obviously correct? | ✅ Yes - aligns `wait_current_trans()` with
existing `btrfs_blocked_trans_types[]` semantics |
| Fixes real bug? | ✅ Yes - deadlock with real call stacks provided |
| Important issue? | ✅ Yes - deadlock is severe (system hang, potential
data loss) |
| Small and contained? | ✅ Yes - ~6 lines logic change in one file |
| No new features? | ✅ Correct - pure bug fix |
| Dependencies in stable? | ✅ Yes - `btrfs_blocked_trans_types[]` exists
since 2013 |

### Review Quality

- Reviewed-by: Filipe Manana (btrfs maintainer)
- Reviewed-by: David Sterba (btrfs maintainer)
- Signed-off-by: David Sterba (merged by maintainer)

### User Impact

- **Severity**: HIGH - deadlock causes complete hang
- **Affected users**: btrfs users with ordered extent workloads (common
  during fsync)
- **Evidence**: Real production call stacks provided from Synology
  system

### Risk vs Benefit

**Benefits:**
- Fixes a critical deadlock in filesystem code
- Small, surgical change with minimal risk
- Uses existing, well-tested infrastructure

**Risks:**
- Very low - the change only affects waiting behavior and aligns it with
  already-existing type-specific blocking rules
- The fix is conservative: it makes the code wait *less* (only when it
  should), not more

### Conclusion

This commit fixes a **real deadlock** in btrfs transaction handling. The
fix is:
- Small and surgical
- Obviously correct (makes `wait_current_trans()` respect existing type-
  specific blocking rules)
- Well-reviewed by btrfs maintainers
- Low risk with high benefit

The `btrfs_blocked_trans_types[]` array has existed since 2013, ensuring
clean backporting to all stable kernels. This is exactly the type of
commit that should be backported - a critical deadlock fix with minimal
risk.

**YES**

 fs/btrfs/transaction.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 89ae0c7a610aa..c457316c2788b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -518,13 +518,14 @@ static inline int is_transaction_blocked(struct btrfs_transaction *trans)
  * when this is done, it is safe to start a new transaction, but the current
  * transaction might not be fully on disk.
  */
-static void wait_current_trans(struct btrfs_fs_info *fs_info)
+static void wait_current_trans(struct btrfs_fs_info *fs_info, unsigned int type)
 {
 	struct btrfs_transaction *cur_trans;
 
 	spin_lock(&fs_info->trans_lock);
 	cur_trans = fs_info->running_transaction;
-	if (cur_trans && is_transaction_blocked(cur_trans)) {
+	if (cur_trans && is_transaction_blocked(cur_trans) &&
+	    (btrfs_blocked_trans_types[cur_trans->state] & type)) {
 		refcount_inc(&cur_trans->use_count);
 		spin_unlock(&fs_info->trans_lock);
 
@@ -699,12 +700,12 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		sb_start_intwrite(fs_info->sb);
 
 	if (may_wait_transaction(fs_info, type))
-		wait_current_trans(fs_info);
+		wait_current_trans(fs_info, type);
 
 	do {
 		ret = join_transaction(fs_info, type);
 		if (ret == -EBUSY) {
-			wait_current_trans(fs_info);
+			wait_current_trans(fs_info, type);
 			if (unlikely(type == TRANS_ATTACH ||
 				     type == TRANS_JOIN_NOSTART))
 				ret = -ENOENT;
@@ -1001,7 +1002,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 
 void btrfs_throttle(struct btrfs_fs_info *fs_info)
 {
-	wait_current_trans(fs_info);
+	wait_current_trans(fs_info, TRANS_START);
 }
 
 bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
-- 
2.51.0


