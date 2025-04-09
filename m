Return-Path: <linux-btrfs+bounces-12931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A95AA83401
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 00:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1B57A93CF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 22:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78268215181;
	Wed,  9 Apr 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kxwjop43"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8A1DFE0A
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236938; cv=none; b=hxNfokzjwReZX6GrkYun/+lg8sWAQyRNMMQFUTYW5cWgFEo8NQfdq4EbRuXYs1rzhAjVibjAiFI+vbLj4bvyff2QnEcXlGEEhe+JAkXFGtASmEvouhLzMqUNqtkWoUIRsP6XVPefhor/Myo5IEpGu+LsfWkfxwqSL29MkyUdpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236938; c=relaxed/simple;
	bh=J+eVvwpzxleyFpok/3XgyvCEM6qBtyuwUajN1e0Rab8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEviwrpyhgjQoewixS0VfVL5T0WCTviBm/uVIIhTGMGEORQ93RyZL5weRUbFjYJuqMDglmafZWQ4VGod2jwkFolSAhiAmJYj+Dl8CDgQpNF7BwHiG2FVpZooMedA5riruBbz90PxQsOup2u2cCrHbbOrYfzn6ZUvnOOmAtK87Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kxwjop43; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744236934; x=1744841734; i=quwenruo.btrfs@gmx.com;
	bh=ENLoMc2UX5cwpAQfgopdQPHh2txK2WD41+BK8yUl/gM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kxwjop43ER2NJ1eqkBG4SyhADzqbZ1FswPXHBeq/rDldbblhbqVxlgesiBJuknZM
	 9OlQICzLyg2AJK7DhdeRhjXt1QcUpGuOpDAOujUigQL1SBP/05L4Pay2ytqJjvgjo
	 EUzIIUr/h5BMMChgnsfc/aqyH1FXN6roaE6rR+G5LlaOxZWm7P1DKYSfpRvYeatuv
	 HhcTm4MCZ0cOFdx04Im3FEmQ60xWlek24WQupyoPIWUIVZC225VtOozzfn9duyEf4
	 rMBDDe14lN9Oq2JEmMMVPuGeXsFPDtBz3cBctxHxv8GFgY/TntwrZvlV/HHR52HOI
	 J4rO/3jbR9jZASfDZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQic-1tsA7f3uYY-00Cg7i; Thu, 10
 Apr 2025 00:15:34 +0200
Message-ID: <abfa0402-44e4-43c7-beda-55a7439bc5f7@gmx.com>
Date: Thu, 10 Apr 2025 07:45:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] btrfs: track the next file offset in struct
 btrfs_bio_ctrl
