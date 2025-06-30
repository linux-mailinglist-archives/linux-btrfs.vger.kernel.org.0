Return-Path: <linux-btrfs+bounces-15129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF5AEE8C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 22:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C0144210F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 20:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EA128C031;
	Mon, 30 Jun 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVj2dhBq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B56236431;
	Mon, 30 Jun 2025 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317155; cv=none; b=Ir7NcV+wdbq+whHP+khoE9kkYrB7id8ObfzfRzYfmss5bOm87VaAfARDS/1xYtiICgVz8AIBXBr/Jvn+FahB+sKwKPGQDtUes2j8k25IDRLsdz+0EpaHA0yaW2U18BgrkaAw+1TSTe3HzyzcKKGq0GyCQhNYqhGBKQozW6hDdes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317155; c=relaxed/simple;
	bh=q+SDzv9F7coCyr6szXFb/sPRJ3uqtq3Eya2l++DISvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhmYbdz1QO7crt8RP54IYEYBS6wKvdCFLUH1WRbkdgHbz44IuNI9+jlzN4qV3/EOvxCYd741hGVPRIzM6BEuehjYKpEm73P6u2/QwuQ7k7Hi4QZdg6A+atG2slsnIe6054T8b0fKqTmO2VwOrQ2KVdgjyQvLRMruga4jEM4fBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVj2dhBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC58C4CEE3;
	Mon, 30 Jun 2025 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751317155;
	bh=q+SDzv9F7coCyr6szXFb/sPRJ3uqtq3Eya2l++DISvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVj2dhBqhmeiWksa2oZRUvNu+OO7LwWqF9TtzkMQCf7umHMUzcsgTLUdc9mWCV5bO
	 a3X8kW67wklSsOEn3eRdANzyvMezwb+JkGaQhM3K1o0XNYUHUizA+NPHV9rHTTemxQ
	 YF7PyQ9lvFCuDdDu3mVs1CyBYDxSOruuBzhAfUL5I/5K3zbmL/KmwUb+gwu7gESQDC
	 kazPvDhFwRmOsk27fF2Mc0vLs9eSML4KD9+4v9vUsA3Omn3DlD5pcf4uIcz7MIsrED
	 qCqcht1t2NqgCmC7gVk5QZuGDtAplAbuYAhklyM0SEJB8j7sp6tzj9cfInFgHA22lu
	 LK4Rmi5QzqJkg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 17/23] btrfs: fix assertion when building free space tree
Date: Mon, 30 Jun 2025 16:44:22 -0400
Message-Id: <20250630204429.1357695-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630204429.1357695-1-sashal@kernel.org>
References: <20250630204429.1357695-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1961d20f6fa8903266ed9bd77c691924c22c8f02 ]

When building the free space tree with the block group tree feature
enabled, we can hit an assertion failure like this:

  BTRFS info (device loop0 state M): rebuilding free space tree
  assertion failed: ret == 0, in fs/btrfs/free-space-tree.c:1102
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/free-space-tree.c:1102!
  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
  Modules linked in:
  CPU: 1 UID: 0 PID: 6592 Comm: syz-executor322 Not tainted 6.15.0-rc7-syzkaller-gd7fa1af5b33e #0 PREEMPT
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c:1102
  lr : populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c:1102
  sp : ffff8000a4ce7600
  x29: ffff8000a4ce76e0 x28: ffff0000c9bc6000 x27: ffff0000ddfff3d8
  x26: ffff0000ddfff378 x25: dfff800000000000 x24: 0000000000000001
  x23: ffff8000a4ce7660 x22: ffff70001499cecc x21: ffff0000e1d8c160
  x20: ffff0000e1cb7800 x19: ffff0000e1d8c0b0 x18: 00000000ffffffff
  x17: ffff800092f39000 x16: ffff80008ad27e48 x15: ffff700011e740c0
  x14: 1ffff00011e740c0 x13: 0000000000000004 x12: ffffffffffffffff
  x11: ffff700011e740c0 x10: 0000000000ff0100 x9 : 94ef24f55d2dbc00
  x8 : 94ef24f55d2dbc00 x7 : 0000000000000001 x6 : 0000000000000001
  x5 : ffff8000a4ce6f98 x4 : ffff80008f415ba0 x3 : ffff800080548ef0
  x2 : 0000000000000000 x1 : 0000000100000000 x0 : 000000000000003e
  Call trace:
   populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c:1102 (P)
   btrfs_rebuild_free_space_tree+0x14c/0x54c fs/btrfs/free-space-tree.c:1337
   btrfs_start_pre_rw_mount+0xa78/0xe10 fs/btrfs/disk-io.c:3074
   btrfs_remount_rw fs/btrfs/super.c:1319 [inline]
   btrfs_reconfigure+0x828/0x2418 fs/btrfs/super.c:1543
   reconfigure_super+0x1d4/0x6f0 fs/super.c:1083
   do_remount fs/namespace.c:3365 [inline]
   path_mount+0xb34/0xde0 fs/namespace.c:4200
   do_mount fs/namespace.c:4221 [inline]
   __do_sys_mount fs/namespace.c:4432 [inline]
   __se_sys_mount fs/namespace.c:4409 [inline]
   __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4409
   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
   invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
   el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
   el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
   el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
   el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
  Code: f0047182 91178042 528089c3 9771d47b (d4210000)
  ---[ end trace 0000000000000000 ]---

