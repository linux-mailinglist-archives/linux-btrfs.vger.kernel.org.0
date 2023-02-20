Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7206C69CA3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 12:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjBTLvj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 06:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjBTLvh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 06:51:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6ED1B335
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 03:51:34 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMobU-1pDVFr1BCu-00ImOa; Mon, 20
 Feb 2023 12:51:27 +0100
Message-ID: <81d2d145-ebfb-d745-c288-814862f0655b@gmx.com>
Date:   Mon, 20 Feb 2023 19:51:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <da81abd638ca83237b8b50671e72793c498dddd9.1676802781.git.wqu@suse.com>
 <8b465081-65f7-4b97-a1bc-3c6b93d3b9c5@suse.com>
 <b0521a4e-15f9-e6d8-0239-97ad83c3124a@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: make dev-replace properly follow its read mode
In-Reply-To: <b0521a4e-15f9-e6d8-0239-97ad83c3124a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xyipk64UW+tLYLentUZ3BYKeizi/sZf7B8Tbj4SwZzVl4KcFhWh
 mbD83Ebtl9QlJEbPKkW30xPQDsMuAp4f9NGzOZhtqRUnUqEBVCv3DYMa3DzaMNOrlVwVWP1
 MB7FgsOg5lzEc5P3vL9qtx21bf1zQ+Yvx2xAs0d14utRrv0QIxLJMYQfIMcbhbZTfKhI18L
 jUqthxZE4jyKsinwoVDfQ==
UI-OutboundReport: notjunk:1;M01:P0:6A1yyz5vYhg=;S3AHcpLGrb7SwrcjFvzmQ9F2cvH
 52Fd9Bg2k/Z7p7KWeb0de+2e5xRC4iydfzjGXbIYcZPiq1LNyFBbNTD/s6uYNBlj9Xb9XW4A7
 D2NO6ptPS/f2eFWwFTpTSXdJjYeG3Ft0WRHp0SXsG9LMLvpFpU9UQDY0UXMrmcd+WNntbzL7l
 pj2wBdHujw5xJPe4tImp3+MzME0mfD6rYAXxlCoL4so1Av8Z0ar4lEqYARsiIR1GtSzYj6VHC
 7u9glxBMXz3BgzmCDJpp6+G36wOOpG9Fe1/OBrqt26+KUP1v/8ZfX+UcJd48im4s7GUCAe+sh
 fqG328B3lxwR0Xg82bMeSR3UDSXfsQhV2MADCISypArB9EJFgMn9bhKh6BoD27qQseH2/uqHo
 oIkPCzYyKoJ1tvx2k0eoYNJWrfX5Pyihq77O6jA+RfJjbc/fiBH3MqpuE0DN8W6clamGRBe7W
 5kbV0nKq1eVABGrf36rJIu1VBPflQRaW4cmbweNmBpOW9M5UxGdWSOilonmPtu1uyQ5VSvKsD
 CkhjK6yLq597G3w8zkk2zlYs8pI+UWkeglqm7nTl0RaPWzWMkSvhs60E4RFQ5WeFlfLFqK4Bw
 G+tYr0QBCfMK6YVW2cgl8S5LPoVFS5RQtOKu+WRwcFi9wy7hvIFnRjM3lWCNu/hou6dp4EVfY
 z424NpmqI5MHOgoi/cwU/y1TIejPbcAwK2sGXBReXI/gR47dbJ/Q+lk6y6o954yykT46foQRB
 TsKDX7MLkVOzUFUIKyKysVKgyTaVt/2eiVvxO3xdYDBdZNEHNk2QuUwYqK8iPiO02a8455Lf+
 MAv1EWoW/dNhqL+UYMsh7eDzmbFNDOz9NfgHVKbnrvO0+7LfZ9jKa7CQrrCJ2rHUgQW9qqG5V
 JXG2KJt19tpydj1V8AUGHBuPAEjRiYkNlesKDrSCYAy37/yGLURAJv3KTnqhulv5m2EFay2K7
 i5Ga98Fyhfde+p5y1NG4h+q/JYM=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/20 15:55, Anand Jain wrote:
> On 2/20/23 10:56, Qu Wenruo wrote:
>>
>>
>> On 2023/2/19 18:33, Qu Wenruo wrote:
>>> [BUG]
>>> Although dev replace ioctl has a way to specify the mode on whether we
>>> should read from the source device, it's not properly followed.
>>>
>>>   # mkfs.btrfs -f -d raid1 -m raid1 $dev1 $dev2
>>>   # mount $dev1 $mnt
>>>   # xfs_io -f -c "pwrite 0 32M" $mnt/file
>>>   # sync
>>>   # btrfs replace start -r -f 1 $dev3 $mnt
>>>
>>> And one extra trace is added to scrub_submit(), showing the detail about
>>> the bio:
>>>
>>>             btrfs-1115669 [005] .....  5437.027093: 
>>> scrub_submit.part.0: devid=1 logical=22036480 phy=22036480 len=16384
>>>             btrfs-1115669 [005] .....  5437.027372: 
>>> scrub_submit.part.0: devid=1 logical=30457856 phy=30457856 len=32768
>>>             btrfs-1115669 [005] .....  5437.027440: 
>>> scrub_submit.part.0: devid=1 logical=30507008 phy=30507008 len=49152
>>>             btrfs-1115669 [005] .....  5437.027487: 
>>> scrub_submit.part.0: devid=1 logical=30605312 phy=30605312 len=32768
>>>             btrfs-1115669 [005] .....  5437.027556: 
>>> scrub_submit.part.0: devid=1 logical=30703616 phy=30703616 len=65536
>>>             btrfs-1115669 [005] .....  5437.028186: 
>>> scrub_submit.part.0: devid=1 logical=298844160 phy=298844160 len=131072
>>>             ...
>>>             btrfs-1115669 [005] .....  5437.076243: 
>>> scrub_submit.part.0: devid=1 logical=322961408 phy=322961408 len=131072
>>>             btrfs-1115669 [005] .....  5437.076248: 
>>> scrub_submit.part.0: devid=1 logical=323092480 phy=323092480 len=131072
>>>
>>> One can see that all the read are submitted to devid 1, even we have
>>> specified "-r" option to avoid read from the source device.
>>>
>>> [CAUSE]
>>> The dev-replace read mode is only set but not followed by scrub code
>>> at all.
>>>
>>> In fact, only common read path is properly following the read mode,
>>> but scrub itself has its own read path, thus not following the mode.
>>>
>>> [FIX]
>>> Here we enhance scrub_find_good_copy() to also follow the read mode.
>>>
>>> The idea is pretty simple, in the first loop, we avoid the following
>>> devices:
>>>
>>> - Missing devices
>>>    This is the existing condition
>>>
>>> - The source device if the replace wants to avoid it.
>>>
>>> And if above loop found no candidate (e.g. replace a single device),
>>> then we discard the 2nd condition, and try again.
>>>
>>> Since we're here, also enhance the function scrub_find_good_copy() by:
>>>
>>> - Remove the forward declaration
>>>
>>> - Makes it return int
>>>    To indicates errors, e.g. no good mirror found.
>>>
>>> - Add extra error messages
>>>
>>> Now with the same trace, "btrfs replace start -r" works as expected:
>>>
>>>             btrfs-1121013 [000] .....  5991.905971: 
>>> scrub_submit.part.0: devid=2 logical=22036480 phy=1064960 len=16384
>>>             btrfs-1121013 [000] .....  5991.906276: 
>>> scrub_submit.part.0: devid=2 logical=30457856 phy=9486336 len=32768
>>>             btrfs-1121013 [000] .....  5991.906365: 
>>> scrub_submit.part.0: devid=2 logical=30507008 phy=9535488 len=49152
>>>             btrfs-1121013 [000] .....  5991.906423: 
>>> scrub_submit.part.0: devid=2 logical=30605312 phy=9633792 len=32768
>>>             btrfs-1121013 [000] .....  5991.906504: 
>>> scrub_submit.part.0: devid=2 logical=30703616 phy=9732096 len=65536
>>>             btrfs-1121013 [000] .....  5991.907314: 
>>> scrub_submit.part.0: devid=2 logical=298844160 phy=277872640 len=131072
>>>             btrfs-1121013 [000] .....  5991.907575: 
>>> scrub_submit.part.0: devid=2 logical=298975232 phy=278003712 len=131072
>>>             btrfs-1121013 [000] .....  5991.907822: 
>>> scrub_submit.part.0: devid=2 logical=299106304 phy=278134784 len=131072
>>>             ...
>>>             btrfs-1121013 [000] .....  5991.947417: 
>>> scrub_submit.part.0: devid=2 logical=318504960 phy=297533440 len=131072
>>>             btrfs-1121013 [000] .....  5991.947664: 
>>> scrub_submit.part.0: devid=2 logical=318636032 phy=297664512 len=131072
>>>             btrfs-1121013 [000] .....  5991.947920: 
>>> scrub_submit.part.0: devid=2 logical=318767104 phy=297795584 len=131072
>>>
>>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Rename "replace read policy" to "replace read mode" in comments
>>>    This is avoid the confusion with the existing read policy.
>>>    No behavior change.
>>> ---
>>>   fs/btrfs/scrub.c | 131 +++++++++++++++++++++++++++++++++++------------
>>>   1 file changed, 97 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>> index ee3fe6c291fe..4c399a720bf1 100644
>>> --- a/fs/btrfs/scrub.c
>>> +++ b/fs/btrfs/scrub.c
>>> @@ -423,11 +423,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, 
>>> u64 logical, u32 len,
>>>   static void scrub_bio_end_io(struct bio *bio);
>>>   static void scrub_bio_end_io_worker(struct work_struct *work);
>>>   static void scrub_block_complete(struct scrub_block *sblock);
>>> -static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
>>> -                 u64 extent_logical, u32 extent_len,
>>> -                 u64 *extent_physical,
>>> -                 struct btrfs_device **extent_dev,
>>> -                 int *extent_mirror_num);
>>>   static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
>>>                         struct scrub_sector *sector);
>>>   static void scrub_wr_submit(struct scrub_ctx *sctx);
>>> @@ -2709,6 +2704,93 @@ static int scrub_find_csum(struct scrub_ctx 
>>> *sctx, u64 logical, u8 *csum)
>>>       return 1;
>>>   }
>>> +static bool should_use_device(struct btrfs_fs_info *fs_info,
>>> +                  struct btrfs_device *dev,
>>> +                  bool follow_replace_read_mode)
>>> +{
>>> +    struct btrfs_device *replace_srcdev = fs_info->dev_replace.srcdev;
>>> +    struct btrfs_device *replace_tgtdev = fs_info->dev_replace.tgtdev;
>>> +
>>> +    if (!dev->bdev)
>>> +        return false;
>>> +
>>> +    /*
>>> +     * We're doing scrub/replace, if it's pure scrub, no tgtdev 
>>> should be
>>> +     * here.
>>> +     * If it's replace, we're going to write data to tgtdev, thus 
>>> the current
>>> +     * data of the tgtdev is all garbage, thus we can not use it at 
>>> all.
>>> +     */
>>> +    if (dev == replace_tgtdev)
>>> +        return false;
>>> +
>>> +    /* No need to follow replace read policy, any existing device is 
>>> fine. */
>>> +    if (!follow_replace_read_mode)
>>> +        return true;
>>> +
>>> +    /* Need to follow the policy. */
>>> +    if (fs_info->dev_replace.cont_reading_from_srcdev_mode ==
>>> +        BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)
>>> +        return dev != replace_srcdev;
>>> +    return true;
>>> +}
>>> +static int scrub_find_good_copy(struct btrfs_fs_info *fs_info,
>>> +                u64 extent_logical, u32 extent_len,
>>> +                u64 *extent_physical,
>>> +                struct btrfs_device **extent_dev,
>>> +                int *extent_mirror_num)
>>> +{
>>> +    u64 mapped_length;
>>> +    struct btrfs_io_context *bioc = NULL;
>>> +    int ret;
>>> +    int i;
>>> +
>>> +    mapped_length = extent_len;
>>> +    ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
>>> +                  extent_logical, &mapped_length, &bioc, 0);
>>> +    if (ret || !bioc || mapped_length < extent_len) {
>>> +        btrfs_put_bioc(bioc);
>>> +        btrfs_err_rl(fs_info, "btrfs_map_block() failed for logical 
>>> %llu: %d",
>>> +                extent_logical, ret);
>>> +        return -EIO;
>>> +    }
>>> +
>>> +    /*
>>> +     * First loop to exclude all missing devices and the source
>>> +     * device if needed.
>>> +     * And we don't want to use target device as mirror either,
>>> +     * as we're doing the replace, the target device range
>>> +     * contains nothing.
>>> +     */
>>> +    for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; 
>>> i++) {
>>> +        struct btrfs_io_stripe *stripe = &bioc->stripes[i];
>>> +
>>> +        if (!should_use_device(fs_info, stripe->dev, true))
>>> +            continue;
>>> +        goto found;
>>> +    }
>>> +    /*
>>> +     * We didn't find any alternative mirrors, we have to break our
>>> +     * replace read mode, or we can not read at all.
>>> +     */
>>> +    for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; 
>>> i++) {
>>> +        struct btrfs_io_stripe *stripe = &bioc->stripes[i];
>>> +
>>> +        if (!should_use_device(fs_info, stripe->dev, false))
>>> +            continue;
>>> +        goto found;
>>> +    }
>>> +
>>> +    btrfs_err_rl(fs_info, "failed to find any live mirror for 
>>> logical %llu",
>>> +            extent_logical);
>>> +    return -EIO;
>>> +
>>> +found:
>>> +    *extent_physical = bioc->stripes[i].physical;
>>> +    *extent_mirror_num = i + 1;
>>> +    *extent_dev = bioc->stripes[i].dev;
>>> +    btrfs_put_bioc(bioc);
>>> +    return 0;
>>> +}
>>>   /* scrub extent tries to collect up to 64 kB for each bio */
>>>   static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup 
>>> *map,
>>>               u64 logical, u32 len,
>>> @@ -2746,7 +2828,8 @@ static int scrub_extent(struct scrub_ctx *sctx, 
>>> struct map_lookup *map,
>>>       }
>>>       /*
>>> -     * For dev-replace case, we can have @dev being a missing device.
>>> +     * For dev-replace case, we can have @dev being a missing 
>>> device, or
>>> +     * we want to avoid read from the source device if possible.
>>>        * Regular scrub will avoid its execution on missing device at 
>>> all,
>>>        * as that would trigger tons of read error.
>>>        *
>>> @@ -2754,9 +2837,14 @@ static int scrub_extent(struct scrub_ctx 
>>> *sctx, struct map_lookup *map,
>>>        * increase unnecessarily.
>>>        * So here we change the read source to a good mirror.
>>>        */
>>> -    if (sctx->is_dev_replace && !dev->bdev)
>>> -        scrub_find_good_copy(sctx->fs_info, logical, len, 
>>> &src_physical,
>>> -                     &src_dev, &src_mirror);
>>> +    if (sctx->is_dev_replace &&
>>> +        (!dev->bdev || 
>>> sctx->fs_info->dev_replace.cont_reading_from_srcdev_mode ==
>>> +         BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)) {
>>
>> The check condition is not safe for RAID56.
>>
>> For RAID56, the scrub_find_good_copy() won't return a good candidate 
>> at all.
>>
>> Thus unfortunately for RAID56, we won't follow the avoid mode for now.
>> The proper way for RAID56 avoid mode is to go rebuild path instead, 
>> which is pretty different from the current code base.
>>
>> I'll update the patch to exclude the RAID56 mode for now.
>>
> 
> 
> Based on the comments found in the only parent function of
> scrub_extent()-  scrub_simple_mirror(), this function
> stack is not intended for RAID56. I don't understand what you mean here.

scrub_simple_mirror() also works for RAID56 handling for data stripes.

Just check "while(physical < physical_end)" loop in scrub_stripe(), 
which is only for RAID56 data profiles.

In that case, if we have MODE_AVOID specified, we would try read from 
other stripes, which can be either other data stripes, or parity 
stripes, thus it would cause false csum mismatch.

Unfortunately RAID56 scrub can only handle missing devices, not avoid 
mode yet.

Thanks,
Qu
> 
> Thanks, Anand
> 
>> Thanks,
>> Qu
>>
>>> +        ret = scrub_find_good_copy(sctx->fs_info, logical, len,
>>> +                       &src_physical, &src_dev, &src_mirror);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +    }
>>>       while (len) {
>>>           u32 l = min(len, blocksize);
>>>           int have_csum = 0;
>>> @@ -4544,28 +4632,3 @@ int btrfs_scrub_progress(struct btrfs_fs_info 
>>> *fs_info, u64 devid,
>>>       return dev ? (sctx ? 0 : -ENOTCONN) : -ENODEV;
>>>   }
>>> -
>>> -static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
>>> -                 u64 extent_logical, u32 extent_len,
>>> -                 u64 *extent_physical,
>>> -                 struct btrfs_device **extent_dev,
>>> -                 int *extent_mirror_num)
>>> -{
>>> -    u64 mapped_length;
>>> -    struct btrfs_io_context *bioc = NULL;
>>> -    int ret;
>>> -
>>> -    mapped_length = extent_len;
>>> -    ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_logical,
>>> -                  &mapped_length, &bioc, 0);
>>> -    if (ret || !bioc || mapped_length < extent_len ||
>>> -        !bioc->stripes[0].dev->bdev) {
>>> -        btrfs_put_bioc(bioc);
>>> -        return;
>>> -    }
>>> -
>>> -    *extent_physical = bioc->stripes[0].physical;
>>> -    *extent_mirror_num = bioc->mirror_num;
>>> -    *extent_dev = bioc->stripes[0].dev;
>>> -    btrfs_put_bioc(bioc);
>>> -}
> 
