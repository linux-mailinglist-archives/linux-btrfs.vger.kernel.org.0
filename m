Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C69132483
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 12:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgAGLJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 06:09:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:52247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbgAGLJg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jan 2020 06:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578395342;
        bh=toAHN0kBncomNfdUxaXAd/Fjdo9U+cNY+Qu2nHigP9s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Tut1/CwyOzLLsezwtjQCXjxaauvLqHvUmBEYuuc8DBG6WPooq1y5nRz+sOwypfQTW
         szJ0bXX1GU1RA/igNptFuC+ZWtpL3QNeTTu6mesB0qHcCxRRnoJYn1kf5R97ds1ShP
         E8kNqTcCia/7HvsX2KeTG2RBKLfsvXKP6LZNO2pA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrQEx-1jSDpT2X15-00oYSl; Tue, 07
 Jan 2020 12:09:02 +0100
Subject: Re: [PATCH] btrfs: kill update_block_group_flags
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200106165015.18985-1-josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4bc7e4f5-c370-4e0e-405c-5d3aa67f95b0@gmx.com>
Date:   Tue, 7 Jan 2020 19:08:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106165015.18985-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FQXvEeV6IdewtpxITqmZIlBdhldKulioq"
X-Provags-ID: V03:K1:mLfduUtCFevauA73rS1e6EKXY+yitScXRoWrXlc6Wvq2tLlO802
 U1Zwt1nibte1BWdHMOiacfBd+WfhPe9SmNsrVSNG6Bn4aNNBji0cx3PEsK8yhrqTLfDL1mL
 tpDk+3aZCZkem4jThhI7bMgHF/CienxoxaXltuCO0FiFhQykr8n0kmVkA5s/3pGmSUHE+55
 yVCMSvTe43FpvM4x/VNPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dsXXJ34eaoc=:6YLAz83aF+8iC4DrRNMbE2
 ZTvCIwWZY4JunlJ3jhoSH0MHa1wpRn7rIGA7+vRCO/hduCSCT6/QRwh+X0PkTn45JTtw5/Hzb
 YERFidvIxtz3qHJZhmAL+Kv4A/hjq3u0GE7BU4mJ2iVUTVcD6k8jKetMJGv4enY+bHu7usOd0
 Oy1OF1wgvMFBM+ZRDFF7qoHG7pmURLtezE6nlDUaikoUmOLVPXsVILaKrW17Im0kU+mFouEZ/
 IRj/FAzPD/YGtFaSM8RtMNok30pDb4OHqmTbioDAHBZlC+vN9SkzBEH6yp06XTCNH1wxjc6tp
 EZyHwm3qWUXmV4IvS2SyFdRqvHQdzcAHBVpc22K5CXmioVO+PqKnvU20IVE5J8xIBlSJGxTDw
 YQ1yEOAhFipoEzUsDx1iPxOfZxNSiql+evTDuSZjAnI6gZahocGtl7fSP2NmispcMtQl34TrH
 rNAAadefcewREhNhE/BQGjwD+ZyAqQmAwvV6pDfRx+K8cWbrr16fx6Icm1TVkMSq6zr3CMX5G
 ubIDvEuxSXNxgF/p01pK5+dcqjZXg6QDrRLVDBcoPv5CGRcWR80xIqnl943090axxqOhHciSb
 YAT11gy22XIbhyEe+CnuwqPNkEAqzLEx9GiMrD/CYro8t+73SuvU7R0+s6Afk3YyrCjNq0ukB
 2h+wyRPjHJcR8mPj7Vfox6Lef9URXs3f4sDXSSNQSaP6GXLU/8NsW0JIBStvShnrjNcSpNFSG
 eetUOxAuhlt2e7+/KOtXYTLnB9/Mbl0BICIM+Z5xP8gmd/ButT7YjDFP/T66ICg6RK2t4XHH/
 Tm9/3bb5QxGjeoy4ZGCf3BwztKC47DIRXVAtmlbp5eeBki5e/S7gsx9JiBFMOtDLhPtohGsdF
 /A6wiKPW3NE7M1hyEovmNWUDo0lyU2uEPOLV+lTQBTyMEpawAQ1YahlhMGONMGyNTvkczKL+6
 Uz6z4eF+KzbPgB+Phh2kECW3bBOmcIbX0kRBHaMXTRCwhAI/VnCNP//9n/J4CPbdWWZ5veJCb
 vB/E09AnHPsi8Xr4KLb7iSoRMd2LssHiygsv3CMkKyr6YF9WxOnS4R6zpEsE9p0S6GmEau0YI
 iZAA8nD/N3WPdsVReKXJImil/MC1U8YPmKo7CQJaWo+FAFF7Hyr1Ar9ZMKGYNvUxAWLxQ5B8c
 hLJGTiO0kFE2imCi8SPEYNWwU4Zx9EzZE+7snJe7gvsREKwkRSin12OLwmCxUE75SIlSmKQx7
 tIdiiflUCP1fgFEGLgtxNU6acCSbBgg6LuETe7BUGWN6rEhu5ZGZf6Ywtw/k=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FQXvEeV6IdewtpxITqmZIlBdhldKulioq
