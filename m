Return-Path: <linux-btrfs+bounces-18920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07219C54823
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 21:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E969348DA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401312D7DFB;
	Wed, 12 Nov 2025 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="L5urA61U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E526E703;
	Wed, 12 Nov 2025 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980611; cv=none; b=PBiJe8N5/u8P3/Daiek/QhLltTBIzVrIfotcClwgEuvTvk+Qcsw1jAn5zKO3s8cv2buiLQm06UGz4pGq6pSUomXTkCIxQxifsLyjS4NvvXF6V+dKstpOxJ7LFIvwCjP6Qse9KQQ+EzAH87CziOIPohryHSSQSNazLcaoNYrI7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980611; c=relaxed/simple;
	bh=RGKYoo6vGRKlyC1UDZGwQHV/jP0MGA7yfxN3TbReJ2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RaRpxOVN5U6Op0e/nA2L0venBRHiSy3/P44I22iabwl2XnUfs7JEbc5VRaNlu9r5UURdiqTsmADuxiuo6PAFGkwZKvaXgExe30FypP83zMR0TbJRcSWk4yY5pauwoPJnLIn84ZMFHzdUp4n++0NOF2lMQcGf0bdjQQIv/08j6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=L5urA61U; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762980606; x=1763585406; i=quwenruo.btrfs@gmx.com;
	bh=bGpl5tsMbfoUPDL8UI44Y1Ax8IzP1hU6PfQ3Y3tJ/Z4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L5urA61U9jWhOEtFlW8NR0MDXOm9WWCpq8Imnpseny+SXbKxm3o3FOG3lcbVpODD
	 hnshNrH2ZPNDSZbNA8TC15E5ULtnWHb4S2BCNjz762TuvI7Clre+/L6J1CzjCzGwT
	 0wc4Ew9NkrrAiGaKYz18FgtDWv6ScQeQGh5wBK9V+2YbXKRcxZPLRvCpgkIGQ9zw1
	 F8TEEm17eIIOMTle5wEuh9AXe95Gwbo/NJMWBjq06P54Ni4WLujFirtSSQZ3Zivoe
	 ZDjEmmMJ1zTWZFXcnduu6d34sBVle4nEFCwiiNoP4SED780DiTLKxF3LJ5PtYqcv3
	 smFTY3h40avH7U3vFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzOm-1vXVmT0NnY-00IJoF; Wed, 12
 Nov 2025 21:50:05 +0100
Message-ID: <0a31cf84-ccfe-4da4-b922-85da570c6e3b@gmx.com>
Date: Thu, 13 Nov 2025 07:20:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] btrfs: simplify return path via cleanup.h
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1762972845.git.foxido@foxido.dev>
 <5bfb05436ed8f80bc060a745805d54309cdba59c.1762972845.git.foxido@foxido.dev>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <5bfb05436ed8f80bc060a745805d54309cdba59c.1762972845.git.foxido@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dRCTrP4i4oAsElbw7zfBp7DZWni7DpcwZe6l3WlKdnrjWoUumJl
 0MlLN+r9WL09bPUvGmNeqiTliXa2QYJSAIjw/GvQkRKQQmIYZp9UpfnBqJqc9/g1qb6QL7j
 qHOL+fr8F05Vwj20PNR08kwf145x0seWbmXdIR/LyAA5DBKgePyzfWpeqct5Efav5IT5Ckf
 /SZlasQzdgluEKlVZJqQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V7ufUDkXIT4=;ZqD5f8C3mu6sDLWJKzgawQvXuSg
 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
 FFBoWyRA=



