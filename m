Return-Path: <linux-btrfs+bounces-4459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC448AB822
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Apr 2024 02:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6270A1F216A1
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Apr 2024 00:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044887FE;
	Sat, 20 Apr 2024 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KB4zYLJa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8F38B
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Apr 2024 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713573178; cv=none; b=ETgdsJHttjhn8m/fwcN8jguEDbZ5TTJX6aPwk8otz8CsthDQOs3nDWhovgk9CViDxLK2Ct0vyIiKh6D43QnkfAoACiTDnxB7XnP0M6lR+YaHIqn37B4n7qh2R/lppmS3iFQo+hNx7h0EaM66aNJ3NZ/A138cso0GIWV8U9HNios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713573178; c=relaxed/simple;
	bh=cKa0p/VU8R1CIyHVyR6Eq4fLE38FdXgwdTKYcqubpA8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AUSPcF2PeWXpj8lY+F0HNQkKieKD+hcNQW2Jg/HRA5g+B5PSPU86OP+XipgWTTi8SjL4IvcAkj8zO7WMtwRwMiW+MckqOUXI8GsS8Y7tKPFvr0UJymp6TkhhONkIJHpiRgRp2+wq9ttunUllQBp4yoVjZLZUK4/fBXOwWr+liQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KB4zYLJa; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-434b7ab085fso28547901cf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 17:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713573173; x=1714177973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fUmjNsUmhmDUwGOvXLq07Q+fy+NTyL+BrKDz3H94kAo=;
        b=KB4zYLJaCh5aqJ8GXpQvxePNPkfXlz7TVlkneMZ18uuG7yqco/SSx2w2a4ih4DXXk/
         QwjCB4kEUDPJNK3avtMReiZmvi3dddICWZzc/mW4G6RZH//zvj/LzSp3fqW+QdbH9yJf
         5Qcid0oU32J2t+hkExsSz71iGlyuHy/HtTvHLy8lburaqurnXM6RalAv9WMfdhEeToo2
         V+pcx2FOqbjh3gwV/57u1w1H6HC99qU/kRgTsT5WGeOktptpQ28cQEXbITm+jp9ERMIC
         ddA40H7PENFIReCpcGYHq0h2m+ItPcmwExYXt9QaS15Uh6H9DPvdF8Nx+fJ75X/lwQeN
         NgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713573173; x=1714177973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUmjNsUmhmDUwGOvXLq07Q+fy+NTyL+BrKDz3H94kAo=;
        b=UxC4EwOwbrVxmNtIQ84YopX8VodVQckTcSx0xpmRSzuNhtiSP456JSw3pv9yeJks5H
         WZ97IlbPqXfcuJ4ZWAww8SA7tH+c2oYVoAxRbcxwyTv3Tozw3oSzFEfNfEPbP3KeUo+1
         MZm3XPmfLjeAvBN5yDGm7I/nmRAalvnuMHLQawx///lWg63dkJJTrAJLRXnPlBceGzia
         cHzHj13SFflMKLN2z/giLxNqDujq5XXapqJmdSg2uJSHuVllzgWw5c3dWxhUd0hBkcH+
         Xw9+lPkEak2c5DD4FN76ZzFWEtdqYGmu3+SSMuMS358K9guM6kMLFfxeHO9yNX64hQUn
         qHOQ==
X-Gm-Message-State: AOJu0Yw0EDqGo6mZ3gvSNRZYvxUJV3+2Q0hSZEN3pLH/N2hSJGJ3574Z
	inRSZBdgKwPInSZMdRfKDJngYW+E/YM5vPRV5kfibRnnG6FKIKRYNxzvk30KgvgTl0nPfOCg4PN
	d
X-Google-Smtp-Source: AGHT+IGmdy6Lwio0+TPtnXb6vQEFO5ZPztQZCXPIVXt/hEqosCJQ628SN3cWwowLHNp6zjQBYrtEEw==
X-Received: by 2002:ac8:5882:0:b0:437:b8d8:511d with SMTP id t2-20020ac85882000000b00437b8d8511dmr8328249qta.22.1713573172645;
        Fri, 19 Apr 2024 17:32:52 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h23-20020ac87157000000b00432bd953506sm2031474qtp.84.2024.04.19.17.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 17:32:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: take the cleaner_mutex earlier in qgroup disable
