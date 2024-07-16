Return-Path: <linux-btrfs+bounces-6496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73857932482
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 12:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A30028339B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB74198E75;
	Tue, 16 Jul 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tdh1MM0y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3C13A416
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127576; cv=none; b=bP2L618uyoT+Dz4rFY1h6PYcH41K+3K/AchqluiM/kTzKqCAQiTJrxd3gWLJjalIi3YKlqG7/e6OELhtB8w42PJWZgPTEJh5Cv1dNWlGVdF+9DMDVTt+5l4+Ef7JQmTpURwuARbXAyqRF0zBe+Zxvv9LeC4Tw9Bkf+v5i5OYgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127576; c=relaxed/simple;
	bh=svXj8AuyCm9hJD22Hc5bqpMP+EaWNGr8iYsy+ZZWXaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mLTIQy+sFplLCz2CZO8A/6ySQz6T84jyg3wjUFPIKXl6WmgHP3BYg9AGAq0VIqcpTccH3fpF1VdkQEhX5PEX+yjthZ7Xe3E4FS4CaECJmF2UxfgWuMq8XtzXyTAM8rJ7/ghOwY9K2hQIq8PkwvCpyyzvKYXYNtTZ9SaqjzB5jXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tdh1MM0y; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721127567; x=1721732367; i=quwenruo.btrfs@gmx.com;
	bh=w4P9tZCJmHaBJD/Oc/xCSMIobFCkLCxS68mBZ0koShM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tdh1MM0yoB0+WuHnMtvyNi8AAOE2SxfKnevdKILGOorFrBNr9z+BOlKS8qia8RJU
	 Q66+i6qoUtTC5ALnP4Z9bIQ7gp8s7ydnqloi4non4ognNpbXeJ12yAcvvqzb8NAkM
	 SiALLiOsips2nF8aSdog71vqBCQ+KB0Q7h7zUtXYXNcCSS5nQuue0Xe3VrrI9Tgwv
	 21FuB7bglaOBfxnHpMfzwwaXKlbuPsziRKvv5SOGstdNoExtYwWhMeA/a0EOhlRrD
	 B1/IGleEtZ6ShzMndtK2hp7AQFIcptINv7bnPZzx95B1KRcfpm+9CjZYFJ6Tcv4WE
	 WbpdhCrg+NGB5pqfGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsnF-1smatX1BTZ-00TUBO; Tue, 16
 Jul 2024 12:59:26 +0200
Message-ID: <e3161618-5e9f-477c-9708-3428136d1fce@gmx.com>
Date: Tue, 16 Jul 2024 20:29:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix corrupt read due to bad offset of a compressed
 extent map
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <7e186f2d4892bf5bfa1a66dd859a38c981acf8ab.1721124786.git.fdmanana@suse.com>
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
In-Reply-To: <7e186f2d4892bf5bfa1a66dd859a38c981acf8ab.1721124786.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:csDW9GRZodun9n6T+iexf0c2cw10tuRlETSkX1sT3Gk2UOEV1eO
 BRp6yO3hBHFna/2mCjtwjjQanMlOo/wpildBGDzi2NiasxJLRKowV2xUdJufvVnQY9VZVHt
 OFUx1d826wFTzUWHDaWpbyFq0VZNPlAQ8HWeMCMbj26wfl1SvIJ7fhedSnUTl+tCy/zSmsP
 4W5LOIRzQZ9TKm9+mVjOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:if7My3gbW9w=;sj7CHEcSyxCKGmA+wPa+fO3oRiG
 /uKMfV99jx3jBNFMpTseFztDJIszQiob9cENtmIE31zjpPj8Ipc1EvJG2ljgLvQPdajciml3Q
 JlrGucSkPEuUUu0DFUxkvKdMqShV/CMyW5Ed0TEDGQ+Qlg5wVjAUAk6Ghu6ZAQWXmBwxMP+id
 kigJYgYz2fJE5uZqsVuU7pRbol0OsCWXguXPyxMt+QIUpyfch6/jGcUQN1sipoqaKJMgl8hod
 Aj6A6fRsBlzNzN5XsgOXW9pVa2DrYd6dQlVkmBA51nvkoY9WLIU8Q1FkHwE4BCgHx0dxUt3J2
 xVgNhp58GyQSrBR+qqCSDzfbz0tOE3U8cRx77tqQ4ZC8ztVLSUB10+4thaLH6V8z277x3lz1j
 Hcypf8LLfcVrsh36da/CCwouxsdkZ68SdV8yVI1v5uJF0n6LFhxfaHElGIGS38S2vrfOU0300
 zGX3oN8uny4dCbZkozBveBOtgZ+PU50/e4eZv6ZpJ7jZu3azU692ffCAs/vtNo/6Z4BI8m+oE
 FQHLHDAI9ex8woFDoQwOKIddHgz0T4A4rjFl+L/H4PVhJjy5/6BAXjUE92wDpEcSMaFXZIgbM
 m7GaSZ4GeaTZw72it1LSHqBQSwg/zlnQ/ImuHcD+z/3G2K7PiiOQeiNgZSHgp/qau//ix+TEZ
 qEaoeUblC8Dcc45+tRLOqPPvJYVzthxBQvdWW+9DCG2Y+zsU+omGirgRbcgMb4+cz/UQIGw/j
 Y+KOM04yBxJiybZKqCsRXWE2H90k4Z/pzRpSOU4xG8cMC7eDmw00YQglONm1Y5/Nz+lBnYsb1
 xZO4LN9VHLFZslJmU9QfFPng==



