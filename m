Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB93F234EA5
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Aug 2020 01:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgGaXhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 19:37:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:48093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgGaXhV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 19:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596238638;
        bh=gwvFFwASnkFKlVMp94dfXvpH5+YF5p6Gj5WAz875PP0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=T6pAln5xlvw1wRU1ZmJmUASa/AtjDQ5G6LLd/rTXY5mbvD2S6BIBI2HXrCw+rzg8f
         HfvrLp/+R3mm370zOpO3Sbylinjh3szMfwEqHieTfzlDt8KCfn80nOITw3+OnXqB2K
         SLKPvUcY3SDfSHz+dIJagNNmjD52RZa6rC9oKcMA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Z5-1kxcZ40wrL-00wBkK; Sat, 01
 Aug 2020 01:37:17 +0200
Subject: Re: [PATCH 0/3] btrfs-progs: convert: better ENOSPC handling
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200729084038.78151-1-wqu@suse.com>
 <20200731161634.GP3703@twin.jikos.cz>
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
Message-ID: <15958814-4956-12bd-3297-0ce3bc495a87@gmx.com>
Date:   Sat, 1 Aug 2020 07:37:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731161634.GP3703@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XR8fCFWXpxMlL8LURJLDIruTRIGubgByO"
X-Provags-ID: V03:K1:PwWvJRSCQAVem5RqpBmp0exRN9uup2TCEMQ1T5Ct5seYFtdhvqi
 l83qm2GTvscnONeXWR+GsWroPdjtkvAdyreTca6i7usXKAppfxnk/VIT+2Nnhm//QjloYXF
 v48jkbaj9bwa+Zfco78awSbltmpqtJBgSob+cFZoVRbtU9BgNDo4lCOh2o60SUZETrMBZT4
 bXrL/zGuu5eW15J2Bo5dw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ETPGO+hDXpo=:lGSUilBAbulsc/LG6Pl/Yg
 Z/AUEyAqGtJ8g9DAGxGKjZDuWT4de8ZgS3GflsVuEQ3mLqBSWJtSbzdqrCGlu3zx4Ol8yQDwt
 S2hFixy9gA2ZFsnfC3h2JSK3QBye4yTg7BcGiiR+OewhWGKmmBu7iUHaj23RSQg2RvDoHdiHY
 Gf5d0QM0JzK/dPCeCVbZWINqwRhJ3LBtCgDiQRziaQrH00E5QoCFxx46W42yhfonjEPMGhNnh
 LYCDEcOo9Pw159+DPcFZdU7fvn0P1WvjZLdvmVT1vAChRIpTFXYk2tUcTm+hgJVbTZ9OEv3nE
 yGCDAEiC1slppL457nq//ZbaKEeeVYHfpMh7IvE8kQaT1u0Sa0M9C0hyEZk/Oy1ND7RITQECK
 G0bD8l66eHOlQQokYmlTQGHwW+MFjtMVODaW839KudgrlzNIGNlVTPwm0naKuub5lixwAZifB
 38F/Ohl4VjsQPciwqrypAzW3qPI3qpakA0RGpff/hRA6jN/4CxY2//sTA/OJ0jF/9ONjl2fbO
 znMQYVmuqxTSbz6BkaMGlw5sLkebnq6O41f/4k7LNtaWiMC/f7ITpI2UevzYR8+XnKk60FvhO
 1/ztdAoQ998FvGgl6wGBoaEjegxlPIjC+0SzU/GmEr/E2KH8mgOafNFT6pBl0LKb41zkLFbv5
 IVk7tjUrGc7NtCzC3SXi3LSlAIJfJhc5CZpzhvWhQZZZQgVlqrAB0HhPd0DFoFIxAsf1N6B7E
 eF2mqa9LDXGECar/WTkbP7vxzCGUpXtcYmKbc3SGDSO8DzdR1zr8IsCrizl1i0yT9fCKfCFqt
 kYTsLmpz4Ry5wR3thS/dlYbQoA/lCeX+d2aZC5rAei9IxkkXthiLV0b/UA27/NLLdZ5Gj5VXP
 457P7kJ5HYmbgoKKlRJ0k4SUiPEmC5raRl7dtyhR2nS4Im7LnUAScf25XfIGZOgWcx61hhd9m
 eFyGWEFwBXZDU6hQUM/yG9z/uJzzCOpv562dzxYpb4jszlluhGV3SB+kvPg5MZ0+9jIr0fnCm
 adVVUjek9+cW7wJsT7UnrVqA8GWPkNtlQ4IHOLxCkPi1vQUrfdM3zO1BfZel+IiINR97dLjBE
 F9Y5FaCCwT8Y71lHL7MEWwV/Spj7uau9YvujpI8rVca6pSe57L+GVsMAox+DXfbGaS4IUIEfT
 hO+lBewTlIn90Vla8BWuCwO6KARuU1NBy7ymFxA22kjlThFPnamAklie7lTwB6WCeDBVwsIm/
 Qma2+5F5QUfaK1ZgQESvQ43yPMaKLCF8I0+1CeQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XR8fCFWXpxMlL8LURJLDIruTRIGubgByO