Date: Fri, 19 Apr 2024 20:32:48 -0400
Message-ID: <a78874868a1d3d8d78e6b0fdbb97debc88923734.1713573156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of my CI runs popped the following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc4+ #1 Not tainted
------------------------------------------------------
btrfs/471533 is trying to acquire lock:
ffff92ba46980850 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: btrfs_quota_disable+0x54/0x4c0

but task is already holding lock:
ffff92ba46980bd0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl+0x1c8f/0x2600

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&fs_info->subvol_sem){++++}-{3:3}:
       down_read+0x42/0x170
       btrfs_rename+0x607/0xb00
       btrfs_rename2+0x2e/0x70
       vfs_rename+0xaf8/0xfc0
       do_renameat2+0x586/0x600
       __x64_sys_rename+0x43/0x50
       do_syscall_64+0x95/0x180
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #1 (&sb->s_type->i_mutex_key#16){++++}-{3:3}:
       down_write+0x3f/0xc0
       btrfs_inode_lock+0x40/0x70
       prealloc_file_extent_cluster+0x1b0/0x370
       relocate_file_extent_cluster+0xb2/0x720
       relocate_data_extent+0x107/0x160
       relocate_block_group+0x442/0x550
       btrfs_relocate_block_group+0x2cb/0x4b0
       btrfs_relocate_chunk+0x50/0x1b0
       btrfs_balance+0x92f/0x13d0
       btrfs_ioctl+0x1abf/0x2600
       __x64_sys_ioctl+0x97/0xd0
       do_syscall_64+0x95/0x180
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #0 (&fs_info->cleaner_mutex){+.+.}-{3:3}:
       __lock_acquire+0x13e7/0x2180
       lock_acquire+0xcb/0x2e0
       __mutex_lock+0xbe/0xc00
       btrfs_quota_disable+0x54/0x4c0
       btrfs_ioctl+0x206b/0x2600
       __x64_sys_ioctl+0x97/0xd0
       do_syscall_64+0x95/0x180
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

other info that might help us debug this:

Chain exists of:
  &fs_info->cleaner_mutex --> &sb->s_type->i_mutex_key#16 --> &fs_info->subvol_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fs_info->subvol_sem);
                               lock(&sb->s_type->i_mutex_key#16);
                               lock(&fs_info->subvol_sem);
  lock(&fs_info->cleaner_mutex);

 *** DEADLOCK ***

2 locks held by btrfs/471533:
 #0: ffff92ba4319e420 (sb_writers#14){.+.+}-{0:0}, at: btrfs_ioctl+0x3b5/0x2600
 #1: ffff92ba46980bd0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl+0x1c8f/0x2600

stack backtrace:
CPU: 1 PID: 471533 Comm: btrfs Kdump: loaded Not tainted 6.9.0-rc4+ #1
Call Trace:
 <TASK>
 dump_stack_lvl+0x77/0xb0
 check_noncircular+0x148/0x160
 ? lock_acquire+0xcb/0x2e0
 __lock_acquire+0x13e7/0x2180
 lock_acquire+0xcb/0x2e0
 ? btrfs_quota_disable+0x54/0x4c0
 ? lock_is_held_type+0x9a/0x110
 __mutex_lock+0xbe/0xc00
 ? btrfs_quota_disable+0x54/0x4c0
 ? srso_return_thunk+0x5/0x5f
 ? lock_acquire+0xcb/0x2e0
 ? btrfs_quota_disable+0x54/0x4c0
 ? btrfs_quota_disable+0x54/0x4c0
 btrfs_quota_disable+0x54/0x4c0
 btrfs_ioctl+0x206b/0x2600
 ? srso_return_thunk+0x5/0x5f
 ? __do_sys_statfs+0x61/0x70
 __x64_sys_ioctl+0x97/0xd0
 do_syscall_64+0x95/0x180
 ? srso_return_thunk+0x5/0x5f
 ? reacquire_held_locks+0xd1/0x1f0
 ? do_user_addr_fault+0x307/0x8a0
 ? srso_return_thunk+0x5/0x5f
 ? lock_acquire+0xcb/0x2e0
 ? srso_return_thunk+0x5/0x5f
 ? srso_return_thunk+0x5/0x5f
 ? find_held_lock+0x2b/0x80
 ? srso_return_thunk+0x5/0x5f
 ? lock_release+0xca/0x2a0
 ? srso_return_thunk+0x5/0x5f
 ? do_user_addr_fault+0x35c/0x8a0
 ? srso_return_thunk+0x5/0x5f
 ? trace_hardirqs_off+0x4b/0xc0
 ? srso_return_thunk+0x5/0x5f
 ? lockdep_hardirqs_on_prepare+0xde/0x190
 ? srso_return_thunk+0x5/0x5f

This happens because when we call rename we already have the inode mutex
held, and then we acquire the subvol_sem if we are a subvolume.  This
makes the dependency

inode lock -> subvol sem

When we're running data relocation we will preallocate space for the
data relocation inode, and we always run the relocation under the
->cleaner_mutex.  This now creates the dependency of

cleaner_mutex -> inode lock (from the prealloc) -> subvol_sem

Qgroup delete is doing this in the opposite order, it is acquiring the
subvol_sem and then it is acquiring the cleaner_mutex, which results in
this lockdep splat.  This deadlock can't happen in reality, because we
won't ever rename the data reloc inode, nor is the data reloc inode a
subvolume.

However this is fairly easy to fix, simply take the cleaner mutex in the
case where we are disabling qgroups before we take the subvol_sem.  This
resolves the lockdep splat.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c  | 20 +++++++++++++++++---
 fs/btrfs/qgroup.c | 21 ++++++++-------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0c977b7cc253..494f4d1dc38d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3758,15 +3758,30 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 		goto drop_write;
 	}
 
