Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084C92B8826
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKRXHE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:07:04 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57569 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgKRXHD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:07:03 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D08C5CBC;
        Wed, 18 Nov 2020 18:07:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=nQ6rnp9LrOP5BFhotjmfxHaPwJ
        mRNX5XSAuJBXGG6XQ=; b=nWyNt5fLnSZm4sNpTcVRsaotcahzSj0BSQXxmGZWcH
        t9hffuuQdCqgLfLaDCKKcLiFyM4Eed9a5j0VQS08aJSaxPouC0mpXOWJ0frpmpu0
        jXXMHopretf3grKJdyR6sbi1+7ZujoT5D6vSn+E0M7Dj8kIrrV0IuzokXi+5Cb/0
        QYeQnKgjZzUPMrbqMfA9mSBw0cz1b6A5s1WWRLGTqWzkGOofTCKZWKNV9dbPE26R
        OUGIAGJWsL5KWi2zHomnxOimOIkQt7tqYh0y1Zl5VvFJXfJiJ2LMTw1Wweipr0TX
        JxkBFsetj0tg2mL8Z9VHs6+9Vv1dCFn/lcMEBwRoJEtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=nQ6rnp9LrOP5BFhotjmfxHaPwJmRNX5XSAuJBXGG6XQ=; b=Wn4xhwXx
        wHCTzZJvt1cK06/fC9fjKOdXg4MVOTHr2E5UHuvENnsNlhZC4E3bbvUmOYlBM0Yw
        A2V3ZWDqV9wOxapKm22XjTwyEZhDlA9bX7JWmYSqF0gTPmHjHLQOgMwLc2t0mqro
        bd5mUG+NkU/q3mcTdmgvbOBDRHsl1jAU/DGXgyF3vnu2WBOacTLtcmdLY3tCgm4M
        +0Fr+VP4hrlzaJn+WNZIOjJVYuXxUyGFRZtsQ9PnIJpkm53cP9gLDDy3A21apDNR
        2Emld1RTPKDICe+nKg9/CpoQrZ6boQALcS4AQ3S+aKubwdbGc4QCVE2TWAQaSc+l
        7jsYbO7mY3DbtQ==
X-ME-Sender: <xms:J6m1X5ULPo8DeRqUTVnE2BDlCm7DBoeEaC6ebWIDtGdY1IEqzO1-Fg>
    <xme:J6m1X5noJOeZmpxc77LFC1obavUmUIETBg00_9Y8sU5TdGeK0VljAqRBBoPz9tAr4
    -BbZkU0W4LQ4L47bX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpedutdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:J6m1X1bXHKZ79oCxeSgpvxmV3hHFZRzXhT_jwdzSdR3i_qZm5pegIw>
    <xmx:J6m1X8Vf6v_awijzO3bcEgOGHfpjkKIzXJdhlEmh0PmLQGd0lgb66A>
    <xmx:J6m1XzmJteSbZsfFWQMpGL67dNllBmHhjWNPaqLatY6dKlNGtrNAMQ>
    <xmx:J6m1X5Q1Gs3aMiOKv2diyT8SlvL8iQlf4wOjb25TK3Uqn04qz-bHFg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2D47328005E;
        Wed, 18 Nov 2020 18:07:18 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 12/12] btrfs: fix lockdep error creating free space tree
Date:   Wed, 18 Nov 2020 15:06:27 -0800
Message-Id: <1dc72f7e64535cda2fbc798e1130d4b516197136.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A lock dependency loop exists between the root tree lock, the extent tree
lock, and the free space tree lock.

The root tree lock depends on the free space tree lock because
btrfs_create_tree holds the new tree's lock while adding it to the root
tree.

The extent tree lock depends on the root tree lock because during umount,
we write out space cache v1, which writes inodes in the root tree, which
results in holding the root tree lock while doing a lookup in the extent tree.

Finally, the free space tree depends on the extent tree because
populate_free_space_tree holds a locked path in the extent tree and then
does a lookup in the free space tree to add the new item.

The simplest of the three to break is the one during tree creation: we
unlock the leaf before inserting the tree node into the root tree, which
fixes the lockdep.

Full contents of lockdep error for reference:

[   30.480136] ======================================================
[   30.480830] WARNING: possible circular locking dependency detected
[   30.481457] 5.9.0-rc8+ #76 Not tainted
[   30.481897] ------------------------------------------------------
[   30.482500] mount/520 is trying to acquire lock:
[   30.483064] ffff9babebe03908 (btrfs-free-space-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180
[   30.484054]
               but task is already holding lock:
[   30.484637] ffff9babebe24468 (btrfs-extent-01#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180
[   30.485581]
               which lock already depends on the new lock.

[   30.486397]
               the existing dependency chain (in reverse order) is:
[   30.487205]
               -> #2 (btrfs-extent-01#2){++++}-{3:3}:
[   30.487825]        down_read_nested+0x43/0x150
[   30.488306]        __btrfs_tree_read_lock+0x39/0x180
[   30.488868]        __btrfs_read_lock_root_node+0x3a/0x50
[   30.489477]        btrfs_search_slot+0x464/0x9b0
[   30.490009]        check_committed_ref+0x59/0x1d0
[   30.490603]        btrfs_cross_ref_exist+0x65/0xb0
[   30.491108]        run_delalloc_nocow+0x405/0x930
[   30.491651]        btrfs_run_delalloc_range+0x60/0x6b0
[   30.492203]        writepage_delalloc+0xd4/0x150
[   30.492688]        __extent_writepage+0x18d/0x3a0
[   30.493199]        extent_write_cache_pages+0x2af/0x450
[   30.493743]        extent_writepages+0x34/0x70
[   30.494231]        do_writepages+0x31/0xd0
[   30.494642]        __filemap_fdatawrite_range+0xad/0xe0
[   30.495194]        btrfs_fdatawrite_range+0x1b/0x50
[   30.495677]        __btrfs_write_out_cache+0x40d/0x460
[   30.496227]        btrfs_write_out_cache+0x8b/0x110
[   30.496716]        btrfs_start_dirty_block_groups+0x211/0x4e0
[   30.497317]        btrfs_commit_transaction+0xc0/0xba0
[   30.497861]        sync_filesystem+0x71/0x90
[   30.498303]        btrfs_remount+0x81/0x433
[   30.498767]        reconfigure_super+0x9f/0x210
[   30.499261]        path_mount+0x9d1/0xa30
[   30.499722]        do_mount+0x55/0x70
[   30.500158]        __x64_sys_mount+0xc4/0xe0
[   30.500616]        do_syscall_64+0x33/0x40
[   30.501091]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   30.501629]
               -> #1 (btrfs-root-00){++++}-{3:3}:
[   30.502241]        down_read_nested+0x43/0x150
[   30.502727]        __btrfs_tree_read_lock+0x39/0x180
[   30.503291]        __btrfs_read_lock_root_node+0x3a/0x50
[   30.503903]        btrfs_search_slot+0x464/0x9b0
[   30.504405]        btrfs_insert_empty_items+0x60/0xa0
[   30.504973]        btrfs_insert_item+0x60/0xd0
[   30.505412]        btrfs_create_tree+0x1b6/0x210
[   30.505913]        btrfs_create_free_space_tree+0x54/0x110
[   30.506460]        btrfs_mount_rw+0x15d/0x20f
[   30.506937]        btrfs_remount+0x356/0x433
[   30.507369]        reconfigure_super+0x9f/0x210
[   30.507868]        path_mount+0x9d1/0xa30
[   30.508264]        do_mount+0x55/0x70
[   30.508668]        __x64_sys_mount+0xc4/0xe0
[   30.509186]        do_syscall_64+0x33/0x40
[   30.509652]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   30.510271]
               -> #0 (btrfs-free-space-00){++++}-{3:3}:
[   30.510972]        __lock_acquire+0x11ad/0x1b60
[   30.511432]        lock_acquire+0xa2/0x360
[   30.511917]        down_read_nested+0x43/0x150
[   30.512383]        __btrfs_tree_read_lock+0x39/0x180
[   30.512947]        __btrfs_read_lock_root_node+0x3a/0x50
[   30.513455]        btrfs_search_slot+0x464/0x9b0
[   30.513947]        search_free_space_info+0x45/0x90
[   30.514465]        __add_to_free_space_tree+0x92/0x39d
[   30.515010]        btrfs_create_free_space_tree.cold.22+0x1ee/0x45d
[   30.515639]        btrfs_mount_rw+0x15d/0x20f
[   30.516142]        btrfs_remount+0x356/0x433
[   30.516538]        reconfigure_super+0x9f/0x210
[   30.517065]        path_mount+0x9d1/0xa30
[   30.517438]        do_mount+0x55/0x70
[   30.517824]        __x64_sys_mount+0xc4/0xe0
[   30.518293]        do_syscall_64+0x33/0x40
[   30.518776]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   30.519335]
               other info that might help us debug this:

[   30.520210] Chain exists of:
                 btrfs-free-space-00 --> btrfs-root-00 --> btrfs-extent-01#2

[   30.521407]  Possible unsafe locking scenario:

[   30.522037]        CPU0                    CPU1
[   30.522456]        ----                    ----
[   30.522941]   lock(btrfs-extent-01#2);
[   30.523311]                                lock(btrfs-root-00);
[   30.523952]                                lock(btrfs-extent-01#2);
[   30.524620]   lock(btrfs-free-space-00);
[   30.525068]
                *** DEADLOCK ***

[   30.525669] 5 locks held by mount/520:
[   30.526116]  #0: ffff9babebc520e0 (&type->s_umount_key#37){+.+.}-{3:3}, at: path_mount+0x7ef/0xa30
[   30.527056]  #1: ffff9babebc52640 (sb_internal#2){.+.+}-{0:0}, at: start_transaction+0x3d5/0x5c0
[   30.527960]  #2: ffff9babeae8f2e8 (&cache->free_space_lock#2){+.+.}-{3:3}, at: btrfs_create_free_space_tree.cold.22+0x101/0x45d
[   30.529118]  #3: ffff9babebe24468 (btrfs-extent-01#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180
[   30.530113]  #4: ffff9babebd52eb8 (btrfs-extent-00){++++}-{3:3}, at: btrfs_try_tree_read_lock+0x16/0x100
[   30.531124]
               stack backtrace:
[   30.531528] CPU: 0 PID: 520 Comm: mount Not tainted 5.9.0-rc8+ #76
[   30.532166] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-4.module_el8.1.0+248+298dec18 04/01/2014
[   30.533215] Call Trace:
[   30.533452]  dump_stack+0x8d/0xc0
[   30.533797]  check_noncircular+0x13c/0x150
[   30.534233]  __lock_acquire+0x11ad/0x1b60
[   30.534667]  lock_acquire+0xa2/0x360
[   30.535063]  ? __btrfs_tree_read_lock+0x39/0x180
[   30.535525]  down_read_nested+0x43/0x150
[   30.535939]  ? __btrfs_tree_read_lock+0x39/0x180
[   30.536400]  __btrfs_tree_read_lock+0x39/0x180
[   30.536862]  __btrfs_read_lock_root_node+0x3a/0x50
[   30.537304]  btrfs_search_slot+0x464/0x9b0
[   30.537713]  ? trace_hardirqs_on+0x1c/0xf0
[   30.538148]  search_free_space_info+0x45/0x90
[   30.538572]  __add_to_free_space_tree+0x92/0x39d
[   30.539071]  ? printk+0x48/0x4a
[   30.539367]  btrfs_create_free_space_tree.cold.22+0x1ee/0x45d
[   30.539972]  btrfs_mount_rw+0x15d/0x20f
[   30.540350]  btrfs_remount+0x356/0x433
[   30.540773]  ? shrink_dcache_sb+0xd9/0x100
[   30.541203]  reconfigure_super+0x9f/0x210
[   30.541642]  path_mount+0x9d1/0xa30
[   30.542040]  do_mount+0x55/0x70
[   30.542366]  __x64_sys_mount+0xc4/0xe0
[   30.542822]  do_syscall_64+0x33/0x40
[   30.543197]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   30.543691] RIP: 0033:0x7f109f7ab93a
[   30.544053] Code: 48 8b 0d 49 e5 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 16 e5 0b 00 f7 d8 64 89 01 48
[   30.546042] RSP: 002b:00007ffc47c4f858 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[   30.546770] RAX: ffffffffffffffda RBX: 00007f109f8cf264 RCX: 00007f109f7ab93a
[   30.547485] RDX: 0000557e6fc10770 RSI: 0000557e6fc19cf0 RDI: 0000557e6fc19cd0
[   30.548185] RBP: 0000557e6fc10520 R08: 0000557e6fc18e30 R09: 0000557e6fc18cb0
[   30.548911] R10: 0000000000200020 R11: 0000000000000246 R12: 0000000000000000
[   30.549606] R13: 0000557e6fc19cd0 R14: 0000557e6fc10770 R15: 0000557e6fc10520

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fea467c421e7..1934bf6a99da 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1142,7 +1142,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
 		leaf = NULL;
-		goto fail;
+		goto fail_unlock;
 	}
 
 	root->node = leaf;
@@ -1166,6 +1166,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 		export_guid(root->root_item.uuid, &guid_null);
 	btrfs_set_root_drop_level(&root->root_item, 0);
 
+	btrfs_tree_unlock(leaf);
+
 	key.objectid = objectid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = 0;
@@ -1173,13 +1175,12 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto fail;
 
-	btrfs_tree_unlock(leaf);
-
 	return root;
 
-fail:
+fail_unlock:
 	if (leaf)
 		btrfs_tree_unlock(leaf);
+fail:
 	btrfs_put_root(root);
 
 	return ERR_PTR(ret);
-- 
2.24.1

