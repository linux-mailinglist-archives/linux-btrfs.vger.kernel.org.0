Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE57624ACC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 20:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKJTkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 14:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKJTkR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 14:40:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCC245EF5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 11:40:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 233F32011B;
        Thu, 10 Nov 2022 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668109214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8d72+YY9mdMp7gnCYs0H03Kv+g0Ydx/paF+kA66W5ko=;
        b=DgnIj0uXpYFAcabSkBEddCCuvKn+vgB0FRAjCqsZylITK5QytWe8P/66EMwyTc7fW5Oo3+
        DLq7m2V2obSeccqpgcex+nkfaLLNwYT6+fkN3AkRIOuM0CPBKjvjzS7rPe7GuE3mNpsciG
        3yHH8p23WAVk1V1Cp3+Ckl1rg06+dFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668109214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8d72+YY9mdMp7gnCYs0H03Kv+g0Ydx/paF+kA66W5ko=;
        b=NaK1kvDo/4IGM5mvsPWfa62KAVUOq/qp8rgS2twxYlBKjBz0XR48hoCbuzNSHb1uAl+0Vn
        rXpa7kXxmlfjQBDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E935413B58;
        Thu, 10 Nov 2022 19:40:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 727sN51TbWO1TwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Nov 2022 19:40:13 +0000
Date:   Thu, 10 Nov 2022 20:39:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] btrfs: raid56: debug: verify all the pointers for
 generate_pq_vertical()
Message-ID: <20221110193950.GI5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0cb5e2dcb02a3f6f8f7ec1f42543d146bed31b51.1667956749.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb5e2dcb02a3f6f8f7ec1f42543d146bed31b51.1667956749.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 09, 2022 at 09:19:10AM +0800, Qu Wenruo wrote:
> David reported a KASAN error that raid6 gen_syndrome() is accessing
> beyond slab boundary:

With this patch I've hit something else. With KASAN and SLUB debug
there are some hints (stack traces at the end) that this could be
related to repair.

Full trace:

[ 2424.662991] BUG: KASAN: use-after-free in queued_spin_lock_slowpath+0x311/0x6f0
[ 2424.664382] Read of size 4 at addr ffff8881073a4508 by task kworker/u8:1/39
[ 2424.665309] 
[ 2424.665639] CPU: 3 PID: 39 Comm: kworker/u8:1 Not tainted 6.1.0-rc4-default+ #51
[ 2424.666670] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
[ 2424.668001] Workqueue: btrfs-rmw scrub_rbio_work_locked [btrfs]
[ 2424.668917] Call Trace:
[ 2424.669290]  <IRQ>
[ 2424.669632]  dump_stack_lvl+0x4c/0x5f
[ 2424.670444]  print_report+0x196/0x48e
[ 2424.671142]  ? __virt_addr_valid+0xc3/0x100
[ 2424.672609]  ? kasan_addr_to_slab+0x9/0xb0
[ 2424.673562]  ? queued_spin_lock_slowpath+0x311/0x6f0
[ 2424.674781]  kasan_report+0xbb/0xf0
[ 2424.675479]  ? queued_spin_lock_slowpath+0x311/0x6f0
[ 2424.677498]  queued_spin_lock_slowpath+0x311/0x6f0
[ 2424.678695]  ? _raw_write_unlock_irqrestore+0x50/0x50
[ 2424.679746]  ? var_wake_function+0xe0/0xe0
[ 2424.680729]  ? lock_acquire+0x144/0x3c0
[ 2424.681972]  ? lock_is_held_type+0x9b/0x100
[ 2424.682950]  do_raw_spin_lock+0x197/0x1b0
[ 2424.683558]  ? rwlock_bug.part.0+0x60/0x60
[ 2424.684191]  _raw_spin_lock_irqsave+0x7d/0x80
[ 2424.692005]  __wake_up_common_lock+0xbb/0x140
[ 2424.692801]  ? __wake_up_common+0x260/0x260
[ 2424.695034]  ? do_raw_spin_unlock+0x93/0xf0
[ 2424.695659]  blk_update_request+0x1e4/0x7b0
[ 2424.696204]  ? collect_syscall+0x120/0x300
[ 2424.696721]  blk_mq_end_request+0x26/0x40
[ 2424.697239]  virtblk_done+0xdf/0x1c0
[ 2424.697739]  ? virtio_commit_rqs+0xb0/0xb0
[ 2424.698277]  ? lock_release+0x1e7/0x6c0
[ 2424.698834]  ? reacquire_held_locks+0x270/0x270
[ 2424.699419]  vring_interrupt+0xdf/0x160
[ 2424.701486]  ? virtqueue_enable_cb+0x20/0x20
[ 2424.702469]  __handle_irq_event_percpu+0x102/
[ 2424.703617]  handle_irq_event+0x54/0xb0
[ 2424.704384]  handle_edge_irq+0xfe/0x350
[ 2424.705350]  __common_interrupt+0x5b/0x140
[ 2424.706551]  common_interrupt+0x75/0xa0
[ 2424.707958]  </IRQ>
[ 2424.708615]  <TASK>
[ 2424.709366]  asm_common_interrupt+0x22/0x40
[ 2424.712444] RIP: 0010:__asan_load4+0x29/0x80
[ 2424.717399] RSP: 0018:ffff88810093f160 EFLAGS: 00000202
[ 2424.718452] RAX: ffffffffc02421cb RBX: ffffffffc02421e0 RCX: ffffffffae17191c
[ 2424.720173] RDX: 0000000000000003 RSI: ffffffffae1718b4 RDI: ffffffffc02421c8
[ 2424.721578] RBP: ffffffffc02421e0 R08: 0000000000000001 R09: ffffffffc04b1ebc
[ 2424.723036] R10: fffffbfff80963d7 R11: 0000000000000000 R12: ffffffffc03bd00e
[ 2424.724827] R13: 0000000000000000 R14: ffffffffaf60fa40 R15: ffffffffc0240000
[ 2424.726961]  ? 0xffffffffc0240000
[ 2424.728223]  ? scrub_rbio_work_locked+0x4ae/0x1310 [btrfs]
[ 2424.730789]  ? mod_find+0x8c/0xe0
[ 2424.731496]  ? mod_find+0x24/0xe0
[ 2424.732412]  mod_find+0x24/0xe0
[ 2424.733790]  ? scrub_rbio_work_locked+0x4ae/0x1310 [btrfs]
[ 2424.738034]  ? scrub_rbio_work_locked+0x4ae/0x1310 [btrfs]
[ 2424.739904]  __module_address+0x54/0x100
[ 2424.740948]  ? scrub_rbio_work_locked+0x4ae/0x1310 [btrfs]
[ 2424.741948]  ? scrub_rbio_work_locked+0x4ae/0x1310 [btrfs]
[ 2424.743463]  __module_text_address+0x11/0x90
[ 2424.744465]  ? scrub_rbio_work_locked+0x4ae/0x1310 [btrfs]
[ 2424.745932]  is_module_text_address+0x11/0x30
[ 2424.747072]  kernel_text_address+0x5c/0xc0
[ 2424.748046]  ? scrub_rbio_work_locked+0x4ae/0x1310 [btrfs]
[ 2424.749511]  __kernel_text_address+0xe/0x30
[ 2424.750494]  unwind_get_return_address+0x2f/0x50
[ 2424.751308]  ? same_magic+0x50/0x50
[ 2424.752234]  arch_stack_walk+0x98/0xf0
[ 2424.753166]  ? scrub_rbio_work_locked+0x4ae/0x1310 [btrfs]
[ 2424.754578]  stack_trace_save+0x91/0xc0
[ 2424.755707]  ? filter_irq_stacks+0x60/0x60
[ 2424.756736]  ? same_magic+0x50/0x50
[ 2424.757617]  ? arch_stack_walk+0x82/0xf0
[ 2424.758867]  kasan_save_stack+0x1c/0x40
[ 2424.759927]  ? kasan_save_stack+0x1c/0x40
[ 2424.760774]  ? kasan_set_track+0x21/0x30
[ 2424.761412]  ? __kasan_slab_alloc+0x65/0x70
[ 2424.762105]  ? kmem_cache_alloc+0x104/0x200
[ 2424.762702]  ? mempool_alloc+0xe1/0x260
[ 2424.763385]  ? __sg_alloc_table+0x141/0x1c0
[ 2424.764008]  ? sg_alloc_table_chained+0x43/0xd0
[ 2424.764704]  ? virtblk_map_data+0xc4/0x140
[ 2424.765292]  ? virtio_queue_rq+0xa4/0x2e0
[ 2424.765809]  ? __blk_mq_try_issue_directly+0x2bd/0x340
[ 2424.766438]  ? blk_mq_try_issue_directly+0x16/0x70
[ 2424.767041]  ? blk_mq_submit_bio+0x909/0xcd0
[ 2424.767588]  ? submit_bio_noacct_nocheck+0x442/0x480
[ 2424.768205]  ? submit_read_bios+0x108/0x2f0 [btrfs]
[ 2424.768968]  ? filter_irq_stacks+0x1d/0x60
[ 2424.769470]  ? __stack_depot_save+0x3b/0x5c0
[ 2424.771902]  ? set_track_prepare+0x40/0x60
[ 2424.772919]  ? mempool_alloc+0xe1/0x260
[ 2424.775494]  ? __sg_alloc_table+0x141/0x1c0
[ 2424.776579]  ? sg_alloc_table_chained+0x43/0xd0
[ 2424.777452]  ? virtblk_map_data+0xc4/0x140
[ 2424.778348]  ? virtio_queue_rq+0xa4/0x2e0
[ 2424.779115]  ? __blk_mq_try_issue_directly+0x2bd/0x340
[ 2424.780210]  ? blk_mq_try_issue_directly+0x16/0x70
[ 2424.781112]  ? blk_mq_submit_bio+0x909/0xcd0
[ 2424.782010]  ? submit_bio_noacct_nocheck+0x442/0x480
[ 2424.783224]  ? submit_read_bios+0x108/0x2f0 [btrfs]
[ 2424.784229]  ? scrub_rbio_work_locked+0x4ae/0x1310 [btrfs]
[ 2424.785497]  ? process_one_work+0x557/0x9d0
[ 2424.786417]  ? worker_thread+0x8f/0x630
[ 2424.787302]  ? kthread+0x146/0x180
[ 2424.788069]  ? ret_from_fork+0x1f/0x30
[ 2424.788987]  ? ___slab_alloc+0x1029/0x1180
[ 2424.790032]  ? mempool_alloc+0xe1/0x260
[ 2424.791073]  ? mark_lock+0x119/0x1650
[ 2424.791711]  kasan_set_track+0x21/0x30
[ 2424.792847]  __kasan_slab_alloc+0x65/0x70
[ 2424.793567]  ? mempool_alloc+0xe1/0x260
[ 2424.794530]  kmem_cache_alloc+0x104/0x200
[ 242....4.795691]  ? mark_lock+0x119/0x1650
[ 2424.797492]  ? mempool_kmalloc+0x20/0x20
[ 2424.798741]  mempool_alloc+0xe1/0x260
[ 2424.799892]  ? mempool_exit+0xa0/0xa0
[ 2424.801675]  ? var_wake_function+0xe0/0xe0
[ 2424.802815]  ? lock_is_held_type+0x9b/0x100
[ 2424.804093]  __sg_alloc_table+0x141/0x1c0
[ 2424.805199]  sg_alloc_table_chained+0x43/0xd0
[ 2424.809482]  ? sg_pool_free+0x50/0x50
[ 2424.811050]  virtblk_map_data+0xc4/0x140
[ 2424.817584]  ? virtblk_map_queues+0x150/0x150
[ 2424.818207]  ? trace_hardirqs_on+0x2d/0xf0
[ 2424.818857]  ? ktime_get+0x129/0x140
[ 2424.819426]  ? ktime_get+0x8c/0x140
[ 2424.819911]  ? virtblk_setup_cmd+0x7e/0x3b0
[ 2424.820563]  virtio_queue_rq+0xa4/0x2e0
[ 2424.821212]  __blk_mq_try_issue_directly+0x2bd/0x340
[ 2424.822677]  ? __blk_mq_get_driver_tag+0x3f0/0x3f0
[ 2424.824053]  ? submit_bio+0x70/0x70
[ 2424.825274]  blk_mq_try_issue_directly+0x16/0x70
[ 2424.826577]  blk_mq_submit_bio+0x909/0xcd0
[ 2424.827596]  ? blk_mq_try_issue_list_directly+0x1e0/0x1e0
[ 2424.828771]  ? lock_chain_count+0x20/0x20
[ 2424.829912]  submit_bio_noacct_nocheck+0x442/0x480
[ 2424.831166]  ? lock_is_held_type+0x9b/0x100
[ 2424.832137]  ? should_fail_request+0x50/0x50
[ 2424.833208]  ? submit_bio_noacct+0x4b3/0x830
[ 2424.834432]  submit_read_bios+0x108/0x2f0 [btrfs]
[ 2424.835709]  ? free_raid_bio+0x1d0/0x1d0 [btrfs]
[ 2424.836827]  ? rbio_add_io_sector+0x28b/0x2e0 [btrfs]
[ 2424.840506]  scrub_rbio_work_locked+0x4ae/0x1310 [btrfs]
[ 2424.841443]  ? var_wake_function+0xe0/0xe0
[ 2424.842574]  ? rmw_rbio_work_locked+0xa0/0xa0 [btrfs]
[ 2424.844083]  ? lock_downgrade+0x380/0x380
[ 2424.844725]  ? reacquire_held_locks+0x270/0x270
[ 2424.845694]  ? mark_held_locks+0x23/0x90
[ 2424.846548]  ? lock_is_held_type+0x9b/0x100
[ 2424.847631]  process_one_work+0x557/0x9d0
[ 2424.848605]  ? pwq_dec_nr_in_flight+0x100/0x100
[ 2424.849615]  ? lock_acquired+0x327/0x5b0
[ 2424.850547]  worker_thread+0x8f/0x630
[ 2424.851419]  ? process_one_work+0x9d0/0x9d0
[ 2424.852372]  kthread+0x146/0x180
[ 2424.853161]  ? kthread_complete_and_exit+0x20/0x20
[ 2424.854224]  ret_from_fork+0x1f/0x30
[ 2424.855077]  </TASK>
[ 2424.855661] 
[ 2424.856109] Allocated by task 8:
[ 2424.856874]  kasan_save_stack+0x1c/0x40
[ 2424.859469]  kasan_set_track+0x21/0x30
[ 2424.869220]  __kasan_kmalloc+0x86/0x90
[ 2424.870549]  alloc_rbio+0xb6/0x470 [btrfs]