To: Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-3-hch@lst.de>
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
In-Reply-To: <20250409111055.3640328-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4zCHdQ2cyrjJb5SpesnyWq/UW9EkE7QTxA833RNapofIXUXxaB9
 cnI1us4QXWcfZcBVcVa/nBoSFjySB+jgaNJCCJoTSzlfZs2l0KYG7yZxLw2IqGetdVcbw4x
 OygQBQAoBHwG8IhJSjhrsrpaL8q6VDezlfRd3Vdv58IAuD4RSdRgD2lXxHqPaNZWJ4H7wb6
 bQ5B0bGoUol4ciT/tp+iQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j4XLIaGPOzs=;tijoItExWpbMGaEET74GFr5GQ0s
 iN5e/6McYlkCsAjf4o7GXDRW4Ix/YI3KYcKiIS015eH8xBtqEOc0aNlhGh2tZqeGAsp/sBzlR
 VdW2658eZIXUwzl0wYJPhpYlvgnMsOW9cx/sZPZomzijZcYxBE/pFxAPXQ87wIKlyvd8hW+iC
 lQ3e8ExM1Lxadn8fNeWg0OM3R3WEgHM+7b5FCs6n9RSoYJpkeCq5knjTODZK1z0RNIoAby2Fw
 m+69ZvhXAy+Qxdry2luHcZsmI4Qkp/AUOpYC8FmFIq6gGEsttjaM5E8nuCcav26b1U4C+b2v+
 Usime3oLYGqQnKtlx0zZQIgH4O7fp9+JM0e+7JoiX6LAnb3rRfTHoAT7nME+dpb15ZLLkXiVi
 TZYq8Fag0mfXr4vbIGinX+jdJmsQIhAb1sgFWNOSGXAgkhEFnt9NIvUPJf8bo5jM25eb6GJDI
 jq9sQLlDKaXq6Y9+36453NGulHGI/zzZfNYoFJGytovpsrb1Y6L7MPvmJYQyqZcY2Djg8tKXs
 uz/PYCv1HqKSBTaMUfEZE6jEX0yCcJnFCYvPmmtKdi9LX8RIDNBpK2l7pACow0x1zqNR8s9qk
 g3yyJI+IcyNbmjWZyPBKQnN8ZDH5ytYYX0l4Fvt2gtHDQHNIm+Xi70CCTwgFbhLMutCroW2Ka
 vIocks3ivlw8/fyVYHJa1qJEsNL2wpmjQZhsYMTGGTaqdRwPZzC17ZHiNksEtqRxfGRbCNarD
 X1kCoBxeRS1FFqWFyP0kPFw5edERPUgijH8W0p+T7L5hPKmylmMj6bgnQezHeIVTOGrI2Ix0G
 ObukWF0xBgYHT7xF6cBABmAAr5NzQzQZel9ssnknWph4UiZC6lBMWRlUWCJCTp4WoKOrHNnzO
 xrKgz2bp7TY8Vm8/pVHi/rS7VFgzArcjojUcrogqA+3TulI/1Z/LjLWVCarTxV8w5JId7gysq
 kRjO/fVUCVQCsoVPj29qfoEwot89f4usR5XSpywQgPF8cg61mDCh+ngQF/b4RqtodzJF2Whdy
 w4GJUckxFloNo574yNxXuuSdp3xvpOh39LG0fSya5ZgKUNGYyWuAI2G2dW/nCYYY1A0peVrcW
 +j77TbTywLVksY5uuP1bsuNDU+HhTHLHkGEpMRU/JOI9t0oM2cPWdhyz8/Sm1c3e0hbsy5C7g
 IAMJmfrlEqugYH0XM27mPifj5t+RFBPMNmyYadqvkEPA6Q9/vCy0rjUN+GTeCnLWc+odq5Pcq
 nNxGTkP9Oh2CS6pwmr/JttHuAUfIh1Dbhfo2YxeXvvvBVXw3xkPakMQxYT8hDTebSMylC9Y14
 C+zHo4so9qQeejtoLLZKcpP7oNzXTgcuJXLOqw3Nb53Iji/rNA6FEznh94tBR+wRIxlSvVIVT
 Att85//EY/YhBSuYg98v5zspSJw6teSsc1nf8bzNvNai0QTmdBPc3KkmwURTmmAZtQaGsF6dM
 rB507ow==



