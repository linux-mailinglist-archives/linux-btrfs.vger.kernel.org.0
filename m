Return-Path: <linux-btrfs+bounces-8230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFE098690B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBEC2860C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 22:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFDB175D37;
	Wed, 25 Sep 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qdHzMx/J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB514AD24
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301633; cv=none; b=XMd1OqOeCAFpBCcT39a/4vmGgDwWolYb0m11FnYjt8grou0nou53s67gDI1ynbTHrvtBacCFU7ZaOww59FhUKxhUdZYQ0jDFseM5vCYC78+Kfw0QO+QTuyB+HMJPFhAfW0zoNwDJdad5S942YOCEMeroCllpmBJ4pMPFUzkovIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301633; c=relaxed/simple;
	bh=TaLLgHdsOjW2QGj49KEiFxPqLnVWMVzD52ME7e4oIVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aOcS8PjKJR/pD/zvOKowJCgojRlII5TaMblFrKzcyZ4Qj1dRJLJ5BG/opHDhTeYJXhLl1h2CSp9mf6PLJCh8NUByQ63WTiPzG2kCMrAOV7zO/T0hRXqD6Feve9t9phEvminLAe/YgukJoZ4r38NzpN2m+SDKu7IMFNtQ2lngUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qdHzMx/J; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727301624; x=1727906424; i=quwenruo.btrfs@gmx.com;
	bh=fH60agodtTXNSA17lsA1tZNU/uLs7U9Yv20LN5oxkRc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qdHzMx/Ji9J87njEPCm0IJivo12HqSUTHXDKbN2UDGxaFGlHzEnnj71iOxi/wuTC
	 dQBv/+ETRGd6rvkd/OyDQhF09OW7LPjn2Vh17O8VOm4dkm3lhyVuL1rcJ9K5RPpo0
	 MEJ+R46DKlIsETNzBwU39C8zUiJk8skFZJpSnmvYA+Vm1L+8nuinh+6fHPXgfEyLa
	 LxpTUK/4sQiqs9EJTc4pSHIIIw0KkCKLegjv7L8zsCOqVQTEMkTBs6TkntK7FxkMz
	 /wO5ur+jnaiFfpD/aVjBpbiYkbPBFDxl3WoEQh10h07P88tLIy2O4tcSJenS0vZz0
	 SUQgGwXstuZ38MMLwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbBu-1s29r732ik-00wgbe; Thu, 26
 Sep 2024 00:00:24 +0200
Message-ID: <478f2c8d-0a20-4ea2-91bc-4aa70e1ab44a@gmx.com>
Date: Thu, 26 Sep 2024 07:30:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] btrfs: add and use helper to remove extent map from
 its inode's tree
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1727174151.git.fdmanana@suse.com>
 <fb07004bfcdfb702307b484a4910d8d1d4962fc3.1727174151.git.fdmanana@suse.com>
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
In-Reply-To: <fb07004bfcdfb702307b484a4910d8d1d4962fc3.1727174151.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LJPyOxrS6M9090bM0U2BmIYNmw+AM86VkHKf5qglVQ5ZdLqmgg2
 dpU55NFhNU3kuRgn3EmJjRGiwAZwXw7gQY8qAj1uSCOFq5yHgPMq62qJZynQDf2VYJXiGSc
 YtwTZ5zDxxGs0gRvXt29zqjXjl/YTL221H3D3/3NXseop33R9DiDD/jL/TE7L8lHXjgveye
 GrnVXORmiN8l9jcEjEgOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l7H0VmXLamc=;JBguVOO36L4ZGX1MXGWFrdKRdTu
 caNz+0dXdkWedqby1QLZ8ksgjDiIfzH7aNfMqoDHPIkOE8+MkNkHSlpQN0IpoYFYASN2hwsUk
 e652mH9G0enIY/JyfUXCuLTxAaRjITw51AB1XuBoz0Vus+OZdQc/zyviH4nbxhavstDU0kjAU
 4nOrcxfqWjyYhx8dIIal2172+qEFJVpesPlyVxX8K9McRFLzjIwKF95qAFjvw6HxTrY92DzwY
 3VBPiVZQpuFEeaO3ABtsDZbSlHFYAU8rIQWLMA7rXIP/F8x7pkymxuz7W9aE8QuV1Nm8d40ws
 aWZD8ci7blFC6CsvQc7/yk4pJPQBg5p4BkFxABIdz1kvPCzG33l7Siwa0VjECNHi+UDIXe9uI
 JWaUtJvhvblUBUiF87jONS2jrI14wnbacgwJbD2Aqp2Nv/zsG2r+OuJFnEKCdkRViXe/QQ7kv
 5JolxOKIAT6LezzyHTa4jKCLg+x7tcipnq4+0h+8dDLNNFyfhGOVgwR39e35ROrkIJfga8c3K
 mvQgBgXvnVKLMWNIt4V3OJuH1FaJoL4JyuGQZzpMfo8QY3MiJGee4ux8RZjb5ba/zZKBiql8q
 U8y73vg8VX2T/JH5QGnC+1Vh/3aGVslVeKg0cO37vo3eqyJ+JGX3V1K58z8lThffGWzyBoh4i
 NRuZ96iLRmMZ/VQTR6F1jpMpajAFC1pdGf2KZ7q+CZOmoW+ouJtsDpkQ8BUVoy+xtCuVyjAxR
 lOOKFmf/4PCi3LLkrbZUdMv4jFIUcriUwCZSkaJxoTZW18aX9vhQO/XQwZc4VwvZUasdhF9BZ
 ZgM5VNe4izEv0kxpkh7Gqst70daikMh74tumFPB0//Q9I=