This happens because we are processing an empty block group, which has
no extents allocated from it, there are no items for this block group,
including the block group item since block group items are stored in a
dedicated tree when using the block group tree feature. It also means
this is the block group with the highest start offset, so there are no
higher keys in the extent root, hence btrfs_search_slot_for_read()
returns 1 (no higher key found).

Fix this by asserting 'ret' is 0 only if the block group tree feature
is not enabled, in which case we should find a block group item for
the block group since it's stored in the extent root and block group
item keys are greater than extent item keys (the value for
BTRFS_BLOCK_GROUP_ITEM_KEY is 192 and for BTRFS_EXTENT_ITEM_KEY and
BTRFS_METADATA_ITEM_KEY the values are 168 and 169 respectively).
In case 'ret' is 1, we just need to add a record to the free space
tree which spans the whole block group, and we can achieve this by
making 'ret == 0' as the while loop's condition.

Reported-by: syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/6841dca8.a00a0220.d4325.0020.GAE@google.com/
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees, specifically to
the 6.1.x and 6.6.x stable series. Here's my extensive analysis:

## Bug Severity and Impact

The commit fixes a **kernel BUG/assertion failure** that causes a system
crash when rebuilding the free space tree. The stack trace shows:

```
assertion failed: ret == 0, in fs/btrfs/free-space-tree.c:1102
kernel BUG at fs/btrfs/free-space-tree.c:1102!
```

This is a serious issue that results in system instability and affects
users who:
1. Use BTRFS with the block group tree feature enabled
2. Trigger a free space tree rebuild (e.g., during remount operations)
3. Have empty block groups in their filesystem

## Technical Analysis of the Fix

The fix is minimal and targeted:

```diff
- ASSERT(ret == 0);
+       if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
+               ASSERT(ret == 0);
```

and

```diff
- while (1) {
+       while (ret == 0) {
```

The root cause is well-understood: when the block group tree feature is
enabled, block group items are stored in a dedicated tree rather than
the extent tree. For empty block groups, `btrfs_search_slot_for_read()`
correctly returns 1 (no key found), but the old code incorrectly
asserted this must be 0.

## Stable Backport Criteria

1. **Fixes a real bug affecting users**: ✓ (kernel crash)
2. **Small and contained fix**: ✓ (2 line logic changes + comments)
3. **No major side effects**: ✓ (only affects the specific error case)
4. **No architectural changes**: ✓ (simple logic adjustment)
5. **Critical subsystem but minimal risk**: ✓ (BTRFS, but very targeted
   fix)

## Version Considerations

Based on my repository analysis:
- The block group tree feature was introduced in kernel 6.1-rc1
- Only 6.1.x and 6.6.x LTS kernels have this feature
- Earlier kernels (5.10, 5.15) don't need this fix as they lack the
  feature

## Similar Commit Patterns

Looking at the provided similar commits:
- Commits fixing free space tree corruption/crashes were marked YES for
  backporting
- Only cosmetic or debug-related changes were marked NO
- This commit follows the pattern of commits #1 and #2 which fixed
  actual bugs

## Conclusion

Despite lacking an explicit `Cc: stable@vger.kernel.org` tag, this
commit meets all criteria for stable backporting. It fixes a kernel
crash with a minimal, well-understood change that only affects systems
using a specific BTRFS feature. The fix should be backported to 6.1.x
and 6.6.x stable series where the block group tree feature exists.

 fs/btrfs/free-space-tree.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 39c6b96a4c25a..31fbf39e6b729 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1099,11 +1099,21 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out_locked;
-	ASSERT(ret == 0);
+	/*
+	 * If ret is 1 (no key found), it means this is an empty block group,
+	 * without any extents allocated from it and there's no block group
+	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
+	 * because we are using the block group tree feature, so block group
+	 * items are stored in the block group tree. It also means there are no
+	 * extents allocated for block groups with a start offset beyond this
+	 * block group's end offset (this is the last, highest, block group).
+	 */
+	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
+		ASSERT(ret == 0);
 
 	start = block_group->start;
 	end = block_group->start + block_group->length;
-	while (1) {
+	while (ret == 0) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
 		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
@@ -1133,8 +1143,6 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 		ret = btrfs_next_item(extent_root, path);
 		if (ret < 0)
 			goto out_locked;
-		if (ret)
-			break;
 	}
 	if (start < end) {
 		ret = __add_to_free_space_tree(trans, block_group, path2,
-- 
2.39.5


