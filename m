Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0F8204969
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 07:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgFWF6O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 01:58:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:58751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730568AbgFWF6N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 01:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592891887;
        bh=3z113nTemgs/v57EldlzBmxRJq1TeNd6Y9xCEAwXbso=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=il7e5DJ5de0GX4DyVEJULo8s0Sp4Y05oDKj5nm3sK9f5mRyakqglPkBmuJHisZPZ1
         DkVs53hHCyoM6lZOQz4aqBlp3eFPzdhAXjmrBY/cVD4lFdDEK+7VLUKNW0MBJA4IhN
         aNJ/uz4T+W+KbkWOBzB6r+CCAq916w48xxdSgAPE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsEn-1iy7on0pvj-00svmg; Tue, 23
 Jun 2020 07:58:06 +0200
Subject: Re: [PATCH 01/15] btrfs-progs: simplify minimal stripe number
 checking
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
 <20200610123258.12382-2-johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <966bb313-20b1-37a9-f466-801b16fe8dfd@gmx.com>
Date:   Tue, 23 Jun 2020 13:58:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610123258.12382-2-johannes.thumshirn@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FdVUX7cAV5wL4Hl8UceAZHBhGQus3brTe"
X-Provags-ID: V03:K1:Acu0//iISQW6Z+HdKTeEF5G+lXQFwgJgiVzwMzg3ifUAJEUH94h
 e4asSvbZfnaKguItVG6RAS//ZGzE09tdfX+Ej6xV0Oo45pFk66wNe/1EHJUToU1d9Tk4YWY
 RixSI9u3L03YkH2GIYpOAhZ9fBRQGrRwimFmUptyL6RJmJDx07GrDv+ks8WH66Olwlg/+fP
 1hv2Zb1sxgjBCZCuVD86A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LiIeobMoZkY=:FUfMAs91Y38+r9PZYdDLTa
 k2nz0sPrKwzI2fNNUraWrrx8fC9N+PqlNoQS/GWuKzkMPUQCzsqwz4HspLH0Nq6c3i4xzg/x4
 vXgzKu+6umHcFb4O033O94XiN9Fi2aorPaUfXMY1MSA8IPIkbHnbZwD3uIOBxMC9wobDCVkRN
 TOrm0qw/dkz83urkcxvkxVhWG4WijhmEf5q+aHSm0zPaPBzF6FzH/xH7lX4pkuMaMkVZ4klb2
 R27t+kPyfrb33Blfph39eWFtl4S5XuUeBe1cHVOUfZyDhk6/j7d58YB9PCI6dV9QD9S7tGpL3
 a2QUeDZxoiX8Lz0Ko/U+N2UXyXHXMbqXmT7TLJ0Q8Xx6uNYR+h9yJ0Ctx7dIqcydtRoJnqieM
 dscUxaUvwDggnCxD1P1x0jXNE2gO9Db4wAZjqOGf+ZlEQyzF26aEIAfMQSH0p0ZT7znh3kvzC
 rF6as7X8XsXD53ThdypbHEk3Im1YpSIs6sF3DMCOibIgObYX58a/R6NyG3TlQ9lkAcvmNiAcJ
 6Gf7DlFpJh8VFHY2MtRZbVpArTEq2SVEl4AvaqeJyKUQnFU7FlE2iytfbtS/q0APP3hg1GcJj
 P9oXUYIWRyQEr1uYBDKpJh8Qu/dT7iBEQ+JYnTzPqAWE9zIWgp9n5tWTgiGavmhni7Yb+3y+g
 hNfdSsIkvP26MInWTV+x42SjpFEXVzANWKpyeGNPRrbauDANU0VTnV+EC60icF2wSEZtQnmFW
 ZsJP8ljWZCLUTNvE36/RFedtAtZ81FddNyffYac4ckQ4MdMgQ+gS2wIL1YXmaryqfb+NYia8E
 DFtcRNUmXWFTE/piYs4bEAh/fPjx88DOg3FT5rBOHoSEGAaWC+wo/oSJ5u4tsCKzUp2dG4cGj
 3aJxuDZlrpog8JmiybyHSbtMIa7ktxet+QwVqncXrkTGcf+8fqeWINSZ2Og6Du0+SmLZ5f58/
 kmvX0WOcdjD8L5tpHpns9hHX3xj8A4IAPyHTNt15mk9nn1SqVZWQDvCqigmdWhxmttnc9gjdp
 l6wWOQMZmu/lskicEB6iGrFPGrSl8KcYdN9h87ei6h9cQwvUIdraP21SU649KAC3rqUP5pCeF
 poTJi9DUh8Leg5aB6lw9dBSlYivuIkqiGeiuZU2r8R6o+0YS/im5/ymwivza8L9IvLJ45XwgB
 lvvDRV854v44iSteNu3VJNaxoI63yW8gaPIunJjSHZ1G7sli+H7NhOMBNtr3fiwHS28nvz4D9
 /cgRnpj60vBvMKP77
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FdVUX7cAV5wL4Hl8UceAZHBhGQus3brTe
Content-Type: multipart/mixed; boundary="5UXRySYKo1A4QGK2MOWrmBoMLNKaD17bW"