=E5=9C=A8 2025/11/13 05:19, Gladyshev Ilya =E5=86=99=E9=81=93:
> In some functions removing cleanup paths allows to overall simplify it's
> code, so replace cleanup paths with guard()s.
>=20
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
>   fs/btrfs/extent-io-tree.c | 21 ++++-----
>   fs/btrfs/extent-tree.c    | 96 ++++++++++++++++-----------------------
>   fs/btrfs/ordered-data.c   | 46 ++++++++-----------
>   3 files changed, 68 insertions(+), 95 deletions(-)
>=20
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index 69ea2bd359a6..88d7aed7055f 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -890,9 +890,8 @@ bool btrfs_find_first_extent_bit(struct extent_io_tr=
ee *tree, u64 start,
>   				 struct extent_state **cached_state)
>   {
>   	struct extent_state *state;
> -	bool ret =3D false;
>  =20
> -	spin_lock(&tree->lock);
> +	guard(spinlock)(&tree->lock);
>   	if (cached_state && *cached_state) {
>   		state =3D *cached_state;
>   		if (state->end =3D=3D start - 1 && extent_state_in_tree(state)) {
> @@ -911,23 +910,21 @@ bool btrfs_find_first_extent_bit(struct extent_io_=
tree *tree, u64 start,
>   			*cached_state =3D NULL;
>   			if (state)
>   				goto got_it;
> -			goto out;
> +			return false;
>   		}
>   		btrfs_free_extent_state(*cached_state);
>   		*cached_state =3D NULL;
>   	}
>  =20
>   	state =3D find_first_extent_bit_state(tree, start, bits);
> +	if (!state)
> +		return false;
> +
>   got_it:
> -	if (state) {
> -		cache_state_if_flags(state, cached_state, 0);
> -		*start_ret =3D state->start;
> -		*end_ret =3D state->end;
> -		ret =3D true;
> -	}
> -out:
> -	spin_unlock(&tree->lock);
> -	return ret;
> +	cache_state_if_flags(state, cached_state, 0);
> +	*start_ret =3D state->start;
> +	*end_ret =3D state->end;
> +	return true;
>   }
>  =20
>   /*
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f9744e456c6c..cb3d61d96e66 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1878,16 +1878,14 @@ static int cleanup_ref_head(struct btrfs_trans_h=
andle *trans,
>   	 * and then re-check to make sure nobody got added.
>   	 */
>   	spin_unlock(&head->lock);
> -	spin_lock(&delayed_refs->lock);
> -	spin_lock(&head->lock);
> -	if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op) {
> -		spin_unlock(&head->lock);
> -		spin_unlock(&delayed_refs->lock);
> -		return 1;
> +	{

There are some internal discussion about such anonymous code block usage.

Although I support such usage, especially when it can reduce the=20
lifespan of local variables, it's not a commonly accepted pattern yet.

Thanks,
Qu

> +		guard(spinlock)(&delayed_refs->lock);
> +		guard(spinlock)(&head->lock);
> +
> +		if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op)
> +			return 1;
> +		btrfs_delete_ref_head(fs_info, delayed_refs, head);
>   	}
> -	btrfs_delete_ref_head(fs_info, delayed_refs, head);
> -	spin_unlock(&head->lock);
> -	spin_unlock(&delayed_refs->lock);
>  =20
>   	if (head->must_insert_reserved) {
>   		btrfs_pin_extent(trans, head->bytenr, head->num_bytes, 1);
> @@ -3391,30 +3389,29 @@ static noinline int check_ref_cleanup(struct btr=
fs_trans_handle *trans,
>   	int ret =3D 0;
>  =20
>   	delayed_refs =3D &trans->transaction->delayed_refs;
> -	spin_lock(&delayed_refs->lock);
> -	head =3D btrfs_find_delayed_ref_head(fs_info, delayed_refs, bytenr);
> -	if (!head)
> -		goto out_delayed_unlock;
> -
> -	spin_lock(&head->lock);
> -	if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root))
> -		goto out;
> +	{
> +		guard(spinlock)(&delayed_refs->lock);
> +		head =3D btrfs_find_delayed_ref_head(fs_info, delayed_refs, bytenr);
> +		if (!head)
> +			return 0;
>  =20
> -	if (cleanup_extent_op(head) !=3D NULL)
> -		goto out;
> +		guard(spinlock)(&head->lock);
> +		if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root))
> +			return 0;
>  =20
> -	/*
> -	 * waiting for the lock here would deadlock.  If someone else has it
> -	 * locked they are already in the process of dropping it anyway
> -	 */
> -	if (!mutex_trylock(&head->mutex))
> -		goto out;
> +		if (cleanup_extent_op(head) !=3D NULL)
> +			return 0;
>  =20
> -	btrfs_delete_ref_head(fs_info, delayed_refs, head);
> -	head->processing =3D false;
> +		/*
> +		 * waiting for the lock here would deadlock.  If someone else has it
> +		 * locked they are already in the process of dropping it anyway
> +		 */
> +		if (!mutex_trylock(&head->mutex))
> +			return 0;
>  =20
> -	spin_unlock(&head->lock);
> -	spin_unlock(&delayed_refs->lock);
> +		btrfs_delete_ref_head(fs_info, delayed_refs, head);
> +		head->processing =3D false;
> +	}
>  =20
>   	BUG_ON(head->extent_op);
>   	if (head->must_insert_reserved)
> @@ -3424,12 +3421,6 @@ static noinline int check_ref_cleanup(struct btrf=
s_trans_handle *trans,
>   	mutex_unlock(&head->mutex);
>   	btrfs_put_delayed_ref_head(head);
>   	return ret;
> -out:
> -	spin_unlock(&head->lock);
> -
> -out_delayed_unlock:
> -	spin_unlock(&delayed_refs->lock);
> -	return 0;
>   }
>  =20
>   int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
> @@ -3910,13 +3901,13 @@ static int do_allocation_zoned(struct btrfs_bloc=
k_group *block_group,
>   		 */
>   	}
>  =20
> -	spin_lock(&space_info->lock);
> -	spin_lock(&block_group->lock);
> -	spin_lock(&fs_info->treelog_bg_lock);
> -	spin_lock(&fs_info->relocation_bg_lock);
> +	guard(spinlock)(&space_info->lock);
> +	guard(spinlock)(&block_group->lock);
> +	guard(spinlock)(&fs_info->treelog_bg_lock);
> +	guard(spinlock)(&fs_info->relocation_bg_lock);
>  =20
>   	if (ret)
> -		goto out;
> +		goto err;
>  =20
>   	ASSERT(!ffe_ctl->for_treelog ||
>   	       block_group->start =3D=3D fs_info->treelog_bg ||
> @@ -3928,8 +3919,7 @@ static int do_allocation_zoned(struct btrfs_block_=
group *block_group,
>   	if (block_group->ro ||
>   	    (!ffe_ctl->for_data_reloc &&
>   	     test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtim=
e_flags))) {
> -		ret =3D 1;
> -		goto out;
> +		goto err;
>   	}
>  =20
>   	/*
> @@ -3938,8 +3928,7 @@ static int do_allocation_zoned(struct btrfs_block_=
group *block_group,
>   	 */
>   	if (ffe_ctl->for_treelog && !fs_info->treelog_bg &&
>   	    (block_group->used || block_group->reserved)) {
> -		ret =3D 1;
> -		goto out;
> +		goto err;
>   	}
>  =20
>   	/*
> @@ -3948,8 +3937,7 @@ static int do_allocation_zoned(struct btrfs_block_=
group *block_group,
>   	 */
>   	if (ffe_ctl->for_data_reloc && !fs_info->data_reloc_bg &&
>   	    (block_group->used || block_group->reserved)) {
> -		ret =3D 1;
> -		goto out;
> +		goto err;
>   	}
>  =20
>   	WARN_ON_ONCE(block_group->alloc_offset > block_group->zone_capacity);
> @@ -3963,8 +3951,7 @@ static int do_allocation_zoned(struct btrfs_block_=
group *block_group,
>   			ffe_ctl->max_extent_size =3D avail;
>   			ffe_ctl->total_free_space =3D avail;
>   		}
> -		ret =3D 1;
> -		goto out;
> +		goto err;
>   	}
>  =20
>   	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
> @@ -4003,17 +3990,14 @@ static int do_allocation_zoned(struct btrfs_bloc=
k_group *block_group,
>   	 */
>  =20
>   	ffe_ctl->search_start =3D ffe_ctl->found_offset;
> +	return 0;
>  =20
> -out:
> -	if (ret && ffe_ctl->for_treelog)
> +err:
> +	if (ffe_ctl->for_treelog)
>   		fs_info->treelog_bg =3D 0;
> -	if (ret && ffe_ctl->for_data_reloc)
> +	if (ffe_ctl->for_data_reloc)
>   		fs_info->data_reloc_bg =3D 0;
> -	spin_unlock(&fs_info->relocation_bg_lock);
> -	spin_unlock(&fs_info->treelog_bg_lock);
> -	spin_unlock(&block_group->lock);
> -	spin_unlock(&space_info->lock);
> -	return ret;
> +	return 1;
>   }
>  =20
>   static int do_allocation(struct btrfs_block_group *block_group,
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 451b60de4550..4dbec4ef4ffd 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -995,35 +995,29 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_=
range(
>   	struct rb_node *node;
>   	struct btrfs_ordered_extent *entry =3D NULL;
>  =20
> -	spin_lock_irq(&inode->ordered_tree_lock);
> +	guard(spinlock_irq)(&inode->ordered_tree_lock);
>   	node =3D ordered_tree_search(inode, file_offset);
>   	if (!node) {
>   		node =3D ordered_tree_search(inode, file_offset + len);
>   		if (!node)
> -			goto out;
> +			return NULL;
>   	}
>  =20
>   	while (1) {
>   		entry =3D rb_entry(node, struct btrfs_ordered_extent, rb_node);
> -		if (btrfs_range_overlaps(entry, file_offset, len))
> -			break;
> +		if (btrfs_range_overlaps(entry, file_offset, len)) {
> +			refcount_inc(&entry->refs);
> +			trace_btrfs_ordered_extent_lookup_range(inode, entry);
> +			return entry;
> +		}
>  =20
>   		if (entry->file_offset >=3D file_offset + len) {
> -			entry =3D NULL;
> -			break;
> +			return NULL;
>   		}
> -		entry =3D NULL;
>   		node =3D rb_next(node);
>   		if (!node)
> -			break;
> +			return NULL;
>   	}
> -out:
> -	if (entry) {
> -		refcount_inc(&entry->refs);
> -		trace_btrfs_ordered_extent_lookup_range(inode, entry);
> -	}
> -	spin_unlock_irq(&inode->ordered_tree_lock);
> -	return entry;
>   }
>  =20
>   /*
> @@ -1092,7 +1086,7 @@ struct btrfs_ordered_extent *btrfs_lookup_first_or=
dered_range(
>   	struct rb_node *next;
>   	struct btrfs_ordered_extent *entry =3D NULL;
>  =20
> -	spin_lock_irq(&inode->ordered_tree_lock);
> +	guard(spinlock_irq)(&inode->ordered_tree_lock);
>   	node =3D inode->ordered_tree.rb_node;
>   	/*
>   	 * Here we don't want to use tree_search() which will use tree->last
> @@ -1112,12 +1106,12 @@ struct btrfs_ordered_extent *btrfs_lookup_first_=
ordered_range(
>   			 * Direct hit, got an ordered extent that starts at
>   			 * @file_offset
>   			 */
> -			goto out;
> +			goto ret_entry;
>   		}
>   	}
>   	if (!entry) {
>   		/* Empty tree */
> -		goto out;
> +		return NULL;
>   	}
>  =20
>   	cur =3D &entry->rb_node;
> @@ -1132,22 +1126,20 @@ struct btrfs_ordered_extent *btrfs_lookup_first_=
ordered_range(
>   	if (prev) {
>   		entry =3D rb_entry(prev, struct btrfs_ordered_extent, rb_node);
>   		if (btrfs_range_overlaps(entry, file_offset, len))
> -			goto out;
> +			goto ret_entry;
>   	}
>   	if (next) {
>   		entry =3D rb_entry(next, struct btrfs_ordered_extent, rb_node);
>   		if (btrfs_range_overlaps(entry, file_offset, len))
> -			goto out;
> +			goto ret_entry;
>   	}
>   	/* No ordered extent in the range */
> -	entry =3D NULL;
> -out:
> -	if (entry) {
> -		refcount_inc(&entry->refs);
> -		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
> -	}
> +	return NULL;
> +
> +ret_entry:
> +	refcount_inc(&entry->refs);
> +	trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
>  =20
> -	spin_unlock_irq(&inode->ordered_tree_lock);
>   	return entry;
>   }
>  =20


