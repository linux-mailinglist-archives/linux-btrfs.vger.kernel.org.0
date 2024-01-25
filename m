Return-Path: <linux-btrfs+bounces-1767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7809683B880
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 04:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8AF1F24503
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 03:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA19C7464;
	Thu, 25 Jan 2024 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="d71OYthM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84B6127
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154792; cv=none; b=K7LW+lvZX0fowgAv3DVhuM8H4vejmc1pknCgSD8uU0LwgHaR8Xyp9b/Z9vYmA2rZ5hY0G19sJuDH18hyzNMFefTWTzgvhsgGZJlpyyRgiTDF/YE3tKCpHlbnZB49PokHi09GtnQoPRVaNc79Y7x1qS5Zh695fbFsiF4RiVauWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154792; c=relaxed/simple;
	bh=c6Woxa8+xpYECDnOTtaljlWLIpLsoKDMB1Fu6qaSQK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=un3Rv7PdHHx23/DASJrZHY80TYZpsClzWX3l8rTMi6pWusi8UBPggy4UC2gGUaYrzNjcuuMvzZ44Y5UgHJE1dMFuIGVnAFfM2TFZiXlE/93DephJ3aeZLWEdFMvhzHgkaQJnOuVhAeLDY/En6UYp906SgyIdB0BriZdwfMkvnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=d71OYthM; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706154787; x=1706759587; i=quwenruo.btrfs@gmx.com;
	bh=c6Woxa8+xpYECDnOTtaljlWLIpLsoKDMB1Fu6qaSQK4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=d71OYthMjBaefDLtu5Kme3gUa7bU3+j4BOWqCHVVldAFcGNccfRvmwcHhz9QwVf4
	 zPdSzmHhxO22xmLEN4Imf/qIRYU3olFy91T0ifFZoGzkkqHPIobh1mJhJVn/Z0I/3
	 wnd/BsbOZs4CXIzcQZNZoGClb9BKLWtu2pxj4rRacDrmPSiwU6xpgi8tOgP9vwAxX
	 QA4ilpkVPxLf7UjVdowSfuXLklZey1OGP6cjRPnXjZj9//dL5RKkW2zDKnHVqN8fY
	 +cAXenIkK17gLEW/IQK5qe4tDclY9/2KPo5mYGnTWGDmC+Y0TS0Xa45zUzgK78Qur
	 uRECYpHEDsTW/0SNpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MV63g-1rdGfU291K-00S9tP; Thu, 25
 Jan 2024 04:53:07 +0100
Message-ID: <7f04e4d0-8695-4d2c-90f8-ea2befb598c8@gmx.com>
Date: Thu, 25 Jan 2024 14:23:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] btrfs: handle invalid range and start in
 merge_extent_mapping()
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <6cd106844e522bbdd21f15572d81d4c9186725cc.1706130791.git.dsterba@suse.com>
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
In-Reply-To: <6cd106844e522bbdd21f15572d81d4c9186725cc.1706130791.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:neTjkLNBzIk/UdxwuuGxUJG6uhKRUCLJ/HsQNc/1L2Mw4+XFM/w
 CwmRfPXqFNatcjmAT6xlY8dU+2VmLliWtUSHumjeiNAGkGpSTAdIR2SevOT64EDzrtoKZP7
 Ylb9KG6gZKKjP7JZpq3CEg+f97sYuHhYyF1cmKKEDzdRfxIsQ3uspch1IUYCNmBR9/YABAp
 OAzWZg6svK3w3eEoHki8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sWfNJmPhGXc=;qGq3gKZwkhT/HJiRYGo5x69l34V
 +ydhPe6sOrUe9Lom5tHiBEPrqjABgUxoeLCVANbgMKvnrG+v4fGS3/tKfJ2L9jkM3mImxp+h+
 Ma62QZ9oFDauFHNjStEmCJYHWTgmYgT6WVAYp/kNerBvs0prZofK3wAd39kzHHrhMDt7PF0L/
 QaO2HOAL5/CnB6QRz6+CMp3Os1xo5iplTSpAMfnnga2ZomtqFD5E9abo4tdEq6AlWgDYrcRws
 U7mZjPPQkaaG9tU9oGiQB/1yXs7aVu1lQ+K1FpYGEZF3y6EaKQ/ySEy27EKsubiTBgCVHrWw1
 iGc4Vo/WpBhBYXnoL5/OD/BBrDZvETjLxRac5t8cmLd35ieTCc+ZYhzU7kABb2cr7mCH01q6u
 scw5Ed23LLPS4DcDX/ND5qMYKqaQppDx31yFH2WW17O6ZoiWJGntXhNAaa6sIkij9CGPv+wR3
 aKIIzmVg5GEZ6VSdrmsazCRMjx87gQQphKxpPVek7iCY2ztnroUk4/2WVo/ea+4srqUyx74Ez
 T2wi4claYwhkHoc6E2QmJs8lqaed8oMUXnQAjo352mcskbugUATC2AxHhY4Mp6B14DNCw9DEc
 YiLeWhb/QAlNHsil1knb/4WPQBJTVPibYH+Ke9TFUAG04juRy8AlLo//tGT3RDcWmJ/ystPbJ
 nki9PYhqyFOFUUllFh6eL1VurZPy3vIvbNO4Le1S0Rj1ghNODOJQpu4Y0zaEckMF8jHxXReT6
 WPDiTfLfm4SBuykbP32lMbLj1KIVfP8MfqNVOAiYr6iXRx1wtUXeTBdXrBZjv14k97jhIYtK2
 +3Nv+Q8IIFBOZ36aA/PWyAtwQ3pJydNZMoe2tA3XwF5hbslpHUMMZHTXWWHVu4LgPBrUNB9gL
 iJGKDb5ctupDtVtWAOFEZIpSWZ0pLl+eTSE7ujnvRCRYXwZw8JvW34n3C7UgJ3KyCWVnGhuEz
 fY6pAA==



On 2024/1/25 07:47, David Sterba wrote:
> Turn a BUG_ON to a properly handled error and update the error message
> in the caller.  It is expected that @em_in and @start passed to
> btrfs_add_extent_mapping() overlap. Besides tests, the only caller
> btrfs_get_extent() makes sure this is true.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent_map.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index f170e7122e74..ac5e366d57b2 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -539,7 +539,8 @@ static noinline int merge_extent_mapping(struct exte=
nt_map_tree *em_tree,
>   	u64 end;
>   	u64 start_diff;
>
> -	BUG_ON(map_start < em->start || map_start >=3D extent_map_end(em));
> +	if (map_start < em->start || map_start >=3D extent_map_end(em))
> +		return -EINVAL;

Shouldn't we go -EUCLEAN?

This is not something we really expect to hit, as it normally means
something wrong with the extent map.

Thanks,
Qu

>
>   	if (existing->start > map_start) {
>   		next =3D existing;
> @@ -634,9 +635,9 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *f=
s_info,
>   				free_extent_map(em);
>   				*em_in =3D NULL;
>   				WARN_ONCE(ret,
> -"unexpected error %d: merge existing(start %llu len %llu) with em(start=
 %llu len %llu)\n",
> -					  ret, existing->start, existing->len,
> -					  orig_start, orig_len);
> +"extent map merge error existing [%llu, %llu) with em [%llu, %llu) star=
t %llu\n",
> +					  existing->start, existing->len,
> +					  orig_start, orig_len, start);
>   			}
>   			free_extent_map(existing);
>   		}

