Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD50C4B1E81
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 07:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiBKGV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 01:21:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiBKGV4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 01:21:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF603B32
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 22:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644560505;
        bh=ZW2Z+3hLU4kkZ8dC1sJYHTRdPPJFGVtkeauMz3ookZU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=D5j0Xq6WW/cxa1uHgLo4i9z1v8j5UYBCPlPZnodJ86RXAGtI7ykVsZQvLPKF7dofX
         NRLu62knpT/Zw1xK8iKmZZbA2i+HlELUwH011htpcWGwzlGqs660VooXuNWqc++YMh
         qI+DS1sFiuyNKAfp4GYf4kornz5fCOhjKu1AvDbw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hvb-1oGsPg2xnj-011nKs; Fri, 11
 Feb 2022 07:21:44 +0100
Message-ID: <68125bf2-af43-916d-b141-bd8a7c53541b@gmx.com>
Date:   Fri, 11 Feb 2022 14:21:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH RFC 3/3] btrfs: make autodefrag to defrag small writes
 without rescanning the whole file
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1644398069.git.wqu@suse.com>
 <fc9f897e0859cccf90c33a7a609dc0a2e96ce3c1.1644398069.git.wqu@suse.com>
 <YgP8UocVo/yMT2Pj@debian9.Home>
 <32c44e26-9bd1-f75f-92df-3f7fbf44f8a0@gmx.com>
 <YgUzsYTCz48nB/XT@debian9.Home>
 <23693916-8269-0357-3a20-5e281cf53ff8@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <23693916-8269-0357-3a20-5e281cf53ff8@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m7/nSS/vw0SuQ6OMs5ydsCnBudygQJ1SSODu5NWhewiZ4CELGfC
 wDCHnJ87rQyXbq/K8yFtr1ytenx9Xv+5McKQrwpwHCc0KtKgkRwGX1dW28Pf7f4PS7fMc40
 QroUPcPah0s/DN9DcH8muBNj5PQNXBipkfZrL/YrJZjEQfHcz6LwUS63aMzC6sM0vRjh+FC
 gmwbR/pm4HblrMXSk0PXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y8qk6wjq1Kg=:f8zYXOa7w7qX9yIp1ukF18
 GTRC//R9QTVFxb6IWmf5Rw/q9tLdWQcR1wotySUGVC5cKIRs94LAgYRgqIzZppcPhgq9SrjhE
 DVtPZho+t1Dft9SC1b3soY9mmQw1xNSEFORUXDor91UTkz8MJSREqPRpOnxATHhXI6aT+R1S8
 bW2Cdx8NFkvrkuMJp5popi8Cgh4Wf9Bj0fDM/NzuSBLQnQF1shsW8AnRmWgcV+ewia53BUhIX
 j/JNJ1Pyxv7UpzD9ZqJPlWWooMQZZPQIjAH9zA7M8MqjSPW7urOUut25DgXA490wlTwRq29bz
 fw31fAJ0sp4iObO61uh/ZV2aaTE9MJ38pBbyqwMEslrD0de73GZyduJJ2XJ/L7sy/G+pKAIjy
 ho5zjZRWYVeLVi/sTq0ZEJOfYiUHZZyDt3Qp2wgtmPSay6JF/eOERtTmk1hf2oCtiyY2ImQo9
 jnpZqnmyMV500tLDSxChr94lsjFoZebUHN4GNTe4elQ/XLY5r712LJg9Ddpz95Iq71QZLJhdr
 34Wx6S0M97N+cjKv5ycFD7aHYLjAm8N7xYjnSk4o6IYIgwFujHyrWj1wjz8csnmUmGTWtYpv9
 kkrnNU6JD2MaVMGXHQ0AOQjMnh6eMvA14EpME95TqWKBu/L7+BQWihbpfKYrvwGeKYAhLNQcg
 SBgGqmpPZAbr71YOHTNFcn9RbgG7tCkRKIG1bYwHp6CViGIpjTrwJ/J0Jj1RfFZE3t9U2MD/i
 gJ+6n2qiHpOB0XhhU2bX288J2nYjD6VrkC/7frMSTywlVDKqZCs4a5aEnGVcdaAlIMx/e5Xrz
 cwAjhx9eQVnEhfpvaTGQgEh7Jy2I9Y3thOvbe08G+6psTmbOLAuxDelI7Vu8xL/5UnEWSXyej
 Rka7yJd85eKC1kRcH9kc4GzW8DQduXLx5B3Kr+Q2L475AMhi3wrHFZxqva1JNzi7VZqJjeNL+
 AZUWhBu51cmTHPv6MVArkFcdP8JF+1AsW3knIW++QCXYo2bvmbzTq9c+MZjO86bGIiV0rsXi4
 gzJy3oDZ0Wd1msDDVkOqR3cJdZRtKRBLZ8pz2NenXjYeef7fP0dDUVZq/Y28v1MXcjV86Sere
 F6dcvZTV0GKmsc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/11 08:24, Qu Wenruo wrote:
>
>
> On 2022/2/10 23:48, Filipe Manana wrote:
>> On Thu, Feb 10, 2022 at 08:31:00AM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/10 01:39, Filipe Manana wrote:
>>>> On Wed, Feb 09, 2022 at 05:23:14PM +0800, Qu Wenruo wrote:
>>>>> Previously autodefrag works by scanning the whole file with a minima=
l
>>>>> generation threshold.
>>>>>
>>>>> Although we have various optimization to skip ranges which don't mee=
t
>>>>> the generation requirement, it can still waste some time on
>>>>> scanning the
>>>>> whole file, especially if the inode got an almost full overwrite.
>>>>>
>>>>> To optimize the autodefrag even further, here we use
>>>>> inode_defrag::targets extent io tree to do accurate defrag targets
>>>>> search.
>>>>>
>>>>> Now we re-use EXTENT_DIRTY flag to mark the small writes, and only
>>>>> defrag those ranges.
>>>>>
>>>>> This rework brings the following behavior change:
>>>>>
>>>>> - Only small write ranges will be defragged
>>>>> =C2=A0=C2=A0=C2=A0 Previously if there are new writes after the smal=
l writes, but
>>>>> it's
>>>>> =C2=A0=C2=A0=C2=A0 not reaching the extent size threshold, it will b=
e defragged.
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 This is because we have a gap between autodefrag =
extent size
>>>>> threshold
>>>>> =C2=A0=C2=A0=C2=A0 and inode_should_defrag() extent size threshold.
>>>>> =C2=A0=C2=A0=C2=A0 (uncompressed 64K / compressed 16K vs 256K)
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 Now we won't need to bother the gap, and can only=
 defrag the small
>>>>> =C2=A0=C2=A0=C2=A0 writes.

BTW since the root concern here is the extent_threshold gap between
autodefrag (default value, 256K) vs the 64K/16K value,

Would it be more acceptable to just save the small_write threshold into
inode_defrag, and then only use the value saved in inode_defrag to do a
autodefrag?

By this, we can really skip tons of extents, and no need to introduce a
full featured extent io tree.

Would this idea be more sane?
(I still need to find a way to benchmark though)

Thanks,
Qu