This is ok, normal path for a request

[ 2424.872604]  raid56_parity_alloc_scrub_rbio+0x3b/0x1e0 [btrfs]
[ 2424.873580]  scrub_parity_check_and_repair+0x25a/0x300 [btrfs]
[ 2424.874701]  scrub_block_put+0x275/0x2f0 [btrfs]
[ 2424.875598]  scrub_bio_end_io_worker+0xed/0x4d0 [btrfs]
[ 2424.876507]  process_one_work+0x557/0x9d0
[ 2424.877663]  worker_thread+0x8f/0x630
[ 2424.878618]  kthread+0x146/0x180
[ 2424.879153]  ret_from_fork+0x1f/0x30
[ 2424.880146] 
[ 2424.880669] Freed by task 4823:
[ 2424.881638]  kasan_save_stack+0x1c/0x40
[ 2424.882744]  kasan_set_track+0x21/0x30
[ 2424.883718]  kasan_save_free_info+0x2a/0x40
[ 2424.884663]  ____kasan_slab_free+0x1b7/0x210
[ 2424.885746]  __kmem_cache_free+0xc7/0x1b0
[ 2424.886816]  rbio_orig_end_io+0x9d/0x110 [btrfs]

Freed in end io - perhaps too early

[ 2424.888108]  scrub_rbio_work_locked+0x440/0x1310 [btrfs]
[ 2424.889493]  process_one_work+0x557/0x9d0
[ 2424.890343]  worker_thread+0x8f/0x630
[ 2424.891246]  kthread+0x146/0x180
[ 2424.892070]  ret_from_fork+0x1f/0x30
[ 2424.893235] 
[ 2424.893708] Last potentially related work creation:
[ 2424.895204]  kasan_save_stack+0x1c/0x40
[ 2424.897723]  __kasan_record_aux_stack+0x100/0x110
[ 2424.899102]  insert_work+0x32/0x150
[ 2424.900714]  __queue_work+0x2f6/0x790
[ 2424.901589]  queue_work_on+0x70/0x80
[ 2424.902360]  scrub_parity_check_and_repair+0x283/0x300 [btrfs]

