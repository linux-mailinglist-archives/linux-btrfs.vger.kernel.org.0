Return-Path: <linux-btrfs+bounces-3830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B5C895E97
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 23:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB471F2755B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C73315E7F4;
	Tue,  2 Apr 2024 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="t1BgN7Uk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F47D15E5B1
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092705; cv=none; b=GvmYDIaac0jmUPl/anne3D13zyBIjlL238gyEqMEamwYxDklz5oLQAmDtWnx/WTvZ+D4UjKKfqWEtUl/6BlH8263HYGI18HCN4pXmXY0KogMpMf4xpaBSzG8b0eT8GclJ2Regw3zpj0vdZssSjlxUJCyC3LjQpxSYQb1dUtsV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092705; c=relaxed/simple;
	bh=EPwx8qapyfigF9yGtUbItQ1oMr/whp1beluHNStkLxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnk5gdh4pO9hynXSnaFgjtHSok/ce9Hpg1cvg7otNrAHCdmFthirwAk046SXHA6Ch20O8Dppt2/cm+y9Ai87gRODrgRNaxk9rgqiXsQR2rtELB3T4otb0rihUu8+OGwuAHfvj+YCcNrgoRCJH57ZaQKFXf7tWk8nnk1BdRUAQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=t1BgN7Uk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712092695; x=1712697495; i=quwenruo.btrfs@gmx.com;
	bh=II9GHgq9JnQxs8AtKH3ftV/dfdJ7Z5l/uiJH04PIQKg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=t1BgN7UkXMQ6InztouNlhgbHDVmxzVBitt2woHbQFI1vqYbVkGx+qk1upuLkrC/G
	 ERZ/osQEJmzTE6b0ZonGTDLUwQcobXYETow/45oYlR3Z0oFP1HRfjqUNSP1DFbQN3
	 pkoIBrePoEgWIVVxXZLlazsI9eItjPSO9eby1TTJdKSUjLif4L1m/KPPcfhoEtvPR
	 SfjsvabepTnGqt6GOHq5iUq+CjUySD5iJaf6jkZT2Ww+5lLIJ8rI4Jy87pRolfthH
	 DytmSphCJAvzKMQoZIIvBMCptcgvoQtfXFB6jWuwp32L4GJ2bdWOj/sQ2FlnWHsJB
	 xp5yUbNz+8uxsfG44A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZkpb-1sMAAy0Tnb-00WmPi; Tue, 02
 Apr 2024 23:18:15 +0200
Message-ID: <ddd3fbbc-612a-45b1-955b-bc938c4ddb7f@gmx.com>
Date: Wed, 3 Apr 2024 07:48:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove not needed mod_start and mod_len from
 struct extent_map
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
References: <2b5929e96bbede278f63c68a149cb50645b094d6.1712074768.git.fdmanana@suse.com>
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
In-Reply-To: <2b5929e96bbede278f63c68a149cb50645b094d6.1712074768.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vLxMngZLymg0hDFF45uQZ627i2avRov928Aj6UtuBs4VuKiu0yD
 nmWa/l0/6yHJKXw4q75Tyfsf+Ee3Zn231DB8r06A9/T5rxdDIdp6ETGiaE3nhhktLxYqNNF
 MEqHWRxfBBQBrE3Iv9CJCB5zb+1ViisN0rvTCDMWR9RQtwGb+wemhO5cg5hoSajqiMqdtCl
 DigQ+s3pggRPnIG4mj76A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G0vfOnEAobY=;4xZ0ulZ8ss2y4jtEyN2d9ERebEh
 4R0l3fsZiOIqk2czfd4ISwLB8PwnlmybdvwMoM9cnivU7Wl91QdHwex+T6w0JPTuGwx45SItX
 ERVewdCRbMVJVFR5cbfUI3YgjuSTgEkIayqnvi0NpETCoUYM4j6vQ8IbLQcl8ydAixotNatYl
 OmnomdiDaqHiu8wGwyNAAT7fAVeIJleDrFy75OlfouVHc5ox7UcoH/zOQ1arelSPsUguES539
 ptzGKYI/TsLo2reeliVD8uP3iAN05qyv1/QgLJk71/9bfaoAKiBdNgd/kIjoOAU6juJbF8hR6
 TUjO/wIyMGzNcDvsYvzVJvLFOqPi+RLCdkpgCvBH3PE1jus1oIflyHdMhxPhcfBlx2ZDQ08T5
 BCCCWH6diQ+P32zvGavKeA/YFdcVPH8KUN4gWP3IUbAV3cv8HMYPDzgCIoiOvgnSfZe95qSCE
 8zxKWGo8s/Pz4Ac1JZ0fZl1ZoVwdiZn8ufdzGbbyze97VAz9vmAFln1wZcTjxyms0Jn7O1ozA
 JeJ/v8M7FWuL9Fy2+uh8QhkShseUqWnrNCQY6d202Z2SyiUM9RIaYZQmWGM4tDP6TwoHdEtxP
 awZtCS7C+PHQgl0yypa6xc+YyiCpdshzdgoUSrrnu7Yp1I4YBV7HUvlLLywMY0HP8G2uPvnyi
 h0uK4rxnJiZ9sUs+yUzKix0i1vzrGp80MhZzskQN89jqQJpV9brvonk6yBgGmxzHUPwUTTCgk
 ebGSCThh8580KYZygVx0svv8jpQPmY+j+ka1+jU8STFi9n5by/8nKgeaP9/j23P1Hh6Rg1CNj
 HDFEZbDf+ChdSkVw1G2nChxPino6weuyhuBKGaq3seR5k=



