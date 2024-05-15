Return-Path: <linux-btrfs+bounces-5030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61718C6E60
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 00:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C601F23306
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 22:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2145015B56A;
	Wed, 15 May 2024 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AoyKcz1x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B143BBEA
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715810610; cv=none; b=Tws5ssMEWFfxhT5Iizbnw0PPziAWby88T2CsT0TUbw94ggdHn9EFXnQA+KHiEM6m5Frz2NCgtqwyCf2zN5DHdB1LhXv1C6GNfCywM5q+Yc12IIMIgtRVDk0TNiLbxaKnBljxHaO4hSvoBqQPsCSYj2YTuF4F3yp+wbwlTiP5yv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715810610; c=relaxed/simple;
	bh=qIGFDcEwGqeUBvBlBS20poiCz77nvnCA3S2LjIVtiYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FH0fUFfc25sdJtPAhgIxMtGNyXWaf3iGY3Pxip3dXb530gGTGKJsGugoRi/aDdS+ehd2IT1MmywcF/KyG3JovGKO0fsu3bZYWALPyZnpfWFFP1fPQTVFx0nCghPHMGG+ORrkkeRD2LF20iFGMiQwGrA1OESGneXDe7XaB0NSGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AoyKcz1x; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715810602; x=1716415402; i=quwenruo.btrfs@gmx.com;
	bh=rZ7T5lQv8MQzxeLdA7f8gCM3qJ6pB9r5cJ+M8amo/9o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AoyKcz1xn0i4kZ1LfFiykJnH8riatCxGxgFnpu4GwpUk/0jYvpwiKI8gjbhWyqN0
	 IeNL6kGmrealc16FgrlxH4yxyO5AwAVOP1BoG5NGF5/LXnj2YBt9GZrqSuNVm+XWE
	 D797iz3QfUYppX5xyHUdihInlsqYxhi0xvsnpADBlG34V/gx4fuKJxFlYsXFzaKjU
	 9NVClanVPH5qo73gPM/RWFYbm+3ydQN8P+uVNPtAZay7xUKORY6+3U/Oj0+d/wuC7
	 4GRRHG7x4fasTTsqxjvywnCZc926uLmm1SbbczPj7NLEbSyH+Mo8Q7C+Nq6TNgCKB
	 TjuRwjO8VWcKjG7/VQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE6F-1rsJu60tIJ-00JN4s; Thu, 16
 May 2024 00:03:21 +0200
Message-ID: <3ee930a1-6aa3-481e-ae4c-80bcbf88d197@gmx.com>
Date: Thu, 16 May 2024 07:33:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: make btrfs_finish_ordered_extent() return
 void
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715798440.git.fdmanana@suse.com>
 <0fc7eb82d2d89b607d663de4fadc031c54aab002.1715798440.git.fdmanana@suse.com>
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
In-Reply-To: <0fc7eb82d2d89b607d663de4fadc031c54aab002.1715798440.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:61QMltJaV779U+IEpvPW+/HnHpWwC2iV+S6m2D/VE1+ez+CzpI4
 yBmKmPR/NpUUBFeYSzR0hK1JNoItIiLjoF+kt+iLeh+lzYvFenncE8xzdMHFqDWLeHrQ4xV
 ll8FU1YI+MkJphCOEiEOBst/pJ9UWrE6J2zlNHSLTWigrTeA/tAiyQRAwJ/CRCltNaOT9aB
 ioiFCIF7LW1ndhfNOw3Gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y49EQ3+z1ho=;HobjhuLgBH4yZn3w8DT6dqK+Nk1
 TbAbJNEl5FqesAdCHgZufNq9LtTCQrraVnY2CEjx4NIBoVjNXGj8soOauFADrm1PJuSQAwpzA
 NnEqQapPatJ01QW5Od6bZ1a1ooPTWf8wWuH0mF3WzXgbczsTvJGZakaC1mYZOQxf9ax0cBclm
 Tvns5seL1s3KRflq7DuTfd4npeFEYbAQbFI6tRSRVF6koKfIYWW2U8QgWCkUSiE8Ff505TzI0
 3gHBV+27OUwgosm5DoXFaj+TWc8rjmx9s9iUQNl+3PH7H3N1ilIlvyBFCA3l8eY98OCQROTDw
 ihOlW6ZEzNCXmvNGHd+gfmWoa+XTnGWMD+ujU/BJc0SXaqydxaXecYqr80bGukfu1Vjqp2A4I
 BOKD2kAkIiYTev3jiT7OkPdhkeAdRKl0dBueuxTUFVDc7E+6elMzngmci/AS2wEKTxON76s0v
 0otiYPmCqhbQH7gPSG0RB0Lo34l/OrVMKQc01Betwfjsr0Y2padW3Ux1XPcEw6EDWraONypMm
 o4oW0NntyNPV5ikDztElqOnqSuDYuHjmX6PJk/5+eZCI3n5uU+RhPj+rVL/lF8NtysUFCmw8Y
 tgjICQniV8r1hZJYncmp+KiXwQeLCvdLP6zh95yKSTjA36242Un7bw+5+5Uv6/j/2l+p1DkIU
 MeTCXUdo5VsAANvURpGepTzGER5NOJk+NBNS1ATvBb1p3P04Bd1Q0xWZrd8JMcSv6qUHxZAcr
 Bx0jeGZ+3L91rM1CHns2gL5I0y6D5IVvS6TkQuZ2jjIJ0DFT+rT8+0ANfBEEtcBV/qprnPXXK
 9pkBaKMPa/5JuCG7UXuorzEpUnszsNFTFYNZnh4IwHj4w=



=E5=9C=A8 2024/5/16 04:21, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently btrfs_finish_ordered_extent() returns a boolean indicating if
> the ordered extent was added to the work queue for completion, but none
> of its callers cares about it, so make it return void.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ordered-data.c | 3 +--
>   fs/btrfs/ordered-data.h | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 3a3f21da6eb7..3766804decb8 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -374,7 +374,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_orde=
red_extent *ordered)
>   	btrfs_queue_work(wq, &ordered->work);
>   }
>
> -bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
> +void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
>   				 struct page *page, u64 file_offset, u64 len,
>   				 bool uptodate)
>   {
> @@ -417,7 +417,6 @@ bool btrfs_finish_ordered_extent(struct btrfs_ordere=
d_extent *ordered,
>
>   	if (ret)
>   		btrfs_queue_ordered_fn(ordered);
> -	return ret;
>   }
>
>   /*
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index b6f6c6b91732..bef22179e7c5 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -162,7 +162,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_ext=
ent *ordered_extent);
>   void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
>   void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
>   				struct btrfs_ordered_extent *entry);
> -bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
> +void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
>   				 struct page *page, u64 file_offset, u64 len,
>   				 bool uptodate);
>   void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,

