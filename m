Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E0B672DD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 02:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjASBJG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Jan 2023 20:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASBJF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Jan 2023 20:09:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E4F2B607
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jan 2023 17:09:03 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1okMFO1oRx-00ajvi; Thu, 19
 Jan 2023 02:08:56 +0100
Message-ID: <85d98cf7-7e68-50c7-e7e1-bd90e35c7934@gmx.com>
Date:   Thu, 19 Jan 2023 09:08:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <07df5461bf34cf138f2f4b281a6fa6a0b389ff68.1673568238.git.boris@bur.io>
 <930c95d4-c55d-cbb3-ce2b-73c4333795d2@gmx.com>
Subject: Re: [PATCH] btrfs: hold block_group refcount during async discard
In-Reply-To: <930c95d4-c55d-cbb3-ce2b-73c4333795d2@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Au71HM8+A1ea9Dlg1TCP5fceil+SwEqucXRfKS5RR7CDZbC5xlM
 a+xZtVDF5V0oaqN0WJ5T5K5xbeaYHIyK4+ZrVp96CR2rUxmJnRM/EEaLVON1vo/dyAgPDBz
 aeoKB/avqwrCzVnXVlRHXyUnbPW32Yx3kmCNHcwLK7jjZEI1zimKqEo1khovG/ctxLgQaWL
 SeJNnlkoVFL2t/W1p6lOw==
UI-OutboundReport: notjunk:1;M01:P0:wVqAodN3P5Q=;TOtdguk8C6NHrkTmUplkPVCsQkt
 toRrtOLC9FuG42xd89iyuOCACXnKz0l9zHwix/Pui9Mrz2iFuID3PfhcfOjMUXUyh+SMHln++
 FLggGrGrWzUMG4izZslQOjKFnKywyFVcbN0hfSvLZgK1/IqXq2qYADxMnud4ZX6DZzwEbaT5e
 pU59e1FiYh+qsapxTZj1I+dxamlY7tdMXTx4cndT5lTxuIkAoSMFcwqYJJyrKt+0ytPXyA6Dw
 R8VZ222o+BCBR8E6RKV+2iUOvs9PMRnaP3iAP+xcHaz9tjOnlkxa+xveu+RbYpxNN+c6tvo7t
 NVeNs4QjxTZpANFvFvWitl5qtq0E5kUkd0Gn6YSBBnJCxFQRU69p7ouqah5tHqCu992ZuGjwe
 GgFBtVpiK9jE14gsu5k4vmdkq3DqbaQ4bxfLmmOg/Y8BFg8W3VLtWC6BVD4wZMJ8AyQPR/C3+
 KhzLlVVIJ0NksGSS6I3kbH8HxGC1KYVhEIWjqYfCr65Tdglowswpj9KVp1blVwQaUZI9Kx5ik
 wX1Gp0box814f8XTXaGlW2/BuSUcPe5XymkJHIbvVWzXF7roYGwZ7bZEy2yEcELJSjTi6SicP
 frmvEtjLTT1I8uWmy3L3H6IMq522QPeAmn45699zcP7WkCeJxq0rZ2QaPLfns85o6S58JyN9M
 R3X2xcaGKq4dNxev1r9EseXo5bJ53sVk1aPaNZQ8wHN+5T/GWEnv+6CyEB1fK20fkICkf9uCw
 7wW2hlxJK4nGk8AGWsyXqlAmrTkGhaSOTN5IDj0HjGn4IqJZewk5KFOiaC+BfpDTfqB953J1T
 RYksmNBJmYfvgvo6D9lLy1BU/tzyTaQq+rDFZFf3mV2d3ShldWYY8p1HUv6+Aghkscl/H8fTJ
 GALnomXma1n++euwDMAM9bNn23tYEa6MUBD9oxKm/ZnkiTJGCyZQL3Qw7B5yRji7ixLDz/Cxb
 CWGeySz9U8kAlTGxvO5ErcxP2s8=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/19 08:21, Qu Wenruo wrote:
> 
> 
> On 2023/1/13 08:05, Boris Burkov wrote:
>> Async discard does not acquire the block group reference count while it
>> holds a reference on the discard list. This is generally OK, as the
>> paths which destroy block groups tend to try to synchronize on
>> cancelling async discard work. However, relying on cancelling work
>> requires careful analysis to be sure it is safe from races with
>> unpinning scheduling more work.
>>
>> While I am unable to find a race with unpinning in the current code for
>> either the unused bgs or relocation paths, I believe we have one in an
>> older version of auto relocation in a Meta internal build. This suggests
>> that this is in fact an error prone model, and could be fragile to
>> future changes to these bg deletion paths.
>>
>> To make this ownership more clear, add a refcount for async discard. If
>> work is queued for a block group, its refcount should be incremented,
>> and when work is completed or canceled, it should be decremented.
>>
>> Signed-off-by: Boris Burkov <boris@bur.io>
> 
> It looks like the patch is causing btrfs/011 to panic with the following 
> ASSERT() failure:
> 
> assertion failed: refcount_read(&block_group->refs) == 1, in 
> fs/btrfs/block-group.c:4259
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/messages.c:259!
> Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> Modules linked in: btrfs xor xor_neon raid6_pq zstd_compress vfat fat 
> cfg80211 rfkill dm_mod fuse ext4 mbcache jbd2 virtio_blk virtio_net 
> virtio_rng net_failover virtio_balloon failover virtio_pci 
> virtio_pci_legacy_dev virtio_mmio virtio_pci_modern_dev
> CPU: 3 PID: 166866 Comm: umount Not tainted 6.2.0-rc4-custom+ #16
> Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : btrfs_assertfail+0x28/0x2c [btrfs]
> lr : btrfs_assertfail+0x28/0x2c [btrfs]
> sp : ffff80000ff9bc20
> x29: ffff80000ff9bc20 x28: ffff0000ebde2dc0 x27: 0000000000000000
> x26: 0000000000000000 x25: ffff0000c30c9000 x24: dead000000000100
> x23: dead000000000122 x22: ffff0000c11c9090 x21: ffff0000c11c9088
> x20: ffff0000c11c9000 x19: ffff0000c30c90d8 x18: ffffffffffffffff
> x17: 2f7366206e69202c x16: 31203d3d20297366 x15: 65723e2d70756f72
> x14: 675f6b636f6c6226 x13: ffff80000919ace8 x12: 0000000000000e0d
> x11: 00000000000004af x10: ffff80000924ace8 x9 : ffff80000919ace8
> x8 : 00000000ffffdfff x7 : ffff80000924ace8 x6 : 80000000ffffe000
> x5 : 0000000000000000 x4 : 0000000000000002 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : ffff0000ebde2dc0 x0 : 0000000000000058
> Call trace:
>   btrfs_assertfail+0x28/0x2c [btrfs]
>   btrfs_free_block_groups+0x420/0x480 [btrfs]
>   close_ctree+0x470/0x4d0 [btrfs]
>   btrfs_put_super+0x14/0x20 [btrfs]
>   generic_shutdown_super+0x7c/0x120
>   kill_anon_super+0x18/0x40
>   btrfs_kill_super+0x18/0x30 [btrfs]
>   deactivate_locked_super+0x44/0xe0
>   deactivate_super+0x88/0xa0
>   cleanup_mnt+0x9c/0x130
>   __cleanup_mnt+0x14/0x20
>   task_work_run+0x80/0xe0
>   do_notify_resume+0x124/0x1b0
>   el0_svc+0x74/0x84
>   el0t_64_sync_handler+0xf4/0x120
>   el0t_64_sync+0x190/0x194
> Code: aa0403e2 b0000100 9134e000 95f1de14 (d4210000)
> ---[ end trace 0000000000000000 ]---
> 
> Weirdly on x86_64 it's very hard to reproduce.
> I have to go my aarch64 machine to reliably reproduce it.

Extra info on the reproducibility.

The 100% reproducibility needs to run at least btrfs/010 and btrfs/011 
on aarch64.
I normally just go `-g auto` and it's 100% reproducible on aarch64 at least.

With "-g auto" run, I can also reproduce it on x86_64 now.

And with the extra reproducibility, I can confirm with this patch 
reverted the crash is gone for sure.

Thanks,
Qu

