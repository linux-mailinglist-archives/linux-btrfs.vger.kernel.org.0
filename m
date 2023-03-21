Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4F76C2B51
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 08:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCUHZr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 03:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCUHZq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 03:25:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1E422A29
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 00:25:39 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbBu-1qX2Ot33SA-00sdi0; Tue, 21
 Mar 2023 08:25:22 +0100
Message-ID: <16b37d65-8b90-f5b1-0f30-41cf392689a5@gmx.com>
Date:   Tue, 21 Mar 2023 15:25:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 01/12] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1679278088.git.wqu@suse.com>
 <94803d18b1c4ce208b6a93e37998718e61ea37d5.1679278088.git.wqu@suse.com>
 <a70957b6-e9df-c50f-0b76-8524a56f64a1@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a70957b6-e9df-c50f-0b76-8524a56f64a1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7hYXCXYQByVzBANA3HHwCSGkSjkPxg1CqeLfyMC9XQ/ODy08KjK
 bjOSeTqMI87dRUiYPaNIMFVjjPJe7BnNR1QeJ8Xr/J/XQ5eHOp2Gg8C8ibmf+IBkjVQXrpD
 /WSgdd2xqrOIHB+GoP1Q2pTXsag6lXNIspAb4jOgGo6WnS2AG9bgtCoEJPaAPJJ0UcW5TKZ
 cIcIZP12VZD/XCls5RRLA==
UI-OutboundReport: notjunk:1;M01:P0:eWbotSjs3xk=;djcEhsL15JrN07fdf12Bg4Nmm+f
 b82UgAOD5ZQ7YuPNBrEpa8uvEcl+edfmAhFVk7U8SIPrb3GasQv6FQMUIJM7dFeVdUvy0eR5g
 veeuxMPBQGoAHJN+guJZf9sogwE15SmlADX82ceowq3MuMsPu5yuQhnVHNTl/y6XNnP6cZ+wq
 tdcDp3NhmNPT6lggftsZzvgP+O5KrXLOxxtaOJ6wg+ZRe0QK1vktG3p73F+5V/a15nMV3gh+6
 BPmYWW7M8HPlr62/6z8tq0tUSX3lX41HU6Az5n0k7Wfd7FGfn6JqHs//dTmivXEKYZO6YOcD0
 e9rDV8g7TP8ysTwcK56FNekJnMMkxmMF3mIWrEojpk1ZEcVrBj52/HnujbPT0lk+TUmNEjHag
 CLNGkEzpoKLWNZjxJtLkMrnVoKdjSAsaUR3u9ANf2KfPRFhJrWEEqBTr3ZOVLKP/0Kz++ClX3
 YBV7nLe4Cvl8KfbH00VJFgjw4krVSMArXER9+RYVdNRYMztKYRCLZa8EOFB1jl7HrJyAgepLn
 60hjE8+kJEy08kKJEnpZZUpuwhtbfiWlFeInOPn9Z2+Pss8aOsv/+cPPWmKON0xUcjySIDI8+
 0uzWLBu6uJnUcTLd8MLrRRPLRPZkba3uscGtej0+tS0XOQ4X/KU69jPFWzoNBE/rj+N4HnHpp
 6ulBpugKDP3FmbnmtTOhvry60bvxcZdHIDU4KOK4mkB63FnemGwUjsPMj0uCZZ/4jYrT829uC
 Mk+VDgkW8LqC87Oz82PQYfLXCpBek1POSnY+elfM3X60SE9EUb81zBdJ/nd12AJPbWXdPQR14
 y1qQMEQSvys8hxwTGEaaP4a3eKlbsO3HMmaDbDf+hNpleYyua/b6u8Dyh5aKsHZl9r7ifr/ke
 0DB+/DDHdRo4WnsuwEfhxmNAqDVzBl32jCrnirikhQ7ty8xiLn4hGyRrCvImG2boTYLQyF+Y1
 SW5nn+XZO2y3+KXnJvQyh9yURzU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 13:22, Anand Jain wrote:
> On 20/03/2023 10:12, Qu Wenruo wrote:
>> There is really no need to go through the super complex scrub_sectors()
>> to just handle super blocks.
>>
>> This patch will introduce a dedicated function (less than 50 lines) to
>> handle super block scrubing.
>>
>> This new function will introduce a behavior change, instead of using the
>> complex but concurrent scrub_bio system, here we just go
>> submit-and-wait.
>>
>> There is really not much sense to care the performance of super block
>> scrubbing. It only has 3 super blocks at most, and they are all scattered
>> around the devices already.
>>
> 
> Looks good
> 
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> nits below:
> 
>> ---
>>   fs/btrfs/scrub.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 46 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 3cdf73277e7e..e765eb8b8bcf 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -4243,18 +4243,59 @@ int scrub_enumerate_chunks(struct scrub_ctx 
>> *sctx,
>>       return ret;
>>   }
>> +static int scrub_one_super(struct scrub_ctx *sctx, struct 
>> btrfs_device *dev,
>> +               struct page *page, u64 physical, u64 generation)
>> +{
>> +    struct btrfs_fs_info *fs_info = sctx->fs_info; > +    struct 
>> bio_vec bvec;
>> +    struct bio bio;
>> +    struct btrfs_super_block *sb = page_address(page);
>> +    int ret;
>> +
>> +    bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
>> +    bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
>> +    bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
>> +    ret = submit_bio_wait(&bio);
>> +    bio_uninit(&bio);
>> +
>> +    if (ret < 0)
>> +        return ret;
>> +    ret = btrfs_check_super_csum(fs_info, sb);
>> +    if (ret != 0) {
>> +        btrfs_err_rl(fs_info,
>> +            "super block at physical %llu devid %llu has bad csum",
>> +            physical, dev->devid);
>> +        return -EIO;
>> +    }
>> +    if (btrfs_super_generation(sb) != generation) {
>> +        btrfs_err_rl(fs_info,
>> +"super block at physical %llu devid %llu has bad generation, has %llu 
>> expect %llu",
>> +                 physical, dev->devid,
>> +                 btrfs_super_generation(sb), generation);
>> +        return -EUCLEAN;
>> +    }
>> +
>> +    ret = btrfs_validate_super(fs_info, sb, -1);
>> +    return ret;
>> +}
>> +
>>   static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>>                          struct btrfs_device *scrub_dev)
>>   {
> 
>   scrub_supers() no longer requires struct scrub_ctx * as a parameter,
>   but this should modify from scrub_supers().
> 
>   A separate patch submitted.
> 
>>       int    i;
>>       u64    bytenr;
>>       u64    gen;
>> -    int    ret;
>> +    int    ret = 0;
>> +    struct page *page;
>>       struct btrfs_fs_info *fs_info = sctx->fs_info;
>>       if (BTRFS_FS_ERROR(fs_info))
>>           return -EROFS;
>> +    page = alloc_page(GFP_KERNEL);
>> +    if (!page)
>> +        return -ENOMEM;
>> +
> 
>   Over allocation for PAGESIZE>4K is unoptimized for SB, which is
>   acceptable. Add a comment to clarify.

For this, I'm not sure if it's that unoptimized.

The "alternative" is to just allocate 4K memory, but bio needs a page 
pointer, not a memory pointer (it can be converted, but not simple if 
not aligned).

The PAGESIZE > 4K one is only not ideal for memory usage, which I'd say 
doesn't worthy a full comment.
At most an ASSERT() like "ASSERT(PAGE_SIZE >= BTRFS_SUPER_INFO_SIZE);".

Thanks,
Qu

> 
> Thanks, Anand
> 
>>       /* Seed devices of a new filesystem has their own generation. */
>>       if (scrub_dev->fs_devices != fs_info->fs_devices)
>>           gen = scrub_dev->generation;
>> @@ -4269,15 +4310,12 @@ static noinline_for_stack int 
>> scrub_supers(struct scrub_ctx *sctx,
>>           if (!btrfs_check_super_location(scrub_dev, bytenr))
>>               continue;
>> -        ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
>> -                    scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
>> -                    NULL, bytenr);
>> +        ret = scrub_one_super(sctx, scrub_dev, page, bytenr, gen);
>>           if (ret)
>> -            return ret;
>> +            break;
>>       }
> 
>> -    wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 
>> 0);
> 
>   Nice.  :-)
> 
> Thanks, Anand
> 
>> -
>> -    return 0;
>> +    __free_page(page);
>> +    return ret;
>>   }
>>   static void scrub_workers_put(struct btrfs_fs_info *fs_info)
> 
