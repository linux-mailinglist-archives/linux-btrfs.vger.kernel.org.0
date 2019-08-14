Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D9A8C5B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfHNBzC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:55:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:34325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfHNBzC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565747695;
        bh=fEoCTOgDMsEOv71uW6ftOaEejBRD+B5WSPqmTi3N0Iw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XEoQjo43swn734vLG5Hswd9coSt8tWdAYa3UjlN0KB/dQ/z3alWVSTZbKQfI2nWCD
         7iytn0jjAZQzkPfZVllVLkso8wHsosNWApB420A7bCY6OE/fssUndVgVwD3+7QJDOq
         U5IMi3M6NM8cnpx+9M0RwIIFtztOE2eMCQ0EMY/g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MEFIm-1i4I4M0NSK-00FT1S; Wed, 14
 Aug 2019 03:54:54 +0200
Subject: Re: [PATCH 5/5] btrfs-progs: mkfs: print error messages instead of
 just error number
To:     Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
References: <20190814010402.22546-1-jeffm@suse.com>
 <20190814010402.22546-5-jeffm@suse.com>
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
Message-ID: <c8c2eaea-104c-40c5-a85c-59dd2f4a4687@gmx.com>
Date:   Wed, 14 Aug 2019 09:54:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814010402.22546-5-jeffm@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="saCv1Yx2J4RVJFhf6KCybQh7bvO6yto3P"
X-Provags-ID: V03:K1:gpcxmHY8KumlCOH3K5kNvNm9h91d7ibR7EmdC5rZKsJJkc0U5D6
 dgi+fqOdUL3BY1jBffEPGj87wtfd2FHifAyeQf7rRbFv4Ruo+CneUFPrjDBZA3Cl4xPsrhW
 oKadWY+nbeVBGUzpQ5fdVQPS+FcirFyUiI5OPWkQwLi9gXU4tdDq3DrKJHbG1iGBFKaTrUj
 RdUfIxDWGJ0UobFjZqzzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:COZSOrAMRNM=:rP/giXxHD8c+i61lrrkr2D
 Q8673BfUyfsmS8K8GG8WyaSuwF29J7JCQnXrn2w9TEtENrQXamj3Entni+1rMzTtdQIDXhQjI
 AQtJyF3QS/AdFhb32WMkmjVZ4N0QrRsWpzLeBJD+KCzwGR9mOCgqspmfRzmKNzYErxX+tUUbQ
 euO/XG0a8rTAwjF3NjcBbglSpOpVtf6U0wq4E5YZRXuQzJbudbYPqzsnHnnYB7Yw9Ueyha4Te
 Dsr7CDFkoe3uK4Zw35ap310MDJnuM8BkjHFz/DozdCJKBEyffa2wzMVFciXe2sihqGGGzYGh7
 1DyNwDyZU09db9wlvzQxJLkJ2etXGWH1ZmrFd3MDXZk4eGURPctVnG4i5Kz5EanxzbtAN6V2o
 X8JO1+FpmS04YFmTPHpqA4XDTZIVA850MmNzDpBQugUPxScZvNYtCFgTqFm9Lx2er8QPSm/dt
 yeH+zKsN9IPHob1kUp+jisfLF9kDKeOZdmIBvIt0LE7t9MO7Zl0yZQDgkllGrhwr20Bs62yTZ
 Iz4v/ByU8C2Z2kH2eevMYbDWoFT16lnrl0dPtRnKvH8o3KU2WBkEFtKpR//mOzC0rKmcDaF3I
 Cbeu5O+Q4jDMdPiMRx33dN6sWzPodqnQ633fTbEajDFpH4+3mYWRNWiTsxb6us8i/WikcP7uz
 FnSGKegpU6gPmJRh2sN+XpOOCJiy1P/nMpQQXXILVVrpXAYBEY0Fo7bo/pT4amoz9D9sop4/4
 bgZjOsucXTinbr7TNWjOEf/CTHL65wxWAN72I856w9SzIWbsMugef2IjMf6tpXEnBohTO+Ijp
 hMhTpFIlwXjIokfXeFq0DKlbSBu+79cNgWsPcaSQIaqysPOhgeEGoHzG5GatodspgQTw3o2LQ
 2XEdGoY7MEu7mJg4DR2qzYcsg2F3PIZ++uPlhMq/NzuJHVDC004CH2KPAY9Cfs3Un/uzNMAFQ
 cF3PzQZnJYPIfDVY4kj3MX9psEd/3RkMkAKdLd2rX6mu+5BV4Fg2RzAZJoR/XkAvQ7riUUtPc
 kVYtEhEy9TQUH4CkMmlCGtcjHhFD+yO/+F/9djbSvr6zgBJvH4dsMVHs5NevVpbjJ1xp+LrEf
 UQM1ZvbbF5XKt6Zh/xAaLNBcxZhVYDcGQq6pvi+J/mOA4YKITOmFAiVFA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--saCv1Yx2J4RVJFhf6KCybQh7bvO6yto3P
