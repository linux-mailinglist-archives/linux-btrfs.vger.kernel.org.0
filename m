Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7851FB7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 22:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfEOU1Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 16:27:16 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42166 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbfEOU1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 16:27:15 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 936912FC8DB; Wed, 15 May 2019 16:27:14 -0400 (EDT)
Date:   Wed, 15 May 2019 16:27:14 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs + KASAN + SLAB + lvmcache + rsync + kernel 5.0 = page
 allocation failure and/or OOM kills (solved...ish)
Message-ID: <20190515202714.GF20359@hungrycats.org>
References: <20190326025028.GG16651@hungrycats.org>
 <20190326043005.GH16651@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
In-Reply-To: <20190326043005.GH16651@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 12:30:07AM -0400, Zygo Blaxell wrote:
> On Mon, Mar 25, 2019 at 10:50:28PM -0400, Zygo Blaxell wrote:
> > Running balance, rsync, and dedupe, I get kernel warnings every few
> > minutes on 5.0.4.  No warnings on 5.0.3 under similar conditions.
> >=20
> > Mount options are:  flushoncommit,space_cache=3Dv2,compress=3Dzstd.
> >=20
> > There are two different stacks on the warnings.  This one comes from
> > btrfs balance:
>=20
> [snip]
>=20
> Possibly unrelated, but I'm also repeatably getting this in 5.0.4 and
> not 5.0.3, after about 5 hours of uptime.  Different processes, same
> kernel stack:
>=20
> 	[Mon Mar 25 23:35:17 2019] kworker/u8:4: page allocation failure: order:=
0, mode:0x404000(GFP_NOWAIT|__GFP_COMP), nodemask=3D(null),cpuset=3D/,mems_=
allowed=3D0

It turns out there were two bugs overlapping here:

	5.0.3 -> 5.0.4 introduced the initial bug I observed in March

	In my own 5.0.6 builds, I turned on KASAN (and several other
	memory debug kernel config options) to chase an unrelated bug
	with behavior that was looking like a use-after-free.  This
	introduced a second page allocation failure behavior that occurred
	much more rapidly (every few seconds instead of every few hours).

	Somewhere between 5.0.5 and 5.0.10, the first, infrequent bug
	introduced in March was fixed.

	In my 5.0.10 and later builds, I turned KASAN off again.
	This avoids the second, very frequent bug.

I have no idea what bug got introduced and removed somewhere in
5.0.3..5.0.10, but I can't reproduce it on 5.0.11 and later, and I have
more urgent bugs to squash.

I'll leave what I've learned here in case someone rediscovers these
problems.