=E5=9C=A8 2025/4/9 20:40, Christoph Hellwig =E5=86=99=E9=81=93:
> Stop poking into bio implementation details and recalculating the pos
> from the folio over and over and instead just track then end of the
> current bio in logical file offsets in the btrfs_bio_ctrl.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu> ---
>   fs/btrfs/extent_io.c | 33 +++++++++++++--------------------
>   1 file changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 193736b07a0b..36db23f7a6bb 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -96,6 +96,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs=
_fs_info *fs_info)
>    */
>   struct btrfs_bio_ctrl {
>   	struct btrfs_bio *bbio;
> +	loff_t next_file_offset; /* last byte contained in bbio + 1 */
>   	enum btrfs_compression_type compress_type;
>   	u32 len_to_oe_boundary;
>   	blk_opf_t opf;
> @@ -643,13 +644,10 @@ static int alloc_eb_folio_array(struct extent_buff=
er *eb, bool nofail)
>   }
>
>   static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
> -				struct folio *folio, u64 disk_bytenr,
> -				unsigned int pg_offset)
> +				u64 disk_bytenr, loff_t file_offset)
>   {
>   	struct bio *bio =3D &bio_ctrl->bbio->bio;
> -	struct bio_vec *bvec =3D bio_last_bvec_all(bio);
>   	const sector_t sector =3D disk_bytenr >> SECTOR_SHIFT;
> -	struct folio *bv_folio =3D page_folio(bvec->bv_page);
>
>   	if (bio_ctrl->compress_type !=3D BTRFS_COMPRESS_NONE) {
>   		/*
> @@ -660,19 +658,11 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_c=
trl *bio_ctrl,
>   	}
>
>   	/*
> -	 * The contig check requires the following conditions to be met:
> -	 *
> -	 * 1) The folios are belonging to the same inode
> -	 *    This is implied by the call chain.
> -	 *
> -	 * 2) The range has adjacent logical bytenr
> -	 *
> -	 * 3) The range has adjacent file offset
> -	 *    This is required for the usage of btrfs_bio->file_offset.
> +	 * To merge into a bio both the disk sector and the logical offset in
> +	 * the file need to be contiguous.
>   	 */
> -	return bio_end_sector(bio) =3D=3D sector &&
> -		folio_pos(bv_folio) + bvec->bv_offset + bvec->bv_len =3D=3D
> -		folio_pos(folio) + pg_offset;
> +	return bio_ctrl->next_file_offset =3D=3D file_offset &&
> +		bio_end_sector(bio) =3D=3D sector;
>   }
>
>   static void alloc_new_bio(struct btrfs_inode *inode,
> @@ -690,6 +680,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>   	bbio->file_offset =3D file_offset;
>   	bio_ctrl->bbio =3D bbio;
>   	bio_ctrl->len_to_oe_boundary =3D U32_MAX;
> +	bio_ctrl->next_file_offset =3D file_offset;
>
>   	/* Limit data write bios to the ordered boundary. */
>   	if (bio_ctrl->wbc) {
> @@ -731,12 +722,13 @@ static void submit_extent_folio(struct btrfs_bio_c=
trl *bio_ctrl,
>   			       size_t size, unsigned long pg_offset)
>   {
>   	struct btrfs_inode *inode =3D folio_to_inode(folio);
> +	loff_t file_offset =3D folio_pos(folio) + pg_offset;
>
>   	ASSERT(pg_offset + size <=3D folio_size(folio));
>   	ASSERT(bio_ctrl->end_io_func);
>
>   	if (bio_ctrl->bbio &&
> -	    !btrfs_bio_is_contig(bio_ctrl, folio, disk_bytenr, pg_offset))
> +	    !btrfs_bio_is_contig(bio_ctrl, disk_bytenr, file_offset))
>   		submit_one_bio(bio_ctrl);
>
>   	do {
> @@ -745,7 +737,7 @@ static void submit_extent_folio(struct btrfs_bio_ctr=
l *bio_ctrl,
>   		/* Allocate new bio if needed */
>   		if (!bio_ctrl->bbio) {
>   			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
> -				      folio_pos(folio) + pg_offset);
> +				      file_offset);
>   		}
>
>   		/* Cap to the current ordered extent boundary if there is one. */
> @@ -760,14 +752,15 @@ static void submit_extent_folio(struct btrfs_bio_c=
trl *bio_ctrl,
>   			submit_one_bio(bio_ctrl);
>   			continue;
>   		}
> +		bio_ctrl->next_file_offset +=3D len;
>
>   		if (bio_ctrl->wbc)
> -			wbc_account_cgroup_owner(bio_ctrl->wbc, folio,
> -						 len);
> +			wbc_account_cgroup_owner(bio_ctrl->wbc, folio, len);
>
>   		size -=3D len;
>   		pg_offset +=3D len;
>   		disk_bytenr +=3D len;
> +		file_offset +=3D len;
>
>   		/*
>   		 * len_to_oe_boundary defaults to U32_MAX, which isn't folio or


