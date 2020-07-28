Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F009B22FE9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 02:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgG1Av0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 20:51:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:59519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgG1AvZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 20:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595897481;
        bh=b8bn6Xr9v4dZ50MzaEMvxNYzVjQxf4dD035d/c+WBH8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fg0VhiIii/i2Q/0QiHcz3BFS2feiPODv1Et6wwIoieLgGPaIcvFhm3QEpz4V3EBCK
         QuADI6VJEQncFLei4wiePP2ZLshg70u3ZdD8tjFkcRcQLXs7J4GAP/9wZoRF3uJzps
         JOSJdYHEKJHnriDo1/a5Gy1EhJUlPaESlSS5LzjY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNpH-1kekj73i0L-00lkVu; Tue, 28
 Jul 2020 02:51:21 +0200
Subject: Re: Debugging abysmal write performance with 100% cpu
 kworker/u16:X+flush-btrfs-2
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
References: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
 <f3cba5f0-8cc4-a521-3bba-2c02ff6c93a2@gmx.com>
 <ae50b6a5-0f1e-282e-61d0-4ff37372a3ca@knorrie.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <b4d0c916-71d5-753a-1c10-cd28f1c3ebec@gmx.com>
Date:   Tue, 28 Jul 2020 08:51:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ae50b6a5-0f1e-282e-61d0-4ff37372a3ca@knorrie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CbSx8sY/066uUmX5dLEIC30EjY41TP/Tn+Z40ppbFTLCSJzgWEU
 rMGCW8gjWNKXdiJxKsPEPB4xSptR1DFwd0cYj1Y6IDR4T0Yz0YXRr2XJA+I+fPke+UBxnCH
 bKeLq9POzJgFiD85V32R7X5LChsTUUgIjbvMj8Ve7rFHrvwAElH1fauIiuV5vXzapgjtL6Z
 XU1caQ/QAa1bI5WqmFdrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AlLShXShX24=:qgz4serpt+V+hrE8oe98Gb
 vNd+9TwYjtvDzxrTqrSov/qIFSbk4kU1ORNf63zpwbp20iZ4INj40QJMdKE0Cb9p7sdCWW51O
 1KpCEEltCnBKPljxVqBvSdiBdJAursxzdRrsamhl14fKuf9S7OxjZCKd/BHhJ08lH/QwqRnYy
 5z7yK8SKoSkxEyM762pTDv/vkEYBkEdZGNQSTw0OionnJletchY1TZOnYNxBLPVvucv/1nSzm
 hdPyj+W43gBppLBLHzgYS6IpKIi6HoLRdyN70JrsBYOpo1TtWCmoAiCrlQuGxdJAdNzsbQwiD
 51ZtSn/IeZfnz30a477eCLWFdKpNXwiNlhuakfZHkB5WEcbS1IW/4hv62cU1dfBTiOOn81tXb
 jZhEQ4OQvy7eBzvocIV6YbJGbwhJ/oMjpXxT1vipgYSm3urqXxX2gT4JJOucKDUPkBIcAsziF
 FCnJnvAj+23Mw2jxkf8b+VgTG6gWJJcGqb565YysI4FD66yYudCkmxzB6vTYzghMcZjoXrZcE
 TCNdBGGhurmbleau80CR8xGzZ8G96Osl9/RE0SFP0JuHLWvazGNaIYPntzmA9n8GbfaXM30Kg
 ex+HuPh8HByJDoKKxq0DjaTw1N/9rYPiUK0yWSPZ6T+IjeF2UBZ8w5ifvqJIEuecJs3F2GRmS
 XATab1Z3eNwl0GcwKnFqiE9/lRE0n9FdRQITEB/tFMOFOcYF2tgBOTcF4HG7z54Gun6tEpvbm
 hXAbv9TBHixcVHT4lZ7N2/aRvZPikCi8He4jbNNWMCCQGBiE86EM8mpT1c4tsdud04jk/bG3m
 6iLDUFn2IEomRARbAy4fLRElXqxDDRNa1ubXJzu90CLXRVqlfoX6n2GQK89cKjTTWGJRBfLrK
 ap3jUbQRmtsQbZiLbUpHocIDu5tUGooZ4cEfSN3FIZee83MnQQd/TzDUM9xAiC2ot+4sQsoti
 3X+m79vhJNcm8/p9zHodZ3+qDzeKZ6LVkb+82K6BLGtYA1pwsWVnjnRHtgwCv3urzTJsPAMMk
 WjP668tydbxR+DSVwo1FkYeajcWARm3KimfuM9Nbk6D5G44EJt+JsR5yWcSZETx3fPdQTIaIO
 M1Vx86fMjGuB7OAH1977n3HuMJHb/KDBtbDVaZJHDpyWFnEPa1dWgSXeoC8mLI1oaP9sLBulf
 mp21EZiGgO9xNhbZTgO6pcEHDH5hGEMTOJ/EwDn9iuHcvjJSkNbBwKfW/+vb7WSMG5DbOI55n
 xBRw4tNLEZ99fe8oF+0hF5fVF9itZmYE/zvX8vw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/28 =E4=B8=8A=E5=8D=881:17, Hans van Kranenburg wrote:
> Hi!
>
> On 7/27/20 1:09 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/7/25 =E4=B8=8B=E5=8D=8810:24, Hans van Kranenburg wrote:
>>> Hi,
>>>
>>> I have a filesystem here that I'm filling up with data from elsewhere.
>>> Most of it is done by rsync, and part by send/receive. So, receiving
>>> data over the network, and then writing the files to disk. There can b=
e
>>> a dozen of these processes running in parallel.
>>>
>>> Now, when doing so, the kworker/u16:X+flush-btrfs-2 process (with
>>> varying X) often is using nearly 100% cpu, while enormously slowing do=
wn
>>> disk writes. This shows as disk IO wait for the rsync and btrfs receiv=
e
>>> processes.
>>
>> The name is in fact pretty strange.
>> It doesn't follow the btrfs workqueue names.
>>
>> There are two type of kernel threads used by btrfs:
>>   [...]
>>
>> As you can see, there is no one named like "flush-btrfs".
>
> Well, I do have a kernel thread named kworker/u16:7-flush-btrfs-2 here,
> currently. ;]
>
>> Thus I guess it's from other part of the stack.
>>
>> Also, the calltrace also shows that, that kernel thread is only doing
>> page writeback, which calls back to the page write hooks of btrfs.
>>
>> So I guess it may not be btrfs, but something else trying to do all the
>> writeback.
>
> Yes, so, from the writeback path it re-enters btrfs code, right?

Yep. Btrfs is still responsible for the problem.

>
>> But still, the CPU usage is still a problem, it shouldn't cost so much
>> CPU time just writing back pages from btrfs.
>
> It's find_free_extent which is the culprit.
>
>>> [...]
>>>
>>> It's clearly kworker/u16:X+flush-btrfs-2 which is the bottleneck here.
>>>
>>> I just did a 'perf record -g -a sleep 60' while disk writes were down =
to
>>> under 1MiB (!) per second and then 'perf report'. Attached some 'scree=
n
>>> shot' of it. Also attached an example of what nmon shows to give an id=
ea
>>> about the situation.
>>>
>>> If the kworker/u16:X+flush-btrfs-2 cpu usage decreases, I immediately
>>> see network and disk write speed ramping up, easily over 200 MiB/s,
>>> until it soon plummets again.
>>>
>>> I see the same behavior with a recent 4.19 kernel and with 5.7.6 (whic=
h
>>> is booted now).
>>>
>>> So, what I'm looking for is:
>>> * Does anyone else see this happen when doing a lot of concurrent writ=
es?
>>> * What does this flush thing do?
>>> * Why is it using 100% cpu all the time?
>>> * How can I debug this more?
>>
>> bcc based runtime probes I guess?
>>
>> Since it's almost a dead CPU burner loop, regular sleep based lockup
>> detector won't help much.
>
> Here's a flame graph of 180 seconds, taken from the kernel thread pid:
>
> https://syrinx.knorrie.org/~knorrie/btrfs/keep/2020-07-27-perf-kworker-f=
lush-btrfs.svg

