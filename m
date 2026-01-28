Return-Path: <linux-btrfs+bounces-21198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE3RJuuOeml+7wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21198-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 23:34:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50221A99B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 23:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A59F83023E2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 22:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D148344D97;
	Wed, 28 Jan 2026 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LizM8k9g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B4E34106D;
	Wed, 28 Jan 2026 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639637; cv=none; b=IA6Qv3wnV7YfAsctUvIoFO0BsOptcGPB92d1XNU/ItcZJlYtfNZibfSNlvmFlhJQgxHDRDp57+zyhxGRdVBFZ75xcXsW/1J6lFLzwA9Sxie2v+tUL6ZkxuyJGT9QVRpwIJo5LIR2mGg3z5lDwcnl3pAAYsocYrcmjSTo+RXHCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639637; c=relaxed/simple;
	bh=oFWWyg7TwmVD0dExZhQhiUm0QLjBZvwvGsZA6zvKIR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsJCdhAueZsKigPuMX7qwo4+KZuS82o9TXWGv7t4/Efbdfl/aE76czfw5DJG1ov+V3/WA9Gg5ziFIthssYVOvYIcdKQuiHTtfuNf3n0nhUx0vJ7LiJkfmipN/e7BBVSqA0h98/j6AkGxHreWnk43WtD8YMf/kCi22Ycvg09QaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LizM8k9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA95C4CEF7;
	Wed, 28 Jan 2026 22:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769639637;
	bh=oFWWyg7TwmVD0dExZhQhiUm0QLjBZvwvGsZA6zvKIR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LizM8k9gqTHyjry+ZGEv42OOEaJc52lg9k4UdbuKxxOFD4faIDcbl6QW6nKbfN56D
	 FX4FJ1bc1IhRj/fwh461HzprJmac3A2x8wVdJKxdAXI/r23XuTKjQ20mD83+g6Xt/l
	 sqRjNDzTse38eNDT8+PHI6CEOVRh2+DdDELaJaXrs/RZCH3033oeVlgIpdHQ7QY9yE
	 ORUSv6XmPBQNBan242C0lIxo8etGZWXt5IBAUodqKh/zIb+0INw2epR66SMKaqizEU
	 SXfkHS064K2jfN8pKaq1tHLwZVO2nRdYePGOLPVXSGr8x2BPUIP2uEK05onXMju6tO
	 lTdmNPtxqFWnw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Jiaming Zhang <r772577952@gmail.com>,
	Boris Burkov <boris@bur.io>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] btrfs: reject new transactions if the fs is fully read-only
Date: Wed, 28 Jan 2026 17:33:11 -0500
Message-ID: <20260128223332.2806589-13-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128223332.2806589-1-sashal@kernel.org>
References: <20260128223332.2806589-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.7
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,bur.io,wdc.com,kernel.org,fb.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21198-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 50221A99B3
X-Rspamd-Action: no action

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 1972f44c189c8aacde308fa9284e474c1a5cbd9f ]

[BUG]
There is a bug report where a heavily fuzzed fs is mounted with all
rescue mount options, which leads to the following warnings during
unmount:

  BTRFS: Transaction aborted (error -22)
  Modules linked in:
  CPU: 0 UID: 0 PID: 9758 Comm: repro.out Not tainted
  6.19.0-rc5-00002-gb71e635feefc #7 PREEMPT(full)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  RIP: 0010:find_free_extent_update_loop fs/btrfs/extent-tree.c:4208 [inline]
  RIP: 0010:find_free_extent+0x52f0/0x5d20 fs/btrfs/extent-tree.c:4611
  Call Trace:
   <TASK>
   btrfs_reserve_extent+0x2cd/0x790 fs/btrfs/extent-tree.c:4705
   btrfs_alloc_tree_block+0x1e1/0x10e0 fs/btrfs/extent-tree.c:5157
   btrfs_force_cow_block+0x578/0x2410 fs/btrfs/ctree.c:517
   btrfs_cow_block+0x3c4/0xa80 fs/btrfs/ctree.c:708
   btrfs_search_slot+0xcad/0x2b50 fs/btrfs/ctree.c:2130
   btrfs_truncate_inode_items+0x45d/0x2350 fs/btrfs/inode-item.c:499
   btrfs_evict_inode+0x923/0xe70 fs/btrfs/inode.c:5628
   evict+0x5f4/0xae0 fs/inode.c:837
   __dentry_kill+0x209/0x660 fs/dcache.c:670
   finish_dput+0xc9/0x480 fs/dcache.c:879
   shrink_dcache_for_umount+0xa0/0x170 fs/dcache.c:1661
   generic_shutdown_super+0x67/0x2c0 fs/super.c:621
   kill_anon_super+0x3b/0x70 fs/super.c:1289
   btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2127
   deactivate_locked_super+0xbc/0x130 fs/super.c:474
   cleanup_mnt+0x425/0x4c0 fs/namespace.c:1318
   task_work_run+0x1d4/0x260 kernel/task_work.c:233
   exit_task_work include/linux/task_work.h:40 [inline]
   do_exit+0x694/0x22f0 kernel/exit.c:971
   do_group_exit+0x21c/0x2d0 kernel/exit.c:1112
   __do_sys_exit_group kernel/exit.c:1123 [inline]
   __se_sys_exit_group kernel/exit.c:1121 [inline]
   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1121
   x64_sys_call+0x2210/0x2210 arch/x86/include/generated/asm/syscalls_64.h:232
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xe8/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x44f639
  Code: Unable to access opcode bytes at 0x44f60f.
  RSP: 002b:00007ffc15c4e088 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
  RAX: ffffffffffffffda RBX: 00000000004c32f0 RCX: 000000000044f639
  RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
  RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004c32f0
  R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
   </TASK>

Since rescue mount options will mark the full fs read-only, there should
be no new transaction triggered.

But during unmount we will evict all inodes, which can trigger a new
transaction, and triggers warnings on a heavily corrupted fs.

[CAUSE]
Btrfs allows new transaction even on a read-only fs, this is to allow
log replay happen even on read-only mounts, just like what ext4/xfs do.

However with rescue mount options, the fs is fully read-only and cannot
be remounted read-write, thus in that case we should also reject any new
transactions.

[FIX]
If we find the fs has rescue mount options, we should treat the fs as
error, so that no new transaction can be started.

Reported-by: Jiaming Zhang <r772577952@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CANypQFYw8Nt8stgbhoycFojOoUmt+BoZ-z8WJOZVxcogDdwm=Q@mail.gmail.com/
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information I need to analyze this commit. Let me
provide a comprehensive analysis.

## Commit Analysis

### 1. COMMIT MESSAGE ANALYSIS

**Subject:** "btrfs: reject new transactions if the fs is fully read-
only"

The commit clearly describes a bug fix with:
- A detailed BUG section with a full kernel stack trace showing warnings
  during unmount with rescue mount options
- A CAUSE section explaining why this bug happens
- A FIX section describing the solution
- The commit is well-documented with `Reported-by:` tag and a link to
  the bug report
- Multiple reviews: `Reviewed-by: Boris Burkov`, `Reviewed-by: Johannes
  Thumshirn`, `Reviewed-by: David Sterba` (the btrfs maintainer)
- Signed off by the btrfs maintainer David Sterba

### 2. CODE CHANGE ANALYSIS

The fix consists of two parts:

**Part 1 - New helper function (fs/btrfs/disk-io.c):**
```c
static bool fs_is_full_ro(const struct btrfs_fs_info *fs_info)
{
    if (!sb_rdonly(fs_info->sb))
        return false;
    if (unlikely(fs_info->mount_opt & BTRFS_MOUNT_FULL_RO_MASK))
        return true;
    return false;
}
```
This helper checks if the filesystem is both read-only AND has any of
the rescue mount options set.

**Part 2 - Setting fs_error during mount (fs/btrfs/disk-io.c):**
```c
/* If the fs has any rescue options, no transaction is allowed. */
if (fs_is_full_ro(fs_info))
    WRITE_ONCE(fs_info->fs_error, -EROFS);
```
This sets the `fs_error` field during mount if rescue options are used.

**Part 3 - New macro (fs/btrfs/fs.h):**
```c
#define BTRFS_MOUNT_FULL_RO_MASK        \
    (BTRFS_MOUNT_NOLOGREPLAY |      \
     BTRFS_MOUNT_IGNOREBADROOTS |       \
     BTRFS_MOUNT_IGNOREDATACSUMS |      \
     BTRFS_MOUNT_IGNOREMETACSUMS |      \
     BTRFS_MOUNT_IGNORESUPERFLAGS)
```

**Why the fix works:**
The existing code in `start_transaction()` (transaction.c:612-613)
checks:
```c
if (BTRFS_FS_ERROR(fs_info))
    return ERR_PTR(-EROFS);
```

By setting `fs_error` to `-EROFS` during mount when rescue options are
present, any later attempt to start a transaction (including during
inode eviction at unmount time) will fail early and return `-EROFS`
instead of proceeding and hitting allocation failures.

### 3. CLASSIFICATION

This is a **bug fix**, not a feature addition. It fixes a real-world
issue where:
- Mounting a corrupted filesystem with rescue mount options (which are
  read-only only)
- Trying to unmount causes inode eviction
- Inode eviction triggers transaction creation
- Transaction starts but fails because the fs can't actually write (it's
  read-only with rescue options)
- Results in WARN_ON/oops and potential issues

