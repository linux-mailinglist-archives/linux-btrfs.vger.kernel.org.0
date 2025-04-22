Return-Path: <linux-btrfs+bounces-13255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3687EA97B65
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 01:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F5D1790F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 23:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609F21C190;
	Tue, 22 Apr 2025 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BokOnU7l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022661EB1B7
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745366073; cv=none; b=CwXaBlxjvK18PAmJm53ORYHZCviTqIR0in36Hitd9D6gOdiDAK1/+8ij11L6RALvVKA6xXv30TYumY7iVC6vIFN80wPSMwMq3DSgkjK+p50s4yBaVQl8AUsOgSkGP4CR5XfMc+F7ju+ix/3jTwwJ25IjrwJQUYeu8xVA8n4FWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745366073; c=relaxed/simple;
	bh=4toRWZkZj28aPTIPvGKX/mj8JsJSw35MeC1drKFmRlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QKAS7jR/xY5rvOcF/fBAb1e27hmoEhEdYYmQZFKX7uW30IQytrHax5gxKZPpYQymKOO682OAII1z/qNM4a7kKylu5cfy6pQ4jb7H5rXYUrYB7LLahNmeOFk+o/vzZXzH5h82vI2ej5Ve1pbATHaQj8Fj6lhbqco4X/IHDQH/FCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BokOnU7l; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745366068; x=1745970868; i=quwenruo.btrfs@gmx.com;
	bh=0AhgTFih5icrU63ljzD1ANsyGCdshkxjplVYF2Gu4z0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BokOnU7lOVBNOlbHD1TDxCb1ewTfliYASMRP2wQ2ExTU/BhcM23cc4FzdAoJbymZ
	 A5U3qJjuiSYv/mNdlFApU8Pd3pvxWm6sKPsnO305mkAas2bfqebUMPClWVSIUPe8c
	 WMNb/DUcShHA7pcalRPNkrgNtBZzAkMuIsPLxGNepY4Blm2RjpB51XvG08JLzYXCc
	 Bx9IK5RC7MAkbYB3O3QqsbKtu3qTJwVaQbEnjGQ0cGBGbhYDtIFDwFmeuJCkY0xCk
	 82epdtwv/px1fU5x5enk1KIfYBYdsnXr7FosAyWZJQOduHBYxDPYW+qFqBjPFCqOQ
	 63NpFyXvdKA2t+16tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpSb-1ujCIc0dKb-00fZsc; Wed, 23
 Apr 2025 01:54:28 +0200
Message-ID: <4b2d059f-d97a-412c-9ccb-b1c2332429f6@gmx.com>
Date: Wed, 23 Apr 2025 09:24:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use list_first_entry() everywhere
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20250422162151.390526-1-dsterba@suse.com>
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
In-Reply-To: <20250422162151.390526-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fb9B5dUkZsJs4htiJHD7rh0PAqwbYxXo379wavbFZgV3R+Y5H5p
 j/N2ap2/xILkNMgqLPsASW3DOZAu+hj8hw1KlAAXyb0fEgPh+JLUoC9mKB/JZBaKrfVRqUU
 55WsvXTLCtT2y9pwfJhZTAoEFE8IVdzYjp6Xdl+KWxDIxpMa0eeEOrWPdNHwY8lGtpOKiIB
 p7jQVYkQJyb4rvJi+gnUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ptZftsoBVE8=;+otYK/ny6iN9FMjYWvVHFuHEqg6
 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
 9Dz4IeppiGA/w43XdwOZ9w=



=E5=9C=A8 2025/4/23 01:51, David Sterba =E5=86=99=E9=81=93:
> Using the helper makes it a bit more clear that we're accessing the
> first list entry.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/async-thread.c     |  3 +--
>   fs/btrfs/backref.c          |  8 ++++----
>   fs/btrfs/block-group.c      |  9 ++++-----
>   fs/btrfs/disk-io.c          |  4 ++--
>   fs/btrfs/extent-io-tree.c   |  2 +-
>   fs/btrfs/free-space-cache.c | 10 ++++------
>   fs/btrfs/inode.c            |  6 +++---
>   fs/btrfs/raid56.c           |  9 ++++-----
>   fs/btrfs/relocation.c       | 36 +++++++++++++++++-------------------
>   fs/btrfs/send.c             |  5 ++---
>   fs/btrfs/tree-log.c         | 14 +++++++-------
>   fs/btrfs/volumes.c          |  8 ++++----
>   12 files changed, 53 insertions(+), 61 deletions(-)
>=20
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index f3bffe08b290aa..6c6f3bb58f4ead 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -219,8 +219,7 @@ static void run_ordered_work(struct btrfs_workqueue =
*wq,
>   		spin_lock_irqsave(lock, flags);
>   		if (list_empty(list))
>   			break;
> -		work =3D list_entry(list->next, struct btrfs_work,
> -				  ordered_list);
> +		work =3D list_first_entry(list, struct btrfs_work, ordered_list);
>   		if (!test_bit(WORK_DONE_BIT, &work->flags))
>   			break;
>   		/*
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 5936cff80ff3d3..b1c39455e92716 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -3134,8 +3134,8 @@ void btrfs_backref_cleanup_node(struct btrfs_backr=
ef_cache *cache,
>   		return;
>  =20
>   	while (!list_empty(&node->upper)) {
> -		edge =3D list_entry(node->upper.next, struct btrfs_backref_edge,
> -				  list[LOWER]);
> +		edge =3D list_first_entry(&node->upper, struct btrfs_backref_edge,
> +					list[LOWER]);
>   		list_del(&edge->list[LOWER]);
>   		list_del(&edge->list[UPPER]);
>   		btrfs_backref_free_edge(cache, edge);
> @@ -3473,8 +3473,8 @@ int btrfs_backref_add_tree_node(struct btrfs_trans=
_handle *trans,
>   		 * type BTRFS_TREE_BLOCK_REF_KEY
>   		 */
>   		ASSERT(list_is_singular(&cur->upper));
> -		edge =3D list_entry(cur->upper.next, struct btrfs_backref_edge,
> -				  list[LOWER]);
> +		edge =3D list_first_entry(&cur->upper, struct btrfs_backref_edge,
> +					list[LOWER]);
>   		ASSERT(list_empty(&edge->list[UPPER]));
>   		exist =3D edge->node[UPPER];
>   		/*
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 91807d29436699..1a37066afccff2 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4425,8 +4425,8 @@ int btrfs_free_block_groups(struct btrfs_fs_info *=
info)
>  =20
>   	write_lock(&info->block_group_cache_lock);
>   	while (!list_empty(&info->caching_block_groups)) {
> -		caching_ctl =3D list_entry(info->caching_block_groups.next,
> -					 struct btrfs_caching_control, list);
> +		caching_ctl =3D list_first_entry(&info->caching_block_groups,
> +					       struct btrfs_caching_control, list);
>   		list_del(&caching_ctl->list);
>   		btrfs_put_caching_control(caching_ctl);
>   	}
> @@ -4497,9 +4497,8 @@ int btrfs_free_block_groups(struct btrfs_fs_info *=
info)
>   	btrfs_release_global_block_rsv(info);
>  =20
>   	while (!list_empty(&info->space_info)) {
> -		space_info =3D list_entry(info->space_info.next,
> -					struct btrfs_space_info,
> -					list);
> +		space_info =3D list_first_entry(&info->space_info,
> +					      struct btrfs_space_info, list);
>  =20
>   		/*
>   		 * Do not hide this behind enospc_debug, this is actually
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 280bc0ee60465f..8252d41ba242dc 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1857,8 +1857,8 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_=
info)
>   	int i;
>  =20
>   	while (!list_empty(&fs_info->dead_roots)) {
> -		gang[0] =3D list_entry(fs_info->dead_roots.next,
> -				     struct btrfs_root, root_list);
> +		gang[0] =3D list_first_entry(&fs_info->dead_roots,
> +					   struct btrfs_root, root_list);
>   		list_del(&gang[0]->root_list);
>  =20
>   		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index cae3980f4291c0..9f4f5829c55ca6 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -42,7 +42,7 @@ static inline void btrfs_extent_state_leak_debug_check=
(void)
>   	struct extent_state *state;
>  =20
>   	while (!list_empty(&states)) {
> -		state =3D list_entry(states.next, struct extent_state, leak_list);
> +		state =3D list_first_entry(&states, struct extent_state, leak_list);
>   		pr_err("BTRFS: state leak: start %llu end %llu state %u in tree %d r=
efs %d\n",
>   		       state->start, state->end, state->state,
>   		       extent_state_in_tree(state),
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 3c4dbe160f13d4..b9ec7de990c91c 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -1071,9 +1071,8 @@ int write_cache_extent_entries(struct btrfs_io_ctl=
 *io_ctl,
>  =20
>   	/* Get the cluster for this block_group if it exists */
>   	if (block_group && !list_empty(&block_group->cluster_list)) {
> -		cluster =3D list_entry(block_group->cluster_list.next,
> -				     struct btrfs_free_cluster,
> -				     block_group_list);
> +		cluster =3D list_first_entry(&block_group->cluster_list,
> +					   struct btrfs_free_cluster, block_group_list);
>   	}
>  =20
>   	if (!node && cluster) {
> @@ -2333,9 +2332,8 @@ static int insert_into_bitmap(struct btrfs_free_sp=
ace_ctl *ctl,
>   		struct rb_node *node;
>   		struct btrfs_free_space *entry;
>  =20
> -		cluster =3D list_entry(block_group->cluster_list.next,
> -				     struct btrfs_free_cluster,
> -				     block_group_list);
> +		cluster =3D list_first_entry(&block_group->cluster_list,
> +					   struct btrfs_free_cluster, block_group_list);
>   		spin_lock(&cluster->lock);
>   		node =3D rb_first(&cluster->root);
>   		if (!node) {
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 652db811e5cabd..1f54f1954715f9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1563,8 +1563,8 @@ static noinline void submit_compressed_extents(str=
uct btrfs_work *work, bool do_
>   		PAGE_SHIFT;
>  =20
>   	while (!list_empty(&async_chunk->extents)) {
> -		async_extent =3D list_entry(async_chunk->extents.next,
> -					  struct async_extent, list);
> +		async_extent =3D list_first_entry(&async_chunk->extents,
> +						struct async_extent, list);
>   		list_del(&async_extent->list);
>   		submit_one_async_extent(async_chunk, async_extent, &alloc_hint);
>   	}
> @@ -8518,7 +8518,7 @@ static int start_delalloc_inodes(struct btrfs_root=
 *root,
>   		struct btrfs_inode *inode;
>   		struct inode *tmp_inode;
>  =20
> -		inode =3D list_entry(splice.next, struct btrfs_inode, delalloc_inodes=
);
> +		inode =3D list_first_entry(&splice, struct btrfs_inode, delalloc_inod=
es);
>  =20
>   		list_move_tail(&inode->delalloc_inodes, &root->delalloc_inodes);
>  =20
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 4657517f5480b7..90b3ebf3b443ad 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -519,9 +519,8 @@ static void btrfs_clear_rbio_cache(struct btrfs_fs_i=
nfo *info)
>  =20
>   	spin_lock(&table->cache_lock);
>   	while (!list_empty(&table->stripe_cache)) {
> -		rbio =3D list_entry(table->stripe_cache.next,
> -				  struct btrfs_raid_bio,
> -				  stripe_cache);
> +		rbio =3D list_first_entry(&table->stripe_cache,
> +					struct btrfs_raid_bio, stripe_cache);
>   		__remove_rbio_from_cache(rbio);
>   	}
>   	spin_unlock(&table->cache_lock);
> @@ -1702,8 +1701,8 @@ static void raid_unplug(struct blk_plug_cb *cb, bo=
ol from_schedule)
>   	list_sort(NULL, &plug->rbio_list, plug_cmp);
>  =20
>   	while (!list_empty(&plug->rbio_list)) {
> -		cur =3D list_entry(plug->rbio_list.next,
> -				 struct btrfs_raid_bio, plug_list);
> +		cur =3D list_first_entry(&plug->rbio_list,
> +				       struct btrfs_raid_bio, plug_list);
>   		list_del_init(&cur->plug_list);
>  =20
>   		if (rbio_is_full(cur)) {
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 19acdd9ede7964..45570a242c6685 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -196,8 +196,8 @@ static struct btrfs_backref_node *walk_up_backref(
>   	int idx =3D *index;
>  =20
>   	while (!list_empty(&node->upper)) {
> -		edge =3D list_entry(node->upper.next,
> -				  struct btrfs_backref_edge, list[LOWER]);
> +		edge =3D list_first_entry(&node->upper, struct btrfs_backref_edge,
> +					list[LOWER]);
>   		edges[idx++] =3D edge;
>   		node =3D edge->node[UPPER];
>   	}
> @@ -223,8 +223,8 @@ static struct btrfs_backref_node *walk_down_backref(
>   			idx--;
>   			continue;
>   		}
> -		edge =3D list_entry(edge->list[LOWER].next,
> -				  struct btrfs_backref_edge, list[LOWER]);
> +		edge =3D list_first_entry(&edge->list[LOWER], struct btrfs_backref_ed=
ge,
> +					list[LOWER]);
>   		edges[idx - 1] =3D edge;
>   		*index =3D idx;
>   		return edge->node[UPPER];
> @@ -348,8 +348,8 @@ static bool handle_useless_nodes(struct reloc_contro=
l *rc,
>   			struct btrfs_backref_edge *edge;
>   			struct btrfs_backref_node *lower;
>  =20
> -			edge =3D list_entry(cur->lower.next,
> -					struct btrfs_backref_edge, list[UPPER]);
> +			edge =3D list_first_entry(&cur->lower, struct btrfs_backref_edge,
> +						list[UPPER]);
>   			list_del(&edge->list[UPPER]);
>   			list_del(&edge->list[LOWER]);
>   			lower =3D edge->node[LOWER];
> @@ -1698,8 +1698,8 @@ int prepare_to_merge(struct reloc_control *rc, int=
 err)
>   	rc->merge_reloc_tree =3D true;
>  =20
>   	while (!list_empty(&rc->reloc_roots)) {
> -		reloc_root =3D list_entry(rc->reloc_roots.next,
> -					struct btrfs_root, root_list);
> +		reloc_root =3D list_first_entry(&rc->reloc_roots,
> +					      struct btrfs_root, root_list);
>   		list_del_init(&reloc_root->root_list);
>  =20
>   		root =3D btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
> @@ -1814,8 +1814,7 @@ void merge_reloc_roots(struct reloc_control *rc)
>  =20
>   	while (!list_empty(&reloc_roots)) {
>   		found =3D 1;
> -		reloc_root =3D list_entry(reloc_roots.next,
> -					struct btrfs_root, root_list);
> +		reloc_root =3D list_first_entry(&reloc_roots, struct btrfs_root, root=
_list);
>  =20
>   		root =3D btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
>   					 false);
> @@ -2110,8 +2109,8 @@ static noinline_for_stack u64 calcu_metadata_size(=
struct reloc_control *rc,
>   			if (list_empty(&next->upper))
>   				break;
>  =20
> -			edge =3D list_entry(next->upper.next,
> -					struct btrfs_backref_edge, list[LOWER]);
> +			edge =3D list_first_entry(&next->upper, struct btrfs_backref_edge,
> +						list[LOWER]);
>   			edges[index++] =3D edge;
>   			next =3D edge->node[UPPER];
>   		}
> @@ -2357,8 +2356,8 @@ static int finish_pending_nodes(struct btrfs_trans=
_handle *trans,
>  =20
>   	for (level =3D 0; level < BTRFS_MAX_LEVEL; level++) {
>   		while (!list_empty(&cache->pending[level])) {
> -			node =3D list_entry(cache->pending[level].next,
> -					  struct btrfs_backref_node, list);
> +			node =3D list_first_entry(&cache->pending[level],
> +						struct btrfs_backref_node, list);
>   			list_move_tail(&node->list, &list);
>   			BUG_ON(!node->pending);
>  =20
> @@ -2396,8 +2395,8 @@ static void update_processed_blocks(struct reloc_c=
ontrol *rc,
>   			if (list_empty(&next->upper))
>   				break;
>  =20
> -			edge =3D list_entry(next->upper.next,
> -					struct btrfs_backref_edge, list[LOWER]);
> +			edge =3D list_first_entry(&next->upper, struct btrfs_backref_edge,
> +						list[LOWER]);
>   			edges[index++] =3D edge;
>   			next =3D edge->node[UPPER];
>   		}
> @@ -4183,8 +4182,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info =
*fs_info)
>   	rc->merge_reloc_tree =3D true;
>  =20
>   	while (!list_empty(&reloc_roots)) {
> -		reloc_root =3D list_entry(reloc_roots.next,
> -					struct btrfs_root, root_list);
> +		reloc_root =3D list_first_entry(&reloc_roots, struct btrfs_root, root=
_list);
>   		list_del(&reloc_root->root_list);
>  =20
>   		if (btrfs_root_refs(&reloc_root->root_item) =3D=3D 0) {
> @@ -4277,7 +4275,7 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_e=
xtent *ordered)
>  =20
>   	while (!list_empty(&list)) {
>   		struct btrfs_ordered_sum *sums =3D
> -			list_entry(list.next, struct btrfs_ordered_sum, list);
> +			list_first_entry(&list, struct btrfs_ordered_sum, list);
>  =20
>   		list_del_init(&sums->list);
>  =20
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index f0e49a813ccbbf..96a7ef9a4451bb 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -3098,7 +3098,7 @@ static void __free_recorded_refs(struct list_head =
*head)
>   	struct recorded_ref *cur;
>  =20
>   	while (!list_empty(head)) {
> -		cur =3D list_entry(head->next, struct recorded_ref, list);
> +		cur =3D list_first_entry(head, struct recorded_ref, list);
>   		recorded_ref_free(cur);
>   	}
>   }
> @@ -4560,8 +4560,7 @@ static int process_recorded_refs(struct send_ctx *=
sctx, int *pending_move)
>   		/*
>   		 * We have a moved dir. Add the old parent to check_dirs
>   		 */
> -		cur =3D list_entry(sctx->deleted_refs.next, struct recorded_ref,
> -				list);
> +		cur =3D list_first_entry(&sctx->deleted_refs, struct recorded_ref, li=
st);
>   		ret =3D dup_ref(cur, &check_dirs);
>   		if (ret < 0)
>   			goto out;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 411dad8860a8f8..97e933113b822f 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -860,9 +860,9 @@ static noinline int replay_one_extent(struct btrfs_t=
rans_handle *trans,
>   				struct btrfs_ordered_sum *sums;
>   				struct btrfs_root *csum_root;
>  =20
> -				sums =3D list_entry(ordered_sums.next,
> -						struct btrfs_ordered_sum,
> -						list);
> +				sums =3D list_first_entry(&ordered_sums,
> +							struct btrfs_ordered_sum,
> +							list);
>   				csum_root =3D btrfs_csum_root(fs_info,
>   							    sums->logical);
>   				if (!ret)
> @@ -4667,9 +4667,9 @@ static int log_extent_csums(struct btrfs_trans_han=
dle *trans,
>   	ret =3D 0;
>  =20
>   	while (!list_empty(&ordered_sums)) {
> -		struct btrfs_ordered_sum *sums =3D list_entry(ordered_sums.next,
> -						   struct btrfs_ordered_sum,
> -						   list);
> +		struct btrfs_ordered_sum *sums =3D list_first_entry(&ordered_sums,
> +								  struct btrfs_ordered_sum,
> +								  list);
>   		if (!ret)
>   			ret =3D log_csums(trans, inode, log_root, sums);
>   		list_del(&sums->list);
> @@ -4947,7 +4947,7 @@ static int btrfs_log_changed_extents(struct btrfs_=
trans_handle *trans,
>   	list_sort(NULL, &extents, extent_cmp);
>   process:
>   	while (!list_empty(&extents)) {
> -		em =3D list_entry(extents.next, struct extent_map, list);
> +		em =3D list_first_entry(&extents, struct extent_map, list);
>  =20
>   		list_del_init(&em->list);
>  =20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4d5c59083003ff..37083708d93cb1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -415,8 +415,8 @@ static void free_fs_devices(struct btrfs_fs_devices =
*fs_devices)
>  =20
>   	WARN_ON(fs_devices->opened);
>   	while (!list_empty(&fs_devices->devices)) {
> -		device =3D list_entry(fs_devices->devices.next,
> -				    struct btrfs_device, dev_list);
> +		device =3D list_first_entry(&fs_devices->devices,
> +					  struct btrfs_device, dev_list);
>   		list_del(&device->dev_list);
>   		btrfs_free_device(device);
>   	}
> @@ -428,8 +428,8 @@ void __exit btrfs_cleanup_fs_uuids(void)
>   	struct btrfs_fs_devices *fs_devices;
>  =20
>   	while (!list_empty(&fs_uuids)) {
> -		fs_devices =3D list_entry(fs_uuids.next,
> -					struct btrfs_fs_devices, fs_list);
> +		fs_devices =3D list_first_entry(&fs_uuids, struct btrfs_fs_devices,
> +					      fs_list);
>   		list_del(&fs_devices->fs_list);
>   		free_fs_devices(fs_devices);
>   	}


