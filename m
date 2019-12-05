Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE90113C3B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 08:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfLEHVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 02:21:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:59413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfLEHVX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 02:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575530481;
        bh=4/ditqWeFl2OGmwy1/GI8cpP4OKmqUNWQNM31cJaL0s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=P24Iz4HzyJLOF9pmTolczVALHWHLzDEICHsEw98qDpC1jTuzE6hSAM/HaO5BO6ZKj
         q8flF7K3w+Tkwrl8n0Z1e41S2ff9oBSSSCIK/eni3YHEVJvXCpvxQZZvONMst09nZC
         Vn/ygpyT3bxbbkpjmZZv7SGVffVjroImBCH5rqTI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6lpG-1igcGc1902-008Lf1; Thu, 05
 Dec 2019 08:21:21 +0100
Subject: Re: [PATCH 01/10] btrfs-progs: handle error if
 btrfs_write_one_block_group() failed
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-2-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <45341336-b2e8-2efe-64c3-cc0df59633ce@gmx.com>
Date:   Thu, 5 Dec 2019 15:21:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205042921.25316-2-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RqjxuxEEkzfKhMhT9sT7RY2vtXtc7sB6C"
X-Provags-ID: V03:K1:rG9/BZU31RVkcRp7CcqvXjcK8y3FfAzJY8iU193wJywNdCBE8B3
 a04mVjm+kUOw2o3j0wgrfsRbJYpEgmTRd3RtmdCUoU/HG+3TQufJzs2j/GzFAk9HCr4ZaeR
 GpTlI+24TlLmFdsjUxomXe8RbF5oIDKurc7YBiCYZ3v58qEcmhMTc04L6ArKmWovw+ssNkE
 tjjtAJCuNG/nPt1MLsSng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OVL55XSZazE=:sedBf7Wr1wFjrEoMX92nBi
 /tjl5XbFGEmfTL66K9osaQdqBl2d7DoGqeU6eZQ9y9FJWcv70CC3yVT150sSg4yJhXCSHZfI6
 3TPJSgKPvMglAA686spJw3wft5c4wXS3++DnoTKCBF5ov3p3RUKpJUzHBBy583cbtEsH1MMeg
 3V1RY+shz6soXK1ipAXBZVjeIRsgD1LWYzq3mUNN1pBrf9K2d1I4i9fatuJhNHOaZdffsKuGd
 fHCRLFbTQSo04Wv0aNe1DTSK6LJtZBRK3+5pjOMHuJ+k/0OZt4axckFrAsPX8hwCZjJoY2jLf
 IfzJuuOo72tB/+Va/Qzoto7y4hSKi2MK/e3RBQOVwFHuU4trFcmVjEdb6IhMZRzl9icQLLHLA
 C0/fNW52cIsN1cphhBI71NDLDR6AGajxzv7EC+VC76TyAMxFvyG/3SIXyyOeRQZbaov0r8jW4
 96E7UcxQ+kTsqYSNSVCYDTEUVTQgo3rlQNMjaTBH7mAJfkcinymSr1avF876bTK548QnMP0P9
 4yfy+zA02JOi83F7VuQByLnmd/gkw1y5i2SgKTKNij32FjdT9fX1XQPLdlEdb2WQrN6s/kOkt
 RLKm3ONRwEiPvF6lqgJXnm59ioWPiudqKDO6GRP7ajmLEogHqdTlq5auS0RjYZIKMSWwdiuyS
 tz/edM7fQua0orn2sZ5YR1RulnCrWf/Ed1QEkuYLHZNkMjla2Lem8GAtHVG0Dg0pAMfmx+GPe
 pn9kBX+Fb+hnNREDKimLgUu0EzRfUDLmNZmndugVmFRTu7yZQnPAo4vj9SsKrhcf2W3cKD6NV
 VLPlKVgmprC5gFi1M686gu2LR40atrGq8Ci9B6fD3JtY3Y3Ou6EcDVRirGCP3gtydDkmdv9yH
 Wv7ifKs3jI4hNoiUZZtxevHExFuX/7nc3oDQJdRBz5L+TQFYd+D1apqnpHy+q9zS3EWXEWt+W
 C6wFq2aOlWZQ+oLSjk8kJtlWuDK5LT5uU7mkXiK/6k5mnYSz2P/dCrPXuQfWHwmIxfZr+vhh2
 f3UGrJhruXLoff/42KKp9pVV4KDMR6unh4MZjO1gTSkiJ8p4oRKJUrAeK6V9uQGNr9Scf5e+r
 00IoDaFZTOba7DzOmk9DOA86gTIM00MbnzSKJsbsJ1ybu+//d702C5Hyegjm8QrYPlEAxjP1K
 uqykGKlP36I/hRGsPsXuzFv2Y11+6/xawrPt1/nQIAQlLVIi2XKUMGWtORYyGhEJCUfWWwbpn
 0engR+CVebY1oHVLhuTZQXWkNCj4XEVaAAqdHIDdfX+HVJLpdY7lS22zWLuY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RqjxuxEEkzfKhMhT9sT7RY2vtXtc7sB6C
