Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABF62A4198
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 11:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgKCKVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 05:21:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:33141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgKCKVu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 05:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604398873;
        bh=LtijL/FlHWovGCs9URW5V9o1r9kRJnuqdx4BufHUPtM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Rk+cYFU5Tr06Gk+J+guVULLZyBEQLtLZzFVIuQZfIw4soVJgRst5ig5xaBfzqYPVc
         kSCvg1J+r/CumxpqztJUUqncUI2vxrhKal+Lk2xbhLpalyZrcqEkr/Mq0yds7+hOtK
         d78Q0FVkn4pCUxsTuMqZfCZBhr4XN8rz7VPYAxWM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpJq-1k1NhT0RP8-00ZtpA; Tue, 03
 Nov 2020 11:21:13 +0100
Subject: Re: ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <CA+G9fYsqbbtYXaw3=upAMnhccjLezaN7RUjysEF4QhS6TfRr-A@mail.gmail.com>
 <CAMuHMdV2A21oMcA9=rQVfL9xJfRZpV__87byMo4GsXH2i7Y2uQ@mail.gmail.com>
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
Message-ID: <7cf2cee6-3a15-b4d4-d0cc-ebc828ec0f56@gmx.com>
Date:   Tue, 3 Nov 2020 18:21:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV2A21oMcA9=rQVfL9xJfRZpV__87byMo4GsXH2i7Y2uQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YJAWHFPphaIxvo3cXJE2btFnl1pzZfWVc"
X-Provags-ID: V03:K1:LY+c0xOvElajXs0+eTvUDSQlsfvbKJegnq7MDxKs+O0ciTDeBrX
 Xv8Hc3g9fcLh4EwKF1ixEmo+2+TFwCOpbBIJGFqHl7ippDonrpirOiwWILPe5OKAgASasLR
 Ru7/CzltMBIfiCS8UucvHiE+RU9QHY+4b/Vqg9w/PykTstAdPTx+NY8yn1l+k97XFCXqcJD
 Hb0hFgGtUiLMma2PnFf2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:san1CuvpCIQ=:LMZdrL+vPbuLTFIJKoPsk2
 6A8Al3mo6woiA3XVySKGRJxhN+jkqvMUNf4CRFyBQoYpsMHZt5602MYC8+o2HPPqMimwruUwn
 OIIR6xcjy8HW5YZZwH0x+Lck8FtGq7a/xS5dIZafUjHOEmNDYsBKB1/t0xTm2j2MV73woc7j0
 5TAsF5C7zIaKqSGIi7Fva53L+gHf0S7U2KmlAL18TPFGzcX/K90G8hr77jEY5bWkTl3tAp0QZ
 a1QbxRNknCbv1LrSSaSaY8Q5jXt3ohEbZzKikozA7o93T/dCsTH0TLxCGjx23VEK/E8CZXcwE
 GpNRVKX5xWQKsAFNVw2/wio3RWOCmcKliQRgMG+Lh+Oc+A3ZOenTBWfrEjG3vXSFXUF3ykqmM
 7dkXg/Y7SqkHzbmgYuaUUs8ozZtDNbwwUXmOzp9w2MXcsSoQ6wbtbIRRHs+qSZXSe4HCkUYiU
 Jd6/JaNPYjCxpdUegMWQ/LzX52JWv2RUsgYpq5XUtgstT1xh3jR8f9zQjyTFUN92uDoYznqfC
 /sQpACoGaxNwwQYogrWU+mJTzK9QYhQUm4kNxTvnwrHsDeIzNMekr0u6/B77KLmUwOWdqgpA0
 kn8mlvUa/qc4yJcmfCR7ISE5mMI/bkiWFxPMWkhM5NUDF3eQBnqj9fb4+68/28slWHqN+nmef
 n0tl16XDWJzQvoJe+EKXEB2sfBQKiKOodsr6OHOekhRXXyngHT5/YbZuyj7V8srUEIilZGGtb
 s7xQICwfNSp9x1ahp1UFRKgKcWsk0IAWI3IxPhWHKyUutn6WCeL8rB9R5Ouaqfaq2Lbb39IqJ
 w3vGcYZWhQ0tqNO9roTfBTwvbqap4866t8Xi1+gipr3I3s+bldT2UXzQ3PXsLqnGAiC+8T2cn
 KvmsMgii/rXIvM/wmgvg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YJAWHFPphaIxvo3cXJE2btFnl1pzZfWVc
Content-Type: multipart/mixed; boundary="uJTWQiC3DZ3ViuRxPfO5fmfqtm6iZqZGV"

--uJTWQiC3DZ3ViuRxPfO5fmfqtm6iZqZGV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/3 =E4=B8=8B=E5=8D=885:47, Geert Uytterhoeven wrote:
> On Tue, Nov 3, 2020 at 10:43 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
>> Linux next 20201103 tag make modules failed for i386 and arm
>> architecture builds.
>>
>> Error log:
>>   LD [M]  fs/btrfs/btrfs.o
>>   MODPOST Module.symvers
>> ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
>> scripts/Makefile.modpost:111: recipe for target 'Module.symvers' faile=
d
>> make[2]: *** [Module.symvers] Error 1
>>
>> Full build log,
>> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTR=
O=3Dlkft,MACHINE=3Dintel-core2-32,label=3Ddocker-lkft/891/consoleText
>> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTR=
O=3Dlkft,MACHINE=3Dam57xx-evm,label=3Ddocker-lkft/891/consoleText
>>
>> --
>> Linaro LKFT
>> https://lkft.linaro.org
>=20
> Yeah, I had a look earlier today, thanks to the kisskb builder, and
> the btrfs people are working on a fix.
> Interestingly, the issue was reported in September, and still entered
> linux-next, so we all had a great time to look into it ;-)

Yeah, we all know that and how to fix it (just call do_div64() for u64 /
u32).
But at that time we're already working on a better solution, other than
using do_div64(), we use sectorsize_bits shift to replace the division,
and unfortunately the bit shift fix didn't get merged until recently.

Considering that patch is only designed to be merged after the bit shift
fix patch, we're not that concerned. (Until some other guys are
complaining about the linux-next branch).

Thanks,
Qu
>=20
> https://lore.kernel.org/linux-btrfs/202009160107.DZZO6Dfi%25lkp@intel.c=
om/
> https://lore.kernel.org/linux-btrfs/20201102073114.66750-1-wqu@suse.com=
/
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20


--uJTWQiC3DZ3ViuRxPfO5fmfqtm6iZqZGV--

--YJAWHFPphaIxvo3cXJE2btFnl1pzZfWVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+hLxIACgkQwj2R86El
/qjq4Qf8DL6eIB3RZeRSAkQd3F573vsi/2PengfvJ8peNXT3pOPHZJe0ijdtf+Id
fs06NrfMuVGxU+d4upF3awclGoc+c5jUzf/SS3d+GCm+zLcCy01xdar1jWibcjkA
HRo499qFsLBtTCywWlrDhxHkLkP8Iu6l07hCBU6g6pV8av3N6f6JYOaxpSTmM+Wp
EKtlWbaMQbQJi2O4C5p1aL0zpDwZXxdt9H6m8xPCWu/HzTaqSTwYxXORr0m1v+jk
5DrvcQdiYbJ6hkMu+G1qNl+nDztuwG1dPTs6IsAsjmsN+UOZRQY2y0h7V4U3hCVx
hf+X2c+pJYQd06Oys+dhMzmeZABCyA==
=kso3
-----END PGP SIGNATURE-----

--YJAWHFPphaIxvo3cXJE2btFnl1pzZfWVc--
