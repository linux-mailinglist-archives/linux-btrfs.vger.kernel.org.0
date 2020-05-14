Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777841D2AB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 10:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgENIza (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 04:55:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:56097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENIz2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 04:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589446522;
        bh=y6hLxXK5ADtqbPHainWmanMRtSyPjD2pP3Sz+LmkbhY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Zy6ZB25rd9XCeqv6qARp1+VIB5VnRQi6+OwOfCx9G8wHFVLx1CoM36gSyudldLyEI
         3i1G5kHReLp61Uii3KnQHCV29hWQpZlqUT3ywCyiPaeSNjZyN0Y9km8Qp/9Fv/B+Uy
         nabliWPQRMZfY8Lxfqx9OHvVm23jPrbRiDt5Krs0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1jqGWl1kEo-00JHLT; Thu, 14
 May 2020 10:55:22 +0200
Subject: Re: Balance loops: what we know so far
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
 <20200512134306.GV10769@hungrycats.org>
 <20200512141108.GW10769@hungrycats.org>
 <b7b8bbf8-119b-02ea-5fad-0f7c3abab07d@gmx.com>
 <20200513052452.GY10769@hungrycats.org>
 <6fcccf0b-108d-75d2-ad53-3f7837478319@gmx.com>
 <20200513122140.GA10769@hungrycats.org>
 <3b3c805d-7c75-5fe7-1ed8-4a7841b16647@gmx.com>
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
Message-ID: <70689a06-dc5f-5102-c0bb-23eadad88383@gmx.com>
Date:   Thu, 14 May 2020 16:55:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3b3c805d-7c75-5fe7-1ed8-4a7841b16647@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yqOXgPv0xtq1vW0z4gjPde8N1OJelpN4T"
X-Provags-ID: V03:K1:Nsfh+O0vkEUUMOM/u1gDMrqzE74absO47SBPhB8I289mIy39+Ys
 Jgvga2xtWWW8lckRrwsqTzgLNgJHKb5Hif1Uxx87xym3NgIS0VVL/CCQG7zkJ4fYOI+LV3n
 hFAnYP6fEBiWd1lSv68TrLx+iEF8NnMuA82QO4eOxoxOrBhlcSt3T4JUXJz70sfnNfvyY6t
 l5qzdOlBPAKPBhNAXdfUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7tBNtolbnVI=:36SuwsRUCbeR2yoU1X0YZl
 3nu69aJgaprUE7LeVLu5+MGBEFklskKTN/Fx7WO417V6o3DJBpDbWqn82ZF7W6nhSjbweV95z
 LaNFlcw/dr9rBqIs86M2wO7MMEUnT6sYPvT0sbcmVCq8X/A3F/U2VeIR14aPfGc2kw1rupwSg
 bSxvV4Kci+qkCOf5kOjlmo6NZ1t8xHNzy/6JzBqurrvnRMTH6OZO/vY2P4/Jp1q0oj1P0OqdS
 JJS8Jf8kbudEOY77A5iws42C/49Ae9nkxMtxkjfrSsmOEO8i7GfOlYLg66h61t7ZsmDCha6qd
 k0s5y0gAXzAL6ujGJdrd30VKnQnL8SrJR9y82rFeoEv4gDPZe54+3dLUVVpY8UiRzeKOmMqj/
 Cw/iTTGFIPrfMBD9kjp2pjhdiEf2y4nMmSbVZwSbqiwbaaffPf2H9D0pLxHfh9plPDURXMAdE
 RvCFLjbfoMKc8zHdei+wuhATpTq+XMOJzmCGNsb/9prbeq8HfA1MoTcp6qVAls3VEl8d7SSNA
 D83TRA0PGVbH8r3b1EeYh4YnbLNNw/+JKp/cuiL9ORlDvAKc4daap9A3d4z0axRx15iideYfm
 OknzrDc5r0QmIlnfePa2o2UJwy/pyTb9M6EyRgtooAGF6PNi/0k/T6asQ45Q7gFcgyuAm5FZr
 O2YpsQfjr2i9ailXfbCV8OyHL9fTACJ8xNPpD241uBKnyEgnX03YPGQgD9JkecX0HNiCcBddz
 fYKY5Rk3VE419unRBC/O43cjwfHE4yXHUCwv5Fzdg4OF/wD4TB51BfBiO2JNRTsy1on/hCtg9
 1V3XDgRoDXT7102nH/CsWIESao2zeJj/MbPz6flwaALgpYdrmAZ2AZRBxxqLNUiYr56/xivoF
 uCyjJT9SN1D/OV1FJ7/B/6K0FZR2gMrrEL4HAeoGlDq9kA6bkicyJ1F8deyGqJLMW09dRe4q4
 udyyT2T4JTDpvlhwJQUM+LhUF9OpKJLwXLoKvpbcW6GD1huPDsFfeHJ7h2ZWu2Q1LLIzMELci
 riWlo9SPM6DBrTiwJDHagP9JiVV5w8y3pNvcyGOUT9OMG9jwbdMO/sivXMMWEXsHCZGz+NokR
 nMfB2o4Fw2YSXSO6x4yccLLO51WkFXuGPhwJb7/6CpbljFnDdCXvLSqdvu443GizcaWfUeJck
 p+jAZ1yeioHmyzokKi/rcOOtOMqwAjU0NucdHst4c5a1uTXG39T7MuFcjZ6L+u4/E9pvHZxms
 EQP/BX7lPjksPHQj2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yqOXgPv0xtq1vW0z4gjPde8N1OJelpN4T
Content-Type: multipart/mixed; boundary="Y9HkY0V9IJGz1MF3bhS951Tqu6TkkR7CJ"

--Y9HkY0V9IJGz1MF3bhS951Tqu6TkkR7CJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/14 =E4=B8=8B=E5=8D=884:08, Qu Wenruo wrote:
>=20
>=20
> On 2020/5/13 =E4=B8=8B=E5=8D=888:21, Zygo Blaxell wrote:
>> On Wed, May 13, 2020 at 07:23:40PM +0800, Qu Wenruo wrote:
>>>
>>>
> [...]
>>
>> Kernel log:
>>
>> 	[96199.614869][ T9676] BTRFS info (device dm-0): balance: start -d
>> 	[96199.616086][ T9676] BTRFS info (device dm-0): relocating block gro=
up 4396679168000 flags data
>> 	[96199.782217][ T9676] BTRFS info (device dm-0): relocating block gro=
up 4395605426176 flags data
>> 	[96199.971118][ T9676] BTRFS info (device dm-0): relocating block gro=
up 4394531684352 flags data
>> 	[96220.858317][ T9676] BTRFS info (device dm-0): found 13 extents, lo=
ops 1, stage: move data extents
>> 	[...]
>> 	[121403.509718][ T9676] BTRFS info (device dm-0): found 13 extents, l=
oops 131823, stage: update data pointers
>> 	(qemu) stop
>>
>> btrfs-image URL:
>>
>> 	http://www.furryterror.org/~zblaxell/tmp/.fsinqz/image.bin
>>
> The image shows several very strange result.
>=20
> For one, although we're relocating block group 4394531684352, the
> previous two block groups doesn't really get relocated.
>=20
> There are still extents there, all belongs to data reloc tree.
>=20
> Furthermore, the data reloc tree inode 620 should be evicted when
> previous block group relocation finishes.
>=20
> So I'm considering something went wrong in data reloc tree, would you
> please try the following diff?
> (Either on vanilla kernel or with my previous useless patch)

Oh, my previous testing patch is doing wrong inode put for data reloc
tree, thus it's possible to lead to such situation.

Thankfully the v2 for upstream gets the problem fixed.

Thus it goes back to the original stage, still no faster way to
reproduce the problem...

Thanks,
Qu
>=20
> Thanks,
> Qu
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9afc1a6928cf..ef9e18bab6f6 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3498,6 +3498,7 @@ struct inode *create_reloc_inode(struct
> btrfs_fs_info *fs_info,
>         BTRFS_I(inode)->index_cnt =3D group->start;
>=20
>         err =3D btrfs_orphan_add(trans, BTRFS_I(inode));
> +       WARN_ON(atomic_read(inode->i_count) !=3D 1);
>  out:
>         btrfs_put_root(root);
>         btrfs_end_transaction(trans);
> @@ -3681,6 +3682,7 @@ int btrfs_relocate_block_group(struct
> btrfs_fs_info *fs_info, u64 group_start)
>  out:
>         if (err && rw)
>                 btrfs_dec_block_group_ro(rc->block_group);
> +       WARN_ON(atomic_read(inode->i_count) !=3D 1);
>         iput(rc->data_inode);
>         btrfs_put_block_group(rc->block_group);
>         free_reloc_control(rc);
>=20


--Y9HkY0V9IJGz1MF3bhS951Tqu6TkkR7CJ--

--yqOXgPv0xtq1vW0z4gjPde8N1OJelpN4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl69B3YACgkQwj2R86El
/qhDJQgAi+QbZRrGP+ctBjn0mD1TINhdg/NhrU0eBMROxO7SZqjv0VqGGTt+2YJt
6ndwMz2Dxv+1Iv7Pws/BJPWYvKlOiikTUruganR1mIHPXXJUYCXBWEZEULe/+Ps3
PFPKUlDya0O3jTNYgbP44OgTkfRp+Lu2CRoEGMevU/OGh1m7C5VfK8WodgcbFXA1
7P8CQD5H2oTkweFoQuFAxcw+rXJfskq1q7XUgvVUYgQqq1WC6eTotJ1OYIMbUsK/
OA6UzhPvs8x4aw6ckZ/w8ac9tj2XPn3ruNahiHUh+o3bm5GoMwXJ7zAKt5Wk8Lkb
Zdh96JztC4wk6kVGnh0ubsne5DciQg==
=Dw8R
-----END PGP SIGNATURE-----

--yqOXgPv0xtq1vW0z4gjPde8N1OJelpN4T--
