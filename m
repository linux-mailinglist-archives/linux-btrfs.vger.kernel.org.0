Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1C910AE33
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 11:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfK0Kt4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 05:49:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:57679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfK0Kt4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 05:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574851718;
        bh=bvDLYvUxCPPCx9WktUVQP+fsBYXPcxAqMmd+LrRKiyc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iXXoi6VRbUOzLqatJNnea+YVC2uLhAboDz8EEVkikAbqAFeXpSrUR0/Fbm5uAKJXK
         uSAtIhKCcrh/ac0oTGXillsk3fz9DfulaqSH7W7ZTinfK0tJFLYD0RCptYoo00bTyi
         7fUQcjHO9PASAZjAr7HzGegRHTJi27Of3R/nh2Dg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6Ue3-1iTaHs0bIf-006zrt; Wed, 27
 Nov 2019 11:48:37 +0100
Subject: Re: [PATCH 4/4] btrfs: use btrfs_can_overcommit in inc_block_group_ro
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com
References: <20191126162556.150483-1-josef@toxicpanda.com>
 <20191126162556.150483-5-josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <75aedd38-8a09-a2c1-242d-198f97ba6328@gmx.com>
Date:   Wed, 27 Nov 2019 18:48:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126162556.150483-5-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5DMOWbIb96uajIoiYAKgfUwtRF0Ms57r3"
X-Provags-ID: V03:K1:wkzuU/KjkhWO0Lv6MQiuDGiTEmU6WpQ92TtMDk1XoZu+PJQIwn8
 aDd7LUhhdydwIfxcpfaichtAgVeQ0leN0LdTw/tqf6XptnhKJn+By4SzKcIBYINyNdA4tby
 nLYRMn9CSXKkKXbYS6cquiCnFLje8K1YDN3sGosZ1T5NuxxGY21SCBicQMZL3sxjr4a3sSZ
 Twc8E5Vp13qiYKyV1Ekkg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OoVmV6UnMf4=:uCsO5WpQFc2PoZ1Zdtx+GU
 Qo0ZemouD05/SYv6u2uSi+4a4F8c31EOTvIvW4PAYuIomYzOF9PerMsKcYWa/sK/+LuMeSlvL
 F/sGogl7hTvE3apIgD48dUBl+X9hDbd48BvEXDnnxUFOHwz856a4qTuAuthuk54M8f4insYqC
 7YP8Wu/IcuOXpryf8zCMFoPG0Phcs3C+VQ00dezkP/8h5S7GVY4vHoKC3zgJ2LaSSTKbTiVSc
 GhRXP37wSB7p3PPxKRbBZ8RgnmHxlM2MrC1ZGJCaB+S6eUQ7RdeSTwDT/mnEAunZIwRxNlzrf
 9P8kUNv+yrzAJ59ePXgBtxHqF87ntF6Ltk8G4+Oh8PB1pLNzy1CrSWXth6ZW+mebjpaPh0NTH
 FgcZlV6L7vBqpiz3n/vkbJnUPnG0pUrjSWXfhbF6ieVWB0xY35msIZkMAxISpBokscPihgXBO
 aPMb09bJwE8ts2mVLQl0jvKvSDgdmSar7KRYAD6maByEKvJzlz440GJ7F9VImEpyMoac3JO/B
 +xk6Nr9s6aLcnFLsFnjZng1/nMo5gwBhwoKRmjeBfsdeVq/UajgiYw8p5wUd553N8ZgFdD7Ap
 +65BCO3Tp06PbfpoVefv5NCdV/nnNink9njsZTGsvEYQLYdBHNd7cpiLz00yk9MA6F+EBucyG
 dlGdTKcgSWutCK17x6PhGS9I+ZLTMEVkGFVRoTKE679VEHgPgHH9Ycm0xmz3iB+A8eTe8s7Yk
 TGZWCxp8wAerj3OSNVAw+C018gZSvuiKnAjh7t2wTJZMskEuSUy4QIzr6JwsPAEle4Vhcfysp
 Pp7AoOchtS9SP9Z7LE3//XjsWslBdxwYXkJ2nKQA1xcMT7GbQW8/YLWaKL7oTdWmZAvTusjM9
 uHUXhnSMT2H4J+Z6HPIWl6Zowna3xYW3vdln603cLMJJAG76I3nalYZO8yEM0VV5BFnfustSq
 o9B7//CEgCGOvFGYh5XBGpaygvsk527oVhCWYJAFQVJDotFjFqvgAAvf4ONNTbtntrIfjq6As
 wmWT2+4iu+AkPRyp/vmnkNK9PhV8ii5nC4Nk8GbvifFIzezwowQG0NsLo4PcsVQRJwvbDnUK8
 p7GFwz135RME6lo5Y80cGgmfB9NHkMVtMU8hQG4eciOqPEFIIMB70vsKeOKDAXz8fasVxvGdW
 lqAnDsuFN3uUFsNybQB1UDucaj8OStwVCx6Fvy/zT48Xni+hreckXtgBkZ1+YUNxxADrrwNWC
 5VXb4ZPLhHQY4ZAln5hP9mfnvwgPcnoRl+oUAhxNikqw+Z48UMSgOBBG0oaQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5DMOWbIb96uajIoiYAKgfUwtRF0Ms57r3
