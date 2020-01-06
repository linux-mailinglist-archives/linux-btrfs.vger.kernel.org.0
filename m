Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523D9130DC3
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 08:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAFHEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 02:04:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:43935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgAFHEo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 02:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578294277;
        bh=GFOFkt3cjmsiUGzoarsLjWYJ/pOZcnjV6tKpsy4r5dg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NDmvT6plqVFZlz4QbND7RVdrQtExAGX1wfrwB4dKfSJZabUr5DA2SpdHLHE9hT6mn
         PRb7AZr+QNAaW7A3HzLc8MZLEm6bfL3aDvv/B0vLO2Hn46l20q05uNiPtRdcpNksvx
         IYJeti3o1iehsmT6mE9Q0j5EnMuEvv6S0NBFXhPU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbg4-1j9B723ZzI-00Kz9g; Mon, 06
 Jan 2020 08:04:37 +0100
Subject: Re: [PATCH 0/3] btrfs: fixes for relocation to avoid KASAN reports
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211153429.GO3929@twin.jikos.cz>
 <74a07fa4-ca35-57ee-2cd9-586a8db04712@gmx.com>
 <20200103155259.GA3929@twin.jikos.cz> <20200103161556.GB3929@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <159ae5f2-92fd-dd71-8c6b-eac018e2faf0@gmx.com>
Date:   Mon, 6 Jan 2020 15:04:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103161556.GB3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cEzN9shfoVeOfLybbDsZXBaH7yCZb6znO"
X-Provags-ID: V03:K1:syPN8O2Lt4NVG382SUNttuPvvr6jj2KgApy1y2l3sm8zL/CnVaJ
 /07WQF74nJgsfYTWQup0Rtnv3ZiV0iKYXC1CDmQ5mgiWKqv4a+Xn1Q9FrBUuAhYpmjMzofV
 NeFZtyy2TTr3AVIZfBShpden0R0Rbw0rTb9hmngvY9K9yQwlqoELn5fHC2QirpCkAr6XcZf
 Y3lgq1esXvmTHAsuCx/kg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:62Hzi03E+7w=:8VYjxrBrO8gzAE5frpZ9P+
 kmNlUBQEn2hP2nCuzHWXbNh7ZkxdkO0Hn69VK5jKwGttDyvHl5buTrw9gQvLKRe6REJM201JT
 ilb2M8CACeVoZu9GHrVDpapOCdYuHdRAIYNg8LtvT5MDgjYNM8xf7p+s0lPLyKJjNYVd6S1bc
 odfcZ1260qlDkloq33aLoCIKI5kX5raWnCWrr0PCnhh1xwRAlNSlsSzPzSZBljxm1ll0UcpmO
 lVU47qqWsLXW8iiZjim2WYAjCWe+c9W8QcGYECo845dcg7kIJ3SVF+Urvo1FD71Rjxur4QLcB
 pgNJJIsXDMxfDJjQvQq2hEn74JiFpH28G7AnQKgmj+vzHt96VNrh6F8924YeuYmc2nWC6YfQu
 IsLqvRk+wFu8sYiux6bOPg9PMHHEnBejrLPO4zSy8NhsHIbZ5tPcefA9CDs8FMZzOcb56DewI
 F9FZHcFxZ01a7QeuCD0898AMM0vHR+VqkqU3V32IPyy7vVidq1PbSoCtf2gFW4nziI6BaNUtK
 06MeJFI/47opctzsoNmxKHadvMosjm/1l0pQ0SoJLnjZ8J9PH3W9xanFaKDwduN4pZ/FScxON
 3il2/t3e5xaiNXqB/ZNrKEmEkO0H6byAhrW90zZFlJDVKiHTX+pW8FV2gU57H66YmJcc4AqmS
 VmoqG8/49Pw4IpP4RNb2nMkzZ5x5+7WVNmXQX93e98iZM65ut4rifUCkLOLUjhzTi3JBFbWaV
 Gjzw+J4HGmt9atrfBGjPFY6/IeA9ym6NQfantFDI0qba/71UvGDvOW1XoVNpCxh6XIAL7v+wJ
 ljbQ4m5WRtF8ZIohCGFcwks3rJSpgMKTgpnj/4QxUDO8sZsC2k3rMvWpsDIXdGniYLhdn0Z3j
 C5byWTUZYhRPgpMv+MTKiGAa+B8huqo3dSmH6qZBDscYDsqv6q7htlTADWjR9WL+N85xVFVT1
 07Zx+v4i0x4k6vscMSv8Hsec/Ilbh8qzvNoWCXuRkBeQNzgipmVcZkFyTscIgpkOdsjF2CDBF
 nBfhL8thXqPUmwrhqDPbJZqyoNcfkzFssE1JoinLoDk5dfyEguUqe2krWUTO/7v0OplMmdRHt
 K9HI+oILMkXgwIEoErAsnXA2h/S2lilmvTDspEZXxuRXW2jv6iasn7YFSTt36z0Zo50Omzem2
 z5APSyj/DCOLhp9vgj2RJkhp0BXZo4rpRvlRU6oQ9gQnPouA6sAg2xv6eeffpB9n/I5zktgbb
 rmipwKD9Gh5mCvFbC4Gd3Hh3jJfmSBp92b2WMJ+zrq8eAiG30ISmld9Rod1U=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cEzN9shfoVeOfLybbDsZXBaH7yCZb6znO
