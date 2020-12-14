Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0C2D9F42
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 19:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbgLNSfq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 13:35:46 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:59502 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440905AbgLNSe0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 13:34:26 -0500
X-Greylist: delayed 1306 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2020 13:34:25 EST
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.93.0.4)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1kosK4-0000TN-Ti; Mon, 14 Dec 2020 19:11:48 +0100
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org,
        ebiggers@kernel.org, Damien.LeMoal@wdc.com, mpatocka@redhat.com,
        herbert@gondor.apana.org.au, kernel-team@cloudflare.com,
        nobuto.murata@canonical.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: dm-crypt with no_read_workqueue and no_write_workqueue + btrfs scrub
 = BUG()
Message-ID: <16ffadab-42ba-f9c7-8203-87fda3dc9b44@maciej.szmigiero.name>
Date:   Mon, 14 Dec 2020 19:11:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I hit a reproducible BUG() when scrubbing a btrfs fs on top of
a dm-crypt device with no_read_workqueue and no_write_workqueue
flags enabled.

Steps to reproduce:
1) cryptsetup create -c aes -d /dev/urandom test /dev/vdb1
2) dmsetup table test --showkeys | sed 's/$/ 2 no_read_workqueue no_write_workqueue/' | dmsetup reload test
3) dmsetup suspend test && dmsetup resume test
4) mkfs.btrfs /dev/mapper/test
5) mkdir /tmp/test; mount -t btrfs /dev/mapper/test /tmp/test/
6) dd if=/dev/zero of=/tmp/test/test bs=1M count=900; sync
7) btrfs scrub start /tmp/test

The result is:
[ 2965.025717][    C0] BUG: sleeping function called from invalid context at mm/mempool.c:381
[ 2965.025721][    C0] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2848, name: kworker/u4:0
[ 2965.025726][    C0] CPU: 0 PID: 2848 Comm: kworker/u4:0 Tainted: G                T 5.10.0-rc3+ #278
[ 2965.025727][    C0] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[ 2965.025735][    C0] Workqueue: btrfs-scrub btrfs_work_helper
[ 2965.025738][    C0] Call Trace:
[ 2965.025759][    C0]  <IRQ>
[ 2965.025766][    C0]  dump_stack+0x57/0x6a
[ 2965.025771][    C0]  ___might_sleep.cold+0x8a/0x97
[ 2965.025776][    C0]  mempool_alloc+0xcb/0x1b0
[ 2965.025781][    C0]  ? crypto_skcipher_decrypt+0x5c/0x80
[ 2965.025786][    C0]  crypt_convert+0xdf0/0xfa0
[ 2965.025793][    C0]  ? update_load_avg+0x92/0x650
[ 2965.025798][    C0]  kcryptd_crypt_read_convert+0xc5/0x100
[ 2965.025802][    C0]  tasklet_action_common.constprop.0+0xfa/0x120
[ 2965.025807][    C0]  __do_softirq+0xc4/0x2a8
[ 2965.025811][    C0]  asm_call_irq_on_stack+0x12/0x20
[ 2965.025814][    C0]  </IRQ>
[ 2965.025818][    C0]  do_softirq_own_stack+0x36/0x40
[ 2965.025821][    C0]  irq_exit_rcu+0x8d/0xc0
[ 2965.025825][    C0]  sysvec_call_function_single+0x36/0x80
[ 2965.025829][    C0]  asm_sysvec_call_function_single+0x12/0x20
[ 2965.025833][    C0] RIP: 0010:crc_18+0xa/0x1e
[ 2965.025837][    C0] Code: ff ff f2 4c 0f 38 f1 81 68 ff ff ff f2 4c 0f 38 f1 8a 68 ff ff ff f2 4d 0f 38 f1 93 68 ff ff ff f2 4c 0f 38 f1 81 70 ff ff ff <f2> 4c 0f 38 f1 8a 70 ff ff ff f2 4d 0f 38 f1 93 70 ff ff ff f2 4c
[ 2965.025839][    C0] RSP: 0018:ffffa2d04023bbf0 EFLAGS: 00000246
[ 2965.025842][    C0] RAX: 0000000000000080 RBX: 0000000000001000 RCX: ffff96e1851ef400
[ 2965.025844][    C0] RDX: ffff96e1851ef800 RSI: 0000000000001000 RDI: 0000000000000000
[ 2965.025845][    C0] RBP: ffff96e1851ef000 R08: 000000000ae37425 R09: 0000000000000000
[ 2965.025847][    C0] R10: 0000000000000000 R11: ffff96e1851efc00 R12: 0000000000001000
[ 2965.025848][    C0] R13: ffff96e18e9a6a80 R14: fffff68440000000 R15: ffff96e184d73c00
[ 2965.025854][    C0]  ? crc32c_pcl_intel_digest+0xa0/0xc0
[ 2965.025857][    C0]  ? scrub_checksum_data+0x126/0x180
[ 2965.025861][    C0]  ? update_load_avg+0x92/0x650
[ 2965.025863][    C0]  ? cpuacct_charge+0x35/0x80
[ 2965.025867][    C0]  ? check_preempt_wakeup+0xef/0x260
[ 2965.025872][    C0]  ? radix_tree_gang_lookup+0xa1/0xd0
[ 2965.025875][    C0]  ? __wake_up_common_lock+0x8a/0xc0
[ 2965.025878][    C0]  ? scrub_block_put+0x5c/0xa0
[ 2965.025880][    C0]  ? scrub_bio_end_io_worker+0x52/0x220
[ 2965.025884][    C0]  ? kfree+0x3ec/0x450
[ 2965.025887][    C0]  ? scrub_bio_end_io_worker+0xd7/0x220
[ 2965.025890][    C0]  ? btrfs_work_helper+0xdb/0x350
[ 2965.025893][    C0]  ? __schedule+0x275/0x8c0
[ 2965.025897][    C0]  ? process_one_work+0x1d6/0x3b0
[ 2965.025901][    C0]  ? worker_thread+0x53/0x400
[ 2965.025904][    C0]  ? rescuer_thread+0x440/0x440
[ 2965.025907][    C0]  ? kthread+0x13f/0x160
[ 2965.025910][    C0]  ? __kthread_bind_mask+0xa0/0xa0
[ 2965.025913][    C0]  ? ret_from_fork+0x22/0x30

