Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4C825DE98
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgIDPyL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 11:54:11 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37354 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDPyK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 11:54:10 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A71ED7EA2FA; Fri,  4 Sep 2020 11:54:00 -0400 (EDT)
Date:   Fri, 4 Sep 2020 11:54:00 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        wqu@suse.com
Subject: Re: BUG at fs/btrfs/relocation.c:794! Still happening on misc-next
 and 5.8.3
Message-ID: <20200904155359.GC5890@hungrycats.org>
References: <bfecfacd-2d9d-386d-dfb7-951a5c5c6f6e@gmx.com>
 <20200804161626.GN5890@hungrycats.org>
 <20200828000313.GS5890@hungrycats.org>
 <20200828000822.GT5890@hungrycats.org>
 <720f3ac7-6af5-e171-5947-ed0240d5f5e5@suse.com>
 <20200828204255.GV5890@hungrycats.org>
 <20200901225341.GY5890@hungrycats.org>
 <45343d53-7dc0-1a7b-6da5-6461b653cde0@gmx.com>
 <20200902001429.GZ5890@hungrycats.org>
 <e2c84d2e-5038-7aaa-2bdf-789f5e075245@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2c84d2e-5038-7aaa-2bdf-789f5e075245@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 02, 2020 at 09:46:29AM +0800, Qu Wenruo wrote:
> On 2020/9/2 上午8:14, Zygo Blaxell wrote:
> > On Wed, Sep 02, 2020 at 07:33:21AM +0800, Qu Wenruo wrote:
> >> This looks like a race between some reloc tree creation from some other
> >> part.
> >>
> >> If you could add debug output for create_reloc_root() and its callers,
> >> we may have a chance to debug it.
> 
> What I mean is, I want to see who else created the reloc tree, not only
> who caused the EEXIST BUG_ON().
> 
> That's why I hope to add enough debug pr_info or whatever for
> create_reloc_root(), so that we can catch the ordinary calls that seems
> safe but may be unsafe for other callers.

