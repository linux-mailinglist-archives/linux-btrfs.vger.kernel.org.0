Return-Path: <linux-btrfs+bounces-2302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BCC8503B3
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 10:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531D91C22890
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC5136135;
	Sat, 10 Feb 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C286p3mh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E8731A8F
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Feb 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707558008; cv=none; b=OovpruTH4QBFI9gx58xBVmrFg3Dtp3xGBBq8D7+1Wtwt+aXg4kgbmNfJs9NFjoKREy56CByg+db3DSXa+/ziEmNSXokFnOUBVwjfziKkgJsyW7ZCY043UKVme90MJLxLuGAd4b9Y8VVPtxzmoemUg5/315+lihJN6wYt3lZt1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707558008; c=relaxed/simple;
	bh=Osh8drQkNwe6JBC44u7X7aJqBPbWLZmvlVRu/B66Av4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIdOJmTHtw0X4cxeluHDL17+rKHToqD07ki2YSbLPU0o+RK5pmfulmdOhxOjbP8N+Pk/WLTXzBJf3643arWDiHraTgIx/QtW4+SLoNHwQ+DEda3mULzz6X71Mpn8F9wkNjnRIXObqiIDX0hfMldZ28E7xVgF43iVZIBePc0BSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C286p3mh; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707557991; x=1708162791; i=quwenruo.btrfs@gmx.com;
	bh=Osh8drQkNwe6JBC44u7X7aJqBPbWLZmvlVRu/B66Av4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=C286p3mhgbLibQ3mpKCtQSVkq7nxzOJ2kyhnprLgzY2ge1ktWlF0sfme5FUjOLAl
	 oZaZc7HjxrZr4ivj/PK83h2A9l9/lHZBFtdc9IjuKx8Ims1LavywUw4WiyHWVBkMM
	 1aQV/otjodUcy/qo8Z7dk5MOoqEXwVAJERFQN4EK7rI1/Y288L5M6Rnm7GlS/PhAZ
	 oVp5OKKjgU+2yFToziFV1P2Z2Vi7YR+Z+wchawypPPnPLoChfCqmx4med+ebD+YAb
	 Dby9RsBLTpMQQqsVJaPWYqPLHy8Yvio057Lp/hvBmjJcTUpwaJy8tG8KgK3aoVq8m
	 by9IoW0YQRlyUlz/pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXdC-1rKwJZ0xUY-00MZ4b; Sat, 10
 Feb 2024 10:39:51 +0100
Message-ID: <91eda445-e58c-4fab-ae49-a10951edfa8d@gmx.com>
Date: Sat, 10 Feb 2024 20:09:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] btrfs: remove non-standard extent handling in
 __extent_writepage_io
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20230531060505.468704-1-hch@lst.de>
 <20230531060505.468704-11-hch@lst.de>
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
In-Reply-To: <20230531060505.468704-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QFCRvcFstv7hnbQC2G2ioQntwrbSty7oZcKIVVqMdPS83NDYQai
 NwX/E8E8YzFidgqykqHmtHf6dzVanrCCKvzwYe95c8cbdwtbASNnJYe6+c+4K5tF/f7YPlR
 1JogL4fn8AU25lXG6ANmMDp+c/PWeren4oOIiQa+/ffKKK9dJok4mBINJ9xeKhJPIgMcivU
 FiEbhy6oh0AuPCAq3xANA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I2ffT+guAn8=;3XwIetITirvwem5MQ/0Leh6kiOw
 1Io31ZxiAY6uxa6zX2jkbwztRZ6CmcmP/kh0SHqU9TMxY7tYMTpCvjuqZ51heqxRvR3EyS7vE
 fSR8Lvj79GNDeonVh2XP0oCefB2LVeAuZEs1w9abqnQkeKHXz8yifOXgniugC6H3tJe5QkOc1
 rssB9DR1VmbvTX4y4hcChVo8bYQMKsx+POZzSvoahGdhoPWWAYZdivwQDZPOBJ2QRr/tQaFnn
 I7autgRWxXBIjojge7kpNY4XmiGdYOyILDGxC1yhxuIw6bTSEMZa4N4alqi07LpwhKyPIKyRr
 Gl/25Xw5Nut9JjdN8lVMxD//TiCijrjx1mE5UZJM9XOujq2sWwojblkYI+oabp582XUMDnABd
 yf905Kt95KExZJ4gxtRz02WFmEr4jStBD0uCmIfgXXoI8L1bCAZb0PqYWLyTOPsEkN22TLtcX
 B5U1Lt8bxYGrnaPZXpgsbpLVt2HRm/rAHuiipr2w6StEexOA7FLt5bfrQ93xvrEgAanv+wNe7
 XBOAOCnMbwWY0H8DHKAI7LluBYdm8YTfIOMxn0OAeBW9i4XwpYa5kW1ODkf8/T45ddyQc3VGR
 QRzyhPIMcaRxmGNpNm27TU8Vry9hi416GuyQFKKYGkTcPX8RrwgiZWBk1RJTLKQ59olYGRqIh
 Ha8l5W1oP4ZPZOddWobMyP6Xby0Vpb642Rd0ALM026uUFFyO6YnsgQDuCmHIbIMeuK6rsoxc2
 flnJhy5EFeJ9NKns85GNz1mGmTGnQH+dVT+I8Z3qLSDnbCKkyeAEcS8mPjfDE3GCcxQLVj8q2
 O7DMSA22wciy/6mwkm3jnywXjI2nW1eAklLJ2lcAeCn4E=



