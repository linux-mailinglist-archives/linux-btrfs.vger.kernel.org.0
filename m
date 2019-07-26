Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B5275F23
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 08:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfGZGg3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 02:36:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:51941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGZGg2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 02:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564122977;
        bh=EoA9fCsbEsS+99m+hr2YAnfrHzwR0hKWREQI4VJ6dwU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TyHvGVQ824xBu8CbJe3lHEH3fOiP2+F7A78IZIbm8L5MO2gi3E++41eeF4es0lnfb
         JoAoXriJB6rtxiD98+GqekW/ZJzZVXa+LPoB8jhArzbKBpi3VTcG7aSgrWZJoHmUCy
         nlcIsnXGEX+WE7MlvE2KTJwS9HJ0nuRx+sE0d86E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4zAs-1iZxTA1PMq-010u9I; Fri, 26
 Jul 2019 08:36:17 +0200
Subject: Re: [PATCH] btrfs: fix extent buffer read/write range checks
To:     Naohiro Aota <naohiro.aota@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20190726052724.12338-1-naohiro.aota@wdc.com>
 <d81154a4-dd3f-481f-92cb-25ea32b55900@suse.com>
 <20190726061300.gvwypjd32elqtkhu@naota.dhcp.fujisawa.hgst.com>
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
Message-ID: <71f0399e-0719-ca8c-cb7b-aba5de5d0c5a@gmx.com>
Date:   Fri, 26 Jul 2019 14:36:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726061300.gvwypjd32elqtkhu@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FhML8DEnsUcoxEx8ntivZ1syMVtMDiDGacMf21c8obQHPjlI772
 scZe1SNgO+/yYhp+QLYQiLQcHtUMa104b9A64LYbqUoAo1sdToMLB1tRReJh0Veo6IuWYwP
 9sXzTy5PuI68FinhL6r82U6O0WJn2Qj2q2vu/pRzOV7oJapEOJ8/UuTLCkLyObMjZ0bx3eV
 +Z7h5WnmA+0H+uBMd1kBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gFmZl9yOly8=:46/0bw8fYqK11HH1SkgJ95
 SaBm+ahQKOz6jI0a8xOI2N8wngYOUZby00JJxCLYtvkhI0nIsgA4j4jkijkZBGJocF7VPoZ+M
 DapkiMr/f/9MgZDPwN+EguKMEFlry8wKpsDShGv9lHXWvqnTEkoa7wsP1XAESo/dM/gKsXFkT
 FhWm/cP0/uKujxFA9C1TXEgsPMM8Js6O/XFpQgIl1LMocbiDKzrFtF38b56iG+w2H7nLNI8Tv
 ay47luRibPeulZnddUmNFC6BakPzf2cJ9/YUHZ9mntsc6KXcs9Mnr0lRStkv6Izzm4kr+7ns7
 QtY2V+Rg4ELD31DGPfAJUtOKQQgcfb/4GdcFWS9LjzTTC6L+78+ik5etl/k5Hv3gSfc3XVD7w
 9eQR5e85Es7BnRKopYb1kg4psGl7QguXa6Q2Okf4NuCAcLiGaYoecCTQLFOqqC57TIwEg+7aX
 wcGoKT2YiHlrpr15/ez4uDmd/E1H2xPGvmVhCm9GhIUSFl7Z5pjLw1cJxWLhNIPe62MhHYGVE
 DV1z1AiHPvJTsww4Ly8q2FCpP/ygBtjBYstjogff7H+Mhi6kdzkiF8FmhRTHAJew2C/JDJzW0
 EzEwPRshhPORgigGredBdl1r7lfzxS3lKG05cCjn2VITqKDoFrnHAvQW8nPfrNUu3ldNnpaBh
 Mck65yGJsng+Zrry5XvuvS2IoMpYV61HMf2AeOD4PWS+yF2WpneCrem+o5d63yV0VliyPRbF6
 Lcf1RXQsQCZfb2JuI3qNb74JIP/ogUAVgkoJbyUlZknuJSr4uPqU7f6FCWrvQHfRiGyjVf0n1
 JO+R/W0ArvZiEp9BmavjiAUn3CbspQh0+2Wi4AuVVEiw37Hw5tgIRQAxE61L3MqQpgW1eXyDJ
 oVElkSFpI1ocsL74+e2lQImhdzcyHoXKzk9SG1Pd9eiQep9+DrGq6XOkijxMJRX8/aaci5QPQ
 a1iV45ZmPp5+wKMf10qVOHge1X2yJkU8BLBEqQufBR4mXLjwM3CGbA1Koh/SutjTqbOIlkKbe
 c4PLwugjKghlbxRAGRpbuBopUyFjujMnypKwnp205jiqL4Ny/H9XhG7oD3jN7fIgysiuxhldI
 wOupRpm1E1Q5755WhbWCNjRfoD+NXWvDy25
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/26 =E4=B8=8B=E5=8D=882:13, Naohiro Aota wrote:
> On Fri, Jul 26, 2019 at 08:38:27AM +0300, Nikolay Borisov wrote:
>>
>>
>> On 26.07.19 =D0=B3. 8:27 =D1=87., Naohiro Aota wrote:
>>> Several functions to read/write an extent buffer check if specified
>>> offset
>>> range resides in the size of the extent buffer. However, those checks
>>> have
>>> two problems:
>>>
>>> (1) they don't catch "start =3D=3D eb->len" case.
>>> (2) it checks offset in extent buffer against logical address using
>>> =C2=A0=C2=A0=C2=A0 eb->start.
>>>
>>> Generally, eb->start is much larger than the offset, so the second
>>> WARN_ON
>>> was almost useless.
>>>
>>> Fix these problems in read_extent_buffer_to_user(),
>>> {memcmp,write,memzero}_extent_buffer().
>>>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>
>> Qu already sent similar patch:
>>
>> [PATCH v2 1/5] btrfs: extent_io: Do extra check for extent buffer read
>> write functions
>>
>>
>> He centralised the checking code, your >=3D fixes though should be merg=
ed
>> there.
>
> Oops, I missed that series. Thank you for pointing out. Then, this
> should be merged into Qu's version.
>
> Qu, could you pick the change from "start > eb->len" to "start >=3D eb->=
len"?

