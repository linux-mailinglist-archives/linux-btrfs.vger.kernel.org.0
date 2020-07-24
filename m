Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8982E22BAB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 02:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGXACL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 20:02:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:56539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgGXACK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 20:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595548924;
        bh=30vEVWLlgEkfqvuVZtC2GNXfdyLvA6fQ2z70c6ve8c0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=k5JV7NrbOXHkbKWqbXqzn+jNiotswWElngUuAxiFaurGL7Ky5whMe+EzNs+5jl+6O
         TNoUQey6JlMqErS+RTaWlOXY/TFJvOb7BKgJZZZw3eD29pejyMk8Fgb5iUfDVtd6EP
         gnef5BLI86ANLTHD4LCMUXZoN9osmtidqHi1UFR0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXdC-1kBUqn2TvW-00Mchm; Fri, 24
 Jul 2020 02:02:04 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
To:     Neal Gompa <ngompa13@gmail.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Christian Zangl <coralllama@gmail.com>
References: <20200720125109.93970-1-wqu@suse.com>
 <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com>
 <20200721095826.GJ3703@twin.jikos.cz>
 <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com>
 <20200721135533.GL3703@twin.jikos.cz>
 <cccdcdc8-db5a-779d-7b99-346ef14133e5@gmx.com>
 <20200722113220.GR3703@twin.jikos.cz>
 <CAEg-Je-QVTWQeFg1gJMSXcBHzniSjMNxSXiN2L++_YVeTwZH_g@mail.gmail.com>
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
Message-ID: <493ab1f9-9f58-6d8e-647a-9092e1e0480f@gmx.com>
Date:   Fri, 24 Jul 2020 08:01:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je-QVTWQeFg1gJMSXcBHzniSjMNxSXiN2L++_YVeTwZH_g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3eyM7OrKHijorGFPiFYXgQzmtxtxoOq9U"
X-Provags-ID: V03:K1:xXq++jJhRDolYP01hK8R+/HHtZAHMym4SMoilg5ZUyRykBPScCZ
 njtxjDNsyzHOF8RjIS1BxTj0CQ8ZmFyIOjQ8T+y5Iwz29Bef8HABL85LV9zrhK62xyxSmnG
 nynTWIefLg6Br+9P3RECG6J/YqzW2O+BtwKm6P/vgb+TFdC9p5v+6vI90GoKujzBuyDBWye
 s+Cu+zl+HE/3du4LzsNgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s0qG77/O6c0=:WHZvNK59JyxXafsZjgwTkJ
 zKZG019+FLFpJj8enV7e2HVkRGIC57Jg2U3K872YsTutGoUKWHsuzCFjAW+pceBGW40joP7Zx
 TDZN4Q4X8h6VrJYe3lg5oS6jXpXuhmNaw6KUkLGYi6HmJEoNPWxT1SjKZYJAlWJyMJN0IriGv
 brl4tgPpuLIeeMlSVqC3Lt4p4Ff7GaHGd8UhAgm5JjvBOFGwRmjc3miWbliY8mtpOy+8/ro4H
 h+exZ6tD3V/icmgSn1PrX7oX9kM+jJ9W606oh2SFiNZ625C5q9NVzl14Bbmv+KKNWtGEus8hv
 V+OfBaNMqbppjjx7W/S9ZJnduzQyYbWftRs7GZuCQ9uAjiucP2lbfy2rV7WCIyhSFM6kd+OnU
 t5T+jLhPdiB9FJ4X0DRziUX/RTydw4atdOPXOuDuvFvp6lU60A4pZ92xQB4Ohgr3P0nm2yBCX
 noluucIr1sLd9Y06qs+Mszxow4+UicjRfHi3Jel5z3ZPVVyXFy9kSRdsZO7Est5nlWqG6EJCQ
 x4gZpkToErFelJ91YbyMYIjdQul3l/k+Fxv+SyNPcytzNya8v7fiVK6QQlOFI9mf4SOvRsK5x
 +SelCmCj3RdQXcgYk+15VuQrB64Hr83CoFztUxTPZ1JtQZ26ygHYU5ggHhSxU+Iabcj/99D10
 f6ZRCn3XjqoCiMgyv3kWsDq3WHzkDoq5Nr20sQcFcfjj+t0iJ4MCHncg9jQhQN4EwFPBbuhO9
 GQUtdAUF9UEkghE6/fAYaYUOm7i6TRFGIhJMJyd9MeE8bgCw6clfwD9S77c9Bcx2rs7CcjO+2
 GaGlDvmF6ow0jR7Iw212UQ6Et6Xf9QW6G/1bo1VWiAKClbdgJiO9Ly3BzrtI3PNNnxpvWsM52
 9ku0P0CosK8lGzMDxspm6TIa2gJoMTqa3SrOxsT3gu2B17rgMrGMguT/pjy9l4IM7d5I81iFk
 75K13IwdA9GE1DiA106tbvFOfo1PBvrPEfp5n5WbsekJr4qGfeHg05cUbE1qPAkzHwURyiZAo
 AASzBooDKdG+l85Ce5SFTyjkGG3OmPYbhADtI47t5fQH5GFBy8JHYS1z2WUKSbxcKfTs4CSAS
 Q8s+b/rfaGfwoE38GqnhYkCHuWMOkVKsMLIuXYM3or7mYGazlZx9QZxsix6QOfSaYtKxM5AvC
 8fRP6ukm/Bx2x8c5xduuIiUxNaTSPNAzbDybtMGDSBHVu0W/2qNQ9df9WY8FT0Ano8z79dVhM
 uy+AlR0ySnCa31bBWmVLDkpAjz9Wi/38IxRRtRw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3eyM7OrKHijorGFPiFYXgQzmtxtxoOq9U
