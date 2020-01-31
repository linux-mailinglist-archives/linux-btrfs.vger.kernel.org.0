Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC26914E6AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 01:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgAaAff (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 19:35:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:56749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbgAaAfe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 19:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580430927;
        bh=404zI8JY+RY8JWDi+5E7kFye80FmdGGsqrO1FOxXJ64=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IGEE1JJmTlD0UjBqbD87aizgJoKHw434sAFN6sLLZv5ecnww/lb18J6x/qpWggNpx
         6a7+sNJo6sUh2BgQ94r/H2nNsots0miLQJSOAEIRC4I0M/V98Fvfx5rwTV5UwJo+ph
         UUbzgXUMTKFqcNsBVdoa0iHyolMsPLCZUbzQB1vs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpex-1jQJ2v2qGF-00mOEm; Fri, 31
 Jan 2020 01:35:27 +0100
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <38a5dc98-7233-0252-4ba3-76c59d7b21e7@toxicpanda.com>
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
Message-ID: <5fe1d568-9c6b-7fcd-5d82-04738dc64b4c@gmx.com>
Date:   Fri, 31 Jan 2020 08:35:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <38a5dc98-7233-0252-4ba3-76c59d7b21e7@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8gk7D0kjWM0AHUchGAgBZUm4dpneCyzff"
X-Provags-ID: V03:K1:kiJ+/MLDb3daBbSKKP1yJIx+m0VX11wrx7fvv6Uo4WvH9Qe26xi
 yDHSthU/Fo9ER/l0CjuOQdkPiODGfgSlZc0cjrrKwLtaIyWLoe2Gs45NhtczlnVoa/aiEih
 F2JLOJIJ4fZLJYE9BWfvAWRyJWyDoPfRhtzoijghZrBSqxRB3ybc/nVFLHw+FgV/Rx+jNpY
 B7Tnqc1QQHnPU6o8lxx1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5TMD9DhvrsY=:3vywsPlzYIZEoxc5QnCEwa
 iflZOEBw0XoHPTfzKK9P+DjQc9/HEXSOU0iZqIyQtIU0UQ9Aoq96QpvXGRTpmvAISPSlRofs3
 DHhg5/2GEOnNvbM2p4ZVIgKtLRALWAh78LiOMnrrOjz9ivJ2a522zztin1dLpYhug9PG4NMqq
 1vANaUpRoDmzdQiRST156VP/vZj7uYBY9gPlFLOVe4JKRffWyjd/In56bT0cIA3KFjMWooHHc
 qu1LB+5L+3SMIFahZsy8+btYUKZsS9DzY3ZgZ9O0fAqtUJ42YEjwfFBr//wkT04ZPo+wTPmiZ
 fHTWczcKa++VIAeqtosQZRNsGGRwvp6hSeoSWlDp3DptSr9+LwqLx0foXncPrYyQUBFyMxGU0
 pClVtYhnP4Qtd9LD6mKr1b4GHEPF3zHHTSnB1i2UphY/99xl93dmqgPkhHlz2ia0E1sqNVrm7
 spxB9HESKU1p9xmfXr8Ddn6ypTrvkphVW4V9PnFtVTwa4Uy0fX3Y8bAfUxQFSPufA7HDYybhh
 taiLIAsfJfPwaXsLI5PJzsaJjYVBRCROCUhx3fAclkwqadZ5Txi7AXiIWfyhPi5keDxPpfccC
 HqXI0fIbbY8zEzCaETlMNfEfk+XJ7NvXAC+UCFzLCaQ8YxXBR0W183eXM+u9niaaCWiZVbrRe
 zrx0dEwgnXW1H1mEYy6J4SJdfYQpFgccGe8k7LBi494JH8k4nYq4yQlsA0m8z03+MkyFwLhz8
 zTqIa+gGVOdO0ZAi2xi8iT2F350PayjqhCd+VRpPa6tENdhgMNJx/LA+XNXSpOgTg7M9yCa1K
 gz/nIfXFMhNhLl8fLEmFzhHn1icUFQN/siPBgb2cWvG89T3OdE1bhe90BkZK3DezDIxI+6e00
 b/knmKXYqkmJI3xHbNv4onhZJsQEWTThHlSVT5d+FXtbnPYkc8VXTJT/sYZ9NT8zX5Nwy+uxF
 9P7MQ0tzQWAzzKMbF9Zr5Z3FdrTlbMoXO8J8bLwR9mQHC1MjHM0M+IIYSWGPdnnWjggSl4d77
 gApINfgdLvcAFsLryYNXBucJzBvwvmejs0gEDjEbLxL6QrVQ3tIIgqf2aAcB+P+sIcq/y/BDP
 ZWE7UORFRGCan6sIrPyErPE2K2qJcEN7woPWRk9jbpna1B8TlyvRn7TBFJMFRm1PNT8+e4Il3
 5M/N7ELUEETT5T1930meCNNx+Sr/ju+OXbyDsxq8h4hIYhGJb26YGuQpKfs4mqk2Oeia2Q3vi
 YGp2t0JHT5B8pVA+n
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8gk7D0kjWM0AHUchGAgBZUm4dpneCyzff
Content-Type: multipart/mixed; boundary="2VbzkKluSmIJw3W6ofmuKfkp5mxIGKCdW"

--2VbzkKluSmIJw3W6ofmuKfkp5mxIGKCdW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/31 =E4=B8=8A=E5=8D=885:05, Josef Bacik wrote:
> On 1/14/20 10:41 PM, Qu Wenruo wrote:
>> [BUG]
>> When there are a lot of metadata space reserved, e.g. after balancing =
a
>> data block with many extents, vanilla df would report 0 available spac=
e.
>>
>> [CAUSE]
>> btrfs_statfs() would report 0 available space if its metadata space is=

>> exhausted.
>> And the calculation is based on currently reserved space vs on-disk
>> available space, with a small headroom as buffer.
>> When there is not enough headroom, btrfs_statfs() will report 0
>> available space.
>>
>> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
>> reservations if we have pending tickets"), we allow btrfs to over comm=
it
>> metadata space, as long as we have enough space to allocate new metada=
ta
>> chunks.
>>
>> This makes old calculation unreliable and report false 0 available spa=
ce.
>>
>> [FIX]
>> Don't do such naive check anymore for btrfs_statfs().
>> Also remove the comment about "0 available space when metadata is
>> exhausted".
>>
>> Please note that, this is a just a quick fix. There are still a lot of=

>> things to be improved.
>>
>> Fixes: ef1317a1b9a3 ("btrfs: do not allow reservations if we have
>> pending tickets")
>=20
> This isn't the patch that broke it.=C2=A0 The patch that broke it is th=
e
> patch that introduced this code in the first place.
>=20
> And this isn't the proper fix either, because technically we have 0
> available if we don't have enough space for our global reserve _and_ we=

> don't have any unallocated space.=C2=A0 So for now the best "quick" fix=
 would
> be to make the condition something like
>=20
> if (!mixed && block-rsv->space_info->full &&
> =C2=A0=C2=A0=C2=A0 total_free_meta - thresh < block_rsv->size)

block-rsv->space_info->full is not reliable afaik.

For metadata we will never really reach full space info.

Anyway, the patch is already discarded since it doesn't make sense if
the patch can't reach v5.5.

The proper fix in the per-profile will be the fix.

Thanks,
Qu

>=20
> Thanks,
>=20
> Josef


--2VbzkKluSmIJw3W6ofmuKfkp5mxIGKCdW--

--8gk7D0kjWM0AHUchGAgBZUm4dpneCyzff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4zdksACgkQwj2R86El
/qjlUgf+JY9DcE5RdpYC6T9YYLJRIE2f+FUYPUh5VlvYGjv2ctBJO+8+uloG9S4A
3L0jwKpiac0AsliqENZlZf00TfJT5Fxb62+W0Xrm4Yr21/0WdtiFZouCc3713BRd
ojx0y081Fku79gfOstRX8rBBLMxbfXba7np/uz2jAw6yqKHB1jsDmlk92mVkQuST
5uE4/Q+08UtIAUsJeTQdKos3LgThJ2+Hr7MBz5fYEwkNXqy+gTgdHna+4evZIayU
g9IK7rtypNw8upNnc5c9T0bUwL12FHL4p3Dkw85A2hHo7E4tAb0So9JH/zQr5iJn
10td9OZwH6tDshZw2vi8nGA3SwhE9g==
=IzcS
-----END PGP SIGNATURE-----

--8gk7D0kjWM0AHUchGAgBZUm4dpneCyzff--
