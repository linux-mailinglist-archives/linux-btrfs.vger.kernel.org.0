Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636359DD96
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 08:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfH0GVu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 02:21:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:52149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfH0GVu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 02:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566886907;
        bh=QTYytZccOUGbcA1xo8NiiFXPwicZsdqzhn6S2AhPgQY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Gu02fl+Mt71Xn1OtLXXcY9FpDZoaxUDXDrJUJKWK9WERzbnJf3HfygolO6MYttnPA
         dslkmyeulp0Q/dsun3lYysFTgKEqUIq7an71AYe1lGxRBgrZBjUHxQApAleoQ+HaNn
         1fBQ7GPKf0gfj4+rviv95YUcV6VphVYIsFOdz66c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRCKC-1ho9Ms1wIO-00NCee; Tue, 27
 Aug 2019 08:21:47 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
Cc:     Christoph Anton Mitterer <calestyo@scientia.net>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org>
 <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
 <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org>
 <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
Date:   Tue, 27 Aug 2019 14:21:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XiKRZIV5OoYsOZ1VmxRIDWnyq4MfMojGdIVk+IwWYXcYuPp+BOt
 1ZlIgj0vqvSz9LXORKsuqnMLnq6ZlfvKLHAVexHI7AHfMgqWti6c2rZD0MJDOSppL7KfoS7
 zCVwY2LUhTN0mHIUIXlzc8syOrzTZizuXkynV1iZ7iKzVB4ww/Z8rbB1W33UoLiR6m4/ziM
 fhtn8P02eEWleDBBDJVoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+42kana8WAg=:stLxwAfov1IgShYDtd4AvE
 6NyQnP2Y2wBUyYm2cSgyDLSeTuG5uYuDvjJKe1lF/KwVJuHnopYkpsxfiFPmSvkG8OVboHyPv
 qwCmtgaNFd3AqtoTz1I2w4UHyoe+B4Mq8zQ/I9i0sJmSkdTfdBeayQCya7ZNGh91ODIHIzLTD
 bbnUN9vXiUbh0b6/albTyrHWhZhTro4IXyrrYsOhlADYT4eM/lNRo0kOlGxDwKi9mf8C3XVuS
 flZybrE4h7S9pzjfCIHsv1eMdwh3S++RzGkkMy/Eiz3h7a11gvWq1wEkvLMf+KUGY4YNSgkxu
 6w2bNLf9WDjZk6V70ag7pu9xnJKeLLqmWW3HWVLetHWBh9Rq9mu35AHt4kmndtM4NMSuM5JvL
 EmUuYrrkepoZJEJaeY9PgcOAdBzga2Df15/+EPEVtM6sUxXV3CkAcjMPmGAVEC6g0l9DBliGJ
 aCJ94Qc3mcecI7bV1K2VXD9lcODeyHkuEw0xE2xqxczhOtKFxbCmFM0PqSP2fzn9a/uwj4IHk
 pEielVLmnQB66nnIM02+IrIqgQqlFHectrQUpum3g5fONaSv9qFbPU7VYXlgXel1Pc35miXkr
 X9LLdy4yU0mS/mzKAAqaquSutzmLqZ9z5ZzsBZxhuC1d9DONI7DTqtRdDRPpGoqRl5FYpdQ83
 cQ86ntiUj/CkDUY8zg0axPIF3A/lPasj1+841AEd/+CuuvpMUvZogUd6CarKxFa1j5bXsjaLz
 K4KE6yWkA4pBZSNo918kT9mzABwi8qFBOFJNA8llkiyiamnV3Bpo6IBQfXbcy7k4WddxkBMsG
 ib2D42yjezK9I5bca4KwbJfWi0SDoe11SrtwrDbF1ipJEjzMDP1ZQAMYIVJGgZnBK1BKjVOIA
 2Fs2McxQ3zgFmXaDKfN8dvWaHDct147jDU2bssHZUca4dHtjH61SOcazotqBOWJLY7GNTrAGa
 oJqcV7vY8UaOo6ORlEEdnrYwAyN/vxxxWNcWUBsrnyqSKJ5s5TdGIYXkrm3SWtWipoz6Vry94
 sIOIlBMuZADO93LuL0ClmJX7E+cziuStFE59IJMiRQbpxe0hyMNw5feIsh0Ze+XHawyA/mAZL
 MkYrzrA5N37QtkEDnpoQ7XTM6C7S3gWxKdLoLjrbGXxpoNzULXYGOL49Rgk5VKfLRVkLrbnEp
 YckeM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/27 =E4=B8=8B=E5=8D=882:13, Sw=C3=A2mi Petaramesh wrote:
> Le 27/08/2019 =C3=A0 07:06, Sw=C3=A2mi Petaramesh a =C3=A9crit=C2=A0:
>>
>> Now the machine looks stable so far with a 5.2, albeit more recent, Arc=
h
>> kernel : 5.2.9-arch1-1-ARCH.
>
> As my 1st machine looks fairly stable now, I just upgraded to 5.2
> another one that had always been running <=3D 5.1 before.
>
> So I keep an eye on the syslog.
>
> Right after reboot in 5.2 I see :
>
> kernel: BTRFS warning (device dm-1): block
> group 34390147072 has wrong amount of free space
> kernel: BTRFS warning (device dm-1):
> failed to load free space cache for block group 34390147072, rebuilding
> it now
>
> So it seems that the 5.2 kernel finds and tries to fix minor
> inconsistencies that were unnoticed in previous kernel versions ?

It means something wrong is already done in previous kernel.

V1 space cache use regular-file-like internal structures to record used
space. V1 space cache doesn't use btrfs' regular csum tree, but uses its
own inline csum to protect its content.

If free space cache is invalid but passes its csum check, it's
completely *possible* to break metadata CoW, thus leads to transid mismatc=
h.

You can go v2 space cache which uses metadata CoW to protect its space
cache, thus in theory it should be a little safer than V1 space cache.

Or you can just disable space cache using nospace_cache mount option, as
it's just an optimization. It's also recommended to clean existing cache
by using "btrfs check --clear-space-cache v1".

I'd prefer to do a "btrfs check --readonly" anyway (which also checks
free space cache), then go nospace_cache if you're concerned.

Thanks,
Qu

>
> I wonder if such things could be the cause of the corruption issues I
> got : finding some inconsistencies with new checks right after a kernel
> upgrade, trying to fix them and creating a mess instead ?
>
> (This 2nd machine has been rebooted twice after this and still looks
> happy...)
>
> Kind regards.
>
> =E0=A5=90
>
