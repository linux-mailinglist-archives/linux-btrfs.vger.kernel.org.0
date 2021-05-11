Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC137A58B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 13:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhEKLQ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 07:16:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:50107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231359AbhEKLQ2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 07:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620731717;
        bh=BhCnlfdxupmFH+4CDRSjzqHXxKYl2jVzDte3kqBiT4Y=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=SF+T2G/tSevtmBG6QuOmXZdOKInXENQ/G66u/1HJzAQhMDp0ATuVZspDhooLSiM7q
         GHw1SdHsNiP3xqQbZ3+M0sxq1nYbhVsSu3+c2cIx/ztPucR/FuoBYTWWHgc30zDXRL
         WX++d7ENBrLm2OE/Jfo1lUnJm4ahB/M/91MwT9iw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpOT-1l144D33yT-00gIx1; Tue, 11
 May 2021 13:15:17 +0200
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-42-wqu@suse.com>
 <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
 <20210507045735.jjtc76whburjmnvt@riteshh-domain>
 <5d406b40-23d9-8542-792a-2cd6a7d95afe@gmx.com>
 <e7e6ebdd-a220-e4ec-64e4-d031d7a9b181@gmx.com>
 <20210510122933.mcg2sac2ugdennbs@riteshh-domain>
 <95d7bc8a-5593-cc71-aee3-349dd6fd060d@gmx.com>
 <20210511104809.evndsdckwhmonyyl@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <334a5fdd-28ee-4163-456c-adc4b2276d08@gmx.com>
Date:   Tue, 11 May 2021 19:15:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511104809.evndsdckwhmonyyl@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+y0ZSY9+rsxyImM3lsz7a8ybXfn0Qtw3Db0ACs4MAAGPCFpvcJg
 9WlvxKm2XZIXgEeHAs6YR/vIQjjLiJie+yAyZdI/mjaQ+pWPqlUuWZleD0BQmZlbsvzSh4H
 TM18PwKXTvQjdehCrCbpsbXoV7ebL2z2LWaztQTyWF8m/Uq7neneyK4Rf07Hi0TUnHA32Sh
 qMI6vwS6vvvpJcoV8OHtQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sj7o54Q7JRk=:d0pFNM1OFLu9gc2WLeE0uc
 FwhPFhJWEI0TAjC5ERUou5QrN2GUmNkuOItpq6O8e9DemClDzeA4CtTFuk/+ExE8WiJXnB/Tn
 MtwUw4bEgeDffYVIxFsQgcWzL4JtjDd40HLx8uNVJY+cICOTa8FrLxoYDxt7zJlpggEL1Bv1I
 BWewRcYy08cSZgja8pLKxn9wBVM57PdlArSUikCPa9OXMCnXzg7uXKG6WaYeRJ9o9vohq/O0h
 6CNBk3O6Grlx29ucEbrchqUjTP1V0GDcGGXVm9az/P4AhZfWbBp4OLAi8EoNoUHeEqYo8TiHI
 yQ19XuU06fNxQdcMwb7kuMXmXVxdD6h4awAR8zqXEthQol3/HJZpIpieigoEdcGaCcJxj0ROz
 lnmwTVFq+e/B/Wws0jbbaHR4tfCvkX5TmKYTq5SHLHA3kiH5mb9rLCrYSeRf5nmB80pH/qGFO
 FdHHUIdsq/4enM8c593NnWd83ki1QgKRAWHOJy7FsYDsaShYAE87lZGz6SW8rx10kbDJlf2Ud
 etYMuT0ZUVepWgt00Y75XPAhWPqJb+p7Hb9PKWbmlQdpvI4gklU/+7espKQpweaNSpzgFQraX
 ljsX0IMhSUraXh9jQOLRMDZLuIfH23mEfVJvukr6q6mcLXEogRUPWm7J7wrjfbigsSrSsy93p
 LpM0WIn+daGS+uA6H4xQyuWJz8ArOZ3k+/GpmYNMvMg9GOp8bimnfO6aU3htagHQp1PgTHiiW
 9S/DuM5dXU9NyNoAX8zVOr0osoyUF1iW+3XySGSqKwuHHV7XuFySHsQ5m67Pq9ujQTvuge5UW
 FEjOFHP+6pPEAyPbZmdhkjXz0c1s4y3789UqUSNHwNLPWaT/3RIJw+HJg+KaN46B7hMtHECqU
 gvPQPIit1M5efEJ6VYvWCWfVk+eRkxtYWSIyKg2Jvxjo1ILn/GC/vl6ZeSqntz+rZa3WpEpra
 6Co7IphBszMO7T+CPIlzq1asxrU8CRwwGV8Qo99kzwTCffLcboJwEE2316FZ79dFgZIHRKg8I
 r6n8Dg79hEEhv8SBTiWD2/OiWWF5COKOU09XtK2bCxxmB76+WrLiO612YKRtHjeZyqI1ZPRNG
 sWTmHfSN3g14T7CJ2dbkPbLBzQlVeS1N7U+gvTTELVbVq2ur1cvNVifSi+ukV8FnbAPIUqptn
 SzGKgduKoXbaRLP/7arkQQTQtCzjAUOqPNeWq0mrChoxTzeVjt4hzGyo6WOYpa4BzqugsGuK9
 EAX4B/wPkqcwNZBor
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/11 =E4=B8=8B=E5=8D=886:48, Ritesh Harjani wrote:
> On 21/05/10 09:10PM, Qu Wenruo wrote:
>>
>>
>> On 2021/5/10 =E4=B8=8B=E5=8D=888:29, Ritesh Harjani wrote:
>>> On 21/05/10 04:38PM, Qu Wenruo wrote:
>>>> Hi Ritesh,
>>>>
>>>> I guess no error report so far is a good thing?
>>> Sorry about the delay in starting of my testing. Was not keeping well =
since
>>> Friday onwards, hence could not start the testing. (Feeling much bette=
r now).
>>>
>>> So -g quick passed w/o any fatal issues. But with -g auto I got a kern=
el bug
>>> with btrfs/28. Below is the report.
>>>
>>>>
>>>> Just to report what my result is, I ran my latest github branch for t=
he
>>>> full weekend, over 50 hours, and around 20 runs of full generic/auto
>>>> without defrag groups.
>>>>
>>>> And I see no crash at all.
>>>>
>>>> But there is a special note, there is a new patch, introduced just
>>>> before the weekend (Fri May 7 09:31:43 2021 +0800), titled "btrfs: fi=
x a
>>>> possible use-after-free race in metadata read path", is a new fix for=
 a
