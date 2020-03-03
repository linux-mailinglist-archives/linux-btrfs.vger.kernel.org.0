Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9287D17695C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 01:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCCAcA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 19:32:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:53655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgCCAb7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 19:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583195514;
        bh=kNGE0Rl2nD3lklkR0tBX7sWbzKXng3SRHFzQbR4BLjo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=N2dyALouVJjSqhiw9i9F3g7FEvMC6oNkZP0zU7ceC9/uw/iLlLY7DGECKPkzbvdh+
         UJpKr6e0ZOhcrOzmRKJOoyV0ii/ZWP809wl9D+JdhxjXoTUoVB6ewQaIfFrQEvYokD
         RDUFQeqQcOYeO949mJ4qMg2rPuKF+Q0YFNqriN6s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MplXz-1jinVk1ljZ-00qFEr; Tue, 03
 Mar 2020 01:31:54 +0100
Subject: Re: [PATCH 5/7] btrfs: clear BTRFS_ROOT_DEAD_RELOC_TREE before
 dropping the reloc root
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-6-josef@toxicpanda.com>
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
Message-ID: <0b219848-9cbc-400e-e967-3cbab2fcdd4c@gmx.com>
Date:   Tue, 3 Mar 2020 08:31:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302184757.44176-6-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FLCvvYgSpEeYmFbivSxsjklPfa7pwLN9Z"
X-Provags-ID: V03:K1:AOrsbgCSFHsP7tR16ZYOWJeB3h1oMTuDu5GqLnP4HnIdOdWym4v
 bkSTVTrMtZuglv0hG84JfiDyd0V2Ge9cJVCPrnhlBaqeW8veIXk4K/DiNJpWiyncUU4bBfH
 I/AVhUnVbJw4ZZ0XX3PFVYsD5jwktk67dWa4ubut1j5RD3ymfdZAkrYQqrCfn+u5SI1EF4d
 eEpsvI/8yZPnQ7U5XxI7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O2miL/HjGSI=:vddlUFO+WB+uisWuoNREr3
 7Mpot+mJ4m/YoeP4fOcc721R2s9DAksmSm1uyOVRUen8e9WvhfdnAOpTjEaZDwvt91v5WaoDi
 6fLovBzmPm7VA74bjGP20genIcoLIFv//vvSZPFgMeUW0AB4YHoopJSqYbnKXiI6PbujQX1kQ
 5e++oJlaUkxuOmWMNP3a44cm8WdmjnmuZpE34dTUZN79cY07AVxBSg7RvTKD0N18oPJbiJKL+
 DFcYjGH8YMyQf+/41h5AMC73FR1yPLO7+VvCXTYbIcKm/B4vYeGnxuHTkmohl0XU02SortyYy
 ISuZn6IZnO/AQMPGOADo/sApgQYSK/UWefutcL24WqRlHd49QT78Ehtf78t/3oWLIVkzPFwiX
 RnaYmSScTRScvQar+Lo1eFJECJpOKgYNEUDADVxtLXdXlxXRf1wwwDs4dSY0oHAvPKGPKZkZl
 +jwnVkNwGTkUtj/GwBI/lcfFF4VuYX4sfM8GEpD+BToB3x43BI8KDWLeY6EAFvvKiRkEnZb7n
 N2VN7uZBKuJwvXGLvoxYc2AWS8wFyW6weFQbE0wn4dPzaakHy8eLmlFt6HYuMJ3LlzsalBVqi
 3lO2TVqcznNnrTDSGiQclSqGMdlUGFG8JK+0Y0ENKiOfMYxZPlHgdzlalbhSCJE+81ysZgGOg
 oftxlIn6ZloU8tktPUv3u1IIsoV9medTJJM+mJeN3nMMEIiDUBrmsGp2az3DAJ7vxEIFejJrs
 CxterUPOflec79OQxeBLy/CouJhiAfEzlMZLqoHQxfjTXvgYcj3SATgIG4bAz8sDctqZYqalj
 gnBB+C8W+NyoGrpW1d1Sxb3s+cyzjYumbU19yJbNQNhYgS+AWhkqVZRYYRQKzgM88KYrIkpcB
 rdwdGgm5WakedikYb1C5GsD5QR8RelpyphE76nwDnJ0AmuZWieWVdp1eLBpHTKzWBXuJr16tG
 ojeywC6BNPuVZXSXGksxsPq4BY1A2XLeRUHZHppwSrEzjYoITCJLfNb4vIuOgmKT4hZoiwbxH
 IwW6DpSqLl8upvoZ0BMrPMgaSg2Qfs1+aEDVb40I3kJwx795ycy7GTTHrwk1sEHQrtXjSiz/C
 MvSRNc/8Tx/Ee+A1+nFAYKY8EBTO5Ua1NyigY7+FXQMRLiyCegW+d3nbJKsh7xF4U3oI9vqp3
 CpyGx2OaRhyUNurIoxSiT2MyVmG3cJA6y8x5S8QRbXvc83brIOFVt8XKSSOIeitfh4T16ZVRe
 BCYBNAGwy7eHO6oXt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FLCvvYgSpEeYmFbivSxsjklPfa7pwLN9Z
