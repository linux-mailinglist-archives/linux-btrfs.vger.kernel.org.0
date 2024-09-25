Return-Path: <linux-btrfs+bounces-8234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F898692A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 00:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D781F25F4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 22:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FE115A4AF;
	Wed, 25 Sep 2024 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="s0egCOAr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E12157A48
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303166; cv=none; b=KEZMgjlSTS5vmG5p7CtKbfUPLv66pqNp3UVxEkvyYebUbuVpPls0xiS41rVBI1I+4gVlINQBZSzcNXMYnUGDtPFs7DmDanwiMe5oqSXCtPlXsfiGj8/08+Q9QjdQQfh0vRTp4PWz+9Os3V6ojdtFlhcWqpmSgOA2yKgpChc5Eqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303166; c=relaxed/simple;
	bh=PGqkUz3AB3p2Wu8WkO+aO9NE7D4D4fDoh6ItjaudAZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JoqVwkQXiccZbt6U5H31qHpyvPd4h5r0D/V+zH0o6/5B4m59hmKUSvxGECOowrNuA2jL1/k6UbKGKnZRkoMLGCqi60npNHNWx5W+R8xDtQZAWUD1YrnUoB+fUIhjS4ywD45n/Yg7aMDw3bxdeB6rCBasALMYpCtO2BEO02YLjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=s0egCOAr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727303157; x=1727907957; i=quwenruo.btrfs@gmx.com;
	bh=L+PUHF7Vhr9iB1E9435761Q9XkUJDRBwP14db4dpA5k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s0egCOArMNo/hc8qRfrtKHQSy6pMq+aoQGK1nNcuDz2mYg+PbOMnG5tXn8GpRyMI
	 MXUmua3BTR9jCouQHwx7iERrHxgvN2NROwl/1pv6Iu7yjlniW4gIOWzoTLR//iKkq
	 jGWZJk1fqx5OL1KX/R1uiunZrO/ZRCMDac1GVrsVFrPRChTSG8tseUg9D0v/LY/pi
	 kg1CYyELCJM/pvK+e0na1rUoWjXu3euLVpt5ZHvw4zcivunWmrxiovXnywthyMxnb
	 pdlegVGRBA4kW1OF6yEmtpsZIA3iWHMGaYo34ZMA9kFqSLbYVUEksvgGLrM3L3An+
	 JnwV6av778BmzUoy4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzhnN-1ryc0z40av-00rTkp; Thu, 26
 Sep 2024 00:25:57 +0200
Message-ID: <99fdef81-7844-4499-9905-f2930e7815f3@gmx.com>
Date: Thu, 26 Sep 2024 07:55:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] btrfs: use sector numbers as keys for the dirty
 extents xarray
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1727261112.git.fdmanana@suse.com>
 <a0b3dae9b5933cb80804f063cedcadf1ae8259f2.1727261112.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <a0b3dae9b5933cb80804f063cedcadf1ae8259f2.1727261112.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BQktkIW0MpWc3XaDL+ahqpG8CVK10T+F+OqwSxH0z+bGP9sckdX
 KeCuN/ys0kYagscbavtiVK9RtONAd6eZkL7vIlUurdE6HplrqWA2kuoHBzwz6k7YI0ZBTOa
 obSw5hFtoqg9Rv2nWJKoK6Q4mcxfIs7P9KQJtXUyXmxy8AyahL6dLdWAO2YeRbAThhkzSJf
 k1B2dK2E17U2tuA8dxT0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xHMdbq+K/vo=;L1ibTsBwlN7Fw+XZMnDXH42VcsI
 wigWb4Mn5GyO1FBI1LVT5LYRmrWCyogWB7LowMI/i5HX3MMmBfkpHBB7VwEo15KUBTeTADEVY
 Wr1K4InAJAlKsfvX3p2aiAzfCnzrCrkrodK4aQb9HTKF9lGfyWs8yJ/3N0WwkgUznSBUlQCRh
 52VP2Ljsl7Eim5kxk17MHG6H1gZoRqHPxMkhqlDiZqwib/c5yKljQ2pyB4lLKHc3kWxQX42ub
 KOCioXdy+3fUZJgVvQorXle99CaXC03SMpSkWuYbGgZZimAGXop+lY2n0gkADe1i+s0vX/s3a
 DHrgqxaFcTyKlrf7D9Bv5f1DV6CIfdErUGCmfzY5MPYK9rDHx6XgC0n/ayK0NmBt/3YwSlziK
 yZx/nwkbRmlALBorvIm/g1GkPg6sKBHoozn54Rclxm6voJY0kMrYJ7VCR5AziC+K+gt39Z8/p
 otVDz5ATZRy9+D/MElfKiLVbdHY+XDvSCXP4pKLZ+Bc9wQUGsmUDy8vutuFj3LOqzw+HbPRkn
 AUahkTJD3dEiwnwhiors/22XMbqNOpDaSODoLMC0IFwx/13XAHKa3zhSXN/AtFBXdk4eA7VDq
 R0N/NxovNvYvD7kRdHKxtAh63X6+wnlI/DhAaAHSjP5Oa9C8B1D5plG3i2Z0npgm5xOgnt/Hl
 pUzlXvZQIwTOoOLyRWloPdP/5RhenECn1W0BVDvuthDL9oq0eVfqbomFInR0+oXtitwukLf6X
 FdW2g0Jm2NXXNGqn/WqxzFEWNNAQOCYwmZ88DZPA5Sk2RNz1l5dfFrJKT+UruzIUo203K/gx9
 Mt4mKX+NmF5PFEc8MHzbgw/w==