Content-Type: multipart/mixed; boundary="KGh9UQEucOzTgDSGIWz1B40V3gTngU2Nk"

--KGh9UQEucOzTgDSGIWz1B40V3gTngU2Nk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/7 =E4=B8=8A=E5=8D=8812:50, Josef Bacik wrote:
> btrfs/061 has been failing consistently for me recently with a
> transaction abort.  We run out of space in the system chunk array, whic=
h
> means we've allocated way too many system chunks than we need.

Isn't that caused by scrubbing creating unnecessary system chunks?

IIRC I had a patch to address that problem by just simply not allocating
system chunks for scrub.
("btrfs: scrub: Don't check free space before marking a block  group RO")=


Although that doesn't address the whole problem, but it should at least
reduce the possibility.


Furthermore, with the newer over-commit behavior for inc_block_group_ro
("btrfs: use btrfs_can_overcommit in inc_block_group_ro"), we won't
really allocate new system chunks anymore if we can over-commit.

With those two patches, I guess we should have solved the problem.
Or did I miss something?

Thanks,
Qu

>=20
> Chris added this a long time ago for balance as a poor mans restriping.=

> If you had a single disk and then added another disk and then did a
> balance, update_block_group_flags would then figure out which RAID leve=
l
> you needed.
>=20
> Fast forward to today and we have restriping behavior, so we can
> explicitly tell the fs that we're trying to change the raid level.  Thi=
s
> is accomplished through the normal get_alloc_profile path.
>=20
> Furthermore this code actually causes btrfs/061 to fail, because we do
> things like mkfs -m dup -d single with multiple devices.  This trips
> this check
>=20
> alloc_flags =3D update_block_group_flags(fs_info, cache->flags);
> if (alloc_flags !=3D cache->flags) {
> 	ret =3D btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
>=20
> in btrfs_inc_block_group_ro.  Because we're balancing and scrubbing, bu=
t
> not actually restriping, we keep forcing chunk allocation of RAID1
> chunks.  This eventually causes us to run out of system space and the
> file system aborts and flips read only.
>=20
> We don't need this poor mans restriping any more, simply use the normal=

> get_alloc_profile helper, which will get the correct alloc_flags and
> thus make the right decision for chunk allocation.  This keeps us from
> allocating a billion system chunks and falling over.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 52 ++----------------------------------------=

>  1 file changed, 2 insertions(+), 50 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c79eccf188c5..0257e6f1efb1 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1975,54 +1975,6 @@ int btrfs_make_block_group(struct btrfs_trans_ha=
ndle *trans, u64 bytes_used,
>  	return 0;
>  }
> =20
> -static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64=
 flags)
