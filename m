Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9566378D37
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfG2Nxm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 09:53:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:56929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfG2Nxm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 09:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564408396;
        bh=nSstwPE4kx/tS9p+lu6M8xJiiCbsuUxHfo15KJPY6mY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Rk1x+9/i2Y/TngmLA3dBdARfmZzmhUMclyijp/zisByGg8W7BufZcsK6havp4OLQA
         byFXZXQNQ9KiiEHEJM364V4bpaFUmff8mmPc5TGmI++pIe4fVau87XxyzZo66IzKxk
         TJgzWNeyS10nYW6wVdi9XPw4YMBr7gLNjr/0mQ+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LwaMR-1iRrCn2wk3-018Gq4; Mon, 29
 Jul 2019 15:53:16 +0200
Subject: Re: [PATCH 1/3] btrfs: tree-checker: Add EXTENT_ITEM and
 METADATA_ITEM check
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190729074337.10573-1-wqu@suse.com>
 <20190729074337.10573-2-wqu@suse.com>
 <bd6c75f8-c9b5-c29f-a691-101fee33cef5@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <66256780-4fa9-9627-151e-62e834a6cc39@gmx.com>
Date:   Mon, 29 Jul 2019 21:53:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bd6c75f8-c9b5-c29f-a691-101fee33cef5@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3SJdsUe89deLQa5fQvsMBLg+CiNEpzq5Q2L7T3ORutKCvB8bmYy
 958QUfxMIomstdZSYfr76FqX/GvKjL4lWAn9L+IOv5mbbKPPH8vN4fmi5dmS0FbViGDYZHH
 NTuxr5zDbD8Ded3eW75pVZB15h+9QM+Nf72m+TfraIv2nS/NLQJTOu6ZJQm6wCuc0w/1hMp
 sjNmWeWEhDZLmC4nnpdwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OVZXlOYDl0Q=:kJR86M3QJx82KlcDAikkDl
 VRrP0akdGoxE53NV3RIthubVLX8bDkWGhCI/tDUhYpCe7NSWmcLK93e4HFwQgDMQ/E9PbT3zY
 +gKVYqMYXIDhOc05O3gLW68jYwpLg1JJ4O5Eb7BQWx6cYx+A+q0SY9wKSS4pW8FI52g6vQElS
 oft1Gb9x5pIHrBnf5b3nk7yWEpfM7urQ9DUXBTKWyxOoAefP/PzKWttJevSVf+ZTJ/5ftmjsB
 7S9wHwebdGARik+x3J7whf0Z27QQa4SLHNfa+af1lSAvR5eexGf4+yuRYBp6ypOCxuQFqUlJ/
 oI1+44bOW7tUozA7Tc57JMFERf3xfajRPO8xnI14/QSyYJQkq/+Qc9ZjRkPdq0VwaR8dPn5Ft
 rf2z9xndk57eIwkhgLbQl77dSUW+2zrHKVkWnBqwr4lYiTwKNiCRtRAOUOUH8ejLodfbbNQwo
 iRq+YT/kQtJ7Rm/M+55SrODPWNyKltVuH+JUcMvnTfnwH+QyCuts2jRYP4qur8+3UC5o1+BcB
 tEtjWe2NftAguJsa6sI3309BHtaALicYjKsJ4oaoN0wC+DQhS0FGdjZpr4zlFxY340TAy4ftF
 rbUcs2BVj6ySstEsLzNRUsTDq3iSQHm9atx7JaD0kFMufvm4ZaLUk2luyNtuWdxs3zb+Viifj
 eHXZqj8psDtIqIvMWhsyUG5/wSVCd8h1piZWEvJ59fu0vNmeUKC5BFgzGowSOfW461aKW8FQs
 OEOdgH5bZrjLqhmkiCHJLzT9wW3JT8oMf+l10BFwo9/xBF32d8amWtcyNBcuSArGdaAUlaa0L
 znggE1kJMJlfW/UCTn976m+y4JND147CxviOmf6R+IOjPzvjrB+2nWH/iVYlfQQA9eF4/1nek
 3oCCtbk1CVSBydw0frMgy7Dc0Wgx6VQVnJLuyhGCe6cXdVF8/9FDy1fjaQKD87jVlZe5nOpVR
 FZ0KavyNOOSmqcwtwYuBUIY15g8SJP7chc0k/bRpIOuaODb23RDogA+swfQ6WuXBDQ8xdyaJG
 vL659yOVRMPZ69k3PG5AtCWW4Qcbuurouz5qSNNJPhJKpJ4OgR2vAMCpFuRTpfv9EpRTvshwl
 TxbhJT4/C1uuIpPb/st4q2kX5X1OfuB2P0P
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=889:42, Nikolay Borisov wrote:
[...]
>> +
>> +	/* key->offset is tree level for METADATA_ITEM_KEY */
>> +	if (key->type =3D=3D BTRFS_METADATA_ITEM_KEY) {
>> +		if (key->offset >=3D BTRFS_MAX_LEVEL) {
>
> make it a compound statement:
>
> if key->type && key->offset. The extra if doesn't bring anything...

Right, that's the case.
I though there would be more checks, but turns out there is only one check=
.

>
>> +			extent_err(leaf, slot,
>> +				"invalid tree level, have %llu expect [0, %u]",
>> +				   key->offset, BTRFS_MAX_LEVEL - 1);
>> +			return -EUCLEAN;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * EXTENT/METADATA_ITEM is consistent of:
>> +	 * 1) One btrfs_extent_item
>> +	 *    Records the total refs, type and generation of the extent.
>> +	 *
>> +	 * 2) One btrfs_tree_block_info (for EXTENT_ITEM and tree backref onl=
y)
>> +	 *    Records the first key and level of the tree block.
>> +	 *
>> +	 * 2) *Zero* or more btrfs_extent_inline_ref(s)
>> +	 *    Each inline ref has one btrfs_extent_inline_ref shows:
>> +	 *    2.1) The ref type, one of the 4
>> +	 *         TREE_BLOCK_REF	Tree block only
>> +	 *         SHARED_BLOCK_REF	Tree block only
>> +	 *         EXTENT_DATA_REF	Data only
>> +	 *         SHARED_DATA_REF	Data only
>> +	 *    2.2) Ref type specific data
>> +	 *         Either using btrfs_extent_inline_ref::offset, or specific
>> +	 *         data structure.
>> +	 */
>> +	if (item_size < sizeof(*ei)) {
>> +		extent_err(leaf, slot,
>> +			   "invalid item size, have %u expect >=3D %lu",
>> +			   item_size, sizeof(*ei));
>> +		return -EUCLEAN;
>> +	}
>> +	end =3D item_size + btrfs_item_ptr_offset(leaf, slot);
>> +
>> +	/* Checks against extent_item */
>> +	ei =3D btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
>> +	flags =3D btrfs_extent_flags(leaf, ei);
>> +	total_refs =3D btrfs_extent_refs(leaf, ei);
>> +	generation =3D btrfs_extent_generation(leaf, ei);
>> +	if (generation > btrfs_super_generation(fs_info->super_copy) + 1) {
>> +		extent_err(leaf, slot,
>> +			"invalid generation, have %llu expect <=3D %llu",
>
> nit: I find the '<=3D [number]' somewhat confusing, wouldn't it be bette=
r
> if it's spelled our e.g 'expecting less than or equal than [number]'.
> Might be just me.

I normally prefer the "[start, end]" notion, but sometimes even myself
can't always keep the format the same.

Furthermore, I can't find a minimal value to use [start, end] notion.
Maybe (0, end] would be more suitable here?

>
>> +			   generation,
>> +			   btrfs_super_generation(fs_info->super_copy) + 1);
>> +		return -EUCLEAN;
>> +	}
>> +	if (!is_power_of_2(flags & (BTRFS_EXTENT_FLAG_DATA |
>> +				    BTRFS_EXTENT_FLAG_TREE_BLOCK))) {
>> +		extent_err(leaf, slot,
>> +		"invalid extent flag, have 0x%llx expect 1 bit set in 0x%llx",
>> +			flags, BTRFS_EXTENT_FLAG_DATA |
>> +			BTRFS_EXTENT_FLAG_TREE_BLOCK);
>> +		return -EUCLEAN;
>> +	}
>> +	is_tree_block =3D !!(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK);
>> +	if (is_tree_block && key->type =3D=3D BTRFS_EXTENT_ITEM_KEY &&
>> +	    key->offset !=3D fs_info->nodesize) {
>> +		extent_err(leaf, slot,
>> +			   "invalid extent length, have %llu expect %u",
>> +			   key->offset, fs_info->nodesize);
>> +		return -EUCLEAN;
>> +	}
>> +	if (!is_tree_block) {
>> +		if (key->type !=3D BTRFS_EXTENT_ITEM_KEY) {
>> +			extent_err(leaf, slot,
>> +		"invalid key type, have %u expect %u for data backref",
>> +				   key->type, BTRFS_EXTENT_ITEM_KEY);
>> +			return -EUCLEAN;
>> +		}
>> +		if (!IS_ALIGNED(key->offset, fs_info->sectorsize)) {
>> +			extent_err(leaf, slot,
>> +			"invalid extent length, have %llu expect aliged to %u",
>> +				   key->offset, fs_info->sectorsize);
>> +			return -EUCLEAN;
>> +		}
>> +	}
>
> unify the two is_tree_block/!is_tree_block either in:
>
> if (is_tree_block) {
> 	if (keypt->type =3D EXTENT_ITEM_KEY && offset !=3D nodesize {
> 		foo;
> 	}
> } else {
> 	bar;
> }
>

Right, that's better.

> or
>
> if (is_tree_block && key->type =3D=3D BTRFS_EXTENT_ITEM_KEY ..) {
>
> } else if (!is_tree_block) {
> bar
> }
>
>> +	ptr =3D (u64)(struct btrfs_extent_item *)(ei + 1);
>> +
>> +	/* Check the special case of btrfs_tree_block_info */
>> +	if (is_tree_block && key->type !=3D BTRFS_METADATA_ITEM_KEY) {
>> +		struct btrfs_tree_block_info *info;
>> +
>> +		info =3D (struct btrfs_tree_block_info *)ptr;
>> +		if (btrfs_tree_block_level(leaf, info) >=3D BTRFS_MAX_LEVEL) {
>> +			extent_err(leaf, slot,
>> +			"invalid tree block info level, have %u expect [0, %u)",
>
> nit: Strictly speaking using [0, 7) is wrong, because ')' already
> implies an open interval. Since we have 8 levels 0/7 inclusive this
> means the correct way to print it would be [0, 7] or [0, 8).

It's not that rare I misuses such notion. [0, 7] would be the case.

>
>
>> +				   btrfs_tree_block_level(leaf, info),
>> +				   BTRFS_MAX_LEVEL - 1);
>> +			return -EUCLEAN;
>> +		}
>> +		ptr =3D (u64)(struct btrfs_tree_block_info *)(info + 1);
>> +	}
>> +
>> +	/* Check inline refs */
>> +	while (ptr < end) {
>> +		struct btrfs_extent_inline_ref *iref;
>> +		struct btrfs_extent_data_ref *dref;
>> +		struct btrfs_shared_data_ref *sref;
>> +		u64 dref_offset;
>> +		u64 inline_offset;
>> +		u8 inline_type;
>> +
>> +		if (ptr + sizeof(*iref) > end) {
>> +			extent_err(leaf, slot,
>> +	"invalid item size, size too small, ptr %llu end %llu",
>> +				   ptr, end);
>> +			goto err;
>> +		}
>> +		iref =3D (struct btrfs_extent_inline_ref *)ptr;
>> +		inline_type =3D btrfs_extent_inline_ref_type(leaf, iref);
>> +		inline_offset =3D btrfs_extent_inline_ref_offset(leaf, iref);
>> +		if (ptr + btrfs_extent_inline_ref_size(inline_type) > end) {
>> +			extent_err(leaf, slot,
>> +	"invalid item size, size too small, ptr %llu end %llu",
>
> Make that text explicit:
>
> "inline ref item overflows extent item" or some such.

OK, I'll use this expression.

Thanks,
Qu

[...]
>> +
>> +	/* Finally, check the inline refs against total refs */
>> +	if (total_refs < inline_refs) {
>
> nit: if (inline_refs > total_refs) {} looks saner to me.
>
>
>
>> +		extent_err(leaf, slot,
>> +			"invalid extent refs, have %llu expect >=3D %llu",
>> +			   total_refs, inline_refs);
>> +		goto err;
>> +	}
>> +	return 0;
>> +err:
>> +	return -EUCLEAN;
>> +}
>> +
>>  /*
>>   * Common point to switch the item-specific validation.
>>   */
>> @@ -937,6 +1182,10 @@ static int check_leaf_item(struct extent_buffer *=
leaf,
>>  	case BTRFS_ROOT_ITEM_KEY:
>>  		ret =3D check_root_item(leaf, key, slot);
>>  		break;
>> +	case BTRFS_EXTENT_ITEM_KEY:
>> +	case BTRFS_METADATA_ITEM_KEY:
>> +		ret =3D check_extent_item(leaf, key, slot);
>> +		break;
>>  	}
>>  	return ret;
>>  }
>>