> 
> With this patch (already in misc-next), my aarch64 VM failed 2/2 during 
> daily runs.
> With this patch reverted, I haven't hit it in 8 runs.
> 
> Thus I guess there is some race in the patch.
> 
> Thanks,
> Qu
> 
>> ---
>>   fs/btrfs/discard.c | 25 +++++++++++++++++++++++--
>>   1 file changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
>> index ff2e524d9937..bcfd8beca543 100644
>> --- a/fs/btrfs/discard.c
>> +++ b/fs/btrfs/discard.c
>> @@ -89,6 +89,8 @@ static void __add_to_discard_list(struct 
>> btrfs_discard_ctl *discard_ctl,
>>                                 BTRFS_DISCARD_DELAY);
>>           block_group->discard_state = BTRFS_DISCARD_RESET_CURSOR;
>>       }
>> +    if (list_empty(&block_group->discard_list))
>> +        btrfs_get_block_group(block_group);
>>       list_move_tail(&block_group->discard_list,
>>                  get_discard_list(discard_ctl, block_group));
>> @@ -108,8 +110,12 @@ static void add_to_discard_list(struct 
>> btrfs_discard_ctl *discard_ctl,
>>   static void add_to_discard_unused_list(struct btrfs_discard_ctl 
>> *discard_ctl,
>>                          struct btrfs_block_group *block_group)
>>   {
>> +    bool queued;
>> +
>>       spin_lock(&discard_ctl->lock);
>> +    queued = !list_empty(&block_group->discard_list);
>> +
>>       if (!btrfs_run_discard_work(discard_ctl)) {
>>           spin_unlock(&discard_ctl->lock);
>>           return;
>> @@ -121,6 +127,8 @@ static void add_to_discard_unused_list(struct 
>> btrfs_discard_ctl *discard_ctl,
>>       block_group->discard_eligible_time = (ktime_get_ns() +
>>                             BTRFS_DISCARD_UNUSED_DELAY);
>>       block_group->discard_state = BTRFS_DISCARD_RESET_CURSOR;
>> +    if (!queued)
>> +        btrfs_get_block_group(block_group);
>>       list_add_tail(&block_group->discard_list,
>>                 &discard_ctl->discard_list[BTRFS_DISCARD_INDEX_UNUSED]);
>> @@ -131,6 +139,7 @@ static bool remove_from_discard_list(struct 
>> btrfs_discard_ctl *discard_ctl,
>>                        struct btrfs_block_group *block_group)
>>   {
>>       bool running = false;
>> +    bool queued = false;
>>       spin_lock(&discard_ctl->lock);
>> @@ -140,7 +149,10 @@ static bool remove_from_discard_list(struct 
>> btrfs_discard_ctl *discard_ctl,
>>       }
>>       block_group->discard_eligible_time = 0;
>> +    queued = !list_empty(&block_group->discard_list);
>>       list_del_init(&block_group->discard_list);
>> +    if (queued && !running)
>> +        btrfs_put_block_group(block_group);
>>       spin_unlock(&discard_ctl->lock);
>> @@ -216,8 +228,10 @@ static struct btrfs_block_group *peek_discard_list(
>>               block_group->used != 0) {
>>               if (btrfs_is_block_group_data_only(block_group))
>>                   __add_to_discard_list(discard_ctl, block_group);
>> -            else
>> +            else {
>>                   list_del_init(&block_group->discard_list);
>> +                btrfs_put_block_group(block_group);
>> +            }
>>               goto again;
>>           }
>>           if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
>> @@ -511,6 +525,8 @@ static void btrfs_discard_workfn(struct 
>> work_struct *work)
>>       spin_lock(&discard_ctl->lock);
>>       discard_ctl->prev_discard = trimmed;
>>       discard_ctl->prev_discard_time = now;
>> +    if (list_empty(&block_group->discard_list))
>> +        btrfs_put_block_group(block_group);
>>       discard_ctl->block_group = NULL;
>>       __btrfs_discard_schedule_work(discard_ctl, now, false);
>>       spin_unlock(&discard_ctl->lock);
>> @@ -651,8 +667,12 @@ void btrfs_discard_punt_unused_bgs_list(struct 
>> btrfs_fs_info *fs_info)
>>       list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
>>                    bg_list) {
>>           list_del_init(&block_group->bg_list);
>> -        btrfs_put_block_group(block_group);
>>           btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
>> +        /*
>> +         * This put is for the get done by btrfs_mark_bg_unused.
>> +         * queueing discard incremented it for discard's reference.
>> +         */
>> +        btrfs_put_block_group(block_group);
>>       }
>>       spin_unlock(&fs_info->unused_bgs_lock);
>>   }
>> @@ -683,6 +703,7 @@ static void btrfs_discard_purge_list(struct 
>> btrfs_discard_ctl *discard_ctl)
>>               if (block_group->used == 0)
>>                   btrfs_mark_bg_unused(block_group);
>>               spin_lock(&discard_ctl->lock);
>> +            btrfs_put_block_group(block_group);
>>           }
>>       }
>>       spin_unlock(&discard_ctl->lock);
