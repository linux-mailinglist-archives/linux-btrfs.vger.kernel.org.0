Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7291352D9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 06:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgAIFyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 00:54:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:33209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgAIFyy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 00:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578549281;
        bh=Ft+ksvRZcEQopdHZ40lth/MHv4ooo1Dp9hv+IJiGyaM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fAdRs1QsPBqsN1sUW3G/gRS6Pa8x+BGYkSdmwsJM34HAAh21B3NOY8wqy8kZDCRS4
         wk552qAnZu8zO09d/NCWkNO77PKYKLVLBYLAEafr3l9v1ebR+ym9OF1yh920vnB/7F
         ipfNnywW4KWCLQKlUz13BWdC3N7DGHVhdWf+Tca0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQe9s-1j0w3a1QCE-00Ngox; Thu, 09
 Jan 2020 06:54:41 +0100
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
Message-ID: <85422cb2-e140-563b-fadd-f820354ed156@gmx.com>
Date:   Thu, 9 Jan 2020 13:54:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108151159.GI3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6y305C7R3maMTqvRMsi/SRu8bF9j6ipBSj/UolLna982Uk50A5E
 hyC17g1NV2v0P5/q0dawjgGFD1UcZMqB7G9pxTxkrG2ZCbFpqwgCaPfSeLhrH4j9JySVXTc
 qbRs0tzvt5Zv9QNm8mPVALxrgjyf9wVQtjF2DxxwF0WD/nZmVVliP0Rng89g+X96ZBQGhHz
 FJmGUX2VvkunDG2GjK4Jw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PBWcMQGq9hQ=:UvA04vO3Epv6iBcyc/O1zj
 eOIiPzZ8NhxV8NU3AL4pxnITTIwg4t0/e4GZkQusagqgd3t3LVDtZqYIg8zKr5qK7y67jGWIX
 2ZOFhBqFYLT+SP2KtflgmY+UR9EQMwz1SJcNBzRNs1aGk+cDTlolsAxKUVo3Lu5zVB/ZgCn1z
 kv8Sg8XCTv47+QciEjExnq5Uh6KeJJ4/Pp7b6s9Bs6PTkohaVXrg5g4ekvPu9zS1M9PF+u2sZ
 6cHZe+oCIUGbTS7FMOYZQOqE0NCEdqVthji9y9uitJskkeb54x2C8OmGVHMbn+kSZFHydbTF3
 UtVKNzo4OMS9vTD/w54RZTCFNfp+PB8QthdMn2oAEKT2MciiZv/Y4kZYSxeeVjvCK0qnJ4HT8
 +YwEQIAj3fv8vk1v88l6voDR1XmT4A14O0PTozZsgbz3gdGqpDqrvzOgHbxcw0svKjFPtqTIy
 Ijtp1Osp0AcEiBjYnVChnzWzysiZA6HBhSHJIEWUhwBVDn1OQ+Nh8zwz9dHsprmlGtBEi7iFY
 EzZgjqVHsSGBbAyQRM56d2oxyJpd7wSXroT6935kbEPs2D+Q44K50RyFULTtrVoQs6b58VC83
 4yNLKxY8sOgvw2bdaWZQii03X8bWiw9tIMqTYK40x29m85poaotffIXVU8GOjyJlt1A03RFon
 0OAn89DSVd73aa+WEvZ4R6emUFjYh1byoBuNHYESrfGQChDYM3vTwW1As+y2AxXMU1qIBXd2s
 E1n6oinWodAHXE2OlKQjDH5XX4A6MPlA4SYIMGCrVoNpnuOPs8vRt2kC4ioeV59HEaSX+0a3W
 WHJYKG6gihByrgONjPJEB5mGAgIqCb5ncIjynH4assJap9dSPNvXzoSxRxb6Lxuf2Hm2F7FjZ
 YL5T33KGSH5w1lzgXAf2vcVcsl7qz8hfEDuajAYsEfHajv0zE+S7veIchErNSjroA5UYMK0CY
 WaKthdUl3h1MRWWUnYN8EBbpVhoKJddr8p9Q8glLPxuAt4TBR8g4j4PSRtce0U85bKdE/8XY5
 whv5Z1zSsdTMU6UO/AtUs1EfKvpDRHbl3rBg8do2lzTvM5max21cfLEagn4gRx1xqAt92ceB/
 hX5OzSg75N5of+vORr3YsqDPUb/pbI/1s0LmlYwp0BBsMVAe0KzXmHf7Avq2ov7yfVPCA27mK
 UC4zZQKQUI+B27I5FyYAQ+834S4zubrf7INJqrSMrL64eMe3vS8F2zRWXpqN1DbpaihVljfxI
 Qd3h2J0nm0Mt/PG2meSpICC4Q8LdRmHQyP8xEeUv4TzHxUa2QBLjkBbxA14M=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/1/8 =E4=B8=8B=E5=8D=8811:11, David Sterba wrote:
> On Wed, Jan 08, 2020 at 04:08:41PM +0100, David Sterba wrote:
>>>>> +static bool have_reloc_root(struct btrfs_root *root)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->=
state))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>>>
>>>> You still need a smp_mb__after_atomic() here, test_bit is unordered.
>>>
>>> Nope, that won't do anything, since smp_mb__(After|before)_atomic only
>>> orders RMW operations and test_bit is not an RMW operation. From
>>> atomic_bitops.txt:
>>>
>>>
>>> Non-RMW ops:
>>>
>>>
>>>
>>>   test_bit()
>>>
>>> Furthermore from atomic_t.txt:
>>>
>>> The barriers:
>>>
>>>
>>>
>>>   smp_mb__{before,after}_atomic()
>>>
>>>
>>>
>>> only apply to the RMW atomic ops and can be used to augment/upgrade th=
e
>>>
>>> ordering inherent to the op.
>>
>> The way I read it is more like smp_rmb/smp_wmb, but for bits in this
>> case, so the smp_mb__before/after_atomic was only a syntactic sugar to
>> match that it's atomic bitops. I realize this could have caused some
>> confusion, however I still think that some sort of barrier is needed.
>
> There's an existing pattern used for serializing set/clear of
> BTRFS_ROOT_IN_TRANS_SETUP (record_root_in_trans,
> btrfs_record_root_in_trans).
>
> Once upon a time there were barriers like smp_mb__before_clear_bit but
> they got unified to just smp_mb__before_atomic for all set/clear
> operations, so I believe I was not all wrong with using them.
>
I used to believe the same fairy tail, that mb() works like a flush(),
but we're not living in a fairy tail.

What mb really does is keep certain ordering from happening.
And ordering means, we have at least *2* different memory accesses.


It's not to ensure every reader get the same result, as there is no way
to do that. Read can happen whenever they want.


So before we talk about mb, we first need to know which 2 memory
accesses we're talking about.
If there is even no 2 memory access, then there is no need for mb().

E.g. for the mb implied by spinlock(), it's not to ensure the spinlock
counter reader, but to ensure the memory ordering between the spinlock
counter itself and the memory it's protecting.

So for memory barrier around test_bit(), as long as the compiler is not
doing reordering, we don't need extra mb.

And if the compiler is really doing re-ordering for the
have_reloc_root(), then the compiler is doing something wrong, as that
would makes the test_bit() meaningless.

Thanks,
Qu
