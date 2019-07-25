Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 332DC74DBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 14:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfGYMGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 08:06:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:47433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfGYMGS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 08:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564056373;
        bh=6Tgjl6lwlMac9hbGlzgs9WInYXEgMSNVWN4c77uGaKw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=a5p4xf1d5WKvOfOHtVQ1o+7Orv3Ik1LkS45K/9rjBej+C+L5XsURMeV9lrOHxFA5G
         hcpo/KPdb+BMTJgXLg8zyW8UPpB5fqWpwo21zGLaGg1OFvVREJqmipH9209gyCUuwK
         Ho1YB0GaQ5bxU5+M/PQZAz0/PYMuzqqlS2N4TwSE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LnOve-1iKhvm2FYs-00haVd; Thu, 25
 Jul 2019 14:06:13 +0200
Subject: Re: [PATCH] Btrfs-progs: mkfs, fix metadata corruption when using
 mixed mode
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20190725102717.11688-1-fdmanana@kernel.org>
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
Message-ID: <842947a9-7547-d38e-dd0c-866c8abeb725@gmx.com>
Date:   Thu, 25 Jul 2019 20:06:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725102717.11688-1-fdmanana@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VZcnLmsLQTP9u4yYklV8iQBU0HHKqv4zK"
X-Provags-ID: V03:K1:wwlscXGEuq5AYnEqqBZF9aIAW8VyKi3E4hmmvMIgZiRtIg92uCL
 Ls6x56+qCcOW3kU0nxWSiBdnG6cL+grb95U3jHSQ+6nykHlZcCP9tXhQhC93LMA3j/6zlhJ
 8Z/LzMZLgTzJVkQNp0yDXuKxplzecd1L8lvqogavEa01L4zaNFwQAJLLL5i18PtNq7OSS4j
 DdFw5Y7cglPM/sHxptB/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2wrsgv+qvBA=:BM8Ii1umor7roEARz8DMP7
 GX9mBI188PaX29w8PNYuANMOBhsFWRngWovEjSJm8c4e9xoclpOsyXgBJ/AHfhO/gPalZKLUJ
 WG/FE2l5YXoX3ruchva03l1v/h2NUiAyWtY6UYO+iTU7U4RbhGtJpX0dVR0WNL+hKOt33uzZ7
 0Ed2xPHg36JLoNQEwIcF/J2oW6H0LQ8GoQeC0yatQ+ln/CfzvD2SXxRHenu1tHDRg/H/KXXf5
 eScnMOpwnR2Gta6StPvj45iTsNSBKQLnzVdV8jPxL2LWUxOGAXpdM5t5ACUcMDv2TQmOt/hig
 ZT8aFSW/hIFFBSxBAJujCHE8fCec1hlPEjD47i3b0fQo7fWznpmVNFlCgwhwTKua7mngzqPN1
 GdvFEvJ/cVtgpnYNl+ooqHPDd2paxIxg7xAobwB0eMfGeb78P5p1u+m7Lgj2UMHMCsW3egEPb
 ykEvLo06Z2fU4q/n6BdFsx6v/GmG3GKhDXoBD6awcbqHcrEBtOZINVpcrBkRTIHE35482Gc6P
 cP2k+JjAruWOci/li18CParvxLTafD7TXa/F/tn+HdqqBADLKTl2Qqt5lV6uLvH2C1lpDRaxp
 Df+o7J2VgUoKoI1edC0poxbF3I5yfxINrw9psvTENn8/VhChQp7mzCFUaWqOj9vYFgDmjtLF6
 hcpcoQF0vat6AlJYOIIbdp3kGe6n8SKw5SXg9ArNdNMu325zeWgDJBSMWl8gMRn/Xa4IOpBcz
 SxenbHu7AMvHnTqB2K/BMgbyIIOWVXAzVKucc5zBk/4PfpJS6yE/5YzwRewEsFyTlw4XKjEwc
 zKo3cMciOg5tvn+5Dns/yGFmbLiSuR7h3jxFXuydzfPFmOeqk8Rz5HJ8HCtSiEd1omes9bNmi
 J0VPe7UeY3HY0BlII7m+Gl09PtS6aqu6ji2kFCBWyKXP6r10vVnjGsi9+n1IVflU36Ntf9/zO
 ASZTTio+C3a91mB83hfPidOiBAwn9WCvTsohZqT4xMlx54IbP/KE2jlTR1uAOb4RnnCSEmfhy
 DG7JN6Bul/v9mFuBeDyw4Cj+Du0kve8Ms9FbxSnxUoCeVrMlaF3kXU0Z1zOlCHuyXIYPX2gv0
 aOudffWULJSf38=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VZcnLmsLQTP9u4yYklV8iQBU0HHKqv4zK
