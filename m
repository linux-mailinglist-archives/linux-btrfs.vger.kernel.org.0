Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09D275A28F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGSW5F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 18:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGSW5D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 18:57:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083CF268E
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 15:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689807357; x=1690412157; i=quwenruo.btrfs@gmx.com;
 bh=+iy/gwbUBZIsGr1551C8DWkLwwzi0M4QseNBXDeF+9E=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=myHxTolxi8ce+kCH+dfeQGNsFXM2Fk19x8K/zY7HW9N3qSaXo3P5W1QX9aDxp/HZkZo0XhE
 MqpUmF+wBZrlzj/U/u+jXX2k8ykeM+qDXbBSYxcV5E+Myaobz3Y0gcPCoPnb6vI3HKUauwq9q
 /FAMIku/N7c8CGna+BsJEKCj8xfxqTHcqimvaqp0zQtflKWvlr7wOBPISWjtnmjreLN9kjWsj
 EloSoS8jAljlOiEJHCXNj4oT4MGzjdVramzn7gY3IBLOvp9pzb65n9Q48Q3nNb4OxT8Mrt1uz
 LRIKv1gtAexESEa60EF9zRmm3Y6Y2ELTZl5uWA9PkpEQLb4nj7RQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWASY-1qOulb46EU-00XdIM; Thu, 20
 Jul 2023 00:50:38 +0200
Message-ID: <0f3bffa6-1d77-8134-ecde-15fecfb21667@gmx.com>
Date:   Thu, 20 Jul 2023 06:50:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: scrub: speed up on NVME devices
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Martin Steigerwald <martin@lichtvoll.de>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
 <6c9a9e34-365a-3392-0289-a911b34a9e4d@gmx.com>
 <4f48e79c-93f7-b473-648d-4c995070c8ac@gmx.com>
 <1921732.taCxCBeP46@lichtvoll.de>
 <ffb05334-b3ee-3a74-8c07-84afa2e62932@kernel.dk>
 <2f0d357e-88bd-d824-872e-8ec3d0e40af2@gmx.com>
 <b6d1ace1-2ba1-5ef4-5641-3813f9c1a90a@kernel.dk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b6d1ace1-2ba1-5ef4-5641-3813f9c1a90a@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kJp9DR5j1AfPfdqZPV5Zx9mBmgEYAUWW/S8OWiROvmB/ZAZYJtk
 sE/JN8pX/3D6ayvtq+AZgxa+cuexLLjJly/qR7KOqWb2FHW2/B2onStBzNkTmAlOthsFfIo
 bsmMrYsoQZglt/uVH9crHWJB9/MgodJadBJhGyZFHjmSDa5L0vKZhBBdmXKnEJKMow+9BTg
 dBg7E3eIorwKpEXpQxQWg==
UI-OutboundReport: notjunk:1;M01:P0:LuGhti3oF38=;7Lj7/spBq8IEnGYbUFcq9AKifd/
 GDtjeeXxD2siRH7b1ttb8h1sgwLVcQ6bi332NrFVG4GRRaluFZbyLYIIzU85yLiHZCAWjgVJk
 h0PU0UkXD5p8hRJd1c9KJb6P2pC8K9YKGtYZIz8FfZOMECpClxf+hkDgp7l2/es5epk0vMP0/
 oHOMs5pGKp21684Hbcg6P/sgEwKHYgg3oHvh8K2hqzKc6DlxjODWLax9T7JSt1EFjpaIT31ZR
 kwjTRj7PsHABuTqLzRa9UzlqkKachCY6rxlFI3skHvAutxtFgPnfILtTzn8Wi4BDOKmrAgy+v
 15Th8bb75C8Hb2DdiiwIBPmF56cg0eGfgZd1Z6cemyq76ivKtC+OMnJoyiSEoJmVlh36I8iWa
 Xtt23xJw7VfBO72y1ceDDpzN2Kq+6lgQZT/q6hTM4dYlxKCeNuSREpdOGZVQZV5rCfPGn4zPO
 f0T8voAaXWlFCTMQXfzlwoDRHnqlDkXhnXUgdYMswcWLd25bZcPORaAgv6aTHNwRHjcWWFHGy
 pfWHCbHa0fzxMd6ihLEEX3gXeSAc3Q1crSofiAn8cKBwNxzUAfBcsClyi6NXOLD7HEeYPG2L5
 e72KHuw/bxSpj7UI8inK+PKn64zPv5MJeQ2Lb/Lzk50c6ae33AYCfZr6CagAc8coLC6QgA8Mk
 QA9ggwssnCCvMXKTJD9MrS0imUcez6FA3v0aF8Ft1MezxT7xvpm5daneTbSKv9YnxyBzM+n6U
 vT6jrKLwVu3Y3AqfuM01ZW0nxfLnOLIrzcnfpk/auD1NnoZJH6rX4P/O2JhzhCn25pHDrYPd0
 EPwF787GhYUtLCu23VuUSOtg+3EdCoWBNu5HJ2CC0LPYvJ2OodmLV/v0E5YG1EJissUD4qs69
 GsKCpiFNSldgf9vJ9wvrCt+2ivvIRu0ebppfkqvs5kBg2Mlp5LBBg8fTTuo5vJDmc31Q8UOwI
 6os39cJFFAh1Qo8cJYU1V/Gx5eU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/20 06:36, Jens Axboe wrote:
> On 7/19/23 4:30?PM, Qu Wenruo wrote:
>>
>>
>> On 2023/7/19 22:59, Jens Axboe wrote:
>>> On 7/19/23 1:27?AM, Martin Steigerwald wrote:
>>>> Hi Qu, hi Jens.
>>>>
>>>> @Qu: I wonder whether Jens as a maintainer for the block layer can sh=
ed
>>>> some insight on the merging of requests in block layer or the latency=
 of
>>>> plugging aspect of this bug.
>>>>
>>>> @Jens: There has been a regression of scrubbing speeds in kernel 6.4
>>>> mainly for NVME SSDs with a drop of speed from above 2 GiB/s to
>>>> sometimes even lower than 1 GiB/s. I bet Qu can explain better to you
>>>> what is actually causing this. For reference here the initial thread:
>>>>
>>>> Scrub of my nvme SSD has slowed by about 2/3
>>>> https://lore.kernel.org/linux-btrfs/
>>>> CAAKzf7=3DyS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/
>>>>
>>>> And here another attempt of Qu to fix this which did not work out as =
well
>>>> as he hoped:
>>>>
>>>> btrfs: scrub: make sctx->stripes[] a ring buffer
>>>>
>>>> https://lore.kernel.org/linux-btrfs/cover.1689744163.git.wqu@suse.com=
/
>>>>
>>>> Maybe Jens you can share some insight on how to best achieve higher
>>>> queue depth and good merge behavior for NVME SSDs while not making th=
e
>>>> queue depth too high for SATA SSDs/HDDs?
>>>
>>> Didn't read the whole thread, but a quick glance at the 6.3..6.4 btrfs
>>> changes, it's dropping plugging around issuing the scrub IO? Using a
>>> plug around issuing IO is _the_ way to ensure that merging gets done,
>>> and it'll also take care of starting issue if the plug depth becomes t=
oo
>>> large.
>>
>> Thanks, I learnt the lesson by the harder way.
>>
>> Just another question related to plugs, the whole plug is per-thread
>> thing, what if we're submitting multiple bios across several kthreads?
>>
>> Is there any global/device/bio based way to tell block layer to try its
>> best to merge? Even it may means higher latency.
>
> Right, the plug is on-stack for the submitting process. It's generally
> pretty rare to have cross-thread merges, at least for normal workloads.
> But anything beyond the plug for merging happens in the io scheduler,
> though these days with devices having high queue depth, you'd have to be
> pretty lucky to hit that. There's no generic way to hold off.

Thanks for clarifying this.

>
> Do you have multiple threads doing the scrubbing?

No, initially I have a multi-thread (and over-engineered) implementation
to make the initial read submission happen in the main thread, but all
later work (verification, and writeback for repair/replace) happens in
different workers.

But later I finally found out that it's not the read part causing the
low throughput, but the preparation part before read submission.

Thus this is just to fill my curiosity.

Thanks very much for the explanation!
Qu

> If yes, then my first
> question would be why they would be working in areas that overlap to
> such an extent that cross thread merging makes sense? And if there are
> good reasons for that, and that's an IFF, then you could queue pending
> IO locally to a shared list, and have whatever thread grabs the list
> first actually perform all the submissions. That'd be more efficient
> further down too.
>
