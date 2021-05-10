Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBCD378F4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhEJNlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 09:41:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:58251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351561AbhEJNLc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 09:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620652221;
        bh=ek9dOklXAVhiUNCc5tblaWDG9yuRkjDTbOwHjd+UyyY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QaxYKJ1ld6k1druT6s7ONy/8ru18Q9aq6RXwdKi0EFccGe006iET8rUZL9YeAQhgG
         RrjbvgCcOTrhNH5P0YTGzYm79moX0kplsQbQM6IAnyUiFlTFXBhadOUWFERq9izowA
         E7Dg2FvEwzMeB4zQkuBhlFUTxjbyh4qdPo4g5zCM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mnpns-1l9jqo16Ve-00pJRG; Mon, 10
 May 2021 15:10:21 +0200
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-42-wqu@suse.com>
 <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
 <20210507045735.jjtc76whburjmnvt@riteshh-domain>
 <5d406b40-23d9-8542-792a-2cd6a7d95afe@gmx.com>
 <e7e6ebdd-a220-e4ec-64e4-d031d7a9b181@gmx.com>
 <20210510122933.mcg2sac2ugdennbs@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <95d7bc8a-5593-cc71-aee3-349dd6fd060d@gmx.com>
Date:   Mon, 10 May 2021 21:10:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210510122933.mcg2sac2ugdennbs@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MqMVn2Fskl3SWhCgqBTV08r3PtJJ1v2Hn067mxC21YP2VBpImsH
 6h1PthdzO8PzARMkrcxuBFEi/P/+SRd59XqD0pD1VcbdhGpgZg6TwxLUH/dLInoAm1acj+c
 zRBZA6qaHmAsRkFv2fIKAr3y6Am0CKFvh7yQ8LRgoBBddxWVU2aMl/W06nlDsV33T/dDjAT
 4x3vEIsEeB9LHh6fK2GYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XLiKslcRlIM=:qyM6tXspglNFAYvIFbz5Ng
 MzvpAjwGtPvTTpS+CQW9VEZQFVQP45ZQ8FE3FoHbqLH90tkRPA7zANVb9EQCj0MRQ4DlLhCAn
 KiCaLVllyIDMh3hVaHRMYUdgKi8+3OU4NdOK+4e4Ne+uMrat2YYkAhBWFOrq0uhKJUj7ruLmn
 nXpRxB6/mcAtoiKfVIL6EiS6cGUlWljFPkmLuZblVk6MzZBaEbt91bqC0/Itz7onVPK8Oz3OE
 aHcYavUs5Q6zZIgdWz9ub/RW/DAayg3jj7J4FKOz4HFihzxDUdTu+I+ojcuJwnxJXFULv6HoX
 8/tbcSVkW0NjvfCme0VLVwi7AIAXnwy5mRJpaO3nBwt+X4EwxkyyUyjsJeh1umEVlZnBBr5qo
 WG66F0TufLkTw6UbFGy9wv0BTczhyI7R4JVimXwgOEKOGDKLFT71hcNbw+5sMhFuMt0JqBqLz
 Lrr93+naxZhX0jx7GMdzaP78Myb7t98zKJCirDOauPk0vttS+AV9gK/x+QFewtyfztqd7mAe2
 N95iY5n/zwz9xFp3IL4hZ9yd908SevvtvBOrdhBUbqpP9OuPj5wqfvgCmiDMQQGHhrWgfwIU3
 5KEGTKNv/vuVEeZv3hQE0ntlO5yq7aSbnj5RO8As9GYDkGtLCk07R+MZJIq3Q3BUKqDJ/9bnR
 zfveWgNBPopJN9SPfjPeRaecLVfyCUX0aiccH4NWpHcoBtMUPDIa5t6zO2Ato/+NQIV5NeHMz
 ZIGP0810fErKXo1Sqkw4xIDW1GtudupW5w0kIvN2fKkMWG883AraYMXBvYB8ksO5a9n/TxZuq
 HDAQmmmzhqgMn00yEkhhE6FtJQGxakIICUDFEmQI1z2Y/xvaR/xkRAlJyMblV3kQFVjWp9gpR
 EK+jHqySazrVFAQ7DN0ehELa1E49QH6Vz39KS7X6m/V7cc4EeqbdzqasVBsjS2k0wOwk4P0E8
 3GJFruojbdUjjEgsWVdu/R+L+HTdiznS83opYeurNR4xACPxltli1NBxNJxMFFx9UvBk3Nu+E
 OTEm0NFOfUFID+HT5UgrfxTILlI6Xbi6qT+ReYVPXXeDEfWC8MPbt/ZtX0UmpkgoDqICbePpM
 if21eof8ixNKg9p8SswPCt4NaS5/1Q8Pa9b3qR7qrOxVY8IWB0kVpmI82dbHA/kfYbteF+5Af
 DD6cD/JWaobsegu+RfLuB5rjuXiH16K6L4LMvSz/OWdobOLgp8o88QxkksBFQ55VlzWDMLcKC
 NyVieFueA1iAFwHgY
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/10 =E4=B8=8B=E5=8D=888:29, Ritesh Harjani wrote:
> On 21/05/10 04:38PM, Qu Wenruo wrote:
>> Hi Ritesh,
>>
>> I guess no error report so far is a good thing?
> Sorry about the delay in starting of my testing. Was not keeping well si=
nce
> Friday onwards, hence could not start the testing. (Feeling much better =
now).
>
> So -g quick passed w/o any fatal issues. But with -g auto I got a kernel=
 bug
