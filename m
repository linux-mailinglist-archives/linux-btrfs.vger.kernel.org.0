Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61ECE78D28
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 15:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfG2NrR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 09:47:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:53145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfG2NrR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 09:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564408035;
        bh=ViaYwRJKgIvbvOn1dcv45jNLmh22dR9g68jR4gDykOo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gtQw1GFVyOAo7gzhGRnslPF4C+XLlADEdIsquAPiLucli2xlQNlqxe7UKM1wdkczT
         jX9yVDOuX903W3UU+ufYJEd29u4BdvBSt4EQ/XHvlKr2/aSPnmwGipj6Cp43VirfPz
         04qpmEu+JZgwBBpXBtTGlf8N5XO16H3T5kbEIwek=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LgISa-1iCoDd2NMK-00ngTo; Mon, 29
 Jul 2019 15:47:15 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
 <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org>
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
Message-ID: <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
Date:   Mon, 29 Jul 2019 21:47:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l5h42KyqXoUV1gijRhd3Eimi/lyikpX6qZhnOI+sq21BbXQ9uXd
 ve6fQ04yH2cd+qV/A/BM7Jpj6IEFgPQHnA+Mj2fQzkTsrpUQ2EcCcDsmpxiSh/GuYSvxf42
 ceM4k8iuge3zQcawBigMrM+u75LFldDxzN6f3YhEHKfeqzMB4usWlpdXi9D3+v4ChmlRIz0
 gN2aFFOYs0DT9LYMrNCQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nebm1u/V1GA=:l+Vgx4WWG8gAecchcWlaD2
 tPp/djEtkNZl+CBCHGwRumW41gSMhZSId6k6qUlHugnwGD7Yv82c63akC1HIwddmw+B+8UFUI
 xW2sEEmUcYstQUnF8gm97pjRDjkB2vHwA5pulVXLOgh9yQL+PcJiQze8kPp3Sca1FlM0eTrMx
 iGOuPo4oQaoheBBVbt+l9ckwZ0kVdQ2mTSHW5ihOr2RU413CFPKvJqFWmm/kELNwt0FWkvKQn
 7NJfLQ7RoIDnNO96hAn8CwXwSIUfGWcoH1g4+xLzQpPKprIaPT+nJ7i8cnkMzaTikurk8MrsD
 H0p3iXR9OnX5IJkl2fzo0MZSp0IViatEeUsxHS3BoYExrFE/tMrBEtL7nl5Wr4/NjCInDa8cU
 Zjc4bx5lO2vMh/EpQBa8jsVT1DhCv/aKWupRe0DpxqFZDxfvgKsk04n0VDSYB1Ov7eeCKrXuV
 lIH0g5foHWLQmEiOwSHUwGdsK+ZwWIj4KWzlIuoXXuYo+Nj6nGLDZastJasR7sEstFv5d/kVP
 ralDpJFw2Oog+6aRl8YOzemeQsD5NiBwg2QLZSBMHjnO49cLp3lbRms6negtaKgt1NszbK3g9
 nJgC+JFeb3lZbYEQegg3aHwGDq461GINe5TIbxC1Q4Ori1sjZrUDZfngGSWzyP4hVnvM/5DYO
 mlNTn32hIkpNMxB5c4//5jHCfpuv1QFEsICQPntJsBEnQreuLhHBdKx6Mj1O4uFgqCHNHdjMa
 ydv9blWm08jYKdhj9IvVH0o/lEj6qUwgyzoucvLPIxcJfgsRo8RTGycKrQc9vvuxJL0Fmi5x3
 HnJBmae3D14KoZVLJowHhHLuzg8qANL15V4gwpygejOxBSBX37I4El+wQhJ78KeCYNRjc81ka
 EzGKJigN4rigsT+ekMJPQX9b+Lhji1qYAmI92Or91/Bolxb+k4kq79cTcmmyTIzyA5tfsaP2+
 bvAvmNZxw8F5C2gTJAFDOnmMo1aFn+oPLizYQ1aZh57xRvhkr2hpMRfDMKaYzlFb3y+b27Iw7
 MUV5+a6uaJEsccu3K9v2FFGk0ihLxL3N6h8P9uryzp4t+YI7++vjEhRQPvLGPJwqJAIr07Qzu
 Npok3xyt7HCKGlEwKDc+BCNmHnQ7Ngsn5m9
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=889:42, Sw=C3=A2mi Petaramesh wrote:
>
> Le 29/07/2019 =C3=A0 15:35, Qu Wenruo a =C3=A9crit=C2=A0:
>> This means btrfs metadata CoW is broken.
>
> I remember having had exactly the same kind of messages on the main
> machine's SSD a week ago (before I had to recreate, backup and restore i=
t)
>
>> Did the system went through some power loss?
>
> No *THIS* filesystem is an external backup. It's typical use is plug,
> backup, umount (properly), unplug.
>
> So there's very little reasons such a filsystem would en up broken.
>
>> If not, then it's btrfs or lower layer causing the problem.
>>
>> Did you have any btrfs without LUKS?
>
> Not much...
>
> Here's the rest of the (still running) btrsf check :
>
> # btrfs check /dev/mapper/luks-UUID
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks-UUID
> UUID: =3D=3Dsomehing=3D=3D
> [1/7] checking root items
> [2/7] checking extents
> parent transid verify failed on 2137144377344 wanted 7684 found 7499
> parent transid verify failed on 2137144377344 wanted 7684 found 7499
> parent transid verify failed on 2137144377344 wanted 7684 found 7499
> Ignoring transid failure
> leaf parent key incorrect 2137144377344
> bad block 2137144377344

All these are the same problem, one tree block didn't went through CoW,
and overwritten some existing data.>
>
> Uh I'm at a loss...

Although there are some bug fixes queued for stable, it doesn't look
like related to such CoW breakage.

Thus we need to rule out lower layer bugs to make sure it's btrfs
causing the problem.

Thanks,
Qu

>
> =E0=A5=90
>