>>>>>
>>>>> - Enlarged critical section for fs_info::defrag_inodes_lock
>>>>> =C2=A0=C2=A0=C2=A0 The critical section will include extent io tree =
update, thus
>>>>> =C2=A0=C2=A0=C2=A0 it will be larger, and fs_info::defrag_inodes_loc=
k will be
>>>>> upgraded
>>>>> =C2=A0=C2=A0=C2=A0 to mutex to handle the possible sleep.
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 This would slightly increase the overhead for aut=
odefrag, but I
>>>>> don't
>>>>> =C2=A0=C2=A0=C2=A0 have a benchmark for it.
>>>>>
>>>>> - Extra memory usage for autodefrag
>>>>> =C2=A0=C2=A0=C2=A0 Now we need to keep an extent io tree for each ta=
rget inode.
>>>>>
>>>>> - No inode re-queue if there are large sectors to defrag
>>>>> =C2=A0=C2=A0=C2=A0 Previously if we have defragged 1024 sectors, we =
will re-queue the
>>>>> =C2=A0=C2=A0=C2=A0 inode, and mostly pick another inode to defrag in=
 next run.
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 Now we will defrag the inode until we finished it=
.
>>>>> =C2=A0=C2=A0=C2=A0 The context switch will be triggered by the cond_=
resche() in
>>>>> =C2=A0=C2=A0=C2=A0 btrfs_defrag_file() thus it won't hold CPU for to=
o long.
>>>>
>>>> So there's a huge difference in this last aspect.
>>>>
>>>> Before, if we defrag one range, we requeue the inode for autodefrag
>>>> - but
>>>> we only run the defrag on the next time the cleaner kthread runs.
>>>> Instead
>>>> of defragging multiple ranges of the file in the same run, we move
>>>> to the
>>>> next inode at btrfs_run_defrag_inodes().
>>>
>>> Unfortunately, that's not the case, the restart-from-0 behavior is sam=
e
>>> for btrfs_run_defrag_inodes().
>>>
>>> In btrfs_pick_defrag_inode() it doesn't really strictly follows the
>>> root/ino requirement, it can choose to use the next inode_defrag.
>>>
>>> Furthermore, btrfs_run_defrag_inodes() will reset the search root/ino =
if
>>> it doesn't find anything, thus search from the start again.
>>
>> Ok, I see now that btrfs_run_defrag_inodes() will do that because of
>> this:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!defrag) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
root_objectid || first_ino) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 root_objectid =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 first_ino =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } el=
se {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>>>
>>> This makes btrfs_run_defrag_inodes() to exhaust all the inode_defrag, =
no
>>> difference than the solution I'm doing.
>>
>> Ok, it seems so.
>>
>>>
>>> In fact, I even considered to refactor btrfs_run_defrag_inodes() to be
>>> more explicit on it's just exhausting the rb tree.
>>>
>>> The tricks is just hiding the true nature.
>>>
>>>>
>>>> With this change, it will defrag all ranges in the same cleaner run.
>>>> If there
>>>> are writes being done to the file all the time, the cleaner will
>>>> spend a lot of
>>>> time defragging ranges for the same file in the same run. That
>>>> delays other
>>>> important work the cleaner does - running delayed iputs, removing emp=
ty
>>>> block groups, deleting snapshots/subvolumes, etc.
>>>
>>> That is the same behavior, before or after my patchset.
>>>
>>> The only way to break the loop in btrfs_run_defrag_inodes() are:
>>>
>>> - Remount
>>>
>>> - Disable autodefrag
>>>
>>> - Exhaust all inode defrags
>>>
>>> That root/ino is just tricking readers to believe it's making a
>>> difference, while it's not.
>>>
>>>>
>>>> That can have a huge impact system wide.
>>>>
>>>> How have you tested this?
>>>>
>>>> Some user workload like the one reported here:
>>>>
>>>> https://lore.kernel.org/linux-btrfs/KTVQ6R.R75CGDI04ULO2@gmail.com/
>>>>
>>>> Would be a good test. Downloading from Steam is probably not somethin=
g
>>>> we can do, as it probably requires some paid scrubscription.
>>>
>>> Nope, it's the same behavior without my patches.
>>> So that's why I'm suspecting this is the cause of the extra CPU usage.
>>
>> Ok, but this type of changes needs to be tested with reasonably realist=
ic
>> or close enough scenarios. Downloading one or more large torrents is
>> likely
>> close enough to the Steam download use case.
>>
>>>
>>>>
>>>> But something that may be close enough is downloading several large
>>>> torrent files and see how it behaves. Things like downloading several
>>>> DVD iso images of Linux distros from torrents, in a way that the sum =
of
>>>> the file sizes is much larger then the total RAM of the system. That
>>>> should
>>>> cause a good amount of work that is "real world", and then try later
>>>> mixing
>>>> that with snapshot/subvolume deletions as well and see if it breaks
>>>> badly
>>>> or causes a huge performance problem.
>>>>
>>>> Some more comments inline below.
>>>>
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>>>>> =C2=A0=C2=A0 fs/btrfs/disk-io.c |=C2=A0=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 fs/btrfs/file.c=C2=A0=C2=A0=C2=A0 | 209
>>>>> ++++++++++++++++++++++++---------------------
>>>>> =C2=A0=C2=A0 fs/btrfs/inode.c=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 4 files changed, 116 insertions(+), 101 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>>> index a5cf845cbe88..9228e8d39516 100644
>>>>> --- a/fs/btrfs/ctree.h
>>>>> +++ b/fs/btrfs/ctree.h
>>>>> @@ -897,7 +897,7 @@ struct btrfs_fs_info {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_free_cluster meta_=
alloc_cluster;
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* auto defrag inodes go here *=
/
>>>>> -=C2=A0=C2=A0=C2=A0 spinlock_t defrag_inodes_lock;
>>>>> +=C2=A0=C2=A0=C2=A0 struct mutex defrag_inodes_lock;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rb_root defrag_inodes;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t defrag_running;
>>>>>
>>>>> @@ -3356,7 +3356,7 @@ void btrfs_exclop_balance(struct
>>>>> btrfs_fs_info *fs_info,
>>>>> =C2=A0=C2=A0 /* file.c */
>>>>> =C2=A0=C2=A0 int __init btrfs_auto_defrag_init(void);
>>>>> =C2=A0=C2=A0 void __cold btrfs_auto_defrag_exit(void);
>>>>> -int btrfs_add_inode_defrag(struct btrfs_inode *inode);
>>>>> +int btrfs_add_inode_defrag(struct btrfs_inode *inode, u64 start,
>>>>> u64 len);
>>>>> =C2=A0=C2=A0 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_in=
fo);
>>>>> =C2=A0=C2=A0 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *=
fs_info);
>>>>> =C2=A0=C2=A0 int btrfs_sync_file(struct file *file, loff_t start, lo=
ff_t end,
>>>>> int datasync);
>>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>>> index b6a81c39d5f4..87782d1120e7 100644
>>>>> --- a/fs/btrfs/disk-io.c
>>>>> +++ b/fs/btrfs/disk-io.c
>>>>> @@ -3126,7 +3126,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info
>>>>> *fs_info)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&fs_info->trans_=
lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&fs_info->fs_roo=
ts_radix_lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&fs_info->delaye=
d_iput_lock);
>>>>> -=C2=A0=C2=A0=C2=A0 spin_lock_init(&fs_info->defrag_inodes_lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&fs_info->super_=
lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&fs_info->buffer=
_lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&fs_info->unused=
_bgs_lock);
>>>>> @@ -3140,6 +3139,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info
>>>>> *fs_info)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&fs_info->reloc_mute=
x);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&fs_info->delalloc_r=
oot_mutex);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&fs_info->zoned_meta=
_io_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_init(&fs_info->defrag_inodes_lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seqlock_init(&fs_info->profiles=
_lock);
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&fs_info->dirty_=
cowonly_roots);
>>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>>> index 2d49336b0321..da6e29a6f387 100644
>>>>> --- a/fs/btrfs/file.c
>>>>> +++ b/fs/btrfs/file.c
>>>>> @@ -34,7 +34,7 @@
>>>>> =C2=A0=C2=A0 static struct kmem_cache *btrfs_inode_defrag_cachep;
>>>>>
>>>>> =C2=A0=C2=A0 /* Reuse DIRTY flag for autodefrag */
>>>>> -#define EXTENT_FLAG_AUTODEFRAG=C2=A0=C2=A0=C2=A0 EXTENT_FLAG_DIRTY
>>>>> +#define EXTENT_FLAG_AUTODEFRAG=C2=A0=C2=A0=C2=A0 EXTENT_DIRTY
>>>>>
>>>>> =C2=A0=C2=A0 /*
>>>>> =C2=A0=C2=A0=C2=A0 * when auto defrag is enabled we
>>>>> @@ -119,7 +119,6 @@ static int __btrfs_add_inode_defrag(struct
>>>>> btrfs_inode *inode,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -EEXIST;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0 set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_f=
lags);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rb_link_node(&defrag->rb_node, =
parent, p);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rb_insert_color(&defrag->rb_nod=
e, &fs_info->defrag_inodes);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> @@ -136,81 +135,80 @@ static inline int __need_auto_defrag(struct
>>>>> btrfs_fs_info *fs_info)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>> +static struct inode_defrag *find_inode_defrag(struct btrfs_fs_info
>>>>> *fs_info,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 u64 root, u64 ino)
>>>>> +{
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 struct inode_defrag *entry =3D NULL;
>>>>> +=C2=A0=C2=A0=C2=A0 struct inode_defrag tmp;
>>>>> +=C2=A0=C2=A0=C2=A0 struct rb_node *p;
>>>>> +=C2=A0=C2=A0=C2=A0 struct rb_node *parent =3D NULL;
>>>>
>>>> Neither entry nor parent need to be initialized.
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 tmp.ino =3D ino;
>>>>> +=C2=A0=C2=A0=C2=A0 tmp.root =3D root;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 p =3D fs_info->defrag_inodes.rb_node;
>>>>> +=C2=A0=C2=A0=C2=A0 while (p) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent =3D p;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D rb_entry(paren=
t, struct inode_defrag, rb_node);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D __compare_inode_=
defrag(&tmp, entry);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
p =3D parent->rb_left;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (ret > 0)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
p =3D parent->rb_right;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return entry;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> It's pointless to have "parent" and "p", one of them is enough.
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 return NULL;
>>>>> +}
>>>>> +
>>>>> =C2=A0=C2=A0 /*
>>>>> =C2=A0=C2=A0=C2=A0 * insert a defrag record for this inode if auto d=
efrag is
>>>>> =C2=A0=C2=A0=C2=A0 * enabled
>>>>> =C2=A0=C2=A0=C2=A0 */
>>>>> -int btrfs_add_inode_defrag(struct btrfs_inode *inode)
>>>>> +int btrfs_add_inode_defrag(struct btrfs_inode *inode, u64 start,
>>>>> u64 len)
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *root =3D ino=
de->root;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =
=3D root->fs_info;
>>>>> -=C2=A0=C2=A0=C2=A0 struct inode_defrag *defrag;
>>>>> +=C2=A0=C2=A0=C2=A0 struct inode_defrag *prealloc;
>>>>> +=C2=A0=C2=A0=C2=A0 struct inode_defrag *found;
>>>>> +=C2=A0=C2=A0=C2=A0 bool release =3D true;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!__need_auto_defrag(fs_info=
))
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
0;
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0 if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runt=
ime_flags))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0 defrag =3D kmem_cache_zalloc(btrfs_inode_defrag_=
cachep, GFP_NOFS);
>>>>> -=C2=A0=C2=A0=C2=A0 if (!defrag)
>>>>> +=C2=A0=C2=A0=C2=A0 prealloc =3D kmem_cache_zalloc(btrfs_inode_defra=
g_cachep,
>>>>> GFP_NOFS);
>>>>> +=C2=A0=C2=A0=C2=A0 if (!prealloc)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
-ENOMEM;
>>>>
>>>> So now everytime this is called, it will allocate memory, even if
>>>> the the
>>>> inode is already marked for defrag.
>>>
>>> Well, since now the defrag_inodes_lock is upgraded to mutex, we can
>>> afford to allocate memory only when needed.
>>>
>>> I can change the behavior.
>>>
>>>>
>>>> Given that this function is called when running delalloc, this can
>>>> cause
>>>> a lot of extra memory allocations. They come from a dedicated slab,
>>>> but it
>>>> still might have a non-negligible impact.
>>>
>>> But please be aware that, the original code is going to allocate memor=
y
>>> if the inode has being evicted, thus its runtime flags is not reliable=
.
>>>
>>> The runtime flags check is an optimization, but not a reliable one.
>>
>> Yes. But there are many cases where the inode has not been evicted afte=
r
>> it was added to the defrag list and before the cleaner picks it up. It'=
s
>> a very common case - not evicted either because there's an open file
>> descriptor for a long period (common with databases, etc), not enough
>> memory
>> pressure, etc.
>>
>>>
>>>>
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0 defrag->ino =3D btrfs_ino(inode);
>>>>> -=C2=A0=C2=A0=C2=A0 defrag->transid =3D inode->root->last_trans;
>>>>> -=C2=A0=C2=A0=C2=A0 defrag->root =3D root->root_key.objectid;
>>>>> -=C2=A0=C2=A0=C2=A0 extent_io_tree_init(fs_info, &defrag->targets,
>>>>> IO_TREE_AUTODEFRAG, NULL);
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0 spin_lock(&fs_info->defrag_inodes_lock);
>>>>> -=C2=A0=C2=A0=C2=A0 if (!test_bit(BTRFS_INODE_IN_DEFRAG, &inode->run=
time_flags)) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we set IN_DEF=
RAG flag and evict the inode from memory,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and then re-read=
 this inode, this new inode doesn't have
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * IN_DEFRAG flag. =
At the case, we may find the existed
>>>>> defrag.
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D __btrfs_add_inod=
e_defrag(inode, defrag);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
extent_io_tree_release(&defrag->targets);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0 } else {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent_io_tree_release(&=
defrag->targets);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(btrfs_in=
ode_defrag_cachep, defrag);
>>>>> +=C2=A0=C2=A0=C2=A0 set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_f=
lags);
>>>>> +=C2=A0=C2=A0=C2=A0 prealloc->ino =3D btrfs_ino(inode);
>>>>> +=C2=A0=C2=A0=C2=A0 prealloc->transid =3D inode->root->last_trans;
>>>>> +=C2=A0=C2=A0=C2=A0 prealloc->root =3D root->root_key.objectid;
>>>>> +=C2=A0=C2=A0=C2=A0 extent_io_tree_init(fs_info, &prealloc->targets,
>>>>> IO_TREE_AUTODEFRAG, NULL);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&fs_info->defrag_inodes_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 found =3D find_inode_defrag(fs_info, prealloc->r=
oot,
>>>>> prealloc->ino);
>>>>> +=C2=A0=C2=A0=C2=A0 if (!found) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D __btrfs_add_inod=
e_defrag(inode, prealloc);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Since we didn't find =
one previously, the insert must
>>>>> success */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(!ret);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found =3D prealloc;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release =3D false;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 set_extent_bits(&found->targets, start, start + =
len - 1,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
EXTENT_FLAG_AUTODEFRAG);
>>>>
>>>> So this can end using a lot of memory and resulting in a deep rbtree.
>>>> It's not uncommon to have very large files with random IO happening
>>>> very
>>>> frequently, each one would result in allocating one extent state reco=
rd
>>>> for the tree.
>>>
>>> This is one of my concern, and I totally understand this.
>>>
>>> However there are some factors to possibly reduce the memory overhead:
>>>
>>> - If the random writes are mergable
>>> =C2=A0=C2=A0 Then the extent states will be merged into a larger one.
>>
>> Sure, but that does not happen for random writes on large files.
>>
>> Let me give you a recent example of an io tree getting big and causing
>> a report of a significant performance drop:
>>
>> https://lore.kernel.org/linux-btrfs/3aae7c6728257c7ce2279d6660ee2797e5e=
34bbd.1641300250.git.fdmanana@suse.com/
>>
>>
>> And performance regression was reported shortly after:
>>
>> https://lore.kernel.org/linux-btrfs/20220117082426.GE32491@xsang-OptiPl=
ex-9020/
>>
>>
>> That was just to track metadata extents of log trees until a
>> transaction commits.
>> Before they were cleared once a log tree is synced, but I changed it
>> to keep the
>> ranges in the io tree until the transaction commits.
>>
>> That can make a huge difference, because even with plenty of available
>> metadata
>> free space and unallocated space, non-contiguous metadata extents got
>> allocated,
>> and they ended up not being merged in the io tree.
>>
>> With autodefrag and workloads that keep doing frequent random writes
>> to a file,
>> the situation will not be better.
>>
>>>
>>> - If the randome writes are happening on the same range
>>> =C2=A0=C2=A0 No change in the number of extent states.
>>
>> You are too optimistic expecting those cases will be the most common.
>>
>>>
>>> - Much smaller extent threshold
>>> =C2=A0=C2=A0 Now the real extent threshold is from inode_should_defrag=
(), which
>>> =C2=A0=C2=A0 exposes 64K for uncompressed write while 16K for compress=
ed writes.
>>>
>>> In fact, for the mentioned case of steam download, I doubt if it would
>>> even trigger autodefrag, as it's mostly sequential write.
>>
>> Have you actually tried it to verify that?
>>
>> It can use a mechanism similar to torrents, or other protocols, which
>> is not always sequential.
>>
>> As I read it, it seems it barely had any performance testing.
>
> OK, I'll try to find a way to replicate the IO of torrents downloading.
> To get a reproducible result, some kind of replay with proper timing is
> needed, any advice on such tool?
>
> But even for torrents downloading, from my experience, it's not full
> random writes.
> Inside the connection to each peer, it's still a sequential write,
> unless one range is finished and then reuqesting another range.
>
> Furthermore, with my personal experience, under most case, the majarity
> of the data just comes from one or two fastest peer, thus the download
> write pattern is more like some multi-thread seqential write with a
> small number of random writes.
>
> But I'll try to do a real world test with 1G ram VM to download some
> distro DVD files to see how this worked.
>
> Meanwhile I already see some of my internal ftrace events are helpful
> not only in debugging but also such testing.
> I'll send them as proper trace events and use them to benchmark such
> situation.
>
> Thanks,
> Qu
>
>>
>>>
>>> Maybe for the decompression part it can cause some random writes, but
>>> according to my daily usage, the IO is pretty high, indicating it's
>>> mostly sequential write, thus should not really trigger autodefrag.
>>>
>>> In fact, I believe a lot of autodefrag for Steam is false triggering,
>>> thus my purposed patchset is exactly to address it.
>>>
>>>>
>>>> Multiply this by N active files in a system, and it can quickly have =
a
>>>> huge impact on used memory.
>>>>
>>>> Also, if a memory allocation triggers reclaim, it will slow down and
>>>> increase the amount of time other tasks wait for the mutex. As the
>>>> rbtree
>>>> that the io tree uses gets larger and larger, it also increases more
>>>> and
>>>> more the critical section's duration.
>>>>
>>>> This means writeback for other inodes is now waiting for a longer
>>>> period,
>>>> as well as the cleaner kthread, which runs autodefrag. Blocking the
>>>> cleaner
>>>> for longer means we are delaying other important work - running delay=
ed
>>>> iputs, deleting snapshots/subvolumes, removing empty block groups, an=
d
>>>> whatever else the cleaner kthread does besides running autodefrag.
>>>>
>>>> So it can have a very high impact on the system overall.
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&fs_info->defrag_inodes_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 if (release) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent_io_tree_release(&=
prealloc->targets);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(btrfs_in=
ode_defrag_cachep, prealloc);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0 spin_unlock(&fs_info->defrag_inodes_lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>> -/*
>>>>> - * Requeue the defrag object. If there is a defrag object that
>>>>> points to
>>>>> - * the same inode in the tree, we will merge them together (by
>>>>> - * __btrfs_add_inode_defrag()) and free the one that we want to
>>>>> requeue.
>>>>> - */
>>>>> -static void btrfs_requeue_inode_defrag(struct btrfs_inode *inode,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
inode_defrag *defrag)
>>>>> -{
>>>>> -=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D inode->root->f=
s_info;
>>>>> -=C2=A0=C2=A0=C2=A0 int ret;
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0 if (!__need_auto_defrag(fs_info))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0 /*
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Here we don't check the IN_DEFRAG flag, =
because we need merge
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * them together.
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> -=C2=A0=C2=A0=C2=A0 spin_lock(&fs_info->defrag_inodes_lock);
>>>>> -=C2=A0=C2=A0=C2=A0 ret =3D __btrfs_add_inode_defrag(inode, defrag);
>>>>> -=C2=A0=C2=A0=C2=A0 spin_unlock(&fs_info->defrag_inodes_lock);
>>>>> -=C2=A0=C2=A0=C2=A0 if (ret)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>>> -=C2=A0=C2=A0=C2=A0 return;
>>>>> -out:
>>>>> -=C2=A0=C2=A0=C2=A0 extent_io_tree_release(&defrag->targets);
>>>>> -=C2=A0=C2=A0=C2=A0 kmem_cache_free(btrfs_inode_defrag_cachep, defra=
g);
>>>>> -}
>>>>> -
>>>>> =C2=A0=C2=A0 /*
>>>>> =C2=A0=C2=A0=C2=A0 * pick the defragable inode that we want, if it d=
oesn't exist,
>>>>> we will get
>>>>> =C2=A0=C2=A0=C2=A0 * the next one.
>>>>> @@ -227,7 +225,7 @@ btrfs_pick_defrag_inode(struct btrfs_fs_info
>>>>> *fs_info, u64 root, u64 ino)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp.ino =3D ino;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp.root =3D root;
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0 spin_lock(&fs_info->defrag_inodes_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&fs_info->defrag_inodes_lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =3D fs_info->defrag_inodes.rb=
_node;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (p) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent =
=3D p;
>>>>> @@ -252,7 +250,7 @@ btrfs_pick_defrag_inode(struct btrfs_fs_info
>>>>> *fs_info, u64 root, u64 ino)
>>>>> =C2=A0=C2=A0 out:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (entry)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rb_eras=
e(parent, &fs_info->defrag_inodes);
>>>>> -=C2=A0=C2=A0=C2=A0 spin_unlock(&fs_info->defrag_inodes_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&fs_info->defrag_inodes_lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return entry;
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>> @@ -261,7 +259,7 @@ void btrfs_cleanup_defrag_inodes(struct
>>>>> btrfs_fs_info *fs_info)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inode_defrag *defrag;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rb_node *node;
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0 spin_lock(&fs_info->defrag_inodes_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&fs_info->defrag_inodes_lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node =3D rb_first(&fs_info->def=
rag_inodes);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (node) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rb_eras=
e(node, &fs_info->defrag_inodes);
>>>>> @@ -269,21 +267,59 @@ void btrfs_cleanup_defrag_inodes(struct
>>>>> btrfs_fs_info *fs_info)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent_=
io_tree_release(&defrag->targets);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_ca=
che_free(btrfs_inode_defrag_cachep, defrag);
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cond_resched_lock(&fs_in=
fo->defrag_inodes_lock);
>>>>> -
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node =
=3D rb_first(&fs_info->defrag_inodes);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0 spin_unlock(&fs_info->defrag_inodes_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&fs_info->defrag_inodes_lock);
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0 #define BTRFS_DEFRAG_BATCH=C2=A0=C2=A0=C2=A0 1024
>>>>> +static int defrag_one_range(struct btrfs_inode *inode, u64 start,
>>>>> u64 len,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 u64 newer_than)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 const struct btrfs_fs_info *fs_info =3D inode->r=
oot->fs_info;
>>>>> +=C2=A0=C2=A0=C2=A0 u64 cur =3D start;
>>>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 while (cur < start + len) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_defrag_ctrl=
 ctrl =3D { 0 };
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl.start =3D cur;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl.len =3D start + len=
 - cur;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl.newer_than =3D newe=
r_than;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl.extent_thresh =3D S=
Z_256K;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl.max_sectors_to_defr=
ag =3D BTRFS_DEFRAG_BATCH;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sb_start_write(fs_info->=
sb);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_defrag_fil=
e(&inode->vfs_inode, NULL, &ctrl);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sb_end_write(fs_info->sb=
);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The range is beyond i=
size, we can safely exit */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EINVAL) =
{
>>>>
>>>> This is a bit odd. I understand this is because the io tree requires
>>>> ranges
>>>> to be sector aligned, so this should trigger only for inodes with an
>>>> i_size that
>>>> is not sector size aligned.
>>>>
>>>> Assuming every -EINVAL is because of that, makes it a bit fragile.
>>>>
>>>> setting ctrl.len to min(i_size_read(inode) - start, start + len -
>>>> cur) and
>>>> then treating all errors the same way, makes it more bullet proof. >
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D 0;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Even we didn't d=
efrag anything, the last_scanned should
>>>>> have
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * been increased.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(ctrl.last_scanned=
 > cur);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur =3D ctrl.last_scanne=
d;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>>> +}
>>>>>
>>>>> =C2=A0=C2=A0 static int __btrfs_run_defrag_inode(struct btrfs_fs_inf=
o *fs_info,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
inode_defrag *defrag)
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *inode_root;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inode *inode;
>>>>> -=C2=A0=C2=A0=C2=A0 struct btrfs_defrag_ctrl ctrl =3D {};
>>>>> +=C2=A0=C2=A0=C2=A0 struct extent_state *cached =3D NULL;
>>>>> +=C2=A0=C2=A0=C2=A0 u64 cur =3D 0;
>>>>> +=C2=A0=C2=A0=C2=A0 u64 found_start;
>>>>> +=C2=A0=C2=A0=C2=A0 u64 found_end;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* get the inode */
>>>>> @@ -300,40 +336,19 @@ static int __btrfs_run_defrag_inode(struct
>>>>> btrfs_fs_info *fs_info,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cl=
eanup;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0 /* do a chunk of defrag */
>>>>> -=C2=A0=C2=A0=C2=A0 clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)=
->runtime_flags);
>>>>> -=C2=A0=C2=A0=C2=A0 ctrl.len =3D (u64)-1;
>>>>> -=C2=A0=C2=A0=C2=A0 ctrl.start =3D defrag->last_offset;
>>>>> -=C2=A0=C2=A0=C2=A0 ctrl.newer_than =3D defrag->transid;
>>>>> -=C2=A0=C2=A0=C2=A0 ctrl.max_sectors_to_defrag =3D BTRFS_DEFRAG_BATC=
H;
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0 sb_start_write(fs_info->sb);
>>>>> -=C2=A0=C2=A0=C2=A0 ret =3D btrfs_defrag_file(inode, NULL, &ctrl);
>>>>> -=C2=A0=C2=A0=C2=A0 sb_end_write(fs_info->sb);
>>>>> -=C2=A0=C2=A0=C2=A0 /*
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * if we filled the whole defrag batch, the=
re
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * must be more work to do.=C2=A0 Queue thi=
s defrag
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * again
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> -=C2=A0=C2=A0=C2=A0 if (ctrl.sectors_defragged =3D=3D BTRFS_DEFRAG_B=
ATCH) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defrag->last_offset =3D =
ctrl.last_scanned;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_requeue_inode_defr=
ag(BTRFS_I(inode), defrag);
>>>>> -=C2=A0=C2=A0=C2=A0 } else if (defrag->last_offset && !defrag->cycle=
d) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we didn't fill o=
ur defrag batch, but
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we didn't start =
at zero.=C2=A0 Make sure we loop
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * around to the st=
art of the file.
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defrag->last_offset =3D =
0;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defrag->cycled =3D 1;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_requeue_inode_defr=
ag(BTRFS_I(inode), defrag);
>>>>> -=C2=A0=C2=A0=C2=A0 } else {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent_io_tree_release(&=
defrag->targets);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(btrfs_in=
ode_defrag_cachep, defrag);
>>>>> +=C2=A0=C2=A0=C2=A0 while (!find_first_extent_bit(&defrag->targets,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cur, &found_start, &found_end,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 EXTENT_FLAG_AUTODEFRAG, &cached)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear_extent_bit(&defrag=
->targets, found_start,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_end, EXTENT_FLAG_AUTODEFRAG, 0, 0, &c=
ached);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D defrag_one_range=
(BTRFS_I(inode), found_start,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 found_end + 1 - found_start, defrag->transid);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
>>>>
>>>> Not sure why it makes more sense to break instead of continuing.
>>>> Just because there was a failure for one range, it does not mean
>>>> the next ranges will fail as well.
>>>
>>> IMHO if we failed to defrag one range, there are two possible reasons:
>>>
>>> - We reached isize, and any later defrag is not needed
>>>
>>> - We got a fatal error like -ENOMEM
>>> =C2=A0=C2=A0 I doubt if we can even continue.
>>>
>>> I can make the first case more correct and explicit, but you're right,
>>> it's better to continue defragging.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Thanks.
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur =3D found_end + 1;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iput(inode);
>>>>> -=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0=C2=A0 cleanup:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent_io_tree_release(&defrag-=
>targets);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(btrfs_inode_def=
rag_cachep, defrag);
>>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>>> index 2049f3ea992d..622e017500bc 100644
>>>>> --- a/fs/btrfs/inode.c
>>>>> +++ b/fs/btrfs/inode.c
>>>>> @@ -570,7 +570,7 @@ static inline void inode_should_defrag(struct
>>>>> btrfs_inode *inode,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If this is a small write ins=
ide eof, kick off a defrag */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (num_bytes < small_write &&
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (start =
> 0 || end + 1 < inode->disk_i_size))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_add_inode_defrag(i=
node);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_add_inode_defrag(i=
node, start, num_bytes);
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0 /*
>>>>> --
>>>>> 2.35.0
>>>>>