=E5=9C=A8 2024/9/24 20:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Move the common code to remove an extent map from its inode's tree into =
a
> helper function and use it, reducing duplicated code.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_map.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 25d191f1ac10..cb2a6f5dce2b 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -77,10 +77,13 @@ static u64 range_end(u64 start, u64 len)
>   	return start + len;
>   }
>
> -static void dec_evictable_extent_maps(struct btrfs_inode *inode)
> +static void remove_em(struct btrfs_inode *inode, struct extent_map *em)
>   {
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>
> +	rb_erase(&em->rb_node, &inode->extent_tree.root);
> +	RB_CLEAR_NODE(&em->rb_node);
> +
>   	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(inode->root=
)))
>   		percpu_counter_dec(&fs_info->evictable_extent_maps);
>   }
> @@ -333,7 +336,6 @@ static void validate_extent_map(struct btrfs_fs_info=
 *fs_info, struct extent_map
>   static void try_merge_map(struct btrfs_inode *inode, struct extent_map=
 *em)
>   {
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -	struct extent_map_tree *tree =3D &inode->extent_tree;
>   	struct extent_map *merge =3D NULL;
>   	struct rb_node *rb;
>
> @@ -365,10 +367,8 @@ static void try_merge_map(struct btrfs_inode *inode=
, struct extent_map *em)
>   			em->flags |=3D EXTENT_FLAG_MERGED;
>
>   			validate_extent_map(fs_info, em);
> -			rb_erase(&merge->rb_node, &tree->root);
> -			RB_CLEAR_NODE(&merge->rb_node);
> +			remove_em(inode, merge);
>   			free_extent_map(merge);
> -			dec_evictable_extent_maps(inode);
>   		}
>   	}
>
> @@ -380,12 +380,10 @@ static void try_merge_map(struct btrfs_inode *inod=
e, struct extent_map *em)
>   		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
>   			merge_ondisk_extents(em, merge);
>   		validate_extent_map(fs_info, em);
> -		rb_erase(&merge->rb_node, &tree->root);
> -		RB_CLEAR_NODE(&merge->rb_node);
>   		em->generation =3D max(em->generation, merge->generation);
>   		em->flags |=3D EXTENT_FLAG_MERGED;
> +		remove_em(inode, merge);
>   		free_extent_map(merge);
> -		dec_evictable_extent_maps(inode);
>   	}
>   }
>
> @@ -582,12 +580,10 @@ void remove_extent_mapping(struct btrfs_inode *ino=
de, struct extent_map *em)
>   	lockdep_assert_held_write(&tree->lock);
>
>   	WARN_ON(em->flags & EXTENT_FLAG_PINNED);
> -	rb_erase(&em->rb_node, &tree->root);
>   	if (!(em->flags & EXTENT_FLAG_LOGGING))
>   		list_del_init(&em->list);
> -	RB_CLEAR_NODE(&em->rb_node);
>
> -	dec_evictable_extent_maps(inode);
> +	remove_em(inode, em);
>   }
>
>   static void replace_extent_mapping(struct btrfs_inode *inode,


