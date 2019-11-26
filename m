Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F63D1097DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 03:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKZCgt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 21:36:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:39131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbfKZCgs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 21:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574735531;
        bh=dK/R9SZFDph7bn1/ft8CDWjVlNsl0lsf5qZX2lTmZ8o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OG8XaVx6HUfGYjME2OMTv8UcgOJPlLHTi5OTiIkZKWjyvU4n4kK5cnHcyX5qWGZMh
         wqTh5dmDk/L34yPFT45ov3s6qMf+2XAcMktoUAjyJabVhAf/OqvHH1AGrVHtBT5ghl
         n4cE4CnU6HNlH5jiQOQCIl9E6r/4UET50FVXlUhU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmlT2-1i8N1J0b0I-00jrm0; Tue, 26
 Nov 2019 03:32:11 +0100
Subject: Re: [PATCH 1/4] btrfs: don't pass system_chunk into can_overcommit
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com
References: <20191125144011.146722-1-josef@toxicpanda.com>
 <20191125144011.146722-2-josef@toxicpanda.com>
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
Message-ID: <5cdd2708-2902-8c4b-98ed-7b6432542dd7@gmx.com>
Date:   Tue, 26 Nov 2019 10:32:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125144011.146722-2-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3ZM5PLDn9xw6Lm9Rf4ua88lBlzLSkBZT4"
X-Provags-ID: V03:K1:AOF55c5vAaSCy3vY+K8JQeHK256jxQYGQCsb23h3hmwZbh5vOlu
 OI/hacCitNhxK7JRIJRTA0cwlLmjUBUxVuVDK6bZvouYBsXckPpQ5J2nX4qOLWL86vJDXxU
 xic3Ugnef4wUjR9MT6VSqZG0WO6wDb7Hwh25sETX0AFpP4YhLgDqIa86AgFOYWOTzj8VrTx
 JIc3Ia3tBhXKSgwyQTbJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ajEqi1mPLzs=:yGT4VwgQ9+636hXSpvTxFH
 6/2Ipz1jZimdWNvxHZIh8+nrTdpMqyDuV3wF53Lid9sLO8tIZoZmqE8Gq+oSyjl+MRF9Z66Ov
 /vKWO5k74U8F8ioHgjiHy9xG8y6BZbLPqYoAq2Ak+jObpyfB6LVp+ewIjcGLpkmzgv12Obsrr
 sa1J2a5DBDliS/29YflrXyd9hwRPbtmhTn3rW3KI8alEMY/axNQ1pfmIRKrmgspZ3iz+qu03d
 G6TZCOF2CT0CxFUIsyz5qPU7BaTZXMJcd7YqQscTm0r7UMgAMFv+IuMaeqIZcxPjHI6nfSZu3
 chysK38L83XwTAwAKhKa5BUc6pG0D8qDRX+qYsBYO65cRniRMn/YnutIxtoSpAYayBmaoiDR4
 SuHwkP4aN4q8LSzkWwwCibMRzwonWPssoo/wRyu/lVD0lu13DBA3Fn9GWjqNXTaj/Fw/JQO45
 skjDmnESVd+NBUnJ6EYt0zLuJi66B99uSZFb3FnN4KNRstOxgGN6MjRNHky37mxFpS4o6P2X5
 E+7cDbX9RtAva7jCiK+ZdiNm6lhmnGs2jJXc9w/U23sU5lQQCr9LIECy4kZtEYRDefHoWTZ74
 RWqyiXc2Mk/dDWR8J4hdspH+u1UpzlnOXAPd3MZMSXGelnOkZGiNAXodT1XzvQquxmnJCv2Kt
 InAcCFqvaQ8iiygaIa9ubPLWHqY+KLQvlCC2Q2U1dmjcWGzOy1pR2WU5MeoAOsQhPTQtERm0R
 rcmE2TIj73R74bsaS65btDyorqOgr4VEtvrXpkbrJhB6kFC12mYc5aMW99x7pDFxNM6DZnAwV
 WVETHVmysrjheQpck7z+aRcktbopkGtACTTt8rRuL7+3bxVdKZ7QJKPG8lGigEX3VqSQ+xuPP
 S5BMkJHBdktJV4n+xhfxLd4YPXkkDnKgbbt8m9SrkWMZHxtR3FyNT02fVJDHQmSX/11NZx+j+
 ZstMmsQBOcccvmrdA5/ZLJz7DFYPA72i/THgDXNWeAy1rSM9GVXB2HdCSlLncZOnBceZhCRrp
 PYeRBE//mkDx6kxQXhHn6klM2ilK71Bl239x5N30cG26Prs5zzlN2WeMfF6Ix73ikm3D2/7Ox
 MQ6zXSxXlW0smr4guPLTgXvtgnim3aS2gc4zYtYpHvrHWd+GLfDy0bRSx7/cJyUVvseNXlGnh
 I4xwsexu4B5YosMYBYclPAFC6CRij3ZE3tvDICNeEJFhspGEvCDHtCwoPfoTN/r8BZf+9+sAH
 hmMU/kEK3OUi4rgVXPKYVMHh6z5dMA4NSq2tanxUtlSas0qmBJOjZhiRKJvc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3ZM5PLDn9xw6Lm9Rf4ua88lBlzLSkBZT4