I ran a lot of tests turning things on and off and found that page
allocation failures seem to be triggered in large numbers by a
combination of _all_ of the following:

	1.  btrfs (ext4 doesn't trigger it)

	2.  lvmcache (using the same hardware in a btrfs on plain HDD
	or SSD doesn't trigger it, bcache has other problems that
	make it untestable)

	3.  kernel KASAN (must be enabled to trigger it)

	4.  userspace running rsync (seems any workload that writes
	pages continuously to a btrfs filesystem will suffice)

	5.  Linux 5.0.6..5.0.10 (haven't rigorously tested anything else)

	6.  Unknown other factors?  (I only tested the above)

Some other things I tried turning on or off that have no effect:

	A.  dedupe, snapshots, balances, processes reading the btrfs
	filesystem

	B.  using memory cgroups to limit page cache RAM usage of the
	rsync process

	C.  sysctl vm.dirty_ratio (1..50), dirty_background_ratio (1..10)
	dirty_expire_centisecs (100..30000) to try to increase or decrease
	the number of reclaimable pages and reclaim rate

	D.  btrfs flushoncommit and compress mount options

	E.  running memory-hog applications to try to trigger page
	allocation failures faster (fork() returns ENOMEM before these
	even get to start)

	F.  changing host memory size (2GB to 8GB in 1GB increments)

The page allocation failures start soon after all the host's RAM is
allocated to page cache.  They lead to a lot of processes getting ENOMEM
on various system calls, especially fork().  This effectively kills some
random process every second or two.  Half the commands run from a shell
will immediately fail with ENOMEM, assuming the shell itself doesn't die.
Booting a desktop or building a kernel is impossible.

I can live without KASAN, so I've just turned it off for my 5.0 kernel
builds.  I've had no problems since I did that near the end of April.

Here's a stacktrace with KASAN:

	[ 5157.469012] kworker/2:0: page allocation failure: order:0, mode:0x40000=
0(GFP_NOWAIT), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
	[ 5157.482299] CPU: 2 PID: 12944 Comm: kworker/2:0 Not tainted 5.0.10-zb64=
-1bb762d31089+ #1
	[ 5157.487810] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 1.10.2-1 04/01/2014
	[ 5157.494046] Workqueue: dm-cache check_migrations [dm_cache]
	[ 5157.496751] Call Trace:
	[ 5157.497564]  dump_stack+0x9c/0xf5
	[ 5157.500331]  warn_alloc+0x19a/0x240
	[ 5157.501518]  ? zone_watermark_ok_safe+0x140/0x140
	[ 5157.502796]  ? __isolate_free_page+0x2b0/0x2b0
	[ 5157.503916]  __alloc_pages_nodemask+0x1857/0x1980
	[ 5157.506179]  ? debug_show_all_locks+0x210/0x210
	[ 5157.508559]  ? gfp_pfmemalloc_allowed+0xc0/0xc0
	[ 5157.509939]  ? __asan_loadN+0xf/0x20
	[ 5157.511398]  ? pvclock_clocksource_read+0xd8/0x180
	[ 5157.513057]  ? kvm_sched_clock_read+0x18/0x30
	[ 5157.514301]  ? check_chain_key+0x147/0x200
	[ 5157.515414]  ? mark_lock+0xad/0x930
	[ 5157.516368]  ? mark_lock+0xad/0x930
	[ 5157.517333]  ? mark_held_locks+0x92/0xc0
	[ 5157.518398]  ? lock_release+0x7e/0x720
	[ 5157.519432]  ? mark_held_locks+0x92/0xc0
	[ 5157.520627]  ? __asan_loadN+0xf/0x20
	[ 5157.521574]  ? pvclock_clocksource_read+0xd8/0x180
	[ 5157.523130]  alloc_pages_current+0x75/0x110
	[ 5157.524244]  new_slab+0x44a/0x6a0
	[ 5157.525244]  ___slab_alloc+0x434/0x5c0
	[ 5157.526469]  ? btracker_queue+0xcc/0x2d0 [dm_cache]
	[ 5157.527976]  ? debug_show_all_locks+0x210/0x210
	[ 5157.529254]  ? __slab_alloc+0x3c/0x90
	[ 5157.530412]  ? btracker_queue+0xcc/0x2d0 [dm_cache]
	[ 5157.531749]  __slab_alloc+0x51/0x90
	[ 5157.532789]  ? __slab_alloc+0x51/0x90
	[ 5157.533766]  ? btracker_queue+0xcc/0x2d0 [dm_cache]
	[ 5157.535172]  kmem_cache_alloc+0x229/0x290
	[ 5157.536310]  btracker_queue+0xcc/0x2d0 [dm_cache]
	[ 5157.537692]  queue_writeback+0x157/0x1d0 [dm_cache_smq]
	[ 5157.539206]  ? mark_pending.isra.24+0x50/0x50 [dm_cache_smq]
	[ 5157.540879]  ? btracker_issue+0x28/0x120 [dm_cache]
	[ 5157.542302]  smq_get_background_work+0xa3/0xc0 [dm_cache_smq]
	[ 5157.543805]  check_migrations+0x1b8/0x2e0 [dm_cache]
	[ 5157.545426]  ? cache_ctr+0x1a70/0x1a70 [dm_cache]
	[ 5157.548005]  process_one_work+0x476/0xa00
	[ 5157.549104]  ? pwq_dec_nr_in_flight+0x130/0x130
	[ 5157.550784]  ? do_raw_spin_lock+0x1d0/0x1d0
	[ 5157.551952]  ? move_linked_works+0x113/0x150
	[ 5157.553119]  worker_thread+0x76/0x5d0
	[ 5157.554163]  kthread+0x1a9/0x200
	[ 5157.555028]  ? process_one_work+0xa00/0xa00
	[ 5157.556221]  ? kthread_park+0xb0/0xb0
	[ 5157.559982]  ret_from_fork+0x3a/0x50
	[ 5157.561253] Mem-Info:
	[ 5157.561822] active_anon:134320 inactive_anon:4419 isolated_anon:0
	[ 5157.561822]  active_file:1107612 inactive_file:249821 isolated_file:115
	[ 5157.561822]  unevictable:0 dirty:4092 writeback:25 unstable:0
	[ 5157.561822]  slab_reclaimable:95574 slab_unreclaimable:98822
	[ 5157.561822]  mapped:8463 shmem:4486 pagetables:2982 bounce:0
	[ 5157.561822]  free:25133 free_pcp:1021 free_cma:13
	[ 5157.572482] Node 0 active_anon:537280kB inactive_anon:17676kB active_fi=
le:4430448kB inactive_file:999284kB unevictable:0kB isolated(anon):0kB isol=
ated(file):460kB mapped:33852kB dirty:16368kB writeback:100kB shmem:17944kB=
 shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 323584kB wr
	iteback_tmp:0kB unstable:0kB all_unreclaimable? no
	[ 5157.579907] Node 0 DMA free:15812kB min:152kB low:188kB high:224kB acti=
ve_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable=
:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_st=
ack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0
	kB free_cma:0kB
	[ 5157.585961] lowmem_reserve[]: 0 2991 6846 6846 6846
	[ 5157.587060] Node 0 DMA32 free:44432kB min:29352kB low:36688kB high:4402=
4kB active_anon:14056kB inactive_anon:8kB active_file:2068012kB inactive_fi=
le:594748kB unevictable:0kB writepending:8620kB present:3129176kB managed:3=
063640kB mlocked:0kB kernel_stack:960kB pagetables:556kB b
	ounce:0kB free_pcp:4272kB local_pcp:748kB free_cma:0kB
	[ 5157.593250] lowmem_reserve[]: 0 0 3854 3854 3854
	[ 5157.594346] Node 0 Normal free:40288kB min:40124kB low:51688kB high:612=
04kB active_anon:523580kB inactive_anon:17668kB active_file:2361432kB inact=
ive_file:404492kB unevictable:0kB writepending:6060kB present:5242880kB man=
aged:3974560kB mlocked:0kB kernel_stack:15488kB pagetables
	:11372kB bounce:0kB free_pcp:404kB local_pcp:32kB free_cma:52kB
	[ 5157.601624] lowmem_reserve[]: 0 0 0 0 0
	[ 5157.602574] Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 0*32kB 1*64kB (U) 1*128k=
B (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15812kB
	[ 5157.605746] Node 0 DMA32: 605*4kB (UME) 438*8kB (UME) 378*16kB (UME) 12=
4*32kB (UME) 162*64kB (UME) 101*128kB (UM) 21*256kB (ME) 1*512kB (M) 0*1024=
kB 0*2048kB 0*4096kB =3D 45124kB
	[ 5157.609543] Node 0 Normal: 651*4kB (UMEC) 693*8kB (UMEC) 658*16kB (UME)=
 398*32kB (UMEH) 63*64kB (UME) 26*128kB (UE) 9*256kB (U) 0*512kB 0*1024kB 0=
*2048kB 0*4096kB =3D 41076kB
	[ 5157.613190] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_sur=
p=3D0 hugepages_size=3D1048576kB
	[ 5157.615305] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_sur=
p=3D0 hugepages_size=3D2048kB
	[ 5157.617353] 1361051 total pagecache pages
	[ 5157.618413] 0 pages in swap cache
	[ 5157.619220] Swap cache stats: add 0, delete 0, find 0/0
	[ 5157.620582] Free swap  =3D 0kB
	[ 5157.621380] Total swap =3D 0kB
	[ 5157.622092] 2097012 pages RAM
	[ 5157.622815] 0 pages HighMem/MovableOnly
	[ 5157.623804] 333485 pages reserved
	[ 5157.624606] 4096 pages cma reserved
	[ 5157.625493] 0 pages hwpoisoned
	[ 5157.626286] SLUB: Unable to allocate memory on node -1, gfp=3D0x400000(=
GFP_NOWAIT)
	[ 5157.628335]   cache: bt_work, object size: 64, buffer size: 96, default=
 order: 0, min order: 0
	[ 5157.630495]   node 0: slabs: 111, objs: 4662, free: 0

This is the original (5.0.4) KASAN-free stacktrace:

> 	[Mon Mar 25 23:35:17 2019] CPU: 2 PID: 29518 Comm: kworker/u8:4 Tainted:=
 G        W         5.0.4-zb64-303ce93b05c9+ #1
> 	[Mon Mar 25 23:35:17 2019] Hardware name: QEMU Standard PC (i440FX + PII=
X, 1996), BIOS 1.10.2-1 04/01/2014
> 	[Mon Mar 25 23:35:17 2019] Workqueue: btrfs-submit btrfs_submit_helper
> 	[Mon Mar 25 23:35:17 2019] Call Trace:
> 	[Mon Mar 25 23:35:17 2019]  dump_stack+0x7d/0xbb
> 	[Mon Mar 25 23:35:17 2019]  warn_alloc+0x108/0x190
> 	[Mon Mar 25 23:35:17 2019]  __alloc_pages_nodemask+0x12c4/0x13f0
> 	[Mon Mar 25 23:35:17 2019]  ? rcu_read_lock_sched_held+0x68/0x70
> 	[Mon Mar 25 23:35:17 2019]  ? __update_load_avg_se+0x208/0x280
> 	[Mon Mar 25 23:35:17 2019]  cache_grow_begin+0x79/0x730
> 	[Mon Mar 25 23:35:17 2019]  ? cache_grow_begin+0x79/0x730
> 	[Mon Mar 25 23:35:17 2019]  ? ____cache_alloc_node+0x165/0x1e0
> 	[Mon Mar 25 23:35:17 2019]  fallback_alloc+0x1e4/0x280
> 	[Mon Mar 25 23:35:17 2019]  kmem_cache_alloc+0x2e9/0x310
> 	[Mon Mar 25 23:35:17 2019]  btracker_queue+0x47/0x170 [dm_cache]
> 	[Mon Mar 25 23:35:17 2019]  __lookup+0x51a/0x600 [dm_cache_smq]
> 	[Mon Mar 25 23:35:17 2019]  ? smq_lookup+0x37/0x7b [dm_cache_smq]
> 	[Mon Mar 25 23:35:17 2019]  smq_lookup+0x5d/0x7b [dm_cache_smq]
> 	[Mon Mar 25 23:35:18 2019]  map_bio.part.40+0x14d/0x5d0 [dm_cache]
> 	[Mon Mar 25 23:35:18 2019]  ? bio_detain_shared+0xb3/0x120 [dm_cache]
> 	[Mon Mar 25 23:35:18 2019]  cache_map+0x120/0x170 [dm_cache]
> 	[Mon Mar 25 23:35:18 2019]  __map_bio+0x42/0x1f0 [dm_mod]
> 	[Mon Mar 25 23:35:18 2019]  __split_and_process_non_flush+0x152/0x1e0 [d=
m_mod]
> 	[Mon Mar 25 23:35:18 2019]  __split_and_process_bio+0xd4/0x400 [dm_mod]
> 	[Mon Mar 25 23:35:18 2019]  ? lock_acquire+0xbc/0x1c0
> 	[Mon Mar 25 23:35:18 2019]  ? dm_get_live_table+0x5/0xc0 [dm_mod]
> 	[Mon Mar 25 23:35:18 2019]  dm_make_request+0x4d/0x100 [dm_mod]
> 	[Mon Mar 25 23:35:18 2019]  generic_make_request+0x297/0x470
> 	[Mon Mar 25 23:35:18 2019]  ? kvm_sched_clock_read+0x14/0x30
> 	[Mon Mar 25 23:35:18 2019]  ? submit_bio+0x6c/0x140
> 	[Mon Mar 25 23:35:18 2019]  submit_bio+0x6c/0x140
> 	[Mon Mar 25 23:35:18 2019]  run_scheduled_bios+0x1e6/0x500
> 	[Mon Mar 25 23:35:18 2019]  ? normal_work_helper+0x95/0x530
> 	[Mon Mar 25 23:35:18 2019]  normal_work_helper+0x95/0x530
> 	[Mon Mar 25 23:35:18 2019]  process_one_work+0x223/0x5d0
> 	[Mon Mar 25 23:35:18 2019]  worker_thread+0x4f/0x3b0
> 	[Mon Mar 25 23:35:18 2019]  kthread+0x106/0x140
> 	[Mon Mar 25 23:35:18 2019]  ? process_one_work+0x5d0/0x5d0
> 	[Mon Mar 25 23:35:18 2019]  ? kthread_park+0x90/0x90
> 	[Mon Mar 25 23:35:18 2019]  ret_from_fork+0x3a/0x50
> 	[Mon Mar 25 23:35:18 2019] Mem-Info:
> 	[Mon Mar 25 23:35:18 2019] active_anon:195872 inactive_anon:15658 isolat=
ed_anon:0
> 				    active_file:629653 inactive_file:308914 isolated_file:0
> 				    unevictable:65536 dirty:14449 writeback:27580 unstable:0
> 				    slab_reclaimable:492522 slab_unreclaimable:94393
> 				    mapped:10915 shmem:18846 pagetables:2178 bounce:0
> 				    free:66082 free_pcp:1963 free_cma:24
> 	[Mon Mar 25 23:35:18 2019] Node 0 active_anon:783488kB inactive_anon:626=
32kB active_file:2516656kB inactive_file:1235604kB unevictable:262144kB iso=
lated(anon):0kB isolated(file):0kB mapped:43660kB dirty:57796kB writeback:1=
10320kB shmem:75384kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 137216k=
B writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> 	[Mon Mar 25 23:35:18 2019] Node 0 DMA free:15844kB min:132kB low:164kB h=
igh:196kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0=
kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked=
:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB =
free_cma:0kB
> 	[Mon Mar 25 23:35:18 2019] lowmem_reserve[]: 0 2939 7906 7906 7906
> 	[Mon Mar 25 23:35:18 2019] Node 0 DMA32 free:116632kB min:81336kB low:87=
592kB high:93848kB active_anon:330436kB inactive_anon:31840kB active_file:5=
31512kB inactive_file:491372kB unevictable:108544kB writepending:121984kB p=
resent:3129176kB managed:3019336kB mlocked:108544kB kernel_stack:2704kB pag=
etables:2944kB bounce:0kB free_pcp:3800kB local_pcp:256kB free_cma:0kB
> 	[Mon Mar 25 23:35:18 2019] lowmem_reserve[]: 0 0 4966 4966 4966
> 	[Mon Mar 25 23:35:18 2019] Node 0 Normal free:141932kB min:42420kB low:5=
3024kB high:63628kB active_anon:453224kB inactive_anon:30792kB active_file:=
1984568kB inactive_file:737244kB unevictable:153600kB writepending:46544kB =
present:5242880kB managed:5102032kB mlocked:153600kB kernel_stack:7020kB pa=
getables:5768kB bounce:0kB free_pcp:4188kB local_pcp:1700kB free_cma:96kB
> 	[Mon Mar 25 23:35:18 2019] lowmem_reserve[]: 0 0 0 0 0
> 	[Mon Mar 25 23:35:18 2019] Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U)=
 1*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*409=
6kB (M) =3D 15844kB
> 	[Mon Mar 25 23:35:18 2019] Node 0 DMA32: 12698*4kB (UME) 6110*8kB (UME) =
1087*16kB (UME) 4*32kB (M) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB=
 0*4096kB =3D 117192kB
> 	[Mon Mar 25 23:35:18 2019] Node 0 Normal: 13507*4kB (UMEHC) 8008*8kB (UM=
EHC) 1374*16kB (UMEH) 3*32kB (H) 4*64kB (H) 4*128kB (H) 2*256kB (H) 1*512kB=
 (H) 0*1024kB 0*2048kB 0*4096kB =3D 141964kB
> 	[Mon Mar 25 23:35:18 2019] Node 0 hugepages_total=3D0 hugepages_free=3D0=
 hugepages_surp=3D0 hugepages_size=3D1048576kB
> 	[Mon Mar 25 23:35:18 2019] Node 0 hugepages_total=3D0 hugepages_free=3D0=
 hugepages_surp=3D0 hugepages_size=3D2048kB
> 	[Mon Mar 25 23:35:18 2019] 955001 total pagecache pages
> 	[Mon Mar 25 23:35:18 2019] 0 pages in swap cache
> 	[Mon Mar 25 23:35:18 2019] Swap cache stats: add 0, delete 0, find 0/0
> 	[Mon Mar 25 23:35:18 2019] Free swap  =3D 0kB
> 	[Mon Mar 25 23:35:18 2019] Total swap =3D 0kB
> 	[Mon Mar 25 23:35:18 2019] 2097012 pages RAM
> 	[Mon Mar 25 23:35:18 2019] 0 pages HighMem/MovableOnly
> 	[Mon Mar 25 23:35:18 2019] 62693 pages reserved
> 	[Mon Mar 25 23:35:18 2019] 4096 pages cma reserved
> 	[Mon Mar 25 23:35:18 2019] 0 pages hwpoisoned
>=20
> As far as I can tell from logs of memory usage (recording memcg and
> MemAvail stats every second), there are gigabytes of available (clean
> page cache) RAM at all times during these tests.

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXNx2HwAKCRCB+YsaVrMb
nD3FAKCgN6SFxLbdVwzOxgLK9o8fhQtsOgCg3Urx5xiUufNxwiSveeFxo47lRB0=
=YS7A
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
