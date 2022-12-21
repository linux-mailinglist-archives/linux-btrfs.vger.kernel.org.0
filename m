Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ECD652D90
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 09:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiLUIAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 03:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiLUIAD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 03:00:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C1EB0A
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 00:00:01 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSc1B-1pJCeu4225-00SsAG; Wed, 21
 Dec 2022 08:59:54 +0100
Message-ID: <a0618e92-ba6b-d598-fa46-29b6f8115b46@gmx.com>
Date:   Wed, 21 Dec 2022 15:59:50 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <aba9f83d-76f2-48fe-1819-bc405cb7efdc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3/8ddfyxU4jD+OSOSU+Geh0fUjOJI/vm5FUl9IHzRGfdQ+SOZBV
 L0VjdewF1wYLYhrfGrJmBOoPyE70tI+rYBqDtSCA8a9uP9PZwFuNm6+25458k4ZBYcTZQj4
 eUOxnNKmJ9eQZyzhHuUOoF1aK/c3Ap+7Ec8kS6NhSRKyjAJuE81i3baXPeXLHhurer3OeSE
 kBVTcwotC5UOBuSzeFhaQ==
UI-OutboundReport: notjunk:1;M01:P0:c1CKS0b3kw0=;AEqAH/J1vV1ZlK3UChyEpWTU9Sf
 yzh+rEmPrzhZDMBiHqkgT7fjp7OXm9TuV/0KiGdhX4AqRFbP56EONLwjGmRGW7fSvjC4ufU2J
 VRp00v0ZObzODnbMYrRSuat5v+M8VyhAbZJ0OExmn9eNSTUBXvQLGaMHa+Tw073gmRDgTnXxa
 Oi63MAhSUAihVVpgmpuJTTokot9Ep49Ahp6MQBzh4kCyqAscpes70qp0swZMGg7wNJP4Y+i9o
 EynHuuUqTqufrJnw4csmvEe1SYaDct5zZqpE0UYROtOiZMX1lIpmBOpjveGe8vgnkFwkIESs8
 V8q6/21BbUXDVgVW07ULXR2Qm3ReS9kTsjeg6mhIAXEHolKSd0y84leDyM6Xd72rvdN3j5Js4
 d3vYJBXDiJOEmLZd2w8H2lZFb8gdM5nV/hP45MqbhLUZrrBQhLfj97WWlIZwKXZbH9qpR5U/6
 ZEAUT6rH8ommwKIXXPsRq7o4zpF3HJGtQ6UfcCH9mVQH8+EoRRE+zFnqb5Y4NG7eU4Tp3VztX
 mgmx8bQ78HvWPZXvgqHmkrw2pVXmGifmLOz0FYhyA+sVy0eBBpqdIZaaDQpX+0a4pt/fP47Gn
 yYs+jvY/093J1pgjCWig9AkZF01miKuBiRu/Mo/NMULPZpV6DiZwGbe28vptAICZr3QXJdC5x
 xWM2rDGvBpiCTt5McSWYMtVsE2rM8rdzdipJlMMk3WJA4n/7hEUrPAC8jvLtIyqgfXLZpOWB1
 c/xkY8RWbn/btbVioIoI7smQ3RLEMf1LuJC9FENdSNNAKMsnLDqfzs1SU3hAarvGBiz4CjB15
 TGXABo1LqYJ0ehTNh8h3qhhoUY9Dj2whENmyLJyUegn/hj9GH2o59tWXw4CGpYDRkTAYGbxfD
 YSt06Keim1G6KO3vdxj0DaRDFjZP8WBaE6qrv2WtAUqhePo1MjyUkkB1jFNAnMIsfA6+z0XDe
 eWEYStFaRBGi0ga2+STk//+BzAo=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/21 15:56, Anand Jain wrote:
> On 12/21/22 07:16, Qu Wenruo wrote:
>> [BUG]
>> Even with commit 81d5d61454c3 ("btrfs: enhance unsupported compat RO
>> flags handling"), btrfs can still mount a fs with unsupported compat_ro
>> flags read-only, then remount it RW:
>>
>>    # btrfs ins dump-super /dev/loop0 | grep compat_ro_flags -A 3
>>    compat_ro_flags        0x403
>>             ( FREE_SPACE_TREE |
>>               FREE_SPACE_TREE_VALID |
>>               unknown flag: 0x400 )
> 
> 
> I am trying to understand how the value 'unknown flag: 0x400' was
> obtained for the 'compat_ro_flags' variable. A crafted 'sb'?

Yes, crafted super block.

> 
> 
>>
>>    # mount /dev/loop0 /mnt/btrfs
>>    mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on 
>> /dev/loop0, missing codepage or helper program, or other error.
>>           dmesg(1) may have more information after failed mount system 
>> call.
>>    ^^^ RW mount failed as expected ^^^
>>
>>    # dmesg -t | tail -n5
>>    loop0: detected capacity change from 0 to 1048576
>>    BTRFS: device fsid cb5b82f5-0fdd-4d81-9b4b-78533c324afa devid 1 
>> transid 7 /dev/loop0 scanned by mount (1146)
>>    BTRFS info (device loop0): using crc32c (crc32c-intel) checksum 
>> algorithm
>>    BTRFS info (device loop0): using free space tree
>>    BTRFS error (device loop0): cannot mount read-write because of 
>> unknown compat_ro features (0x403)
>>    BTRFS error (device loop0): open_ctree failed
>>
>>    # mount /dev/loop0 -o ro /mnt/btrfs
>>    # mount -o remount,rw /mnt/btrfs
>>    ^^^ RW remount succeeded unexpectedly ^^^
>>
>> [CAUSE]
>> Currently we use btrfs_check_features() to check compat_ro flags against
>> our current moount flags.
>>
>> That function get reused between open_ctree() and btrfs_remount().
>>
>> But for btrfs_remount(), the super block we passed in still has the old
>> mount flags, thus btrfs_check_features() still believes we're mounting
>> read-only.
>>
>> [FIX]
>> Introduce a new argument, *new_flags, to indicate the new mount flags.
>> That argument can be NULL for the open_ctree() call site.
>>
>> With that new argument, call site at btrfs_remount() can properly pass
>> the new super flags, and we can reject the RW remount correctly.
>>
>> Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
>> Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags 
>> handling")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/disk-io.c | 9 ++++++---
>>   fs/btrfs/disk-io.h | 3 ++-
>>   fs/btrfs/super.c   | 2 +-
>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 0888d484df80..210363db3e2d 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3391,12 +3391,15 @@ int btrfs_start_pre_rw_mount(struct 
>> btrfs_fs_info *fs_info)
>>    * (space cache related) can modify on-disk format like free space 
>> tree and
>>    * screw up certain feature dependencies.
>>    */
>> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>> super_block *sb)
>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>> super_block *sb,
>> +             int *new_flags)
>>   {
>>       struct btrfs_super_block *disk_super = fs_info->super_copy;
>>       u64 incompat = btrfs_super_incompat_flags(disk_super);
>>       const u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
>>       const u64 compat_ro_unsupp = (compat_ro & 
>> ~BTRFS_FEATURE_COMPAT_RO_SUPP);
> 
> 
>> +    bool rw_mount = (!sb_rdonly(sb) ||
>> +             (new_flags && !(*new_flags & SB_RDONLY)));
> 
> The remount is used to change the state of a mount point from
> read-only (ro) to read-write (rw), or vice versa. In both of these
> transitions, the %rw_mount variable remains true. So it is not clear
> to me, what the intended purpose of this is.

If rw_mount is already true, the fs doesn't has unsupported compat_flag 
anyway, thus we don't really need to bother the unsupported flags.

The only case rw_mount is true and we care is, RO->RW remount.

> 
> -Anand
> 
>>       if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
>>           btrfs_err(fs_info,
>> @@ -3430,7 +3433,7 @@ int btrfs_check_features(struct btrfs_fs_info 
>> *fs_info, struct super_block *sb)
>>       if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
>>           incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>> -    if (compat_ro_unsupp && !sb_rdonly(sb)) {
>> +    if (compat_ro_unsupp && rw_mount) {
>>           btrfs_err(fs_info,
>>       "cannot mount read-write because of unknown compat_ro features 
>> (0x%llx)",
>>                  compat_ro);
>> @@ -3633,7 +3636,7 @@ int __cold open_ctree(struct super_block *sb, 
>> struct btrfs_fs_devices *fs_device
>>           goto fail_alloc;
>>       }
>> -    ret = btrfs_check_features(fs_info, sb);
>> +    ret = btrfs_check_features(fs_info, sb, NULL);
>>       if (ret < 0) {
>>           err = ret;
>>           goto fail_alloc;
>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>> index 363935cfc084..e83453c7c429 100644
>> --- a/fs/btrfs/disk-io.h
>> +++ b/fs/btrfs/disk-io.h
>> @@ -50,7 +50,8 @@ int __cold open_ctree(struct super_block *sb,
>>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
>>   int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>>                struct btrfs_super_block *sb, int mirror_num);
>> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>> super_block *sb);
>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>> super_block *sb,
>> +             int *new_flags);
>>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device 
>> *bdev);
>>   struct btrfs_super_block *btrfs_read_dev_one_super(struct 
>> block_device *bdev,
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index d5de18d6517e..bc2094aa9a40 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -1705,7 +1705,7 @@ static int btrfs_remount(struct super_block *sb, 
>> int *flags, char *data)
>>       if (ret)
>>           goto restore;
>> -    ret = btrfs_check_features(fs_info, sb);
>> +    ret = btrfs_check_features(fs_info, sb, flags);
>>       if (ret < 0)
>>           goto restore;
> 