=E5=9C=A8 2024/4/3 03:10, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> The mod_start and mod_len fields of struct extent_map were introduced by
> commit 4e2f84e63dc1 ("Btrfs: improve fsync by filtering extents that we
> want") in order to avoid too low performance when fsyncing a file that
> keeps getting extent maps merge, because it resulted in each fsync loggi=
ng
> again csum ranges that were already merged before.
>
> We don't need this anymore as extent maps in the modified list of extent=
s
> that get merged with other extents and once we log an extent map we remo=
ve
> it from the list of modified extent maps.
>
> So remove the mod_start and mod_len fields from struct extent_map and us=
e
> instead the start and len fields when logging checksums in the fast fsyn=
c
> path. This also makes EXTENT_FLAG_FILLING unused so remove it as well.
>
> Running the reproducer from the commit mentioned before, with a larger
> number of extents and against a null block device, so that IO is fast
> and we can better see any impact from searching checkums items and loggi=
ng
> them, gave the following results from dd:
>
> Before this change:
>
>     409600000 bytes (410 MB, 391 MiB) copied, 22.948 s, 17.8 MB/s
>
> After this change:
>
>     409600000 bytes (410 MB, 391 MiB) copied, 22.9997 s, 17.8 MB/s
>
> So no changes in throughput.
> The test was done in a release kernel (non-debug, Debian's default kerne=
l
> config) and its steps are the following:
>
>     $ mkfs.btrfs -f /dev/nullb0
>     $ mount /dev/sdb /mnt
>     $ dd if=3D/dev/zero of=3D/mnt/foobar bs=3D4k count=3D100000 oflag=3D=
sync
>     $ umount /mnt
>
> This also reduce the size of struct extent_map from 128 bytes down to 11=
2
> bytes, so now we can have 36 extents maps per 4K page instead of 32.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Great we can start cleaning up the extent map members.

Mind this patch to be included in my upcoming extent map cleaning series?

Thanks,
Qu
> ---
>   fs/btrfs/extent_map.c        | 18 ------------------
>   fs/btrfs/extent_map.h        |  4 ----
>   fs/btrfs/inode.c             |  4 +---
>   fs/btrfs/tree-log.c          |  4 ++--
>   include/trace/events/btrfs.h |  3 +--
>   5 files changed, 4 insertions(+), 29 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 445f7716f1e2..471654cb65b0 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -252,8 +252,6 @@ static void try_merge_map(struct extent_map_tree *tr=
ee, struct extent_map *em)
>   			em->len +=3D merge->len;
>   			em->block_len +=3D merge->block_len;
>   			em->block_start =3D merge->block_start;
> -			em->mod_len =3D (em->mod_len + em->mod_start) - merge->mod_start;
> -			em->mod_start =3D merge->mod_start;
>   			em->generation =3D max(em->generation, merge->generation);
>   			em->flags |=3D EXTENT_FLAG_MERGED;
>
> @@ -271,7 +269,6 @@ static void try_merge_map(struct extent_map_tree *tr=
ee, struct extent_map *em)
>   		em->block_len +=3D merge->block_len;
>   		rb_erase_cached(&merge->rb_node, &tree->map);
>   		RB_CLEAR_NODE(&merge->rb_node);
> -		em->mod_len =3D (merge->mod_start + merge->mod_len) - em->mod_start;
>   		em->generation =3D max(em->generation, merge->generation);
>   		em->flags |=3D EXTENT_FLAG_MERGED;
>   		free_extent_map(merge);
> @@ -300,7 +297,6 @@ int unpin_extent_cache(struct btrfs_inode *inode, u6=
4 start, u64 len, u64 gen)
>   	struct extent_map_tree *tree =3D &inode->extent_tree;
>   	int ret =3D 0;
>   	struct extent_map *em;
> -	bool prealloc =3D false;
>
>   	write_lock(&tree->lock);
>   	em =3D lookup_extent_mapping(tree, start, len);
> @@ -325,21 +321,9 @@ int unpin_extent_cache(struct btrfs_inode *inode, u=
64 start, u64 len, u64 gen)
>
>   	em->generation =3D gen;
>   	em->flags &=3D ~EXTENT_FLAG_PINNED;
> -	em->mod_start =3D em->start;
> -	em->mod_len =3D em->len;
> -
> -	if (em->flags & EXTENT_FLAG_FILLING) {
> -		prealloc =3D true;
> -		em->flags &=3D ~EXTENT_FLAG_FILLING;
> -	}
>
>   	try_merge_map(tree, em);
>
> -	if (prealloc) {
> -		em->mod_start =3D em->start;
> -		em->mod_len =3D em->len;
> -	}
> -
>   out:
>   	write_unlock(&tree->lock);
>   	free_extent_map(em);
> @@ -361,8 +345,6 @@ static inline void setup_extent_mapping(struct exten=
t_map_tree *tree,
>   					int modified)
>   {
>   	refcount_inc(&em->refs);
> -	em->mod_start =3D em->start;
> -	em->mod_len =3D em->len;
>
>   	ASSERT(list_empty(&em->list));
>
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index c5a098c99cc6..10e9491865c9 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -30,8 +30,6 @@ enum {
>   	ENUM_BIT(EXTENT_FLAG_PREALLOC),
>   	/* Logging this extent */
>   	ENUM_BIT(EXTENT_FLAG_LOGGING),
> -	/* Filling in a preallocated extent */
> -	ENUM_BIT(EXTENT_FLAG_FILLING),
>   	/* This em is merged from two or more physically adjacent ems */
>   	ENUM_BIT(EXTENT_FLAG_MERGED),
>   };
> @@ -46,8 +44,6 @@ struct extent_map {
>   	/* all of these are in bytes */
>   	u64 start;
>   	u64 len;
> -	u64 mod_start;
> -	u64 mod_len;
>   	u64 orig_start;
>   	u64 orig_block_len;
>   	u64 ram_bytes;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3442dedff53d..c6f2b5d1dee1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7338,9 +7338,7 @@ static struct extent_map *create_io_em(struct btrf=
s_inode *inode, u64 start,
>   	em->ram_bytes =3D ram_bytes;
>   	em->generation =3D -1;
>   	em->flags |=3D EXTENT_FLAG_PINNED;
> -	if (type =3D=3D BTRFS_ORDERED_PREALLOC)
> -		em->flags |=3D EXTENT_FLAG_FILLING;
> -	else if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
> +	if (type =3D=3D BTRFS_ORDERED_COMPRESSED)
>   		extent_map_set_compression(em, compress_type);
>
>   	ret =3D btrfs_replace_extent_map_range(inode, em, true);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 472918a5bc73..d9777649e170 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4574,8 +4574,8 @@ static int log_extent_csums(struct btrfs_trans_han=
dle *trans,
>   	struct btrfs_root *csum_root;
>   	u64 csum_offset;
>   	u64 csum_len;
> -	u64 mod_start =3D em->mod_start;
> -	u64 mod_len =3D em->mod_len;
> +	u64 mod_start =3D em->start;
> +	u64 mod_len =3D em->len;
>   	LIST_HEAD(ordered_sums);
>   	int ret =3D 0;
>
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 90b0222390e5..766cfd48386c 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -277,8 +277,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
>   		{ EXTENT_FLAG_COMPRESS_LZO,	"COMPRESS_LZO"	},\
>   		{ EXTENT_FLAG_COMPRESS_ZSTD,	"COMPRESS_ZSTD"	},\
>   		{ EXTENT_FLAG_PREALLOC,		"PREALLOC"	},\
> -		{ EXTENT_FLAG_LOGGING,		"LOGGING"	},\
> -		{ EXTENT_FLAG_FILLING,		"FILLING"	})
> +		{ EXTENT_FLAG_LOGGING,		"LOGGING"	})
>
>   TRACE_EVENT_CONDITION(btrfs_get_extent,
>

