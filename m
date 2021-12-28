Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B9B4806B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Dec 2021 07:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhL1G3m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Dec 2021 01:29:42 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:33810 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232480AbhL1G3m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Dec 2021 01:29:42 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 9060B1208F5; Tue, 28 Dec 2021 01:29:41 -0500 (EST)
Date:   Tue, 28 Dec 2021 01:29:41 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: KASAN use-after free in misc-next a8eb3521f240
Message-ID: <Ycqu1Wr8p3aJNcaf@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running a slightly different workload than my usual regression test:

	- mount options rw,noatime,degraded,compress=zstd:3,ssd,flushoncommit,space_cache=v2,autodefrag

	- metadata raid1, data raid5

	- workload is a continuous loop of all of the following at once:

		- rsync x10

		- bees dedupe

		- create and rename files with 16 threads in one directory

		- btrfs replace

Probably the most relevant part of the above is the replace on raid5
data, which was the most recent change to the workload (previously it
was looping replace on raid1 data).  This happened soon after:

	[134141.419795][T4038472] ==================================================================
	[134141.421408][T4038472] BUG: KASAN: use-after-free in __remove_rbio_from_cache+0x26/0x2e0
	[134141.423281][T4038472] Read of size 8 at addr ffff888129702800 by task kworker/u8:24/4038472
	[134141.426074][T4038472] 
	[134141.427362][T4038472] CPU: 1 PID: 4038472 Comm: kworker/u8:24 Tainted: G        W         5.16.0-77deb3be908f-misc-next+ #141 4aa87610d6aeaaaf53dd48d092c1e09cd06399d8
	[134141.435115][T4038472] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	[134141.439704][T4038472] Workqueue: btrfs-worker btrfs_work_helper
	[134141.442785][T4038472] Call Trace:
	[134141.444593][T4038472]  <TASK>
	[134141.446177][T4038472]  dump_stack_lvl+0x74/0xa6
	[134141.448662][T4038472]  print_address_description.constprop.0+0x24/0x120
	[134141.452242][T4038472]  ? __remove_rbio_from_cache+0x26/0x2e0
	[134141.455357][T4038472]  kasan_report.cold+0x82/0xdb
	[134141.457965][T4038472]  ? __remove_rbio_from_cache+0x26/0x2e0
	[134141.461065][T4038472]  __asan_load8+0x69/0x90
	[134141.463540][T4038472]  __remove_rbio_from_cache+0x26/0x2e0
	[134141.466528][T4038472]  remove_rbio_from_cache+0x7d/0x90
	[134141.469316][T4038472]  lock_stripe_add+0x1c7/0x700
	[134141.472111][T4038472]  raid56_parity_write+0x253/0x2b0
	[134141.474972][T4038472]  btrfs_map_bio+0x762/0x930
	[134141.477470][T4038472]  ? irqentry_exit+0x3a/0x90
	[134141.480107][T4038472]  ? trace_hardirqs_on+0x55/0x130
	[134141.482963][T4038472]  ? btrfs_map_sblock+0x20/0x20
	[134141.485560][T4038472]  ? lock_downgrade+0x420/0x420
	[134141.488310][T4038472]  ? lock_contended+0x770/0x770
	[134141.490892][T4038472]  ? do_raw_spin_lock+0x1c0/0x1c0
	[134141.493656][T4038472]  ? kfree+0x197/0x290
	[134141.495981][T4038472]  run_one_async_done+0xa9/0x120
	[134141.498671][T4038472]  btrfs_work_helper+0x16f/0x620
	[134141.501663][T4038472]  process_one_work+0x56b/0xac0
	[134141.504527][T4038472]  ? pwq_dec_nr_in_flight+0x120/0x120
	[134141.507777][T4038472]  ? worker_thread+0xd0/0x700
	[134141.510579][T4038472]  ? kthread_data+0x38/0x50
	[134141.513222][T4038472]  worker_thread+0x2f1/0x700
	[134141.515851][T4038472]  ? trace_hardirqs_on+0x55/0x130
	[134141.518788][T4038472]  ? process_one_work+0xac0/0xac0
	[134141.521623][T4038472]  kthread+0x254/0x290
	[134141.523780][T4038472]  ? set_kthread_struct+0x80/0x80
	[134141.526620][T4038472]  ret_from_fork+0x22/0x30
	[134141.529146][T4038472]  </TASK>

	__remove_rbio_from_cache+0x26/0x2e0:

	__remove_rbio_from_cache at fs/btrfs/raid56.c:273
	 268    /*
	 269     * we hash on the first logical address of the stripe
	 270     */
	 271    static int rbio_bucket(struct btrfs_raid_bio *rbio)
	 272    {
	>273<           u64 num = rbio->bioc->raid_map[0];
	 274
	 275            /*
	 276             * we shift down quite a bit.  We're using byte
	 277             * addressing, and most of the lower bits are zeros.
	 278             * This tends to upset hash_64, and it consistently

	lock_stripe_add+0x1c7/0x700:

	lock_stripe_add at fs/btrfs/raid56.c:734
	 729            refcount_inc(&rbio->refs);
	 730            list_add(&rbio->hash_list, &h->hash_list);
	 731    out:
	 732            spin_unlock_irqrestore(&h->lock, flags);
	 733            if (cache_drop)
	>734<                   remove_rbio_from_cache(cache_drop);
	 735            if (freeit)
	 736                    __free_raid_bio(freeit);
	 737            return ret;
	 738    }
	 739

	raid56_parity_write+0x253/0x2b0:

	raid56_parity_write at fs/btrfs/raid56.c:1597
	 1592   static int partial_stripe_write(struct btrfs_raid_bio *rbio)
	 1593   {
	 1594           int ret;
	 1595
	 1596           ret = lock_stripe_add(rbio);
	>1597<          if (ret == 0)
	 1598                   start_async_work(rbio, rmw_work);
	 1599           return 0;
	 1600   }
	 1601
	 1602   /*

	[134141.530723][T4038472] 
	[134141.532092][T4038472] Allocated by task 82995:
	[134141.534703][T4038472]  kasan_save_stack+0x26/0x60
	[134141.537524][T4038472]  __kasan_kmalloc+0xab/0xe0
	[134141.540156][T4038472]  __kmalloc+0x22b/0x4a0
	[134141.542580][T4038472]  alloc_rbio.constprop.0+0x88/0x320
	[134141.545533][T4038472]  raid56_parity_write+0x37/0x2b0
	[134141.548390][T4038472]  btrfs_map_bio+0x762/0x930
	[134141.551259][T4038472]  run_one_async_done+0xa9/0x120
	[134141.554112][T4038472]  btrfs_work_helper+0x16f/0x620
	[134141.556845][T4038472]  process_one_work+0x56b/0xac0
	[134141.559573][T4038472]  worker_thread+0x2f1/0x700
	[134141.562193][T4038472]  kthread+0x254/0x290
	[134141.564518][T4038472]  ret_from_fork+0x22/0x30

	alloc_rbio.constprop.0+0x88/0x320:

	alloc_rbio.constprop.0 at fs/btrfs/raid56.c:980
	 975                           sizeof(*rbio->finish_pointers) * real_stripes +
	 976                           sizeof(*rbio->dbitmap) * BITS_TO_LONGS(stripe_npages) +
	 977                           sizeof(*rbio->finish_pbitmap) *
	 978                                    BITS_TO_LONGS(stripe_npages),
	 979                           GFP_NOFS);
	>980<           if (!rbio)
	 981                    return ERR_PTR(-ENOMEM);
	 982
	 983            bio_list_init(&rbio->bio_list);
	 984            INIT_LIST_HEAD(&rbio->plug_list);
	 985            spin_lock_init(&rbio->bio_list_lock);

	raid56_parity_write+0x37/0x2b0:

	raid56_parity_write at fs/btrfs/raid56.c:1728
	 1723           struct btrfs_raid_bio *rbio;
	 1724           struct btrfs_plug_cb *plug = NULL;
	 1725           struct blk_plug_cb *cb;
	 1726           int ret;
	 1727
	>1728<          rbio = alloc_rbio(fs_info, bioc, stripe_len);
	 1729           if (IS_ERR(rbio)) {
	 1730                   btrfs_put_bioc(bioc);
	 1731                   return PTR_ERR(rbio);
	 1732           }
	 1733           bio_list_add(&rbio->bio_list, bio);

	[134141.567063][T4038472] 
	[134141.568423][T4038472] Freed by task 737008:
	[134141.570793][T4038472]  kasan_save_stack+0x26/0x60
	[134141.573272][T4038472]  kasan_set_track+0x25/0x30
	[134141.575813][T4038472]  kasan_set_free_info+0x24/0x40
	[134141.578689][T4038472]  __kasan_slab_free+0xf0/0x140
	[134141.581378][T4038472]  kfree+0x109/0x290
	[134141.583550][T4038472]  __free_raid_bio+0x155/0x1a0
	[134141.586183][T4038472]  __remove_rbio_from_cache+0x1bd/0x2e0
	[134141.589223][T4038472]  unlock_stripe+0x5d8/0x7e0
	[134141.591757][T4038472]  rbio_orig_end_io+0x80/0x170
	[134141.594382][T4038472]  raid_write_end_io+0xc5/0xe0
	[134141.597009][T4038472]  bio_endio+0x2f4/0x340
	[134141.599378][T4038472]  dm_io_dec_pending+0x2bc/0x4f0
	[134141.602267][T4038472]  clone_endio+0x14c/0x4a0
	[134141.604931][T4038472]  bio_endio+0x2f4/0x340
	[134141.607428][T4038472]  blk_update_request+0x206/0x7d0
	[134141.610375][T4038472]  blk_mq_end_request+0x30/0x50
	[134141.613213][T4038472]  virtblk_request_done+0x69/0x100
	[134141.616180][T4038472]  blk_mq_complete_request+0x46/0x50
	[134141.619194][T4038472]  virtblk_done+0xf8/0x1e0
	[134141.621780][T4038472]  vring_interrupt+0xdd/0x170
	[134141.624481][T4038472]  __handle_irq_event_percpu+0x168/0x440
	[134141.627133][T4038472]  handle_irq_event+0xba/0x160
	[134141.628319][T4038472]  handle_edge_irq+0x122/0x3e0
	[134141.629489][T4038472]  __common_interrupt+0x85/0x170
	[134141.630684][T4038472]  common_interrupt+0xae/0xd0
	[134141.631858][T4038472]  asm_common_interrupt+0x1e/0x40

	__free_raid_bio+0x155/0x1a0:

	__free_raid_bio at fs/btrfs/raid56.c:841
	 836                    }
	 837            }
	 838
	 839            btrfs_put_bioc(rbio->bioc);
	 840            kfree(rbio);
	>841<   }
	 842
	 843    static void rbio_endio_bio_list(struct bio *cur, blk_status_t err)
	 844    {
	 845            struct bio *next;
	 846

	__remove_rbio_from_cache+0x1bd/0x2e0:

	__remove_rbio_from_cache at fs/btrfs/raid56.c:389
	 384            spin_unlock(&rbio->bio_list_lock);
	 385            spin_unlock(&h->lock);
	 386
	 387            if (freeit)
	 388                    __free_raid_bio(rbio);
	>389<   }
	 390
	 391    /*
	 392     * prune a given rbio from the cache
	 393     */
	 394    static void remove_rbio_from_cache(struct btrfs_raid_bio *rbio)

	[134141.633113][T4038472]
	[134141.633665][T4038472] Last potentially related work creation:
	[134141.634969][T4038472]  kasan_save_stack+0x26/0x60
	[134141.636505][T4038472]  __kasan_record_aux_stack+0x9b/0xb0
	[134141.637780][T4038472]  kasan_record_aux_stack_noalloc+0xb/0x10
	[134141.639191][T4038472]  insert_work+0x3a/0x170
	[134141.640332][T4038472]  __queue_work+0x35b/0x810
	[134141.641489][T4038472]  queue_work_on+0x9d/0xb0
	[134141.642609][T4038472]  btrfs_queue_work+0x178/0x280
	[134141.643844][T4038472]  raid56_parity_write+0x2a7/0x2b0
	[134141.645180][T4038472]  btrfs_map_bio+0x762/0x930
	[134141.646396][T4038472]  run_one_async_done+0xa9/0x120
	[134141.648004][T4038472]  btrfs_work_helper+0x16f/0x620
	[134141.649302][T4038472]  process_one_work+0x56b/0xac0
	[134141.650537][T4038472]  worker_thread+0x2f1/0x700
	[134141.651733][T4038472]  kthread+0x254/0x290
	[134141.652784][T4038472]  ret_from_fork+0x22/0x30

	btrfs_queue_work+0x178/0x280:

	btrfs_queue_work at fs/btrfs/async-thread.c:379
	 374            if (test_bit(WORK_HIGH_PRIO_BIT, &work->flags) && wq->high)
	 375                    dest_wq = wq->high;
	 376            else
	 377                    dest_wq = wq->normal;
	 378            __btrfs_queue_work(dest_wq, work);
	>379<   }
	 380
	 381    static inline void
	 382    __btrfs_destroy_workqueue(struct __btrfs_workqueue *wq)
	 383    {
	 384            destroy_workqueue(wq->normal_wq);

	raid56_parity_write+0x2a7/0x2b0:

	raid56_parity_write at fs/btrfs/raid56.c:1762
	 1757                   }
	 1758                   list_add_tail(&rbio->plug_list, &plug->rbio_list);
	 1759                   ret = 0;
	 1760           } else {
	 1761                   ret = __raid56_parity_write(rbio);
	>1762<                  if (ret)
	 1763                           btrfs_bio_counter_dec(fs_info);
	 1764           }
	 1765           return ret;
	 1766   }
	 1767

	[134141.653929][T4038472] 
	[134141.654566][T4038472] The buggy address belongs to the object at ffff888129702800
	[134141.654566][T4038472]  which belongs to the cache kmalloc-1k of size 1024
	[134141.658180][T4038472] The buggy address is located 0 bytes inside of
	[134141.658180][T4038472]  1024-byte region [ffff888129702800, ffff888129702c00)
	[134141.661501][T4038472] The buggy address belongs to the page:
	[134141.662974][T4038472] page:0000000039d6f61b refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8881092366c0 pfn:0x129702
	[134141.665899][T4038472] flags: 0x17ffe0000000200(slab|node=0|zone=2|lastcpupid=0x3fff)
	[134141.667918][T4038472] raw: 017ffe0000000200 ffffea0000dab088 ffffea0005a93a48 ffff888101040e40
	[134141.670096][T4038472] raw: ffff8881092366c0 ffff888129702000 0000000100000002 0000000000000000
	[134141.672370][T4038472] page dumped because: kasan: bad access detected
	[134141.674074][T4038472] 
	[134141.674732][T4038472] Memory state around the buggy address:
	[134141.676208][T4038472]  ffff888129702700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
	[134141.678323][T4038472]  ffff888129702780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
	[134141.680404][T4038472] >ffff888129702800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
	[134141.682559][T4038472]                    ^
	[134141.683674][T4038472]  ffff888129702880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
	[134141.685883][T4038472]  ffff888129702900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
	[134141.688125][T4038472] ==================================================================
	[134141.690315][T4038472] BUG: kernel NULL pointer dereference, address: 0000000000000000
	[134141.692465][T4038472] #PF: supervisor read access in kernel mode
	[134141.694157][T4038472] #PF: error_code(0x0000) - not-present page
	[134141.695832][T4038472] PGD 0 P4D 0
	[134141.696773][T4038472] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
	[134141.698327][T4038472] CPU: 1 PID: 4038472 Comm: kworker/u8:24 Tainted: G    B   W         5.16.0-77deb3be908f-misc-next+ #141 4aa87610d6aeaaaf53dd48d092c1e09cd06399d8
	[134141.702374][T4038472] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	[134141.704857][T4038472] Workqueue: btrfs-worker btrfs_work_helper
	[134141.706417][T4038472] RIP: 0010:__remove_rbio_from_cache+0x47/0x2e0
	[134141.708099][T4038472] Code: 48 83 ec 10 e8 2a e0 b3 ff 49 8b 1c 24 48 8d 7b 50 e8 1d e0 b3 ff 48 8b 5b 50 48 89 df e8 11 e0 b3 ff be 08 00 00 00 4c 89 ff <4c> 8b 2b e8 a1 ea b3 ff 4c 89 ff e8 f9 df b3 ff 49 8b 84 24 18 01
	[134141.713268][T4038472] RSP: 0018:ffffc90002e4fa20 EFLAGS: 00010086
	[134141.714890][T4038472] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffaba3d0bf
	[134141.717029][T4038472] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888129702918
	[134141.719101][T4038472] RBP: ffffc90002e4fa58 R08: ffffffffab17ef68 R09: ffffffffae594e83
	[134141.721164][T4038472] R10: fffffbfff5cb29d0 R11: 0000000000000001 R12: ffff888129702800
	[134141.723172][T4038472] R13: ffff888149580010 R14: 0000000000000282 R15: ffff888129702918
	[134141.725147][T4038472] FS:  0000000000000000(0000) GS:ffff8881f1000000(0000) knlGS:0000000000000000
	[134141.727355][T4038472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[134141.728995][T4038472] CR2: 0000000000000000 CR3: 000000005e8ec005 CR4: 0000000000170ee0
	[134141.730918][T4038472] Call Trace:
	[134141.731770][T4038472]  <TASK>
	[134141.732535][T4038472]  remove_rbio_from_cache+0x7d/0x90
	[134141.733857][T4038472]  lock_stripe_add+0x1c7/0x700
	[134141.735061][T4038472]  raid56_parity_write+0x253/0x2b0
	[134141.736354][T4038472]  btrfs_map_bio+0x762/0x930
	[134141.737530][T4038472]  ? irqentry_exit+0x3a/0x90
	[134141.738689][T4038472]  ? trace_hardirqs_on+0x55/0x130
	[134141.740011][T4038472]  ? btrfs_map_sblock+0x20/0x20
	[134141.741290][T4038472]  ? lock_downgrade+0x420/0x420
	[134141.742577][T4038472]  ? lock_contended+0x770/0x770
	[134141.743780][T4038472]  ? do_raw_spin_lock+0x1c0/0x1c0
	[134141.745101][T4038472]  ? kfree+0x197/0x290
	[134141.746156][T4038472]  run_one_async_done+0xa9/0x120
	[134141.747436][T4038472]  btrfs_work_helper+0x16f/0x620
	[134141.748744][T4038472]  process_one_work+0x56b/0xac0
	[134141.749972][T4038472]  ? pwq_dec_nr_in_flight+0x120/0x120
	[134141.751383][T4038472]  ? worker_thread+0xd0/0x700
	[134141.752599][T4038472]  ? kthread_data+0x38/0x50
	[134141.753757][T4038472]  worker_thread+0x2f1/0x700
	[134141.754924][T4038472]  ? trace_hardirqs_on+0x55/0x130
	[134141.756178][T4038472]  ? process_one_work+0xac0/0xac0
	[134141.757525][T4038472]  kthread+0x254/0x290
	[134141.758642][T4038472]  ? set_kthread_struct+0x80/0x80
	[134141.759977][T4038472]  ret_from_fork+0x22/0x30
	[134141.761109][T4038472]  </TASK>
	[134141.761926][T4038472] Modules linked in:
	[134141.762970][T4038472] CR2: 0000000000000000
	[134141.764057][T4038472] ---[ end trace 6c0429dcff12055d ]---
	[134141.765454][T4038472] RIP: 0010:__remove_rbio_from_cache+0x47/0x2e0
	[134141.767026][T4038472] Code: 48 83 ec 10 e8 2a e0 b3 ff 49 8b 1c 24 48 8d 7b 50 e8 1d e0 b3 ff 48 8b 5b 50 48 89 df e8 11 e0 b3 ff be 08 00 00 00 4c 89 ff <4c> 8b 2b e8 a1 ea b3 ff 4c 89 ff e8 f9 df b3 ff 49 8b 84 24 18 01
	[134141.771832][T4038472] RSP: 0018:ffffc90002e4fa20 EFLAGS: 00010086
	[134141.773284][T4038472] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffaba3d0bf
	[134141.775321][T4038472] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888129702918
	[134141.777344][T4038472] RBP: ffffc90002e4fa58 R08: ffffffffab17ef68 R09: ffffffffae594e83
	[134141.779460][T4038472] R10: fffffbfff5cb29d0 R11: 0000000000000001 R12: ffff888129702800
	[134141.781654][T4038472] R13: ffff888149580010 R14: 0000000000000282 R15: ffff888129702918
	[134141.783746][T4038472] FS:  0000000000000000(0000) GS:ffff8881f1000000(0000) knlGS:0000000000000000
	[134141.786112][T4038472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[134141.787872][T4038472] CR2: 0000000000000000 CR3: 000000005e8ec005 CR4: 0000000000170ee0
	[134141.789968][T4038472] note: kworker/u8:24[4038472] exited with preempt_count 1