=E5=9C=A8 2024/7/16 19:44, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> If we attempt to insert a compressed extent map that has a range that
> overlaps another extent map we have in the inode's extent map tree, we
> can end up with an incorrect offset after adjusting the new extent map a=
t
> merge_extent_mapping() because we don't update the extent map's offset.
>
> For example consider the following scenario:
>
> 1) We have a file extent item for a compressed extent covering the file
>     range [108K, 144K) and currently there's no corresponding extent map
>     in the inode's extent map tree;
>
> 2) The inode's size is 141K;
>
> 3) We have an encoded write (compressed) into the file range [120K, 128K=
),
>     which overlaps the existing file extent item. The encoded write crea=
tes
>     a matching extent map, add's it to the inode's extent map tree and
>     creates an ordered extent for it.
>
>     Note that the corresponding file extent item is added to the subvolu=
me
>     tree only when the ordered extent completes (when executing
>     btrfs_finish_one_ordered());
>
> 4) We have a write into the file range [160K, 164K[.
>
>     This writes increases the i_size of the file, and there's a hole
>     between the current i_size (141K) and the start offset of this write=
,
>     and since the old i_size is in the middle of the block [140K, 144K),
>     we have to write zeroes to the range [141K, 144K) (3072 bytes) and
>     therefore dirty that page.
>
>     We then call btrfs_set_extent_delalloc() with a start offset of 140K=
.
>     We then end up at btrfs_find_new_delalloc_bytes() which will call
>     btrfs_get_extent() for the range [140K, 144K);
>
> 5) The btrfs_get_extent() doesn't find any extent map in the inode's
>     extent map tree covering the range [140K, 144K), so it searches the
>     subvolume tree for any file extent items covering that range.
>
>     There it finds the file extent item for the range [108K, 144K),
>     creates a compressed extent map for that range and then calls
>     btrfs_add_extent_mapping() with that extent map and passes the
>     range [140K, 144K) via the "start" and "len" parameters;
>
> 6) The call to add_extent_mapping() done by btrfs_add_extent_mapping()
>     fails with -EEXIST because there's an extent map, created at step 2
>     for the [120K, 128K) range, that covers that overlaps with the range
>     of the given extent map ([108K, 144K)).
>
>     Then it does a lookup for extent map from step 2 add calls
>     merge_extent_mapping() to adjust the input extent map ([108K, 144K))=
.
>     That adjust the extent map to a start offset of 128K and a length
>     of 16K (starting just after the extent map from step 2), but it does
>     not update the offset field of the extent map, leaving it with a val=
ue
>     of zero instead of updating to a value of 20K (128K - 108K =3D 20K).
>
>     As a result any read for the range [128K, 144K) can return
>     incorrect data since we read from a wrong section of the extent (unl=
ess
>     both the correct and incorrect ranges happen to have the same data).
>
> So fix this by changing merge_extent_mapping() to update the extent map'=
s
> offset even if it's compressed. Also add a test case to the self tests.
>
> A test case for fstests that triggered this problem using send/receive
> with compressed writes will be added soon.
>
> Fixes: 3d2ac9922465 ("btrfs: introduce new members for extent_map")

Reviewed-by: Qu Wenruo <wqu@suse.com>


> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/extent_map.c             |  2 +-
>   fs/btrfs/tests/extent-map-tests.c | 99 +++++++++++++++++++++++++++++++
>   2 files changed, 100 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index bacb76952fc4..f85f0172b58b 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -664,7 +664,7 @@ static noinline int merge_extent_mapping(struct btrf=
s_inode *inode,
>   	start_diff =3D start - em->start;
>   	em->start =3D start;
>   	em->len =3D end - start;
> -	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE && !extent_map_is_compresse=
d(em))
> +	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
>   		em->offset +=3D start_diff;

However I'm not sure if the fixes tag is correct.

The fix is changing the condition so that even for compressed extents we
can properly update the offset

