Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542D075A1EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjGSWb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 18:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGSWbY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 18:31:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8BA1BF0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 15:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689805858; x=1690410658; i=quwenruo.btrfs@gmx.com;
 bh=tBIGQN6Es2tv9MI4j+Ubb8xwfp0axtIrCGJa/RTYH2k=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=rLQHVokf7ktPsN3+nyfmLsbx4udiQptfjo9Sw1hOBech4K793oYi5AzcTiDwT0tLxNwxh8h
 9oxztUId2FMfGPxIVRuk6yNls1g/0vO+M09pkWgYncQyS/3Tw7SFDIExCSNSCDYLoyDM3I7fe
 6jb3hAIzsHCNGozOwZ1xYSmFI4aYKxPy4kEbTyYJOi4XhKUT04O6rOZ1umaFwhw8ae/9taKyq
 mgm0FgAr6kzIr8IJP/VIP3fuxvaiJtj2eMMdJKTY5WMEH1k7ogbJBX4ia5odERZUc8W0w4V/h
 f/IklcuH6///DQRaqp8LEiZofM3cq6y49KOdMHmuVegasNiBOMng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCKBm-1qDyDr3YVm-009PAl; Thu, 20
 Jul 2023 00:30:58 +0200
Message-ID: <2f0d357e-88bd-d824-872e-8ec3d0e40af2@gmx.com>
Date:   Thu, 20 Jul 2023 06:30:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Jens Axboe <axboe@kernel.dk>,
        Martin Steigerwald <martin@lichtvoll.de>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
 <6c9a9e34-365a-3392-0289-a911b34a9e4d@gmx.com>
 <4f48e79c-93f7-b473-648d-4c995070c8ac@gmx.com>
 <1921732.taCxCBeP46@lichtvoll.de>
 <ffb05334-b3ee-3a74-8c07-84afa2e62932@kernel.dk>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: scrub: speed up on NVME devices
In-Reply-To: <ffb05334-b3ee-3a74-8c07-84afa2e62932@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pTsF5iMRDFk8CrM5v1JdYbVDmKeaKnPmECx1mRo3pX1LoHzU7lB
 39OR6mNiQ3b6E984/myz+cIY5tpXGMWPNbDsPCfQ/H5GxbhM7h0tvkqAp+OF0aCnRpbXn81
 O9u5z+uN6cCCmB6wSawAJd5HwR2cx9Kmg5eVotD50tJDaW66swIMLO/EA9kfgBAwUSJPzTC
 KnH8lz+9WyrAAcWzjjR4g==
UI-OutboundReport: notjunk:1;M01:P0:STZ/f1SeLBQ=;14PHa3GIbObXPsa2MEmN+2BwoiY
 seoDsGO6HUCUZV2udGkJ9zinBew+WquvbEYc+n72s5OLvRdVE975tgwMXMITV+LIr310Scbev
 +Nwj1AacR4pH/CoMcfWKJyrnwQhQ6i/6yd7/YbxEz+byn595KoSp0iK9PWikf/xyjeJ6TJ97o
 X5cceLmta4n5mDcNnZViJWJkdN45RdJLZwX30TgshtRWwi86ZjKhGpldecxEDAwlXBCe3K0Gf
 ID59OMgZujbnM2vJFmdogd/qvZ57kmItmiQOP2KKAHB0DmstIkPDuby8UAi2Sc45RChOJYiy1
 1g+MLnRC1DXATxS1ZKf+cqb9j/64H68T6VArEzETTCruuwnEhirhNe2pXhU02nbKOFElKml8m
 UMSyetjIm1/v0Ib8XAGP1d9GJirqYrkuSBp1wKHrNYcfhyHUpBgAWqVgoodfxem+94os62X9Q
 XUGKYABzz9gJuR55wmRO02IuWKmjYwPg8xQebrlZpbp/1ZfP3kX56OtEi/g7VAozGOGsmix31
 iPlbsQvyHOzE0VY+Y/2E1vcRxs58XM5LrZT6XltLS129NSefXo7FWBk0CvjGFdnuVhQaCC2J5
 3ZNRF3DL+IGLLNytVgxuUE7zgMjHVmSyCf9GOQUXiUp6NqvKyCJxeQqdzjaYE609sJRhdtbih
 G9gEGQCUhfaZsNhmAJJv560vKtm9h+Hq70oEZFoy9tDbTjy4vKSq32LfPuJerxjpaSgZYNcOQ
 A+Rn+XHHqWbSVIMlh9OmNvE/PZwQShcpAcM+XlT10kOWN4ngVGoSGh7Irs++yoxUl/WT9jhoj
 5wy4htd7War8IxfFxTPxiVumIHJF942oHEwBkkcj6jauD9ZG+LvoHFD5SunY2IVtY8LO2exY/
 o4sQ3FysigyMwICU3+zlJ8MPgDAqkTWbOGzhlM+AkEwBV3bWwQyGX1wKgPZNumsBGFgMkixDj
 2NRjPX1wUYoNkGrA3Q/Fox01diI=
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



On 2023/7/19 22:59, Jens Axboe wrote:
> On 7/19/23 1:27?AM, Martin Steigerwald wrote:
>> Hi Qu, hi Jens.
>>
>> @Qu: I wonder whether Jens as a maintainer for the block layer can shed
>> some insight on the merging of requests in block layer or the latency o=
f
>> plugging aspect of this bug.
>>
>> @Jens: There has been a regression of scrubbing speeds in kernel 6.4
>> mainly for NVME SSDs with a drop of speed from above 2 GiB/s to
>> sometimes even lower than 1 GiB/s. I bet Qu can explain better to you
>> what is actually causing this. For reference here the initial thread:
>>
>> Scrub of my nvme SSD has slowed by about 2/3
>> https://lore.kernel.org/linux-btrfs/
>> CAAKzf7=3DyS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/
>>
>> And here another attempt of Qu to fix this which did not work out as we=
ll
>> as he hoped:
>>
>> btrfs: scrub: make sctx->stripes[] a ring buffer
>>
>> https://lore.kernel.org/linux-btrfs/cover.1689744163.git.wqu@suse.com/
>>
>> Maybe Jens you can share some insight on how to best achieve higher
>> queue depth and good merge behavior for NVME SSDs while not making the
>> queue depth too high for SATA SSDs/HDDs?
>
> Didn't read the whole thread, but a quick glance at the 6.3..6.4 btrfs
> changes, it's dropping plugging around issuing the scrub IO? Using a
> plug around issuing IO is _the_ way to ensure that merging gets done,
> and it'll also take care of starting issue if the plug depth becomes too
> large.

Thanks, I learnt the lesson by the harder way.

Just another question related to plugs, the whole plug is per-thread
thing, what if we're submitting multiple bios across several kthreads?

Is there any global/device/bio based way to tell block layer to try its
best to merge? Even it may means higher latency.

>
> So is this a case of just not doing plugging anymore, and this is why
> the merge rate (and performance) drops?
>

That's part of the reason, another problem is due to the new fixed block
size, we spent much more time on preparing the needed info before
submitting the bio, thus reducing the throughput.

I'm working on reducing the overhead to properly fix the regression.

Thanks,
Qu