The fix leverages the existing `fs_error` mechanism to reject
transactions early instead of letting them start and fail later with
confusing errors.

### 4. SCOPE AND RISK ASSESSMENT

**Lines changed:** ~20 lines added, no lines removed
**Files touched:** 2 files (fs/btrfs/disk-io.c, fs/btrfs/fs.h)
**Complexity:** Low - simple check and assignment

**Risk assessment:**
- **LOW RISK**: The change is surgical and leverages existing mechanisms
- The `fs_error` field and `BTRFS_FS_ERROR()` check are well-established
  in btrfs
- The rescue mount options already require read-only mode - this just
  ensures transaction rejection is enforced
- The fix is in the mount path, not a hot path
- Multiple reviews from btrfs maintainers including David Sterba

**Potential impact:**
- Could theoretically affect behavior if some code expected transactions
  to start (even if they'd fail later)
- But this is the correct behavior - rescue options should never allow
  writes

### 5. USER IMPACT

**Who is affected:**
- Users mounting heavily corrupted btrfs filesystems with rescue mount
  options (e.g., `rescue=all`, `rescue=ibadroots`, etc.)
- This is a common data recovery scenario

**Severity:**
- Without the fix: Users get confusing WARN_ON messages and potential
  issues during unmount
- With the fix: Clean rejection of transactions with clear `-EROFS`
  error

### 6. STABILITY INDICATORS

- The commit has been reviewed by 3 btrfs experts including the
  maintainer
- `Reviewed-by: Boris Burkov <boris@bur.io>`
- `Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>`
- `Reviewed-by: David Sterba <dsterba@suse.com>`
- Signed off by the maintainer

### 7. DEPENDENCY CHECK

- No dependencies on other commits
- The code uses existing infrastructure (`fs_error`, mount option flags)
- All the mount option flags (BTRFS_MOUNT_NOLOGREPLAY, etc.) exist in
  all stable kernels where btrfs rescue options exist
- The fix is self-contained

### CONCLUSION

**Recommendation: YES for backport**

This commit fixes a real bug that affects users mounting corrupted btrfs
filesystems with rescue mount options - a legitimate and important data
recovery scenario. The fix is:

1. **Small and surgical** - Only ~20 lines of simple, readable code
2. **Fixes a real bug** - Prevents warnings and potential issues during
   unmount with rescue options
3. **Low risk** - Uses existing `fs_error` mechanism, well-tested
   pattern
4. **Well reviewed** - Multiple reviews from btrfs maintainers
5. **No new features** - Just ensures correct rejection of transactions
   that can't succeed anyway
6. **Self-contained** - No dependencies on other patches

The fix ensures that when rescue mount options are used (which are
inherently read-only and cannot be remounted read-write), new
transactions are rejected cleanly at start rather than failing later
with confusing errors and warnings.

**YES**

 fs/btrfs/disk-io.c | 13 +++++++++++++
 fs/btrfs/fs.h      |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f6..c5279aed7503f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3270,6 +3270,15 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 	return 0;
 }
 
+static bool fs_is_full_ro(const struct btrfs_fs_info *fs_info)
+{
+	if (!sb_rdonly(fs_info->sb))
+		return false;
+	if (unlikely(fs_info->mount_opt & BTRFS_MOUNT_FULL_RO_MASK))
+		return true;
+	return false;
+}
+
 int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices)
 {
 	u32 sectorsize;
@@ -3378,6 +3387,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
 		WRITE_ONCE(fs_info->fs_error, -EUCLEAN);
 
+	/* If the fs has any rescue options, no transaction is allowed. */
+	if (fs_is_full_ro(fs_info))
+		WRITE_ONCE(fs_info->fs_error, -EROFS);
+
 	/* Set up fs_info before parsing mount options */
 	nodesize = btrfs_super_nodesize(disk_super);
 	sectorsize = btrfs_super_sectorsize(disk_super);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 814bbc9417d2a..37aa8d141a83d 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -250,6 +250,14 @@ enum {
 	BTRFS_MOUNT_REF_TRACKER			= (1ULL << 33),
 };
 
+/* These mount options require a full read-only fs, no new transaction is allowed. */
+#define BTRFS_MOUNT_FULL_RO_MASK		\
+	(BTRFS_MOUNT_NOLOGREPLAY |		\
+	 BTRFS_MOUNT_IGNOREBADROOTS |		\
+	 BTRFS_MOUNT_IGNOREDATACSUMS |		\
+	 BTRFS_MOUNT_IGNOREMETACSUMS |		\
+	 BTRFS_MOUNT_IGNORESUPERFLAGS)
+
 /*
  * Compat flags that we support.  If any incompat flags are set other than the
  * ones specified below then we will fail to mount
-- 
2.51.0


