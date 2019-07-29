Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A7E78D77
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 16:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfG2OIh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 10:08:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:41769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbfG2OIh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 10:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564409316;
        bh=JWZQZpCn2R1zyEBkHIef/XcO11rIvTfMRXJ6l8mvIkE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LX7AJtAFvPiaqY2oV0GHVi+hDumSKIl5yYqw+8mEGZvx3ii3SCFuyH32oyXusl/6p
         gCNGXOs6mssDWLyHOvyj0a9NGznAoDIZrBTd/+kuY2vNdq3Ojmun2FpoYP5oPJDQG1
         GKjPm9vFspcBvsKWRcF1Viwhsp3S/0wHBrMHhHeI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LpPg1-1iLuhq1Iov-00f8y0; Mon, 29
 Jul 2019 16:08:36 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
 <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org>
 <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org>
 <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
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
Message-ID: <71bc824e-1462-50ef-19b1-848c5eb0439d@gmx.com>
Date:   Mon, 29 Jul 2019 22:08:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OUiuMMHowlxIuNlj445jsoD5amadBw4onr6xqaNTsmBSXbG87CL
 YL5cN33y4C50bVsxFg+OQQuED7yMKrHDOVQ0YyXkVCj6B9lwpHTtmyW0q3XESeLP54SabSA
 ttHxjscdPlfQGEVgMMXpYqK4UHiaPF+J4dtYvLj/bbMuOqO9gf80L8PiSsayXMgezpq+K1A
 7/8ERfEzoaFekgYWEyY6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+dvGsjq0cBM=:zp1f+WWYqLa0UKD84u13Rh
 vkUp7Xuaw7pRCWAL3C8MfGcxrmkgrrr1sObMQJDL6Hg5Hri13RaiWSLIn2kj3iaBmjjGrh1N1
 Dm4uuJHu02jUJE6W/y/h1r+GgscZRNwYxXjh5UXn5e5ZEkDmY11e3Ii/ywOVHSV4fJwg9L12n
 lq80kIrn4/OMZQYXFMyIXsgLSelcxb+uSP/WfxQKUeP2UGR/0dtDnU4fLuFJNrT0qphUSaf1c
 /JJAQP1Y6DDqTmGJQTR4FoufazfUGpjzWqpQmA21llK+k/EaLZEqLBiCo0vGEm4k1EBkfrIYV
 YeoLenHu+9NJIcrHwCr7NSy0p7N2gzGciB1b0YsEJdNP3DdvXmZrsnbA6GKS6iX/UCpmyRAKB
 rynmo/Ty0uJnoe1ofnJtdpHZanqgD2zyo8x6fH8kjRdAo+ur9Os7MAudi1JJpT9ROqJMppC9z
 knJK2q/Ic8r7l+UNqTdXmDvCb3KxgtlJDwHmEq41o2BqttmhGBJmud/l+69srgN/ZBWdaVK+2
 SSZBcjUXaCjPTcGrhd8ppBXI+5ASebQ4bTI9umZGKodzYb0S4X9oic8rZ3E2h0N47V/2ydRLH
 9DUHrPdqb1XUqG28J0s8N4wNlUa8TGnIhexRK+LAyHkXGdjIVN/wWKOtm//lcgjg1W2aMjtKm
 Drq54SpL0/ABv2FLVYBPItpAcLiL+4eZRAYn+wfftwR4nEUEaxupIXpF8VwpFFFs5EnUfdrNd
 L9ymJfX8VBZeDSNJg4AiSCTfd5znfZvaqXvTLhwqQ7O7y1uLsbjgnHFfq3O4WAHofXF+1Dl+s
 +yM3MnD+62sV3za3I207+SeM8AUPelq6EmpyyqoRtv5gVu9doWhJmHvAapguCxfATB00V5fwl
 /mBJRSRdTW4wV9ez75FsAk4VIegERzzT76Izlf3pFCb0HjwlVRVMUyCPm1vtYl2xzqfIy1hUM
 w1U8tHcLR0y+EcwsLj1MTT6tpRRcDCmYggF+yrE4nDq3QNT4xrPPeL9QE8M6N4qwXLqCJ85+C
 J9SvDIveki+QP/NdI3PQ579B6OwEet3Z0Dc3DbENnd2Y8A7q86etWGaMZkxqu7xhX3No7Y3FU
 Fu1pRcId46tZpKemm/3r7GVks0uRFqZTWFl
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=8810:01, Sw=C3=A2mi Petaramesh wrote:
> Le 29/07/2019 =C3=A0 15:52, Sw=C3=A2mi Petaramesh a =C3=A9crit=C2=A0:
>>
>> Please tell me how I could help.
>
> Here is the complete output of BTRFS check, ressembling exactly to what
> I saw on the 1st disk that broke.
>
> QUESTION : If I run =C2=AB btrfs check =C2=BB in repair mode, is there a=
ny hope it
> will repair the FS properly - I can afford to lose the damaged files,
> that's not a problem for me.

You don't need to repair.

The corruption is in extent tree, to read data out you don't need extent
tree at all.

You can experiment with the following patchset:
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D130637

>
>
...
> Wrong key of child node/leaf, wanted: (1797454, 96, 23), have:
> (18446744073709551606, 128, 2538887163904)

Unfortunately, some of your fs tree is also corrupted during that CoW
breakage.

The following output is your the corrupted files.

> root 2815 inode 1797454 errors 200, dir isize wrong
> root 2815 inode 1797455 errors 2001, no inode item, link count wrong
> 	unresolved ref dir 1767611 index 5 namelen 2 name fs filetype 2 errors
> 4, no inode ref
[...]
> ERROR: errors found in fs roots

But I'd say you would have a good chance to salvage a lot of data at least=
.

BTW, --repair may help, but won't be any better than that skip_bg
rescue, you won't have much chance other than salvaging data.

Thanks,
Qu

> found 1681780068352 bytes used, error(s) found
> total csum bytes: 1634102612
> total tree bytes: 7675002880
> total fs tree bytes: 5528207360
> total extent tree bytes: 374669312
> btree space waste bytes: 1041372744
> file data blocks allocated: 2247597993984
>  referenced 1803060187136
> root:~#
>
> =E0=A5=90
>