Content-Type: multipart/mixed; boundary="K4hw2YUSpQJlEJnjzl1LRIg0NqK2RuDIo"

--K4hw2YUSpQJlEJnjzl1LRIg0NqK2RuDIo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/25 =E4=B8=8B=E5=8D=8810:40, Josef Bacik wrote:
> We have the space_info, we can just check its flags to see if it's the
> system chunk space info.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/space-info.c | 41 +++++++++++++++--------------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index f09aa6ee9113..df5fb68df798 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -161,8 +161,7 @@ static inline u64 calc_global_rsv_need_space(struct=
 btrfs_block_rsv *global)
> =20
>  static int can_overcommit(struct btrfs_fs_info *fs_info,
>  			  struct btrfs_space_info *space_info, u64 bytes,
> -			  enum btrfs_reserve_flush_enum flush,
> -			  bool system_chunk)
> +			  enum btrfs_reserve_flush_enum flush)
>  {
>  	u64 profile;
>  	u64 avail;
> @@ -173,7 +172,7 @@ static int can_overcommit(struct btrfs_fs_info *fs_=
info,
>  	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
>  		return 0;
> =20
> -	if (system_chunk)
> +	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
>  		profile =3D btrfs_system_alloc_profile(fs_info);
>  	else
>  		profile =3D btrfs_metadata_alloc_profile(fs_info);
> @@ -227,8 +226,7 @@ void btrfs_try_granting_tickets(struct btrfs_fs_inf=
o *fs_info,
> =20
>  		/* Check and see if our ticket can be satisified now. */
>  		if ((used + ticket->bytes <=3D space_info->total_bytes) ||
> -		    can_overcommit(fs_info, space_info, ticket->bytes, flush,
> -				   false)) {
> +		    can_overcommit(fs_info, space_info, ticket->bytes, flush)) {
>  			btrfs_space_info_update_bytes_may_use(fs_info,
>  							      space_info,
>  							      ticket->bytes);
> @@ -626,8 +624,7 @@ static void flush_space(struct btrfs_fs_info *fs_in=
fo,
> =20
>  static inline u64
>  btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
> -				 struct btrfs_space_info *space_info,
> -				 bool system_chunk)
> +				 struct btrfs_space_info *space_info)
>  {
>  	struct reserve_ticket *ticket;
>  	u64 used;
> @@ -643,13 +640,13 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_=
info *fs_info,
> =20
>  	to_reclaim =3D min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
>  	if (can_overcommit(fs_info, space_info, to_reclaim,
> -			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
> +			   BTRFS_RESERVE_FLUSH_ALL))
>  		return 0;
> =20
>  	used =3D btrfs_space_info_used(space_info, true);
> =20
>  	if (can_overcommit(fs_info, space_info, SZ_1M,
> -			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
> +			   BTRFS_RESERVE_FLUSH_ALL))
>  		expected =3D div_factor_fine(space_info->total_bytes, 95);
>  	else
>  		expected =3D div_factor_fine(space_info->total_bytes, 90);
> @@ -665,7 +662,7 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_in=
fo *fs_info,
> =20
>  static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,=

>  					struct btrfs_space_info *space_info,
> -					u64 used, bool system_chunk)
> +					u64 used)
>  {
>  	u64 thresh =3D div_factor_fine(space_info->total_bytes, 98);
> =20
> @@ -673,8 +670,7 @@ static inline int need_do_async_reclaim(struct btrf=
s_fs_info *fs_info,
>  	if ((space_info->bytes_used + space_info->bytes_reserved) >=3D thresh=
)
>  		return 0;
> =20
> -	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info,
> -					      system_chunk))
> +	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info))
>  		return 0;
> =20
>  	return (used >=3D thresh && !btrfs_fs_closing(fs_info) &&
> @@ -765,8 +761,7 @@ static void btrfs_async_reclaim_metadata_space(stru=
ct work_struct *work)
>  	space_info =3D btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METAD=
ATA);
> =20
>  	spin_lock(&space_info->lock);
> -	to_reclaim =3D btrfs_calc_reclaim_metadata_size(fs_info, space_info,
> -						      false);
> +	to_reclaim =3D btrfs_calc_reclaim_metadata_size(fs_info, space_info);=

