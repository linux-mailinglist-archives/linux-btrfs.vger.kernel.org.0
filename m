Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81956242580
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 08:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHLGds (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 02:33:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:38525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgHLGdr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 02:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597214020;
        bh=PkFcZagO2Zi2wFBD2IgBPTZGGkg9aYUUsLwL+GyAK3w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ml8zcXku5pEzZk4Mg6XrOOZM4i5DwRDuik5g3RqEhxa/71oWFGpfd7343Ww6mdqq/
         +h5xEP+LJJxVsMbKKL51mE8vQ6TPkmEE7NtbfrLr2jWmJh82d+JirzSR8wXfKemeaQ
         F/RCCaGFewHGWsCofao7rOBtp0omP/X2ThlAqiLE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GQs-1kjKKo3TZQ-014Gbu; Wed, 12
 Aug 2020 08:33:40 +0200
Subject: Re: [PATCH v4] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
 <20200731140807.GM3703@twin.jikos.cz>
 <9ec86d30-96b5-2e80-969e-158342c273ab@gmx.com>
 <20200811072234.GK2026@twin.jikos.cz>
 <8796039b-d0b1-a129-3b01-a260a051154b@gmx.com>
 <20200812061016.GT2026@twin.jikos.cz>
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
Message-ID: <2fd35a06-ba26-173d-1b72-e41243b78068@gmx.com>
Date:   Wed, 12 Aug 2020 14:33:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812061016.GT2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xxt3K8AhxI5RMa8BQflFAfCIOFcE0PerwNj1EgZX/H7DjbIgZYl
 pEXYUFk4QjYm5wHRbyW5RccO+4n+AWiGprENd6pjxuS8cvDvIHlqL2RFMylC0UdOO9sFWRe
 W1WaOZUXGUhV8nWd2wdreoiHPc7eJs65M1O7Gy1haIEgGi4nS3Pt/FbfpZNqe+5pjFKmwO2
 1Ej5tF209FF/mayJbFoJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/iWjsPWlD5I=:CjEvKCjMj/dBOA4O//v/wv
 3bAY9AsCxxtnVkerGWjdI6h8HIfKZerN737cYmC6L8heXsOPibwYVqiUFNrRmcu7NtwqrToKp
 mM+ykK9zwIaBssjZMy8U1ksDmKnIiFAlFhCyZR9Y3CFlRDMT5DZO0YJMbRloSfCp+Ymym/Hay
 gYWXT6j7nnBmjNk6XGmfypCWXGgIMlYMhs2sjk+s6bQiviHA4Bq6PMMgVHcRNqWaUrI3bdE9x
 dIFbIuWK+BV0+sIlDOONa4RaO9MbJkUVJnBBBKjLhjNn+nVl0eEwIULhL7XLh2xp8NAb/9bs5
 Q67ZhRsvXvMO0dPtpltD9KczXPbJ7cGzLtZO97N8pwEmEvT5OhzqIPm/+YnS9kSlReCTpRdxc
 vxcjPH02rUtENArhEbZkSyqpumnaZU3xvOwuj50GQzb5O2HMWoTjE0BAqKxhyhztZ4MHY5MES
 nt3WTw2p/aO68E8aGK3fTqQu7nrZFV7vOzEUE93RpT5edOhMCkuIulJhmne+nXMUFjBDLi4yB
 M06X6seQYQPd+CURlUyqqQYOyqaowzyzV/5o1J5/TlPZJb+2lV55VaprpDXMWoW+HQrhFd5fn
 FBOZGujnulhRmby7n6vNiCbVek3GYsfuOWGrb7aD7wv7P7aFwhnApNXkGA3eNZu7p7K4OS8sV
 1n+CA7AkckKSfb+lP3AqpazTq7N9rLcHz9RhSWmbgeIrpaXY4aB3Pve6B2r2fAE6INFu57cpt
 in544zR0y32HzlICpBS5yKP+QybK+DR82tsflU+74XccWT7ZnM3WopWpdjgOPSI4JLcH5nPwE
 SdaeAerxHwiS5YB3hB9BaJz4iS+3Rvl/z1GkO5KE6l4jWRRhfPYpYL9iQfQrY1fErrHtVELbS
 q9Qt+EtFNX/OJHQJhbXRz8f0zPo0X8sBcSZKrJq4qtqVBrresbwHCX+08HAUYNQA7wLr8+mRB
 LIo0rFq1nVt5LOdBO0I3mvSUW9GsUKGbh31ByZR4gLfG/wOvFVuEmoUfpxHezEoKV2zeSZFBp
 po2QzhAbvHZpQn/sXp9bFnXCtsUnebSrUSFBrtL3AzozvqQEyHBs8deuMSnspbHNs93FUBO20
 hgxyWCBcqmw+l6jgbCAK81/7fi5sI/oE0askBBWKuvchIASphll/zcwFquU5lISNucLhC3nbW
 +FnJ/Dg+uBMIWv5tM1aOGMC7fNv6SpU9TLnBfEtpXOMrTtp0ueKjO9HVLMy1A7COAc6XHUua5
 6foqgnu67062BH54YPid4y2UDMwwmgVNFy42cKQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/12 =E4=B8=8B=E5=8D=882:10, David Sterba wrote:
> On Tue, Aug 11, 2020 at 03:42:31PM +0800, Qu Wenruo wrote:
>>>> CHUNK_TRIMMED and CHUNK_ALLOCATED.
>>>>
>>>> Thus what we're doing is to clear all utilized bits.
>>>
>>> Which is true for now, adding a new bit would change that.
>>
>> Yep, that's also why I had the comment here.
>
> The comment is not enough to make the code future proof, as we really
> want do clear all bits in the range beyond device->total_size and that
> works only if we specify them all (clear_state_bit).
>
> Either we can define a bitmask of all the bits next to their definition
> (slightly more error prone if we forget to add that manually), or pass a
> all ones to the clear_extent_bit. Though this is a bit uncommon, with a
> comment I'd prefer this option.

OK, I'd go that (u64)-1 as clear_bits direction, with updated comment.

Thanks,
Qu

>
>>>>> But I still have doubts about just clearing the range, why are there=
 any
>>>>> device->alloc_state entries at all after device is shrunk?
>>>>
>>>> Because the alloc_state is mostly only utilized by trim facility, thu=
s
>>>> existing functions won't bother clearing/setting it.
>>>>
>>>> In this particular case, previous fstrim run would set the CHUNK_TRIM=
MED
>>>> bit for all unallocated range (except the super reserve).
>>>> Then shrink doesn't clear the exceed range, and cause problem.
>>>
>>> So the unallocated range on a device is also represented in the
>>> alloc_state tree?
>>
>> If the unallocated range has been trimmed, then it has an state, with
>> CHUNK_TRIMMED bit set.
>
> To clarify my previous doubts: I was talking about the slack space (ie.
> space beyond device->total_size up to block device size), 'unallocated'
> is ambiguous and confusing here.
>
> The missing bit about clearing the whole range lies inside
> clear_state_bit that deletes all state tracking once all bits are
> dropped.
>