There doesn't appear to be a race with multiple instances of
create_reloc_root as nobody else seems to be calling it at the time
when it fails.  On the other hand, it is a kworker thread, so it could
be racing with something else.

	Sep  4 01:46:42 regress kernel: [12131.050264][ T5245] btrfs_search_slot ret = 0
	Sep  4 01:46:51 regress kernel: [12140.058734][ T5245] btrfs_search_slot ret = 0
	Sep  4 01:47:00 regress kernel: [12149.079892][ T5245] btrfs_search_slot ret = 0
	Sep  4 01:47:09 regress kernel: [12158.091883][ T5245] btrfs_search_slot ret = 0
	Sep  4 01:47:14 regress kernel: [12162.521167][ T2993] btrfs_search_slot ret = 0
	Sep  4 01:47:14 regress kernel: [12162.823894][ T2993] btrfs_search_slot ret = 0
	Sep  4 01:47:14 regress kernel: [12162.991624][ T2993] btrfs_search_slot ret = 0
	Sep  4 01:47:14 regress kernel: [12162.999665][ T2993] btrfs_search_slot ret = 0
	Sep  4 01:47:19 regress kernel: [12167.117620][ T5245] btrfs_search_slot ret = 0
	Sep  4 01:47:28 regress kernel: [12176.232713][ T5245] btrfs_search_slot ret = 0
	Sep  4 01:47:37 regress kernel: [12185.237905][ T5245] btrfs_search_slot ret = 0
	Sep  4 01:47:50 regress kernel: [12199.005753][ T5245] btrfs_search_slot ret = 0
	Sep  4 01:47:51 regress kernel: [12199.953977][T27716] BTRFS info (device dm-0): balance: start -dlimit=9
	Sep  4 01:47:51 regress kernel: [12199.992918][T27716] BTRFS info (device dm-0): relocating block group 16502453436416 flags data
	Sep  4 01:47:54 regress kernel: [12202.443621][T11829] root->root_key.objectid == 0, objectid = 10502
	Sep  4 01:47:54 regress kernel: [12202.444916][T11829] CPU: 0 PID: 11829 Comm: kworker/u8:20 Tainted: G        W         5.8.6-ce459d8ff170+ #8
	Sep  4 01:47:54 regress kernel: [12202.446791][T11829] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	Sep  4 01:47:54 regress kernel: [12202.449187][T11829] Workqueue: btrfs-endio-write btrfs_work_helper
	Sep  4 01:47:54 regress kernel: [12202.450355][T11829] Call Trace:
	Sep  4 01:47:54 regress kernel: [12202.451580][T11829]  dump_stack+0xc8/0x11a
	Sep  4 01:47:54 regress kernel: [12202.452475][T11829]  create_reloc_root.cold.42+0x60/0x4d9
	Sep  4 01:47:54 regress kernel: [12202.453512][T11829]  ? invalidate_extent_cache+0x2a0/0x2a0
	Sep  4 01:47:54 regress kernel: [12202.454538][T11829]  ? check_chain_key+0x1e6/0x2e0
	Sep  4 01:47:54 regress kernel: [12202.455479][T11829]  btrfs_init_reloc_root+0x2d7/0x310
	Sep  4 01:47:54 regress kernel: [12202.456493][T11829]  ? find_reloc_root+0x200/0x200
	Sep  4 01:47:54 regress kernel: [12202.457510][T11829]  ? do_raw_spin_unlock+0xa8/0x140
	Sep  4 01:47:54 regress kernel: [12202.458446][T11829]  record_root_in_trans+0x18c/0x1d0
	Sep  4 01:47:54 regress kernel: [12202.459394][T11829]  btrfs_record_root_in_trans+0x8b/0xc0
	Sep  4 01:47:54 regress kernel: [12202.460673][T11829]  start_transaction+0x16b/0x8f0
	Sep  4 01:47:54 regress kernel: [12202.461595][T11829]  btrfs_join_transaction+0x1d/0x20
	Sep  4 01:47:54 regress kernel: [12202.462586][T11829]  btrfs_finish_ordered_io+0x535/0xd10
	Sep  4 01:47:54 regress kernel: [12202.463590][T11829]  ? register_lock_class+0x900/0x900
	Sep  4 01:47:54 regress kernel: [12202.464576][T11829]  ? btrfs_update_inode_fallback+0x40/0x40
	Sep  4 01:47:54 regress kernel: [12202.465584][T11829]  ? rcu_read_lock_sched_held+0xa1/0xd0
	Sep  4 01:47:54 regress kernel: [12202.466547][T11829]  ? rcu_read_lock_bh_held+0xb0/0xb0
	Sep  4 01:47:54 regress kernel: [12202.467463][T11829]  ? lock_is_held_type+0xc9/0x100
	Sep  4 01:47:54 regress kernel: [12202.468371][T11829]  finish_ordered_fn+0x15/0x20
	Sep  4 01:47:54 regress kernel: [12202.469224][T11829]  btrfs_work_helper+0x118/0x920
	Sep  4 01:47:54 regress kernel: [12202.470105][T11829]  ? rcu_read_lock_bh_held+0xb0/0xb0
	Sep  4 01:47:54 regress kernel: [12202.471082][T11829]  ? trace_hardirqs_on+0x57/0x140
	Sep  4 01:47:54 regress kernel: [12202.471998][T11829]  process_one_work+0x507/0xa70
	Sep  4 01:47:54 regress kernel: [12202.472885][T11829]  ? pwq_dec_nr_in_flight+0x130/0x130
	Sep  4 01:47:54 regress kernel: [12202.473816][T11829]  ? do_raw_spin_lock+0x1e0/0x1e0
	Sep  4 01:47:54 regress kernel: [12202.474716][T11829]  worker_thread+0x63/0x5a0
	Sep  4 01:47:54 regress kernel: [12202.475510][T11829]  ? process_one_work+0xa70/0xa70
	Sep  4 01:47:54 regress kernel: [12202.476428][T11829]  kthread+0x20c/0x230
	Sep  4 01:47:54 regress kernel: [12202.477137][T11829]  ? kthread_create_worker_on_cpu+0xc0/0xc0
	Sep  4 01:47:54 regress kernel: [12202.478152][T11829]  ret_from_fork+0x22/0x30
	Sep  4 01:47:54 regress kernel: [12202.480616][T11829] btrfs_search_slot ret = 0
	Sep  4 01:47:54 regress kernel: [12202.482834][T11829] btrfs_insert_empty_item ret = -17
	Sep  4 01:47:54 regress kernel: [12202.485447][T11829] btrfs_insert_root ret = -17
	Sep  4 01:47:54 regress kernel: [12202.487775][T11829] ------------[ cut here ]------------
	Sep  4 01:47:54 regress kernel: [12202.490086][T11829] kernel BUG at fs/btrfs/relocation.c:798!
	Sep  4 01:47:54 regress kernel: [12202.491104][T11829] invalid opcode: 0000 [#1] SMP KASAN PTI
	Sep  4 01:47:54 regress kernel: [12202.492056][T11829] CPU: 1 PID: 11829 Comm: kworker/u8:20 Tainted: G        W         5.8.6-ce459d8ff170+ #8
	Sep  4 01:47:54 regress kernel: [12202.493712][T11829] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	Sep  4 01:47:54 regress kernel: [12202.495311][T11829] Workqueue: btrfs-endio-write btrfs_work_helper
	Sep  4 01:47:54 regress kernel: [12202.496424][T11829] RIP: 0010:create_reloc_root.cold.42+0x434/0x4d9
	Sep  4 01:47:54 regress kernel: [12202.497550][T11829] Code: e8 6c d6 f3 ff 48 c7 c7 e0 98 03 8f 89 c6 89 85 30 ff ff ff e8 0d 53 8c ff 8b 95 30 ff ff ff 4c 8b 8d 28 ff ff ff 85 d2 74 02 <0f> 0b 4c 89 cf e8 fd 56 bc ff 4c 89 e7 e8 45 9c bc ff 49 8b 7f 20
	Sep  4 01:47:54 regress kernel: [12202.501225][T11829] RSP: 0018:ffffc9000b80f920 EFLAGS: 00010282
	Sep  4 01:47:54 regress kernel: [12202.503239][T11829] RAX: 000000000000001b RBX: 1ffff92001701f29 RCX: ffffffff8d273af2
	Sep  4 01:47:54 regress kernel: [12202.504644][T11829] RDX: 00000000ffffffef RSI: 0000000000000008 RDI: ffff8881f59ff28c
	Sep  4 01:47:54 regress kernel: [12202.507025][T11829] RBP: ffffc9000b80fa10 R08: ffffed103eb41645 R09: ffff8880a598b400
	Sep  4 01:47:54 regress kernel: [12202.509429][T11829] R10: ffff8881f5a0b227 R11: ffffed103eb41644 R12: ffff8881c93e8020
	Sep  4 01:47:54 regress kernel: [12202.510781][T11829] R13: ffff8881cbefd2a0 R14: ffffc9000b80f9a8 R15: ffff8881c93e8000
	Sep  4 01:47:54 regress kernel: [12202.512142][T11829] FS:  0000000000000000(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
	Sep  4 01:47:54 regress kernel: [12202.513651][T11829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	Sep  4 01:47:54 regress kernel: [12202.514790][T11829] CR2: 00007fb4c11f0a68 CR3: 00000001dc604005 CR4: 00000000001606e0
	Sep  4 01:47:54 regress kernel: [12202.516258][T11829] Call Trace:

For reference, here's my kernel logging so far:

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 82ab6e5a386d..b98b74397afc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4748,10 +4748,14 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 
	total_size = total_data + (nr * sizeof(struct btrfs_item));
	ret = btrfs_search_slot(trans, root, cpu_key, path, total_size, 1);
-	if (ret == 0)
+	if (ret == 0) {
+		printk(KERN_ERR "btrfs_search_slot ret = %d\n", ret);
		return -EEXIST;
-	if (ret < 0)
+	}
+	if (ret < 0) {
+		printk(KERN_ERR "btrfs_search_slot ret = %d\n", ret);
		return ret;
+	}
 
	slot = path->slots[0];
	BUG_ON(slot < 0);
@@ -4775,14 +4779,18 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root *root,
	unsigned long ptr;
 
	path = btrfs_alloc_path();
-	if (!path)
+	if (!path) {
+		printk(KERN_ERR "btrfs_alloc_path ENOMEM\n");
		return -ENOMEM;
+	}
	ret = btrfs_insert_empty_item(trans, root, path, cpu_key, data_size);
	if (!ret) {
		leaf = path->nodes[0];
		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
		write_extent_buffer(leaf, data, ptr, data_size);
		btrfs_mark_buffer_dirty(leaf);
+	} else {
+		printk(KERN_ERR "btrfs_insert_empty_item ret = %d\n", ret);
	}
	btrfs_free_path(path);
	return ret;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 350050b288e4..23fffd4bfd41 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -744,6 +744,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
	root_key.type = BTRFS_ROOT_ITEM_KEY;
	root_key.offset = objectid;
 
+	printk(KERN_ERR "root->root_key.objectid == %zu, objectid = %zu\n", ret, root->root_key.objectid, objectid);
+	dump_stack();
+
	if (root->root_key.objectid == objectid) {
		u64 commit_root_gen;
 
@@ -791,6 +794,7 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 
	ret = btrfs_insert_root(trans, fs_info->tree_root,
				&root_key, root_item);
+	printk(KERN_ERR "btrfs_insert_root ret = %d\n", ret);
	BUG_ON(ret);
	kfree(root_item);

> >>> The 5.4 result is interesting--I've been running 5.4 for some time and
> >>> not hit this before.  So there are 3 possible theories:
> >>>
> >>> 	1.  It's because of sending signals to balance.  That has been
> >>> 	added to my test workload after 5.7 was released, so earlier
> >>> 	tests on 5.4 would not have triggered it.

This might be related.  I removed 'kill the balance process' from my
test workload, and didn't have any BUG_ONs for two days.  When I put
the kill-the-balance-process test back in the workload, it went back
to BUG_ON at fairly reliable 1-5 hour intervals.  Of course that's just
correlation, and with random events at that, but so far the data supports
theory 1 and refutes theory 3.

> >>> 	2.  There's a regression in 5.4-stable, which I've cherry-picked
> >>> 	to all the other kernels during my test setup.	(On the other
> >>> 	hand, if I don't backport some fixes, kernels 5.5..5.7 crash
> >>> 	before they get to this bug.)
> >>>
> >>> 	3.  There's something rotten in my test filesystem, and the
> >>> 	BUG will go away for a while if I do a mkfs.  Qu asked for
> >>> 	a dump earlier in this thread, and I provided one.
> >>>
> >>> All three of these theories are testable to some extent, so I'll have
> >>> my test VM run some variations.
> >>>
> >>> The full test workload is:
> >>>
> >>> 	balance metadata or data at random intervals
> >>>
> >>> 	scrub, scrub cancel at random intervals
> >>>
> >>> 	20x rsync updating files
> >>>
> >>> 	snapshot create, delete at random intervals
> >>>
> >>> 	bees dedupe (lots of EXTENT_SAME and LOGICAL_INO calls)
> >>>
> >>> 	balance cancel at random intervals
> >>>
> >>> 	kill -9 $(pidof btrfs balance) at random intervals (NEW - added
> >>> 	when 5.7 came out)
> >>>
> >>> This is the 5.5 root assertion failure:
> >>>
> >>> 	Sep  1 04:48:48 regress kernel: [10642.537825][T24161] assertion failed: root, in fs/btrfs/relocation.c:837
> >>> 	Sep  1 04:48:48 regress kernel: [10642.538911][T24161] ------------[ cut here ]------------
> >>> 	Sep  1 04:48:48 regress kernel: [10642.539704][T24161] kernel BUG at fs/btrfs/ctree.h:3125!
> >>> 	Sep  1 04:48:48 regress kernel: [10642.540621][T24161] invalid opcode: 0000 [#1] SMP KASAN PTI
> >>> 	Sep  1 04:48:48 regress kernel: [10642.540624][ T4639] irq event stamp: 49626809
> >>> 	Sep  1 04:48:48 regress kernel: [10642.540632][ T4639] hardirqs last  enabled at (49626809): [<ffffffff8a00481a>] trace_hardirqs_on_thunk+0x1a/0x1c
> >>> 	Sep  1 04:48:48 regress kernel: [10642.541451][T24161] CPU: 1 PID: 24161 Comm: btrfs Tainted: G        W         5.5.19-76348822ab91+ #14
> >>> 	Sep  1 04:48:48 regress kernel: [10642.542114][ T4639] hardirqs last disabled at (49626808): [<ffffffff8a004836>] trace_hardirqs_off_thunk+0x1a/0x1c
> >>> 	Sep  1 04:48:48 regress kernel: [10642.543693][T24161] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> >>> 	Sep  1 04:48:48 regress kernel: [10642.545017][ T4639] softirqs last  enabled at (49626726): [<ffffffff8bc0048b>] __do_softirq+0x48b/0x5be
> >>> 	Sep  1 04:48:48 regress kernel: [10642.545023][ T4639] softirqs last disabled at (49626715): [<ffffffff8a1258a2>] irq_exit+0x112/0x120
> >>> 	Sep  1 04:48:48 regress kernel: [10642.546536][T24161] RIP: 0010:assertfail.constprop.42+0x1c/0x1e
> >>> 	Sep  1 04:48:49 regress kernel: [10642.551589][T24161] Code: 48 c7 c6 c0 90 03 8c e8 89 29 f1 ff 0f 0b 55 89 f1 48 c7 c2 40 82 03 8c 48 89 fe 48 c7 c7 60 83 03 8c 48 89 e5 e8 41 b0 90 ff <0f> 0b 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 f4 53 48 89 fb 48 83
> >>> 	Sep  1 04:48:49 regress kernel: [10642.554495][T24161] RSP: 0018:ffffc90002327150 EFLAGS: 00010282
> >>> 	Sep  1 04:48:49 regress kernel: [10642.555371][T24161] RAX: 0000000000000034 RBX: 000004513701c000 RCX: ffffffff8a264242
> >>> 	Sep  1 04:48:49 regress kernel: [10642.556515][T24161] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881f580004c
> >>> 	Sep  1 04:48:49 regress kernel: [10642.557680][T24161] RBP: ffffc90002327150 R08: ffffed103eb017e1 R09: ffffed103eb017e1
> >>> 	Sep  1 04:48:49 regress kernel: [10642.558895][T24161] R10: ffffed103eb017e0 R11: ffff8881f580bf07 R12: ffff88800d1ea5c0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.560139][T24161] R13: ffffc900023273e0 R14: 0000000000000000 R15: ffff8880bbf238f0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.561391][T24161] FS:  00007f03f48488c0(0000) GS:ffff8881f5600000(0000) knlGS:0000000000000000
> >>> 	Sep  1 04:48:49 regress kernel: [10642.562779][T24161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> 	Sep  1 04:48:49 regress kernel: [10642.563801][T24161] CR2: 00007f1cab76f718 CR3: 0000000189a5e004 CR4: 00000000001606e0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.565046][T24161] Call Trace:
> >>> 	Sep  1 04:48:49 regress kernel: [10642.565565][T24161]  build_backref_tree+0x186b/0x2590
> >>> 	Sep  1 04:48:49 regress kernel: [10642.566389][T24161]  ? relocate_data_extent+0x1a0/0x1a0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.567295][T24161]  ? lock_downgrade+0x3d0/0x3d0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.568142][T24161]  ? match_held_lock+0x20/0x260
> >>> 	Sep  1 04:48:49 regress kernel: [10642.568925][T24161]  ? do_raw_spin_unlock+0xa8/0x140
> >>> 	Sep  1 04:48:49 regress kernel: [10642.569765][T24161]  ? _raw_spin_trylock_bh+0x60/0x80
> >>> 	Sep  1 04:48:49 regress kernel: [10642.570605][T24161]  ? release_extent_buffer+0x13b/0x230
> >>> 	Sep  1 04:48:49 regress kernel: [10642.571480][T24161]  ? free_extent_buffer.part.45+0xd7/0x140
> >>> 	Sep  1 04:48:49 regress kernel: [10642.572406][T24161]  relocate_tree_blocks+0x204/0xa50
> >>> 	Sep  1 04:48:49 regress kernel: [10642.573244][T24161]  ? build_backref_tree+0x2590/0x2590
> >>> 	Sep  1 04:48:49 regress kernel: [10642.574103][T24161]  ? rb_insert_color+0x3af/0x400
> >>> 	Sep  1 04:48:49 regress kernel: [10642.574896][T24161]  ? kmem_cache_alloc_trace+0x5af/0x740
> >>> 	Sep  1 04:48:49 regress kernel: [10642.575785][T24161]  ? tree_insert+0x90/0xb0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.576495][T24161]  ? add_tree_block.isra.38+0x1d6/0x230
> >>> 	Sep  1 04:48:49 regress kernel: [10642.577387][T24161]  relocate_block_group+0x528/0x9d0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.578220][T24161]  ? merge_reloc_roots+0x470/0x470
> >>> 	Sep  1 04:48:49 regress kernel: [10642.579047][T24161]  btrfs_relocate_block_group+0x26e/0x4c0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.579968][T24161]  btrfs_relocate_chunk+0x52/0xf0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.580773][T24161]  btrfs_balance+0xe5b/0x1800
> >>> 	Sep  1 04:48:49 regress kernel: [10642.581542][T24161]  ? btrfs_relocate_chunk+0xf0/0xf0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.582381][T24161]  ? kmem_cache_alloc_trace+0x5af/0x740
> >>> 	Sep  1 04:48:49 regress kernel: [10642.583270][T24161]  ? _copy_from_user+0xaa/0xd0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.584022][T24161]  btrfs_ioctl_balance+0x3de/0x4c0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.584819][T24161]  btrfs_ioctl+0x3122/0x4470
> >>> 	Sep  1 04:48:49 regress kernel: [10642.585540][T24161]  ? __asan_loadN+0xf/0x20
> >>> 	Sep  1 04:48:49 regress kernel: [10642.586229][T24161]  ? __asan_loadN+0xf/0x20
> >>> 	Sep  1 04:48:49 regress kernel: [10642.586920][T24161]  ? btrfs_ioctl_get_supported_features+0x30/0x30
> >>> 	Sep  1 04:48:49 regress kernel: [10642.587935][T24161]  ? __asan_loadN+0xf/0x20
> >>> 	Sep  1 04:48:49 regress kernel: [10642.588649][T24161]  ? pvclock_clocksource_read+0xeb/0x190
> >>> 	Sep  1 04:48:49 regress kernel: [10642.589566][T24161]  ? __asan_loadN+0xf/0x20
> >>> 	Sep  1 04:48:49 regress kernel: [10642.590254][T24161]  ? pvclock_clocksource_read+0xeb/0x190
> >>> 	Sep  1 04:48:49 regress kernel: [10642.591128][T24161]  ? __kasan_check_read+0x11/0x20
> >>> 	Sep  1 04:48:49 regress kernel: [10642.591913][T24161]  ? check_chain_key+0x1e6/0x2e0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.592707][T24161]  ? __asan_loadN+0xf/0x20
> >>> 	Sep  1 04:48:49 regress kernel: [10642.593409][T24161]  ? pvclock_clocksource_read+0xeb/0x190
> >>> 	Sep  1 04:48:49 regress kernel: [10642.594312][T24161]  ? kvm_sched_clock_read+0x18/0x30
> >>> 	Sep  1 04:48:49 regress kernel: [10642.595139][T24161]  ? check_chain_key+0x1e6/0x2e0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.595929][T24161]  ? sched_clock_cpu+0x1b/0x120
> >>> 	Sep  1 04:48:49 regress kernel: [10642.596712][T24161]  do_vfs_ioctl+0x13e/0xad0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.597432][T24161]  ? btrfs_ioctl_get_supported_features+0x30/0x30
> >>> 	Sep  1 04:48:49 regress kernel: [10642.598455][T24161]  ? do_vfs_ioctl+0x13e/0xad0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.599202][T24161]  ? compat_ioctl_preallocate+0x170/0x170
> >>> 	Sep  1 04:48:49 regress kernel: [10642.600128][T24161]  ? __kasan_check_write+0x14/0x20
> >>> 	Sep  1 04:48:49 regress kernel: [10642.600949][T24161]  ? up_read+0x176/0x4f0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.601648][T24161]  ? down_write_nested+0x2d0/0x2d0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.602476][T24161]  ? handle_mm_fault+0x211/0x480
> >>> 	Sep  1 04:48:49 regress kernel: [10642.603263][T24161]  ? __kasan_check_read+0x11/0x20
> >>> 	Sep  1 04:48:49 regress kernel: [10642.604062][T24161]  ? __fget_light+0xb2/0x110
> >>> 	Sep  1 04:48:49 regress kernel: [10642.604805][T24161]  ksys_ioctl+0x67/0x90
> >>> 	Sep  1 04:48:49 regress kernel: [10642.605471][T24161]  __x64_sys_ioctl+0x43/0x50
> >>> 	Sep  1 04:48:49 regress kernel: [10642.606203][T24161]  do_syscall_64+0x77/0x2d0
> >>> 	Sep  1 04:48:49 regress kernel: [10642.606933][T24161]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>> 	Sep  1 04:48:49 regress kernel: [10642.607875][T24161] RIP: 0033:0x7f03f493b427
> >>> 	Sep  1 04:48:49 regress kernel: [10642.608588][T24161] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
> >>> 	Sep  1 04:48:49 regress kernel: [10642.611697][T24161] RSP: 002b:00007ffd6bd78fb8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> >>> 	Sep  1 04:48:49 regress kernel: [10642.613035][T24161] RAX: ffffffffffffffda RBX: 00007ffd6bd79058 RCX: 00007f03f493b427
> >>> 	Sep  1 04:48:49 regress kernel: [10642.614313][T24161] RDX: 00007ffd6bd79058 RSI: 00000000c4009420 RDI: 0000000000000003
> >>> 	Sep  1 04:48:49 regress kernel: [10642.615605][T24161] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
> >>> 	Sep  1 04:48:49 regress kernel: [10642.616877][T24161] R10: fffffffffffff5ab R11: 0000000000000206 R12: 0000000000000001
> >>> 	Sep  1 04:48:49 regress kernel: [10642.618132][T24161] R13: 0000000000000000 R14: 00007ffd6bd7aa46 R15: 0000000000000001
> >>> 	Sep  1 04:48:49 regress kernel: [10642.619378][T24161] Modules linked in:
> >>> 	Sep  1 04:48:49 regress kernel: [10642.620153][T24161] ---[ end trace a33c17a7d43dd973 ]---
> >>>
