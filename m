Return-Path: <linux-btrfs+bounces-14185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC29AC2048
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 11:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE499E1786
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211E23E346;
	Fri, 23 May 2025 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="i26hqzq8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D6236421
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747994034; cv=none; b=LMl+qTClyeQTg98SaBBlkPSLQv7StAc4vH/voPjZHL9+OIGZSvU/Nn9xotebvvlaQeELSUYM4tImW5lygpUuhBVoqoZtckSPKjxDbQLGah35P107B5N4xQ5zVqgGKVTL+4O09rTaWGvlCstKCsj50gu8DR6LvghdZY9HayK79ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747994034; c=relaxed/simple;
	bh=CWqnFEp5gIQZK4tfbuSoYRlhvP/ZKAs9mk+LXBO0jAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YvqM2MOh01r+EnYzf1a+te612jT8cFEnTfFStmlqT+uQEbrP0LauBDkHZYwYEq76x2H21EdijMryhK5kGp1LXQZw/0aOeMDaW4TIEMY8rTGxkmjphV46H7rnuPnMxe/nRgShwYUwK4fsmNcyl2KpmzKPgRkWzel+OYHTgVyESGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=i26hqzq8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747994025; x=1748598825; i=quwenruo.btrfs@gmx.com;
	bh=qwPAa2lEdhXLZnLM7Rro+rDAmaXW5vGrPx6NtOufo3c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i26hqzq8rbaOglUMG2w9DThVIqF0ZoF3I93jSoRZM6/b6uzok0LwnACjJA7J/SS9
	 GwSsXy1L5EW5bsymcSx7ELXPnjoxFZ3tNVEtz3cqENfeE2KDPp5C6kdPSX5EnWQm5
	 aRwyoMXpMz02EN0gMNS/T+iLaT9XlAcSBmYgQwrqAwey4AdFFL7Slmd4TyUmEfNnq
	 tjp8FoJqAJZVwp2QFSMy7FDUJn+26R4lzor84WMLmV5wirBfeqgdj0iznhFJbg0yi
	 SNItj3yNlRclBoll7SV9Tl1/9JhOaGGFGEbA0y1hRJHaQ5PWVRmpOfhzSMzfIXVhb
	 FOoYo7ik/ZQWBStYyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq6M-1vBTea3gsa-00rhpo; Fri, 23
 May 2025 11:53:45 +0200
Message-ID: <1b511b2f-0738-42a1-95af-546bd7b4e51e@gmx.com>
Date: Fri, 23 May 2025 19:23:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/10] btrfs: add extended version of struct
 block_group_item
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20250515163641.3449017-1-maharmstone@fb.com>
 <20250515163641.3449017-5-maharmstone@fb.com>
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
In-Reply-To: <20250515163641.3449017-5-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:37vrn1p8QgO3khYZvXHLbxlKJocUYpGw9Kz3GxczSlLpF1EtBPH
 P5KPwBl84rC5cYYi1FpdFFenigrM5Pb6WnBV/AHyvS8ghqMK7j7Bq59YfzhsDYRNy5J+K8g
 0VTtlLVS8tMWYq3MLoi8Q0+owvJOuLU81kWdOgfwVa7Oe9FF21NTib06eVmsGBx3Yn1+Phz
 Ckyz3+3jFyoDH4hxNoLAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6X/pC6eeGtk=;EBiB6+ceHdsnCFSlcWWCix+cql2
 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



=E5=9C=A8 2025/5/16 02:06, Mark Harmstone =E5=86=99=E9=81=93:
> Add a struct btrfs_block_group_item_v2, which is used in the block group
> tree if the remap-tree incompat flag is set.
>=20
> This adds two new fields to the block group item: `remap_bytes` and
> `identity_remap_count`.
>=20
> `remap_bytes` records the amount of data that's physically within this
> block group, but nominally in another, remapped block group. This is
> necessary because this data will need to be moved first if this block
> group is itself relocated. If `remap_bytes` > 0, this is an indicator to
> the relocation thread that it will need to search the remap-tree for
> backrefs. A block group must also have `remap_bytes` =3D=3D 0 before it =
can
> be dropped.
>=20
> `identity_remap_count` records how many identity remap items are located
> in the remap tree for this block group. When relocation is begun for
> this block group, this is set to the number of holes in the free-space
> tree for this range. As identity remaps are converted into actual remaps
> by the relocation process, this number is decreased. Once it reaches 0,
> either because of relocation or because extents have been deleted, the
> block group has been fully remapped and its chunk's device extents are
> removed.

Can we add those two items into a new item other than a completely new=20
v2 block group item?

I mean for regular block groups they do not need those members, and all=20
block groups starts from regular ones at mkfs time.

We can add a regular block group flag to indicate if the bg has the=20
extra members.

Thanks,
Qu

>=20
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>   fs/btrfs/accessors.h            |  20 +++++++
>   fs/btrfs/block-group.c          | 101 ++++++++++++++++++++++++--------
>   fs/btrfs/block-group.h          |  14 ++++-
>   fs/btrfs/tree-checker.c         |  10 +++-
>   include/uapi/linux/btrfs_tree.h |   8 +++
>   5 files changed, 126 insertions(+), 27 deletions(-)
>=20
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index 5f5eda8d6f9e..6e6dd664217b 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -264,6 +264,26 @@ BTRFS_SETGET_FUNCS(block_group_flags, struct btrfs_=
block_group_item, flags, 64);
>   BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
>   			struct btrfs_block_group_item, flags, 64);
>  =20
> +/* struct btrfs_block_group_item_v2 */
> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_used, struct btrfs_block_=
group_item_v2,
> +			 used, 64);
> +BTRFS_SETGET_FUNCS(block_group_v2_used, struct btrfs_block_group_item_v=
2, used, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_chunk_objectid,
> +			 struct btrfs_block_group_item_v2, chunk_objectid, 64);
> +BTRFS_SETGET_FUNCS(block_group_v2_chunk_objectid,
> +		   struct btrfs_block_group_item_v2, chunk_objectid, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_flags,
> +			 struct btrfs_block_group_item_v2, flags, 64);
> +BTRFS_SETGET_FUNCS(block_group_v2_flags, struct btrfs_block_group_item_=
v2, flags, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_remap_bytes,
> +			 struct btrfs_block_group_item_v2, remap_bytes, 64);
> +BTRFS_SETGET_FUNCS(block_group_v2_remap_bytes, struct btrfs_block_group=
_item_v2,
> +		   remap_bytes, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_identity_remap_count,
> +			 struct btrfs_block_group_item_v2, identity_remap_count, 32);
> +BTRFS_SETGET_FUNCS(block_group_v2_identity_remap_count, struct btrfs_bl=
ock_group_item_v2,
> +		   identity_remap_count, 32);
> +
>   /* struct btrfs_free_space_info */
>   BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_in=
fo,
>   		   extent_count, 32);
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5b0cb04b2b93..6a2aa792ccb2 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2351,7 +2351,7 @@ static int check_chunk_block_group_mappings(struct=
 btrfs_fs_info *fs_info)
>   }
>  =20
>   static int read_one_block_group(struct btrfs_fs_info *info,
> -				struct btrfs_block_group_item *bgi,
> +				struct btrfs_block_group_item_v2 *bgi,
>   				const struct btrfs_key *key,
>   				int need_clear)
>   {
> @@ -2366,11 +2366,16 @@ static int read_one_block_group(struct btrfs_fs_=
info *info,
>   		return -ENOMEM;
>  =20
>   	cache->length =3D key->offset;
> -	cache->used =3D btrfs_stack_block_group_used(bgi);
> +	cache->used =3D btrfs_stack_block_group_v2_used(bgi);
>   	cache->commit_used =3D cache->used;
> -	cache->flags =3D btrfs_stack_block_group_flags(bgi);
> -	cache->global_root_id =3D btrfs_stack_block_group_chunk_objectid(bgi);
> +	cache->flags =3D btrfs_stack_block_group_v2_flags(bgi);
> +	cache->global_root_id =3D btrfs_stack_block_group_v2_chunk_objectid(bg=
i);
>   	cache->space_info =3D btrfs_find_space_info(info, cache->flags);
> +	cache->remap_bytes =3D btrfs_stack_block_group_v2_remap_bytes(bgi);
> +	cache->commit_remap_bytes =3D cache->remap_bytes;
> +	cache->identity_remap_count =3D
> +		btrfs_stack_block_group_v2_identity_remap_count(bgi);
> +	cache->commit_identity_remap_count =3D cache->identity_remap_count;
>  =20
>   	set_free_space_tree_thresholds(cache);
>  =20
> @@ -2435,7 +2440,7 @@ static int read_one_block_group(struct btrfs_fs_in=
fo *info,
>   	} else if (cache->length =3D=3D cache->used) {
>   		cache->cached =3D BTRFS_CACHE_FINISHED;
>   		btrfs_free_excluded_extents(cache);
> -	} else if (cache->used =3D=3D 0) {
> +	} else if (cache->used =3D=3D 0 && cache->remap_bytes =3D=3D 0) {
>   		cache->cached =3D BTRFS_CACHE_FINISHED;
>   		ret =3D btrfs_add_new_free_space(cache, cache->start,
>   					       cache->start + cache->length, NULL);
> @@ -2455,7 +2460,8 @@ static int read_one_block_group(struct btrfs_fs_in=
fo *info,
>  =20
>   	set_avail_alloc_bits(info, cache->flags);
>   	if (btrfs_chunk_writeable(info, cache->start)) {
> -		if (cache->used =3D=3D 0) {
> +		if (cache->used =3D=3D 0 && cache->identity_remap_count =3D=3D 0 &&
> +		    cache->remap_bytes =3D=3D 0) {
>   			ASSERT(list_empty(&cache->bg_list));
>   			if (btrfs_test_opt(info, DISCARD_ASYNC))
>   				btrfs_discard_queue_work(&info->discard_ctl, cache);
> @@ -2559,9 +2565,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info =
*info)
>   		need_clear =3D 1;
>  =20
>   	while (1) {
> -		struct btrfs_block_group_item bgi;
> +		struct btrfs_block_group_item_v2 bgi;
>   		struct extent_buffer *leaf;
>   		int slot;
> +		size_t size;
>  =20
>   		ret =3D find_first_block_group(info, path, &key);
>   		if (ret > 0)
> @@ -2572,8 +2579,16 @@ int btrfs_read_block_groups(struct btrfs_fs_info =
*info)
>   		leaf =3D path->nodes[0];
>   		slot =3D path->slots[0];
>  =20
> +		if (btrfs_fs_incompat(info, REMAP_TREE)) {
> +			size =3D sizeof(struct btrfs_block_group_item_v2);
> +		} else {
> +			size =3D sizeof(struct btrfs_block_group_item);
> +			btrfs_set_stack_block_group_v2_remap_bytes(&bgi, 0);
> +			btrfs_set_stack_block_group_v2_identity_remap_count(&bgi, 0);
> +		}
> +
>   		read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
> -				   sizeof(bgi));
> +				   size);
>  =20
>   		btrfs_item_key_to_cpu(leaf, &key, slot);
>   		btrfs_release_path(path);
> @@ -2643,25 +2658,38 @@ static int insert_block_group_item(struct btrfs_=
trans_handle *trans,
>   				   struct btrfs_block_group *block_group)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_block_group_item bgi;
> +	struct btrfs_block_group_item_v2 bgi;
>   	struct btrfs_root *root =3D btrfs_block_group_root(fs_info);
>   	struct btrfs_key key;
>   	u64 old_commit_used;
> +	size_t size;
>   	int ret;
>  =20
>   	spin_lock(&block_group->lock);
> -	btrfs_set_stack_block_group_used(&bgi, block_group->used);
> -	btrfs_set_stack_block_group_chunk_objectid(&bgi,
> -						   block_group->global_root_id);
> -	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
> +	btrfs_set_stack_block_group_v2_used(&bgi, block_group->used);
> +	btrfs_set_stack_block_group_v2_chunk_objectid(&bgi,
> +						      block_group->global_root_id);
> +	btrfs_set_stack_block_group_v2_flags(&bgi, block_group->flags);
> +	btrfs_set_stack_block_group_v2_remap_bytes(&bgi,
> +						   block_group->remap_bytes);
> +	btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
> +					block_group->identity_remap_count);
>   	old_commit_used =3D block_group->commit_used;
>   	block_group->commit_used =3D block_group->used;
> +	block_group->commit_remap_bytes =3D block_group->remap_bytes;
> +	block_group->commit_identity_remap_count =3D
> +		block_group->identity_remap_count;
>   	key.objectid =3D block_group->start;
>   	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>   	key.offset =3D block_group->length;
>   	spin_unlock(&block_group->lock);
>  =20
> -	ret =3D btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE))
> +		size =3D sizeof(struct btrfs_block_group_item_v2);
> +	else
> +		size =3D sizeof(struct btrfs_block_group_item);
> +
> +	ret =3D btrfs_insert_item(trans, root, &key, &bgi, size);
>   	if (ret < 0) {
>   		spin_lock(&block_group->lock);
>   		block_group->commit_used =3D old_commit_used;
> @@ -3116,10 +3144,12 @@ static int update_block_group_item(struct btrfs_=
trans_handle *trans,
>   	struct btrfs_root *root =3D btrfs_block_group_root(fs_info);
>   	unsigned long bi;
>   	struct extent_buffer *leaf;
> -	struct btrfs_block_group_item bgi;
> +	struct btrfs_block_group_item_v2 bgi;
>   	struct btrfs_key key;
> -	u64 old_commit_used;
> -	u64 used;
> +	u64 old_commit_used, old_commit_remap_bytes;
> +	u32 old_commit_identity_remap_count;
> +	u64 used, remap_bytes;
> +	u32 identity_remap_count;
>  =20
>   	/*
>   	 * Block group items update can be triggered out of commit transactio=
n
> @@ -3129,13 +3159,21 @@ static int update_block_group_item(struct btrfs_=
trans_handle *trans,
>   	 */
>   	spin_lock(&cache->lock);
>   	old_commit_used =3D cache->commit_used;
> +	old_commit_remap_bytes =3D cache->commit_remap_bytes;
> +	old_commit_identity_remap_count =3D cache->commit_identity_remap_count=
;
>   	used =3D cache->used;
> -	/* No change in used bytes, can safely skip it. */
> -	if (cache->commit_used =3D=3D used) {
> +	remap_bytes =3D cache->remap_bytes;
> +	identity_remap_count =3D cache->identity_remap_count;
> +	/* No change in values, can safely skip it. */
> +	if (cache->commit_used =3D=3D used &&
> +	    cache->commit_remap_bytes =3D=3D remap_bytes &&
> +	    cache->commit_identity_remap_count =3D=3D identity_remap_count) {
>   		spin_unlock(&cache->lock);
>   		return 0;
>   	}
>   	cache->commit_used =3D used;
> +	cache->commit_remap_bytes =3D remap_bytes;
> +	cache->commit_identity_remap_count =3D identity_remap_count;
>   	spin_unlock(&cache->lock);
>  =20
>   	key.objectid =3D cache->start;
> @@ -3151,11 +3189,23 @@ static int update_block_group_item(struct btrfs_=
trans_handle *trans,
>  =20
>   	leaf =3D path->nodes[0];
>   	bi =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
> -	btrfs_set_stack_block_group_used(&bgi, used);
> -	btrfs_set_stack_block_group_chunk_objectid(&bgi,
> -						   cache->global_root_id);
> -	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
> -	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
> +	btrfs_set_stack_block_group_v2_used(&bgi, used);
> +	btrfs_set_stack_block_group_v2_chunk_objectid(&bgi,
> +						      cache->global_root_id);
> +	btrfs_set_stack_block_group_v2_flags(&bgi, cache->flags);
> +
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		btrfs_set_stack_block_group_v2_remap_bytes(&bgi,
> +							   cache->remap_bytes);
> +		btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
> +						cache->identity_remap_count);
> +		write_extent_buffer(leaf, &bgi, bi,
> +				    sizeof(struct btrfs_block_group_item_v2));
> +	} else {
> +		write_extent_buffer(leaf, &bgi, bi,
> +				    sizeof(struct btrfs_block_group_item));
> +	}
> +
>   fail:
>   	btrfs_release_path(path);
>   	/*
> @@ -3170,6 +3220,9 @@ static int update_block_group_item(struct btrfs_tr=
ans_handle *trans,
>   	if (ret < 0 && ret !=3D -ENOENT) {
>   		spin_lock(&cache->lock);
>   		cache->commit_used =3D old_commit_used;
> +		cache->commit_remap_bytes =3D old_commit_remap_bytes;
> +		cache->commit_identity_remap_count =3D
> +			old_commit_identity_remap_count;
>   		spin_unlock(&cache->lock);
>   	}
>   	return ret;
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 9de356bcb411..c484118b8b8d 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -127,6 +127,8 @@ struct btrfs_block_group {
>   	u64 flags;
>   	u64 cache_generation;
>   	u64 global_root_id;
> +	u64 remap_bytes;
> +	u32 identity_remap_count;
>  =20
>   	/*
>   	 * The last committed used bytes of this block group, if the above @u=
sed
> @@ -134,6 +136,15 @@ struct btrfs_block_group {
>   	 * group item of this block group.
>   	 */
>   	u64 commit_used;
> +	/*
> +	 * The last committed remap_bytes value of this block group.
> +	 */
> +	u64 commit_remap_bytes;
> +	/*
> +	 * The last commited identity_remap_count value of this block group.
> +	 */
> +	u32 commit_identity_remap_count;
> +
>   	/*
>   	 * If the free space extent count exceeds this number, convert the bl=
ock
>   	 * group to bitmaps.
> @@ -275,7 +286,8 @@ static inline bool btrfs_is_block_group_used(const s=
truct btrfs_block_group *bg)
>   {
>   	lockdep_assert_held(&bg->lock);
>  =20
> -	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
> +	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0 ||
> +		bg->remap_bytes > 0);
>   }
>  =20
>   static inline bool btrfs_is_block_group_data_only(const struct btrfs_b=
lock_group *block_group)
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index fd83df06e3fb..25311576fab6 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -687,6 +687,7 @@ static int check_block_group_item(struct extent_buff=
er *leaf,
>   	u64 chunk_objectid;
>   	u64 flags;
>   	u64 type;
> +	size_t exp_size;
>  =20
>   	/*
>   	 * Here we don't really care about alignment since extent allocator c=
an
> @@ -698,10 +699,15 @@ static int check_block_group_item(struct extent_bu=
ffer *leaf,
>   		return -EUCLEAN;
>   	}
>  =20
> -	if (unlikely(item_size !=3D sizeof(bgi))) {
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE))
> +		exp_size =3D sizeof(struct btrfs_block_group_item_v2);
> +	else
> +		exp_size =3D sizeof(struct btrfs_block_group_item);
> +
> +	if (unlikely(item_size !=3D exp_size)) {
>   		block_group_err(leaf, slot,
>   			"invalid item size, have %u expect %zu",
> -				item_size, sizeof(bgi));
> +				item_size, exp_size);
>   		return -EUCLEAN;
>   	}
>  =20
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_=
tree.h
> index 9a36f0206d90..500e3a7df90b 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -1229,6 +1229,14 @@ struct btrfs_block_group_item {
>   	__le64 flags;
>   } __attribute__ ((__packed__));
>  =20
> +struct btrfs_block_group_item_v2 {
> +	__le64 used;
> +	__le64 chunk_objectid;
> +	__le64 flags;
> +	__le64 remap_bytes;
> +	__le32 identity_remap_count;
> +} __attribute__ ((__packed__));
> +
>   struct btrfs_free_space_info {
>   	__le32 extent_count;
>   	__le32 flags;


