Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEEB6668F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 03:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjALCf2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 21:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjALCf1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 21:35:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D15FCA
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 18:35:24 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5rU-1pSuRT38Lo-00M7TP; Thu, 12
 Jan 2023 03:35:20 +0100
Message-ID: <067d3b1c-8510-81ee-4c90-02c6cbd74f7c@gmx.com>
Date:   Thu, 12 Jan 2023 10:35:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] btrfs: keep sysfs features in tandem with runtime
 features change
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <ef0efdacd9bd53a55a02c6419b9ff0d51edf5408.1673412612.git.anand.jain@oracle.com>
 <98540b70-c7b8-5340-7a4d-ee6f43f6babf@gmx.com>
In-Reply-To: <98540b70-c7b8-5340-7a4d-ee6f43f6babf@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MZZvH7Z9vsii1maE7SRCmHrxZ+jRu8VyAgRj/kUSCpQKTb7jDGC
 K45hYYdj0cIciuo4DzdGBM4/TcO6FRvnC3wJw6qzeeNjX21DgZ3Iy3jHVWDlM5UnNlaG4L6
 v03nvGUu24VixgqqAO/jqlrgpGSA28XeDb6ES/u4kY3OYYuAyW0Xl/WfvS5gjioyXr3FsGi
 35sS4sB3cQkJLqWTTZXUg==
UI-OutboundReport: notjunk:1;M01:P0:GNKaT4/y55s=;wtWwwFz8q7+0pFAxgfVwL3uQs5H
 wzAY3iDS9JZ9cKopNqT7dYCQYc18tcJCnjLw7DEEYeMVw5bFF4SKd/QEYB9TXGrkQ0/K6iIWN
 A2X/1EuZuejoLAzorFb6UtQ2zFXiB4jpAb7L5i3US9sMwk1yUlVX/Z9aS9nSSiFC/moKLK91Q
 iglzQIwFI0sbk4QRlwV5t4ilBtVLeSm4fRGFJOR4ADxLsPtkE0moZ7DbKfxaoX09HzQdP1CWC
 SfsSLKnh2M/8eQ4SftdF+dJcyBMb85mQ3R5kIu2ELsdRMRhkXC+bmcuUQchbXaroMOgslSgW5
 TjGirhUhjCfNTR4J9gIB5p+s025alRZ3Dlg/nZr6TQ/okphVHsvy+0RVHH9A37tWvOF9tgEVU
 RzUYkJ6i78qaYnB1uTHKCQ2IGnF5Ic4Uiqtq/kZVyEHoGGOeQcSidAp08w7ynQ6IBslAtb1KU
 MKVQk1J8VffbADx+os4pS+idoHVnVXDlzAA0zPvwC9tmxXzmAsD/nB8F7CsV2PJHgNzbRs0TF
 h6h0vkwwVxUPLBARg2W+ssUTpNJQ0n1rxDDTowpyTet2s1RkHspJB895/e5YcTSokcEA3ScJa
 PSoVNhWBaNBynhy8U0wWDO/GXrJ+sfMOT9lI7DEmDmY99yubnAgRxhaGSI36yhJEMEz2JSchC
 /Tm8p7I5j2m7JFJSnCPZHIMXlG0oxySOi9TUWgFLXdrFgn08xkRIioltJQQJNTBElgPaN1d3Q
 Yip0uSlsqejGYjyvlLL+UlVVilnd1Ot2x4lvaSN/Pvi6UJDvHfuVqjioJVPE/U8U25KUSvehe
 u8IpXKmQ+VLhSoiuioIBmHaR8oPP/BFsGZWFDJ5jKcfyB+m1GCshyUVO9DqGaVDVZ1w25CzRh
 IYZIjkIk8zinkEDJ1txCTnBdJ72yiPrpiugi16+/born7jCvwozKC8qS/LLeb+0n5yD95S66t
 g50Wdc19KpmRqar+I4bqynjYLrA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 15:05, Qu Wenruo wrote:
> 
> 
> On 2023/1/11 13:40, Anand Jain wrote:
>> When we change runtime features, the sysfs under
>>     /sys/fs/btrfs/<uuid>/features
>> render stale.
>>
>> For example: (before)
>>
>>   $ btrfs filesystem df /btrfs
>>   Data, single: total=8.00MiB, used=0.00B
>>   System, DUP: total=8.00MiB, used=16.00KiB
>>   Metadata, DUP: total=51.19MiB, used=128.00KiB
>>   global reserve, single: total=3.50MiB, used=0.00B
>>
>>   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
>>   extended_iref free_space_tree no_holes skinny_metadata
>>
>> Use balance to convert from single/dup to RAID5 profile.
>>
>>   $ btrfs balance start -f -dconvert=raid5 -mconvert=raid5 /btrfs
>>
>> Still, sysfs is unaware of raid5.
>>
>>   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
>>   extended_iref free_space_tree no_holes skinny_metadata
>>
>> Which doesn't match superblock
>>
>>   $ btrfs in dump-super /dev/loop0
>>
>>   incompat_flags 0x3e1
>>   ( MIXED_BACKREF |
>>   BIG_METADATA |
>>   EXTENDED_IREF |
>>   RAID56 |
>>   SKINNY_METADATA |
>>   NO_HOLES )
>>
>> Require mount-recycle as a workaround.
>>
>> Fix this by laying out all attributes on the sysfs at mount time. 
>> However,
>> return 0 or 1 when read, for used or unused, respectively.
>>
>> For example: (after)
>>
>>   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
>>   block_group_tree compress_zstd extended_iref free_space_tree 
>> mixed_groups raid1c34 skinny_metadata zoned
>> compress_lzo default_subvol extent_tree_v2 metadata_uuid no_holes 
>> raid56 verity
>>
>>   $ cat 
>> /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/raid56
>>   0
>>
>>   $ btrfs balance start -f -dconvert=raid5 -mconvert=raid5 /btrfs
>>
>>   $ cat 
>> /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/raid56
>>   1
> 
> Oh, I found this very confusing.
> 
> Previously features/ directory just shows what we have (either in kernel 
> support or the specified fs), which is very straightforward.
> 
> Changing it to 0/1 is way less easy to understand, and can be considered 
> as big behavior change.
> 
> Is it really no way to change the fs' features?

Furthermore, we have something left already in the sysfs.c, 
btrfs_sysfs_feature_update() to do the work.

I'm working on a patch to revive the behavior, which is working fine so 
far in my environment.

I'll address all the concerns (mostly related to the context) to make it 
work as expected.

Thanks,
Qu
> 
> Thanks,
> Qu
>>
>> A fstests test case will follow.
>>
>> The source code changes involve removing the visible function pointer for
>> the btrfs_feature_attr_group, as it is an optional feature. And the
>> store/show part for the same is already implemented.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/sysfs.c | 23 -----------------------
>>   1 file changed, 23 deletions(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 45615ce36498..fa3354f8213f 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -256,28 +256,6 @@ static ssize_t btrfs_feature_attr_store(struct 
>> kobject *kobj,
>>       return count;
>>   }
>> -static umode_t btrfs_feature_visible(struct kobject *kobj,
>> -                     struct attribute *attr, int unused)
>> -{
>> -    struct btrfs_fs_info *fs_info = to_fs_info(kobj);
>> -    umode_t mode = attr->mode;
>> -
>> -    if (fs_info) {
>> -        struct btrfs_feature_attr *fa;
>> -        u64 features;
>> -
>> -        fa = attr_to_btrfs_feature_attr(attr);
>> -        features = get_features(fs_info, fa->feature_set);
>> -
>> -        if (can_modify_feature(fa))
>> -            mode |= S_IWUSR;
>> -        else if (!(features & fa->feature_bit))
>> -            mode = 0;
>> -    }
>> -
>> -    return mode;
>> -}
>> -
>>   BTRFS_FEAT_ATTR_INCOMPAT(default_subvol, DEFAULT_SUBVOL);
>>   BTRFS_FEAT_ATTR_INCOMPAT(mixed_groups, MIXED_GROUPS);
>>   BTRFS_FEAT_ATTR_INCOMPAT(compress_lzo, COMPRESS_LZO);
>> @@ -335,7 +313,6 @@ static struct attribute 
>> *btrfs_supported_feature_attrs[] = {
>>   static const struct attribute_group btrfs_feature_attr_group = {
>>       .name = "features",
>> -    .is_visible = btrfs_feature_visible,
>>       .attrs = btrfs_supported_feature_attrs,
>>   };
