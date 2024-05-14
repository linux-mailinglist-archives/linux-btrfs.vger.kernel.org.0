Return-Path: <linux-btrfs+bounces-4997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0198C5DA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 00:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86257B219AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 22:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18322181D10;
	Tue, 14 May 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="j3CJ+xHJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31F181CE9
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725393; cv=none; b=IlhKxj2m0tcvtZEWN3iWSBVFyxx8ylV1J3lvHVtjM7MrmMt1hc5PHTdnPqeeqOrZNP8BIsUZ65ZOFuxWO3cRrg6Mv2AT0IHu7BBZMw5mLcxXwH4MKL6RiJVTM4uC9QM2D8TSRAgg6zqyaoXrXWMfdxFylK0XxPkJYZmDmjSqTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725393; c=relaxed/simple;
	bh=ljJwIALoi8GtPJoNY7hd1bkWjqKNORRuOjdXXVaByQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hjiqjfEIAA0kSDp48Uw8/6di2FyapncU32IisehsFuEcjJd841ADObnYHHLnuSSnq/bJE6ouq4wqFVGEvU0rs+ZZOOM8RrrD3HWoRnq0WjXuDsBq+MiSLTEWri7ehiR/RdN6q1fyH1U1Eb6pXRrTWrbbS3d2qATfR3xanMfdH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=j3CJ+xHJ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715725384; x=1716330184; i=quwenruo.btrfs@gmx.com;
	bh=mR612Ig75aDYN/JNyJNOeUFrr8r9KqG6REMpDNe0oHY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=j3CJ+xHJFsv3i60OUcXbmCzhxESaGNkyeQn9OoK2ablEgvZ11kkGyOYq+HrdfqFA
	 ZkBPjkrbTDMq4n61iV8glOKHiOhjuE3XuOS7dLVilT/6Yn7Wxlohf7VOzlHxesQIS
	 ShDjbMNwClIyZYW4fkj7mXZBPZoYEdFiucca+IpTZEdsx1XTbshe9Lp5RLT2z0Syp
	 miRgIc6+b2ylkHS0jpOcJIWxVozFq9YZZ47pM4/hrliHdTKB/coV9OK3WFIN6umaj
	 CW7GI3LadEnbGvf6emPcFlYt7j2ca0dsvSJEU5ciqZQUiMGRIDgJ6zuW672Nd+lZa
	 DfbEjPYGP6MDnGerlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Qr-1sfFMy3rFb-00dYqx; Wed, 15
 May 2024 00:23:04 +0200
Message-ID: <ff4c67c5-0163-4641-82c1-1ac36efdd9d7@gmx.com>
Date: Wed, 15 May 2024 07:53:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: refactor btrfs_dio_submit_io() for less
 nesting and indentation
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715688057.git.fdmanana@suse.com>
 <69a34ba773dd14f59b6220587029a09dbba3e104.1715688057.git.fdmanana@suse.com>
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
In-Reply-To: <69a34ba773dd14f59b6220587029a09dbba3e104.1715688057.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fktLTItuv92qQPXbVGbUXJDVwOcCPBo2N1/3mF/bZT7o4UYIs/G
 wzVVSwGJRmBVAWm5OH3JuYTlB+liodE1tP86mvV6IUn6zrgjmzOUy+heBrWuRNWl0gcKNHe
 WVoHJ02HnsnLXiWso5o1CB6EG4iISlDYWlkI/69RHWaHDBFvDy9+2i2iHEawZNVO9mC7FVh
 /upqC66s0bqZR3c0YSv3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mR7++io8mp0=;kjlrvSLJSGX0ASKJXEmajqYh5U/
 ygLJLRLI5fgNx97HUcveDJS1M43X5xx46La2r/8jrHPCNtMeKb2dWrDRZU5WHjtvAiTo++Kj7
 FBDjJHP1cIFkmb39SA6whhGxa+OtE9XjtLLEMiaLzk2PKUDl50HCofT8ceZnhYmkB8s7hSgeH
 oi2D5heSwtQy7CtGz3VteLXLgX3v5vuAcVyC89pFq2TuBtdXxGT0BPHJPqUxQmp6ZImuWuwsD
 lO6cUjizLy4Q4JixF85AnDQ9jfVBrnETWVRTnIRdvBxZJpcugZnsoh0VRBETnhaUfw1D+OyzV
 ZKXBui1k5igsNjaKcO9DwhIxsE1XxZf+wJsl+bPmTCfD3jP2N765jkGjQ9JsSgpBz98hr1AS6
 UxpwAmEPAOvRzhfg5v0mIKnIH1GlpQq7clBepJyx/0v+O07ohakJRwQdPX71p2YfnVQsdRHg7
 LIziRAr2IFhI09zI18IKc1BsppXeTCUR+sjrGCSsc4Br1/rLeBZg3kuynffjzY9PPGqDUOPWM
 CMr98JRc9MoyFza7ix2uewYOtY/HMnYXnhIZzeEiQt134vX7ixY4nVXQrgD9MR/+bjzk7Act0
 v+7VgrhKJchxNeWZakrugmorCXRmpqR0ECqBMjCTLWcDjbGJkXuNrQQYJH/RW28eo3c15tBQt
 a0PZlbvKzxLlE6eCoLKUDqUoKgn/B+A+NlT0DOvwzgEcAYAbw5//6GAZupKRWG6A3Lj4MU9gR
 Xrvz4VVMDHzg/hn1bPPcI1o7B/NNgHFPxx9ROVMm9jf6ZFU/j6ij5uq9wIgH3769ewYp6w2P9
 UkaZaPfFSYptpixjaILcIV/ys0qf6CXHVXBOqSi8k6Gok=