Content-Type: multipart/mixed; boundary="tjnYxtMc2KD3m0GnWLDqAWKQs3dVMA5JA"

--tjnYxtMc2KD3m0GnWLDqAWKQs3dVMA5JA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/23 =E4=B8=8B=E5=8D=889:31, Neal Gompa wrote:
> On Wed, Jul 22, 2020 at 7:33 AM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Wed, Jul 22, 2020 at 06:58:39AM +0800, Qu Wenruo wrote:
>>>>> Thus casting both would definitely be right, without the need to re=
fer
>>>>> to the complex rule book, thus save the reviewer several minutes.
>>>>
>>>> The opposite, if you send me code that's not following known schemes=
 or
>>>> idiomatic schemes I'll be highly suspicious and looking for the reas=
ons
>>>> why it's that way and making sure it's correct costs way more time.
>>>>
>>> OK, then would you please remove one casting at merge time, or do I n=
eed
>>> to resend?
>>
>> Yeah, I fix such things routinely no need to resend.
>=20
> I have a report[1] that seems to look like this patch solves it, is
> that correct?
>=20
> [1]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1851674#c7
>=20
Yep, looks like the same bug.

Thanks,
Qu


--tjnYxtMc2KD3m0GnWLDqAWKQs3dVMA5JA--

--3eyM7OrKHijorGFPiFYXgQzmtxtxoOq9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8aJPcACgkQwj2R86El
/qj7mwf+KDoxXWHY3cfhXekyA3iOSjFtxVXIY5r61SnQ8JJQo54NR59Xw80cGsxR
MH6n1xz8KHFC3e+lp6ug9KBpzrVLxX20ZmwNno9E1f4qU07iZ7STjAZ8H44NaeJj
wcVw8iCKaxBIF6kjK+cZdiUMQRdFwXTiu09IoNuIyh8uB0SYTs+YyTmTUEleEOoN
wt4ChsRJqqLb0A69zpswJZusdYdJru7CDBwJ7YogWiMo4EisfvYVQhd9MLBSUzDJ
d30w1LLqqXq1eae6aoO3jt90DgPMBCD7nfjKF6qHc0RREPfPAsqXpOAEsQAg0Hfy
A9A2v7AWML42T13s7mmO4zDKEt1Z/Q==
=S35O
-----END PGP SIGNATURE-----

--3eyM7OrKHijorGFPiFYXgQzmtxtxoOq9U--
