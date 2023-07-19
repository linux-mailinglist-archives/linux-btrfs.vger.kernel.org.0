Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB17590A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 10:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjGSIvp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 04:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGSIvn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 04:51:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C410E
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689756696; x=1690361496; i=quwenruo.btrfs@gmx.com;
 bh=nxXNsXe/LwiS47ygEsq8KGAefOuJvSGOFINVETCHqLE=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=TsTvckUjs8U+8c6f6/Q5Qt/xSJ7F3tv3l7LTzdqQHT2vXzkHD/YQpO+bxiMXMb4G4V8b8Ln
 rluloos9kHLJCMfu/KLNuTN15C01au1FX2V9l7fJkWVLj/z4PkcU0Ak6NW73keocwp34l7KLp
 b9R27bbWvmYPsq0/zmNE+6AgTc/ttLNkOXUq+EIy7jHNZCbj1oMk1go52ygkox/3h56zsreKL
 ah7TaY6suKOKRon9OpZf6aqwFY0nM5wmMIINuinAvx7pGwaVJP+umFhPbPxH3mTc8WwmFtcFv
 qCCgOo9mfq473ESxMwxc7KSYfM9vyh4u4doFwT1soJogYCiyG8sA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hzj-1ptcSu3REl-011mVL; Wed, 19
 Jul 2023 10:51:36 +0200
Message-ID: <62c26796-c8d2-2124-7a30-ff3a7d52d80e@gmx.com>
Date:   Wed, 19 Jul 2023 16:51:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
 <20230718005924.GN20457@twin.jikos.cz>
 <6c9a9e34-365a-3392-0289-a911b34a9e4d@gmx.com>
 <4f48e79c-93f7-b473-648d-4c995070c8ac@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: scrub: speed up on NVME devices
In-Reply-To: <4f48e79c-93f7-b473-648d-4c995070c8ac@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vhof7k7lWAq7R0GqYhHdAM7fho5/cXkq1HNAVr+EGMi1pREKYrH
 qFs+MMwI7dt+4FEA+zRgwIwpBmecTGHR49NaRX2RETgrH077zArkWQqKuhhuOkYxhvPFC3f
 QzIyu7nx7Jd4CjM4ahr7rCiSbKeij6fDFQPIgTNBuXmI0NY9d0/yx0Vjv73L0L/b8l0MxK4
 EWyJ2Cs9HX0Ttxd/aOEsw==
UI-OutboundReport: notjunk:1;M01:P0:xZKQ7oijUe4=;Tghf4Nw2Hiz2v6KqFR2c1OOp9zJ
 3gh/1FAQNMZDMqbwmZ6AJ0ahMq3sXsSShQFmcd64lsmTILieXjXG+MhzkzYeTLsvxJEyGxhiM
 3MePSZ03jJIEriUkpaZak+lz96WSI6MFcKQlXNRwmiJtcWi+kKnnXfKwWx5d20JhMec8xTbF9
 iXfzkKoDsQTaq3HUIO0ruqbTEpDfVSY3YeX+t+oNYqRp5IQ6EfeF/ChjkZlcZ1SvkR032TaC1
 bAjCH+aokKzAB43LJauQLgK/1lwnkEDXM9BX+FuSYy8AQ5cOTNKV4d5Hkx+p8i3+5Kxf5LwF8
 z/ywFiTdQgVm/J0ynAINifJwc+INALRzGaoBbSIz/4qDETuYt+PlsTmGN+OAjRCnRFh/1Qf9L
 FNnLL3cJfrwBDmooEjlDl6U/btorZ1nnNKHISgyLF+qeDeYI7UdK5yXkUJImQ/j1ENXLaeRLB
 n96xTTYymn/8gAxS243qTxcnJQVpHSqdlgHX9/PcFbhUqROSWUqTREcQYR5FylLXvsujoZNm0
 1eSgGODs2kxfdKYKvYOXaO4Hp10qmnfLbB3WGKbMr2eAKW/ruDYGkZKmKdPKVmYinbQScfFTE
 jYrJCV+bifj3L8l93JdMVQnneYdanaeDVcgd52Pni9pckTlJwpbIMVyIiyc2FXOEZXa9eEiCL
 BhW3U34FD9h40QaqfDGPJh1gvOiDsYfSS6/bj6fQMO0EjZWJ47OKrqfrUfF2mJGO6/Xra4kF5
 gfbhYdBrOUUXn8Ltc90s5uIkSZPqGK5oE0u4KTx9CwAUyMq1q+YJX9veGCRH+ucfgnSpuwAT2
 ecu9KCdMBronUFqrhjhCz3FR7nlGz+mBfipvVl2NBK+tDkGKKOtPZwe7WWMXZEXbFeLVSiQCy
 +LlFiFNfWTLv2JHhl5YiftziU6WLd/SzO6RJzhrHvoTpt+VuTaq/5T3cJqC7DDMHcJ6mNBhiJ
 lUKL/cFaNEl7Hzu1pW92HVCuPo4=
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



