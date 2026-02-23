Return-Path: <linux-btrfs+bounces-21837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMCTLpdLnGnYDQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21837-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 13:44:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E181765A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 13:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCDBD311A90E
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B0C366DBE;
	Mon, 23 Feb 2026 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxq2xMUE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242036654A;
	Mon, 23 Feb 2026 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850286; cv=none; b=rals67YXxfisVNxBtyBzPlpAZ2nk1VlePf/WN/E7OoF9+5gHZF3lYusQ1XNgr7CLMt00UXYpEXkxylk0dyFpkwdZ231hS8BXAVIZJ241WHQDzmK843aU7cV6G9UPbsG6ufQC1Dq6TXL4QChGgOX8ksCN7ERn0ajkWqedqIF8Y+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850286; c=relaxed/simple;
	bh=EfL1zGl01oo4GS5HNkMgV5OVgLXxYcXRoLCBrmlcPQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=libWlfT2u/2mvZCf+SzuDh6c+siOYJuA1MtQlJ+eI9e5DD3PGyLWQTvRPIv8zjickHWWrA+bv98doA0GStO8AmkMyfxQS0Aqb7iFrwphuEQl3IX3HuoE3ErhoHJJ/tvL4Yslh+m3h0NunL/w/2g+G+8CkQ/NqQNMOBkgnG4oZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxq2xMUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAABC2BC86;
	Mon, 23 Feb 2026 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771850286;
	bh=EfL1zGl01oo4GS5HNkMgV5OVgLXxYcXRoLCBrmlcPQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dxq2xMUEYjAP/TINOt3M+vG1ghNlYHGqZr060RjoAFlI/Fusv6dCUJwN5XKwBepyI
	 PfDeeFPQUzm0f7aQwnDn2iXaufuEXQgDpp6bvgTUKItygIJ6XhcIYU42neJBLC/1fX
	 HE0iZhSUKiw4QpMHVOUdDImqGuVXURm5eb/ySKYKyZbdo88GPBNX5sj3q78eHxM+qZ
	 NqSU8rSE0pBPcyburmBqux65U3EfPLxDCfjYydDX5nw+xsrXY3kHXSHFK4Pv1tYg4G
	 qnRZCSFTmlgWMpfrRV18oinWygTgAexv52YGJ8e3WsKez/yjxz23uCJdYXAOIG4/ZL
	 G16nAeB1tC/5A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] btrfs: do not ASSERT() when the fs flips RO inside btrfs_repair_io_failure()
Date: Mon, 23 Feb 2026 07:37:23 -0500
Message-ID: <20260223123738.1532940-18-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21837-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qemu.org:url,lst.de:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13E181765A4
X-Rspamd-Action: no action

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 8ceaad6cd6e7fa5f73b0b2796a2e85d75d37e9f3 ]

[BUG]
There is a bug report that when btrfs hits ENOSPC error in a critical
path, btrfs flips RO (this part is expected, although the ENOSPC bug
still needs to be addressed).

The problem is after the RO flip, if there is a read repair pending, we
can hit the ASSERT() inside btrfs_repair_io_failure() like the following:

  BTRFS info (device vdc): relocating block group 30408704 flags metadata|raid1
  ------------[ cut here ]------------
  BTRFS: Transaction aborted (error -28)
  WARNING: fs/btrfs/extent-tree.c:3235 at __btrfs_free_extent.isra.0+0x453/0xfd0, CPU#1: btrfs/383844
  Modules linked in: kvm_intel kvm irqbypass
  [...]
  ---[ end trace 0000000000000000 ]---
  BTRFS info (device vdc state EA): 2 enospc errors during balance
  BTRFS info (device vdc state EA): balance: ended with status: -30
  BTRFS error (device vdc state EA): parent transid verify failed on logical 30556160 mirror 2 wanted 8 found 6
  BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
  [...]
  assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
  ------------[ cut here ]------------
  assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
  kernel BUG at fs/btrfs/bio.c:938!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 868 Comm: kworker/u8:13 Tainted: G        W        N  6.19.0-rc6+ #4788 PREEMPT(full)
  Tainted: [W]=WARN, [N]=TEST
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  Workqueue: btrfs-endio simple_end_io_work
  RIP: 0010:btrfs_repair_io_failure.cold+0xb2/0x120
  RSP: 0000:ffffc90001d2bcf0 EFLAGS: 00010246
  RAX: 0000000000000051 RBX: 0000000000001000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffffffff8305cf42 RDI: 00000000ffffffff
  RBP: 0000000000000002 R08: 00000000fffeffff R09: ffffffff837fa988
  R10: ffffffff8327a9e0 R11: 6f69747265737361 R12: ffff88813018d310
  R13: ffff888168b8a000 R14: ffffc90001d2bd90 R15: ffff88810a169000
  FS:  0000000000000000(0000) GS:ffff8885e752c000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  ------------[ cut here ]------------

[CAUSE]
The cause of -ENOSPC error during the test case btrfs/124 is still
unknown, although it's known that we still have cases where metadata can
be over-committed but can not be fulfilled correctly, thus if we hit
such ENOSPC error inside a critical path, we have no choice but abort
the current transaction.

This will mark the fs read-only.

