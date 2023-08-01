Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DA376C011
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 00:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjHAWGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 18:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjHAWGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 18:06:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400FA19BE
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690927595; x=1691532395; i=quwenruo.btrfs@gmx.com;
 bh=JUFOkL710uHaMTVWWaJdlKB5raO1+c1tqgZv050MPMc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=CbKBNs6O+9dAWVilrSSpqPS8ARmVACpDLLtBtcqK/X3LnNi9nibO1N1teuHgDDhundCPD+L
 XHaWdVC+lIXwg9cilx3a7PbipBHL3fy4twY0R2ONJbTT9uSijuN3G5GUS3f6HX9nuc7gHJCxE
 z0veBl1xCpUj+o9OE7S7isdYcCIbJpzQlvl0nVCqGFf4rWQgfY+Sr5Xxr4hlz754BJBtJx1ux
 5HICdMjoI44R5h7l0Pv/QAxdxM5QH69VYCDUGIwr1tfw71JwQKqaaXOE1+sqQET6MTK4LgTmq
 +BKRXU2emx4RsGQq3D+e7wnuFY4GTo8qGWv5BEyIjB7pV37PfCSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bSt-1pjCbx2bgp-010fAT; Wed, 02
 Aug 2023 00:06:35 +0200
Message-ID: <48dea2d4-42ba-50bc-d955-9aa4a8082c7e@gmx.com>
Date:   Wed, 2 Aug 2023 06:06:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] btrfs: scrub: improve the scrub performance
To:     Jani Partanen <jiipee@sotapeli.fi>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1690542141.git.wqu@suse.com>
 <2d45a042-0c01-1026-1ced-0d8fdd026891@sotapeli.fi>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <2d45a042-0c01-1026-1ced-0d8fdd026891@sotapeli.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BadwhRGC+mUvkkZEfEi90Uuq9abHN5wyhP2cDz+KRCQduYN/pOe
 uxFCpOUgtP++3PThrOIje1d/BunY080yHUYCcLksXBV/k3iMvMGsijO5PyptmORmKxEubRJ
 T1wiwNuUT5k5L2OgmUade5Wcol14lFcVSJLKYrw6BwPRHHSYbw8gRIeuD5ZDOQWQEfZu2/k
 yCBGb3V6nIa2WvfulApKw==
UI-OutboundReport: notjunk:1;M01:P0:uZnC2R2bUlo=;Od9JgrQR2wJj5y+EuHM7OYYh4q8
 CCOblm1S7+J/GkeU7lwu06PJizJE9rPlAo5TNgrEcwosVQWXmeBrt1k6y9ImUtyz4NHZz7EMT
 5Y4ZUefEYlT/qFKGyjf+G4Jfb+sIPeWoSBV4BTxeULl7W1D5ftVnfYJoOxC+BtwDz5oOXCTHK
 aQgi5hMPjJTgEzkkn0RyTEQwxMLSUvZCLK/eqs+9rbHFgOid6NgIJnPXRW4pzMaojcCK9xLrC
 CW/WXdOeZ8ynqZMbjzjYtSheRRQ1GVocAhFvRitItBq2ib4C0brAo3tTY/swo6A1vL+J2VHnz
 pBklzwiThKgSBtZYR1rjSaK43Qv8FXUir8geyipzftvKFLN11HaFXnh0EHUP+IMcum5Mi7gSc
 +2HQTzMXUrTo0bnFRnR1g7YLAVNQxat8vuM+acC33nCd/RYAh+QtUXMHAmCwP7+rWeV61wRcM
 1QVmxR9pF6szm1SIQTcmtI1J0or+Gzah/KbMJFiTcRmhWDMpsqpTNc5DUgFarbzD+k//FxWOw
 fjD0mMS32HzDDOvLojFDMZAybiCH1t5d2nrVvYHMZDqcwTb3AWhoA1RVjHpY3GmAEWMFrlf9x
 cLA9bTsMMqgfOVM+C/FqEd1KhwkpDQMThq5djiBQrKNWNb+tBC90XsX4zppofo8wxKrNT2xph
 mLMFi2LoI4/EvaXspTXgFPeGWuMbCMA82aNKkb2OUF1QGrMPTTBFfiAM0VH9d0Xf2dFJN0XjJ
 YyyWQ9ZjGHGRm37M41WQnhwNwzELz3c/ap3JQuappo656cfXhFS0+m15cXn/TjhEA235U00oZ
 LeZwsozy499yetprJIY+VKAC5K5CRf6fr3V7WQjWhmMvpP9lJHffhtipbXCI5n6DYyJzQKVs7
 7/hJnuE9JXkNHXediWAgAPlAqAeHvdgIXw2G8Y1rA2hEn5KV3cxsZD7W7B9vCDv25dpTbWR8y
 4j4N8O7oobKr3Us8EAazy378I+k=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/2 04:14, Jani Partanen wrote:
> Hello, I did some testing with 4 x 320GB HDD's. Meta raid1c4 and data
> raid 5.

RAID5 has other problems related to scrub performance unfortunately.

>
> Kernel=C2=A0 6.3.12
>
> btrfs scrub start -B /dev/sdb
>
> scrub done for 6691cb53-271b-4abd-b2ab-143c41027924
> Scrub started:=C2=A0=C2=A0=C2=A0 Tue Aug=C2=A0 1 04:00:39 2023
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fini=
shed
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2:37:35
> Total to scrub:=C2=A0=C2=A0 149.58GiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 16.20MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 no errors found
>
>
> Kernel 6.5.0-rc3
>
> btrfs scrub start -B /dev/sdb
>
> scrub done for 6691cb53-271b-4abd-b2ab-143c41027924
> Scrub started:=C2=A0=C2=A0=C2=A0 Tue Aug=C2=A0 1 08:41:12 2023
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fini=
shed
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:31:03
> Total to scrub:=C2=A0=C2=A0 299.16GiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 56.08MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 no errors found
>
>
> So much better speed but Total to scrub reporting seems strange.
>
> df -h /dev/sdb
> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Use% Moun=
ted on
> /dev/sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1,2T=C2=A0 599G=C2=A0=
 292G=C2=A0 68% /mnt
>
>
> Looks like old did like 1/4 of total data what seems like right because
> I have 4 drives.
>
> New did=C2=A0 about 1/2 of total data what seems wrong.

I checked the kernel part of the progress reporting, for single device
scrub for RAID56, if it's a data stripe it contributes to the scrubbed
bytes, but if it's a P/Q stripe it should not contribute to the value.

Thus 1/4 should be the correct value.

However there is another factor in btrfs-progs, which determines how to
report the numbers.

There is a fix for it already merged in v6.3.2, but it seems to have
other problems involved.

>
> And if I do scrub against mount point:
>
> btrfs scrub start -B /mnt/
> scrub done for 6691cb53-271b-4abd-b2ab-143c41027924
> Scrub started:=C2=A0=C2=A0=C2=A0 Tue Aug=C2=A0 1 11:03:56 2023
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fini=
shed
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10:02:44
> Total to scrub:=C2=A0=C2=A0 1.17TiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 33.89MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 no errors found
>
>
> Then performance goes down to toilet and now Total to scrub reporting is
> like 2/1
>
> btrfs version
> btrfs-progs v6.3.3
>
> Is it btrfs-progs issue with reporting?

Can you try with -BdR option?

It shows the raw numbers, which is the easiest way to determine if it's
a bug in btrfs-progs or kernel.

> What about raid 5 scrub
> performance, why it is so bad?

It's explained in this cover letter:
https://lore.kernel.org/linux-btrfs/cover.1688368617.git.wqu@suse.com/

In short, RAID56 full fs scrub is causing too many duplicated reads, and
the root cause is, the per-device scrub is never a good idea for RAID56.

That's why I'm trying to introduce the new scrub flag for that.

Thanks,
Qu

>
>
> About disks, they are old WD Blue drives what can do about 100MB/s
> read/write on average.
>
>
> On 28/07/2023 14.14, Qu Wenruo wrote:
>> [REPO]
>> https://github.com/adam900710/linux/tree/scrub_testing
>>
>> [CHANGELOG]
>> v1:
>> - Rebased to latest misc-next
>>
>> - Rework the read IO grouping patch
>> =C2=A0=C2=A0 David has found some crashes mostly related to scrub perfo=
rmance
>> =C2=A0=C2=A0 fixes, meanwhile the original grouping patch has one extra=
 flag,
>> =C2=A0=C2=A0 SCRUB_FLAG_READ_SUBMITTED, to avoid double submitting.
>>
>> =C2=A0=C2=A0 But this flag can be avoided as we can easily avoid double=
 submitting
>> =C2=A0=C2=A0 just by properly checking the sctx->nr_stripe variable.
>>
>> =C2=A0=C2=A0 This reworked grouping read IO patch should be safer compa=
red to the
>> =C2=A0=C2=A0 initial version, with better code structure.
>>
>> =C2=A0=C2=A0 Unfortunately, the final performance is worse than the ini=
tial version
>> =C2=A0=C2=A0 (2.2GiB/s vs 2.5GiB/s), but it should be less racy thus sa=
fer.
>>
>> - Re-order the patches
>> =C2=A0=C2=A0 The first 3 patches are the main fixes, and I put safer pa=
tches first,
>> =C2=A0=C2=A0 so even if David still found crash at certain patch, the r=
emaining can
>> =C2=A0=C2=A0 be dropped if needed.
>>
>> There is a huge scrub performance drop introduced by v6.4 kernel, that
>> the scrub performance is only around 1/3 for large data extents.
>>
>> There are several causes:
>>
>> - Missing blk plug
>> =C2=A0=C2=A0 This means read requests won't be merged by block layer, t=
his can
>> =C2=A0=C2=A0 hugely reduce the read performance.
>>
>> - Extra time spent on extent/csum tree search
>> =C2=A0=C2=A0 This including extra path allocation/freeing and tree sear=
chs.
>> =C2=A0=C2=A0 This is especially obvious for large data extents, as prev=
iously we
>> =C2=A0=C2=A0 only do one csum search per 512K, but now we do one csum s=
earch per
>> =C2=A0=C2=A0 64K, an 8 times increase in csum tree search.
>>
>> - Less concurrency
>> =C2=A0=C2=A0 Mostly due to the fact that we're doing submit-and-wait, t=
hus much
>> =C2=A0=C2=A0 lower queue depth, affecting things like NVME which benefi=
ts a lot
>> =C2=A0=C2=A0 from high concurrency.
>>
>> The first 3 patches would greately improve the scrub read performance,
>> but unfortunately it's still not as fast as the pre-6.4 kernels.
>> (2.2GiB/s vs 3.0GiB/s), but still much better than 6.4 kernels (2.2GiB
>> vs 1.0GiB/s).
>>
>> Qu Wenruo (5):
>> =C2=A0=C2=A0 btrfs: scrub: avoid unnecessary extent tree search prepari=
ng stripes
>> =C2=A0=C2=A0 btrfs: scrub: avoid unnecessary csum tree search preparing=
 stripes
>> =C2=A0=C2=A0 btrfs: scrub: fix grouping of read IO
>> =C2=A0=C2=A0 btrfs: scrub: don't go ordered workqueue for dev-replace
>> =C2=A0=C2=A0 btrfs: scrub: move write back of repaired sectors into
>> =C2=A0=C2=A0=C2=A0=C2=A0 scrub_stripe_read_repair_worker()
>>
>> =C2=A0 fs/btrfs/file-item.c |=C2=A0 33 +++---
>> =C2=A0 fs/btrfs/file-item.h |=C2=A0=C2=A0 6 +-
>> =C2=A0 fs/btrfs/raid56.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>> =C2=A0 fs/btrfs/scrub.c=C2=A0=C2=A0=C2=A0=C2=A0 | 234 +++++++++++++++++=
+++++++++-----------------
>> =C2=A0 4 files changed, 169 insertions(+), 108 deletions(-)
>>
