Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9F280C18
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 03:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgJBBqj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 21:46:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:56693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgJBBqj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 21:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601603190;
        bh=gM/nXgbSLHFvzm5V9Rol34yUPu3VLYm5mLt7Va+OAUM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ITEA3qzhY73rQtkT6aWuN9XvQhKVTidopOo2aV7WMRvCF+4E1Ocv5rEf5aPdvhRqj
         1iDD2yop0tHp5ABbUiRHvgxtGPjSkyeFEmHnkyrR10yPx1qbBmkG+LvD0LC1nzX+nu
         +hC6SZnE4OuYw2T/VX2CVyMFsB4htVwifQPF9gmQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKGP-1kDV1w1LGD-00Fj3I; Fri, 02
 Oct 2020 03:46:30 +0200
Subject: Re: simple Chunk allocator like calculation to replace Factor based
 calculation
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20201001233649.888B.409509F4@e16-tech.com>
 <7b8600fa-e04e-2b87-3ddb-ba16d4f2824f@suse.com>
 <20201002093001.19E0.409509F4@e16-tech.com>
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
Message-ID: <6941eed6-19a3-add6-6608-8a5d5ec86006@gmx.com>
Date:   Fri, 2 Oct 2020 09:46:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201002093001.19E0.409509F4@e16-tech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pgpjsVSTLG89vUHQ1CiqLs3fIGRheY8ne"
X-Provags-ID: V03:K1:3O6cev7M+qP0SfIZmukntglFO/kVtf9Q0yaAwSo6NrukCl0lkg8
 h/TOBm3Z70eNZ3gSwty9G6W7ua5NpjTyoq/cSV2oE3y9JncscW0IXR8rq3ZS6JzXldZ+BHy
 uU8cd1TIje3ovlFHua6ycBfjAkhNddI6TJ1U2151uhVVAtggiANcKbe05W9sAGHVJGxLgIh
 EyUt3pkOI/TKa6hX+CVeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UhSUxtvWeVw=:Nyp/LSUXjkuYmd+wT7ogVH
 Y6wY+3z0gPGzsL+Fp0jURERiKNO0krPadI8iu+b2qpnC+VY9CBEs5cOXxMfzV93LbqIdz2oZN
 YXHz+dlxg6vhRklJPrpn1tR8CBOZ6lNynvouIpRfkS17XhVLCkjpzGzwzr+RWeXIbZbrcfq7d
 3EdozMzEU+Xh3vQwcYoWGMnkFBpXb6MfyTwz713mDwWiOBBYx2IpsgwgjruUJUs0iXV7i4e/N
 CuLNvZhyqmnKoJtadtwqHgSFeUPTdowmwLz0Ev6zlKL9yh+kdfTTwDcRR5mQeREDrs3M6exTE
 DW0/JbXS7vVbT3bXKWzAItQ6DoPl7rTGa+gKwQSYxh/1CNazhcWgTn92pp5XJs5DgrB/GiEhg
 YMLRciIkLpTQzstddx466g29szKUphSvPiLwzJMh9kF5glLbkCCcSyDnPmnc1HtPy5d0DWWoO
 ce+SvPeBNCYthO573MykHfbAkl5idw0DrdU1VwNn086V1xouND8iTY7u1qx5Cge/8eI5ftqV9
 I+PzoVTvGAxYHm6Ps8Am0UcQOaEIiAjHQWCDgIah0U8L8fdO8IU/1pMtc12jYNoHKvK3d2rwa
 LqKNY7UMU6VBII/RZqkwRmIFluOLcq7R3IIE3YxNFawJ0DOTtWkgiO0+1H14equfOQ8AXENTE
 untwqQ1LmsS/SsMpxrf6t9yj+8ETfuFKNFZQAl74WkBt7ZVeIKiiKD5IuGHPSEjDnAUw98l0u
 os5Q+dlsgKTeVImvi3zLER9zq2mSs2rKqiy8FEpUBCSwB26DWVySU6T1kgh/KOwVg17vKDD+V
 i42SeNeRp2SEczzEkE+nydPPGlmoCroR77N2h111ZZhjKNIj+oudBS7jSXMzJzP1TwGvd/0SY
 lxYWCm5nEGEu2LKygIk8HW8vlGvOvWZziELA9Z9RYBfDQgxGjNL/uBfOz9JJmDAf2Gwe1eHy/
 dsACEG5E08ppC7UUiKvDmFMrQQQeOYODlgdbYUGkIkUqx4VtsZs9Jr30D+UbEGos44Eev3vhd
 QPRaETPIi8auehas8Dm+nK7NP6RlM+50p0pyOGyAxdnC4af/opZd4o8bxXvE8VSXXbAGYzip7
 olKPLZPM/B1fqzdDkzOUlupRkJu4br+7iqDYFF5e+yMeD3rcpuPWFtkWeYf8ASrlyf85RVvmL
 30ZkYDdYwDnPRLrkHHSLOg1iMJ0xGClqmVxKpoFGwEaPkwzeohmypooQbtv1tkyYRPYGEIoKP
 pUG6hAsOrUe8OAAiGQSq60SxNW36sR9M/euiyZQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pgpjsVSTLG89vUHQ1CiqLs3fIGRheY8ne
