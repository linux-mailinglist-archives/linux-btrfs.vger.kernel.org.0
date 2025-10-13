Return-Path: <linux-btrfs+bounces-17736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2723BD6478
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 22:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2D218A337D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D6B30ACF4;
	Mon, 13 Oct 2025 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DV2iLNjK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233392FAC09
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388724; cv=none; b=tJNlo/YkKI969zOh9ne8d6m7zHx9u7NmVTh4A7LGuGeryWBMP3rbMEG/as46/6vELySkSsNI2WwmUMl/ki4ChwmcwMZTMcLXVuHMbhU2RMOuYYeSiV7PhMHbfWeS9rIRoA8cwYzO07V43TtW9v6XS3MCGfSTwkrgPzT0rt3s2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388724; c=relaxed/simple;
	bh=F+mLNLJbGopP7o2nP9mW1AAE9j19L+mMi60N6x7S/S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k7fOESSutvi+GXi+f5xKQ2rliotqh3/WC49EkWBfPRogutf4MjX192MYB01TkvGaAu3CQS3bo/ilm1DuecZFts+NfANggc65cYqSLyVg1wPUexzwEbxOrE2M2++Ia7alLsgiL6IVPYj0JeYL/b3neH2agVZCuV2gBfb8yX6RZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DV2iLNjK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760388715; x=1760993515; i=quwenruo.btrfs@gmx.com;
	bh=NDM6xgC/p0jaM2/NIbiZBOnLBl2kxnd4aOjDBNTKeWk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DV2iLNjKra72ZXPSJx+7Pg8h6YWpKilWZ/bFLANKm0UFrXIF+1YN5MXyyJVohGOs
	 /MTu/yCJkTl/AFfwsmcZUDd93l1lraLuHgUZrE868FhURoux/mMDARw5SHoE+4OFo
	 mT26pVVQ2nV3Y5+/Rd1rHLzcgkdY69deEScITnP4ETmyeN3E9BM4LDQ7IMGpWSCA2
	 59cnBdJg7j3GJfBq40Xwytxjlu/cdSZ/sdSjZzm0hgopvlgN2Hmbfzaoi7JrN6uLr
	 qsWyx2/kmjVzQ6OlMCVur0ACnO+EBlOFfou5oXFWp2udRNVtmc896KdVfVAHpRoMH
	 3DCQN+Gwmr+L7IOsnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0G1n-1uLGmb0KV5-011sf7; Mon, 13
 Oct 2025 22:51:54 +0200
Message-ID: <ed4d2d1f-942c-418c-9b88-6a8d72ad6e29@gmx.com>
Date: Tue, 14 Oct 2025 07:21:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] btrfs: use variable for end offset in
 extent_writepage_io()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760356778.git.fdmanana@suse.com>
 <6b9b4740fe8b138175b0e0e0b36408a93338c9cc.1760356778.git.fdmanana@suse.com>
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
In-Reply-To: <6b9b4740fe8b138175b0e0e0b36408a93338c9cc.1760356778.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TaZ0VfVRWSSbomDHLQKHHTt7BhegEVa9hrPLCtmNbhelDoqsxEU
 H0rE8Y7g03aU0VEr6UxKg+VSBLt49hfxL5P56A9GN5Xw5DV1QqAFYtBg1BjQFJYjAh6NtO/
 3pDxAPLbL6QjEAaLOvW+uE7ElBe4iyXPBZtcYtmBTlOQIlqliYRwwUV5sz9DGpYfor8dS2C
 Yjm108noaJ655C/Dfjg9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nOo6VthD2j0=;0SZKtBQnAoMwCAsY+C3N+QwQ8Or
 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



=E5=9C=A8 2025/10/13 22:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Instead of repeating the expression "start + len" multiple times, store =
it
> in a variable and use it where needed.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 67706c1efa88..c641eb50d0ee 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1690,6 +1690,7 @@ static noinline_for_stack int extent_writepage_io(=
struct btrfs_inode *inode,
>   	unsigned long range_bitmap =3D 0;
>   	bool submitted_io =3D false;
>   	int found_error =3D 0;
> +	const u64 end =3D start + len;
>   	const u64 folio_start =3D folio_pos(folio);
>   	const u64 folio_end =3D folio_start + folio_size(folio);
>   	const unsigned int blocks_per_folio =3D btrfs_blocks_per_folio(fs_inf=
o, folio);
> @@ -1697,7 +1698,7 @@ static noinline_for_stack int extent_writepage_io(=
struct btrfs_inode *inode,
>   	int bit;
>   	int ret =3D 0;
>  =20
> -	ASSERT(start >=3D folio_start && start + len <=3D folio_end);
> +	ASSERT(start >=3D folio_start && end <=3D folio_end);
>  =20
>   	ret =3D btrfs_writepage_cow_fixup(folio);
>   	if (ret =3D=3D -EAGAIN) {
> @@ -1713,7 +1714,7 @@ static noinline_for_stack int extent_writepage_io(=
struct btrfs_inode *inode,
>   		return ret;
>   	}
>  =20
> -	for (cur =3D start; cur < start + len; cur +=3D fs_info->sectorsize)
> +	for (cur =3D start; cur < end; cur +=3D fs_info->sectorsize)
>   		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitm=
ap);
>   	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range=
_bitmap,
>   		   blocks_per_folio);
> @@ -1742,7 +1743,7 @@ static noinline_for_stack int extent_writepage_io(=
struct btrfs_inode *inode,
>   			btrfs_put_ordered_extent(ordered);
>  =20
>   			btrfs_mark_ordered_io_finished(inode, folio, cur,
> -						       start + len - cur, true);
> +						       end - cur, true);
>   			/*
>   			 * This range is beyond i_size, thus we don't need to
>   			 * bother writing back.
> @@ -1751,8 +1752,7 @@ static noinline_for_stack int extent_writepage_io(=
struct btrfs_inode *inode,
>   			 * writeback the sectors with subpage dirty bits,
>   			 * causing writeback without ordered extent.
>   			 */
> -			btrfs_folio_clear_dirty(fs_info, folio, cur,
> -						start + len - cur);
> +			btrfs_folio_clear_dirty(fs_info, folio, cur, end - cur);
>   			break;
>   		}
>   		ret =3D submit_one_sector(inode, folio, cur, bio_ctrl, i_size);