> -{
> -	u64 num_devices;
> -	u64 stripped;
> -
> -	/*
> -	 * if restripe for this chunk_type is on pick target profile and
> -	 * return, otherwise do the usual balance
> -	 */
> -	stripped =3D get_restripe_target(fs_info, flags);
> -	if (stripped)
> -		return extended_to_chunk(stripped);
> -
> -	num_devices =3D fs_info->fs_devices->rw_devices;
> -
> -	stripped =3D BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID56_MASK =
|
> -		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
> -
> -	if (num_devices =3D=3D 1) {
> -		stripped |=3D BTRFS_BLOCK_GROUP_DUP;
> -		stripped =3D flags & ~stripped;
> -
> -		/* turn raid0 into single device chunks */
> -		if (flags & BTRFS_BLOCK_GROUP_RAID0)
> -			return stripped;
> -
> -		/* turn mirroring into duplication */
> -		if (flags & (BTRFS_BLOCK_GROUP_RAID1_MASK |
> -			     BTRFS_BLOCK_GROUP_RAID10))
> -			return stripped | BTRFS_BLOCK_GROUP_DUP;
> -	} else {
> -		/* they already had raid on here, just return */
> -		if (flags & stripped)
> -			return flags;
> -
> -		stripped |=3D BTRFS_BLOCK_GROUP_DUP;
> -		stripped =3D flags & ~stripped;
> -
> -		/* switch duplicated blocks with raid1 */
> -		if (flags & BTRFS_BLOCK_GROUP_DUP)
> -			return stripped | BTRFS_BLOCK_GROUP_RAID1;
> -
> -		/* this is drive concat, leave it alone */
> -	}
> -
> -	return flags;
> -}
> -
>  int btrfs_inc_block_group_ro(struct btrfs_block_group *cache)
> =20
>  {
> @@ -2058,7 +2010,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_g=
roup *cache)
>  	 * if we are changing raid levels, try to allocate a corresponding
>  	 * block group with the new raid level.
>  	 */
> -	alloc_flags =3D update_block_group_flags(fs_info, cache->flags);
> +	alloc_flags =3D get_alloc_profile(fs_info, cache->flags);
>  	if (alloc_flags !=3D cache->flags) {
>  		ret =3D btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
>  		/*
> @@ -2082,7 +2034,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_g=
roup *cache)
>  	ret =3D inc_block_group_ro(cache, 0);
>  out:
>  	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
> -		alloc_flags =3D update_block_group_flags(fs_info, cache->flags);
> +		alloc_flags =3D get_alloc_profile(fs_info, cache->flags);
>  		mutex_lock(&fs_info->chunk_mutex);
>  		check_system_chunk(trans, alloc_flags);
>  		mutex_unlock(&fs_info->chunk_mutex);
>=20


--KGh9UQEucOzTgDSGIWz1B40V3gTngU2Nk--

--FQXvEeV6IdewtpxITqmZIlBdhldKulioq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4UZscXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjlzAf/ZKqT33lvewcCi8jWifEiTVbI
PR5huROtPvwwUbg0glzBQCDNKQfBuOJEAyHylZ61CGD1m9uY45WXKJ7UR9Q5Nl0A
RXGz8f02QR1Vhsje5V/X71EVuYvWhMITPL9QoSto2PaESi39IA/Rhrk+MO6JlIbf
979o3dxzk257Hk2ubT3KK6O3tVl8+E+SVy0aHBcVarfAtk6Jllq1RyE/56qQ4gGU
mZTGIKMEIHUeN29/jSEDzcqXqxPHIPYuRLSbBYbLpSDN200CmArZifsohXPtdJYo
pFIJJi/fS0ETYGvAd2ZM6pFJ3+dygQMWZ8FCbmMy85/JBkqK1mEiVXNl0DXrcA==
=Af18
-----END PGP SIGNATURE-----

--FQXvEeV6IdewtpxITqmZIlBdhldKulioq--
