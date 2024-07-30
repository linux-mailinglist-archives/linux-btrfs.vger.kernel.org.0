Return-Path: <linux-btrfs+bounces-6897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B0942224
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 23:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9317E1C22AAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 21:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71818E022;
	Tue, 30 Jul 2024 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="M+G7jANj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82121AA3FF
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374486; cv=none; b=cKzDqG6xF5mZN5dffTEvb+A51DJ35RTsWAcgWrxvYTp+sHHbunayNVC++tJcO8oQtdgUK2hpg8S7mBwXOLwH7sfawUXqJ46KRG18ibEdWCcphLCmMDVatThY2A4D3IqDcOjOQIdjxrisL1PnNF2IpB1tb1lnd0cVehZz2XtoI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374486; c=relaxed/simple;
	bh=8/VcPgkYIgsjrPbtttagCaOzFsCl2Gxp4sXLzD1DrgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nP6EpeTDTRRXe10Bw2MEGSTM5abGBfhb8LBwtm9a/rCFTqxZOAngzVmtXRql0/FSjT4OrSRdl0qGRpkadr538eED97SodTsmsdt9+mdVBl9A+QIyZYkTsfV60FMUfujPwhZV/O3Jz1yuSgjmiGU585LcE+f7Cj5shWh8qIEc8M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=M+G7jANj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722374477; x=1722979277; i=quwenruo.btrfs@gmx.com;
	bh=fvTURB6jAM6jODPCuTYM9RSx+YujpAH8S2tYkeFWLdw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=M+G7jANj65skaEbJ0oLZcKzSke89WBWB2iZXLJz8991Umd2MmeXGrVGpBSzwW1BU
	 YPMZc2t3N1DdRUP+L8GiOoWtX2u9rdF+eSv6pN8EhHhSBnSjLJ7jNjLohjOhPMdwH
	 q0QzAxfcnszT6AmArvXLaNeiwsO6hjp3O7WarKlsauJ870voaY7D72N6WbmEuKbr9
	 9bI1ueZSd7QSaeN2uzShfIlnpc1L2MeH1XrgMlrjeN9y3Z0pU5bsZjrhj1An8DoPF
	 ECWN1evsScLGh7AgvuGI0PUzoCiPeQWgMGAOyFb8eUQUrB0zj8lG5J3zg/SqI7b37
	 tY4i+9nY1UKKmRoCoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEFvp-1sQyCW0v9J-001pnW; Tue, 30
 Jul 2024 23:21:17 +0200
Message-ID: <c90191b8-4f82-4c36-ac06-ca8717c8772a@gmx.com>
Date: Wed, 31 Jul 2024 06:51:14 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: emit a warning about space cache v1 being
 deprecated
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <51e96d7a2754991bc369065d74290e7a436934c7.1722358018.git.josef@toxicpanda.com>
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
In-Reply-To: <51e96d7a2754991bc369065d74290e7a436934c7.1722358018.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3g0M0sOwD47H2iXiFmet25ocEoQ7sNoRSjzF9GukQQawMHdYzl7
 sEiu2Z6oWs+eNLEYfwOBvmNsh3Ly+CGyGjFVm5Ygpd/mrjbH1KRpPESzaBeEzQI3LsCzbmj
 RGZ4QALv4xfPO/QSmNsoF6ZJYLzXRC5USMJbOKGNmF/WZ4szzU9I+yWKrnpSCNWwgpaxLny
 wydsXsDbelSZdbu87AHAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yKx88Nj6R2I=;H5fbZAxb9bT7rkBWU8PO+1sFTQG
 jKqJDmU46ozUtQOVKkG46Eq8KT8eM/anCPL4XBcKH+T8hsVkH86OFL2mthDLJ3LW6oQQDBSfq
 c1DLLNmauuriAcKQglQ3S2yJo+dJTWcS+r3HVLoZ/ingMRKpxyeW6yKPYbqoVyloz2CtE9hsv
 GSO/BN8YxzY/ahB6P6HCjARFxvWEVQJMNYwOYp6s5LZc1jz8yGxO3bVs2LNDEnEeRrYkpj3rI
 IN7T9oI/TDWFK1uHfbhlYY4mE717r8ki3o6xzqcBcYstzt8oqwFXGrPzmAfERoYG1QpTLTc+2
 vvrBqg7YHBN6aE+NLw/oIX+DkyEjb/X0e5df6kHqsEnpNu1YUwWMdUaOLU9KUJ3Tm83TXO60u
 QPdE6vHR10AoGhV8+6BaSiDAQwdTzfdf9pMO0oKR7++MhTuyZUMEE4bRb1caNGI85lraq2rtY
 /gj7vO7llGHoQizQMET0SS9II+CGoe8f/0uCAwwoWimngxA29YRoqGKKV2kk5+ufnuZ0lyYxb
 4wMBr6q0hse8oEqzC3MrwMV6m2OTKEnJWT9H4ST31w1VvScCnMyGNxQUu0Hljp965/bakKSuh
 sPFJkyT76nouLIlJDat+Bz6SV3fQ6GZ8A5YmtnStfpdJ0iqL/te4So//jm2n9d1PC+6ms5o6j
 Lcv53B1ron8aLt1lHM3FlRBrbdqOAyChN/9yQJcBjs6ytL1nNopWdMf8DlLBGG1L8lxFYOB88
 zgXtcThuaHwGuNx9yLxSLiVwgjHIFa79fjDCnG/T20urbxs6Vk5sM+BMxK0ABqs43Ck8VKwTl
 RW3wnFrVcR5AC9bgKQHXEWpg==



=E5=9C=A8 2024/7/31 02:17, Josef Bacik =E5=86=99=E9=81=93:
> We've been wanting to get rid of this for a while, add a message to
> indicate that this feature is going away and when so we can finally have
> a date when we're going to remove it.  The output looks like this
>
> BTRFS warning (device nvme0n1): space cache v1 is being deprecated and w=
ill be removed in a future release, please use -o space_cache=3Dv2
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> v1->v2:
> - Made it all one line as per Dave's comment.
>
>   fs/btrfs/super.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 0eda8c21d861..1eed1a42db22 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -682,8 +682,11 @@ bool btrfs_check_options(const struct btrfs_fs_info=
 *info, unsigned long *mount_
>   		ret =3D false;
>
>   	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
> -		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
> +		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
>   			btrfs_info(info, "disk space caching is enabled");
> +			btrfs_warn(info,
> +"space cache v1 is being deprecated and will be removed in a future rel=
ease, please use -o space_cache=3Dv2");
> +		}
>   		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
>   			btrfs_info(info, "using free-space-tree");
>   	}

