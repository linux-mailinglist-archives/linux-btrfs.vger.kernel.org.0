Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F812A2CF2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKBO1e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:27:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:44085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgKBO1d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604327249;
        bh=Lz4CHuxJ6bxfY/uReFEP/XzTf0MrWTkBnnHglvzVvoE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZDokUzmQYERRcF7Iv5eAa8SRZSS6co6E0Oz5FsLB0sw0kDcw7RSEhqr82/ZE7AcU+
         dLcq8eOdxcSHL7TtrdxZ5g1Y3W8842WA4oMmX3C072ERAxcXgm6ZDp3PmAaS2Sy5kX
         FYeszxk9NageBI141i+MyboHdfucaKv6QWjqpvPk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJVG-1k6YiP3WPW-00fPxW; Mon, 02
 Nov 2020 15:27:29 +0100
Subject: Re: [PATCH 05/10] btrfs: precalculate checksums per leaf once
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1603981452.git.dsterba@suse.com>
 <33195f212e58bb0150017b3c1ac6df5c2d8c8dc7.1603981453.git.dsterba@suse.com>
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
Message-ID: <037ace4b-0293-f43d-f340-68e766c6fd3b@gmx.com>
Date:   Mon, 2 Nov 2020 22:27:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <33195f212e58bb0150017b3c1ac6df5c2d8c8dc7.1603981453.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="brj91k2i9dRcSZaS4lm5BHSGIs6wt4uc3"
X-Provags-ID: V03:K1:vKubtPHQy5XJBLaz80snfP1p/E6hbw+DgOIX1Rc/j7JFUo+StA6
 U0z/EO69qdpJvnEVINu3hZCNv7JZoo4fzAdfFnw2Rwl/JLu9H1JLvuVreF3OJzx/2OuVgN3
 7pzXq2kFNc2pgFSaGrpTaWt4cRldj79LeOkNMtyHOFDVK3bMySkRqhm9bAKi8Aa7bCcxMme
 o/kH4KscF2RDUdD01SEow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:57GBETaO+R8=:BsnMyXcMCHnZAZbRINdiMv
 pqY2lbWi3nwyQgKGZ2m22BRVOB6OXNPfhf6chJ4yDmPNO/lxbOZ940303cDplCm8z2cN7l2kw
 98QId580GB0H0ZirGm6rEQgbo4wuFWkAp2U4kp1tzuo89N84+2zXVnxqRgnt0At3soSNokQoS
 sLluLNkrNvsMSefpIFj6MVEQeRXiRIVpT0ZvjtG45AK8l8QDkLnh6zGFj/oCIeDbf6dmczwjP
 pVEAEsbMxxh+hKIlesxQbHGx+6Y9UJU2J3CpqbxjcHjEPLkd+KVyOz8ppwsRHa492kBg6wn8e
 7VXxRx9X9naJJwDDphIGlwEZ7iAhWFkDZ9LP0EizlCftMxJSR/qEUnvlcf+Fn9Ev+08TjTYpJ
 BaZPvI2eHG/kNk19xClc5JCdKcgmzoUZd6KgggbkmEQTWiV9EUv3zKYxlICdm8J0NbhdnqRes
 7IpbkcbRmFKllnw++OkbfzXdiRnQ/CNYZZHcwFRyPq8qTkiKRTXbjTTI5um7sFRwJ1yKmSm8n
 E9NzXsL7HCbnuBtn2C69WRbT+f8Umewkfimo+vdfqicLu9n/iWkkQX9AvZtLr/iZlCEYIk1N7
 G/fWphBmeJHENUL0pluLDjx4XXe0bWst0YiWAYD1KZs9FMPq2TAbbEcOzGdL/u1xFCNhDnBeZ
 zC1zO+/lS3oPzjjimuL5O7JCYfimG5Fu7/Vh90iQRNezcZu46N6UyJMw+9ZPJVWkNY7LwLw4J
 xMOLrpDtkJrZhkGa18jmXDd7f/Cu5jnVgY/kZjk5ltsnbW2D0Fjwkvy4VOYCqoMKE9asBV6tl
 Yo2n0aplQEqMoNQuL5l1LABt+DN5vm3TgPjxs+l0ylYelhnnCHjSurJTW3j1BmkHM7VjSs3/5
 IUGpuYR2bHw5yfbnAuuQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--brj91k2i9dRcSZaS4lm5BHSGIs6wt4uc3