Content-Type: multipart/mixed; boundary="uuQGVBDPtQq9ayoLnfK12BtqDBlGwvKnC"

--uuQGVBDPtQq9ayoLnfK12BtqDBlGwvKnC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/27 =E4=B8=8A=E5=8D=8812:25, Josef Bacik wrote:
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
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just as mentioned in patch 3, it would be better to revert b12de52896c0
("btrfs: scrub: Don't check free space before marking a block group RO")
in this patch too.

As your new over-commit check also prevent btrfs_inc_block_group_ro() to
create empty system chunk, it solves that mentioned bug in a better way.

Thanks,
Qu

> ---
>  fs/btrfs/block-group.c | 35 ++++++++++++++++++++++++-----------
>  fs/btrfs/space-info.c  | 19 ++++++++++---------
>  fs/btrfs/space-info.h  |  3 +++
>  3 files changed, 37 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5961411500ed..ca55eb6758d1 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1184,7 +1184,6 @@ static int inc_block_group_ro(struct btrfs_block_=
group *cache, int force)
>  {
>  	struct btrfs_space_info *sinfo =3D cache->space_info;
>  	u64 num_bytes;
> -	u64 sinfo_used;
>  	int ret =3D -ENOSPC;
> =20
>  	spin_lock(&sinfo->lock);
> @@ -1205,19 +1204,36 @@ static int inc_block_group_ro(struct btrfs_bloc=
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
> -	if (sinfo_used + num_bytes <=3D sinfo->total_bytes) {
> +	if (sinfo->flags & BTRFS_BLOCK_GROUP_DATA) {
> +		u64 sinfo_used =3D btrfs_space_info_used(sinfo, true);
> +
> +		/*
> +		 * Here we make sure if we mark this bg RO, we still have enough
> +		 * free space as buffer.
> +		 */
> +		if (sinfo_used + num_bytes <=3D sinfo->total_bytes)
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
> +
> +	if (!ret) {
>  		sinfo->bytes_readonly +=3D num_bytes;
>  		cache->ro++;
>  		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
> -		ret =3D 0;
>  	}
>  out:
>  	spin_unlock(&cache->lock);
> @@ -1225,9 +1241,6 @@ static int inc_block_group_ro(struct btrfs_block_=
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


--uuQGVBDPtQq9ayoLnfK12BtqDBlGwvKnC--

--5DMOWbIb96uajIoiYAKgfUwtRF0Ms57r3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3eVIAXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhBWgf5Aaa+LGFUstFfk2O3fGGROudX
HQXZkZ4Gd1w19QOFD24GWRVlRxAiL0fV/ktpDB+qPcueEEPm8KbOTaoiKivdwG2W
Fv4eHfZc5T2DU1YWqyJEKHDwG4rppo5YTKHToGs/5B1Gtd49Q3xiQ78DfboXwHYH
YQbJ4K5bpzPkrFiNiX0WNo6OSu20u327SS5zy3V2ZCEUeP4AZUGt6vHhlhBrIKmF
hC72hcIj1vXI8F2OXfn+sudmXl6ot1AMEs84WIkB59nWCiDP73CcV1KOxzySP/c0
ot72/py7rKygC1ONz4oF239+f8jsuG2jux66QTCgtVmvizeWgqQNCaVKzrcyhg==
=TuSH
-----END PGP SIGNATURE-----

--5DMOWbIb96uajIoiYAKgfUwtRF0Ms57r3--
