Return-Path: <linux-btrfs+bounces-4130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009878A07CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 07:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEAC1C2192F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 05:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F0413C9CD;
	Thu, 11 Apr 2024 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="K4oJ6nGa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9E0EADD
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 05:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813984; cv=none; b=kC2j8svvkdZ9bFyA8OYCii3WxB5P/QqoCzQHL3tyCIlT2DLqrga/GRXcC/aFLfWzsA28h9QT96bL3YlFTxBD1DpIWccClP7sHacDzP/WxCj3rDyF6G0KBqPravwnrz1ig9rHdSqA2cLPFCCkbw0xXSqdh/5FT9KhnmHh0kbnNko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813984; c=relaxed/simple;
	bh=c/rU6rcfcWisDk2NE3brar1JNk0IwQssMeHnXCY/RuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fT9ZIq66Qb/h3Z8Z/LujQKB5UQ0Ut5p+WKJMJOlOtElUS4MI12HwMKhVnPU0lMBiFNE9vT64UI7FqRTalnbD4HougaHx2Oc2L7I1/BxeqZZAbIEKLLPfFn6kuHAp5F4bdow4fDGPDi2tfteiFJ2a3aZTmSYUYlSW8ZFyj8F+nvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=K4oJ6nGa; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712813975; x=1713418775; i=quwenruo.btrfs@gmx.com;
	bh=3ITvoTn0nq2xM0wYL7/AscjnLv2AM40itiLqrIcfpvg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=K4oJ6nGagIx9yrpihuDU5DwNBLEzDCrmByzz+lWxZBWXziL51bVgCXS4cnu6wrYY
	 Ia6KPtz5H+ZZ06m0RO/lNjdu7YvYI4MSc1Z7FlTokuJzQgleKv/rdYoivd/huo/vg
	 Ny9OmVrz9FbSmH7cLWSP7/oaNDCtWe91QdnAphoARW9Vwp3X9k6hMZfdTOp4KFpL3
	 yr6SZnoqElfeQaPzMKj+CjoBgvKNPNfRWqtZ9Z9RWvWXj2AcQ77Lqq4NItuEUucUs
	 9zP5FGzy3Mg5O2yPIIpv4+2Xc437Eeo+fLBmpMNd8ExJsnJW23Dht5k3pvBA5Dmjn
	 WbpY+nY0c5PeWfLedA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My32F-1shW3d2jgF-00zYzL; Thu, 11
 Apr 2024 07:39:35 +0200
Message-ID: <4ff14e1a-964b-45e0-885f-1e86386c7924@gmx.com>
Date: Thu, 11 Apr 2024 15:09:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] btrfs: add a global per cpu counter to track number
 of used extent maps
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712748143.git.fdmanana@suse.com>
 <0f1a834bcb67f4c57885706b54e19d22e64b9ce7.1712748143.git.fdmanana@suse.com>
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
In-Reply-To: <0f1a834bcb67f4c57885706b54e19d22e64b9ce7.1712748143.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EcqYaHAwNakwWqMFR3vdjX1yHhJCetfgok3hB3PV5sU5lC+GZWU
 +lcBPRozQ0xT1LrbggcMMKglMIOBBPNder9qFPvy/RW2RT+HUV7fzeX1UJD6jC/0jK7NtIf
 oTaJJyn3M47v+ywDkTbwxD4ljed02EqemjTB1ePlsVB8JjOjPNGTlAO7qbCHTMqUfYxrL5c
 MJlg6saSooQLraSiXozpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:belZq67++/k=;jmI5vJ+v+7GAwsP71HT3vcOZard
 hpZEvCinO2xYvsLIE6H2uUJNlBCY/ITl2PGeDTmtpCgpBJs2hvMD2mUhKPYuvBHCkR7hb1y6a
 VWqYtTmWHvY9BowGCZaoNuaSI2RzoreiUiLMqyfFrs7fBz6/JN9YtxS00LuJEvw+URLyCbLzk
 SF1CtDR1tQqg1Ruv1jYjNbTAdgRiUdN19lnAbgeWJqlWC8c2iTjpJTCoyrXYCOe6NaS5/mTcu
 ZvFHaldToHkS52gPKOYbmZI/gKOphxCsmcukjF3E8XpjLZpYh9OZzKpCzuHKYflN4XB2tqDm+
 u6nISZD8mehFu3cgCP5BQ5jUg7gl2/IFPuscB/5d4FpJlrqA7uD7kLFQyKH+gksn2A2DHgM0F
 zq2a0FX0DM97F9M32kwBlS2nbrb7ye2cQqlc5MS4lMyY1SEOeEJQVV/00ChJVKIB5Zl9p2hSq
 z155qCfOP6d4RqVFUTcctS2MRAL6Ghfb/0bbky/hHZFO5+0rJS/9Ku3CF5SqHyS6+LEmyy9II
 VYFKuintf5Hj0JRrD0hRN17zdsnAgpd160m0cYOY5i7GqiYvOIdNkaW5jIGcIpwEjXYSLPOuL
 bw1MsLLBZNiTuFxWeHxNDzBme/4mBuyxBpH9gV966QYxJV3ZbdCbrLYjsEtwgFoMd6ydtAlM9
 diw0H1y8XCVp2X6e6CH+pI1kdu948R23S1d8e5L4hWzk96io+JUTP5TjCriWY0H3JRzqPMBR/
 Fr1btE/leATl56CMiDBS/2uL1qw0+i1Mj4AyOzZKNUS6RWwEzxtMiT1C7FeTl6710RGHsUyZg
 wGAHr/z4JYGisFpVUwtpE9UrWjMKmbZxysYnrUXolB/Xk=



=E5=9C=A8 2024/4/10 20:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Add a per cpu counter that tracks the total number of extent maps that a=
re
> in extent trees of inodes that belong to fs trees. This is going to be
> used in an upcoming change that adds a shrinker for extent maps. Only
> extent maps for fs trees are considered, because for special trees such =
as
> the data relocation tree we don't want to evict their extent maps which
> are critical for the relocation to work, and since those are limited, it=
's
> not a concern to have them in memory during the relocation of a block
> group. Another case are extent maps for free space cache inodes, which
> must always remain in memory, but those are limited (there's only one pe=
r
> free space cache inode, which means one per block group).
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
[...]
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -76,6 +76,14 @@ static u64 range_end(u64 start, u64 len)
>   	return start + len;
>   }
>
> +static void dec_evictable_extent_maps(struct btrfs_inode *inode)
> +{
> +	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +
> +	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(inode->root)=
))
> +		percpu_counter_dec(&fs_info->evictable_extent_maps);
> +}
> +
>   static int tree_insert(struct rb_root_cached *root, struct extent_map =
*em)
>   {
>   	struct rb_node **p =3D &root->rb_root.rb_node;
> @@ -223,8 +231,9 @@ static bool mergeable_maps(const struct extent_map *=
prev, const struct extent_ma
>   	return next->block_start =3D=3D prev->block_start;
>   }
>
> -static void try_merge_map(struct extent_map_tree *tree, struct extent_m=
ap *em)
> +static void try_merge_map(struct btrfs_inode *inode, struct extent_map =
*em)

Maybe it would be a little easier to read if the extent_map_tree to
btrfs_inode conversion happens in a dedicated patch, just like all the
previous ones?

Otherwise the introduction of the per-cpu counter looks good to me.

Thanks,
Qu