=E5=9C=A8 2024/9/25 20:20, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> We are using the logical address ("bytenr") of an extent as the key for
> qgroup records in the dirty extents xarray. This is a problem because th=
e
> xarrays use "unsigned long" for keys/indices, meaning that on a 32 bits
> platform any extent starting at or beyond 4G is truncated, which is a to=
o
> low limitation as virtually everyone is using storage with more than 4G =
of
> space. This means a "bytenr" of 4G gets truncated to 0, and so does 8G a=
nd
> 16G for example, resulting in incorrect qgroup accounting.
>
> Fix this by using sector numbers as keys instead, that is, using keys th=
at
> match the logical address right shifted by fs_info->sectorsize_bits, whi=
ch
> is what we do for the fs_info->buffer_radix that tracks extent buffers
> (radix trees also use an "unsigned long" type for keys). This also makes
> the index space more dense which helps optimize the xarray (as mentioned
> at Documentation/core-api/xarray.rst).
>
> Fixes: 3cce39a8ca4e ("btrfs: qgroup: use xarray to track dirty extents i=
n transaction")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/delayed-ref.c | 13 ++++++++-----
>   fs/btrfs/delayed-ref.h | 10 +++++++++-
>   fs/btrfs/qgroup.c      | 11 ++++++-----
>   3 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 32f719b9e661..f075ac11e51c 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -849,6 +849,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *tran=
s,
>   		     struct btrfs_qgroup_extent_record *qrecord,
>   		     int action, bool *qrecord_inserted_ret)
>   {
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	struct btrfs_delayed_ref_head *existing;
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	bool qrecord_inserted =3D false;
> @@ -859,11 +860,12 @@ add_delayed_ref_head(struct btrfs_trans_handle *tr=
ans,
>   	if (qrecord) {
>   		int ret;
>
> -		ret =3D btrfs_qgroup_trace_extent_nolock(trans->fs_info,
> +		ret =3D btrfs_qgroup_trace_extent_nolock(fs_info,
>   						       delayed_refs, qrecord);
>   		if (ret) {
>   			/* Clean up if insertion fails or item exists. */
> -			xa_release(&delayed_refs->dirty_extents, qrecord->bytenr);
> +			xa_release(&delayed_refs->dirty_extents,
> +				   qrecord->bytenr >> fs_info->sectorsize_bits);
>   			/* Caller responsible for freeing qrecord on error. */
>   			if (ret < 0)
>   				return ERR_PTR(ret);
> @@ -873,7 +875,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *tran=
s,
>   		}
>   	}
>
> -	trace_add_delayed_ref_head(trans->fs_info, head_ref, action);
> +	trace_add_delayed_ref_head(fs_info, head_ref, action);
>
>   	existing =3D htree_insert(&delayed_refs->href_root,
>   				&head_ref->href_node);
> @@ -895,7 +897,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *tran=
s,
>   		if (head_ref->is_data && head_ref->ref_mod < 0) {
>   			delayed_refs->pending_csums +=3D head_ref->num_bytes;
>   			trans->delayed_ref_csum_deletions +=3D
> -				btrfs_csum_bytes_to_leaves(trans->fs_info,
> +				btrfs_csum_bytes_to_leaves(fs_info,
>   							   head_ref->num_bytes);
>   		}
>   		delayed_refs->num_heads++;
> @@ -1030,7 +1032,8 @@ static int add_delayed_ref(struct btrfs_trans_hand=
le *trans,
>   			goto free_head_ref;
>   		}
>   		if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents,
> -			       generic_ref->bytenr, GFP_NOFS)) {
> +			       generic_ref->bytenr >> fs_info->sectorsize_bits,
> +			       GFP_NOFS)) {
>   			ret =3D -ENOMEM;
>   			goto free_record;
>   		}
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 085f30968aba..352921e76c74 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -202,7 +202,15 @@ struct btrfs_delayed_ref_root {
>   	/* head ref rbtree */
>   	struct rb_root_cached href_root;
>
> -	/* Track dirty extent records. */
> +	/*
> +	 * Track dirty extent records.
> +	 * The keys correspond to the logical address of the extent ("bytenr")
> +	 * right shifted by fs_info->sectorsize_bits. This is both to get a mo=
re
> +	 * dense index space (optimizes xarray structure) and because indexes =
in
> +	 * xarrays are of "unsigned long" type, meaning they are 32 bits wide =
on
> +	 * 32 bits platforms, limiting the extent range to 4G which is too low
> +	 * and makes it unusable (truncated index values) on 32 bits platforms=
.
> +	 */
>   	struct xarray dirty_extents;
>
>   	/* this spin lock protects the rbtree and the entries inside */
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index c297909f1506..a76e4610fe80 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2005,7 +2005,7 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_=
fs_info *fs_info,
>   				struct btrfs_qgroup_extent_record *record)
>   {
>   	struct btrfs_qgroup_extent_record *existing, *ret;
> -	unsigned long bytenr =3D record->bytenr;
> +	const unsigned long index =3D (record->bytenr >> fs_info->sectorsize_b=
its);

Could we check if record->bytenr >=3D MAX_LFS_FILESIZE and error out direc=
tly?
(With btrfs_err_32bit_limit() called to indicate the problem).

Just like what we did in alloc_extent_buffer().

Otherwise looks good.

Thanks,
Qu

>
>   	if (!btrfs_qgroup_full_accounting(fs_info))
>   		return 1;
> @@ -2014,7 +2014,7 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_=
fs_info *fs_info,
>   	trace_btrfs_qgroup_trace_extent(fs_info, record);
>
>   	xa_lock(&delayed_refs->dirty_extents);
> -	existing =3D xa_load(&delayed_refs->dirty_extents, bytenr);
> +	existing =3D xa_load(&delayed_refs->dirty_extents, index);
>   	if (existing) {
>   		if (record->data_rsv && !existing->data_rsv) {
>   			existing->data_rsv =3D record->data_rsv;
> @@ -2024,7 +2024,7 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_=
fs_info *fs_info,
>   		return 1;
>   	}
>
> -	ret =3D __xa_store(&delayed_refs->dirty_extents, record->bytenr, recor=
d, GFP_ATOMIC);
> +	ret =3D __xa_store(&delayed_refs->dirty_extents, index, record, GFP_AT=
OMIC);
>   	xa_unlock(&delayed_refs->dirty_extents);
>   	if (xa_is_err(ret)) {
>   		qgroup_mark_inconsistent(fs_info);
> @@ -2129,6 +2129,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_h=
andle *trans, u64 bytenr,
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	struct btrfs_qgroup_extent_record *record;
>   	struct btrfs_delayed_ref_root *delayed_refs;
> +	const unsigned long index =3D (bytenr >> fs_info->sectorsize_bits);
>   	int ret;
>
>   	if (!btrfs_qgroup_full_accounting(fs_info) || bytenr =3D=3D 0 || num_=
bytes =3D=3D 0)
> @@ -2137,7 +2138,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_h=
andle *trans, u64 bytenr,
>   	if (!record)
>   		return -ENOMEM;
>
> -	if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents, bytenr=
, GFP_NOFS)) {
> +	if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents, index,=
 GFP_NOFS)) {
>   		kfree(record);
>   		return -ENOMEM;
>   	}
> @@ -2152,7 +2153,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_h=
andle *trans, u64 bytenr,
>   	spin_unlock(&delayed_refs->lock);
>   	if (ret) {
>   		/* Clean up if insertion fails or item exists. */
> -		xa_release(&delayed_refs->dirty_extents, record->bytenr);
> +		xa_release(&delayed_refs->dirty_extents, index);
>   		kfree(record);
>   		return 0;
>   	}


