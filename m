Return-Path: <linux-btrfs+bounces-5754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2E90A5B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 08:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F22D1F20C36
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8807C1850B4;
	Mon, 17 Jun 2024 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iOFRiStY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1965817E900;
	Mon, 17 Jun 2024 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605666; cv=none; b=a42T/NA5FiA41Y91tJWM+LJdnGg1AznR7QgNXuYGloTFTIDDr+KwyamDLF6KiYnUw8Ur3JVcPA6l7G538QFBqJkVZVs3dw0zt4PerxVvqxNay28vdf4G5/Llc3fmmmrDLepYLNov9e/bq+g9AgYpXPEaHJ0gstcwE3nusyFp89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605666; c=relaxed/simple;
	bh=9graNFzYLZAiIG07ICrI4J7ntIF0Tby0R7gZl0N97S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc5O3QHmaqUoMNG8XTEZ8lllffMV0+1f20hwmxGMzPNQ4FTYOUBHVmOfjQdyKGrmNSHFUB1ha4yepqrhgS453xVZ3sj7VX4Mo0E+KEFDdeCOchVzHQU5q6ej5oH5KcvFPCTT/GfMRgKV+ph4i1iRzmlXA7OQVorPlzT+nuNXK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iOFRiStY; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718605650; x=1719210450; i=quwenruo.btrfs@gmx.com;
	bh=STS0e609qcKbJeHeyEZPmvuQL7PJjagyZMst7phExwQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iOFRiStYmI8loXfczq2fGD/wNFV37ZithEdYjbyzm+ZmxsNcZsveZiuhpdfjU/gw
	 ZEyCGnhrn9yfXCb+V6ZZwywWC/HQJtdPipu+Qs8EueuNSWW+Fuhc4GgjpZcXeGUam
	 cck3+tpsQVCYc3fpfZQLnRG7U6kjdyqya9//yC41EXotGjciWK0kreNu8/m8sKByA
	 /0ZmgZFIVlJCjz1fTCS1xbemhIzkJl8oYDDvTtPtziQhn05T+ZnrAsZ+iz/Lkrra3
	 XvcRBFxy4v30Uaq2EkcZiBFDgjXGFUfLLY7AcoYuV+Wdd1wJpcA+yBuy9o0xTtjnY
	 oKbNuIL2MmkGv/sPRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgeoI-1stF091YL6-00gU0u; Mon, 17
 Jun 2024 08:27:30 +0200
Message-ID: <f02a0366-4754-48fc-9746-39888371de97@gmx.com>
Date: Mon, 17 Jun 2024 15:57:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: rst: remove encoding field from stripe_extent
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-1-179c1eec08f2@kernel.org>
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
In-Reply-To: <20240610-b4-rst-updates-v1-1-179c1eec08f2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HQgtvCu+FG/DbLkhQrz+xvsrLgsXFC9nW98Ur5fFji/evCYZlsn
 TDaDm6TeyLzbFdl99RZ3dDj6FcZs1cP/zBKmtYCG+dRasToJJtF4L89LTVSGBVJecDkbJ01
 z2CvMBd86tJo4Ylthqe/7d01NxGq3g+zX/We+Tot0OxGRRadzhMBf8b7kDFDa7KX2Qby/0w
 +vfJi9rJ71FF06NjkOShg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xa7rPNOw+P8=;oYwELhWZzkQoQYGpxzozoitLv0p
 rJnVj/IOIUdCd8nphdQCQGkhd76SWjcURiHUNKsU2mmgxmxDZL32wYW2Pl3/5XFZTIYBY3In9
 m3IvLxhhSO3vfR2V/WbcgtULRp/BXWOVaG/YxhuJzxEAfNo4ArXGBOoxjBiDumMWUHOQRLZfn
 OanIUg9yFFBT87HmekOHduoWF1jzfS69CMWbYS7g/JdaEJf+tr5r7YAERlT2z7Axb2n8b8iI8
 UV8BiBFnpfQIoIPWMei4t2hCQPHeInDUCL0v5vek1OFQP7rItZyDdHaIKUDpo+TIZIMIu46YZ
 g4dN1NQlqi5iwoxqbFzUUpWd//oaSqfTaIW2eo/GJvzOaZxsScrU6hU56t1SIBk3J7cevpmSe
 ZOFeCpLm2EdI7B1sii+/aEG6G+lvUDL7/zkVvYXBa2TOKKSWM4iKLmhlda2OoTqd5af1mSAKz
 dWPE1YIV0cV2vpewBUEyR5Mpazv/hcPTuWYir+VyV9ZnPWWJs2/X10GTR+3WAGp9SniVqDTcq
 ghW7R1Lz1ztUhFKE6aMD7WXjLQo60rQ5rGzcijwR6d6+lyoq2fmkhML2dcOCDlJgP0+XCMkfS
 3tIrupbnTWph19EnHjqy6hFY7MNVj1kfx8DCMimXfARvyUrw2reKVToLc9O1SLL8rcwlgtxV+
 PioRDOSuInK2h2/iq6ZuDeI8nyN9j7Dh1OmRTy205z24c3FzokD1FRfkGIZFEQARjapXed3SZ
 ksLfES6+tvsxYBmMhbY1DF/F+/UygGY27PQ6banPerqtmElTAsc4Rbp/BL07hND7nf+QBhNNh
 gZ3yzHFnD28LtkFhjIYyrRiaP0cyk9bsAizvkcj8EDdHE=



