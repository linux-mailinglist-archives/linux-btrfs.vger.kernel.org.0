Return-Path: <linux-btrfs+bounces-12930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE2A833FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 00:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EF487ADD30
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 22:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B0B219A9B;
	Wed,  9 Apr 2025 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GJ6Ba7AA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAED213E81
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236843; cv=none; b=T0h+bV6/gVbAA3WVjuQdVk6bRUusc9ct26FL2bYfzR592ENC4E2YKGqKI4irRRg2UlAoa14BpcNgR+6RGX7IsuoD15hpsb6Rt5bCJnm1DcRDmTtBMk0oZ/xfKzUDLH5+DlbAtR5GwjMLHd3mCpL8G9STYI9HxHqHh/qXxwYWbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236843; c=relaxed/simple;
	bh=DyQeWAU++DCXtwGl531M/VBEqwG2UDkeVulJcyOaB7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDEukk9daulgczMdhlL3JY7E5lUwMH9HtH2DYYXO9cod4L+ImxJfZTwPchkhh/T/FlbOYvBhclGjSs/XDf0C8zowKjGgYJUDaRh4ipzjqwCKNJvCpRg9/JYBRF6OEiezvFC+GcJs88nlYCLHhbhg9uCSDz+IKXvp16YegamhIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GJ6Ba7AA; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744236838; x=1744841638; i=quwenruo.btrfs@gmx.com;
	bh=l8Z1aCwN/JslDOq5JpejZWXbH+N98H3Yy29g5ne895M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GJ6Ba7AABijQlxeVFKFBBlAlH53Ep56Yvs6dOYoELo+/qy1+NRCtF0GOy4Uc/o9U
	 JXztJzsya3KkcsDa8UdmrelmD0egIzxoV1lTm6TqnOijfPWt7qxnODotlCMJpJ4CK
	 J+SY5swqIIukKG96oKlFaR1zrbY88T94WUA1MBOvYUbele2Pk/88J53P5PK1uxzCW
	 3PsmWCMaqdPjFUe4NoS8IDepOX/FrsRSz+HBFcz0yi/UnlxkeCikilCjBGUVTvmEw
	 a1tqg1b2YWX/DwrvhSPvCwbM77uygERzxVoFm+A2TzrhkuytvX4BdqLq12f2tYZEv
	 Grc5dYFxQjjfGnMURA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mplbx-1tHRMG2Rgr-00pyQC; Thu, 10
 Apr 2025 00:13:58 +0200
Message-ID: <d0f52e89-1bd2-4a06-b142-1e18381862b6@gmx.com>
Date: Thu, 10 Apr 2025 07:43:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] btrfs: remove the alignment checks in
 end_bbio_data_read
To: Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-2-hch@lst.de>
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
In-Reply-To: <20250409111055.3640328-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GtggSF55gAKEaPYw8atjT96tY2Eebd3kHthBT7Fhnh6T0cRWgMF
 SC3ldSbqd71Ha0byGT80AbmQWzbGx6wImQGWHfeEO2dZqb0sleOxAvvFhjJ1+U3jmADvzEb
 pxGyZNM/V7lNXEaH1rl1A/FLGBsw76rvjNMtx2553uNgG6R0qxEhqoZwZsWwdGR8ALVex1M
 ATvizlgOPwVOhKfgAP5Vg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:skuXjNi8yac=;vjXgSpj0CwaKpW7h6u0WkMosLhb
 N28teWAdnUUCwUHLDs1119b/xV+/IDQnJqd46Hr3+M5YesMX5LcGoSN0kljbwr1VWPtSVAIqC
 b5aaBKsjDbQviZ5n1Lp5gRj7kRnyQSQw6QHl21r4T24b9YFYP00p+oBDIwtZCwU2FCWfXQS/l
 Yy9vh+azQkQYYxTxNK4vS1NdPKh9Dm+AEYNt0jPthkrjM+fXGvfnQkmh4O2TiSGA5zoDQW59Q
 DyDaZbiaQ5qddMhF1t/0Iv8EiJz16S/ZWAMLVFVe2b3vePquCtYuXh2hLnohHjKtmzJDG4mbL
 JQdsE36e68esVIC+KySKXUP9DRVj+RPqOJ6e5TKq13YMbTDU4dO31zHlQ1q7e5y0gpi8Mkcw9
 Mezhig4ia5n/lc4f03/3vlQyILzODj5rILR8S60b6HwdtO4DL6erhqLABWJ5ICcUxlLMyFukk
 rZ677p/yYTmyBh+mjzQOv5Ogj8d9hchmTBqoAT85n0e0mPVjI1SMFZZjBbIjjNPHDfdT/ugJs
 aWHXcjc/hAt02JIt4HACbR6Dyjn+h8dpbBKwD0rA+nUvfxDTosvR95l+T0uAozAD6UeR22UOE
 SHLXoO3RG0qnhZZvGk4Qg/CIgXU1R3AM8sT2EZMoGp5QA2azS6an3s4pZYie6nz6zYPPOqwAm
 RC/zlEi6StScInk1eZOaYTAU+BqnNPTDERynoz2V1ctX/nzbQZL55DyHHX3IcaW6mKawikaOT
 xVFKVxDLoh18NgH7GBN4dzmZfgvNHESJFccN4WjwA/57sV7i+8mQO82gpmVfLAzFIPXgfO5hW
 LRSdMs2m0OHQwvNlhZ0Er5MM0xpfMZ4pAfrL2maUyNlbblCQ0mGFXWLptlzFUH+H497Ee2wEA
 98Eswb9Sey4sfrYKVFy8vsv4mtnVKCXRGwZP3jjUzE9/+JtealIIPizfzqg6HQT5hCZop0GHU
 Ne159UHes9HBqKUJsPM0bZMdJNaq4ZnPjImkzQaI/x5FhH1orebTd4vyFRmi+f6NzSxxhMUQz
 KxP9SvgLVBP6nPHKDQQOBElP8Rwke4NAeP32qPhJyrhcxlRPNDUSZMqJ4BjIz2xddRChgPd9O
 AOHofQN9qKW80jS8cjZv8bTY8IQ4xht7P2evShXGc/mBdPk1kioXVuM9Jl4/er8B6m8N0KRX2
 VAM7at9IZVW5Hi7+dTsUb7gks7fwXfmN8qkilOquVxyf73PTzUDGMMuzomHuW9w064NhQMYUG
 qtGrEy1eEczDcukWBrmXQOWUJnnYl9S3KvYS+mzXB+Gi+ki4jECC9nCie7NM4J1j9Mhzl3s6o
 Wp9lrMAivKOdzY2JzMMWDQdgFAIMD+4AoMvFo/bOhtsNFIjcP0JLwrDs8NJEW5eRjaWKwDu4c
 KaaEydqBLKJcUHeimZBfi+OvHsHsxRlbpFV/2Tn/DWUD86ssWfPsOpQVgcEJZhTlfriDDw8t4
 wKlDmLw==