> with btrfs/28. Below is the report.
>
>>
>> Just to report what my result is, I ran my latest github branch for the
>> full weekend, over 50 hours, and around 20 runs of full generic/auto
>> without defrag groups.
>>
>> And I see no crash at all.
>>
>> But there is a special note, there is a new patch, introduced just
>> before the weekend (Fri May 7 09:31:43 2021 +0800), titled "btrfs: fix =
a
>> possible use-after-free race in metadata read path", is a new fix for a
>> bug I reproduced once locally.
>
> Yes,  I already have this in my tree. This is the latest patch in my tre=
e which
> I am testing.
> "btrfs: remove io_failure_record::in_validation"
>
>>
>> The bug should only happen when read is slow and only happens for
>> metadata read path.
>>
>> The details can be found in the commit message, although it's rare to
>> hit, I have hit such problem around 3 times in total.
>>
>> Hopes you didn't hit any crash during your test.
>
> I am hitting below bug_on(). Since I saw your email just now, so I am di=
rectly
> reporting this failure, w/o analyzing. Please let me know if you need an=
ything
> else from my end for this.
>
> I will halt the testing of "-g auto" for now. Once we have some conclusi=
on on
> this one, then will resume the testing.

Thanks for the reporting, I was still just looping generic tests, thus
didn't yet start testing the btrfs tests.

But considering no new crash in generic tests, I guess it's time to move
forward.

>
> btrfs/028 32s ... 	[10:41:18][  780.104573] run fstests btrfs/028 at 202=
1-05-10 10:41:18
>
> [  780.732073] BTRFS: device fsid be9b827d-28ee-4a5e-80a0-e19971061a58 d=
evid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (21129)
> [  780.759754] BTRFS info (device vdc): disk space caching is enabled
> [  780.759848] BTRFS info (device vdc): has skinny extents
> [  780.759888] BTRFS warning (device vdc): read-write for sector size 40=
96 with page size 65536 is experimental
> <...>
> [  784.580404] BTRFS info (device vdc): found 21 extents, stage: move da=
ta extents
> [  784.878376] BTRFS info (device vdc): found 13 extents, stage: update =
data pointers
> [  785.175349] BTRFS info (device vdc): balance: ended with status: 0
> [  785.367729] BTRFS info (device vdc): balance: start -d
> [  785.400884] BTRFS info (device vdc): relocating block group 244632780=
8 flags data
> [  785.527858] btrfs_print_data_csum_error: 18 callbacks suppressed
> [  785.527865] BTRFS warning (device vdc): csum failed root -9 ino 262 o=
ff 393216 csum 0x8941f998 expected csum 0x9439dda4 mirror 1

Checking the test case btrfs/028, it shouldn't have any error when
relocating the block groups, thus it's definitely something wrong in the
balance code.

Thanks for the report, I'll give you an update after finishing the local
btrfs test groups.

Thanks for your confirmation, really helps a lot!
Qu

> [  785.528406] btrfs_dev_stat_print_on_error: 18 callbacks suppressed
> [  785.528409] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0,=
 flush 0, corrupt 1, gen 0