=E5=9C=A8 2024/5/14 23:53, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Refactor btrfs_dio_submit_io() to avoid so much nesting and the need to
> split long lines, making it a bit easier to read.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 52 +++++++++++++++++++++++-------------------------
>   1 file changed, 25 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f04852e44123..c7f0239c3b68 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7869,6 +7869,8 @@ static void btrfs_dio_submit_io(const struct iomap=
_iter *iter, struct bio *bio,
>   	struct btrfs_dio_private *dip =3D
>   		container_of(bbio, struct btrfs_dio_private, bbio);
>   	struct btrfs_dio_data *dio_data =3D iter->private;
> +	struct btrfs_ordered_extent *oe =3D dio_data->ordered;
> +	int ret;
>
>   	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
>   		       btrfs_dio_end_io, bio->bi_private);
> @@ -7880,6 +7882,8 @@ static void btrfs_dio_submit_io(const struct iomap=
_iter *iter, struct bio *bio,
>
>   	dio_data->submitted +=3D bio->bi_iter.bi_size;
>
> +	if (!(iter->flags & IOMAP_WRITE))
> +		goto submit_bio;
>   	/*
>   	 * Check if we are doing a partial write.  If we are, we need to spli=
t
>   	 * the ordered extent to match the submitted bio.  Hang on to the
> @@ -7887,37 +7891,31 @@ static void btrfs_dio_submit_io(const struct iom=
ap_iter *iter, struct bio *bio,
>   	 * cancelled in iomap_end to avoid a deadlock wherein faulting the
>   	 * remaining pages is blocked on the outstanding ordered extent.
>   	 */
> -	if (iter->flags & IOMAP_WRITE) {
> -		struct btrfs_ordered_extent *oe =3D dio_data->ordered;
> -		int ret;
> -
> -		ret =3D btrfs_extract_ordered_extent(bbio, oe);
> -		if (ret) {
> -			/*
> -			 * If this is a COW write it means we created new extent
> -			 * maps for the range and they point to an unwritten
> -			 * location since we got an error and we don't submit
> -			 * a bio. We must drop any extent maps within the range,
> -			 * otherwise a fast fsync would log them and after a
> -			 * crash and log replay we would have file extent items
> -			 * that point to unwritten locations (garbage).
> -			 */
> -			if (!test_bit(BTRFS_ORDERED_NOCOW, &oe->flags)) {
> -				const u64 start =3D oe->file_offset;
> -				const u64 end =3D start + oe->num_bytes - 1;
> +	ret =3D btrfs_extract_ordered_extent(bbio, oe);
> +	if (!ret)
> +		goto submit_bio;
>
> -				btrfs_drop_extent_map_range(bbio->inode, start, end, false);
> -			}
> +	/*
> +	 * If this is a COW write it means we created new extent maps for the
> +	 * range and they point to an unwritten location since we got an error
> +	 * and we don't submit a bio. We must drop any extent maps within the
> +	 * range, otherwise a fast fsync would log them and after a crash and
> +	 * log replay we would have file extent items that point to unwritten
> +	 * locations (garbage).
> +	 */
> +	if (!test_bit(BTRFS_ORDERED_NOCOW, &oe->flags)) {
> +		const u64 start =3D oe->file_offset;
> +		const u64 end =3D start + oe->num_bytes - 1;
>
> -			btrfs_finish_ordered_extent(oe, NULL,
> -						    file_offset, dip->bytes,
> -						    !ret);
> -			bio->bi_status =3D errno_to_blk_status(ret);
> -			iomap_dio_bio_end_io(bio);
> -			return;
> -		}
> +		btrfs_drop_extent_map_range(bbio->inode, start, end, false);
>   	}
>
> +	btrfs_finish_ordered_extent(oe, NULL, file_offset, dip->bytes, false);
> +	bio->bi_status =3D errno_to_blk_status(ret);
> +	iomap_dio_bio_end_io(bio);
> +	return;
> +
> +submit_bio:
>   	btrfs_submit_bio(bbio, 0);
>   }
>