On 2023/5/31 15:34, Christoph Hellwig wrote:
> __extent_writepage_io is never called for compressed or inline extents,
> or holes.  Remove the not quite working code for them and replace it wit=
h
> asserts that these cases don't happen.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It's a little too late, but this patch is causing crashing for subpage.

> ---
>   fs/btrfs/extent_io.c | 23 +++++------------------
>   1 file changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 09a9973c27ccfb..a2e1dbd9b92309 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1361,7 +1361,6 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>   	struct extent_map *em;
>   	int ret =3D 0;
>   	int nr =3D 0;
> -	bool compressed;
>
>   	ret =3D btrfs_writepage_cow_fixup(page);
>   	if (ret) {
> @@ -1419,10 +1418,14 @@ static noinline_for_stack int __extent_writepage=
_io(struct btrfs_inode *inode,
>   		ASSERT(cur < end);
>   		ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
>   		ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
> +
>   		block_start =3D em->block_start;
> -		compressed =3D test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
>   		disk_bytenr =3D em->block_start + extent_offset;
>
> +		ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
> +		ASSERT(block_start !=3D EXTENT_MAP_HOLE);

For subpage cases, __extent_writepage_io() can be triggered to write
only a subset of the page, from extent_write_locked_range().

In that case, if we have submitted the target range, since our @len is
to the end of the page, we can hit a hole.

In that case, this ASSERT() would be triggered.
And even worse, if CONFIG_BTRFS_ASSERT() is not enabled, we can do wrong
writeback using the wrong disk_bytenr.

So at least we need to skip the hole ranges for subpage.
And thankfully the remaining two cases are impossible for subpage.

Thanks,
Qu

> +		ASSERT(block_start !=3D EXTENT_MAP_INLINE);
> +
>   		/*
>   		 * Note that em_end from extent_map_end() and dirty_range_end from
>   		 * find_next_dirty_byte() are all exclusive
> @@ -1431,22 +1434,6 @@ static noinline_for_stack int __extent_writepage_=
io(struct btrfs_inode *inode,
>   		free_extent_map(em);
>   		em =3D NULL;
>
> -		/*
> -		 * compressed and inline extents are written through other
> -		 * paths in the FS
> -		 */
> -		if (compressed || block_start =3D=3D EXTENT_MAP_HOLE ||
> -		    block_start =3D=3D EXTENT_MAP_INLINE) {
> -			if (compressed)
> -				nr++;
> -			else
> -				btrfs_writepage_endio_finish_ordered(inode,
> -						page, cur, cur + iosize - 1, true);
> -			btrfs_page_clear_dirty(fs_info, page, cur, iosize);
> -			cur +=3D iosize;
> -			continue;
> -		}
> -
>   		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
>   		if (!PageWriteback(page)) {
>   			btrfs_err(inode->root->fs_info,

