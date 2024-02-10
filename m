Return-Path: <linux-btrfs+bounces-2298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE1A850368
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 08:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291E12822B8
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433AC2B9B7;
	Sat, 10 Feb 2024 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="t/wmhVMK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA87286AF
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Feb 2024 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551332; cv=none; b=nfeKR1skPJRdG/ZskroxTme9oPgzpPoisymNWqm8DMWAGw19nQeNz0g1QjZdlsIKJD/4i+8GhaV9j5Vd09s67Gjn4qCueHRUNIekKHZkdN98NyVGyy1O0A1G0b9uloWxBMiIYpll2hygxeFF1q3TyzS6H0JmGeu6wMN+iHO2A+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551332; c=relaxed/simple;
	bh=0NMiUcql6Em67/iMRa2dMENHaezjw2hnVLPLNs3PDXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UrZWZZ/83vpXTc8+zDv0ucq7qFEzjWKmEetFJPqitARusqSpa3lPX8HPYcBqvkrDWGAD8Yc6MhRhV02vBKnT5fQ1bOl1Ojv4KLosHD/KdE8iqFPWmnU2Y3U6GkhPft7XMHtd7aBQAZjA0V/TEnnL6rqg+mMj0Aahqxy9z4UrbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=t/wmhVMK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707551325; x=1708156125; i=quwenruo.btrfs@gmx.com;
	bh=0NMiUcql6Em67/iMRa2dMENHaezjw2hnVLPLNs3PDXY=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=t/wmhVMKUXxaMnF24qIHHP08ENoswllOh9eolePjyfDuH7SlZaNURB290BmUA1Qm
	 Uc1C+vKKWR0vXdgT7npgcxHLPhbHxFp5ob3oiGdMxNO18BeAWmUcMASaRGmEhqrg1
	 g+PeNGG+TTV69WHl/wHG/dq9B8fvya4UZNlDwLn5O0NHn8R69iI4VE14p6MLXugaX
	 tj7v69AHhuOjn/pqP4W+FtXutG//s+qzS+M3x+nn2iJ4u/hy1b+j42Go8NA0cFa4A
	 Hq/EuZF7yg+UslBvQPRMxERKkux4V051mk1jZcuCiOs9PDpuuC4FjmJYnLzMS4ZHN
	 MuWC2+3+9Dg9zeVX3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2Jt-1r3nGH1W4X-00e2wD; Sat, 10
 Feb 2024 08:48:44 +0100
Message-ID: <7467035e-15ad-4020-a621-e8939f9b29dd@gmx.com>
Date: Sat, 10 Feb 2024 18:18:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] btrfs: use assertion instead of BUG_ON when
 adding/removing to delalloc list
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707491248.git.fdmanana@suse.com>
 <d5c32d0109f92b848b6a0054571ef48b82bd77ac.1707491248.git.fdmanana@suse.com>
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
In-Reply-To: <d5c32d0109f92b848b6a0054571ef48b82bd77ac.1707491248.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g6+UZWejir0dSMVZYE5LPPqLf3ztttSS6BM7mIWRfbo7YyklKBC
 fvS33lCxLuK3QZ5lUhssGJ1T828shcLwbyCBHU2t0sbB13y5js7cbrFl4Qat9cSY8OAwctl
 ZOwqe1N3oqzn/sJB1UnfZas5C6TITO7/9WRtjZDRrJ8vzXTgRPbSEf1VxTCUrTm3NQga7IN
 l957JYd0jjjdb6uJZ4A6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b3zy6TqrWfw=;E4EEa4qOa/C0FcK5d5udFXBrdU7
 RcyM8KfKs/16iHTnW4FMy1pG8sj6puRb4PyUg6d6zcLMEB+eb63If6fMaPmUTMcUUYmjGkQGG
 f5xodRyf1EblArlzeAoDmf01fGk9qRwr3eFyhPpBEy270qP8a3B27AyNhzNn9PA4iQKunktea
 hEIPo5mFqma+nrM4e/4iudeaQDCzgJD+URQeSM/Ck4rLhHe/s/penAyrTMhLickEO6XTgWzHi
 iadnZgRAJub9ZCbL2DBx74ojTlPgP9ZKVc3RdUGuxppj1jzSlqe6gbCoMQdMRNUkbUbg6kKlE
 loHrsgoEuirTPf4p0A6c8gGPSskwyrInfOoQ9DQGTPM1+u5iSJWGI7MXgY0ySvVjtcNR82/Ow
 LksNJZYICinandi5NnYGcLg98/xw9kL0ARukQXX0O5fB8ehiLKJSwC2adlJlqUnQB/aTL2B6T
 +LUqk/jZaM7J2dFBrr/4PORiT4JJQtLLzbWfqnlUnWXz+bF1vvxSlhiVMe1o758nMWdvEmiba
 ZHoqRh6Zr/M22bcbKg4b0DUYHcfAM9bHXsYFBopSkRLWaAdJF295UC75zXYTrv8w9JRBVvZN/
 LkXwc1H+pwHHS+au+gTwCAyJBXxpzZHD2bQwnWHiOSHJ8x6Nxz1GFhK9yKCaJNM7vahMzeRj7
 lslJD+z9xeUniCMitX9auww1LgTT+Mb3PNdjmWeZdaDI9WDG0ppCNomAKtSQtq/9ao5HJNgXR
 DEtbm7exhEuiyA7yuisuq28vYuMxfpb1iRJIjeOB/qIVEyDyQjmbztg62xtS8mOJp3kCrcNsB
 SRCN91BGtaLCNiVyDiYxnPkLz0JdcsQb4rkSEruSsePWM=



On 2024/2/10 04:30, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When adding or removing and inode to/from the root's delalloc list,
> instead of using a BUG_ON() to validate list emptiness, use ASSERT()
> since this is to check logic errors rather than real errors.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c7a5fb1f8b3e..fe962a6045fd 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2400,7 +2400,7 @@ static void btrfs_add_delalloc_inode(struct btrfs_=
inode *inode)
>   	root->nr_delalloc_inodes++;
>   	if (root->nr_delalloc_inodes =3D=3D 1) {
>   		spin_lock(&fs_info->delalloc_root_lock);
> -		BUG_ON(!list_empty(&root->delalloc_root));
> +		ASSERT(list_empty(&root->delalloc_root));
>   		list_add_tail(&root->delalloc_root, &fs_info->delalloc_roots);
>   		spin_unlock(&fs_info->delalloc_root_lock);
>   	}
> @@ -2426,7 +2426,7 @@ void __btrfs_del_delalloc_inode(struct btrfs_inode=
 *inode)
>   		if (!root->nr_delalloc_inodes) {
>   			ASSERT(list_empty(&root->delalloc_inodes));
>   			spin_lock(&fs_info->delalloc_root_lock);
> -			BUG_ON(list_empty(&root->delalloc_root));
> +			ASSERT(!list_empty(&root->delalloc_root));
>   			list_del_init(&root->delalloc_root);
>   			spin_unlock(&fs_info->delalloc_root_lock);
>   		}