start >=3D eb->len is not always invalid.

start =3D=3D eb->len while len =3D=3D 0 is still valid.

Or should we also warn such bad practice?

Thanks,
Qu

>
>>
>>
>>> ---
>>> =C2=A0fs/btrfs/extent_io.c | 16 ++++++++--------
>>> =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 50cbaf1dad5b..c0174f530568 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -5545,8 +5545,8 @@ int read_extent_buffer_to_user(const struct
>>> extent_buffer *eb,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 unsigned long i =3D (start_offset + start) >>=
 PAGE_SHIFT;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>
>>> -=C2=A0=C2=A0=C2=A0 WARN_ON(start > eb->len);
>>> -=C2=A0=C2=A0=C2=A0 WARN_ON(start + len > eb->start + eb->len);
>>> +=C2=A0=C2=A0=C2=A0 WARN_ON(start >=3D eb->len);
>>> +=C2=A0=C2=A0=C2=A0 WARN_ON(start + len > eb->len);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 offset =3D offset_in_page(start_offset + star=
t);
>>>
>>> @@ -5623,8 +5623,8 @@ int memcmp_extent_buffer(const struct
>>> extent_buffer *eb, const void *ptrv,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 unsigned long i =3D (start_offset + start) >>=
 PAGE_SHIFT;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>
>>> -=C2=A0=C2=A0=C2=A0 WARN_ON(start > eb->len);
>>> -=C2=A0=C2=A0=C2=A0 WARN_ON(start + len > eb->start + eb->len);
>>> +=C2=A0=C2=A0=C2=A0 WARN_ON(start >=3D eb->len);
>>> +=C2=A0=C2=A0=C2=A0 WARN_ON(start + len > eb->len);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 offset =3D offset_in_page(start_offset + star=
t);
>>>
>>> @@ -5678,8 +5678,8 @@ void write_extent_buffer(struct extent_buffer
>>> *eb, const void *srcv,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 size_t start_offset =3D offset_in_page(eb->st=
art);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 unsigned long i =3D (start_offset + start) >>=
 PAGE_SHIFT;
>>>
>>> -=C2=A0=C2=A0=C2=A0 WARN_ON(start > eb->len);
>>> -=C2=A0=C2=A0=C2=A0 WARN_ON(start + len > eb->start + eb->len);
>>> +=C2=A0=C2=A0=C2=A0 WARN_ON(start >=3D eb->len);
>>> +=C2=A0=C2=A0=C2=A0 WARN_ON(start + len > eb->len);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 offset =3D offset_in_page(start_offset + star=
t);
>>>
>>> @@ -5708,8 +5708,8 @@ void memzero_extent_buffer(struct extent_buffer
>>> *eb, unsigned long start,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 size_t start_offset =3D offset_in_page(eb->st=
art);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 unsigned long i =3D (start_offset + start) >>=
 PAGE_SHIFT;
>>>
>>> -=C2=A0=C2=A0=C2=A0 WARN_ON(start > eb->len);
>>> -=C2=A0=C2=A0=C2=A0 WARN_ON(start + len > eb->start + eb->len);
>>> +=C2=A0=C2=A0=C2=A0 WARN_ON(start >=3D eb->len);
>>> +=C2=A0=C2=A0=C2=A0 WARN_ON(start + len > eb->len);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 offset =3D offset_in_page(start_offset + star=
t);
>>>
>>>
