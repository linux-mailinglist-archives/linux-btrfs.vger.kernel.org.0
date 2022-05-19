Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D2F52D0CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiESKqY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 06:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiESKqT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 06:46:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BA25BE41
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 03:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652957168;
        bh=ExZ8g5+1YFiERY96ORoGWQOc5OLOWUe/By9TkRQOVL4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=khaJ1z4ZND6zk+RTF6JthXDbj7GjPQCSzU72O3yHkuZ6mKLWYnUWB60AIj6AZiWFQ
         HOcDCUxVVwTFrZvFDFagdYHfTljoDMw5rAOG2dt9fB4zMFJPC3h/vCbdoudg1VW6rz
         IqT3jIVhX+4+AKFprCy7vPxLIhq00zGj2PCCeaaE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wLT-1nxvzo1TRb-007TY7; Thu, 19
 May 2022 12:46:08 +0200
Message-ID: <18a7a039-fdc8-8b44-edf8-85af99ef616c@gmx.com>
Date:   Thu, 19 May 2022 18:46:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-13-hch@lst.de>
 <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
 <20220519093641.GA32623@lst.de>
 <d99b2ba3-23d2-0ea1-9aa4-13a898e77ab6@suse.com>
 <da8e2614-e365-da00-dad5-1d4cf62b1e20@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <da8e2614-e365-da00-dad5-1d4cf62b1e20@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1lFwuVPrfcoC92SyLtF+DeILCFg+Z+SsOxvvB3Ygf3qxau5kd6D
 qTBoWYtu1UtcohPwZCrlR2b3sOpVlVGX0StkgYUyE/KLl1/Q59GVM1Wu/9t3G2qr4puaPj4
 +v8Iz4SfTWisap/JUBJq5HNaz+FqeML/B7fGf3bmGBU3K/FfAVTiUhLZq4i8ogJlVXTFqCH
 rVwLUSkvbejzwMZiULaXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qDyrPU+AbGk=:xtALOeeLzCkn4MshDQkrhb
 J7tlkM1D6Ej8J6CJUrFOYJK+HDyfmHGMQSozPB8sHDn+M/btHQ9YGJsc4V3kiMvQBNX2lzhmv
 dXOpDP0UKi8ZAuDsAA4zGK9PAy7IcoTSJqtnjRnwiA35RzBwzfLg5XIyHMsYi6N05w+MgZkSh
 xW/Ct8BYAjA8Vj3meZINBqPflfP/Q+ePrBYzrJGhqLiqC0/SKGrDdQRNgyKJO6sfnOCwTTgPq
 tQdALVV49ZpS+9MV9m2M+hZbZCSMEJMJhyO4giJ3dRFjpl8NrxuNEPfU5+fiooRM2BcAS1z4K
 MnvWrGhpHweAti9aGkZj3+AuwADI81w45cMDB/LQmxuX0z21/CipGm6BAPlmb6csPa5A2x2BH
 YAIm2Ibg8baiHSWozeqAf47ngMYDto49ufuZd43fCVEnuxuSmNoDq+FXBu0ZJ1vKLbRTQH9Uw
 JUkMk8gwYo5mSCAeudkLMeWQkMAnGjSmnL153PFvgpgFsKlg62E8sKJ8m9XnmMb3ZyBsTO6po
 xMl36pbKkzTJpyRYG6e27FfGKFQmRbbmWn/3NQNfd9NQUMPR5Y+EQ1HOD3XpnQb/yGknyiDCH
 cjDXdI6vAFaitHA/3K0CuOuOJGNfch16rnJzTsjLGeJOKxdct0x8ReJbBLr9ZWUOu6aCygR8Y
 /Ik/dJSiyAdITK2KseP+rAcuYEBPeeRpwo4csOROhYz3gGN6xijS/BYld4CqmkGkxN8Rb7OaF
 JI1k3JOYjvQBOab5b1UgZ4smVtE2r0GwJpMxPbZRTGAKbiAE81g9tXb7ZDVYe1Zu7TMtmTNmB
 fpvILyf5719zo5qCFimKRVEf0j1gMRbqb/nBBxDECjDF94LcHNCgMDJFKUgEr9irKEVufhEVe
 FgAt3hWpuy/IcIr3UVmLdmLpA8pW0zUnAdAZ1+/6DEObs6gIgbiKg1dXeZnZzuKHP1wnZLUe8
 HlZhUsXP8gczN1ssBzDRdRjwSP79RHzauFwRHXtzY72r2B1Kwylq/qKTsK6G5GfL2bTTcH97B
 it7kYjv2ydEa/Ka2NcJLrjocwS7P6BRRpSzi4lZipsL+RC/RaODmJx6HyQysNQM2xJtJB+681
 ssN8UA5xh+UtB9ngl7IIqoRtA6KzgLF3gBEf21d3/nx0uuCNyqXcFdDRA==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/19 18:45, Nikolay Borisov wrote:
>
>
> On 19.05.22 =D0=B3. 13:41 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2022/5/19 17:36, Christoph Hellwig wrote:
>>> On Wed, May 18, 2022 at 07:04:22AM +0800, Qu Wenruo wrote:
>>>> Function btrfs_repair_read_bio() will only return true if all of its
>>>> data matches csum.
>>>>
>>>> Consider the following case:
>>>>
>>>> Profile RAID1C3, 2 sectors to read, the initial mirror is 1.
>>>>
>>>> Mirror 1:=C2=A0=C2=A0=C2=A0 |X|X|
>>>> Mirror 2:=C2=A0=C2=A0=C2=A0 |X| |
>>>> Mirror 3:=C2=A0=C2=A0=C2=A0 | |X|
>>>>
>>>> Now we will got -EIO, but in reality, we can repair the read by using
>>>> the first sector from mirror 3 and the 2nd sector from mirror 2.
>>>
>>> I tried to write a test case for this by copying btrfs/140 and then
>>> as a first step extending it to three mirrors unsing the raid1c1
>>> profile.=C2=A0 But it seems that the tricks used there don't work,
>>> as the code in btrfs/140 relies on the fact that the btrfs logic
>>> address repored by file frag is reported by dump-tree as the item
>>> "index" =C4=ADn this line:
>>>
>>> item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 137756672) itemoff 15751 items=
iz
>>>
>>> but for the raid1c3 profile that line reports something entirely
>>> different.
>>>
>>> for raid1:
>>>
>>> logical: 137756672
>>> item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 137756672) itemoff 15751
>>> itemsize 112
>>>
>>> for raid1c3:
>>>
>>> logical: 343998464
>>> item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15621
>>> itemsize 144
>>>
>>> any idea how to find physical sectors to corrupt for raid1c1?
>>>
>>
>> I also recently hit weird cases why extent allocator no longer puts
>> the first data extent at the beginning of a chunk.
>>
>> So in that case, the best solution is to use "btrfs-map-logical -l
>> 343998464", which will directly return the physical offset of the
>> wanted logical on each involved devices.
>
> Any reason why this is kept as a separate tool and not simply integrated
> into btrfs-progs as a separate command?

For historical reasons I guess.

I'm totally fine to move it into btrfs-ins subcommand.

Thanks,
Qu
>
>>
>> Although we need to note:
>>
>> - btrfs-map-logical may not always be shipped in progs in the future
>> =C2=A0=C2=A0 This tool really looks like a debug tool. I'm not sure if =
we will keep
>> =C2=A0=C2=A0 shipping it (personally I really hope to)
>>
>> - btrfs-map-logical only return data stripes
>> =C2=A0=C2=A0 Thus it doesn't work for RAID56 just in case you want to u=
se it.
>>
>> Despite the weird extent logical bytenr, everything should be fine
>> with btrfs-map-logical.
>>
>> I'll take some time looking into the weird behavior change.
>>
>> Thanks,
>> Qu
>>
