Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5057D13647E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 01:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgAJA6l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 19:58:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:54333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgAJA6k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 19:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578617909;
        bh=erPYz58RxjXj/yjW0CfotcsJ/bDf9aY5QTOS+6HuV48=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Qu5ulYwZUovvesApWBnccphfxnd38tq8hVuxgYuPVlXTsZ7EnwHVF3gRFzUX9ff5h
         rXNMGqIMtp++5Kcm7qUO+PvXoJsfqqwIrv8VtEV/WOHbFhT+JlDwLK5h+qYNNjy4wG
         Ux5koZtuEoKlFTowQl7DNrKIA7b3xFW/J9nK/ebI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLQxN-1j6QZK08Cx-00ITaF; Fri, 10
 Jan 2020 01:58:29 +0100
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
Message-ID: <d4322bd6-c2dd-e3e6-e8eb-2cda1963f9d7@gmx.com>
Date:   Fri, 10 Jan 2020 08:58:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <f8458b9c-0b6c-024e-399d-ea530abd1204@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0DBz1E57fxM0zjjNMCuCkOlutp68m6TbPNB9XZqGUaF3csTZwR/
 V8PlL9vxj+JwnO0uJWley5I2tB7/mQ96uJzLhEKbBqMBY4RnXdaWa4+7rpxt3obpfGeGBxI
 6rcL/kplJfuPN/VDI+U9I4q7+IgPC6lrApsO17aXrY12qpTFvk/+1QE5LdhbexTI3O+ZLZQ
 EwmYGwgoJZwZmB0gA/pqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xugdqmQBOzg=:6yadZy7gYsgogfisLQg7+p
 DPvtA/dZr5kSjwRSFm420Y3mmohtdx5mlWZlnDMNggcmSzJyK50FqhnLa1fzsz3zRSs1/vTXr
 PDFb11ltkWdKTAmjjEfEm+7sXnW11erCeFCbXDrmaVUIDlrnUco9xK2zTm0IPCW+G8Tr0KHQm
 bDYYzpgXZdB6G8BnPZvXy4UFOFpJA+HR1bT3LIrU9WlurCF2n+4VjqXZWg/CKurGU9hwmnTEh
 ZF/U5iXG8BN1BnNWmSUMYdGklzUfHLyRX4zVY8LWTBZuuaTKlz/sZFkHMczU54BIQEjxXlqRm
 psMGqUfQdM+EUncNiiXoVCEoSDML8OYM8ylNY3/P8QM/FWl6T1FFNdexdTxXbAfT5jpkBUhqI
 1Irus34bQ6XVzNc8yfgcVipm3rs/EOZqEIo63+z3uRtUblspptIwzlYBhMp2iO3tCtpXXKgyq
 SCxWjn9hHXpZiQcLbxm8Yn6St2Qm1hvwINPD+j4lJlJPJQkXMzqHp9DT1KvAjNuKqYei/QTHk
 tBAruYivIPRikNXCdFMEwasK/9hy6wrpHsX1oyj5G+Ptk4uy6Fhi9SUd3ZohzS0902eTpMEs9
 CnhafH4ryz3chEHXZ2VvGwAcJ+FXNZ07UE+ukKoitPaqGpOIOfYI1JpqXJHZToWYKP/2KFUZp
 pcG+DQf0U/u1W2cp5aXF4SbfGSPtbGpzXHr9Z5YmkYQzwjxBTlLbIvKzH4gRL1eVs430NCsXI
 aMgvCCZtCDgTFroZeHI73EdpnlZwl6WYd9iQDqXV2yeJd+jFHeK37/t605JaxtlabHP4BU1ds
 TKXjwVDDe1uGZ+81uKkKY2GWfLynWEsTjzEXt8IfCRLJB72WILXwCMZYrT1wnHA6PXsulMIaG
 7FI+gWKNNwJ9+8f7WG+nig+u1E73ckTvIVGU8N9sn24mT34n6I4tX1mIaU2xy+0XHMqPAptW7
 FEokSyjiYa6RoH+Ao/O0irvHm/ujvHXsI1eSAlsFxqdLv9gS0SIBsK9OoOJs0X2LwKetcBgAa
 jL/+/GX3Q9tkiQfeeHaYh+WdJw8+cHRHu7M4e9zBL5UVKBXJ+k5spOG92lOn8OVmyhQ2E8Z0D
 K0M5AipG6LzctJRs3VrGrDa6pg2/T1P5hF6CxHrHkHXr3lQL7WeXlcLFnkswygDvQl1EL1ydl
 7oow8ROVwciTmnnn7/XdtesdzpgnCNOrceAtNELQFcpCqCJLV2Z/MnFt9UdgFH7MLI9Fqp0ih
 +oGbyO1W+ZBWki2himJhW4plTy5bVHVZ7UsqrgKECUHps/viBZgX7WaUJ2E0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/1/10 =E4=B8=8A=E5=8D=888:21, Qu Wenruo wrote:
>
>
> On 2020/1/9 =E4=B8=8B=E5=8D=8810:37, David Sterba wrote:
>> On Thu, Jan 09, 2020 at 01:54:34PM +0800, Qu Wenruo wrote:
>>>>> The way I read it is more like smp_rmb/smp_wmb, but for bits in this
>>>>> case, so the smp_mb__before/after_atomic was only a syntactic sugar =
to
>>>>> match that it's atomic bitops. I realize this could have caused some
>>>>> confusion, however I still think that some sort of barrier is needed=
.
>>>>
>>>> There's an existing pattern used for serializing set/clear of
>>>> BTRFS_ROOT_IN_TRANS_SETUP (record_root_in_trans,
>>>> btrfs_record_root_in_trans).
>>>>
>>>> Once upon a time there were barriers like smp_mb__before_clear_bit bu=
t
>>>> they got unified to just smp_mb__before_atomic for all set/clear
>>>> operations, so I believe I was not all wrong with using them.
>>>>
>>> I used to believe the same fairy tail, that mb() works like a flush(),
>>> but we're not living in a fairy tail.
>>
>> This sounds strange, by flush I was refering to internal CPU mechanism
>> that makes all temporary changes visible to other cpus, so you're sayin=
g
>> that this does not work as everybody expects?
>
> Because no matter whether mb ensures that or not, the result is the same=
.
>
> What would happen if the reader get schedule just before the mb()
> command? Reader can still get older value.
> That makes no difference if we had mb() or not.
>
>>
>>> What mb really does is keep certain ordering from happening.
>>> And ordering means, we have at least *2* different memory accesses.
>>
>> Sorry but I think you're missing some pieces here. There are 2 memory
>> accesses: set_bit/clear_bit (writer) and test_bit (reader).
>>
>> The same could be achieved by a plain variable, that it's a bit brings
>> more confusion about what barrier should be really used.
>>
>> The pattern we want to use here is pretty standard. Read barrier before
>> read and write barrier that separates the data change from the indicato=
r
>> of the change. If you line up the barriers, there's a clear line betwee=
n
>> the data changes and the indicator value.
>
> Again, test_bit() can happen whenever they like, and smp_rmb() before
> test_bit() makes no sense.
>
> test_bit() can happen before reloc_root =3D NULL assign. after reloc_roo=
t
> =3D NULL assign but before set_bit(), or after set_bit().
>
> That smp_wmb() makes sure set_bit() won't happen before reloc_root, than
> that's enough.
> BTW, smp_mb__before_atomic() should be full mb, not just wmb or rmb.
>
>>
>> reloc_root =3D NULL
>> smp_wmb                           smp_rmb()
>>                                   test_bit()
>>                                   ... here
>> set_bit(DEAD)
>>                                   ... or here, it'll be always
>> 				  reloc_root =3D=3D NULL, but it still could
>> 				  be before or after set_bit
>>
>> You should also distinguish between mb() and smp_mb() (and the rmb/wmb)=
.
>> mb is a unconditional barrier, used to synchronize access to hardware i=
o
>> ports, suitable in drivers.
>>
>> We use smp_mb() because this serializes memory among multipe CPUs, when
>> one changes memory but stores it to some temporary structures, while
>> other CPUs don't see the effects. I'm sure you've read about that in th=
e
>> memory barrier docs.

I guess the main difference between us is the effect of "per-cpu
viewable temporary value".

It looks like your point is, without rmb() we can't see consistent
values the writer sees.

But my point is, even we can only see a temporary value, the
__before_atomic() mb at the writer side, ensures only 3 possible
temporary values combination can be seen.
(PTR, DEAD), (NULL, DEAD), (NULL, 0).

The killed (PTR, 0) combination is killed by that writer side mb.
Thus no need for the reader side mb before test_bit().

That's why I insist on the "test_bit() can happen whenever they like"
point, as that has the same effect as schedule.

Thanks,
Qu

>
> Yes, but schedule can put that smp_rmb(); test_bit() line where ever
> they want. So smp_rmb(); test_bit() can still get all the 3 difference
> timing. It's that smp_mb__before_atomic() killing the 4th case, not the
> smp_rmb().
>
>>
>>> It's not to ensure every reader get the same result, as there is no wa=
y
>>> to do that. Read can happen whenever they want.
>>
>> That is true about the 'whenever', but what we need to guarantee here i=
s
>> that when the read happens the following condition will have view of th=
e
>> changes implied by the pairing barrier.
>
> Still, if reader still gets the temporary value, it's the same as random
> schedule timing.
> What we need to ensure is the order, which is solely ensured by that
> smb_mb__before_atomic().
>
> Thanks,
> Qu
>
>>
>>> So before we talk about mb, we first need to know which 2 memory
>>> accesses we're talking about.
>>> If there is even no 2 memory access, then there is no need for mb().
>>>
>>> E.g. for the mb implied by spinlock(), it's not to ensure the spinlock
>>> counter reader, but to ensure the memory ordering between the spinlock
>>> counter itself and the memory it's protecting.
>>>
>>> So for memory barrier around test_bit(), as long as the compiler is no=
t
>>> doing reordering, we don't need extra mb.
>>
>> This is not about compiler.
>>
>>> And if the compiler is really doing re-ordering for the
>>> have_reloc_root(), then the compiler is doing something wrong, as that
>>> would makes the test_bit() meaningless.