However the condition line is not from that commit.
The condition is there way before the change, just the em member cleanup
touched that line by removing the tailing '{' since eventually there is
only one line.

So it looks like the problem exists way before that fixes tag.

Thanks,
Qu

>   	return add_extent_mapping(inode, em, 0);
>   }
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-m=
ap-tests.c
> index ebec4ab361b8..e4d019c8e8b9 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -900,6 +900,102 @@ static int test_case_7(struct btrfs_fs_info *fs_in=
fo, struct btrfs_inode *inode)
>   	return ret;
>   }
>
> +/*
> + * Test a regression for compressed extent map adjustment when we attem=
pt to
> + * add an extent map that is partially ovarlapped by another existing e=
xtent
> + * map. The resulting extent map offset was left unchanged despite havi=
ng
> + * incremented its start offset.
> + */
> +static int test_case_8(struct btrfs_fs_info *fs_info, struct btrfs_inod=
e *inode)
> +{
> +	struct extent_map_tree *em_tree =3D &inode->extent_tree;
> +	struct extent_map *em;
> +	int ret;
> +	int ret2;
> +
> +	em =3D alloc_extent_map();
> +	if (!em) {
> +		test_std_err(TEST_ALLOC_EXTENT_MAP);
> +		return -ENOMEM;
> +	}
> +
> +	/* Compressed extent for the file range [120K, 128K). */
> +	em->start =3D SZ_1K * 120;
> +	em->len =3D SZ_8K;
> +	em->disk_num_bytes =3D SZ_4K;
> +	em->ram_bytes =3D SZ_8K;
> +	em->flags |=3D EXTENT_FLAG_COMPRESS_ZLIB;
> +	write_lock(&em_tree->lock);
> +	ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
> +	write_unlock(&em_tree->lock);
> +	free_extent_map(em);
> +	if (ret < 0) {
> +		test_err("couldn't add extent map for range [120K, 128K)");
> +		goto out;
> +	}
> +
> +	em =3D alloc_extent_map();
> +	if (!em) {
> +		test_std_err(TEST_ALLOC_EXTENT_MAP);
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Compressed extent for the file range [108K, 144K), which overlaps
> +	 * with the [120K, 128K) we previously inserted.
> +	 */
> +	em->start =3D SZ_1K * 108;
> +	em->len =3D SZ_1K * 36;
> +	em->disk_num_bytes =3D SZ_4K;
> +	em->ram_bytes =3D SZ_1K * 36;
> +	em->flags |=3D EXTENT_FLAG_COMPRESS_ZLIB;
> +
> +	/*
> +	 * Try to add the extent map but with a search range of [140K, 144K),
> +	 * this should succeed and adjust the extent map to the range
> +	 * [128K, 144K), with a length of 16K and an offset of 20K.
> +	 *
> +	 * This simulates a scenario where in the subvolume tree of an inode w=
e
> +	 * have a compressed file extent item for the range [108K, 144K) and w=
e
> +	 * have an overlapping compressed extent map for the range [120K, 128K=
),
> +	 * which was created by an encoded write, but its ordered extent was n=
ot
> +	 * yet completed, so the subvolume tree doesn't have yet the file exte=
nt
> +	 * item for that range - we only have the extent map in the inode's
> +	 * extent map tree.
> +	 */
> +	write_lock(&em_tree->lock);
> +	ret =3D btrfs_add_extent_mapping(inode, &em, SZ_1K * 140, SZ_4K);
> +	write_unlock(&em_tree->lock);
> +	free_extent_map(em);
> +	if (ret < 0) {
> +		test_err("couldn't add extent map for range [108K, 144K)");
> +		goto out;
> +	}
> +
> +	if (em->start !=3D SZ_128K) {
> +		test_err("unexpected extent map start %llu (should be 128K)", em->sta=
rt);
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +	if (em->len !=3D SZ_16K) {
> +		test_err("unexpected extent map length %llu (should be 16K)", em->len=
);
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +	if (em->offset !=3D SZ_1K * 20) {
> +		test_err("unexpected extent map offset %llu (should be 20K)", em->off=
set);
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +out:
> +	ret2 =3D free_extent_map_tree(inode);
> +	if (ret =3D=3D 0)
> +		ret =3D ret2;
> +
> +	return ret;
> +}
> +
>   struct rmap_test_vector {
>   	u64 raid_type;
>   	u64 physical_start;
> @@ -1076,6 +1172,9 @@ int btrfs_test_extent_map(void)
>   	if (ret)
>   		goto out;
>   	ret =3D test_case_7(fs_info, BTRFS_I(inode));
> +	if (ret)
> +		goto out;
> +	ret =3D test_case_8(fs_info, BTRFS_I(inode));
>   	if (ret)
>   		goto out;
>

