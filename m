Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925837AAB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 16:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfG3OQ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 10:16:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:53557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfG3OQz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 10:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564496211;
        bh=I8Jc1ES8RcfRSf551eJSPN4ofjstLmdeB3qcSjO24t4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a6DTLkEUX9sDyLeSrFp2UMi48yPjnlP2SDscvhuvuClAU7IssTUeI38mc9Zq8ZVkZ
         wEjYKqdkj1amA0Yn563dcmhk0ZT/rG+6nJyfZpjcS7g4tk387bBs/J1wJvOGRY1oIL
         baWLXPIEo31Rpg5XDKstf3KxNjGYkw3lL8wTEF70=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfpOd-1iYfN23zBJ-00gGDf; Tue, 30
 Jul 2019 16:16:51 +0200
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     linux-btrfs@vger.kernel.org
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <daeb4767-b113-f945-da67-61d250fa1663@petaramesh.org>
 <d9ea9623-657e-0315-7166-b7f58b32d4e0@gmx.com>
 <4776e0bd-83c2-44a1-4403-3a155fe3f6c7@gmx.com>
 <508c6378-522a-ae24-6c33-83c8efc64ae5@petaramesh.org>
 <83294063-9f98-71ab-428b-e2251b96e5b9@gmx.com>
 <bc23aa4a-2240-80d6-c2c2-d060191f884b@petaramesh.org>
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
Message-ID: <afa404af-1365-9763-b0e7-7a5a088f4d49@gmx.com>
Date:   Tue, 30 Jul 2019 22:16:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bc23aa4a-2240-80d6-c2c2-d060191f884b@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UOzgGoSHI2ZY6PSdUK5zhRgiwNx24p0/iQx21jTvov2X99ZOzkt
 JV/++lNGrkppASv4HABOzCVOPJghjE8P//QVw9rtPV1lQZm4r7n6T1Bg9g7Jk2iZ/s23J+8
 sgY/aPgTS71z9W8EjmjshO1sn1TESNgDvMOK2qW4ESOVzOegfvO0wAjPOq7ZjLDZUyhpgqo
 U/61BmRtD/lfq68ni/33g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:p8IxnHZQlu4=:wA8AvB5YPot6cYySiQkYZP
 pqNNJpg4WLQJdcZP+xC/HCnZfsFMGahvtZBGN27B1jSZJ7h8iSEM0wjNv4iVXmvJ6K9TteDf3
 tWVwZFTrzj5CMUCHyYEJYy0nzqFwd+E6tW0n/xHzmPZVAVvArWle0s12gvuvY/61Xrn6WBJCZ
 fzOce0ff0P6OO5i8IQn+tPyF6OLMoHIum9VriYkP7z5XIHotuzhum8g+vvhHJcKTAGda0SD1W
 STs1X4aZR14tVLYNshiBpxKuyDOJ+9rNh8jb3HHrZxkmqYOyI2e0Nc/zOODW7yyCVjdNCSXYN
 tiwGTBJx/M3NTTj/JFwe2UszIvPcVlIb93qwmKTZ+JHvx/VDrPWPGFk5KuDD5mlxs4xG7zyj2
 4S30rjgTEKp1B91X2iQqmV3bB3BVVSbWP1iBa83DEi3fNJUY15scU12UQapCgrn4upVVA0Srz
 yNHPXBeWBNOv8hDp6DgU7XRGGgYKTg/OColKzg4SP1ejb6FlijtO79QX7Nti4XjptjuDjyfbO
 jgL2TPA0f/csO5Kezi680xFpgUEU9X68d/Bumj2iN00Q9uAXfdMIdwrwQZgJvAlWSf1Igno0m
 apJ54/JZUZrXOxu0eRJJneLKDIf/V04Y6kL/kPokFdzIbMfRjlucwoJAq3UaXIX6VTvd6afgi
 gV8yRxjWOPcV6oGP4YnW8agdPW1UkH/iSu4EjE6kCvpSd87paXzrCsS/rCDDs4Edd7qCwjfD6
 4FHfG82lJT9tzYptpTSBGQPLSDKu6+SaUeoC1QZ2M0E8DCb9yUUAWs7St6g1lDbzn+DJi+x62
 QcnIfK4t0OzA14b9LpKyLe3eeDW8hYraaTsw+mWcIJPop3pZckILBJbvJIhKEy8qrKU4GwplZ
 QHT+xAuxoGbw2GqAd5hcQViI+rpfQPQdxJ17O9CebZEWPMU7eElmrqo11jmz9sQVyAwi7/HYU
 64ZiQBTanxrw+Lt4kIrzojwor0c4T99mTXuydTkuw9dDLH6NofaG5dlMYP4wOggdTzsxJg8PU
 JeQ/HwxCU4FYjaLsIt5W0dVRJViUTBHuvWJdSFrIrG0BUEEVF7wWZ6bo6KmxqiLysfHAMTcGF
 ygHEWN32L+X40EOWfF1nK7UAVFl/pqw6sMQ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/30 =E4=B8=8B=E5=8D=889:57, Sw=C3=A2mi Petaramesh wrote:
> Hello,
>
> Le 30/07/2019 =C3=A0 09:21, Qu Wenruo a =C3=A9crit=C2=A0:
>> Unfortunately, transid error here helps nothing.
>
> Now, each and everytime I try to mount this disk on the original
> machine, or another one, I get :

When the message shows, it means the damage is already done *BEFORE*.

Really nothing to do with your current kernel version.

If it's the fault of btrfs or device mapper, then it's related to the
kernel used in last unmount (if unmounted cleanly) or last unclean
shutdown before hitting this error.

If it's the hardware, you'd check if your disk has unreliable flush/fua
behavior, then different kernel may have some difference in how it's
affected, but nothing can save you.

>
> systemd[1]: run-media-xxxxxxxxxxxxxxxx.mount: Succeeded.
> kernel: BTRFS info (device dm-2): disk space caching is enabled
> kernel: BTRFS info (device dm-2): has skinny extents
> kernel: BTRFS error (device dm-2): parent transid verify failed on
> 2137144377344 wanted 7684 found 7499
> kernel: BTRFS error (device dm-2): parent transid verify failed on
> 2137144377344 wanted 7684 found 7499
> kernel: BTRFS error (device dm-2): parent transid verify failed on
> 2137144377344 wanted 7684 found 7499
> kernel: BTRFS: error (device dm-2) in btrfs_drop_snapshot:9465: errno=3D=
-5
> IO failure
> kernel: BTRFS info (device dm-2): forced readonly
>
> (It first appears to mount OK, then the errors follow a few seconds
> afterwards, and the it remounts readonly).
>
> The "7499" displays seems to correspond to the most recent snapshot
> created on the disk (using btrfs su li).
>
> Is there any way I could repair this several-TB FS, ever if it implies
> losing the latest (or a few of the latest) created subvols and snapshots=
 ?

Short answer: no.

If you want to recover to a rw mountable fs and pass btrfs check, the
chance is very low, as the corruption happens in extent tree, an
essential tree to write operations.
Corruption there is not easy to repair to pass btrfs check again.

Thanks,
Qu

>
> TIA.
>
> Kind regards.
>
