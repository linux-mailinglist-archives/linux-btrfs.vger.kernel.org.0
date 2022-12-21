Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C6652DC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 09:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiLUIPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 03:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiLUIPK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 03:15:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996642182E
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 00:15:08 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH9Y-1obsoz276C-00ce4y; Wed, 21
 Dec 2022 09:15:02 +0100
Message-ID: <4282d330-430c-7efd-4331-d344275e4724@gmx.com>
Date:   Wed, 21 Dec 2022 16:14:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] btrfs: fix compat_ro checks against remount
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Chung-Chiang Cheng <shepjeng@gmail.com>
References: <8ab95b9b1469cf773928e720a9d787316dfb44bc.1671577140.git.wqu@suse.com>
 <aba9f83d-76f2-48fe-1819-bc405cb7efdc@oracle.com>
 <a0618e92-ba6b-d598-fa46-29b6f8115b46@gmx.com>
 <a54879d4-a1e3-32f6-fd6b-6b76fc8f0192@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a54879d4-a1e3-32f6-fd6b-6b76fc8f0192@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GB0RF4HycdCafHfdFq5vsoVR3OK2R9jTL73Tb6er1/lnRDDEBb3
 m1hUauRBcLQiqru57K/SDXw5OrMA7hK2iyoH8ntfe1N+a4MhJxY/igX3PElRal48zbeJBCm
 6fTUVrD+cJvF2RiHnN2kvw2+GMymkbUMlcpOnfloVvQNToCcA9NfR1J22QCop+sc67mO6MZ
 zCIIyUXhXTa9NWlwV1diQ==
UI-OutboundReport: notjunk:1;M01:P0:tySGhoKMu/k=;dylGv4VXrnOn3pqZRLlTn/YynKo
 Qq3EdTaYJGZp9MTxoTp2jSl95m3hG1MUd9GUp+J175HPnzJM/aCl7JGNToWuYKFBtkI/M8S7Q
 t3klBB6vDVjFfkcITm6RBUvGPvaf8ofAHaIkYaa1/ErpJ+EdceUbDrp94RTYGkTUPlkdhdcBd
 af4InTRiRxN5eeoOkeptCQCVUKj6N21Fbi4NQa53dA00Ok/plrFYoKRjWGkc+pW9ak5+xwnIt
 m/jQbXfspIi5o2q8420U8LkHeBNcF7mB9QXWLqs5p+tcADXW/rFGgc+IJ+uUvpsqRGM+y701h
 I35OxcW50mX4ym/sU+ID3FI5tqAvrKDdJQZPRMHJ0RRsN/cUCBFNQItr394GRYTO2wmsVAstn
 As0NVujBnKQ8VcFqbbijOfb0aCChO0KGUVoLifhTA+TrHVXaoeNv8ep8xT9JD9uS7NQvgS0V8
 oWr8WdcR7QPHkkkDdTsiKlT1hHg8DB2UMrVKIlPOiGxeha3PkLC/l3om7ca/duhPAVfIm86C9
 wPs5iiVB7I8hrdxjbm/p2gaWVrL1QBWbLsYUnJhcdygvedR/5uH9Bt6duGQXaDilk7fJIwdZ0
 h+TtNa91RSUfS3NZBZrwt1B7ouWo+3eWPqqMO1MqV8GnEQeCWMYgec/ZvXYQWKVTIkOAQjTeb
 DOj4pIap2Gzbq/QRDFXTurV+ruQzEJJ1h/mr/AnPhiMkP3uaszdMQGgXmOH9DTddkGpRa/YNE
 WHz02ipnNLIgiK6Axd4tXqkLeCRmkxRw5oEOXgFe8z5Y5ZutXmiFiEZgOG9HGqbkHj/R9k4OF
 gTC0DxUT8GAr3FViLUivnWr76ETXxLJigT3MS2q1j2w6/5+LmKAoW/HEKZuGAqkEY6BMr1NC7
 Jdvnr1rnZXKDAwVb+FvX9VUBWtj3H/51ENtaNDCOlzY7n0ZrN1WabfZYaSl30QD1vgSUQ8h07
 IEjD2gxLfGPhxotR0rnk0QhIibY=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/21 16:08, Anand Jain wrote:
> 
> 
> On 12/21/22 15:59, Qu Wenruo wrote:
>>
>>
>> On 2022/12/21 15:56, Anand Jain wrote:
>>> On 12/21/22 07:16, Qu Wenruo wrote:
>>>> [BUG]
>>>> Even with commit 81d5d61454c3 ("btrfs: enhance unsupported compat RO
>>>> flags handling"), btrfs can still mount a fs with unsupported compat_ro
>>>> flags read-only, then remount it RW:
>>>>
>>>>    # btrfs ins dump-super /dev/loop0 | grep compat_ro_flags -A 3
>>>>    compat_ro_flags        0x403
>>>>             ( FREE_SPACE_TREE |
>>>>               FREE_SPACE_TREE_VALID |
>>>>               unknown flag: 0x400 )
>>>
>>>
>>> I am trying to understand how the value 'unknown flag: 0x400' was
>>> obtained for the 'compat_ro_flags' variable. A crafted 'sb'?
>>
>> Yes, crafted super block.
>>
>>>
>>>
>>>>
>>>>    # mount /dev/loop0 /mnt/btrfs
>>>>    mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on 
>>>> /dev/loop0, missing codepage or helper program, or other error.
>>>>           dmesg(1) may have more information after failed mount 
>>>> system call.
>>>>    ^^^ RW mount failed as expected ^^^
>>>>
>>>>    # dmesg -t | tail -n5
>>>>    loop0: detected capacity change from 0 to 1048576
>>>>    BTRFS: device fsid cb5b82f5-0fdd-4d81-9b4b-78533c324afa devid 1 
>>>> transid 7 /dev/loop0 scanned by mount (1146)
>>>>    BTRFS info (device loop0): using crc32c (crc32c-intel) checksum 
>>>> algorithm
>>>>    BTRFS info (device loop0): using free space tree
>>>>    BTRFS error (device loop0): cannot mount read-write because of 
>>>> unknown compat_ro features (0x403)
>>>>    BTRFS error (device loop0): open_ctree failed
>>>>
>>>>    # mount /dev/loop0 -o ro /mnt/btrfs
>>>>    # mount -o remount,rw /mnt/btrfs
>>>>    ^^^ RW remount succeeded unexpectedly ^^^
>>>>
>>>> [CAUSE]
>>>> Currently we use btrfs_check_features() to check compat_ro flags 
>>>> against
>>>> our current moount flags.
>>>>
>>>> That function get reused between open_ctree() and btrfs_remount().
>>>>
>>>> But for btrfs_remount(), the super block we passed in still has the old
>>>> mount flags, thus btrfs_check_features() still believes we're mounting
>>>> read-only.
>>>>
>>>> [FIX]
>>>> Introduce a new argument, *new_flags, to indicate the new mount flags.
>>>> That argument can be NULL for the open_ctree() call site.
>>>>
>>>> With that new argument, call site at btrfs_remount() can properly pass
>>>> the new super flags, and we can reject the RW remount correctly.
>>>>
>>>> Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
>>>> Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags 
>>>> handling")
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>   fs/btrfs/disk-io.c | 9 ++++++---
>>>>   fs/btrfs/disk-io.h | 3 ++-
>>>>   fs/btrfs/super.c   | 2 +-
>>>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>> index 0888d484df80..210363db3e2d 100644
>>>> --- a/fs/btrfs/disk-io.c
>>>> +++ b/fs/btrfs/disk-io.c
>>>> @@ -3391,12 +3391,15 @@ int btrfs_start_pre_rw_mount(struct 
>>>> btrfs_fs_info *fs_info)
>>>>    * (space cache related) can modify on-disk format like free space 
>>>> tree and
>>>>    * screw up certain feature dependencies.
>>>>    */
>>>> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>>>> super_block *sb)
>>>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>>>> super_block *sb,
>>>> +             int *new_flags)
>>>>   {
>>>>       struct btrfs_super_block *disk_super = fs_info->super_copy;
>>>>       u64 incompat = btrfs_super_incompat_flags(disk_super);
>>>>       const u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
>>>>       const u64 compat_ro_unsupp = (compat_ro & 
>>>> ~BTRFS_FEATURE_COMPAT_RO_SUPP);
>>>
>>>
>>>> +    bool rw_mount = (!sb_rdonly(sb) ||
>>>> +             (new_flags && !(*new_flags & SB_RDONLY)));
>>>
>>> The remount is used to change the state of a mount point from
>>> read-only (ro) to read-write (rw), or vice versa. In both of these
>>> transitions, the %rw_mount variable remains true. So it is not clear
>>> to me, what the intended purpose of this is.
>>
>> If rw_mount is already true, the fs doesn't has unsupported 
>> compat_flag anyway, thus we don't really need to bother the 
>> unsupported flags.
>>
> 
>> The only case rw_mount is true and we care is, RO->RW remount.
> 
>   Have you tested the value of %rw_mount in the secnarios RO->RW
>   and RW->RW? I did. I find %rw_mount is true in both the cases.

What's the problem? That's exactly the expected behavior.

We don't want to allow RO->RW with unsupported compat_ro flag.

The truth table is very simple:

         rw_mount
RO->RO  False
RO->RW  True
RW->RW  True
RW->RO  True

And in above cases, RO->RW is what we care.
RW->RW is fine, as if the fs is already mounted RW, the compat_ro flags 
must be fine.
RW->RO is the same as RW->RW.

So, what's your problem here?

Thanks,
Qu

> 
> 
> 
>>> -Anand
>>>
>>>>       if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
>>>>           btrfs_err(fs_info,
>>>> @@ -3430,7 +3433,7 @@ int btrfs_check_features(struct btrfs_fs_info 
>>>> *fs_info, struct super_block *sb)
>>>>       if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
>>>>           incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>>>> -    if (compat_ro_unsupp && !sb_rdonly(sb)) {
>>>> +    if (compat_ro_unsupp && rw_mount) {
>>>>           btrfs_err(fs_info,
>>>>       "cannot mount read-write because of unknown compat_ro features 
>>>> (0x%llx)",
>>>>                  compat_ro);
>>>> @@ -3633,7 +3636,7 @@ int __cold open_ctree(struct super_block *sb, 
>>>> struct btrfs_fs_devices *fs_device
>>>>           goto fail_alloc;
>>>>       }
>>>> -    ret = btrfs_check_features(fs_info, sb);
>>>> +    ret = btrfs_check_features(fs_info, sb, NULL);
>>>>       if (ret < 0) {
>>>>           err = ret;
>>>>           goto fail_alloc;
>>>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>>>> index 363935cfc084..e83453c7c429 100644
>>>> --- a/fs/btrfs/disk-io.h
>>>> +++ b/fs/btrfs/disk-io.h
>>>> @@ -50,7 +50,8 @@ int __cold open_ctree(struct super_block *sb,
>>>>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
>>>>   int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>>>>                struct btrfs_super_block *sb, int mirror_num);
>>>> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>>>> super_block *sb);
>>>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>>>> super_block *sb,
>>>> +             int *new_flags);
>>>>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>>>>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device 
>>>> *bdev);
>>>>   struct btrfs_super_block *btrfs_read_dev_one_super(struct 
>>>> block_device *bdev,
>>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>>> index d5de18d6517e..bc2094aa9a40 100644
>>>> --- a/fs/btrfs/super.c
>>>> +++ b/fs/btrfs/super.c
>>>> @@ -1705,7 +1705,7 @@ static int btrfs_remount(struct super_block 
>>>> *sb, int *flags, char *data)
>>>>       if (ret)
>>>>           goto restore;
>>>> -    ret = btrfs_check_features(fs_info, sb);
>>>> +    ret = btrfs_check_features(fs_info, sb, flags);
>>>>       if (ret < 0)
>>>>           goto restore;
>>>