Content-Type: multipart/mixed; boundary="O7GB2XNrkrOfcysS0yroSGYiuHWSiccbG"

--O7GB2XNrkrOfcysS0yroSGYiuHWSiccbG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/3 =E4=B8=8A=E5=8D=882:47, Josef Bacik wrote:
> We were doing the clear dance for the reloc root after doing the drop o=
f
> the reloc root, which means we have a giant window where we could miss
> having BTRFS_ROOT_DEAD_RELOC_TREE unset and the reloc_root =3D=3D NULL.=


Sorry I didn't see the problem of having BTRF_ROOT_DEAD_RELOC_TREE and
reloc_root =3D=3D NULL.

The whole idea of BTRFS_ROOT_DEAD_RELOC_TREE is to avoid accessing
root->reloc_root, no matter if reloc_root is NULL or not.

Or did I miss anything?

Thanks,
Qu

>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index e60450c44406..acd21c156378 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2291,18 +2291,19 @@ static int clean_dirty_subvols(struct reloc_con=
trol *rc)
> =20
>  			list_del_init(&root->reloc_dirty_list);
>  			root->reloc_root =3D NULL;
> -			if (reloc_root) {
> -
> -				ret2 =3D btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
> -				if (ret2 < 0 && !ret)
> -					ret =3D ret2;
> -			}
>  			/*
>  			 * Need barrier to ensure clear_bit() only happens after
>  			 * root->reloc_root =3D NULL. Pairs with have_reloc_root.
>  			 */
>  			smp_wmb();
>  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
> +
> +			if (reloc_root) {
> +
> +				ret2 =3D btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
> +				if (ret2 < 0 && !ret)
> +					ret =3D ret2;
> +			}
>  			btrfs_put_root(root);
>  		} else {
>  			/* Orphan reloc tree, just clean it up */
>=20


--O7GB2XNrkrOfcysS0yroSGYiuHWSiccbG--

--FLCvvYgSpEeYmFbivSxsjklPfa7pwLN9Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5dpXYACgkQwj2R86El
/qjIVAf/QI90Z8GzXtB9n6gCAjsMOZpjCs5Zk980R2JZAxBwLzoFndngvPmJh+47
EY3y1mjVBtuOuyZtysdU84du07M5kxwmCsQ0J5nRqqXaVdOYWCaCngkmgFHFNAsk
9kOu7OnVOMKWIo5ggMF4YugYN9Ncx2djlILzAVEYg3Plb6raxsIFpr8Hy6/pCv2f
7sZx/SqHljS+dORTReuXVWTMj3yKKsYEJHi5KU0KNnkZgai34tW1vgp1quPdEqLd
W1hRUvK4jqIXrczUKVWNi8GgscsH21lBtizVbE/UJjCjAZSU5ruwnWTBJarnWWQ2
mDFkGpZJkIhMdfdRN9/DGDu/PM0PgQ==
=n6vw
-----END PGP SIGNATURE-----

--FLCvvYgSpEeYmFbivSxsjklPfa7pwLN9Z--
