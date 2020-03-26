Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9335619352B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 02:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCZBJx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 21:09:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:58291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbgCZBJx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 21:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585184986;
        bh=fgXrb2w0QvmWIKjh8ZUO0GUF4j4bD1Bp0vajh98IFqk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Rh82vvOrJtTIWfCZQpous9d+fmOytBV90Y2jdYggksa5tHoW5FLO12ZA4H0zrL1NL
         kLSo/jCaoyr6QIVGpBAT2fmpxWjfrEvZlWDTYybcKXg/gUC1cCZzo+LtvufOjoMF5a
         H8CbcWsN/zIX1GXvXi5mNjdlO+zzf3d8X9jSiNow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQe5u-1iuoj12Cc2-00NiKE; Thu, 26
 Mar 2020 02:09:46 +0100
Subject: Re: btrfs-progs: RAID1C3/C4 missing some info in btrfs_raid_array
To:     kreijack@inwind.it
Cc:     David Sterba <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <2f5db5cd-001f-449d-d370-697f3494ed34@libero.it>
 <cf046899-7a7b-a93b-2340-c996cbfbc6ac@gmx.com>
 <b8b874d0-a60e-2a4c-f3eb-e54539bddc8d@inwind.it>
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
Message-ID: <eaab47b8-4026-f5f2-5e4a-723c990cfbca@gmx.com>
Date:   Thu, 26 Mar 2020 09:09:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b8b874d0-a60e-2a4c-f3eb-e54539bddc8d@inwind.it>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lSthIG7HaTCYsW0AUdUTcDC95XELszSWW"
X-Provags-ID: V03:K1:mTJWUSN1+XiQt0iBFZ5iwcPME20xcZsjx/nxzGE/M5xSmqIFWG8
 dheU1H9mOicGTxcuSe++M2Hw603gxEM/6PXE2fuKbyFO4GxtqhszKOgkqVMuxmFdvb4pIr9
 rBfI8wkUrg4sgqx2AAuqMHp1RRmIRvr7Tra9pEK+dR92Irh1nnTMAHbisT/VVPSs1TOdV7P
 lLrYiL6H1taH8hoRnauWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LsYVFuRCsBI=:ddg7doTHOQhD6W/BGgErG0
 plhKL+/9PuH+7nfXFI3nDWJjaPub7QbHoLdN0c9pBZ3dEfHl1eWeUZmz9iZRDbf6n1ELgnuoQ
 GfUL8D7ZN9LvnIHGmJ9ugwSr7n4F5XgY63wUfUaqLonWRdvn8wPwQIFyoQ9fgsATdsVjXTMDU
 CqlRwLfZSIRk0is9wO1S/KH8aUma4UX9lqJytk1BDEkGzFe5wQGwof2gxVgGd8LyaUv9ZIIkA
 +jAqxxXIVdWeikN9xK1vbQgO6jLdVo42pz3NovAzQhHkmd24fKEuztI7yZKxLfG7B2UYRfpUD
 QpbBinElNnCqAK4XHUQXgmc/xGCR4TKxu5znqEbcIkr2UxGSsL5N+T0GcQvasYeU8fhKeVhPF
 P18MNlx6i6oLqSxrQfbQRDWBV4BPzlN9nP2efMNW6wYzUQY+bWT1Xz48J2hepE5goFf1Y8CJI
 Fd/akOCi2PmMkWswk6X3S3p/xlwSglktz2MBG7bflGqyWSd26y9/JQC7+ci3+43vne2FI2q5l
 9OV6U9PAk7vRLK6P0JGQEwGl3KQUh3QWh5Yys3KfDlHE9cCCTEIp7VmrE0o0OIwJFWht1TAym
 GeLp62ociiJB35xrlv9WD74nVPigxWX5rTSVNuB8i/+Uq3cpiAMKT2+h97HwLXTZdUyAKdwSq
 MHvVw4g4+5fJKs3A0wYpbEs7suOXX0h410U6Ggdk+NmUdOeGZr4Qnrbu0jdHskfPBqfkriMky
 PnIgnBRu6EK+I5t3spcKLzyFoF2PQuIn5AAMm7m4+/gzmtj27l2q6Rw6pkzg0n5tkeOFpksg8
 3+sklyLhYZgBEuLQ2+EEVuCjk86Q+llynjhQ4aZn/zgGe9o5n7sO6fT2iWzRUUtaJmVePs+TF
 fCR91QEG+YU5vVko1Nah8STeFEWTpJrAtOKlXtg8/9p3O7LJYkKiPqj8Z+TbFvdAbdKXtw9Ff
 WrPO52y2y6MhLArDPdH0QE7s5e8EKvvaLJvlIs4W9B8HQygeQIVrUgorlGQFC35GLIwK/HxNn
 /TuTQPgAv2o5m10EtlIKYTAPaCqjg0gWpW8wBjEfBYgMiEOX+efx3x5ldMVneujH9CFpsSjAO
 JH3uXK9ekcWbNMuxGvTAIee9b2n0IKHWI4easognE5qT7KucyOGSYyvHsw7IQPjv45O9SfNSK
 AL5SeMBxLyhlCUSaFlwhjT3guNk1o/JS1FTD0E5gpmNLrLk3H8GawmklUNwJ1omCI9Lh/ugxj
 7OsCAwhnqf2fWjImq
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lSthIG7HaTCYsW0AUdUTcDC95XELszSWW
Content-Type: multipart/mixed; boundary="iQz3uZLExZiQmm8n6lllbmPhU0gbnrIMt"