That's really awesome!

>
>> You can try trace events first to see which trace event get executed th=
e
>> most frequently, then try to add probe points to pin down the real caus=
e.
>
> From the default collection, I already got the following, a few days
> ago, by enabling find_free_extent and btrfs_cow_block:
>
> https://syrinx.knorrie.org/~knorrie/btrfs/keep/2020-07-25-find_free_exte=
nt.txt
>
> From the timestamps you can see how long this takes. It's not much that
> gets done per second.
>
> The spin lock part must be spin_lock(&space_info->lock) because that's
> the only one in find_free_extent.
>
> So, what I think is that, like I mentioned on saturday already,
> find_free_extent is probably doing things in a really inefficient way,
> scanning around for a small single free space gap all the time in a
> really expensive way, and doing that over again for each tiny metadata
> block or file that needs to be placed somewhere (also notice the
> empty_size=3D0), instead of just throwing all of it on disk after each
> other, when it's otherwise slowing down everyone.

I think you're mostly right, find_free_extent() is not that efficient.

But that only happens when there are a lot of parallel requests for it.

One example is btrfs_get_block_group().
That function is only calling one function, refcount_inc(), which
normally shouldn't be that slow, unless there are tons of other callers
here.

>
> And then we have the spin lock part and btrfs_get_block_group, which are
> also a significant part of the time spent. All together is the
> continuous 100% cpu.

So is the spinlock part. That spinlock itself should be pretty fast
(that's why we use spinlock), but when it's not, it's mostly caused by
high concurrency.

>
> What I *can* try is switch to the ssd_spread option, to force it to do
> much more yolo allocation, but I'm afraid this will result in a sudden
> blast of metadata block groups getting allocated. Or, maybe try it for a
> minute or so and compare the trace pipe output...

Another thing can't be explained is, that slow down you're experiencing
is from data write back.
It should never conflicts with metadata space reservation, as data and
metadata are separated by space_info first, thus they shouldn't affect
each other.
Either I'm missing something, or there are other problems.

>
>> But personally speaking, it's better to shrink the workload, to find a
>> minimal workload to reproduce the 100% CPU burn, so that you need less
>> probes/time to pindown the problem.
>
> I think I can reproduce it with a single btrfs receive operation, as
> long as it has a large amount of small files in it.

IMHO, if the culprit is really find_free_extent() itself, then single
receive won't reach the concurrency we need to expose the slowdown.

Since receive is just doing serial writes, that shouldn't cause enough
race for find_free_extents().

But that's worthy trying to see if it proofs my assumption of concurrency.

Thanks,
Qu

>
> Currently I'm almost only copying data onto the filesystem, only data
> removals are some targeted dedupe script for known big files that are
> identical, but which could not easily be handled by rsync.
>
> So, when find_free_extent wants to write extent tree blocks, it might be
> playing outside in the woods all the time, searching around for little
> holes that were caused by previous cow operations.
>
> Large files are not a problem, like postgresql database dumps. Copying
> them over just runs >200-300M/s without problem, where the read speed of
> the old storage I'm moving things off is the bottleneck, actually.
>
>>> * Ultimately, of course... how can we improve this?
>>>
>>> [...]
>
> I will see if I can experiment a bit with putting more trace points in.
>
> I remember reading around in the extent allocator code, until I got
> dizzy from it. Deja vu...
>
> https://www.spinics.net/lists/linux-btrfs/msg70624.html
>
> Thanks
> Hans
>