Content-Type: multipart/mixed; boundary="0etbFxKTc5wCAReB7qie0JaO4RNdQup4S"

--0etbFxKTc5wCAReB7qie0JaO4RNdQup4S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020/1/4 =E4=B8=8A=E5=8D=8812:15, David Sterba wrote:
> On Fri, Jan 03, 2020 at 04:52:59PM +0100, David Sterba wrote:
>> So it's one bit vs refcount and a lock. For the backports I'd go with
>> the bit, but this needs the barriers as mentioned in my previous reply=
=2E
>> Can you please update the patches?
>=20
> The idea is in the diff below (compile tested only). I found one more
> case that was not addressed by your patches, it's in
> btrfs_update_reloc_root.
>=20
> Given that the type of the fix is the same, I'd rather do that in one
> patch. The reported stack traces are more or less the same.
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index af4dd49a71c7..aeba3a7506e1 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -517,6 +517,15 @@ static int update_backref_cache(struct btrfs_trans=
_handle *trans,
>  	return 1;
>  }
> =20
> +static bool have_reloc_root(struct btrfs_root *root)
> +{
> +	smp_mb__before_atomic();

Mind to explain why the before_atomic() is needed?

Is it just paired with smp_mb__after_atomic() for the
set_bit()/clear_bit() part?

>  	reloc_root =3D root->reloc_root;
> @@ -1489,6 +1498,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_ha=
ndle *trans,
>  	if (fs_info->reloc_ctl->merge_reloc_tree &&
>  	    btrfs_root_refs(root_item) =3D=3D 0) {
>  		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
> +		smp_mb__after_atomic();

I get the point here, to make sure all other users see this bit change.

>  		__del_reloc_root(reloc_root);

Interestingly in that function we immediately triggers spin_lock() which
implies memory barrier.
(Not an excuse to skip memory barrier anyway)

>  	}
> =20
> @@ -2201,6 +2211,7 @@ static int clean_dirty_subvols(struct reloc_contr=
ol *rc)
>  				if (ret2 < 0 && !ret)
>  					ret =3D ret2;
>  			}
> +			smp_mb__before_atomic();
>  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);

I guess this should be a smp_mb__after_atomic();

>  			btrfs_put_fs_root(root);

And btrfs_put_fs_root() triggers a release memory ordering.

So it looks memory order is not completely screwed up before, completely
by pure luck...

Thanks,
Qu

>  		} else {
> @@ -4730,7 +4741,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pendin=
g_snapshot *pending,
>  	struct btrfs_root *root =3D pending->root;
>  	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
> =20
> -	if (!root->reloc_root || !rc)
> +	if (!rc || !have_reloc_root(root))
>  		return;
> =20
>  	if (!rc->merge_reloc_tree)
> @@ -4764,7 +4775,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_=
handle *trans,
>  	struct reloc_control *rc =3D root->fs_info->reloc_ctl;
>  	int ret;
> =20
> -	if (!root->reloc_root || !rc)
> +	if (!rc || !have_reloc_root(root))
>  		return 0;
> =20
>  	rc =3D root->fs_info->reloc_ctl;
>=20


--0etbFxKTc5wCAReB7qie0JaO4RNdQup4S--

--cEzN9shfoVeOfLybbDsZXBaH7yCZb6znO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4S3AEXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjnMAf7B8BAnWcGKug4nvbpRZFLNOWf
jHHA4cPB5ak6wvfHxnHKOdPClQFrUDbt6L+kECZEVCJcXHDCVVBvCsDO5pYccsfD
SRWrQWRXsTwz5bJFb9wsXg0Z3R9HSyqm4mtFQdtMdfLG6wnMGCidDfMOt9BGNKjE
cEwSkUSLtb4ebnJxi32HxOCez/8oxs5OEFCS/hBYE5B6wQS/8qfD+XNMbENMtoQ/
fjVfn0bAcBYXT02tTHOhSSeqScy0RQjJWtWY9kuTvuEZtBlOrIj42jG6bexp46cj
sGp0FaCZc4zPJIYy61koZlDE0Np1QW1y6e7nqaPrXLdbcqOQ4cjBO+/CsCbvrw==
=1LwW
-----END PGP SIGNATURE-----

--cEzN9shfoVeOfLybbDsZXBaH7yCZb6znO--
