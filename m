Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE7D79FFD8
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjINJSr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 05:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjINJSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 05:18:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE71A2;
        Thu, 14 Sep 2023 02:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1694683106; x=1695287906; i=quwenruo.btrfs@gmx.com;
 bh=icd+33yelo7OZxJ/7LKd1iDZiUEAA+tSnBqZO/KJO0c=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jsmmTefiAOG8ktBBTrG0warBXse0OxJcqNV8CVJtTC3YGQMqlo2ARIf2/ZLL5ttZBXYfeoYQWUr
 SuL9C7niGTJ17PMX1+ULvBP/ieZjmxjxRrhRJtPVkBPlvS3OlQFHsFQ639IxgxLnICxyubuF758d+
 B8bt4FIUOmaI1WegFDMyVPcxop6QAQByaetz3M+kVWrEfNvDvI7K/zXStLoNbHBbRS69nh5s9LqYE
 qjJAZiMBuQVHkS7vpl9oiKyVGXv4qL7Z9eYPsZp7X/z0+5G8FTPK67Gvxw9SRYUpWry2u4wuzh7w8
 hs3G/y71cE4ExcMWgMxGsrd0IpjtMTv0z9cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mz9Un-1rbReE19ud-00wAxO; Thu, 14
 Sep 2023 11:18:26 +0200
Message-ID: <6de87230-f981-411c-b173-55871e4d4720@gmx.com>
Date:   Thu, 14 Sep 2023 18:48:17 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/11] btrfs: lookup physical address from stripe
 extent
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-5-647676fa852c@wdc.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <20230911-raid-stripe-tree-v8-5-647676fa852c@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vt7kKFltGHNY4MRwnW+IRzo1H8knQDTof93ZAV2YaUwrIbb/ZZw
 RofkHGvYzL/hQNSHaVLrMyugEhmleWNANas/2hZUBI3HRj2+NNmAB3C5A/bnp838daS9pjR
 bbtuEc6Xx3EVq/muzwTQoGrSHPMKuKXZujK2NAoCCDrIPgQAbdKZJwRxwzZwVlw3hk4dDr1
 3lYeiiT7IoiYvs+mf6EhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ixJaVKpWiHA=;Q7fZTJc6o2RBurdHkOvIisHluYs
 Na+tRVHuQnnReya3KRcaEgVPOdKrxp8Ul2UFC79B3/QNg5BdYXNWaiVluRXz1X0BnsYyTYMKE
 LifpA+tA5jq13XFySAt27sTyH8oikYEzRzdzrRjYjsAv17MJq3G8YHL0is+ee0VQvVW088RJZ
 G106sodDwiaS7cybL9AFqBRujbZdhw0VX5/4Mzok8awZEVcZxH2laUZvJd41qPR7wCsTSMvLo
 k0ka3LSV7Wkry9zu8lMrQH/LEN66xSV65W0uaEA7Qh1CA9utNLqimdruje5qHUzb9tVEFoKpC
 LXOeMh9VQwcEi7afvAhetjzIME166sXQK+zkBlHnaGMzKNlRdJvWAo9/mPTXVLJFoOMvUz+rU
 2ij/DKnmhfKtmHTCOkwkr5SU+a1nNfCU+wKcISYn04xScYFhu0osEH0mDR1+E/TTD4mwvXvpl
 U9YpDx6VXv9UtgfOAD5zIZFjT/xZcIrhxJ2PhpBDuR8FHFVq1Nx8OPoOqRHd9mP2RQD1YHJmN
 v0J4bickCnlHI6WjzqdDJ03EIZ0rn15dKSuxue/hUxqdHD2MTIyIfsZjjrebReyxt0ysvzwH0
 oB80MRgnyed967HJDY12nTdTnhBpveojHLwRM7mIieVzL+TQFLNYQuILoDo1dE8ZCRyF7du2D
 nNMfH/SSZ62WzuOKiHFYVff8PRcIz/j/8Pty6xE6YXw+PRlCcz+8+3pAVo1UtlxQ2Z2iCrMKN
 R0cRDVQwc5Z5x8zR94Zl3QptGVnGlbQ+YEr5TTa4Wj4ikBRy6Z30AyYuVvfSRCz5A0P+rGKo5
 wh9SFEcl/2agg6/RI6i/jMwPNsHMJpEYG/dmaHCs9coIjftKUPqYHAvWSAcRTKLbvvJUShI7M
 Gut8St80uUes4rxmmBkVFJFBHfNLbPS6uKXHj0OdM5JS/N8lZHp5BkQn/VlfAPkOm69uS17pA
 Uns4nSEBHqZ3mp6buEhDmQ9gYkg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/11 22:22, Johannes Thumshirn wrote:
> Lookup the physical address from the raid stripe tree when a read on an
> RAID volume formatted with the raid stripe tree was attempted.
>
> If the requested logical address was not found in the stripe tree, it ma=
y
> still be in the in-memory ordered stripe tree, so fallback to searching
> the ordered stripe tree in this case.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/raid-stripe-tree.c | 159 ++++++++++++++++++++++++++++++++++++=
++++++++
>   fs/btrfs/raid-stripe-tree.h |  11 +++
>   fs/btrfs/volumes.c          |  37 ++++++++---
>   3 files changed, 198 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 5b12f40877b5..7ed02e4b79ec 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -324,3 +324,162 @@ int btrfs_insert_raid_extent(struct btrfs_trans_ha=
ndle *trans,
>
>   	return ret;
>   }
> +
> +static bool btrfs_check_for_extent(struct btrfs_fs_info *fs_info, u64 l=
ogical,
> +				   u64 length, struct btrfs_path *path)
> +{
> +	struct btrfs_root *extent_root =3D btrfs_extent_root(fs_info, logical)=
;
> +	struct btrfs_key key;
> +	int ret;
> +
> +	btrfs_release_path(path);
> +
> +	key.objectid =3D logical;
> +	key.type =3D BTRFS_EXTENT_ITEM_KEY;
> +	key.offset =3D length;
> +
> +	ret =3D btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
> +
> +	return ret;
> +}
> +
> +int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
> +				 u64 logical, u64 *length, u64 map_type,
> +				 u32 stripe_index,
> +				 struct btrfs_io_stripe *stripe)
> +{
> +	struct btrfs_root *stripe_root =3D btrfs_stripe_tree_root(fs_info);
> +	struct btrfs_stripe_extent *stripe_extent;
> +	struct btrfs_key stripe_key;
> +	struct btrfs_key found_key;
> +	struct btrfs_path *path;
> +	struct extent_buffer *leaf;
> +	int num_stripes;
> +	u8 encoding;
> +	u64 offset;
> +	u64 found_logical;
> +	u64 found_length;
> +	u64 end;
> +	u64 found_end;
> +	int slot;
> +	int ret;
> +	int i;
> +
> +	stripe_key.objectid =3D logical;
> +	stripe_key.type =3D BTRFS_RAID_STRIPE_KEY;
> +	stripe_key.offset =3D 0;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret =3D btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
> +	if (ret < 0)
> +		goto free_path;
> +	if (ret) {
> +		if (path->slots[0] !=3D 0)
> +			path->slots[0]--;

IIRC we have btrfs_previous_item() to do the forward search.

> +	}
> +
> +	end =3D logical + *length;

IMHO we can make it const and initialize it at the definition part.

> +
> +	while (1) {

Here we only can hit at most one RST item, thus I'd recommend to remove
the while().

Although this would mean we will need a if () to handle (ret > 0) case,
but it may still be a little easier to read than a loop.

You may want to refer to btrfs_lookup_csum() for the non-loop
implementation.

> +		leaf =3D path->nodes[0];
> +		slot =3D path->slots[0];
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, slot);
> +		found_logical =3D found_key.objectid;
> +		found_length =3D found_key.offset;
> +		found_end =3D found_logical + found_length;
> +
> +		if (found_logical > end) {
> +			ret =3D -ENOENT;
> +			goto out;
> +		}
> +
> +		if (in_range(logical, found_logical, found_length))
> +			break;
> +
> +		ret =3D btrfs_next_item(stripe_root, path);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	offset =3D logical - found_logical;
> +
> +	/*
> +	 * If we have a logically contiguous, but physically noncontinuous
> +	 * range, we need to split the bio. Record the length after which we
> +	 * must split the bio.
> +	 */
> +	if (end > found_end)
> +		*length -=3D end - found_end;
> +
> +	num_stripes =3D btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
> +	stripe_extent =3D btrfs_item_ptr(leaf, slot, struct btrfs_stripe_exten=
t);
> +	encoding =3D btrfs_stripe_extent_encoding(leaf, stripe_extent);
> +
> +	if (encoding !=3D btrfs_bg_type_to_raid_encoding(map_type)) {
> +		ret =3D -ENOENT;
> +		goto out;

This looks like a very weird situation, we have a bg with a different type=
.
Should we do some warning or is there some valid situation for this?

> +	}
> +
> +	for (i =3D 0; i < num_stripes; i++) {
> +		struct btrfs_raid_stride *stride =3D &stripe_extent->strides[i];
> +		u64 devid =3D btrfs_raid_stride_devid(leaf, stride);
> +		u64 len =3D btrfs_raid_stride_length(leaf, stride);
> +		u64 physical =3D btrfs_raid_stride_physical(leaf, stride);
> +
> +		if (offset >=3D len) {
> +			offset -=3D len;
> +
> +			if (offset >=3D BTRFS_STRIPE_LEN)
> +				continue;
> +		}
> +
> +		if (devid !=3D stripe->dev->devid)
> +			continue;
> +
> +		if ((map_type & BTRFS_BLOCK_GROUP_DUP) && stripe_index !=3D i)
> +			continue;
> +
> +		stripe->physical =3D physical + offset;
> +
> +		ret =3D 0;
> +		goto free_path;
> +	}
> +
> +	/*
> +	 * If we're here, we haven't found the requested devid in the stripe.
> +	 */
> +	ret =3D -ENOENT;
> +out:
> +	if (ret > 0)
> +		ret =3D -ENOENT;
> +	if (ret && ret !=3D -EIO) {
> +		/*
> +		 * Check if the range we're looking for is actually backed by
> +		 * an extent. This can happen, e.g. when scrub is running on a
> +		 * block-group and the extent it is trying to scrub get's
> +		 * deleted in the meantime. Although scrub is setting the
> +		 * block-group to read-only, deletion of extents are still
> +		 * allowed. If the extent is gone, simply return ENOENT and be
> +		 * good.
> +		 */

As mentioned in the next patch (sorry for the reversed order), this
should be handled in a different way (by only searching commit root for
scrub usage).
> +		if (btrfs_check_for_extent(fs_info, logical, *length, path)) {
> +			ret =3D -ENOENT;
> +			goto free_path;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
> +			btrfs_print_tree(leaf, 1);
> +		btrfs_err(fs_info,
> +			  "cannot find raid-stripe for logical [%llu, %llu] devid %llu, prof=
ile %s",
> +			  logical, logical + *length, stripe->dev->devid,
> +			  btrfs_bg_type_to_raid_name(map_type));
> +	}
> +free_path:
> +	btrfs_free_path(path);
> +
> +	return ret;
> +}
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> index 7560dc501a65..40aa553ae8aa 100644
> --- a/fs/btrfs/raid-stripe-tree.h
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -13,6 +13,10 @@ struct btrfs_io_stripe;
>
>   int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 sta=
rt,
>   			     u64 length);
> +int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
> +				 u64 logical, u64 *length, u64 map_type,
> +				 u32 stripe_index,
> +				 struct btrfs_io_stripe *stripe);
>   int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
>   			     struct btrfs_ordered_extent *ordered_extent);
>
> @@ -33,4 +37,11 @@ static inline bool btrfs_need_stripe_tree_update(stru=
ct btrfs_fs_info *fs_info,
>
>   	return false;
>   }
> +
> +static inline int btrfs_num_raid_stripes(u32 item_size)
> +{
> +	return (item_size - offsetof(struct btrfs_stripe_extent, strides)) /
> +		sizeof(struct btrfs_raid_stride);
> +}
> +
>   #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0c0fd4eb4848..7c25f5c77788 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -35,6 +35,7 @@
>   #include "relocation.h"
>   #include "scrub.h"
>   #include "super.h"
> +#include "raid-stripe-tree.h"
>
>   #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
>   					 BTRFS_BLOCK_GROUP_RAID10 | \
> @@ -6206,12 +6207,22 @@ static u64 btrfs_max_io_len(struct map_lookup *m=
ap, enum btrfs_map_op op,
>   	return U64_MAX;
>   }
>
> -static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map=
_lookup *map,
> -			  u32 stripe_index, u64 stripe_offset, u32 stripe_nr)
> +static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_=
op op,
> +		      u64 logical, u64 *length, struct btrfs_io_stripe *dst,
> +		      struct map_lookup *map, u32 stripe_index,
> +		      u64 stripe_offset, u64 stripe_nr)
Do we need @length to be a pointer?
IIRC we can return the number of bytes we mapped, or <0 for errors.
Thus at least @length doesn't need to be a pointer.