-	down_write(&fs_info->subvol_sem);
-
 	switch (sa->cmd) {
 	case BTRFS_QUOTA_CTL_ENABLE:
 	case BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA:
+		down_write(&fs_info->subvol_sem);
 		ret = btrfs_quota_enable(fs_info, sa);
+		up_write(&fs_info->subvol_sem);
 		break;
 	case BTRFS_QUOTA_CTL_DISABLE:
+		/*
+		 * Lock the cleaner mutex to prevent races with concurrent
+		 * relocation, because relocation may be building backrefs for
+		 * blocks of the quota root while we are deleting the root. This
+		 * is like dropping fs roots of deleted snapshots/subvolumes, we
+		 * need the same protection.
+		 *
+		 * This also prevents races between concurrent tasks trying to
+		 * disable quotas, because we will unlock and relock
+		 * qgroup_ioctl_lock across BTRFS_FS_QUOTA_ENABLED changes.
+		 */
+		mutex_lock(&fs_info->cleaner_mutex);
+		down_write(&fs_info->subvol_sem);
 		ret = btrfs_quota_disable(fs_info);
+		up_write(&fs_info->subvol_sem);
+		mutex_unlock(&fs_info->cleaner_mutex);
 		break;
 	default:
 		ret = -EINVAL;
@@ -3774,7 +3789,6 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 	}
 
 	kfree(sa);
-	up_write(&fs_info->subvol_sem);
 drop_write:
 	mnt_drop_write_file(file);
 	return ret;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9a9f84c4d3b8..7d48ecf9ee7f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1342,16 +1342,10 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	lockdep_assert_held_write(&fs_info->subvol_sem);
 
 	/*
-	 * Lock the cleaner mutex to prevent races with concurrent relocation,
-	 * because relocation may be building backrefs for blocks of the quota
-	 * root while we are deleting the root. This is like dropping fs roots
-	 * of deleted snapshots/subvolumes, we need the same protection.
-	 *
-	 * This also prevents races between concurrent tasks trying to disable
-	 * quotas, because we will unlock and relock qgroup_ioctl_lock across
-	 * BTRFS_FS_QUOTA_ENABLED changes.
+	 * Relocation will mess with backrefs, so make sure we have the
+	 * cleaner_mutex held to protect us from relocate.
 	 */
-	mutex_lock(&fs_info->cleaner_mutex);
+	lockdep_assert_held(&fs_info->cleaner_mutex);
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root)
@@ -1373,9 +1367,13 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 
+	/*
+	 * We have nothing held here and no trans handle, just return the error
+	 * if there is one.
+	 */
 	ret = flush_reservations(fs_info);
 	if (ret)
-		goto out_unlock_cleaner;
+		return ret;
 
 	/*
 	 * 1 For the root item
@@ -1439,9 +1437,6 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_commit_transaction(trans);
-out_unlock_cleaner:
-	mutex_unlock(&fs_info->cleaner_mutex);
-
 	return ret;
 }
 
-- 
2.43.0