>>>> bug I reproduced once locally.
>>>
>>> Yes,  I already have this in my tree. This is the latest patch in my t=
ree which
>>> I am testing.
>>> "btrfs: remove io_failure_record::in_validation"
>>>
>>>>
>>>> The bug should only happen when read is slow and only happens for
>>>> metadata read path.
>>>>
>>>> The details can be found in the commit message, although it's rare to
>>>> hit, I have hit such problem around 3 times in total.
>>>>
>>>> Hopes you didn't hit any crash during your test.
>>>
>>> I am hitting below bug_on(). Since I saw your email just now, so I am =
directly
>>> reporting this failure, w/o analyzing. Please let me know if you need =
anything
>>> else from my end for this.
>>>
>>> I will halt the testing of "-g auto" for now. Once we have some conclu=
sion on
>>> this one, then will resume the testing.
>>
>> Thanks for the reporting, I was still just looping generic tests, thus
>> didn't yet start testing the btrfs tests.
>>
>> But considering no new crash in generic tests, I guess it's time to mov=
e
>> forward.
>>
>>>
>>> btrfs/028 32s ... 	[10:41:18][  780.104573] run fstests btrfs/028 at 2=
021-05-10 10:41:18
>>>
>>> [  780.732073] BTRFS: device fsid be9b827d-28ee-4a5e-80a0-e19971061a58=
 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (21129)
>>> [  780.759754] BTRFS info (device vdc): disk space caching is enabled
>>> [  780.759848] BTRFS info (device vdc): has skinny extents
>>> [  780.759888] BTRFS warning (device vdc): read-write for sector size =
4096 with page size 65536 is experimental
>>> <...>
>>> [  784.580404] BTRFS info (device vdc): found 21 extents, stage: move =
data extents
>>> [  784.878376] BTRFS info (device vdc): found 13 extents, stage: updat=
e data pointers
>>> [  785.175349] BTRFS info (device vdc): balance: ended with status: 0
>>> [  785.367729] BTRFS info (device vdc): balance: start -d
>>> [  785.400884] BTRFS info (device vdc): relocating block group 2446327=
808 flags data
>>> [  785.527858] btrfs_print_data_csum_error: 18 callbacks suppressed
>>> [  785.527865] BTRFS warning (device vdc): csum failed root -9 ino 262=
 off 393216 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
>>
>> Checking the test case btrfs/028, it shouldn't have any error when
>> relocating the block groups, thus it's definitely something wrong in th=
e
>> balance code.
>>
>> Thanks for the report, I'll give you an update after finishing the loca=
l
>> btrfs test groups.
>>
>> Thanks for your confirmation, really helps a lot!
>
> Hi Qu,
>
> FYI - I re-tested "-g auto" with btrfs/028 test excluded. I didn't find =
any
> other failure.

That's too kind of you.

It's not a surprise for it too pass generic tests, but since I haven't
yet run full btrfs test group, it passing other btrfs tests is really a
good news.

> Please let me know once you have a fix for btrfs/028, I can
> re-test the whole tree again.

Fix on the way, in fact btrfs/028 already shows several bugs I didn't
expect at all, some spoilers:

- The crash in btrfs_subpage_end_reader()
   It turns out to be a bug in the read time refactor patches. ("btrfs:
   submit read time repair only for each corrupted sector")
   Fixed in the original patch.

- Possible hang for certain data repair failure
   The same cause as above bug.
   Fixed in the original patch.

- False alert for data reloc, with expected csum 0x00
   A bug in btrfs_verify_data_csum() which from the very beginning it
   doesn't take subpage into consideration.
   Fixed in a new patch.

- False alert for data reloc, with random expected csum
   Still debugging, hopes to be the last bug in the series.

Will give another update when the last bug get solved.

Thanks,
Qu
>
> Thanks
> ritesh
>
>
>> Qu
>>
>>> [  785.528406] btrfs_dev_stat_print_on_error: 18 callbacks suppressed
>>> [  785.528409] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd =
0, flush 0, corrupt 1, gen 0
>>> [  785.528857] BTRFS warning (device vdc): csum failed root -9 ino 262=
 off 397312 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
>>> [  785.529166] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd =
0, flush 0, corrupt 2, gen 0
>>> [  785.529412] BTRFS warning (device vdc): csum failed root -9 ino 262=
 off 401408 csum 0x8941f998 expected csum 0x667b7e1e mirror 1
>>> [  785.529714] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd =
0, flush 0, corrupt 3, gen 0
>>> [  785.530321] BTRFS warning (device vdc): csum failed root -9 ino 262=
 off 393216 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
>>> [  785.530637] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd =
0, flush 0, corrupt 4, gen 0
>>> [  785.530882] BTRFS warning (device vdc): csum failed root -9 ino 262=
 off 397312 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
>>> [  785.531185] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd =
0, flush 0, corrupt 5, gen 0
>>> [  785.531428] BTRFS warning (device vdc): csum failed root -9 ino 262=
 off 401408 csum 0x8941f998 expected csum 0x667b7e1e mirror 1
>>> [  785.531719] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd =
0, flush 0, corrupt 6, gen 0
>>> <...>
>>> [  803.459877] BTRFS info (device vdc): relocating block group 1049939=
1488 flags data
>>> [  803.776810] BTRFS info (device vdc): found 29 extents, stage: move =
data extents
>>> [  803.979572] BTRFS info (device vdc): found 18 extents, stage: updat=
e data pointers
>>> [  804.276370] BTRFS info (device vdc): balance: ended with status: 0
>>> [  804.427621] BTRFS info (device vdc): balance: start -d
>>> [  804.454527] BTRFS info (device vdc): relocating block group 1103626=
2400 flags data
>>> [  804.623962] BTRFS warning (device vdc): csum failed root -9 ino 282=
 off 684032 csum 0x8941f998 expected csum 0x605aaa22 mirror 1
>>> [  804.624147] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd =
0, flush 0, corrupt 15, gen 0
>>> [  804.624277] BTRFS warning (device vdc): csum failed root -9 ino 282=
 off 688128 csum 0x8941f998 expected csum 0xe90a7889 mirror 1
>>> [  804.624435] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd =
0, flush 0, corrupt 16, gen 0
>>> [  804.624682] assertion failed: atomic_read(&subpage->readers) >=3D n=
bits, in fs/btrfs/subpage.c:203
>>> [  804.624902] ------------[ cut here ]------------
>>> [  804.624989] kernel BUG at fs/btrfs/ctree.h:3415!
>>> cpu 0x1: Vector: 700 (Program Check) at [c000000007b47640]
>>>       pc: c000000000af297c: assertfail.constprop.11+0x34/0x38
>>>       lr: c000000000af2978: assertfail.constprop.11+0x30/0x38
>>>       sp: c000000007b478e0
>>>      msr: 800000000282b033
>>>     current =3D 0xc000000007999800
>>>     paca    =3D 0xc00000003fffee00	 irqmask: 0x03	 irq_happened: 0x01
>>>       pid   =3D 23, comm =3D kworker/u4:1
>>> kernel BUG at fs/btrfs/ctree.h:3415!
>>> Linux version 5.12.0-rc8-00160-gcd0da6627caa (root@ltctulc6a-p1) (gcc =
(Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.30=
) #25 SMP Mon May 10 01:31:44 CDT 2021
>>> enter ? for help
>>> [c000000007b47940] c000000000aefdac btrfs_subpage_end_reader+0x5c/0xb0
>>> [c000000007b47980] c000000000a379f0 end_page_read+0x1d0/0x200
>>> [c000000007b479c0] c000000000a41554 end_bio_extent_readpage+0x784/0x9b=
0
>>> [c000000007b47b30] c000000000b4a234 bio_endio+0x254/0x270
>>> [c000000007b47b70] c0000000009f6178 end_workqueue_fn+0x48/0x80
>>> [c000000007b47ba0] c000000000a5c960 btrfs_work_helper+0x260/0x8e0
>>> [c000000007b47c40] c00000000020a7f4 process_one_work+0x434/0x7d0
>>> [c000000007b47d10] c00000000020ae94 worker_thread+0x304/0x570
>>> [c000000007b47da0] c0000000002173cc kthread+0x1bc/0x1d0
>>> [c000000007b47e10] c00000000000d6ec ret_from_kernel_thread+0x5c/0x70
>>>
>>> -ritesh
>>>