Content-Type: multipart/mixed; boundary="lBD7uIOIvk0gAajNwrIjQ6EZrGwiYlvKL";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <c8c2eaea-104c-40c5-a85c-59dd2f4a4687@gmx.com>
Subject: Re: [PATCH 5/5] btrfs-progs: mkfs: print error messages instead of
 just error number
References: <20190814010402.22546-1-jeffm@suse.com>
 <20190814010402.22546-5-jeffm@suse.com>
In-Reply-To: <20190814010402.22546-5-jeffm@suse.com>

--lBD7uIOIvk0gAajNwrIjQ6EZrGwiYlvKL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/14 =E4=B8=8A=E5=8D=889:04, Jeff Mahoney wrote:
> Printing the error number means having to go look up what that error
> number means.  For a developer, it's easy.  For a user, it's unhelpful.=

>=20
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  mkfs/main.c | 47 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
>=20
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b752da13..7bfeb610 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1197,37 +1197,43 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> =20
>  	ret =3D create_metadata_block_groups(root, mixed, &allocation);
>  	if (ret) {
> -		error("failed to create default block groups: %d", ret);
> +		error("failed to create default block groups: %d/%s",
> +		      ret, strerror(-ret));

The new trend is to use %m.

So we would do something like:
	errno =3D -ret;
	error("%m");

Thanks,
Qu

>  		goto error;
>  	}
> =20
>  	trans =3D btrfs_start_transaction(root, 1);
>  	if (IS_ERR(trans)) {
> -		error("failed to start transaction");
> +		error("failed to start transaction: %ld/%s",
> +		      PTR_ERR(trans), strerror(-PTR_ERR(trans)));
>  		goto error;
>  	}
> =20
>  	ret =3D create_data_block_groups(trans, root, mixed, &allocation);
>  	if (ret) {
> -		error("failed to create default data block groups: %d", ret);
> +		error("failed to create default data block groups: %d/%s",
> +		      ret, strerror(-ret));
>  		goto error;
>  	}
> =20
>  	ret =3D make_root_dir(trans, root);
>  	if (ret) {
> -		error("failed to setup the root directory: %d", ret);
> +		error("failed to setup the root directory: %d/%s",
> +		      ret, strerror(-ret));
>  		goto error;
>  	}
> =20
>  	ret =3D btrfs_commit_transaction(trans, root);
>  	if (ret) {
> -		error("unable to commit transaction: %d", ret);
> +		error("unable to commit transaction: %d/%s",
> +		      ret, strerror(-ret));
>  		goto out;
>  	}
> =20
>  	trans =3D btrfs_start_transaction(root, 1);
>  	if (IS_ERR(trans)) {
> -		error("failed to start transaction");
> +		error("failed to start transaction: %ld/%s",
> +		      PTR_ERR(trans), strerror(-PTR_ERR(trans)));
>  		goto error;
>  	}
> =20
> @@ -1267,7 +1273,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		ret =3D btrfs_add_to_fsid(trans, root, fd, file, dev_block_count,
>  					sectorsize, sectorsize, sectorsize);
>  		if (ret) {
> -			error("unable to add %s to filesystem: %d", file, ret);
> +			error("unable to add %s to filesystem: %d/%s", file, ret, strerror(=
-ret));
>  			goto error;
>  		}
>  		if (verbose >=3D 2) {
> @@ -1284,46 +1290,52 @@ raid_groups:
>  	ret =3D create_raid_groups(trans, root, data_profile,
>  			 metadata_profile, mixed, &allocation);
>  	if (ret) {
> -		error("unable to create raid groups: %d", ret);
> +		error("unable to create raid groups: %d/%s",
> +		      ret, strerror(-ret));
>  		goto out;
>  	}
> =20
>  	ret =3D create_data_reloc_tree(trans);
>  	if (ret) {
> -		error("unable to create data reloc tree: %d", ret);
> +		error("unable to create data reloc tree: %d/%s",
> +		      ret, strerror(-ret));
>  		goto out;
>  	}
> =20
>  	ret =3D create_uuid_tree(trans);
>  	if (ret)
>  		warning(
> -	"unable to create uuid tree, will be created after mount: %d", ret);
> +	"unable to create uuid tree, will be created after mount: %d/%s",
> +			ret, strerror(-ret));
> =20
>  	ret =3D btrfs_commit_transaction(trans, root);
>  	if (ret) {
> -		error("unable to commit transaction: %d", ret);
> +		error("unable to commit transaction: %d/%s",
> +		      ret, strerror(-ret));
>  		goto out;
>  	}
> =20
>  	ret =3D cleanup_temp_chunks(fs_info, &allocation, data_profile,
>  				  metadata_profile, metadata_profile);
>  	if (ret < 0) {
> -		error("failed to cleanup temporary chunks: %d", ret);
> +		error("failed to cleanup temporary chunks: %d/%s",
> +		      ret, strerror(-ret));
>  		goto out;
>  	}
> =20
>  	if (source_dir_set) {
>  		ret =3D btrfs_mkfs_fill_dir(source_dir, root, verbose);
>  		if (ret) {
> -			error("error while filling filesystem: %d", ret);
> +			error("error while filling filesystem: %d/%s",
> +			      ret, strerror(-ret));
>  			goto out;
>  		}
>  		if (shrink_rootdir) {
>  			ret =3D btrfs_mkfs_shrink_fs(fs_info, &shrink_size,
>  						   shrink_rootdir);
>  			if (ret < 0) {
> -				error("error while shrinking filesystem: %d",
> -					ret);
> +				error("error while shrinking filesystem: %d/%s",
> +					ret, strerror(-ret));
>  				goto out;
>  			}
>  		}
> @@ -1383,8 +1395,9 @@ out:
> =20
>  	if (!ret && close_ret) {
>  		ret =3D close_ret;
> -		error("failed to close ctree, the filesystem may be inconsistent: %d=
",
> -		      ret);
> +		error(
> +	"failed to close ctree, the filesystem may be inconsistent: %d/%s",
> +		      ret, strerror(-ret));
>  	}
> =20
>  	btrfs_close_all_devices();
>=20


--lBD7uIOIvk0gAajNwrIjQ6EZrGwiYlvKL--

--saCv1Yx2J4RVJFhf6KCybQh7bvO6yto3P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1TaekACgkQwj2R86El
/qh85gf+OSK7oSCBub1sRoN9b/QylinYqAVWXCBFjWG8WI1gLQVx3LLznoJIe9iv
swbNDdJLQolCOkYLCph9NOQ+pIScZH/7JoAha9VKsWWaEu4nOk6hrJ9n4nbKGEs8
VJ1O0az/o0rzXUoU2iipXw1ZqEcceN3p0xgFJFMTqEG25/YmQOGp83iFU4sAekr4
TDsReeVEaOWErUn7Ot3pkBzl/xK1vcSeB56lSaoXp6BdEaKDT39mpezwchV5zOdh
+S8R06I6/adOAE6ns48sf4qORLEdsO6zax2443hnKIoT8nz3T2GXh4wsvwvuQRfo
MpR5UdzTX+dZca+Z+0rl3tRe9a4dnQ==
=d1hr
-----END PGP SIGNATURE-----

--saCv1Yx2J4RVJFhf6KCybQh7bvO6yto3P--