Content-Type: multipart/mixed; boundary="2u2dFhvxpmfAeeITh6MRs2hmrYHmiha4E"

--2u2dFhvxpmfAeeITh6MRs2hmrYHmiha4E
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/29 =E4=B8=8B=E5=8D=8810:27, David Sterba wrote:
> btrfs_csum_bytes_to_leaves shows up in system profiles, which makes it =
a
> candidate for optimizations. After the 64bit division has been replaced=

> by shift, there's still a calculation done each time the function is
> called: checksums per leaf.
>=20
> As this is a constanat value for the entire filesystem lifetime, we
> can calculate it once at mount time and reuse. This also allows to
> reduce the division to 64bit/32bit as we know the constant will always
> fit to 32bit type.
>=20
> Replace the open-coded rounding up with a macro that internally handles=

> the 64bit division.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.h       | 1 +
>  fs/btrfs/disk-io.c     | 1 +
>  fs/btrfs/extent-tree.c | 9 +--------
>  3 files changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 1f2162fc1daa..8c4cd79b2810 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -933,6 +933,7 @@ struct btrfs_fs_info {
>  	u32 sectorsize;
>  	u32 sectorsize_bits;
>  	u32 csum_size;
> +	u32 csums_per_leaf;
>  	u32 stripesize;
> =20
>  	/* Block groups and devices containing active swapfiles. */
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 25dbdfa8bc4b..f870e252aa37 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3079,6 +3079,7 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
>  	fs_info->sectorsize =3D sectorsize;
>  	fs_info->sectorsize_bits =3D ilog2(sectorsize);
>  	fs_info->csum_size =3D btrfs_super_csum_size(disk_super);
> +	fs_info->csums_per_leaf =3D BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->c=
sum_size;

I guess here we don't need any macro for division right?
The BTRFS_MAX_ITEM_SIZE() should follow the type of
BTRFS_MAX_ITEM_SIZE() which is u32, thus u32/u32, we're safe even on
32bit systems, right?

>  	fs_info->stripesize =3D stripesize;
> =20
>  	/*
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 29ac97248942..81440a0ba106 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2138,17 +2138,10 @@ static u64 find_middle(struct rb_root *root)
>   */
>  u64 btrfs_csum_bytes_to_leaves(struct btrfs_fs_info *fs_info, u64 csum=
_bytes)
>  {
> -	u64 csum_size;
> -	u64 num_csums_per_leaf;
>  	u64 num_csums;
> =20
> -	csum_size =3D BTRFS_MAX_ITEM_SIZE(fs_info);
> -	num_csums_per_leaf =3D div64_u64(csum_size,
> -			(u64)btrfs_super_csum_size(fs_info->super_copy));
>  	num_csums =3D csum_bytes >> fs_info->sectorsize_bits;
> -	num_csums +=3D num_csums_per_leaf - 1;
> -	num_csums =3D div64_u64(num_csums, num_csums_per_leaf);
> -	return num_csums;
> +	return DIV_ROUND_UP_ULL(num_csums, fs_info->csums_per_leaf);

Since it's just a DIV_ROUND_UP_ULL() call, can we make it inline?

Thanks,
Qu
>  }
> =20
>  /*
>=20


--2u2dFhvxpmfAeeITh6MRs2hmrYHmiha4E--

--brj91k2i9dRcSZaS4lm5BHSGIs6wt4uc3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+gF00ACgkQwj2R86El
/qimUQf8CVnc7OqePB4SILqp8JV8n7mBFVPN+1GnAO5+itrKsPJOfkC44aapQm+I
ZBkF1h9Kvy2XV4NL6hd5mHsdkCQyE6UbAWozIlzjTGrjZjff/CvbdSyvD6aE6y2u
oKF6xqMAfftu4wGX32cg/K0ocnwRid437BmNnjx0ohOAAtqc2ePM6PukaJt00azR
T7420o2ze3AvjuSl2qquBFW1p23993nNyq6FuRJWWtl0yZbo7bd1L2SNORxJIZfW
0qJew34Q7E1bYSmmJx9/uqYkGlhYjuz+2UOTu5qWzUJ7Lh2gnfzAj89CdDdT2S/B
0bI/LvoItMLzI5V+hscfGVf+mhfUMQ==
=3/cq
-----END PGP SIGNATURE-----

--brj91k2i9dRcSZaS4lm5BHSGIs6wt4uc3--