Content-Type: multipart/mixed; boundary="OACIB2a0zeJey9jI9ZubqLX0MxNvHzpZv";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Message-ID: <842947a9-7547-d38e-dd0c-866c8abeb725@gmx.com>
Subject: Re: [PATCH] Btrfs-progs: mkfs, fix metadata corruption when using
 mixed mode
References: <20190725102717.11688-1-fdmanana@kernel.org>
In-Reply-To: <20190725102717.11688-1-fdmanana@kernel.org>

--OACIB2a0zeJey9jI9ZubqLX0MxNvHzpZv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/25 =E4=B8=8B=E5=8D=886:27, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> When creating a filesystem with mixed block groups, we are creating two=

> space info objects to track used/reserved/pinned space, one only for da=
ta
> and another one only for metadata.
>=20
> This is making fstests test case generic/416 fail, with btrfs' check
> reporting over an hundred errors about bad extents:
>=20
>   (...)
>   bad extent [17186816, 17190912), type mismatch with chunk
>   bad extent [17195008, 17199104), type mismatch with chunk
>   bad extent [17203200, 17207296), type mismatch with chunk
>   (...)
>=20
> Because, surprisingly, this results in block groups that do not have th=
e
> BTRFS_BLOCK_GROUP_DATA flag set but have data extents allocated in them=
=2E
> This is a regression introduced in btrfs-progs v5.2.
>=20
> So fix this by making sure we only create one space info object, for bo=
th
> metadata and data, when mixed block groups are enabled.
>=20
> Fixes: c31edf610cbe1e ("btrfs-progs: Fix false ENOSPC alert by tracking=
 used space correctly")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  mkfs/main.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 8dbec071..971cb395 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -64,18 +64,17 @@ static int create_metadata_block_groups(struct btrf=
s_root *root, int mixed,
>  	struct btrfs_fs_info *fs_info =3D root->fs_info;
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_space_info *sinfo;
> +	u64 flags =3D BTRFS_BLOCK_GROUP_METADATA;
>  	u64 bytes_used;
>  	u64 chunk_start =3D 0;
>  	u64 chunk_size =3D 0;
>  	int ret;
> =20
> +	if (mixed)
> +		flags |=3D BTRFS_BLOCK_GROUP_DATA;
> +
>  	/* Create needed space info to trace extents reservation */
> -	ret =3D update_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA,
> -				0, 0, &sinfo);
> -	if (ret < 0)
> -		return ret;
> -	ret =3D update_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA,
> -				0, 0, &sinfo);
> +	ret =3D update_space_info(fs_info, flags, 0, 0, &sinfo);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -149,6 +148,13 @@ static int create_data_block_groups(struct btrfs_t=
rans_handle *trans,
>  	int ret =3D 0;
> =20
>  	if (!mixed) {
> +		struct btrfs_space_info *sinfo;
> +
> +		ret =3D update_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA,
> +					0, 0, &sinfo);
> +		if (ret < 0)
> +			return ret;
> +
>  		ret =3D btrfs_alloc_chunk(trans, fs_info,
>  					&chunk_start, &chunk_size,
>  					BTRFS_BLOCK_GROUP_DATA);
>=20


--OACIB2a0zeJey9jI9ZubqLX0MxNvHzpZv--

--VZcnLmsLQTP9u4yYklV8iQBU0HHKqv4zK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl05mzAACgkQwj2R86El
/qiPpgf+Lcs7pQEcMdNUY3LiLtGWjQu9rT4IsxkOU5UkpSYKHsZAeTL9KLd/QILk
BbNicXpQHf8UuL8VUVT/Ovf0CcC2KzC5QK02anjmKPTeR8Z6FYHLv/H/K7gxxWBc
lBZzEe0tjsysuPOC6Iv5CvRkGoni0FSCDVNxQDeXOu1W6kC/mxfvVtcuT8sZdRG6
TV3PTIF1WF06LSNT6QU0cYcoR4EX5XE6AFUO8nx7h9LGK9A2hTNbSibk1zmskw32
qR9pJesndIKdrUxYGU0yQYBzVyqgWwHmuTzZXxRmjj6p5Wg8ywi7p4KmPlPr8+3+
a6QFTj/BxUW8zAGYvFsI+FPP082K6Q==
=OtCs
-----END PGP SIGNATURE-----

--VZcnLmsLQTP9u4yYklV8iQBU0HHKqv4zK--
