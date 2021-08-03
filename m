Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDD13DE727
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Aug 2021 09:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhHCHWS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Aug 2021 03:22:18 -0400
Received: from mail.synology.com ([211.23.38.101]:49162 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233966AbhHCHWS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Aug 2021 03:22:18 -0400
Subject: Re: [PATCH] Btrfs: fix root drop key mismatch when drop snapshot
 fails
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1627975326; bh=mbCup/gC+gQdYwOobdJrtXDB9NdxqKn9I3Z75IN4Igg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UbKRBKtya5wH7VZlkpiRnGUNiU3WU4Uz/tSRHGZgxC51QGOdVJ0EDbzH1F7ltm3h2
         6oolfE0Olbu8BNATrktzCaPNhRr3WUECcKRRTSg7UMTEyKEg1VzmqR07viYMhvgEqd
         3rapTJJFSk8sPKCBDEa0dy3regu9tEAXDrW/ePrI=
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210802104004.733-1-robbieko@synology.com>
 <CAL3q7H6BpnTLqugMh7NrSSqdB4NE4HnuWPYmKOV79UD3v3UBsA@mail.gmail.com>
From:   robbieko <robbieko@synology.com>
Message-ID: <625dc2dd-95ff-3806-0d47-909b7654b639@synology.com>
Date:   Tue, 3 Aug 2021 15:24:33 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6BpnTLqugMh7NrSSqdB4NE4HnuWPYmKOV79UD3v3UBsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 210803-0, 2021/8/3), Outbound message
X-Antivirus-Status: Clean
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe Manana 於 2021/8/2 下午 07:28 寫道:
> On Mon, Aug 2, 2021 at 11:41 AM robbieko <robbieko@synology.com> wrote:
>> From: Robbie Ko <robbieko@synology.com>
>>
>> When walk down/up tree fails, we did not abort the transaction,
>> nor did modify the root drop key, but the refs of some tree blocks
>> may have been removed in the transaction.
>>
>> Therefore, when we retry to delete subvol in the future, and
>> missing reference occurs when lookup extent info.
> This sentence is confusing, it took me some time to understand it.
>
> Something like:
>
> Therefore when we retry to delete the subvolume in the future, we will
> fail due to
> the fact that some references were deleted in the previous attempt:
>
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
>> ------------[ end trace ]------------
>> BTRFS error (device dm-1): Missing references.
>> BTRFS: error (device dm-1) in btrfs_drop_snapshot:9557: errno=-5 IO failure
>>
>> We fix this problem by abort trnasaction when walk down/up tree fails.
> Typo in "trnasaction". Also "by aborting the transaction".
>
> Finally you should be more explicit about the problem, something like:
>
> By not aborting the transaction, every future attempt to delete the
> subvolume fails and we
> end up never freeing all the extents used by the subvolume/snapshot.
> By aborting the transaction we have a least the possibility to
> succeeded after unmounting
> and mounting again the filesystem.
>
> Also use "btrfs: " instead of "Btrfs: " in the subject.
>
> Now my question is, why can't the problem be solved by ensuring we
> persist a correct drop progress key?

Aborting the transaction is a safer practice.
If we want to ensure drop progress, we need to check error handling in 
different situations, which is a more complicated part.
For example, we first modified wc->drop_progress and wc->drop_level in 
do_walk_down, and then went to the free extent. If the free extent 
fails, the drop_progress and drop_level are incorrect and cannot be 
updated to root_item. In addition, I found a potential risk. We will 
unconditionally update wc->drop_progress and wc->drop_level back to the 
root item, but the above two values ​​are 0 at the time of 
initialization, and not initialized to root_item->drop_progress, 
resulting in Clear root_item->drop_porgress to 0 during resume subvol 
delete. Cause the drop key to be inconsistent.

That is, if walk up or walk down fails, still try to update the drop
progress and the root item with the new drop progress - aborting the
transaction only if we get an error updating the root item.

Is there a reason why that can't be done? If that does not work, it
should be mentioned in the change log.

Thanks.


>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>> ---
>>   fs/btrfs/extent-tree.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 268ce58d4569..49cdb7eeccb3 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -5659,8 +5659,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
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
> --
> Filipe David Manana,
>
> “Whether you think you can, or you think you can't — you're right.”



-- 
Avast 防毒軟體已檢查此封電子郵件的病毒。
https://www.avast.com/antivirus

