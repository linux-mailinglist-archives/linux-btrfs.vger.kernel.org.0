Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5BC1097F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 04:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfKZDBp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 22:01:45 -0500
Received: from mout.gmx.net ([212.227.17.22]:51587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKZDBp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 22:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574737229;
        bh=9F7v8kxEyCuSOrX0M6RXCwWSvfr3qY5D98d0j6pq6nU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FUyr0CUmut+FdvFBceWe7ZNJJPwgmttkm0oxaKnIrQqTLPHgtIKE3EbY6LZUNhvZn
         cLIoBpinFy0/VX6B5fbQRdTVJ7Yz5/2aF6iQZf9IPa6ZCVoTniHRZd0DoZ8zhfmPZZ
         jzFqnh6Kl7zkGirFrLWLWHO70daCpr/Hlcmz33Bg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4z6q-1hqIh62GVo-010vWX; Tue, 26
 Nov 2019 04:00:29 +0100
Subject: Re: [PATCH 4/4] btrfs: use btrfs_can_overcommit in inc_block_group_ro
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com
References: <20191125144011.146722-1-josef@toxicpanda.com>
 <20191125144011.146722-5-josef@toxicpanda.com>
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
Message-ID: <bc6ee1c0-b8cd-01c9-a38d-42ac59ed0093@gmx.com>
Date:   Tue, 26 Nov 2019 11:00:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125144011.146722-5-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g08m4tOjoygwLERTDEIEfs6khwURHPNmf"
X-Provags-ID: V03:K1:T6SHXyfHRbQAb5Jclcwkup/zVW32BGQSswbyLTrMty8djMjCl6L
 SOFyjDQ1h1gpSpv7Tk0WPv3ZSYil6JvFlkH5X/qnChfz3sNHFCq47Cdabg3cmqkp2zyYNHV
 xQYs524lcisYapVfOGPyR+Zj1SSyfj10Y69jzFizH+Z121mQOBPPy5Pdv2eeM3WbxHaVO0N
 WBIKovW9fW/8q2MHROuRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7AZQdD6erUc=:Tc1XYeqfH3vRnnVtc/y48L
 Uo/gd2uE6T/87x/DPKe7BpWMwMS5Fz228dq7v3OiRcOQP4lCBoCICNmK8IDuv+mDq+GiQk5ZD
 KiHyyiALz2ayJKxVzVJbuZw1E3fx7De17T9stArvodKFvzsVUjjn/SGne3KHKaH42kwvNfrOD
 mEys9wclIbNFU1ZnYziogTSbF4CNbudLcyuARCnlyn6IUg1wxU/Mg0vZpAWIIAxLDcQ+28J5y
 lYDU0s9MPDBF5lubcdX/yBERMAZZp4LxUYGZA/Sf+ceATX/XIwZmJVVfmyStIqGXV58zHWvna
 EyZsrdG6Ga27pA5DZ70JmSuWYY0v2lMwgJ4T05aij2T1sbeQV1WfWriezZFjIFFl4jac1+8tI
 1MiZH53fu96liWkONQBz61bmbuAavTKnjXs05c27hdCW7oAttAg7JSDsBvo+3D7WxAC7fLRLW
 rcONqRCu4oU6o5DTGToXI0NYWRIgKEWEh7WL53x3iWhKQeGvOV74y4GoCsQQ47tfhlmaRz8PP
 Jr6TfyAopLOVjBFRh1xDobXOmG3HAHxItJoOt/Cl0jQ3QlykZ71aWE9M1oJQFTtxzIU6lCDgP
 wKr50rQzD9vx4L5jlGQ30IrDe9ks0zX9jzQ20s5+aw3849AoP+ynmBZ/prtnPtCPhdy9pMqJ0
 XxSk+KWwrfl+nwoj1vA9qHa/X9ar7zOL6rtwl9qRpBUOhpwM2o5+zmMzU4e/8SAxAIfcWGkO4
 2UOdt6GFRqxy3YEcd5bWi0IdupYvMfnoEVOS/Me1mBU80GsSfACQxgU1tJt/a3ET8nKIE1ekT
 +M785WTY2sADrZoGpBBxB3+5g9ziD/tvPpHyiAgQEElF+oIGuVY3Vk6YGjiphzBtuEBrOnUVc
 I/6txmNy+Uq7IBuYfb9wUTDL9niykFgL7Ejk31WksuKKO0hrH9iokNGTlmnkS0nAE5XxQu1Zm
 Z2oYJc2t+Fmdq6YXiC0lJlja0+QMpjKDQn3BgNbLdvuHMUxFFHmSY5HYCJ3e1Crorwlr3IvGY
 y/RRw0+durf+NtnwDayvilxZUQrf1sLiDW+iUT8yhcy2fKKrtkbc46CKEln3FOOvGs2EK5zJL
 ZHSXa0qTRN5F9J1VQw2SKXMjSGWECH9ULV3g5xU4GxB1WjqkK31cQv4gxkybS/x2fYj7wi7gd
 XApDM7sPKogjOtGHV76ZR+k/1zzPYeS531fcOCS1xP0pZB54of68z0uv3nkRNN85mkcx3/0CB
 lqJvt0eqQivHAlBGharWHKmbwJhq4zQEyzKWaJI5epWae4v1F4jZJpNxfYC4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g08m4tOjoygwLERTDEIEfs6khwURHPNmf
Content-Type: multipart/mixed; boundary="5RuKaG0wt7K0iiKeLcRMr0VJpPeMYBLka"

--5RuKaG0wt7K0iiKeLcRMr0VJpPeMYBLka
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/25 =E4=B8=8B=E5=8D=8810:40, Josef Bacik wrote:
> inc_block_group_ro does a calculation to see if we have enough room lef=
t
> over if we mark this block group as read only in order to see if it's o=
k
> to mark the block group as read only.
>=20
> The problem is this calculation _only_ works for data, where our used i=
s
> always less than our total.  For metadata we will overcommit, so this
> will almost always fail for metadata.
>=20
> Fix this by exporting btrfs_can_overcommit, and then see if we have
> enough space to remove the remaining free space in the block group we
> are trying to mark read only.  If we do then we can mark this block
> group as read only.

This patch is indeed much better than my naive RFC patches.

Instead of reducing over commit threshold, this just increase the check
to can_overcommit(), brilliant.

However some small nitpicks below.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 37 ++++++++++++++++++++++++++-----------
>  fs/btrfs/space-info.c  | 19 ++++++++++---------
>  fs/btrfs/space-info.h  |  3 +++
>  3 files changed, 39 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 3ffbc2e0af21..7b1f6d2b9621 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1184,7 +1184,6 @@ static int inc_block_group_ro(struct btrfs_block_=
group *cache, int force)
Now @force parameter is not used any more.

We can have a cleanup patch for it.

>  {
>  	struct btrfs_space_info *sinfo =3D cache->space_info;
>  	u64 num_bytes;
> -	u64 sinfo_used;
>  	int ret =3D -ENOSPC;
> =20
>  	spin_lock(&sinfo->lock);
> @@ -1200,19 +1199,38 @@ static int inc_block_group_ro(struct btrfs_bloc=
k_group *cache, int force)
> =20
>  	num_bytes =3D cache->length - cache->reserved - cache->pinned -
>  		    cache->bytes_super - cache->used;
> -	sinfo_used =3D btrfs_space_info_used(sinfo, true);
> =20
>  	/*
> -	 * sinfo_used + num_bytes should always <=3D sinfo->total_bytes.
> -	 *
> -	 * Here we make sure if we mark this bg RO, we still have enough
> -	 * free space as buffer.
> +	 * Data never overcommits, even in mixed mode, so do just the straigh=
t
> +	 * check of left over space in how much we have allocated.
>  	 */
> -	if (sinfo_used + num_bytes + sinfo->total_bytes) {
> +	if (sinfo->flags & BTRFS_BLOCK_GROUP_DATA) {
> +		u64 sinfo_used =3D btrfs_space_info_used(sinfo, true);
> +
> +		/*
> +		 * sinfo_used + num_bytes should always <=3D sinfo->total_bytes.
> +		 *
> +		 * Here we make sure if we mark this bg RO, we still have enough
> +		 * free space as buffer.
> +		 */
> +		if (sinfo_used + num_bytes + sinfo->total_bytes)

The same code copied from patch 3 I guess?
The same typo.

> +			ret =3D 0;
> +	} else {
> +		/*
> +		 * We overcommit metadata, so we need to do the
> +		 * btrfs_can_overcommit check here, and we need to pass in
> +		 * BTRFS_RESERVE_NO_FLUSH to give ourselves the most amount of
> +		 * leeway to allow us to mark this block group as read only.
> +		 */
> +		if (btrfs_can_overcommit(cache->fs_info, sinfo, num_bytes,
> +					 BTRFS_RESERVE_NO_FLUSH))
> +			ret =3D 0;
> +	}

For metadata chunks, allocating a new chunk won't change how we do over
commit calculation.

I guess we can skip the chunk allocation for metadata chunks in
btrfs_inc_block_group_ro()?

Thanks,
Qu

> +
> +	if (!ret) {
>  		sinfo->bytes_readonly +=3D num_bytes;
>  		cache->ro++;
>  		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
> -		ret =3D 0;
>  	}
>  out:
>  	spin_unlock(&cache->lock);
> @@ -1220,9 +1238,6 @@ static int inc_block_group_ro(struct btrfs_block_=
group *cache, int force)
>  	if (ret =3D=3D -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG=
)) {
>  		btrfs_info(cache->fs_info,
>  			"unable to make block group %llu ro", cache->start);
> -		btrfs_info(cache->fs_info,
> -			"sinfo_used=3D%llu bg_num_bytes=3D%llu",
> -			sinfo_used, num_bytes);
>  		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
>  	}
>  	return ret;
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index df5fb68df798..01297c5b2666 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -159,9 +159,9 @@ static inline u64 calc_global_rsv_need_space(struct=
 btrfs_block_rsv *global)
>  	return (global->size << 1);
>  }
> =20
> -static int can_overcommit(struct btrfs_fs_info *fs_info,
> -			  struct btrfs_space_info *space_info, u64 bytes,
> -			  enum btrfs_reserve_flush_enum flush)
> +int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
> +			 struct btrfs_space_info *space_info, u64 bytes,
> +			 enum btrfs_reserve_flush_enum flush)
>  {
>  	u64 profile;
>  	u64 avail;
> @@ -226,7 +226,8 @@ void btrfs_try_granting_tickets(struct btrfs_fs_inf=
o *fs_info,
> =20
>  		/* Check and see if our ticket can be satisified now. */
>  		if ((used + ticket->bytes <=3D space_info->total_bytes) ||
> -		    can_overcommit(fs_info, space_info, ticket->bytes, flush)) {
> +		    btrfs_can_overcommit(fs_info, space_info, ticket->bytes,
> +					 flush)) {
>  			btrfs_space_info_update_bytes_may_use(fs_info,
>  							      space_info,
>  							      ticket->bytes);
> @@ -639,14 +640,14 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_=
info *fs_info,
>  		return to_reclaim;
> =20
>  	to_reclaim =3D min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
> -	if (can_overcommit(fs_info, space_info, to_reclaim,
> -			   BTRFS_RESERVE_FLUSH_ALL))
> +	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
> +				 BTRFS_RESERVE_FLUSH_ALL))
>  		return 0;
> =20
>  	used =3D btrfs_space_info_used(space_info, true);
> =20
> -	if (can_overcommit(fs_info, space_info, SZ_1M,
> -			   BTRFS_RESERVE_FLUSH_ALL))
> +	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
> +				 BTRFS_RESERVE_FLUSH_ALL))
>  		expected =3D div_factor_fine(space_info->total_bytes, 95);
>  	else
>  		expected =3D div_factor_fine(space_info->total_bytes, 90);
> @@ -1005,7 +1006,7 @@ static int __reserve_metadata_bytes(struct btrfs_=
fs_info *fs_info,
>  	 */
>  	if (!pending_tickets &&
>  	    ((used + orig_bytes <=3D space_info->total_bytes) ||
> -	     can_overcommit(fs_info, space_info, orig_bytes, flush))) {
> +	     btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush))) {=

>  		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
>  						      orig_bytes);
>  		ret =3D 0;
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 1a349e3f9cc1..24514cd2c6c1 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -127,6 +127,9 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root =
*root,
>  				 enum btrfs_reserve_flush_enum flush);
>  void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
>  				struct btrfs_space_info *space_info);
> +int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
> +			 struct btrfs_space_info *space_info, u64 bytes,
> +			 enum btrfs_reserve_flush_enum flush);
> =20
>  static inline void btrfs_space_info_free_bytes_may_use(
>  				struct btrfs_fs_info *fs_info,
>=20


--5RuKaG0wt7K0iiKeLcRMr0VJpPeMYBLka--

--g08m4tOjoygwLERTDEIEfs6khwURHPNmf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3clUgACgkQwj2R86El
/qhh2Qf/aylZOr7+VCada6xmFRid8FSgUNvBVX+AcPcMhfI3dqog5iuynCN2S73U
LDzLXDr4n70ap2+EihRdFjaUKSvb8VWXKWyFCmU6YE0mOpFdApcvELL3MgptpEVf
ozDsUfTdjc1xGeIqzIZhCvcr9/hRFki3aZ+DxB0pyeLgieisTa7CCyckaSwCdc7U
fO7QehKaVfdPXLzrstLgKNH0+dZ+8e6yujK0ScZMXVLC8mgKB6cvQpvC2SmjTM6U
4Lujd01te5s9Xywr4HEyIA9S5EQLmbc4jTyALjnsEPYgbJ+F4hRRAf9icJmjUw1l
UXOD6JG4XIVBKN5dy68hS5gODRDTug==
=lfqt
-----END PGP SIGNATURE-----

--g08m4tOjoygwLERTDEIEfs6khwURHPNmf--
