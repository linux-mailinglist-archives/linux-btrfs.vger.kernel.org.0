Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F4275716D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 03:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGRBlO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 21:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRBlM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 21:41:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDD019B
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689644467; x=1690249267; i=quwenruo.btrfs@gmx.com;
 bh=Fqyf+9yeBrlE9UolfCHWwAS7aNlEoYZ4I6L/OCpPHho=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=ROMIWtlR9OqbGVdGXewSZFWbfrvLC4ACP3qgevrmCB6zkpN/Y7XhfLE789TnMREg0QkqCPm
 Qyemi3V5sc/5WBPPVMGRoWYJkmj0K2DDJOVS/ZjJVmfkqfCYi+6LuPxZ+FOtGpXZdhKV2qQSR
 4T4dfU1LbLFRiKRk5FEYAmB7xfRUUxULkAcWUbwv3IqQ5l0aUnKPKISEQ69+N/zPyRUlkK3tW
 hVw/LRCWY148IjZ8W1o1eKfoLL3UsxeClhhBGHmnZcvt63W+Uplq07GTCwNsymtZU9VLH0UIo
 S2mSwKm/Njf38zHjPwEowqgpE4QUgbBfAMFBnCiFqCVnhHDYkLtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5QJJ-1qKC8N1FzB-001Ue8; Tue, 18
 Jul 2023 03:41:06 +0200
Message-ID: <6c9a9e34-365a-3392-0289-a911b34a9e4d@gmx.com>
Date:   Tue, 18 Jul 2023 09:41:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
 <20230718005924.GN20457@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: scrub: speed up on NVME devices
In-Reply-To: <20230718005924.GN20457@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UPhfjligZ7EPPWRknDvEj4nNdOB3BAaVHJUdSAPf/xfxa8dRXrh
 NInT/7Hbrz7kj04bBZJ6b8fiI7vmm0/lsnYMtvqy51Nw3H8TLC9EQHD2T2TjRWth1cGn3gS
 UqWQiJYc9klp2dP9KNncu1M+v9dOLxOoxrA+LBTz8RUcTXlblkYHzK65CpgPOCkuyM+PzZg
 7RapbzBXfO8V+eQ4AcCug==
UI-OutboundReport: notjunk:1;M01:P0:EDZ9O15hkyk=;kTNNCUwYz0906M5Ht8vk7rDSWVB
 3zW/zklHev5bQYmYpBDRNRUfCtmqr+9CcZseeP822eVF4X01kz1r49+yyk7oVLKeD2ucCPSqK
 NKy0qalIawQZVrgUXwtT+Vd7voJ2wAj/5DcEBUC9RZmMSOAlVstd7YwEUqAPH4oCQfu8Wcjyj
 4tZ7kOfRzvsBkKTm9vN1wvsLpb8FnLy3/fDHcYnryXmhOPcCxQOSpOXZeGUxJLxGNs5sAnsz3
 oTzQowGRTHnlywuv7Y3CZEsinurAOPIKU0iSOlYlracNKN3ECE02gpb+PliF8dLEQi5tcYwdG
 3QSjx8dhC9tWDrQ4gfF+qUE+22k8CuQwqgwU7Jg8iiQ/1jPC1W6JleaPkzHL7PN4uyXYZlQ9e
 V/2fhprGMZpuIGRbRk8pmAYBgLF1QBm+5Y/o126PjQu/dzyjg4vXfnpq+ae2jMYWKxmGqBgon
 t3VChX3FlX5liFZ9SKFLN2caoLlSyiu3filWoqIqpSVJv6GJCI5ENXp3STUbDmuSi5VF80BZ7
 qjd1mL6Fj91KRVwUbN6a5eP9kySaS+2XaCMh89M93PmJE4XLb7xgsZejJAE+OJY1WIxdLhEHJ
 oL5v+anayoCJ5iCCLiJVU230ntcH8ZIYc1Yye7NNYAWA/bQQvuLFBGluaU8S/0G8Ym7/JBTCt
 ROnLzdtc/qVlsYNIof2u/M/eqB/55/LN/SNLJcylPVfthxsM8iQOgr1hFr5qMGnE4KwvBVSGv
 ITnmnE+sTGMQoSUCTaB6NKptNC/XBDWVJ0K5yFXf5O0LqWnxNSs7PIYhHOiXbH2CP2czHF/CW
 3ZK5I7d3Mu6O/zPx56gONUTJzokypBZs8+z60DwcGJPExiHHZ7qUUxbEyzIfSX3E/PKv/Ufn+
 71NJFvL3alyvLJWq3QXzyTyzp4mMLeymtZb6L5ijGQVqJ5c+sNfk1bjt81hfWRlBIijWNFgA8
 E3ohnelTuSm0qXA0fZnFCxFvMNk=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/18 08:59, David Sterba wrote:
> On Fri, Jul 14, 2023 at 06:26:40PM +0800, Qu Wenruo wrote:
>> [REGRESSION]
>> There are several regression reports about the scrub performance with
>> v6.4 kernel.
>>
>> On a PCIE3.0 device, the old v6.3 kernel can go 3GB/s scrub speed, but
>> v6.4 can only go 1GB/s, an obvious 66% performance drop.
>>
>> [CAUSE]
>> Iostat shows a very different behavior between v6.3 and v6.4 kernel:
>>
>> Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  =
%util
>> nvme0n1p3  9731.00 3425544.00 17237.00  63.92    2.18   352.02  21.18 1=
00.00
>> nvme0n1p3 20853.00 1330288.00     0.00   0.00    0.08    63.79   1.60 1=
00.00
>>
>> The upper one is v6.3 while the lower one is v6.4.
>>
>> There are several obvious differences:
>>
>> - Very few read merges
>>    This turns out to be a behavior change that we no longer go bio
>>    plug/unplug.
>>
>> - Very low aqu-sz
>>    This is due to the submit-and-wait behavior of flush_scrub_stripes()=
.
>>
>> Both behavior is not that obvious on SATA SSDs, as SATA SSDs has NCQ to
>> merge the reads, while SATA SSDs can not handle high queue depth well
>> either.
>>
>> [FIX]
>> For now this patch focus on the read speed fix. Dev-replace replace
>> speed needs extra work.
>>
>> For the read part, we go two directions to fix the problems:
>>
>> - Re-introduce blk plug/unplug to merge read requests
>>    This is pretty simple, and the behavior is pretty easy to observe.
>>
>>    This would enlarge the average read request size to 512K.
>>
>> - Introduce multi-group reads and no longer waits for each group
>>    Instead of the old behavior, which submit 8 stripes and wait for
>>    them, here we would enlarge the total stripes to 16 * 8.
>>    Which is 8M per device, the same limits as the old scrub flying
>>    bios size limit.
>>
>>    Now every time we fill a group (8 stripes), we submit them and
>>    continue to next stripes.
>
> Have you tried other values for the stripe count if this makes any
> difference? Getting back to the previous value (8M) is closer to the
> amount of data sent at once but the code around has chnaged, so it's
> possible that increasing that could also improve it (or not).

I tried smaller ones, like grounp number 8 (4M), with the plugging added
back, it's not that good, around 1.6GB/s ~ 1.7GB/s.
And larger number 32 (16M) doesn't increase much over the 16 (8M) value.

The bottleneck on the queue depth seems to be the wait.

Especially for zoned write back, we need to ensure the write into
dev-replace target device ordered.

This patch choose to wait for all existing stripes to finish their read,
then submit all the writes, to ensure the write sequence.

But this is still a read-and-wait behavior, thus leads to the low queue
depth.


>
>>    Only when the full 16 * 8 stripes are all filled, we submit the
>>    remaining ones (the last group), and wait for all groups to finish.
>>    Then submit the repair writes and dev-replace writes.
>>
>>    This should enlarge the queue depth.
>>
>> Even with all these optimization, unfortunately we can only improve the
>> scrub performance to around 1.9GiB/s, as the queue depth is still very
>> low.
>
> So the request grouping gained about 700MB/s, I was expecting more but
> it's a noticeable improvement still.

I think the queue depth is the final missing piece, but that's not
something we can easily fix, especially taking zoned support into
consideration.

>
>> Now the new iostat results looks like this:
>>
>> Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  =
%util
>> nvme0n1p3  4030.00 1995904.00 27257.00  87.12    0.37   495.26   1.50 1=
00.00
>>
>> Which still have a very low queue depth.
>>
>> The current bottleneck seems to be in flush_scrub_stripes(), which is
>> still doing submit-and-wait, for read-repair and dev-replace
>> synchronization.
>>
>> To fully re-gain the performance, we need to get rid of the
>> submit-and-wait, and go workqueue solution to fully utilize the
>> high queue depth capability of NVME devices.
>>
>> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scr=
ub_stripe infrastructure")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> For the proper fix, I'm afraid we have to utilize btrfs workqueue, let
>> the initial read and repair done in an async manner, and let the
>> writeback (repaired and dev-replace) happen in a synchronized manner.
>>
>> This can allow us to have a very high queue depth, to claim the
>> remaining 1GiB/s performance.
>>
>> But I'm also not sure if we should go that hard, as we may still have
>> SATA SSD/HDDs, which won't benefit at all from high queue depth.
>
> I don't understand what you mean here, there are all sorts of devices
> that people use and will use. Lower queue depth will lead to lower
> throughput which would be expected, high speed devices should utilize
> the full bandwidth if we have infrastructure for that.
>
> To some level we can affect the IO but it's still up to block layer.
> We've removed code that did own priority, batching and similar things,
> which is IMHO good and we can rely on block layer capabilities. So I'm
> assuming the fixes should go more in that direction. If this means to
> use a work queue then sure.

OK, I'll go the workqueue solution, making the sctx->stripes[] a ring
buffer like behavior.

So we will still batch all the reads of the same group, then let the
repair part happen in the async part of the btrfs workqueue, and the
write to dev-replace target to happen in the ordered part.

Hopes by this we can enlarge the queue depth and gain back the performance=
.

Thanks,
Qu

>
>> The only good news is, this patch is small enough for backport, without
>> huge structure changes.
>
> Yeah that's useful, thanks. Patch added to misc-next.