Content-Type: multipart/mixed; boundary="T9rf6oajRtEhoexNzXAPjCpYLsqI6iwIG"

--T9rf6oajRtEhoexNzXAPjCpYLsqI6iwIG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/2 =E4=B8=8A=E5=8D=889:30, Wang Yugui wrote:
> Hi, Qu Wenruo
>=20
>> On 2020/10/1 =E4=B8=8B=E5=8D=8811:36, Wang Yugui wrote:
>>> Hi, Qu Wenruo
>>>
>>> Chunk allocator like calculation will get the right value, but it is
>>> slow for big file system such as 500T.
>>
>> Nope, the ballon allocator doesn't have any size limit, thus it will t=
ry
>> to use as much space as possible in a single run.
>>
>> If the 500T fs only has say 100T used, and the remaining 400T is split=

>> into, say 2 parts, then just two small run would finish.
>>
>> On the other hand, if the 500T is mostly used, only 100T unallocated a=
nd
>> the 100T is in a big unallocate chunk (under most cases it's true), th=
en
>> just one allocation run is enough.
>>
>> So in short, it's unrelated to the fs, but how fragmented the
>> unallocated space is.
>> And normally unallocated space is not fragmented at all, thus it's ver=
y
>> speedy.
>=20
> We need some more complex example for 'Chunk allocator like calculation=
'
> to make it easy to understand.
>=20
> such as
> 1) RAID10 with 8T,1T,1T,1T,1T
>     the virtal chunk size of 1st iteration:	1T or 0.33T?
>     1T    chunk will use 4T at most
>     0.33T chunk will use 5.33T at most?

You didn't get the point.
For the each loop we:
- Sort the devices with their free space.
  In this case, it's 8, 1, 1, 1, 1.

- Round down to dev increament
  Then we got 8, 1, 1, 1.

- Then allocate chunk
  Since the biggest unallocated space is 1T, we allocate a RAID10 with
  1T stripe size, which will be a 2T chunk.

  The remaining size is 7, 0, 0, 0, 1.

- We go to next round.
  No way to allocate new chunk.

In this case, we can only get 2T chunk.
Just as the chunk allocator do.

>=20
> 2) RAID10 with 8T,1T,1T,1T,0.5T
>     the virtal chunk size of 1st iteration:0.5T or smaller?

Still the same, 2T chunk can be allocated using the largest 4 devices.

Thanks,
Qu

>=20
> Best Regards
> =E7=8E=8B=E7=8E=89=E8=B4=B5
> 2020/10/02
>=20
>=20
> --------------------------------------
> =E5=8C=97=E4=BA=AC=E4=BA=AC=E5=9E=93=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=
=E5=85=AC=E5=8F=B8
> =E7=8E=8B=E7=8E=89=E8=B4=B5	wangyugui@e16-tech.com
> =E7=94=B5=E8=AF=9D=EF=BC=9A+86-136-71123776
>=20


--T9rf6oajRtEhoexNzXAPjCpYLsqI6iwIG--

--pgpjsVSTLG89vUHQ1CiqLs3fIGRheY8ne
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl92hnIACgkQwj2R86El
/qhVzQgAjBPIeWjEh1T1EVQw3ndC6nUHbrBfXt/3Fnp/sUc4lQc3KTHtcbGSrL0g
u3+Qsbi5Pmo9jST/iBz4g55FiS12Zpztr9uVo6G16Fqlqtt+LgCO/gW5pF4VHFx5
hP1/4CKLI7t5A8YstdfzCn274/pB0gDakCfUuy/kTH0kk6K664LkCpYrt8LDritM
FXwMB6cOtVsFnmEMt1XXLqfDta0VPy4ct5+oxCP5ZmRuAwoEMBulW4ElG7mvI9ca
2USK8IqSZSzfkJd2xD2U+k4PmCxiBbXuNC4J/Fb9e0YoPyzlcFkSFJ/PkBWR02u8
86clMhgHpaIq9V015rPA8D3ZtFBSvg==
=GKjq
-----END PGP SIGNATURE-----

--pgpjsVSTLG89vUHQ1CiqLs3fIGRheY8ne--