Content-Type: multipart/mixed; boundary="zXoPxtj5qyGR2mwJmDsbKsQlg1ikoStMk"

--zXoPxtj5qyGR2mwJmDsbKsQlg1ikoStMk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> Just break loop and return the error code if failed.
> Functions in the call chain are able to handle it.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

> ---
>  extent-tree.c | 4 +++-
>  transaction.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/extent-tree.c b/extent-tree.c
> index 53be4f4c7369..4a3db029e811 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -1596,9 +1596,11 @@ int btrfs_write_dirty_block_groups(struct btrfs_=
trans_handle *trans)
> =20
>  		cache =3D (struct btrfs_block_group_cache *)(unsigned long)ptr;
>  		ret =3D write_one_cache_group(trans, path, cache);
> +		if (ret)
> +			break;
>  	}
>  	btrfs_free_path(path);
> -	return 0;
> +	return ret;
>  }
> =20
>  static struct btrfs_space_info *__find_space_info(struct btrfs_fs_info=
 *info,
> diff --git a/transaction.c b/transaction.c
> index 45bb9e1f9de6..c9035c765a74 100644
> --- a/transaction.c
> +++ b/transaction.c
> @@ -77,7 +77,9 @@ static int update_cowonly_root(struct btrfs_trans_han=
dle *trans,
>  					&root->root_item);
>  		if (ret < 0)
>  			return ret;
> -		btrfs_write_dirty_block_groups(trans);
> +		ret =3D btrfs_write_dirty_block_groups(trans);
> +		if (ret)
> +			return ret;
>  	}

Another hint for later cleanup.

What about killing that while (1) loop in another patch as a cleanup?

Thanks,
Qu


>  	return 0;
>  }
>=20


--zXoPxtj5qyGR2mwJmDsbKsQlg1ikoStMk--

--RqjxuxEEkzfKhMhT9sT7RY2vtXtc7sB6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3or+wXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qj5Jwf9FBk/2hIsoOVFDsf+ctoMRfEf
SZydeMqlVbpJOy0E567/3d0/EAnClMA2RkhA3gpfAZSe04nONuxSUefyT5DfrqaO
ftbzUyUnlpBx4vESFrHzHHihSfBw2DHPfzAVHDm/tNLkqZ5JbEHX4g4JpYIBA4VI
Kh/+xF9OBZYJe6gGGFkFDgO9LliXGk7Ez1kI1omt2NGxxGAM4+h1PXUcuyxcOc4S
637hfH/DrgAYkak0oTbRmlNKs0MW7GTX05UK2JMLHDqHNO2uWfIF3aFWZg1xLWM6
p/UJUZ2l39RjzMeS7KTvqz9lG/PldYl/c+qiRQGTR4DI9OJFhcZRWAUbDdgLiA==
=aYje
-----END PGP SIGNATURE-----

--RqjxuxEEkzfKhMhT9sT7RY2vtXtc7sB6C--