>  	if (!to_reclaim) {
>  		space_info->flush =3D 0;
>  		spin_unlock(&space_info->lock);
> @@ -785,8 +780,7 @@ static void btrfs_async_reclaim_metadata_space(stru=
ct work_struct *work)
>  			return;
>  		}
>  		to_reclaim =3D btrfs_calc_reclaim_metadata_size(fs_info,
> -							      space_info,
> -							      false);
> +							      space_info);
>  		if (last_tickets_id =3D=3D space_info->tickets_id) {
>  			flush_state++;
>  		} else {
> @@ -858,8 +852,7 @@ static void priority_reclaim_metadata_space(struct =
btrfs_fs_info *fs_info,
>  	int flush_state;
> =20
>  	spin_lock(&space_info->lock);
> -	to_reclaim =3D btrfs_calc_reclaim_metadata_size(fs_info, space_info,
> -						      false);
> +	to_reclaim =3D btrfs_calc_reclaim_metadata_size(fs_info, space_info);=

>  	if (!to_reclaim) {
>  		spin_unlock(&space_info->lock);
>  		return;
> @@ -990,8 +983,7 @@ static int handle_reserve_ticket(struct btrfs_fs_in=
fo *fs_info,
>  static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
>  				    struct btrfs_space_info *space_info,
>  				    u64 orig_bytes,
> -				    enum btrfs_reserve_flush_enum flush,
> -				    bool system_chunk)
> +				    enum btrfs_reserve_flush_enum flush)
>  {
>  	struct reserve_ticket ticket;
>  	u64 used;
> @@ -1013,8 +1005,7 @@ static int __reserve_metadata_bytes(struct btrfs_=
fs_info *fs_info,
>  	 */
>  	if (!pending_tickets &&
>  	    ((used + orig_bytes <=3D space_info->total_bytes) ||
> -	     can_overcommit(fs_info, space_info, orig_bytes, flush,
> -			   system_chunk))) {
> +	     can_overcommit(fs_info, space_info, orig_bytes, flush))) {
>  		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
>  						      orig_bytes);
>  		ret =3D 0;
> @@ -1054,8 +1045,7 @@ static int __reserve_metadata_bytes(struct btrfs_=
fs_info *fs_info,
>  		 * the async reclaim as we will panic.
>  		 */
>  		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
> -		    need_do_async_reclaim(fs_info, space_info,
> -					  used, system_chunk) &&
> +		    need_do_async_reclaim(fs_info, space_info, used) &&
>  		    !work_busy(&fs_info->async_reclaim_work)) {
>  			trace_btrfs_trigger_flush(fs_info, space_info->flags,
>  						  orig_bytes, flush, "preempt");
> @@ -1092,10 +1082,9 @@ int btrfs_reserve_metadata_bytes(struct btrfs_ro=
ot *root,
>  	struct btrfs_fs_info *fs_info =3D root->fs_info;
>  	struct btrfs_block_rsv *global_rsv =3D &fs_info->global_block_rsv;
>  	int ret;
> -	bool system_chunk =3D (root =3D=3D fs_info->chunk_root);
> =20
>  	ret =3D __reserve_metadata_bytes(fs_info, block_rsv->space_info,
> -				       orig_bytes, flush, system_chunk);
> +				       orig_bytes, flush);
>  	if (ret =3D=3D -ENOSPC &&
>  	    unlikely(root->orphan_cleanup_state =3D=3D ORPHAN_CLEANUP_STARTED=
)) {
>  		if (block_rsv !=3D global_rsv &&
>=20


--K4hw2YUSpQJlEJnjzl1LRIg0NqK2RuDIo--

--3ZM5PLDn9xw6Lm9Rf4ua88lBlzLSkBZT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3cjqYACgkQwj2R86El
/qh/nAf/UJTqxc49zEefwtKXbI/kv1p8KdROEAKYuB527YepH8q/G3xGlrhAITuX
l/HyAKGWDc2Ylsm0QvvQ32bFmm1l+x/nRmuB70eS9vNj/PoLL49v0UiWY0nUMnTB
s2dxvSCHCcD5CRom9Vew+hArU2UaohEm3eGJqmo9hfNkMD2750ZgLF+Ngd/mkLyy
JmBK0ZjC5+EPG6gDRhwCv6H0frcpjeOf81rp+6bXpaVZutc2Rs0rcLXfVnxIuBh6
iMCKydogOAe/zjcOisENaJnnUBs/Z0fUuIg+SsBO7hECqT+Rwa+KH6gyiCuHQo1T
Dhn4hZCL+GNPYHnFO07QzA8vLF1BqA==
=F5sn
-----END PGP SIGNATURE-----

--3ZM5PLDn9xw6Lm9Rf4ua88lBlzLSkBZT4--
