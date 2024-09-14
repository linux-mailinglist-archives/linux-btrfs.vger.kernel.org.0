Return-Path: <linux-btrfs+bounces-8014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25CC978C17
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2024 02:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1198F1C2538E
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2024 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0DD1FDA;
	Sat, 14 Sep 2024 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ImdqK9KF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBF1370
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Sep 2024 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726273102; cv=none; b=CmWVewEzFqZsQUFoLlND0KHMxFjgrNfB1QuzyXJT2ZXptNRtO4UBdrRUSoaCy2M5PusNRcBDzV1HiLL9BspRvZq5bvCTnP51ar4t8RPQ2Cwwhl0H4HrMN2mFdhd6Me6PxDVIzlqvxuT2RCIXilTzR9vd2xxdC1Iy3fyh9Fl/DTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726273102; c=relaxed/simple;
	bh=8SjKr7lnj59IQ8q8qX/hsRZFiYdlU3eUSsBf6ErsVWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LhQcAT6TsA2KzWniwa+59EOWPbExuzWRBMBENFsX1W5VbJIBKEy6IEjFt0L3z31BF7jj8rSPSty2T2WUrmBccMuqr9A8EAGt1122/uct6aQ/Wn6vdMVSQl383RSCBerDmwp49Z3++mezgeQCfQ8RgusWQp8BITjphtqNLsA+R3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ImdqK9KF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726273093; x=1726877893; i=quwenruo.btrfs@gmx.com;
	bh=/JqIiAp+wLwwPyughSItUa1aLkl+xcddp/OnEwUaB6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ImdqK9KFOyikY7VrnhAEdLvtkLNRyit+lcFPfLj6eSntUs0wWvoJoQZ0468/bSyc
	 1frXVNP/MDSy+gWID9dMPAT4px7wzk0iozE+yRzVoRD0EFt/ZqtlNNByvcraeLGpC
	 VZaidEWaxLFjA2ICg3Xv1RoNFInjlDj+n2++KsAIP13rXYj4kdNfglUCPcLD9HNBl
	 /xVj8LnxdAouiZ8dzUha8CRDLZm729hY5u1Kj8HgLb04TLmu9KVZ2F6DKpDharZ8L
	 mH2Bz5b0SyUzTXYLhDGYMD3bVaEi+G1zGhG1vRyQKeDSrnm47nnuPbQJMd5/0AXiN
	 /4w1MhzkyyQ8vUk6Ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1sF6OG0mur-00kFIK; Sat, 14
 Sep 2024 02:18:13 +0200
Message-ID: <2aad6e53-1321-4a73-9e2a-70f9d5e17216@gmx.com>
Date: Sat, 14 Sep 2024 09:48:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: set flag to message when ratelimited
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <0628fc55984c3507c5365d4e1d5ed96d28693939.1726261774.git.loemra.dev@gmail.com>
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
In-Reply-To: <0628fc55984c3507c5365d4e1d5ed96d28693939.1726261774.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1fcJOadC9NfaoztljtJunG3FhEbJb3qKx2Ks8nIsB93cz21z1XF
 xT3wOXHIZL8cS8+B6xEsbhjgDCH3L1rgwc/ptyAjBIc8iCJ4z3QN1oocNSR5N0PTpQ5+3ga
 bfuxihd/FSuFKOWIMeHYsSiMI5DeC2ySKCo4UKokf3ekHFhUtjKTRfyH3X6fpphd9y4o2QY
 q0FItWc+bcy6Q9rtdO7Tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sKw394SH3Ks=;49iGoFcK1RkRBTYWj3Jm4Cz+USW
 y5MJN0Cpo3G0k26Ykhf3zOLbQJIkTWyjkzh+zBj5zt9YcK6pTWgg147SQYwD635WZ2XGKPnd1
 Hxl2X5WetGEOQcAj7v4XcPhjoCUZch7aP0pSpTu41v08XVMs+m7plijEAhE8g8v9okRdEsiK4
 jOdxTX65ProJx0WCgGnT0VEhTRU4T+s9ffkO5h7ebkp2ADQPNzK1j6+PQyMnd8GFj6kmQWaYw
 FbFGcMLuTEuIaYt1rD6u31TCp5euRkAHh7gMy+1a3CIoKXi0UXNLId3BTGwD0pDypFurYu1/S
 wdbDLIOARxo0/5Op3YccaNGrhO3copGwHpIq8fKmfG6y1X9U8aRWTGJLwBli8RxZrOZI9DFHJ
 2Ocmlhv5PbSghgVQgTPXzqz1eYweZijJcHBnuI30FSIKHAAqEoj7lKL2RuQYXMKqplCbmi9cL
 byz9vgNZwEgMLKi147fl7V1/SpP6PYS9zeXp7MS6QqL37y8V0i2gVyEhf3ehWs/daoXAzsCz7
 2DS9y6JX+xY5SPGIq/73/9S+uCTyYek4iUh+7dtpbskykpHhMmULo9wF+8XNeYvcOHbIsRPUE
 CGwpUJv+lFDo4lE1Vloagt0cfbk7IjUMjWNsqLvoJDyQy4qgfDBGCYAlApzK29AOtpF/5zTvG
 7XmeJDE5H79x3ZG1SjKl98zhkvnRqrDjxgNuMKMk9LjHLjQd6e8bhjyD6VDJNx3AguShyzAwb
 ZAeqOPbRmX5Lq6a4U1YyErgPMJgO2boVHiSBHz9gV6n1BVb/9PghRZahgq5encq1pudfQATaU
 cYZHdbY1RkVxxwar2Qzbs5NQ==