> [  785.528857] BTRFS warning (device vdc): csum failed root -9 ino 262 o=
ff 397312 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
> [  785.529166] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0,=
 flush 0, corrupt 2, gen 0
> [  785.529412] BTRFS warning (device vdc): csum failed root -9 ino 262 o=
ff 401408 csum 0x8941f998 expected csum 0x667b7e1e mirror 1
> [  785.529714] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0,=
 flush 0, corrupt 3, gen 0
> [  785.530321] BTRFS warning (device vdc): csum failed root -9 ino 262 o=
ff 393216 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
> [  785.530637] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0,=
 flush 0, corrupt 4, gen 0
> [  785.530882] BTRFS warning (device vdc): csum failed root -9 ino 262 o=
ff 397312 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
> [  785.531185] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0,=
 flush 0, corrupt 5, gen 0
> [  785.531428] BTRFS warning (device vdc): csum failed root -9 ino 262 o=
ff 401408 csum 0x8941f998 expected csum 0x667b7e1e mirror 1
> [  785.531719] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0,=
 flush 0, corrupt 6, gen 0
> <...>
> [  803.459877] BTRFS info (device vdc): relocating block group 104993914=
88 flags data
> [  803.776810] BTRFS info (device vdc): found 29 extents, stage: move da=
ta extents
> [  803.979572] BTRFS info (device vdc): found 18 extents, stage: update =
data pointers
> [  804.276370] BTRFS info (device vdc): balance: ended with status: 0
> [  804.427621] BTRFS info (device vdc): balance: start -d
> [  804.454527] BTRFS info (device vdc): relocating block group 110362624=
00 flags data
> [  804.623962] BTRFS warning (device vdc): csum failed root -9 ino 282 o=
ff 684032 csum 0x8941f998 expected csum 0x605aaa22 mirror 1
> [  804.624147] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0,=
 flush 0, corrupt 15, gen 0
> [  804.624277] BTRFS warning (device vdc): csum failed root -9 ino 282 o=
ff 688128 csum 0x8941f998 expected csum 0xe90a7889 mirror 1
> [  804.624435] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0,=
 flush 0, corrupt 16, gen 0
> [  804.624682] assertion failed: atomic_read(&subpage->readers) >=3D nbi=
ts, in fs/btrfs/subpage.c:203
> [  804.624902] ------------[ cut here ]------------
> [  804.624989] kernel BUG at fs/btrfs/ctree.h:3415!
> cpu 0x1: Vector: 700 (Program Check) at [c000000007b47640]
>      pc: c000000000af297c: assertfail.constprop.11+0x34/0x38
>      lr: c000000000af2978: assertfail.constprop.11+0x30/0x38
>      sp: c000000007b478e0
>     msr: 800000000282b033
>    current =3D 0xc000000007999800
>    paca    =3D 0xc00000003fffee00	 irqmask: 0x03	 irq_happened: 0x01
>      pid   =3D 23, comm =3D kworker/u4:1
> kernel BUG at fs/btrfs/ctree.h:3415!
> Linux version 5.12.0-rc8-00160-gcd0da6627caa (root@ltctulc6a-p1) (gcc (U=
buntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.30) =
#25 SMP Mon May 10 01:31:44 CDT 2021
> enter ? for help
> [c000000007b47940] c000000000aefdac btrfs_subpage_end_reader+0x5c/0xb0
> [c000000007b47980] c000000000a379f0 end_page_read+0x1d0/0x200
> [c000000007b479c0] c000000000a41554 end_bio_extent_readpage+0x784/0x9b0
> [c000000007b47b30] c000000000b4a234 bio_endio+0x254/0x270
> [c000000007b47b70] c0000000009f6178 end_workqueue_fn+0x48/0x80
> [c000000007b47ba0] c000000000a5c960 btrfs_work_helper+0x260/0x8e0
> [c000000007b47c40] c00000000020a7f4 process_one_work+0x434/0x7d0
> [c000000007b47d10] c00000000020ae94 worker_thread+0x304/0x570
> [c000000007b47da0] c0000000002173cc kthread+0x1bc/0x1d0
> [c000000007b47e10] c00000000000d6ec ret_from_kernel_thread+0x5c/0x70
>
> -ritesh
>
