Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B38C69A2E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 01:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBQAPh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 19:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBQAPh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 19:15:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B1D4C3E1
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 16:15:25 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4z6q-1oRwON2HmG-010whG; Fri, 17
 Feb 2023 01:15:16 +0100
Message-ID: <9cdc5adf-3479-c79e-2549-d4743affd26c@gmx.com>
Date:   Fri, 17 Feb 2023 08:15:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Boris Burkov <boris@bur.io>,
        Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
 <Y+1pAoetotjEuef7@zen> <dabed1bf-da8b-6ef4-77c4-e2c28cf9106f@gmx.com>
 <CAL3q7H4nHvNtH84ZwkZm0kGSALNfFZNYc7=WuQ=FBcrGuYd7Dg@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H4nHvNtH84ZwkZm0kGSALNfFZNYc7=WuQ=FBcrGuYd7Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:koSrFBIHU1VRA+vQ+tSndtU7vXgQOl3tqeYLm9xiSxxyc+nn0jg
 9+oVZg0JGswQIAco/6kZiGEIPQhf8HUYOLCV/9+icejuTuThi2OP0JL0/KEhopTjicml77Y
 tUTm1arE8RL9I3K710160n1wEBNSYbCUqJjAWFbV2+XvmGJG8+i7Yg5vIXyacHuhh8emcvM
 D5ooXfBgrFR1NOk95kZXA==
UI-OutboundReport: notjunk:1;M01:P0:NACQQucuzYY=;NrQG31E/BUSC2XewV+XBj6WBta3
 99B3Kdip7G0o6ySp5t2WNO+T9CfKXVejlG0ioX8HybBuyLTw7VmTfWoc4S4ZyTtKpzA5uwDUy
 07bfY9C2F53yHf7UGvGEJBkHKW9OVRYocfREwVeKVoeF/7BcKJz7AZLZzznIZMkkOVIkRDu/K
 MxWlxTtCot71IHEpD8IgDU9g2ub3/rrZR0WCd6NDwMJeJVIOwXhqnG16goGWU7XnGi5nS4avZ
 D1JLLYukNWny7PSychZMjAC88ebfqDYIvgR8by5HpAsmwqRoQKzC9VSul715ftNdPmMQn08lS
 73KREAOiqfEYBKRiLJangGsAb92CS3cDdeespzVyXa1Ud7uteL1YY2xIyVoyB01dKnUcV/Lfz
 EqDK4ltenJIgPIfmsfRHia06JEKBcIz1p1BBKg6Swo/SKzsuqlk0KZoh+vxD4veKVU3ZyQjT6
 W6S3dRyTY7RuQiSL7g/lHA9RTCGlV3BYkvRkiieAGdF4EQAO+gB1KXO4bAwUPt0zNbfKAn4Qx
 ec/Dpv0wUquiWsirvOD/S4OGSM71e7M+aMkGVt9VY0fyXHqTTukGrJbWhnagzfQzZ2rqQLjqc
 8MPCMKjyjhqYYJBHaRkWxhnbfahxHRzcQSzWAEvrwa14SaGYFUgnX/NnDjoYMjTQ6CQ1lKezc
 lAoA4NKgVqwVFTIT346vhwdVwC8AZPmEek+5jL5/Tmat+zSpPlsujB1UUhF1t6sp48S8XMLbR
 Ix97KT0GS/p6aEQvVww6A0KNFBtn8RyQ8UGJ6tqOFmR93BVILl/EOpuZeUhsndrXqNQV0N5Ht
 cg/nW/CdQbv6mWz7pl4qqqkoGnvoNVwoS2iXcSsy1VshfQdXJbm+PimWjuASPpfm3rxA/U+3k
 L8WEd1n6B60NfUPPcV2hryQiQ6ev6QD86TOzvsUUJGnJggmt+FUyFdhh2GWulSX1+APYz12Ux
 xdVEy2vU3yZfuo5H1toFmF9hObA=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/16 20:01, Filipe Manana wrote:
> On Thu, Feb 16, 2023 at 10:23 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2023/2/16 07:21, Boris Burkov wrote:
>>> On Wed, Feb 15, 2023 at 03:16:39PM -0500, Chris Murphy wrote:
>>>>
>>>>
>>>> On Wed, Feb 15, 2023, at 3:04 PM, Chris Murphy wrote:
>>>>> Downstream bug report, reproducer test file, and gdb session transcript
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2169947
>>>>>
>>>>> I speculated that maybe it's similar to the issue we have with VM's
>>>>> when O_DIRECT is used, but it seems that's not the case here.
>>>>
>>>> I can reproduce the mismatching checksums whether the test files are datacow or nodatacow (using chattr +C). There are no kernel messages during the tests.
>>>>
>>>> kernel 6.2rc7 in my case; and in the bug report kernel series 6.1, 6.0, and 5.17 reproduce the problem.
>>>>
>>>
>>> I was also able to reproduce on the current misc-next. However, when I
>>> hacked the kernel to always fall back from DIO to buffered IO, it no
>>> longer reproduced. So that's one hint..
>>>
>>> The next observation comes from comparing the happy vs unhappy file
>>> extents on disk:
>>> happy: https://pastebin.com/k4EPFKhc
>>> unhappy: https://pastebin.com/hNSBR0yv
>>>
>>> The broken DIO case is missing file extents between bytes 8192 and 65536
>>> which corresponds to the observed zeros.
>>>
>>> Next, at Josef's suggestion, I looked at the IOMAP_DIO_PARTIAL and
>>> instrumented that codepath. I observed a single successful write to 8192
>>> bytes, then a second write which first does a partial write from 8192 to
>>> 65536 and then faults in the rest of the iov_iter and finishes the
>>> write.
>>
>> A little off-topic, as I'm not familiar with Direct IO at all.
>>
>> That fault (I guess means page fault?) means the Direct IO source
>> (memory of the user space program) can not be accessible right now?
>> (being swapped?)
>>
>> If that's the case, any idea why we can not wait for the page fault to
>> fill the user space memory?
> 
> Sure, you can call fault_in_iov_iter_readable() for the whole iov_iter
> before starting the actual direct IO,
> and that will work and not result in any problems most of the time.
> 
> However:
> 
> 1) After that and before starting the write, all pages or some pages
> may have been evicted from memory due to memory pressure for e.g.;
> 
> 2) If the iov_iter refers to a very large buffer, it's inefficient to
> fault in all pages.

Indeed. As even we load in all the pages, there is no guarantee unless 
the user space program pins the pages in advance.

Another question is, can we fall back to buffered IO half way?
E.g. if we hit page fault for certain range, then fall back to buffered 
IO for the remaining part?

Thanks,
Qu

> 
>> I guess it's some deadlock but is not for sure.
>>
>> Thanks,
>> Qu
>>>
>>> I'm now trying to figure out how these partial writes might lead us to
>>> not create all the EXTENT_DATA items for the file extents.
>>>
>>> Boris
>>>
>>>>
>>>> --
>>>> Chris Murphy