=E5=9C=A8 2024/9/14 06:56, Leo Martins =E5=86=99=E9=81=93:
> Set RATELIMIT_MSG_ON_RELEASE flag to send a message when being
> ratelimited. During some recent debugging not realizing that
> logs were being ratelimited caused some confusion so making
> sure there is a warning seems prudent.
>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/messages.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
> index 77752eec125d9..22316067bde75 100644
> --- a/fs/btrfs/messages.c
> +++ b/fs/btrfs/messages.c
> @@ -199,14 +199,22 @@ static const char * const logtypes[] =3D {
>    * messages doesn't cause more important ones to be dropped.
>    */
>   static struct ratelimit_state printk_limits[] =3D {
> -	RATELIMIT_STATE_INIT(printk_limits[0], DEFAULT_RATELIMIT_INTERVAL, 100=
),
> -	RATELIMIT_STATE_INIT(printk_limits[1], DEFAULT_RATELIMIT_INTERVAL, 100=
),
> -	RATELIMIT_STATE_INIT(printk_limits[2], DEFAULT_RATELIMIT_INTERVAL, 100=
),
> -	RATELIMIT_STATE_INIT(printk_limits[3], DEFAULT_RATELIMIT_INTERVAL, 100=
),
> -	RATELIMIT_STATE_INIT(printk_limits[4], DEFAULT_RATELIMIT_INTERVAL, 100=
),
> -	RATELIMIT_STATE_INIT(printk_limits[5], DEFAULT_RATELIMIT_INTERVAL, 100=
),
> -	RATELIMIT_STATE_INIT(printk_limits[6], DEFAULT_RATELIMIT_INTERVAL, 100=
),
> -	RATELIMIT_STATE_INIT(printk_limits[7], DEFAULT_RATELIMIT_INTERVAL, 100=
),
> +	RATELIMIT_STATE_INIT_FLAGS(printk_limits[0], DEFAULT_RATELIMIT_INTERVA=
L,
> +				   100, RATELIMIT_MSG_ON_RELEASE),
> +	RATELIMIT_STATE_INIT_FLAGS(printk_limits[1], DEFAULT_RATELIMIT_INTERVA=
L,
> +				   100, RATELIMIT_MSG_ON_RELEASE),
> +	RATELIMIT_STATE_INIT_FLAGS(printk_limits[2], DEFAULT_RATELIMIT_INTERVA=
L,
> +				   100, RATELIMIT_MSG_ON_RELEASE),
> +	RATELIMIT_STATE_INIT_FLAGS(printk_limits[3], DEFAULT_RATELIMIT_INTERVA=
L,
> +				   100, RATELIMIT_MSG_ON_RELEASE),
> +	RATELIMIT_STATE_INIT_FLAGS(printk_limits[4], DEFAULT_RATELIMIT_INTERVA=
L,
> +				   100, RATELIMIT_MSG_ON_RELEASE),
> +	RATELIMIT_STATE_INIT_FLAGS(printk_limits[5], DEFAULT_RATELIMIT_INTERVA=
L,
> +				   100, RATELIMIT_MSG_ON_RELEASE),
> +	RATELIMIT_STATE_INIT_FLAGS(printk_limits[6], DEFAULT_RATELIMIT_INTERVA=
L,
> +				   100, RATELIMIT_MSG_ON_RELEASE),
> +	RATELIMIT_STATE_INIT_FLAGS(printk_limits[7], DEFAULT_RATELIMIT_INTERVA=
L,
> +				   100, RATELIMIT_MSG_ON_RELEASE),
>   };
>
>   void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const c=
har *fmt, ...)