--5UXRySYKo1A4QGK2MOWrmBoMLNKaD17bW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/10 =E4=B8=8B=E5=8D=888:32, Johannes Thumshirn wrote:
> In btrfs_alloc_chunk_ctrl() we have a recurring pattern, first we assig=
n
> num stripes, then we test if num_stripes is smaller than a hardcoded
> boundary and after that we set min_stripes to this magic value.
>=20
> Reverse the logic by first assigning min_stripes and then testing
> num_stripes against min_stripes.
>=20
> This will help further refactoring.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

I'm wondering why we don't use btrfs_raid_attr::devs_min.

In fact, I'm a little surprised why use so little of that structure, but
relies on so many if branches to do the check.

Thanks,
Qu

> ---
>  volumes.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/volumes.c b/volumes.c
> index 7f84fbbaa742..089363f66473 100644
> --- a/volumes.c
> +++ b/volumes.c
> @@ -1054,25 +1054,25 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle=
 *trans,
>  		}
>  	}
>  	if (type & BTRFS_BLOCK_GROUP_RAID1) {
> -		num_stripes =3D min_t(u64, 2,
> +		min_stripes =3D 2;
> +		num_stripes =3D min_t(u64, min_stripes,
>  				  btrfs_super_num_devices(info->super_copy));
> -		if (num_stripes < 2)
> +		if (num_stripes < min_stripes)
>  			return -ENOSPC;
> -		min_stripes =3D 2;
>  	}
>  	if (type & BTRFS_BLOCK_GROUP_RAID1C3) {
> -		num_stripes =3D min_t(u64, 3,
> +		min_stripes =3D 3;
> +		num_stripes =3D min_t(u64, min_stripes,
>  				  btrfs_super_num_devices(info->super_copy));
> -		if (num_stripes < 3)
> +		if (num_stripes < min_stripes)
>  			return -ENOSPC;
> -		min_stripes =3D 3;
>  	}
>  	if (type & BTRFS_BLOCK_GROUP_RAID1C4) {
> -		num_stripes =3D min_t(u64, 4,
> +		min_stripes =3D 4;
> +		num_stripes =3D min_t(u64, min_stripes,
>  				  btrfs_super_num_devices(info->super_copy));
> -		if (num_stripes < 4)
> +		if (num_stripes < min_stripes)
>  			return -ENOSPC;
> -		min_stripes =3D 4;
>  	}
>  	if (type & BTRFS_BLOCK_GROUP_DUP) {
>  		num_stripes =3D 2;
> @@ -1085,32 +1085,32 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle=
 *trans,
>  		min_stripes =3D 2;
>  	}
>  	if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
> +		min_stripes =3D 4;
>  		num_stripes =3D btrfs_super_num_devices(info->super_copy);
>  		if (num_stripes > max_stripes)
>  			num_stripes =3D max_stripes;
> -		if (num_stripes < 4)
> +		if (num_stripes < min_stripes)
>  			return -ENOSPC;
>  		num_stripes &=3D ~(u32)1;
>  		sub_stripes =3D 2;
> -		min_stripes =3D 4;
>  	}
>  	if (type & (BTRFS_BLOCK_GROUP_RAID5)) {
> +		min_stripes =3D 2;
>  		num_stripes =3D btrfs_super_num_devices(info->super_copy);
>  		if (num_stripes > max_stripes)
>  			num_stripes =3D max_stripes;
> -		if (num_stripes < 2)
> +		if (num_stripes < min_stripes)
>  			return -ENOSPC;
> -		min_stripes =3D 2;
>  		stripe_len =3D find_raid56_stripe_len(num_stripes - 1,
>  				    btrfs_super_stripesize(info->super_copy));
>  	}
>  	if (type & (BTRFS_BLOCK_GROUP_RAID6)) {
> +		min_stripes =3D 3;
>  		num_stripes =3D btrfs_super_num_devices(info->super_copy);
>  		if (num_stripes > max_stripes)
>  			num_stripes =3D max_stripes;
> -		if (num_stripes < 3)
> +		if (num_stripes < min_stripes)
>  			return -ENOSPC;
> -		min_stripes =3D 3;
>  		stripe_len =3D find_raid56_stripe_len(num_stripes - 2,
>  				    btrfs_super_stripesize(info->super_copy));
>  	}
>=20


--5UXRySYKo1A4QGK2MOWrmBoMLNKaD17bW--

--FdVUX7cAV5wL4Hl8UceAZHBhGQus3brTe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7xmeoACgkQwj2R86El
/qhETggAsdM/gleCDDVAe7si5tx690vYP9iHlZeuGMMC24vatosSqDE8Pa02oPtP
xr22A5m6RJEgahoag+imztBjoTBRk2IxKLZYENAbNw4eKwQAiO8Yme+t7wX7BTuB
LD0SQiXLI7Z3SIVl605RVlY77zuXj7sK6uYpLxQQ8j/0hvY+UdwM1xyYxSNwrSNs
RAznsWqR2ZaVW2EsSQp/8QxA9uRuSmHYUMT6z0GZqlPnFYUwr5n/LBzTiuU3xOe1
Sy3jgyTbeznz80Cmtk34Z0uYKva3JlaNSnuaoy2WmLPJbEugIpliXoK2wn6ulPdc
h7gBCvzMOH/drUkOSIIdWR881rWjmg==
=u3Bo
-----END PGP SIGNATURE-----

--FdVUX7cAV5wL4Hl8UceAZHBhGQus3brTe--
