Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9E7C22A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfI3OFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 10:05:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:34633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfI3OFU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 10:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569852314;
        bh=2a8dw/QruPsiHdqkS/sJMpfpcmE6+LTygv5HxG5Anxs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FbSRgAcedKx/a3a+jM7zpUIH8v/08z8+fLWM31qcWa3uPmPzJqB1GkzPbwNXbS/ac
         eSGOH1OeH2GpXsmoBrEW49ccxx5/WAie3F4po8hmow7Ek9B//Oz7NsFGwuMDT5bGln
         GDI0g89d/VX2D3sP35uy2KgbsMkdDKhRFagEUtAo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mf07E-1hd8RD3VPe-00gc9g; Mon, 30
 Sep 2019 16:05:14 +0200
Subject: Re: [PATCH 1/3] btrfs-progs: check/lowmem: Add check and repair for
 invalid inode generation
To:     Nikolay Borisov <nborisov@suse.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Charles Wright <charles.v.wright@gmail.com>
References: <20190924081120.6283-1-wqu@suse.com>
 <20190924081120.6283-2-wqu@suse.com>
 <373ac9c6-ecdc-7688-5c28-791131b67f92@suse.com>
 <a73fe243-3be4-9576-6b5e-8b867aa16060@gmx.com>
 <b7663ce0-d2e8-6da7-bbc7-df0152e56e21@suse.com>
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <652d4ab4-b3e8-8b0b-4ffe-f9f2756a418f@gmx.com>
Date:   Mon, 30 Sep 2019 22:05:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b7663ce0-d2e8-6da7-bbc7-df0152e56e21@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oOSF4Zz098GKU6e/Z5Q5F+6umlHxndKUiiGw3SfKPrqBgXcinAp
 9/QPY6hT5dSvQY5qlhWqwe050u8SOGcH3wVaF9OHL//eWl5n0wsNs6MIITIdf71ADPTxD0d
 jk1qI6ChasHBs2bh8cncbV4W2833mIQ8jdDhrTi3YlGe4Yn6Baj/3mFsRT5OzHS0R0krTFb
 8O1BvlDU4QbhC3fr35Lrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sq+GQp/Fr8k=:QF+XtppkV2SbUrUfywJYwq
 Wx4TL79aNd0KIeHfQGljZ0pEJLE9TxibRJX3fiURd9RhlxW/Er/DH3QsFR6KhmTmiBD7qXxYa
 09rAW6Gz/uOSkdcNJF+JeZ/rw2i1hi6IEquXJgf/4AaHlkfDJQzr4IsQroJKN1fdUpxjlOJ6z
 4cgy6WDLp6WxYDAgzZ9WKXegL/OT4OXodacSdyeqfojXomgN5Or2sfoNLAwUPExTNj2KhRR3I
 cEqi3gNFiO48IdCvFaFmTz3SxTNRICwgqm+aCGk6Ke8P9vEt88jvHBBjzcN5mWwrFAEuAqfMf
 ohEDusuzAdH7M3InNfzMzlju1Gy/8nSAgm6fzatucG8YjZWvH4fwJBZjCAo45HE3hxgJoCZzr
 psVkjSEnH72A+ngd/xKcC/CGwfIJXMmMeRfS6L278TBqoL7NvHBVssutcToI3JNU4h8qNcaTX
 hh8k9Ifyb4pGQTdmj5mPPh1/w+fdShbMCxn8id6IS+8iszCuNRjX391jIlu2XwD/kjnzvUnPm
 VIypp7dGyxmyO7Lo2H4JZjMAB78+6au6Q//PNz9kU4i6nZ3XmZ6afKzy/GjeKAuJze6PZRLV9
 wfLeOygr8f22JpeAiJd0vVdFAMPdFSRMl6eprSuS/DX9x2YJAIRApPvqGKQl901pC7RZP3uKh
 djG+4dQj2nuuugTOimpGS654Srx7Ud4mZ0Mki5qEL3sHpmDdRylWbQl58nsYHEukEzjN1Trrb
 xEkMZlIqO8ZqjxkKbU7c8/LmSi4zZmuOwVbpOLwAlKCZLXO8tGrmlafc1hYlBzYmrM3lSSi/6
 MGLqZ3vzlUyYuCAf3ecDsV6/NLe4zdLmc+CEzM2R1PyLu5TSJiFHjqK6x0I0m7qSiz73eeZiX
 uJAFfxDzp2jHBmXzeZkf6UcMz8McZf0iMnuDXUP7Sk6JDz1KYjKfxogotw24xgS2m28mw9opi
 O2YuIuuNdpEkkxho73/pVVd8wb09McHs49cZmRSH0W7U9LIm300w9OitE22RsrGjiILc27hcI
 r0R3VfIiNxP4lGnN0oi01SIkl3B7mjNFkraPefFkiAjBSqav+IS+NLqtuRhNxANl9IWWAaTLg
 GF1ZPv3UkUfAD3dB+xj6ifGD8NNLOZi3/et3CRRWGLobaewL9xulScYfHojZf/VVjUA/kg+5l
 fu622zcDSGd5YvfuBjq4mGRb2ARQzVJVRVFoCku6qc8+8oXtpGTGQoNb8mig1jpJ6jIJJPVOM
 q+NlSdl4ZHE79kkTady46+qo1VZYCNF4q9MaILOBiT1kwDZXxf/DOci9ytzQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/30 =E4=B8=8B=E5=8D=889:34, Nikolay Borisov wrote:
>
>
> On 30.09.19 =D0=B3. 15:24 =D1=87., Qu Wenruo wrote:
>> Yes, the ASSERT() doesn't make much sense by itself.
>>
>> However I still believe it won't be a problem.
>
> It won't be a problem but it feels wrong to have this assert this deep
> into the call chain. IMO It should be put where it can trigger at the
> earliest which seems to be in check_inode_item. That function assumes
> it's working with an inode item and goes to dereference inode members so
> if the type is wrong we'd crash there instead of in repair_inode_gen_low=
mem.

This is going to be a preference thing.

To my taste, if possible, I would put ASSERT() in every function with
more than 24 lines, as an alternative to comment, to show the
prerequisite or the assumption.

Thanks,
Qu

>
>>
>> It's compiler's job to remove such dead ASSERT(), but for human reader,
>> I still believe this ASSERT() could still make sense, especially when
>> the caller or callee can get more and more complex.
>>
>> Thanks,