Content-Type: multipart/mixed; boundary="UPj7xv3QjF7bFIHhEPhlLRxcfNqOEiyKz"

--UPj7xv3QjF7bFIHhEPhlLRxcfNqOEiyKz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/1 =E4=B8=8A=E5=8D=8812:16, David Sterba wrote:
> On Wed, Jul 29, 2020 at 04:40:35PM +0800, Qu Wenruo wrote:
>> This patchset is to address a bug report [1], where even with the bit
>> overflow bug fixed, the user is still unable to convert an ext4 fs to
>> btrfs.
>>
>> The error is -ENOSPC, which triggers BUG_ON() and brings the end to th=
e
>> convertion.
>>
>> We're still waiting for the image dump to determine what's the real
>> cause is, but considering the user is still reporting around 40% free
>> space, I guess it's something wrong with the extent allocator.
>>
>> But still, we can enhance btrfs-convert to make it handle errors more
>> gracefully, with better error message, and even some debugging info li=
ke
>> the available space / total space ratio.
>>
>> Qu Wenruo (3):
>>   btrfs-progs: convert: handle errors better in ext2_copy_inodes()
>>   btrfs-progs: convert: update error message to reflect original fs
>>     unmodified cases
>>   btrfs-progs: convert: report available space before convertion happe=
ns
>=20
> Added to devel, thanks. With the fixup and I've updated the space repor=
t
> to look like this:
>=20
> create btrfs filesystem:
>         blocksize: 4096
>         nodesize:  16384
>         features:  extref, skinny-metadata (default)
>         checksum:  crc32c
> free space report:
>         total:     2147483648
>         free:      1610547200 (75.00%)
>=20
Wow, that looks even better!

Thanks for the hot fix and enhanced UI!
Qu


--UPj7xv3QjF7bFIHhEPhlLRxcfNqOEiyKz--

--XR8fCFWXpxMlL8LURJLDIruTRIGubgByO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8kqykACgkQwj2R86El
/qj3ZAf+LDX7Ks2ohXmjNUFbqvHQw5nowGrqah1hUsBquGnQG9nkDvxgN7e4yzTM
q/M24M53dLpZSfzN5Q6j98fNheM8BmT9k1shcZejQHzjoo6SlxCzvTgGmH0LBsZY
6iGfB21lX5WsBulW0jriCM2hfYIzOqz6y3j+pg+8+W0V73IyscGZKOAFu3ATNTew
5U2h+JiSQbzVsI4eYLx9qZReeJbX6pC3+6i2USBJ5LNakxBC0UI97kls54aaxryq
qAB1Rq40ycoVL0kuiYl21RHbJ/XN4h64ezFH+XQ9uVx3J+Gxkgw37Cgoms1AMKe/
oVoJvK/c/+G6f7iV0FliQ5iUidWuYQ==
=qcyH
-----END PGP SIGNATURE-----

--XR8fCFWXpxMlL8LURJLDIruTRIGubgByO--