=E5=9C=A8 2025/4/9 20:40, Christoph Hellwig =E5=86=99=E9=81=93:
> end_bbio_data_read checks that each iterated folio fragment is aligned
> and justifies that with block drivers advancing the bio.  But block
> driver only advance bi_iter, while end_bbio_data_read uses
> bio_for_each_folio_all to iterate the immutable bi_io_vec array that
> can't be changed by drivers at all.

The old comment indeed is incorrect, but can we still leave an ASSERT()
just in case to case any unaligned submission?

It shouldn't cause anything different for end users, but should greatly
improve the life of quality for developers.

Thanks,
Qu>
> Remove the alignment checking and the misleading comment.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 27 +++------------------------
>   1 file changed, 3 insertions(+), 24 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 197f5e51c474..193736b07a0b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -512,43 +512,22 @@ static void end_bbio_data_read(struct btrfs_bio *b=
bio)
>   	struct btrfs_fs_info *fs_info =3D bbio->fs_info;
>   	struct bio *bio =3D &bbio->bio;
>   	struct folio_iter fi;
> -	const u32 sectorsize =3D fs_info->sectorsize;
>
>   	ASSERT(!bio_flagged(bio, BIO_CLONED));
>   	bio_for_each_folio_all(fi, &bbio->bio) {
>   		bool uptodate =3D !bio->bi_status;
>   		struct folio *folio =3D fi.folio;
>   		struct inode *inode =3D folio->mapping->host;
> -		u64 start;
> -		u64 end;
> -		u32 len;
> +		u64 start =3D folio_pos(folio) + fi.offset;
>
>   		btrfs_debug(fs_info,
>   			"%s: bi_sector=3D%llu, err=3D%d, mirror=3D%u",
>   			__func__, bio->bi_iter.bi_sector, bio->bi_status,
>   			bbio->mirror_num);
>
> -		/*
> -		 * We always issue full-sector reads, but if some block in a
> -		 * folio fails to read, blk_update_request() will advance
> -		 * bv_offset and adjust bv_len to compensate.  Print a warning
> -		 * for unaligned offsets, and an error if they don't add up to
> -		 * a full sector.
> -		 */
> -		if (!IS_ALIGNED(fi.offset, sectorsize))
> -			btrfs_err(fs_info,
> -		"partial page read in btrfs with offset %zu and length %zu",
> -				  fi.offset, fi.length);
> -		else if (!IS_ALIGNED(fi.offset + fi.length, sectorsize))
> -			btrfs_info(fs_info,
> -		"incomplete page read with offset %zu and length %zu",
> -				   fi.offset, fi.length);
> -
> -		start =3D folio_pos(folio) + fi.offset;
> -		end =3D start + fi.length - 1;
> -		len =3D fi.length;
>
>   		if (likely(uptodate)) {
> +			u64 end =3D start + fi.length - 1;
>   			loff_t i_size =3D i_size_read(inode);
>
>   			/*
> @@ -573,7 +552,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbi=
o)
>   		}
>
>   		/* Update page status and unlock. */
> -		end_folio_read(folio, uptodate, start, len);
> +		end_folio_read(folio, uptodate, start, fi.length);
>   	}
>   	bio_put(bio);
>   }