On 2023/7/19 13:22, Qu Wenruo wrote:
>
>
> On 2023/7/18 09:41, Qu Wenruo wrote:
>>
>>
>> On 2023/7/18 08:59, David Sterba wrote:
>>> On Fri, Jul 14, 2023 at 06:26:40PM +0800, Qu Wenruo wrote:
>>>> [REGRESSION]
>>>> There are several regression reports about the scrub performance with
>>>> v6.4 kernel.
>>>>
>>>> On a PCIE3.0 device, the old v6.3 kernel can go 3GB/s scrub speed, bu=
t
>>>> v6.4 can only go 1GB/s, an obvious 66% performance drop.
>>>>
>>>> [CAUSE]
>>>> Iostat shows a very different behavior between v6.3 and v6.4 kernel:
>>>>
>>>> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r/s=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rkB/s=C2=A0=C2=A0 rrqm/s=C2=A0 %rrqm r_await rareq-s=
z
>>>> aqu-sz=C2=A0 %util
>>>> nvme0n1p3=C2=A0 9731.00 3425544.00 17237.00=C2=A0 63.92=C2=A0=C2=A0=
=C2=A0 2.18=C2=A0=C2=A0 352.02=C2=A0 21.18
>>>> 100.00
>>>> nvme0n1p3 20853.00 1330288.00=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=
=A0 0.00=C2=A0=C2=A0=C2=A0 0.08=C2=A0=C2=A0=C2=A0 63.79=C2=A0=C2=A0 1.60
>>>> 100.00
>>>>
>>>> The upper one is v6.3 while the lower one is v6.4.
>>>>
>>>> There are several obvious differences:
>>>>
>>>> - Very few read merges
>>>> =C2=A0=C2=A0 This turns out to be a behavior change that we no longer=
 go bio
>>>> =C2=A0=C2=A0 plug/unplug.
>>>>
>>>> - Very low aqu-sz
>>>> =C2=A0=C2=A0 This is due to the submit-and-wait behavior of
>>>> flush_scrub_stripes().
>>>>
>>>> Both behavior is not that obvious on SATA SSDs, as SATA SSDs has NCQ =
to
>>>> merge the reads, while SATA SSDs can not handle high queue depth well
>>>> either.
>>>>
>>>> [FIX]
>>>> For now this patch focus on the read speed fix. Dev-replace replace
>>>> speed needs extra work.
>>>>
>>>> For the read part, we go two directions to fix the problems:
>>>>
>>>> - Re-introduce blk plug/unplug to merge read requests
>>>> =C2=A0=C2=A0 This is pretty simple, and the behavior is pretty easy t=
o observe.
>>>>
>>>> =C2=A0=C2=A0 This would enlarge the average read request size to 512K=
.
>>>>
>>>> - Introduce multi-group reads and no longer waits for each group
>>>> =C2=A0=C2=A0 Instead of the old behavior, which submit 8 stripes and =
wait for
>>>> =C2=A0=C2=A0 them, here we would enlarge the total stripes to 16 * 8.
>>>> =C2=A0=C2=A0 Which is 8M per device, the same limits as the old scrub=
 flying
>>>> =C2=A0=C2=A0 bios size limit.
>>>>
>>>> =C2=A0=C2=A0 Now every time we fill a group (8 stripes), we submit th=
em and
>>>> =C2=A0=C2=A0 continue to next stripes.
>>>
>>> Have you tried other values for the stripe count if this makes any
>>> difference? Getting back to the previous value (8M) is closer to the
>>> amount of data sent at once but the code around has chnaged, so it's
>>> possible that increasing that could also improve it (or not).
>>
>> I tried smaller ones, like grounp number 8 (4M), with the plugging adde=
d
>> back, it's not that good, around 1.6GB/s ~ 1.7GB/s.
>> And larger number 32 (16M) doesn't increase much over the 16 (8M) value=
.
>>
>> The bottleneck on the queue depth seems to be the wait.
>>
>> Especially for zoned write back, we need to ensure the write into
>> dev-replace target device ordered.
>>
>> This patch choose to wait for all existing stripes to finish their read=
,
>> then submit all the writes, to ensure the write sequence.
>>
>> But this is still a read-and-wait behavior, thus leads to the low queue
>> depth.
>
> I tried making sctx->stripes[] a ring buffer, so that we would only wait
> the current slot if it's still under scrub, no more dedicated waits at
> the last slot.
>
> The branch can be found at my github repo:
> https://github.com/adam900710/linux/tree/scrub_testing
>
>
> But unfortunately this brings no change to scrub performance at all, and
> the average queue depth is still pretty shallow (slightly better, can
> reach 1.8~2.0).
>
> If needed, I can send out the patchset (still pretty small, +249/-246)
> for review, but I don't think it worthy as no improvement at all...
>
> For now, I'm afraid the latency introduced by plug is already enough to
> reduce the throughput, thus we have to go back the original behavior, to
> manually merge the read requests, other than rely on block layer plug...

Well, I got some progress in a completely different path of scrub.

Since I have no better ideas, I begin skipping certain workload to see
what is really slowing down the read.

Skipped data verification, no difference (a big surprise to me).

Skipped data csum population, the read speed jumped to 2.7GiB/s, which
is already pretty close to the old speed.

This already shows some big progress, the csum and extent tree search is
now a pretty big part, and we're doing the search again and again just
to process one 64KiB.

Thus the core should be reducing the extent/csum tree search, other than
chasing the read pattern. This is also a big wake up call for me, as I
purely assumed the cached extent buffers for extent/csum tree would make
the search as fast as light, but it isn't.

With this new bulb lit (with extra benchmark results backing it up), it
should not be that hard to get back the performance, at least beyond
2.5GiB/s.

Thanks,
Qu
>
> Thanks,
> Qu
