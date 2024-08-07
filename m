Return-Path: <linux-btrfs+bounces-7036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D66294B304
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 00:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54A0283926
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 22:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5B155352;
	Wed,  7 Aug 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cfWoKPf3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681E155337
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069638; cv=none; b=r3mFim4s2PtC4ZVMpqrla7Y1q0aa3c+S3VSD1nxje6L6J2uFBzZjH3obWF2WOOgGKZhXOg6HAOG4rUpBJIUPLoW32S2+hVnxMOVoPQDXck/M7kp+6Vy9FRJrY25YElu/zU5sq0SDOunzXvdzm12tifB2lA9u01DMst1+Ak/a+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069638; c=relaxed/simple;
	bh=qfKM4gBQHXGQK6JB4t01Hvg9yZ7CNd7aUQ/Qwj+lhqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fTSWYiLqu6bNIjWR4BgyGw6OhzsY0YD95vxhH1M3FBSRd0qUvmhjU/6MtZh8nXIPA08QpeKA6OnqadF16Y6PAZAxJTpUeL7Jemul4RtRHrbiO3lMkkr4vlvusP/IkJd5gOEfg1/rX9LENirU09vPWo9ux8nTpdC6GMmmJoyikvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cfWoKPf3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723069626; x=1723674426; i=quwenruo.btrfs@gmx.com;
	bh=Q5cmCW7lpkioA/HyZpcc+O2unFv59OLmOK3X0qKw+OM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cfWoKPf35F8Q0OvvdJNpAxTDYE8Bk2o0lVuk2umO6ast78qVVrhfZgNOIh9AnVhd
	 4NPOawlBG+96zMFCu4VAmUTy/Neuw5FlYDJZnFYUxXp9yCZEKEx33/vMPnAJ1p9CM
	 s/pI2ZIp+gHbcB3GRvsKRu1YuzykAmK1gfnzMIMdjQrwg/bn66zvauXxHgLm9gXMt
	 y8BQt8bG7OKgCB7REs8wzm/WRFJDkxFvfdu5MknHDuo7ujsSdGurUTHqsncC0b6lE
	 nNgLq5XhzBadfMelgdho/eJrPFXPR/P5jKGS6YRD5E330J3PKY2rWbxhs2qj1Uy0C
	 2zDA9C+UbEqg8+qh0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMobU-1suRw52Qzc-00Ll7e; Thu, 08
 Aug 2024 00:27:06 +0200
Message-ID: <18286600-549f-46c4-8387-33cc461d1bfe@gmx.com>
Date: Thu, 8 Aug 2024 07:57:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: directly wake up cleaner kthread in the
 BTRFS_IOC_SYNC ioctl
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b4c0f0bc574a1b105a02132c2ebedb0e31f235eb.1723052137.git.fdmanana@suse.com>
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
In-Reply-To: <b4c0f0bc574a1b105a02132c2ebedb0e31f235eb.1723052137.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rDsTxpNoVgQ0gqSrPN/HHAxMGNQabZcd+FWmUns8tsSt6n+0T4F
 cLGbFX/Ovh7gxFRnk7E5K4LkBbejB1tUAlHPO7rqO5eGOGdOBCg9SwrL7CCrGhFJObmslbd
 mDC++bSGlJQFUUYjAByE8llPD4CKzw7J33CEx0j9NmVnYpzw24bAcnZ3l2nuHGIo0CYT8DG
 UlOZxyyCkKPj2PT1BykDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lP5BpX/1tz0=;qpKXm6F0Xy1VvXnKdrm/W4h3OoT
 YN6Nb3KUc6wF2LnXhOfA+8WgH1c6Gc7oESOi/KM92yYpzTYHoEwJe/0L0J699irdzOD16tb2S
 KH7nOZjtrkmuUOVzhBRVyGxLkXOoe+X6iSNMA/6GODMZaq7xSbryq+jAxNn81tuLvUeMqTkTN
 3J0JvJ6YVLoqlqoit+f+nbkXMZqyzK/xVJ+yuV6dYh7ou6yzUJJMhvnMGjD6d0+CgzkcWpx/L
 FW05JYTKXwQEIOM4+vV8EHg2ZISBuOUBXsZ7AKczR34G9abshdjnbYiC0/V4KrIivL1T+mlZR
 J7MXdnKFqCmBcT58ubwho/e/An3racXaZaPDgRh9Oc+LmmOPY/uQEQFIqjXaM6whZo79+LFtE
 UkheubOjHIARk0b3hC75Zlmbwrdl88KrRM0zrB3rhkhBK7cvurPDXvwWJFkAj5X/tCvTNjAxK
 rXGFpU6xoo3FAMTBWEJgPdNPe2aMG99+QNLhAxlpvkP8TsfQhHULKc97ogFe5yU6AdzIW+IxE
 KBMeP/Nx3kYXiTKHRozctgincDixBK6fuXXbUtyFHUWmuldxfFDHYwR0+GTNbBZKBsseZTM0i
 OzKraEOHpplVZfM5dEMbchuRNN9oTJ1scPnbD7Pg8CN3SLDcEdHHe9sW6Cf4ksFxyfvDT/S0/
 Jqi14OpeSd6sLdv9PywCaUDwnp0nVe/bAdZeFfvJilyXlW82iHoP/pQlgmasBWBHvUVMJ1WqP
 9OFvYl7gdJpshUl3R7HZVx6QakjIkILa5bdq/PmE/KbgEeDHubHtZ8GBT2w6R20b0HGU8zSO9
 YTmpW+tTYqxVBQvPxyblLWdGJzl7oploMeXO+MppKCul4=



=E5=9C=A8 2024/8/8 03:17, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> The BTRFS_IOC_SYNC ioctl wants to wake up the cleaner kthread so that it
> does any pending work (subvolume deletion, delayed iputs, etc), however
> it is waking up the transaction kthread, which in turn wakes up the
> cleaner. Since we don't have any transaction to commit, as any ongoing
> transaction was already committed when it called btrfs_sync_fs() and
> the goal is just to wake up the cleaner thread, directly wake up the
> cleaner instead of the transaction kthread.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ioctl.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index e0a664b8a46a..ee01cc828883 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4765,11 +4765,10 @@ long btrfs_ioctl(struct file *file, unsigned int
>   			return ret;
>   		ret =3D btrfs_sync_fs(inode->i_sb, 1);
>   		/*
> -		 * The transaction thread may want to do more work,
> -		 * namely it pokes the cleaner kthread that will start
> -		 * processing uncleaned subvols.
> +		 * There may be work for the cleaner kthread to do (subvolume
> +		 * deletion, delayed iputs, defrag inodes, etc), so wake it up.
>   		 */
> -		wake_up_process(fs_info->transaction_kthread);
> +		wake_up_process(fs_info->cleaner_kthread);
>   		return ret;
>   	}
>   	case BTRFS_IOC_START_SYNC:

