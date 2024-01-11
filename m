Return-Path: <linux-btrfs+bounces-1387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9200482A7F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 08:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E1CB21DFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 07:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FEE5663;
	Thu, 11 Jan 2024 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hNZAyrvg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F946B1
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704956461; x=1705561261; i=quwenruo.btrfs@gmx.com;
	bh=qbIJcHrPe3DzBAioboLroXrXlmQviyY7KBBosZSpW00=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=hNZAyrvgUzTIlP6eQFxTerl+Wov9wTBisqzOZdLZIneMwb2S5bgcIBsCwhBJ7Bgi
	 AIeXvfeNFervIeI8um9KM0T7KdL18C7TCIoh6pL0rPOcC+oLKl5iqaprAoOyQGDjc
	 c+wcxKK5g3qlazdiqQMs6Znb80X15AYji/1zcLBakFAPhMF0M+XARq0V7AjtIUzep
	 POEe0I1eDzPbPdXMBxddPRHcZcvp+ZIfgTWxCZ46zKBGdUXL+bimtYxEPrRN/8ckI
	 rpCWDXDYI63HFQ8Ty/6rtpd78X+CxxJoFm87pR9XSmQ2ptvkL7mQVSlXn4Cwz1Yqd
	 5kfqBxvBMgUshCAGfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.153.88] ([49.178.149.31]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmGP-1rd1cr2tdB-00KD2o; Thu, 11
 Jan 2024 08:01:01 +0100
Message-ID: <bcd3e007-a9f3-4d9a-a28a-cec0452133b7@gmx.com>
Date: Thu, 11 Jan 2024 17:30:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't unconditionally call folio_start_writeback
 in subpage
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cd8e40a516d86d1c58a221fa8d964a04bc226891.1704924693.git.josef@toxicpanda.com>
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
In-Reply-To: <cd8e40a516d86d1c58a221fa8d964a04bc226891.1704924693.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JRoGAqNYHO1JZ3+Fl0m+992yQDb+VtDSirtfIr+DRnV400i9Xct
 ItKDTY/W/hxqQk/v+14sSUbUFDivZaKGaieoX/LMq7HJ23C1k1RR87K5wnXbGHO9lHNKUZd
 +yxXmd9Q3ddFUJzZJjP8GDqLx0F2D9RlsXzCvV0NbLVprd2WqyKYwGvlK8IxLDha0GoryBk
 K8CulpAKlqowVjWN59ndQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l7PL5ipPdsE=;CsRc+8Ljy3isGzdZHl0mio8d0rc
 WOLhqTWPsdHtkF73r1opSwlpJEt1zDCZ7FqW7YlIhg4sPOaqOfrp0u7yP63bvqS8nQzuYsSU3
 smmdJxjtGbskFvr8iKETYJAeMWu1fvUw6wexzwC/kw1Dj7MwX/bqjMqxIzgTau3QTu7e8BUiz
 CNUhHzFaeqM/CvufvYPnkV/g2dr+HjjcHwEkmL1IvAq/4c8bQJ+4q/PH61aU+zu3e7MA8oeJW
 R75jFZOy/Oz3EOZIkMKDjUcxmgSwquG0P2EZ4tCumWsPQ1eMppr4b13cQ1eDbMyyS/qcA1+Ec
 5lfq5L+OiwpvYYR0hbJDSrEhl7oHEd7sj5fLszoqAe4NcLLJz0HLHxzatkCtV4kGidn9pOOOT
 fnFASAZQBGHDrAhhayY+qWnmSK1w4FMcLhjNqKQGsJ8TTgkLHLcRjAsL/Tw5hY54WO75TFdtL
 OcDOCZub63D15fvpp4Zfu8KGRJzhCXjbFKaoJHY+GnfkRSL7lNt5I74Ve7ltWbLo+JblfEYFz
 mcDQ9FPcZlOIbCLjU+atZf59ZE6CRGfs58T6KvKqj/7YteEsQUefCmEFrCUfzpEZEZL8G64H6
 S4AVw9ybZGVFnM/Iz10p8DuMYDG78oQuFWqW5wj7le80Q/fPyBUjZlRaQs8EHU8oH/kHFTs/7
 N2c0oZJKRkiPrfgLqRbKHcsxQ1MgZF3/U76aW2tfoNpEINQZbF6QgQMPgFtrYSgofvI6RRr/M
 R2IwYooq9HyV0KSPbRsX9acM6az1rI8CLJKCkiI7s/3IYzXRyqB4+4jasirK+PiulNbeealTm
 p/kS4rczQsHSHKP5F3r7X3Pq9eBX0N2MNaX8ofaisEMkEZaCleoFLUu+OgEwdU7xmWud65XQN
 XG7PwlUCGbS7HENuf1GQI9C2SQV/qqDgTeft6CjDNICs11zZoEeV7241DLwVFrDwmgneqsmJl
 i2dLy0SCO7GtyUVcgrzOATBTiqM=



On 2024/1/11 08:44, Josef Bacik wrote:
> In the normal case we check if a page is under writeback and skip it
> before we attempt to begin writeback.
>
> The exception is subpage metadata writes, where we know we don't have an
> eb under writeback and we're doing it one eb at a time.  Since
> b5612c368648 ("mm: return void from folio_start_writeback() and related
> functions") we now will BUG_ON() if we call folio_start_writeback()
> on a folio that's already under writeback.  Previously
> folio_start_writeback() would bail if writeback was already started.
>
> Fix this in the subpage code by checking if we have writeback set and
> skipping it if we do.  This fixes the panic we were seeing on subpage.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Initially I thought my subpage code screwed up again, but turns out it's
MM layer behavior change.

Thanks,
Qu

> ---
>   fs/btrfs/subpage.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 93511d54abf8..0e49dab8dad2 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -475,7 +475,8 @@ void btrfs_subpage_set_writeback(const struct btrfs_=
fs_info *fs_info,
>
>   	spin_lock_irqsave(&subpage->lock, flags);
>   	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bi=
ts);
> -	folio_start_writeback(folio);
> +	if (!folio_test_writeback(folio))
> +		folio_start_writeback(folio);
>   	spin_unlock_irqrestore(&subpage->lock, flags);
>   }
>

