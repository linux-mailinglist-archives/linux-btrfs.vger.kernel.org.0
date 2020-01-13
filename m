Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C7D138A4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 05:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgAMEmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jan 2020 23:42:11 -0500
Received: from mout.gmx.net ([212.227.17.21]:47637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732970AbgAMEmK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jan 2020 23:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578890510;
        bh=3Gfr6+43MygpmPg76GPNTY4/53Ho68oYDcwW9rzya1o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CX1yfwqez4srOhA9cX5epV8U6SyBWuajkhLdHgBSMSYnZ1DlZcZx9SohsPPAyzLaV
         oPwl/qXymnxIiOntcD1nPX5NlUo3+/JbiG7aqsxUWQUOdIn9MTX0UQwQ1Nq5b1M66S
         2pfRwBI0kE3Ztj5rOAru+Gksr6ayQsALBBa5ktiA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1jV5j90G61-00o0n5; Mon, 13
 Jan 2020 05:41:50 +0100
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200108051200.8909-1-wqu@suse.com>
 <7482d2f3-f3a1-7dd9-6003-9042c1781207@toxicpanda.com>
 <2bfd87cf-2733-af0d-f33f-59e07c25d500@suse.com>
 <20200108150841.GH3929@twin.jikos.cz> <20200108151159.GI3929@twin.jikos.cz>
 <85422cb2-e140-563b-fadd-f820354ed156@gmx.com>
 <20200109143742.GN3929@twin.jikos.cz>
 <f8458b9c-0b6c-024e-399d-ea530abd1204@gmx.com>
 <d4322bd6-c2dd-e3e6-e8eb-2cda1963f9d7@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <8b1245b4-ecac-57c1-d1bf-28360f089f6d@gmx.com>
Date:   Mon, 13 Jan 2020 12:41:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <d4322bd6-c2dd-e3e6-e8eb-2cda1963f9d7@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R/clU+Vkx5v4IAXy/QWwPe1qQQqzMBk0vRz2Zdyme7fcbxmOkHw
 8/ZyKHBbyMC9pIQOfVk9dBCknefP129Ap+PICKeppxLNy5XaW2IC5yXHQGH5s7O7ZiHpF5E
 L+9donrODEQD7yetSgiOMQsmP8XWxhoaTsClFxldkvuq5OxHjmxmfjNonQlfBLx3l3tHFW2
 hyxF8AGT3HC9/089BeaQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:egtsE4ubdf0=:x1NeLu6/FEwXJ2J9sO1XDN
 fKZRuxEXxOD21rOgZg15IQcVD7WJ3LJ7ZGLCLFgnEid2fpvYT/A9XJncKukntFPaCPSWkebIZ
 qfm9z83FOLNV6A0sz5ycK++DfPyPWCZRHzb6SRdZma9XljCxEgiffkk+dbCFG2TFwMRc+GhS8
 o5KBW/VKj2SRf/Vy8jQqgimvQYPqh6MVwT7L6LloRDDXt2oI47ZKF0wzmKo2YovOYNzIm7KR4
 siO1v6d5SESIXE5iwYXPzUZJYN06a75SPWb3OM/q6awPFXZwD4LI66F3n4EKJT4xVLFTttUJL
 CG742ScmZYyQVt+YL7D82Ke2IQOsiQPHoQ8THnxIrrk+lYbO6SwaxMrgGnkhRS5I+O4hfZ4Xd
 zcQta+ZoCT8MdqfV4tWI7FIV6cR/9l7MuPhT3AiQF2cL36ccJXxRGFSQdWtRJKL7Zy48/3kzs
 yOMpS/UKaaejpbRDvAUkdJvj8Gozc+sAxiiKHcBsKjlB0OUAVYoSl4VFPcZT9WBqTqBvG2Yib
 yjk9gfNCoJWwYUdpIFxxH0vKXIJlYyUgxxCFg6R4c1yb/usNTwb4C621cLuTyDxBEczrEszhh
 RDyq/ibyYTSHDOg0gh03+JJul5Onb0N3gzydjeFgApARrhMRvY28r185MfcsAjDMng1Czfa7J
 WGZmGlBBybmayNnpnIT0iTihoDrm9gNONOABqNCbeD0NHwWe1rf+t34/T8Ci3RxzFCkxUfN0Z
 QSPsg3M5M8UpbMgOfaigCZc6lWXGK85xK6oJkQ5Z0QCcG75/NP6xsqi8KF84dmtAQLkCjtGx3
 YVdvH9vSlt1CESozAUAoCCHCEDc124TeuA5/iehUR6k3K2S0Oe28qE9ZMoCd1v5HxdmGdnqI5
 h8RB/BAxgzL1+Glbfx6RdaTa2L8CFB3I7CZtCxm4q6k1QSnRXilcUu5Z1LXUY+7sNfB+tRN06
 1jD5fuk4qoI8nsxappnrgWbRlqJ29EkJMTCfUBogCxD7Wleocf1TUT4edFrqDEWixrqxKZr+d
 XYcbXI3zwusFGSWrte4bu3GWOmMLcVlaJyi1Ktn2aiIdH4mhaLrNdsv6jjXrBwR6jP7pW0pKe
 /FoK4dhJR/zA/jAZG0TFqNv94FGthtVKXrtG8Q2sNWxPZ82GD+1gu3sUKn1ozBKr37cnVSiXJ
 PyuwX6nPjjXz4ntQA5ljUS0oOGy9Ndvuch14c0bpDfBmqAU2kcbMFovtEqlt0H9goVCe6l/wY
 amFgSWR+I3c2yjK2Zq9icG25f85ULbXia6DdaprhWdpzlyvTGcnlWyLN+z9c=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/1/10 =E4=B8=8A=E5=8D=888:58, Qu Wenruo wrote:
>
>
> On 2020/1/10 =E4=B8=8A=E5=8D=888:21, Qu Wenruo wrote:
>>
>>
>> On 2020/1/9 =E4=B8=8B=E5=8D=8810:37, David Sterba wrote:
>>> On Thu, Jan 09, 2020 at 01:54:34PM +0800, Qu Wenruo wrote:
>>>>>> The way I read it is more like smp_rmb/smp_wmb, but for bits in thi=
s
>>>>>> case, so the smp_mb__before/after_atomic was only a syntactic sugar=
 to
>>>>>> match that it's atomic bitops. I realize this could have caused som=
e
>>>>>> confusion, however I still think that some sort of barrier is neede=
d.
>>>>>
>>>>> There's an existing pattern used for serializing set/clear of
>>>>> BTRFS_ROOT_IN_TRANS_SETUP (record_root_in_trans,
>>>>> btrfs_record_root_in_trans).
>>>>>
>>>>> Once upon a time there were barriers like smp_mb__before_clear_bit b=
ut
>>>>> they got unified to just smp_mb__before_atomic for all set/clear
>>>>> operations, so I believe I was not all wrong with using them.
>>>>>
>>>> I used to believe the same fairy tail, that mb() works like a flush()=
,
>>>> but we're not living in a fairy tail.
>>>
>>> This sounds strange, by flush I was refering to internal CPU mechanism
>>> that makes all temporary changes visible to other cpus, so you're sayi=
ng
>>> that this does not work as everybody expects?
>>
>> Because no matter whether mb ensures that or not, the result is the sam=
e.
>>
>> What would happen if the reader get schedule just before the mb()
>> command? Reader can still get older value.
>> That makes no difference if we had mb() or not.
>>
>>>
>>>> What mb really does is keep certain ordering from happening.
>>>> And ordering means, we have at least *2* different memory accesses.
>>>
>>> Sorry but I think you're missing some pieces here. There are 2 memory
>>> accesses: set_bit/clear_bit (writer) and test_bit (reader).
>>>
>>> The same could be achieved by a plain variable, that it's a bit brings
>>> more confusion about what barrier should be really used.
>>>
>>> The pattern we want to use here is pretty standard. Read barrier befor=
e
>>> read and write barrier that separates the data change from the indicat=
or
>>> of the change. If you line up the barriers, there's a clear line betwe=
en
>>> the data changes and the indicator value.
>>
>> Again, test_bit() can happen whenever they like, and smp_rmb() before
>> test_bit() makes no sense.
>>
>> test_bit() can happen before reloc_root =3D NULL assign. after reloc_ro=
ot
>> =3D NULL assign but before set_bit(), or after set_bit().
>>
>> That smp_wmb() makes sure set_bit() won't happen before reloc_root, tha=
n
>> that's enough.
>> BTW, smp_mb__before_atomic() should be full mb, not just wmb or rmb.
>>
>>>
>>> reloc_root =3D NULL
>>> smp_wmb                           smp_rmb()
>>>                                   test_bit()
>>>                                   ... here
>>> set_bit(DEAD)
>>>                                   ... or here, it'll be always
>>> 				  reloc_root =3D=3D NULL, but it still could
>>> 				  be before or after set_bit
>>>
>>> You should also distinguish between mb() and smp_mb() (and the rmb/wmb=
).
>>> mb is a unconditional barrier, used to synchronize access to hardware =
io
>>> ports, suitable in drivers.
>>>
>>> We use smp_mb() because this serializes memory among multipe CPUs, whe=
n
>>> one changes memory but stores it to some temporary structures, while
>>> other CPUs don't see the effects. I'm sure you've read about that in t=
he
>>> memory barrier docs.
>
> I guess the main difference between us is the effect of "per-cpu
> viewable temporary value".
>
> It looks like your point is, without rmb() we can't see consistent
> values the writer sees.
>
> But my point is, even we can only see a temporary value, the
> __before_atomic() mb at the writer side, ensures only 3 possible
> temporary values combination can be seen.
> (PTR, DEAD), (NULL, DEAD), (NULL, 0).
>
> The killed (PTR, 0) combination is killed by that writer side mb.
> Thus no need for the reader side mb before test_bit().
>
> That's why I insist on the "test_bit() can happen whenever they like"
> point, as that has the same effect as schedule.
>
> Thanks,
> Qu

Can we push the fix to upstream? I hope it to be fixed in late rc of v5.5.

Thanks,
Qu

>
>>
>> Yes, but schedule can put that smp_rmb(); test_bit() line where ever
>> they want. So smp_rmb(); test_bit() can still get all the 3 difference
>> timing. It's that smp_mb__before_atomic() killing the 4th case, not the
>> smp_rmb().
>>
>>>
>>>> It's not to ensure every reader get the same result, as there is no w=
ay
>>>> to do that. Read can happen whenever they want.
>>>
>>> That is true about the 'whenever', but what we need to guarantee here =
is
>>> that when the read happens the following condition will have view of t=
he
>>> changes implied by the pairing barrier.
>>
>> Still, if reader still gets the temporary value, it's the same as rando=
m
>> schedule timing.
>> What we need to ensure is the order, which is solely ensured by that
>> smb_mb__before_atomic().
>>
>> Thanks,
>> Qu
>>
>>>
>>>> So before we talk about mb, we first need to know which 2 memory
>>>> accesses we're talking about.
>>>> If there is even no 2 memory access, then there is no need for mb().
>>>>
>>>> E.g. for the mb implied by spinlock(), it's not to ensure the spinloc=
k
>>>> counter reader, but to ensure the memory ordering between the spinloc=
k
>>>> counter itself and the memory it's protecting.
>>>>
>>>> So for memory barrier around test_bit(), as long as the compiler is n=
ot
>>>> doing reordering, we don't need extra mb.
>>>
>>> This is not about compiler.
>>>
>>>> And if the compiler is really doing re-ordering for the
>>>> have_reloc_root(), then the compiler is doing something wrong, as tha=
t
>>>> would makes the test_bit() meaningless.
