Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820657A02E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 06:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfG3E4e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 00:56:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:32913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbfG3E4e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 00:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564462592;
        bh=RaVKBIaZCFDtQ3OY08hBjS469HyUlIPJOPbelrVYdUQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=YqXr+3oG3lBxIA4M4fu34cKwr3Tcjh/l3nKQDOQLKtB2n/pw17kRmL7qeirJFc6OT
         PbjK2kCvJtupoHbLDuB00LmBB8HRbtJgOBjytylHnusI6GwI5iy47foB6IH6IbfAOf
         4L+/o0fDFWqqyPN6TzO0AEb/3r+R/I5YnkoMsczI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LreCz-1iWYnD0CBJ-013Qho; Tue, 30
 Jul 2019 06:56:32 +0200
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        alexander.wetzel@web.de
Cc:     linux-btrfs@vger.kernel.org
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <daeb4767-b113-f945-da67-61d250fa1663@petaramesh.org>
 <d9ea9623-657e-0315-7166-b7f58b32d4e0@gmx.com>
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
Message-ID: <4776e0bd-83c2-44a1-4403-3a155fe3f6c7@gmx.com>
Date:   Tue, 30 Jul 2019 12:56:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d9ea9623-657e-0315-7166-b7f58b32d4e0@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AVQfX73YcUJxqlCCEVgNzkGpaeSX6IjEXaCQF2YV+zPsfc4vBSE
 k8hw4I7sOejvWUdYgtwT76yfeXnREasVFGdvwqHFsl2KFZvYEpX3v0qPrcReP5PH7g0fuLJ
 U8em0pM5jwmicaMpV6tlyWU65fr5tltsblswV+eTF0F+xAurBAmvITPJCnWkS0Fq4eahDty
 dB6aS9Q597A+/+/OR+PUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qF+DdL+ZnH8=:kdRiI0/c8dLVwDOf4RFe6C
 OEFDAXCq5PyySjwrrY9BZyymYqxyKiOmLXhZrP7995JfcBRSsJfRoojpas89YHirs4mHOdJVm
 QeC2cViTX0bf61BXE4Va4QoLR6VUby0Hq2cwDGos408vDmoW+yggRURoEpqm6ySlJTkwXDLot
 1KAZkgaoGejESaTtn+WgApu4Yt4WDDzVsRQWZZXOIHETWWVec6ukYh7vHRiZt29MEGEo/aT8a
 CuziLrJMZD+XG+9T4wtpqdMmBO0LXAVVC/Goey7CLRtbc3Njf5BdWTdFqo809LWNgrPQv0JJ1
 BcZej0jmvwSEGBMm7EjLpb/bcwHTFZgsA9bRk+Ka8UXMEvEWEDhMHrs291HaIj26rB6IdyftC
 8QgKyjNzXshS3+B04pEI+6M2uukEojoayZJIsOK2kkJRtR27eLImzHjkIn5AzCoOTpHiL0GPy
 oRyRTgkRpdWxEzIJUI3vpWRM2dO9K/mxUOIxz274Yo5+qfz0nyMl2RvG87/CmjoAg1VEh3pNH
 EAWXaps9RZCaJnTjeFBU9kJJXIH2VrD/S7WimXIMsU6CEzkOABZ6cKeFVP80HzswSOevUzgK5
 Lm9q+sy7sX5kvrwxTnslhkzoMf1cKXWE95Kkc+eWjkX5tAACCmw3hQ4qiM9xYRkV5NK+JJBRn
 FcAfocNStokMXVZwQ8y6St9dtAss2hcQszs75SVt9QRlku6il4nsB9yEAVBvOcq+6lwxvu+5H
 aT37DP0gmNydzIuHpB5cV80D6dBs9lCTSTQMxAAMe8IOP3Vg3B8leCg68DXlvanRnsUmwH58A
 H/ig44qTj7+HroP6HK4vRLsl3oz+w2a9mqNrvU5PRvfNGOX8sNnFy/XZwu6n3CluHvpINulqa
 OWLtjLwRfGljFgCcArgH7tVSirW7e9YFYyQwQJHcSdgAbX9VPBas9TIiVN3F5W57dZXMrrwSm
 0rIigrYdPSGkh3oAnLCVpkXkUGe7pPVOF/ZX8IVhNcomW/wi8IHzyeJenX5n/pLZfEwgnrDZJ
 4z28H/KS7dMyVrJOFrmOMO60DHbftPnGN5vpTVLFt0NRhBwZ+rAK05cCBRH0jBlkNKnbjdoG9
 H/qcezDaD3B/jeuG589kAl7zEJpyB/U/d4D
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=889:33, Qu Wenruo wrote:
>
>
> On 2019/7/29 =E4=B8=8B=E5=8D=888:46, Sw=C3=A2mi Petaramesh wrote:
>> Hi,
>>
>> The corruption issue that you report just after upgrading to kernel 5.2
>> resembles very much to what I had on 2 filesystems after such an upgrad=
e.
>>
>> I think I'me gonna emergency downgrade all my BTRFS machines to kernel
>> 5.1 before they break ,-(
>
> Full kernel message please.
>
> That commit is designed to corrupted inode item, we need more info to
> determine if it's a real corruption or not.
>
> Thanks,
> Qu

Ping? If you really want to solve the problem, please provide the full
kernel message.

Thanks,
Qu
>
>>
>>
>> =E0=A5=90
>>