--iQz3uZLExZiQmm8n6lllbmPhU0gbnrIMt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/26 =E4=B8=8A=E5=8D=882:57, Goffredo Baroncelli wrote:
> Hi Qu,
>=20
> On 3/25/20 1:12 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/3/25 =E4=B8=8A=E5=8D=884:00, Goffredo Baroncelli wrote:
>>> Hi David,
>>>
>>> I noticed that in btrfs-progs - volumes.c in the array
>>> "btrfs_raid_array", the info
>>> raid_name and bg_flag are missing for the item BTRFS_RAID_RAID1C3 and=

>>> BTRFS_RAID_RAID1C4.
>>
>> In devel branch, it's between RAID_DUP and RAID_1.
>=20
> Sorry I cant find it. In the devel branch (last commit
> be952386cab3973b3e15434495d0070d5479516f) I found
> $ cat volumes.c
> [...]
> =C2=A0=C2=A0=C2=A0=C2=A0[BTRFS_RAID_RAID1] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sub_stripes=C2=A0=C2=A0=C2=A0=
 =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_stripes=C2=A0=C2=A0=C2=A0=
 =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .devs_max=C2=A0=C2=A0=C2=A0 =
=3D 2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .devs_min=C2=A0=C2=A0=C2=A0 =
=3D 2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .tolerated_failures =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .devs_increment=C2=A0=C2=A0=C2=
=A0 =3D 2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ncopies=C2=A0=C2=A0=C2=A0 =3D=
 2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .nparity=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D 0,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .raid_name=C2=A0=C2=A0=C2=A0=
 =3D "raid1",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bg_flag=C2=A0=C2=A0=C2=A0 =3D=
 BTRFS_BLOCK_GROUP_RAID1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mindev_error=C2=A0=C2=A0=C2=
=A0 =3D BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET,
> =C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0=C2=A0=C2=A0=C2=A0[BTRFS_RAID_RAID1C3] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sub_stripes=C2=A0=C2=A0=C2=A0=
 =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_stripes=C2=A0=C2=A0=C2=A0=
 =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .devs_max=C2=A0=C2=A0=C2=A0 =
=3D 3,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .devs_min=C2=A0=C2=A0=C2=A0 =
=3D 3,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .tolerated_failures =3D 2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .devs_increment=C2=A0=C2=A0=C2=
=A0 =3D 3,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ncopies=C2=A0=C2=A0=C2=A0 =3D=
 3,
> =C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0=C2=A0=C2=A0=C2=A0[BTRFS_RAID_RAID1C4] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sub_stripes=C2=A0=C2=A0=C2=A0=
 =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_stripes=C2=A0=C2=A0=C2=A0=
 =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .devs_max=C2=A0=C2=A0=C2=A0 =
=3D 4,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .devs_min=C2=A0=C2=A0=C2=A0 =
=3D 4,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .tolerated_failures =3D 3,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .devs_increment=C2=A0=C2=A0=C2=
=A0 =3D 4,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ncopies=C2=A0=C2=A0=C2=A0 =3D=
 4,
> =C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0=C2=A0=C2=A0=C2=A0[BTRFS_RAID_DUP] =3D {
> [...]
>=20
> As you can see the items BTRFS_RAID_RAID1C3 and BTRFS_RAID_RAID1C4,
> missed of the fields '.raid_name' and '.bg_flag';
> if you look at BTRFS_RAID_RAID1 item, it has both the fields filled wit=
h
> "raid1" and "BTRFS_BLOCK_GROUP_RAID1".

Oh, you're right.

AFAIK there is no special reason not to add these members.

For the bg_flag and min_dev_error, we have it defined already, so it
won't be a problem to add.
For name, it's just a string, even easier to add.

Feel free to add them.

Thanks,
Qu
>=20
> Am I missing something ?
>=20
> I am asking that because I need these fields. I don't have problem to
> issue a patch about that, however I want to be
> sure that these fields are not missing for a some valid reason.
>=20
> BR
> G.Baroncelli
>=20
>>
>> Thanks,
>> Qu
>>>
>>> Is it wanted ? Which is the reason to do that ?
>>>
>>> BR
>>> G.Baroncelli
>>
>=20
>=20


--iQz3uZLExZiQmm8n6lllbmPhU0gbnrIMt--

--lSthIG7HaTCYsW0AUdUTcDC95XELszSWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl58ANUACgkQwj2R86El
/qhl4Qf+N/2e5HpTOLuhqxHBu6bGB110m/pAsg8w5z3zFlzdLSJnYFe2sBXzAiyK
0bmKm3421/99RYq05bA+D3RpP777NVTcnqI25GvF4JOFdwEDsTYgRkcKgqb2n3ji
Q++aG/wl1sZ0NQh1fjrbkkdya9BPe2cSKykdMCTZyfP/W0HM63vr1PahjpoXGhIT
QXQkJhEkj3Sq2xnrY07f9aQANdxh2p7lJU6aDz5ARM/MX2juvNrmXy5zpJp3j5DZ
d6EFctHcRQ4TIDajPuKd8KiLZsbWSH/MxkJzD1Z8vqZwwES5+l9yrjKEUIVBb9sc
7wlHEWXBids+qDn7NsvipLEDfcC4dA==
=vMGp
-----END PGP SIGNATURE-----

--lSthIG7HaTCYsW0AUdUTcDC95XELszSWW--