The problem is inside the btrfs_repair_io_failure() path that we require
the fs not to be mount read-only. This is normally fine, but if we are
doing a read-repair meanwhile the fs flips RO due to a critical error,
we can enter btrfs_repair_io_failure() with super block set to
read-only, thus triggering the above crash.

[FIX]
Just replace the ASSERT() with a proper return if the fs is already
read-only.

Reported-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-btrfs/20260126045555.GB31641@lst.de/
Tested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The same ASSERT exists in v6.1 too (in extent_io.c instead of bio.c).
The bug is present across all stable trees.

## Analysis

### What problem does this commit solve?

This commit fixes a **kernel BUG/crash** (not just a warning) that
occurs when:
1. The btrfs filesystem encounters a critical error (e.g., ENOSPC in a
   critical path)
2. The filesystem flips to read-only mode (transaction abort)
3. Meanwhile, a concurrent read-repair operation calls
   `btrfs_repair_io_failure()`
4. The ASSERT checks `!(fs_info->sb->s_flags & SB_RDONLY)` and fails
5. Since btrfs's `ASSERT()` macro calls `BUG()`, this causes a kernel
   oops/crash

The crash is confirmed by the stack trace in the commit message showing
`kernel BUG at fs/btrfs/bio.c:938!`.

### Does it meet stable kernel rules?

1. **Obviously correct and tested**: Yes. The fix replaces an ASSERT
   (which calls BUG()) with a graceful `return 0` when the filesystem is
   read-only. It has `Tested-by: Christoph Hellwig` and `Reviewed-by:
   David Sterba` (btrfs maintainer).

2. **Fixes a real bug**: Yes. A kernel BUG/crash is triggered. The bug
   report is linked and comes from Christoph Hellwig, a prominent kernel
   developer.

3. **Fixes an important issue**: Yes. This is a kernel crash (oops via
   BUG()). If a filesystem encounters a critical error and goes RO, a
   concurrent read-repair shouldn't crash the entire system.

4. **Small and contained**: Yes. The change removes one line
   (`ASSERT(...)`) and adds a 4-line `if (unlikely(sb_rdonly(...)))
   return 0;` check. Total: ~6 lines changed in one file.

5. **Does NOT introduce new features**: Correct. It only changes error
   handling.

### Risk vs Benefit

- **Risk**: Extremely low. Replacing a crash (BUG()) with a graceful
  return (0 = success, skip repair) is safe. If the filesystem is
  already RO, skipping the repair write is correct behavior — you can't
  write to a RO filesystem anyway.
- **Benefit**: High. Prevents kernel crash in a race condition that real
  users hit (reported by Christoph Hellwig during btrfs/124 test).

### Backport considerations

The function signature has changed significantly across versions:
- **v6.6**: Uses `struct page *page` parameter — different signature but
  the ASSERT is identical
- **v6.12**: Uses `struct folio *folio` parameter — different signature
  but the ASSERT is identical
- **Current**: Uses `const phys_addr_t paddrs[]` parameter

However, the **fix itself** (remove ASSERT, add `if (sb_rdonly(...))
return 0`) is signature-independent and applies to all versions. A minor
adaptation to the surrounding context will be needed for each stable
tree, but the core fix is trivial.

### Verification

- **Verified**: The ASSERT macro in btrfs calls `BUG()` (confirmed in
  `fs/btrfs/messages.h` lines 139-152)
- **Verified**: The buggy ASSERT exists in v6.12 and v6.6 stable trees
  (checked via `git show v6.12:fs/btrfs/bio.c` and `git show
  v6.6:fs/btrfs/bio.c`)
- **Verified**: The buggy ASSERT also exists in v6.1 (in
  `fs/btrfs/extent_io.c` rather than `bio.c`, function named
  `repair_io_failure`)
- **Verified**: The function has two callers: `btrfs_end_repair_bio()`
  (bio.c) and `btrfs_repair_eb_io_failure()` (disk-io.c), both in I/O
  completion paths that can race with filesystem RO transitions
- **Verified**: The commit has `Tested-by: Christoph Hellwig`,
  `Reviewed-by: David Sterba`, and `Reported-by: Christoph Hellwig` with
  a link to the bug report
- **Verified**: The fix is a clean 6-line change — remove ASSERT, add
  early return with comment
- **Verified**: The function signature differs across stable trees (page
  vs folio vs phys_addr_t), but the fix concept (remove ASSERT, add
  sb_rdonly check) is identical and straightforward to adapt

This is a textbook stable backport candidate: a small, well-reviewed fix
for a kernel crash in a race condition, reported by a trusted developer,
in a widely-used filesystem. The fix is obviously correct — when the fs
is RO, there's nothing to repair and crashing is worse than skipping.

**YES**

 fs/btrfs/bio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index fa1d321a2fb83..45bd3c3b6d793 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -935,7 +935,6 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
 	struct bio *bio = NULL;
 	int ret = 0;
 
-	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
 	/* Basic alignment checks. */
@@ -947,6 +946,13 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
 	ASSERT(step <= length);
 	ASSERT(is_power_of_2(step));
 
+	/*
+	 * The fs either mounted RO or hit critical errors, no need
+	 * to continue repairing.
+	 */
+	if (unlikely(sb_rdonly(fs_info->sb)))
+		return 0;
+
 	if (btrfs_repair_one_zone(fs_info, logical))
 		return 0;
 
-- 
2.51.0