This is speculative, but I don't have any other idea. A repair request
took longer to process, meanwhile the endio freed it. This would be a
problem with reference counts and with in-flight bio tracking.

[ 2424.903491]  scrub_block_put+0x275/0x2f0 [btrfs]
[ 2424.904789]  scrub_bio_end_io_worker+0xed/0x4d0 [btrfs]
[ 2424.905671]  process_one_work+0x557/0x9d0
[ 2424.907220]  worker_thread+0x8f/0x630
[ 2424.908146]  kthread+0x146/0x180
[ 2424.909055]  ret_from_fork+0x1f/0x30
[ 2424.909826] 
[ 2424.910264] The buggy address belongs to the object at ffff8881073a4400
[ 2424.910264]  which belongs to the cache kmallo... .c-512 of size 512
[ 2424.912849] The buggy address is located 264 bytes inside of
[ 2424.912849]  512-byte region [ffff8881073a4400, ffff8881073a4600)
[ 2424.915502] 
[ 2424.916459] The buggy address belongs to the physical page:
[ 2424.918064] page:ffff88813efce800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1073a0
[ 2424.920130] head:ffff88813efce800 order:3 compound_mapcount:0 compound_pincount:0
[ 2424.921915] flags: 0x4100000010200(slab|head|section=32|zone=2)
[ 2424.924317] raw: 0004100000010200 ffff88813ef9d408 ffff88813ef01a08 ffff888100042f40
[ 2424.925278] raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
[ 2424.926207] page dumped because: kasan: bad access detected
[ 2424.926807] 
[ 2424.927084] Memory state around the buggy address:
[ 2424.927625]  ffff8881073a4400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2424.928419]  ffff8881073a4480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2424.930274] >ffff8881073a4500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2424.931902]                       ^
[ 2424.932686]  ffff8881073a4580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2424.934224]  ffff8881073a4600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 2424.935717] ==================================================================

> This patch is a mostly debugging one, including the following changes:
> 
> - Try to access the beginning and end of a sector
>   To make sure we have correct sector assembled.
> 
> - Avoid "pointers[stripe++]" usage
>   This is super common question for every C language learner, but for
>   real practice usage, it should be avoided, as it takes reader extra
>   seconds to consider when the value really get increased.
> 
>   Instead let's use rbio->nr_data to grab P/Q stripe number.

I don't see anything related to the added debugging, so the pointers are
probably OK.

> And to no one's surprise, I can not reproduce it even with the debug
> patch.

I've hit this on 2nd run, the KASAN increases the run time but it's
bearable.
