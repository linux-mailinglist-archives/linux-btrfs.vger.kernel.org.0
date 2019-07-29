Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BD278CF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbfG2Nfy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 09:35:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:53773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387638AbfG2Nfy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 09:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564407351;
        bh=2hCluCX4mg/z/nBhShWTO8DiqzAohDvB/LQIQhuzXg0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=S0zP6bdJXRkGqmploS5mHTeRxfh8JQt5rEpmnV4JdeIkHBJ+rXH6TSBKtMeV5CMiu
         nZEEc6vfs+mpLCuuhlBWjnJPJPI6LXUqURPL42qGEn32DC90p4dn/6F+DGfWADizVJ
         vJMzUo6F6MWmv3JIR0XK1TXC7q6zueYaSYRBEjvY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsEn-1ihItF3jfz-00sygs; Mon, 29
 Jul 2019 15:35:51 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
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
Message-ID: <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
Date:   Mon, 29 Jul 2019 21:35:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cYxjNUDve39xOxB+ZQ/jBee6fsr4mKParJ9YKeKZ25Akc6Ng8KG
 g2lDYJ7FAuforM+m5REk0yXSo93lvo+k2A3OZYrTt8aom3F14+Vdt9LIt47znzyYAQx9byF
 /614112ZKQhfR+a90PgFNFPtCcv6mSWGKGe55bQ+ggFgMoZVdFGS4byuH7jC3Gy+dbRU4x+
 765VRvI1BFXrLCaRdP/1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:euQNsr/7RZk=:DeDrTVjMU1Kkwz9484PKFL
 PuMW+Q9FcqEbupihLZ44k1mY9C+pcJcoMjVlQ/NewN6oVScpLF9oGEbdGCFpkN7BcToja8j3X
 mnt1ebJ0mQejdDZuSTLi4U/FsZCrmNZsktprLWrQ4mSlUcPzZVhkVRr97Mfvhm73hL0pWGDg9
 cr5Qs/umKHLO0ptUnjzJV78+STLRTfO50scpqqMKGWgY4AhXFk61r+79IBGDXnNU9SCrBGQXz
 rtcKepRXC950uF7FWjorGiOrVdjf5HfLil05JZDAa7Na9KOGXiU5eZ6Rb6HIE26hlx3gonwl0
 f+qPVTZ2BjLc+aFul02xGzphWeQWQucVKk3KOjIuV0n0197n0tDKrEX+Xbwe6674LBmv4kxB+
 3KKZd0BrT15BhOxIgeRJDxEnt8biw7J/xxKeUfsYCII/k7ARu3U5FLieku/SfpY1JDkhsTvJ4
 OYaeXZ+NWD4kTzLOskeZLU+kFTyj0i3RR8Cw8Hlsn7+8X25Gf18kXyifkHij97RTmMeevBhL2
 czSwiF5hUDUKaHj1yYm5Dv+pyX5Fo5689nKgw83WvvZwCwy4ryzcjJrp52PDnJzma96awgntC
 /sCPozyY9O8V2DTadAodjFuBFcIeXyfou+tC4lra+f4TJCJWnZS8PzkQuP2UpCmjCTHNfQgUt
 jCWy5sDQYxEbBZHOhvr+J1DezjKmWd4D0FSF/lOyIDy8BNrEPyjbD0B4UF/HJrMoj/n0TCoUC
 Oe3r65KabkH823yjJfcP5Bl1JNhbGg9gg2pdRJKNOYCjKxRYO2gtaUM6Z7+E5Ma79tvtTghJT
 H4tT7vQ/t23jibZfRH2qmwg0Tm3t8bs+kvkO5UlrDaDSYkBnUL8uNYxmP+YCkx3YsYdoISkRw
 2ljOCjVhXbix95NXaTbmpiejTesgDflLk2zuLEewTIg/mLEAsQAHriWNJgn+j85xuynkIl2kB
 bNfPRkaNBcsPToh//x3p3pDHDZIy42g1oM+fKXlzvtQGdTdbldM7jC3LmlXhCPUBxU/kXg28i
 X3dvMtlMy7EKk60yBieNXFtNEgcmwLv+SvZFg+jILrbHpV3kzXlkowwXbzkWIuAaRxOjIAFCf
 FcgJ2vgM+kiczXswUj3yQpkAOwbnRc3lqVS
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=889:02, Sw=C3=A2mi Petaramesh wrote:
> Le 29/07/2019 =C3=A0 14:32, Sw=C3=A2mi Petaramesh a =C3=A9crit=C2=A0:
>>
>> Today, same machine, but this time my external BTRFS (over LUKS) backup
>> USB HDD went corrupt the same.
>
> btrfs check reports as follows :
>
> # btrfs check /dev/mapper/luks-UUID
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks-UUID
> UUID: ---Something---
> [1/7] checking root items
> [2/7] checking extents
> parent transid verify failed on 2137144377344 wanted 7684 found 7499
> parent transid verify failed on 2137144377344 wanted 7684 found 7499
> parent transid verify failed on 2137144377344 wanted 7684 found 7499

This means btrfs metadata CoW is broken.

Did the system went through some power loss?
If not, then it's btrfs or lower layer causing the problem.

Did you have any btrfs without LUKS?

Thanks,
Qu


> Ignoring transid failure
> leaf parent key incorrect 2137144377344
> bad block 2137144377344
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
>
> (Still running)
>
> =E0=A5=90
>