Thanks,
Qu

>   {
>   	dst->dev =3D map->stripes[stripe_index].dev;
> +
> +	if (op =3D=3D BTRFS_MAP_READ &&
> +	    btrfs_need_stripe_tree_update(fs_info, map->type))
> +		return btrfs_get_raid_extent_offset(fs_info, logical, length,
> +						    map->type, stripe_index,
> +						    dst);
> +
>   	dst->physical =3D map->stripes[stripe_index].physical +
>   			stripe_offset + btrfs_stripe_nr_to_offset(stripe_nr);
> +	return 0;
>   }
>
>   /*
> @@ -6428,11 +6439,11 @@ int btrfs_map_block(struct btrfs_fs_info *fs_inf=
o, enum btrfs_map_op op,
>   	 */
>   	if (smap && num_alloc_stripes =3D=3D 1 &&
>   	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1))=
 {
> -		set_io_stripe(smap, map, stripe_index, stripe_offset, stripe_nr);
> +		ret =3D set_io_stripe(fs_info, op, logical, length, smap, map,
> +				    stripe_index, stripe_offset, stripe_nr);
>   		if (mirror_num_ret)
>   			*mirror_num_ret =3D mirror_num;
>   		*bioc_ret =3D NULL;
> -		ret =3D 0;
>   		goto out;
>   	}
>
> @@ -6463,21 +6474,29 @@ int btrfs_map_block(struct btrfs_fs_info *fs_inf=
o, enum btrfs_map_op op,
>   		bioc->full_stripe_logical =3D em->start +
>   			btrfs_stripe_nr_to_offset(stripe_nr * data_stripes);
>   		for (i =3D 0; i < num_stripes; i++)
> -			set_io_stripe(&bioc->stripes[i], map,
> -				      (i + stripe_nr) % num_stripes,
> -				      stripe_offset, stripe_nr);
> +			ret =3D set_io_stripe(fs_info, op, logical, length,
> +					    &bioc->stripes[i], map,
> +					    (i + stripe_nr) % num_stripes,
> +					    stripe_offset, stripe_nr);
>   	} else {
>   		/*
>   		 * For all other non-RAID56 profiles, just copy the target
>   		 * stripe into the bioc.
>   		 */
>   		for (i =3D 0; i < num_stripes; i++) {
> -			set_io_stripe(&bioc->stripes[i], map, stripe_index,
> -				      stripe_offset, stripe_nr);
> +			ret =3D set_io_stripe(fs_info, op, logical, length,
> +					    &bioc->stripes[i], map, stripe_index,
> +					    stripe_offset, stripe_nr);
>   			stripe_index++;
>   		}
>   	}
>
> +	if (ret) {
> +		*bioc_ret =3D NULL;
> +		btrfs_put_bioc(bioc);
> +		goto out;
> +	}
> +
>   	if (op !=3D BTRFS_MAP_READ)
>   		max_errors =3D btrfs_chunk_max_errors(map);
>
>
