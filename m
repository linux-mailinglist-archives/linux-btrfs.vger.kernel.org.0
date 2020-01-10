Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC0913644F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 01:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgAJAWF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 19:22:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:54561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730146AbgAJAWF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 19:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578615712;
        bh=b76opKYuVVDkQcLkk9mW8pk+nJjaGpijE/rpItY/fTI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EfBoRpZ1GMB3yqa75URVLTdBq1zFaFygbp3UhS1Tv70vXqKFxr0AeCY9ZeqiEwrxq
         bdhYVZ57/nWYeFwm1mk7tXtKQ7JnPTe5MJQxaIKtJYQVMn1mRE+WFvnP42QbO39Mrf
         F6y+lhr+PINikJOIYPGRnjphiYJz7rAeriHI4KVU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPog5-1j21sx0GGp-00Mt4F; Fri, 10
 Jan 2020 01:21:52 +0100
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
Message-ID: <f8458b9c-0b6c-024e-399d-ea530abd1204@gmx.com>
Date:   Fri, 10 Jan 2020 08:21:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109143742.GN3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QsimB9W89MMoucYnMfRGUakThBLYrv7VECp3V/EEELLaopM62Ls
 Z/u6KhydMKIJlgiv7XuB6+DXILzloSaXH94LD61/O5T8wyxPJ6GYryezr6lP72mHHtu22/e
 DQ1mrktWAKOC5nKFf2WVmoW3PdYirRopotj/omujas6IioSWJHdWJhtZUvTyLQ5MugeVz3O
 GU3NRSAjJlwxMitU5X6Vw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GSKrpTudka8=:LCEPhS5KZ9Ncizn6mryGNT
 FpApFnSvxT26Q+6cpZNETQTKR/lGq8w+DviBM71dn5CX4rBd2MA8IXpwLv28OGuB8+TDigHrF
 YbFeA+s1oYAcE2dOIjgKYTsXaBJ3iN4tK2Mx2a2mMJLUk51fu9bs9Hb7eZ9cAxnAEL/MMW8vK
 EKaoKqsed4VuVHVk1G3CljE2DK3de7hHmhAT0bmvY4UcIfJhmi38rYWIxcZHhwxSc623r/F8E
 c113Ayd1j2sjumgsAR8UItq49tZjeBaZqrSq9dEBZ4hR7wITa7DgZX25L7lf1VZB8M74rmAy2
 LlcN+dCsDxVBzrgcqkv4a4IO1qGfxxGui+0NvHrHemOKLJoHsY5Pbkf0aeD7jImzI5Z2Ks5Lh
 6yX/Cc+wLUguXHxchF/znOe3ii8nNHALcDY4IXi6kUM3KMTbwTyawvd6vEIIH8JqBYDSdU8kJ
 vVCyGktGoArQOPr1ji2f4fTda9mPWZvkBmQYySlcSSR265zp+OjgbC1pxEyxRseqsOurwZeGE
 b8gDr8yOTdy9jwLzWSv/V9ULReCmAMlP91sfql5XMNUQL5T9lZs90b38Cu5/jlbF3/IR/R5yd
 B9wbqepwnCBv3+m6vJ42tYnsA+DQ2kWYFKv4LeWcpJNaOfCVBQnvsh9cj0FMt9B8ROksE+a9C
 ruqLRxOiRLVcu44fhgLPmbZHwNMCLrzLdLoNKpkr/+Tpkfqoc8zT3/ZGbZJuNZaDVO9YrIMCM
 0mv/BvNRRldHMZbs2NOaAbii5gdhi+hiiq6GN44z7rnX8VE8yIoSOywjmx5s1qw7nzQmsbAXz
 MQlidU6z2AR5MyX5qsDU8dupGRhlKmfmZETkfnsLT5doe2Gc2sSIPTrfF5NDbTIM7Vly56ysU
 ae7IwwwEnHdU9qJe3KI72r+yVCfS9YmV9bQX6KKxKZD9xYXu9Z57M+m5CTk5hB340y1eFQsD0
 V0Dp0aTLbKX+kuaulLOEMNZ8fGFbyhi0bg5SyqPWEyKILTgLpuK77zoKaxXaBMorESIOiexUd
 /9sF8PMRnMqTG+FHL2PbZlbRCp4isqXz42WkHQiWS5JwDfkDRa8D3AIcUmiyUydqzY2bj2XeW
 mwEsnkN4RSpPwAdHtn0JtunI6N+LFzAc59NWKtpUNm5SBGVOJDz38tanCdGmZJkwK6pfcpeNJ
 KqbFjCllk3SxuBYiTbPQHuHhZuoejdM1EJxPf5NDgrGW8Wri9/Ac27WBZyaUbbjhXKtgi9ptL
 9qCUF6nJxrzEOuVH3CenClt5MW8On1jz5jD6p+COdF4sMZj5IBR3VJxBDh/Y=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/1/9 =E4=B8=8B=E5=8D=8810:37, David Sterba wrote:
> On Thu, Jan 09, 2020 at 01:54:34PM +0800, Qu Wenruo wrote:
>>>> The way I read it is more like smp_rmb/smp_wmb, but for bits in this
>>>> case, so the smp_mb__before/after_atomic was only a syntactic sugar t=
o
>>>> match that it's atomic bitops. I realize this could have caused some
>>>> confusion, however I still think that some sort of barrier is needed.
>>>
>>> There's an existing pattern used for serializing set/clear of
>>> BTRFS_ROOT_IN_TRANS_SETUP (record_root_in_trans,
>>> btrfs_record_root_in_trans).
>>>
>>> Once upon a time there were barriers like smp_mb__before_clear_bit but
>>> they got unified to just smp_mb__before_atomic for all set/clear
>>> operations, so I believe I was not all wrong with using them.
>>>
>> I used to believe the same fairy tail, that mb() works like a flush(),
>> but we're not living in a fairy tail.
>
> This sounds strange, by flush I was refering to internal CPU mechanism
> that makes all temporary changes visible to other cpus, so you're saying
> that this does not work as everybody expects?

Because no matter whether mb ensures that or not, the result is the same.

What would happen if the reader get schedule just before the mb()
command? Reader can still get older value.
That makes no difference if we had mb() or not.

>
>> What mb really does is keep certain ordering from happening.
>> And ordering means, we have at least *2* different memory accesses.
>
> Sorry but I think you're missing some pieces here. There are 2 memory
> accesses: set_bit/clear_bit (writer) and test_bit (reader).
>
> The same could be achieved by a plain variable, that it's a bit brings
> more confusion about what barrier should be really used.
>
> The pattern we want to use here is pretty standard. Read barrier before
> read and write barrier that separates the data change from the indicator
> of the change. If you line up the barriers, there's a clear line between
> the data changes and the indicator value.

Again, test_bit() can happen whenever they like, and smp_rmb() before
test_bit() makes no sense.

test_bit() can happen before reloc_root =3D NULL assign. after reloc_root
=3D NULL assign but before set_bit(), or after set_bit().

That smp_wmb() makes sure set_bit() won't happen before reloc_root, than
that's enough.
BTW, smp_mb__before_atomic() should be full mb, not just wmb or rmb.

>
> reloc_root =3D NULL
> smp_wmb                           smp_rmb()
>                                   test_bit()
>                                   ... here
> set_bit(DEAD)
>                                   ... or here, it'll be always
> 				  reloc_root =3D=3D NULL, but it still could
> 				  be before or after set_bit
>
> You should also distinguish between mb() and smp_mb() (and the rmb/wmb).
> mb is a unconditional barrier, used to synchronize access to hardware io
> ports, suitable in drivers.
>
> We use smp_mb() because this serializes memory among multipe CPUs, when
> one changes memory but stores it to some temporary structures, while
> other CPUs don't see the effects. I'm sure you've read about that in the
> memory barrier docs.

Yes, but schedule can put that smp_rmb(); test_bit() line where ever
they want. So smp_rmb(); test_bit() can still get all the 3 difference
timing. It's that smp_mb__before_atomic() killing the 4th case, not the
smp_rmb().

>
>> It's not to ensure every reader get the same result, as there is no way
>> to do that. Read can happen whenever they want.
>
> That is true about the 'whenever', but what we need to guarantee here is
> that when the read happens the following condition will have view of the
> changes implied by the pairing barrier.

Still, if reader still gets the temporary value, it's the same as random
schedule timing.
What we need to ensure is the order, which is solely ensured by that
smb_mb__before_atomic().

Thanks,
Qu

>
>> So before we talk about mb, we first need to know which 2 memory
>> accesses we're talking about.
>> If there is even no 2 memory access, then there is no need for mb().
>>
>> E.g. for the mb implied by spinlock(), it's not to ensure the spinlock
>> counter reader, but to ensure the memory ordering between the spinlock
>> counter itself and the memory it's protecting.
>>
>> So for memory barrier around test_bit(), as long as the compiler is not
>> doing reordering, we don't need extra mb.
>
> This is not about compiler.
>
>> And if the compiler is really doing re-ordering for the
>> have_reloc_root(), then the compiler is doing something wrong, as that
>> would makes the test_bit() meaningless.
