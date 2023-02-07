Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4596F68CC84
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 03:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBGCUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 21:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGCUA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 21:20:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5192E0DF
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 18:19:58 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9FjR-1pUyLh1dtn-006SCL; Tue, 07
 Feb 2023 03:19:51 +0100
Message-ID: <a4c209fa-96f3-7f6d-0fd9-ea69a13a254e@gmx.com>
Date:   Tue, 7 Feb 2023 10:19:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1674893735.git.wqu@suse.com>
 <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
 <5195283e-7e3d-6de1-75f4-d7f635bfc0ab@oracle.com>
 <61d2d841-778b-ca13-cc41-ca115b5ed287@suse.com>
 <aec522de-683f-b673-408f-8380b206309e@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 2/3] btrfs: small improvement for btrfs_io_context
 structure
In-Reply-To: <aec522de-683f-b673-408f-8380b206309e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ASvRC6j9WdluIKmwmpnLy1os1vgR2gu2X80M2L/HyWk/dBjahEH
 NbXm6Zv7FxtlDmZeotu7Z0nkCl3jucxt0YZkpCNYGgKsqBHdJK2HFh8IZLCF3yVVq1V3FAa
 eHml8RUPGL4W7QeO+MPzNwWHVCRg+JQAzjGv4gxS/58kM5YqX8rf8xq/GPODXGTnt4XVeKY
 Sfz72KHajrKlvHLzZcesA==
UI-OutboundReport: notjunk:1;M01:P0:DQrmJeoeVLc=;FMq+Jon97Thg91dIMOKzSSs7IZr
 tDjX2OkiSn0Y+41i98eaXYFAfXG4BqABCjlmOI/SZ7hzVx5UZHM+K1b8FEAkUyncvvYw/YODr
 7N739B4lBDfR81W5XKjFWIAWOp+GRlkTEkJ8hnsD2UI13oFx1Yb+mo7jmawhaoLV8IIr73pSo
 +SasGjUDHO5tCrYodTbDu/24W+R6Zlegc0hxjcwbWP4PqUeNujM/P6SkjazNfQaYftRNj8XNc
 O3CpYWIpMomH05LVcLfPZhUKwxABsIhDKm0QmlsK4pnhr128s7Dds5/JQobZEPdT+lLzuRuc7
 ZibO3Gt38Yi9PRO4pQ/OBeeBrcnWqmjo4J4FwJDEzlcbifsZh4d9b0of766a0iBp3vPCLkaAT
 ET87x2Ju05Y0xhBoqA9wk+IQFFd5t5YmqDRAfSW5K+YjtD3L1J52TmOnUirSb/moQMuVWn/vg
 2FLwx7thknk4vJU7ka84BiNQttc1PWA4GhEDCfBmmbEeLJucDn6Tb/K+u7iBzkdWTnB2hJNsz
 ZbpwRrr5BAlTOTt5Nwqlgl2CSXqk0iijrydTngUdmJVjBcxzp+yy9Ftdc3hwUsv9FcBpCeK6U
 c6hHjjspILTfzg6Y6MrFLvMIdUX1VKCWQVIpbfuTEnHjtC9OysDLLb8QYS8sZEMrdgUeoSmBj
 MEoM9JNHCU7JpYiaGMM7q7mQfVwmsDv9qo4JaryHH9hxsAwjWBVTOHLph36lVdfVSTLADHX8x
 7tUQvPLnKhFakP/Nj3QYdaQFmxtY+RWOO2A/T4u6i7pGydpNWpB5yURkKf0mYKLoytM9hKvK7
 dAdfDFzejLLHnc/TzH3JAQdg7Wwzio1g6OD2h2fZx3Okb5eZFFlAK/zztNbb+K4r50/ipukrL
 4Mgzvxz3TdKEeT8PCYVARaAcRW2vPm2rfV3Qidsj+VcC57oMJSFEoB4Wq1oZel09d3sNOlaWX
 xH2yMLjGyMMW0/vh0eX666Il4pQ=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/2 17:12, Anand Jain wrote:
> 
> 
> On 2/2/23 14:47, Qu Wenruo wrote:
>>
>>
>> On 2023/2/2 14:28, Anand Jain wrote:
>>>
>>>
>>>> +    bioc = kzalloc(
>>>>            /* The size of btrfs_io_context */
>>>>           sizeof(struct btrfs_io_context) +
>>>>           /* Plus the variable array for the stripes */
>>>>           sizeof(struct btrfs_io_stripe) * (total_stripes) +
>>>>           /* Plus the variable array for the tgt dev */
>>>> -        sizeof(int) * (real_stripes) +
>>>> +        sizeof(u16) * (real_stripes) +
>>>>           /*
>>>>            * Plus the raid_map, which includes both the tgt dev
>>>>            * and the stripes.
>>>
>>> Why not order the various sizeof() in the same manner as in the 
>>> struct btrfs_io_context?
>>
>> Because the tgtdev_map would soon get completely removed in the next 
>> patch.
>>
> 
> Ah. Ok.
> 
>> Just to mention, I don't like the current way to allocate memory at all.
>>
>> If there is more feedback, I can convert the allocation to the same 
>> way as alloc_rbio() of raid56.c, AKA, use dedicated kcalloc() calls 
>> for those arrays.
> 
> The alloc_rbio() method allocates each component independently, leading
> to frequent memory allocation and freeing, which could impact 
> performance in an IO context.

That method is fine if we only have one variable length array (stripes).

But it won't be a problem anymore, the 3/3 would make the dev-replace to 
only take one s16 to record the replace source.

Then I have a new patch to this series, which converts *raid_map into a 
single u64.

By all those work, btrfs_io_context structure would only have one 
variable length array (stripes), then the existing method would be 
acceptable.

The final result would make btrfs_io_context look like this: (comments 
skipped, as the comments would be larger than the structure itself)

struct btrfs_io_context {
         refcount_t refs;
         struct btrfs_fs_info *fs_info;
         u64 map_type; /* get from map_lookup->type */
         struct bio *orig_bio;
         atomic_t error;
         u16 max_errors;
         u16 num_stripes;
         u16 mirror_num;

         u16 replace_nr_stripes;
         s16 replace_stripe_src;

         u64 full_stripe_logical;
         struct btrfs_io_stripe stripes[];
};

> 
> It may be goodidea to conduct a small experiment to assess any
> performance penalties. If none are detected, then it should be ok.

If HCH or someone else is going to make btrfs_io_context mempool based, 
then I guess we have to go the other way, mempool for btrfs_io_context, 
but still manually allocate the stripes.

Anyway the updated series would benefit everyone (at least I hope so).

Thanks,
Qu

> 
> Thx,
> 
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thx.