=E5=9C=A8 2024/6/10 18:10, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Remove the encoding field from 'struct btrfs_stripe_extent'. It was
> originally intended to encode the RAID type as well as if we're a data
> or a parity stripe.
>
> But the RAID type can be inferred form the block-group and the data vs.
> parity differentiation can be done easier with adding a new key type
> for parity stripes in the RAID stripe tree.

Talking about adding new key type or even new members, I'm wondering can
we also utilizing the higher 8/16/32 bits of key.offset?

Currently the RST entry uses key.offset for the length of the entry,
which is at most the length of the max zone append size.

If the vendor (WDC) is determined to go with zone size smaller than 4G
(32bits) or 256T (48bits), we definitely have 32 or 16 bits for other
usages, without expanding the entry item size.

The 4G (32bits) looks a little unreliable but 256T (48bits) is
definitely worthy considering.

Thanks,
Qu
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/accessors.h            |  3 ---
>   fs/btrfs/print-tree.c           |  5 -----
>   fs/btrfs/raid-stripe-tree.c     | 13 -------------
>   fs/btrfs/raid-stripe-tree.h     |  3 +--
>   fs/btrfs/tree-checker.c         | 19 -------------------
>   include/uapi/linux/btrfs_tree.h | 14 +-------------
>   6 files changed, 2 insertions(+), 55 deletions(-)
>
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index 6c3deaa3e878..b2eb9cde2c5d 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -315,11 +315,8 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_time=
spec, nsec, 32);
>   BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, se=
c, 64);
>   BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, n=
sec, 32);
>
> -BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, =
encoding, 8);
>   BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid,=
 64);
