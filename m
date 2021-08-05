Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191863E0C95
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 05:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhHEDAQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 23:00:16 -0400
Received: from mail.synology.com ([211.23.38.101]:44708 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229609AbhHEDAQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Aug 2021 23:00:16 -0400
Subject: Re: [PATCH v2] btrfs: fix root drop key inconsistent when drop
 subvolume/snapshot fails
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1628132401; bh=lLPf/f3KnS6JfHyDEpSJk4dANSTGL9mvDwn6KsG1SyA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Vi1nRM2UFsjUrm+9ASEXbqIeJGff/SrbqlWR6kfR6b9VOE19onjDnxw9wYUR65QuT
         my5/3akSLue2O+nf1U8oX/wwAnKV5Ra73UMoNhUbQeFUNkPSKZ2FnF+iW9cUfn/HZS
         ZHEMwT1sW+r0O8C2CxTOk//L3g3c92wjK1ebN7TE=
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210804024904.2598-1-robbieko@synology.com>
 <CAL3q7H74kDr+_R=RixVyu05zBxXNqTgYh+Wibmp3vffxjwA6Yg@mail.gmail.com>
From:   robbieko <robbieko@synology.com>
Message-ID: <58bbbb8f-06d6-2976-7cb7-afffe3c8436a@synology.com>
Date:   Thu, 5 Aug 2021 11:02:23 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H74kDr+_R=RixVyu05zBxXNqTgYh+Wibmp3vffxjwA6Yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 210804-6, 2021/8/4), Outbound message
X-Antivirus-Status: Clean
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe Manana 於 2021/8/4 下午 07:56 寫道:
> On Wed, Aug 4, 2021 at 4:45 AM robbieko <robbieko@synology.com> wrote:
>> From: Robbie Ko <robbieko@synology.com>
>>
>> When walk down/up tree fails, we did not aborting the transaction,
>> nor did modify the root drop key, but the refs of some tree blocks
>> may have been removed in the transaction.
>>
>> Therefore when we retry to delete the subvolume in the future,
>> we will fail due to the fact that some references were deleted
>> in the previous attempt.
>>
>> ------------[ cut here ]------------
>> WARNING: at fs/btrfs/extent-tree.c:898 btrfs_lookup_extent_info+0x40a/0x4c0 [btrfs]()
>> CPU: 2 PID: 11618 Comm: btrfs-cleaner Tainted: P
>> Hardware name: Synology Inc. RS3617xs Series/Type2 - Board Product Name1, BIOS M.017 2019/10/16
>> ffffffff814c2246 ffffffff81036536 ffff88024a911d08 ffff880262de45b0
>> ffff8802448b5f20 ffff88024a9c1ad8 0000000000000000 ffffffffa08eb05a
>> 000008f84e72c000 0000000000000000 0000000000000001 0000000100000000
>> Call Trace:
>> [<ffffffff814c2246>] ? dump_stack+0xc/0x15
>> [<ffffffff81036536>] ? warn_slowpath_common+0x56/0x70
>> [<ffffffffa08eb05a>] ? btrfs_lookup_extent_info+0x40a/0x4c0 [btrfs]
>> [<ffffffffa08ee558>] ? do_walk_down+0x128/0x750 [btrfs]
>> [<ffffffffa08ebab4>] ? walk_down_proc+0x314/0x330 [btrfs]
>> [<ffffffffa08eec42>] ? walk_down_tree+0xc2/0xf0 [btrfs]
>> [<ffffffffa08f2bce>] ? btrfs_drop_snapshot+0x40e/0x9a0 [btrfs]
>> [<ffffffffa09096db>] ? btrfs_clean_one_deleted_snapshot+0xab/0xe0 [btrfs]
>> [<ffffffffa08fe970>] ? cleaner_kthread+0x280/0x320 [btrfs]
>> [<ffffffff81052eaf>] ? kthread+0xaf/0xc0
>> [<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
>> [<ffffffff814c8c0d>] ? ret_from_fork+0x5d/0xb0
>> [<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
>> ------------[ end trace ]-----------
>> BTRFS error (device dm-1): Missing references.
>> BTRFS: error (device dm-1) in btrfs_drop_snapshot:9557: errno=-5 IO failure
>>
>> By not aborting the transaction, every future attempt to delete the
>> subvolume fails and we end up never freeing all the extents used by
>> the subvolume/snapshot.
>>
>> By aborting the transaction we have a least the possibility to
>> succeeded after unmounting and mounting again the filesystem.
>>
>> So we fix this problem by aborting the transaction when the walk down/up
>> tree fails, which is a safer approach.
> Ok, this still misses the explanation on why we can't solve the
> problem by simply updating the drop_progress and drop_level when we
> get an error from walk_up_tree() or walk_down_tree().

I don't fully understand the walk up/down tree part, so I am not sure if 
drop_progress and drop_level are correct. So it’s safer for me to abort 
the transaction.


>> In addition, we also added the initialization of drop_progress and
>> drop_level.
> So, this about initializing drop_progress and drop_level seems like a
> separate change.
> How is this related to the original problem?
>
> It completely lacks an explanation about why it's needed, how it
> relates to the original problem.
>
> If it's unrelated, then it should go into a separate patch with a
> proper explanation in its changelog.

This part is really not related to the original problem, but I think 
there is a potential risk, I will separate it into another patch.


>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>> ---
>>   fs/btrfs/extent-tree.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 268ce58d4569..032a257fdb65 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -5539,10 +5539,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>>                  path->locks[level] = BTRFS_WRITE_LOCK;
>>                  memset(&wc->update_progress, 0,
>>                         sizeof(wc->update_progress));
>> +               memset(&wc->drop_progress, 0,
>> +                      sizeof(wc->drop_progress));
> I don't see why this is needed.
> wc was allocated with kzalloc(), how can wc->drop_progress not be
> already zeroed here?

Yes, it's should all be zero.
But I think the wording of update_progress should be consistent.

>
> Also, walk_up_tree() and walk_down_tree() never read from
> wc->drop_progress. We use wc->drop_progress only for storing after
> walk up/walk down and then copy it into the root item for persistence.
>
>>          } else {
>>                  btrfs_disk_key_to_cpu(&key, &root_item->drop_progress);
>>                  memcpy(&wc->update_progress, &key,
>>                         sizeof(wc->update_progress));
>> +               memcpy(&wc->drop_progress, &key,
>> +                      sizeof(wc->drop_progress));
> Why is this needed?
> Except when starting the subvolume/snapshot drop, before entering the
> loop with the walk up and down logic, we never read wc->drop_progress.
>
> wc->drop_progress is meant only for storing into the root_item after
> each walk up/walk down iteration, we never read from it during the
> walks.

Indeed, drop_progress is only used to storing into the root item after 
each walk up/down iteration. But this value is not updated every time, 
when the stage is UPDATE_BACKREF, we may update 0 into to the root item, 
resulting in inconsistent drop_progress.

So I think we must initialize drop_progress and drop_level.

>>                  level = btrfs_root_drop_level(root_item);
>>                  BUG_ON(level == 0);
>> @@ -5588,6 +5592,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>>
>>          wc->restarted = test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
>>          wc->level = level;
>> +       wc->drop_level = level;
> I don't understand why this is needed too.
> We never read from wc->drop_level during the walk up and walk down,
> it's only used to store a level during/after each walk up and walk
> down iteration, and if the walks succeeded we
> set wc->drop_level to wc->level and then copy it into the root item.

This is not always true.
If the stage is UPDATE_BACKREF, drop_level and drop_progress will not be updated,
so the root item may write 0, resulting in inconsistent drop_progress.


>
> So please provide an explanation on why these initializations are
> needed and how they relate to the original problem.
> If they are not related to the original problem, then move them into a
> separate patch, with all the proper explanations in the changelog.
>
> Thanks.
>
>
>>          wc->shared_level = -1;
>>          wc->stage = DROP_REFERENCE;
>>          wc->update_ref = update_ref;
>> @@ -5659,8 +5664,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>>                  }
>>          }
>>          btrfs_release_path(path);
>> -       if (err)
>> +       if (err) {
>> +               btrfs_abort_transaction(trans, err);
>>                  goto out_end_trans;
>> +       }
>>
>>          ret = btrfs_del_root(trans, &root->root_key);
>>          if (ret) {
>> --
>> 2.17.1
>>
>


-- 
Avast 防毒軟體已檢查此封電子郵件的病毒。
https://www.avast.com/antivirus

