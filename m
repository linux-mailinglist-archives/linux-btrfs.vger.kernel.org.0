Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCDD6C5BBE
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 02:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCWBNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 21:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWBNo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 21:13:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDDB6E90
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 18:13:42 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8ofO-1qao263vsM-015qST; Thu, 23
 Mar 2023 02:13:33 +0100
Message-ID: <24d97721-6906-7633-4fc8-c5d9b0b35b3e@gmx.com>
Date:   Thu, 23 Mar 2023 09:13:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] btrfs: remove struct scrub_stx for superblock
 scrubbing
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <10d0f55b196d4dc949f0ac29f2f0af023eaa7523.1679376183.git.anand.jain@oracle.com>
 <35929eb4-7467-6cae-3d5d-3f6b239c11a7@gmx.com>
 <601f517a-2736-0f35-fde7-965de0daf36d@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <601f517a-2736-0f35-fde7-965de0daf36d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6VyQM42Mk64Qssw153Z8oJb0c/Hh/7/0cVk8Y7D/1rcUPF4F9CU
 26aC4YpGfw/UF3diNiycpeWyxMKt8gXTBQgFxG5Qj+C45UJ8wkE8XNWrRNptdjPGmYLQsOx
 xbpR+cqdl0SCdoxBN2Nmu0ThrFzsgEWilNfeUzUqStV0sx+Ism0JArwZlVoj2Ryw8Mc7xK5
 p+RUw/gHmiQtt8/EteABg==
UI-OutboundReport: notjunk:1;M01:P0:7zD75yd9ztw=;hO/R5u4Mcytef7vTbXMVlamfDmZ
 q6oc+ktABkHrv6g4SRiK55DoUfA7xAdiv05yGBrvKjyYl34O0W8Cp1OJ62/gK39JU6AMIUZUC
 /Sw3iC0q7uRWel9xKMi3ukLKG+jRYXN1YyT+80cFAmZ7NK1NRiJQHVdFzSaKVc8/YiyH75RH9
 Mt+/GTOoEMWc5VnWDbdK2/2OXY924w6BDTTHkLLEzFRzoAiY3KPirInE0H6SH1dlf8WH/MP5x
 d5L9M2odQEym07mDsuNGYXDBASDUox4ZKKMgdu2WSWL7O+9N9FgR+VdEJJJBaXpl6mi58dfpo
 nR0UyB7DGQclAXenreParO9p+3PHiGbqMlgYuQEG0smWBK48epoMlGQj79zWk8lATjAYtJqHo
 jEgk5XmHIvZtAbTtKnjFnhhAywqns54wkrrEYcwWZ96CEf9dykg1gnzOtldkaa10tfOoQInlG
 FNEF7jj1WTFRXv58G7jwKkGeVhHDwyXxm2IXqYA8K4wb9SgyO7wn4pbX/WlrgZn9b5RtLUJva
 kdFMgyOS7X374wooj6vQIRdeVLG5/iV9RPFWpg+IeikQX3ig8LEfOkqqGqxU3pRgqXtendgnV
 WBplVNMk33s3Rkm8swpdC6SQDu/KZLla/eHStSaIxA9poKJMJsToFkia2BPN3OM+VfZcNI0S/
 vOg+TDrYjSsv71uFeaguuiuOBwM6esrSBBKf8vUY0Suq9uMV8a8X+Uan8JLLVb64xI9TeFw/E
 1YHZw7XF8KQggMj+ZmSoH6Zi2uguD4+u/KzJsNyEy7/I96/VGKRFOT5UsEeOAQf+xfC800Pva
 DRLGaJ3c/GPZFV9TZwwZ0WDi48qs5wbqYmOpawThirwgV859L2ohBjaDweKimOP+9bmqGYqBV
 Cu7UuINTzn8f2io/My79VqVEAc0EED6LLiJKMz2lINuf4vDg7SEHaBS/cfwK8KAfS+o718F7b
 EdtGNizzZPXt2BdfK4Pab9Gh8Jw=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 18:11, Anand Jain wrote:
> On 3/21/23 15:26, Qu Wenruo wrote:
>>
>>
>> On 2023/3/21 13:23, Anand Jain wrote:
>>> Following the patchset that implements reader-friendly scrub code
>>> made the struct scrub_stx is no longer required for scrubbing 
>>> superblocks.
>>>
>>>    btrfs: scrub: use a more reader friendly code to implement 
>>> scrub_simple_mirror()
>>>
>>> Therefore, scrub_ctx does not need to be passed as a parameter,
>>> (unless there are other plans for it).
>>>
>>> This patch cleans up the code and is built on top of the above patchset.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> Looks good, if you're fine I can fold this into the offending patch in 
>> the next update.
>>
> 
> IMO, this patch is a cleanup rather than a bug fix, so there
> isn't offending patch. If it is folded to the patch 1/12, it
> may be too many objectives in one patch.

The cleanup is only possible because of the patch "btrfs: scrub: use 
dedicated super block verification function to scrub one super block".

As the old code relies on the scrub_sectors() function, thus needing the 
@sctx parameter.

And it's indeed my fault not fully cleaning up the parameters.

Thus I believe it's better to fold it into the mentioned patch.

Thanks,
Qu
> 
> Nonetheless, I have no objections if you still decide to fold it.
> 
> Thanks, Anand
> 
> 
>> Thanks,
>> Qu
>>
>>> ---
>>>   fs/btrfs/scrub.c | 15 +++++++--------
>>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>> index beccf763ae64..bc87277559d3 100644
>>> --- a/fs/btrfs/scrub.c
>>> +++ b/fs/btrfs/scrub.c
>>> @@ -4909,12 +4909,12 @@ int scrub_enumerate_chunks(struct scrub_ctx 
>>> *sctx,
>>>       return ret;
>>>   }
>>> -static int scrub_one_super(struct scrub_ctx *sctx, struct 
>>> btrfs_device *dev,
>>> -               struct page *page, u64 physical, u64 generation)
>>> +static int scrub_one_super(struct btrfs_device *dev, struct page *page,
>>> +               u64 physical, u64 generation)
>>>   {
>>> -    struct btrfs_fs_info *fs_info = sctx->fs_info;
>>>       struct bio_vec bvec;
>>>       struct bio bio;
>>> +    struct btrfs_fs_info *fs_info = dev->fs_info;
>>>       struct btrfs_super_block *sb = page_address(page);
>>>       int ret;
>>> @@ -4945,15 +4945,14 @@ static int scrub_one_super(struct scrub_ctx 
>>> *sctx, struct btrfs_device *dev,
>>>       return ret;
>>>   }
>>> -static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>>> -                       struct btrfs_device *scrub_dev)
>>> +static noinline_for_stack int scrub_supers(struct btrfs_device 
>>> *scrub_dev)
>>>   {
>>>       int    i;
>>>       u64    bytenr;
>>>       u64    gen;
>>>       int    ret = 0;
>>>       struct page *page;
>>> -    struct btrfs_fs_info *fs_info = sctx->fs_info;
>>> +    struct btrfs_fs_info *fs_info = scrub_dev->fs_info;
>>>       if (BTRFS_FS_ERROR(fs_info))
>>>           return -EROFS;
>>> @@ -4976,7 +4975,7 @@ static noinline_for_stack int 
>>> scrub_supers(struct scrub_ctx *sctx,
>>>           if (!btrfs_check_super_location(scrub_dev, bytenr))
>>>               continue;
>>> -        ret = scrub_one_super(sctx, scrub_dev, page, bytenr, gen);
>>> +        ret = scrub_one_super(scrub_dev, page, bytenr, gen);
>>>           if (ret)
>>>               break;
>>>       }
>>> @@ -5172,7 +5171,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info 
>>> *fs_info, u64 devid, u64 start,
>>>            * kick off writing super in log tree sync.
>>>            */
>>>           mutex_lock(&fs_info->fs_devices->device_list_mutex);
>>> -        ret = scrub_supers(sctx, dev);
>>> +        ret = scrub_supers(dev);
>>>           mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>>>           spin_lock(&sctx->stat_lock);
> 