>   BTRFS_SETGET_FUNCS(raid_stride_physical, struct btrfs_raid_stride, phy=
sical, 64);
> -BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_encoding,
> -			 struct btrfs_stripe_extent, encoding, 8);
>   BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_devid, struct btrfs_raid_st=
ride, devid, 64);
>   BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_physical, struct btrfs_raid=
_stride, physical, 64);
>
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 7e46aa8a0444..9f1e5e11bf71 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -208,11 +208,6 @@ static void print_raid_stripe_key(const struct exte=
nt_buffer *eb, u32 item_size,
>   				  struct btrfs_stripe_extent *stripe)
>   {
>   	const int num_stripes =3D btrfs_num_raid_stripes(item_size);
> -	const u8 encoding =3D btrfs_stripe_extent_encoding(eb, stripe);
> -
> -	pr_info("\t\t\tencoding: %s\n",
> -		(encoding && encoding < BTRFS_NR_RAID_TYPES) ?
> -		btrfs_raid_array[encoding].raid_name : "unknown");
>
>   	for (int i =3D 0; i < num_stripes; i++)
>   		pr_info("\t\t\tstride %d devid %llu physical %llu\n",
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 6af6b4b9a32e..e6f7a234b8f6 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -80,7 +80,6 @@ static int btrfs_insert_one_raid_extent(struct btrfs_t=
rans_handle *trans,
>   	struct btrfs_key stripe_key;
>   	struct btrfs_root *stripe_root =3D fs_info->stripe_root;
>   	const int num_stripes =3D btrfs_bg_type_to_factor(bioc->map_type);
> -	u8 encoding =3D btrfs_bg_flags_to_raid_index(bioc->map_type);
>   	struct btrfs_stripe_extent *stripe_extent;
>   	const size_t item_size =3D struct_size(stripe_extent, strides, num_st=
ripes);
>   	int ret;
> @@ -94,7 +93,6 @@ static int btrfs_insert_one_raid_extent(struct btrfs_t=
rans_handle *trans,
>
>   	trace_btrfs_insert_one_raid_extent(fs_info, bioc->logical, bioc->size=
,
>   					   num_stripes);
> -	btrfs_set_stack_stripe_extent_encoding(stripe_extent, encoding);
>   	for (int i =3D 0; i < num_stripes; i++) {
>   		u64 devid =3D bioc->stripes[i].dev->devid;
>   		u64 physical =3D bioc->stripes[i].physical;
> @@ -159,7 +157,6 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_inf=
o *fs_info,
>   	struct extent_buffer *leaf;
>   	const u64 end =3D logical + *length;
>   	int num_stripes;
> -	u8 encoding;
>   	u64 offset;
>   	u64 found_logical;
>   	u64 found_length;
> @@ -222,16 +219,6 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_in=
fo *fs_info,
>
>   	num_stripes =3D btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
>   	stripe_extent =3D btrfs_item_ptr(leaf, slot, struct btrfs_stripe_exte=
nt);
> -	encoding =3D btrfs_stripe_extent_encoding(leaf, stripe_extent);
> -
> -	if (encoding !=3D btrfs_bg_flags_to_raid_index(map_type)) {
> -		ret =3D -EUCLEAN;
> -		btrfs_handle_fs_error(fs_info, ret,
> -				      "on-disk stripe encoding %d doesn't match RAID index %d",
> -				      encoding,
> -				      btrfs_bg_flags_to_raid_index(map_type));
> -		goto out;
> -	}
>
>   	for (int i =3D 0; i < num_stripes; i++) {
>   		struct btrfs_raid_stride *stride =3D &stripe_extent->strides[i];
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> index c9c258f84903..1ac1c21aac2f 100644
> --- a/fs/btrfs/raid-stripe-tree.h
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -48,8 +48,7 @@ static inline bool btrfs_need_stripe_tree_update(struc=
t btrfs_fs_info *fs_info,
>
>   static inline int btrfs_num_raid_stripes(u32 item_size)
>   {
> -	return (item_size - offsetof(struct btrfs_stripe_extent, strides)) /
> -		sizeof(struct btrfs_raid_stride);
> +	return item_size / sizeof(struct btrfs_raid_stride);
>   }
>
>   #endif
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index a2c3651a3d8f..1e140f6dabc6 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1682,9 +1682,6 @@ static int check_inode_ref(struct extent_buffer *l=
eaf,
>   static int check_raid_stripe_extent(const struct extent_buffer *leaf,
>   				    const struct btrfs_key *key, int slot)
>   {
> -	struct btrfs_stripe_extent *stripe_extent =3D
> -		btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
> -
>   	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) =
{
>   		generic_err(leaf, slot,
>   "invalid key objectid for raid stripe extent, have %llu expect aligned=
 to %u",
> @@ -1698,22 +1695,6 @@ static int check_raid_stripe_extent(const struct =
extent_buffer *leaf,
>   		return -EUCLEAN;
>   	}
>
> -	switch (btrfs_stripe_extent_encoding(leaf, stripe_extent)) {
> -	case BTRFS_STRIPE_RAID0:
> -	case BTRFS_STRIPE_RAID1:
> -	case BTRFS_STRIPE_DUP:
> -	case BTRFS_STRIPE_RAID10:
> -	case BTRFS_STRIPE_RAID5:
> -	case BTRFS_STRIPE_RAID6:
> -	case BTRFS_STRIPE_RAID1C3:
> -	case BTRFS_STRIPE_RAID1C4:
> -		break;
> -	default:
> -		generic_err(leaf, slot, "invalid raid stripe encoding %u",
> -			    btrfs_stripe_extent_encoding(leaf, stripe_extent));
> -		return -EUCLEAN;
> -	}
> -
>   	return 0;
>   }
>
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_=
tree.h
> index d24e8e121507..cb103c76d398 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -747,21 +747,9 @@ struct btrfs_raid_stride {
>   	__le64 physical;
>   } __attribute__ ((__packed__));
>
> -/* The stripe_extent::encoding, 1:1 mapping of enum btrfs_raid_types. *=
/
> -#define BTRFS_STRIPE_RAID0	1
> -#define BTRFS_STRIPE_RAID1	2
> -#define BTRFS_STRIPE_DUP	3
> -#define BTRFS_STRIPE_RAID10	4
> -#define BTRFS_STRIPE_RAID5	5
> -#define BTRFS_STRIPE_RAID6	6
> -#define BTRFS_STRIPE_RAID1C3	7
> -#define BTRFS_STRIPE_RAID1C4	8
> -
>   struct btrfs_stripe_extent {
> -	__u8 encoding;
> -	__u8 reserved[7];
>   	/* An array of raid strides this stripe is composed of. */
> -	struct btrfs_raid_stride strides[];
> +	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);
>   } __attribute__ ((__packed__));
>
>   #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
>