Additionally, here is a similar BUG() backtrace I've hit on
another system, while scrubbing a btrfs fs on dm-crypt devs
with these flags enabled, the BUG() hit here was actually
scheduling while atomic:
  <IRQ>
  dump_stack+0x57/0x6a
  __schedule_bug.cold+0x47/0x53
  __schedule+0x643/0x7d0
  schedule+0x62/0xd0
  schedule_timeout+0x135/0x180
  ? cryptd_enqueue_request+0x5e/0xd0
  wait_for_completion+0x84/0xe0
  crypt_convert.constprop.0+0x7a7/0xf60
  ? crypt_endio+0x2d/0x90
  ? kmem_cache_free+0x416/0x470
  ? ktime_get+0x4a/0xc0
  kcryptd_crypt_read_convert+0xbe/0x100
  blk_update_request+0x229/0x3d0
  scsi_end_request+0x40/0x200
  scsi_io_completion+0x8e/0x5b0
  blk_done_softirq+0x87/0xb0
  __do_softirq+0xd3/0x2ed
  asm_call_irq_on_stack+0x12/0x20
  </IRQ>
  do_softirq_own_stack+0x36/0x40
  irq_exit_rcu+0x8d/0xc0
  common_interrupt+0x87/0x160
  asm_common_interrupt+0x1e/0x40
RIP: 0010:_aesni_dec4+0x2f/0x190
Code: fa 66 0f ef c2 66 0f ef e2 66 0f ef ea 66 0f ef f2 49 83 c2 30 41 83 f9 18 72 70 4d 8d 52 20 74 36 49 83 c2 20 41 0f 28 52 a0 <66> 0f 38 de c2 66 0f 38 de e2 66 0f 3
  ? _aesni_dec1+0xb0/0xb0
  ? _aesni_dec1+0xb0/0xb0
  ? aesni_xts_crypt8+0xe0/0x240
  ? __glue_xts_req_128bit+0x8f/0xc0
  ? glue_xts_req_128bit+0xc1/0x400
  ? aesni_set_key+0x1e0/0x1e0
  ? ttwu_queue_wakelist+0xb9/0xe0
  ? kcryptd_async_done+0xa6/0x210
  ? kcryptd_async_done+0xa6/0x210
  ? kfree+0x401/0x460
  ? kcryptd_async_done+0xa6/0x210
  ? crypto_skcipher_decrypt+0x4b/0x80
  ? cryptd_skcipher_decrypt+0xa6/0x130
  ? update_load_avg+0x7e/0x660
  ? set_next_entity+0xcd/0x240
  ? __switch_to_asm+0x3f/0x60
  ? finish_task_switch+0x87/0x280
  ? __schedule+0x263/0x7d0
  ? preempt_schedule+0x32/0x50
  ? preempt_schedule_thunk+0x16/0x18
  ? cryptd_queue_worker+0x8b/0xe0
  ? process_one_work+0x1d4/0x3d0
  ? worker_thread+0x50/0x3f0
  ? rescuer_thread+0x420/0x420
  ? kthread+0x134/0x160
  ? __kthread_bind_mask+0xa0/0xa0
  ? ret_from_fork+0x22/0x30

It looks like to me that the dm-crypt code in kcryptd_queue_crypt()
checks for a hard IRQ context via in_irq() before deciding whether to
offload processing to a tasklet or proceed directly, but it probably
should check for any interrupt context via in_interrupt() or similar
and then proceed with using a workqueue, as the ordinary code flow
does.

CC'ing btrfs folks in case it is actually a btrfs-specific issue.

Thanks,
Maciej

