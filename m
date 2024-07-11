Return-Path: <linux-btrfs+bounces-6405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824A192F210
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 00:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CFD1C22166
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A619E83C;
	Thu, 11 Jul 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GbHRGfJk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F3685956
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720737310; cv=none; b=DraY/+0gcUIH8ZrJ0nabNEVm+v+hnu3eU1arvIb4HJveIpunktwCJilsrYE3i3sQYkA6ENoolN1TJO25TxD74TkpyNsHMmiMvjdarcVUHgMPp/hgKBhc4t17v0NppUDpjbPSzlJN8dLc0xuhwCcsJs9LQ+DhLrQNTKVxNoQ4QDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720737310; c=relaxed/simple;
	bh=CAqJCKFMyypRAuKDkIh5eAqvfKxrNv7NCUxCOIYoZsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cIF68VYAhm6/PAfF0CU4BGsWQu6CfsINJh2xWtypveRW5pHK2hKoHHe9rfYGt9JbHwZAf8BjHC29EuyO7pkC3MsYil/mjLMc0oI2OqW2LD3rzp2D1NM/3RNN/+5wfOiqEyXDwlekCZdPlsMiOOkx2o0BcK8ghaEL35EqtBcBcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GbHRGfJk; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720737300; x=1721342100; i=quwenruo.btrfs@gmx.com;
	bh=kM43eWfHeahJbKHPWYo3lVvl/OfEqVoudN9wWoQmye8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GbHRGfJkQZ9ldsdNI3FXXRy/d+oDczWQDdqoAAncYEpbUKRdEAS9WXwBK2KVmvEe
	 RMf/gEbrpvm4oG8k/eQHgSqnAv6FHcbWBzNG2icn2K9J5Vuv2TMtL9fvPXDAakkFF
	 Bh/7lUCUSVn/e5cS7enE9xwCSu5pxD8bxzTcJWCqCfzsrQXtNroDHp2cD8fvGvpHz
	 MNj/fkU/s7bdammB83cJge6We5T0TcfK6f16Z77gluXxFZiH/FKq/t7p/kWyriNBE
	 8Pd5Kgf6ICLpnrFrPeq/4SQW4ROZi896XRt95sJFqEbiDEvkvAn+1coLEcBxwkXgI
	 K/ec7Ecz8q41003PVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwfac-1s8pX40wnK-016ZOk; Fri, 12
 Jul 2024 00:35:00 +0200
Message-ID: <bdaadd92-ae3e-4502-aeda-c61bdac752aa@gmx.com>
Date: Fri, 12 Jul 2024 08:04:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs-progs: btrfstune: fix documentation for
 --enable-simple-quota
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1720732480.git.boris@bur.io>
 <e30318f3bd2579e9492d2e1e0fd4b408c2bd0fb9.1720732480.git.boris@bur.io>
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
In-Reply-To: <e30318f3bd2579e9492d2e1e0fd4b408c2bd0fb9.1720732480.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XIDJtHPNP9mr6Q9LU7A2RSkgJE1wpsQDf3pls5GWi0NjHKgjR6Y
 BQubJLv7o6AeBEvQL/R1XgtHGpXBLo8yAAQGjiYC8oBfsMLsg3auTYTFd1EvXDe7d6TvDG2
 smnQBAWyNNRQ3vSCLGCTYCj8tRD2gHpDtW/Zus16lTVSm6KY2k5xIYhTno9Hq34O9J3erhk
 4PXiI+l8njhpTjS6FkDzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PYghORFxrms=;5C+3SC1mdotmKiERlP9CgKNcN5S
 nXy2GP5/HfyAC+YzoPuOaB7HAqg0N7Jn7L5BVRu+qYnIyoLPc1g/eLwlAvqm39MxP4MbOmHB+
 xqQ2atDKDOn44Ws5gvIkeeUQvFx5p08QlE11K41t2VIVfDyUV/nrSW+Yl7zCKanjbsUpdi6EW
 lPZGH/xugQJa8Jj6HA7nMFsoGpMtMftIZAwnkSSzldEhUbz7wU8IhnCP+53s7JcdMlYSlbSpW
 Da/mF6dDapYZuCVKeI1vTrUAMvtOd6F1xL1rLnOtHcKv4FlccvFXLTG1aoRs3WC5dnsrbbAVe
 4uoZfyBqfrQYaKibDA/dDBImYsFrQNFZG2GDY2nq/ULTwEnHJrfsQiVH6Qg3kyvwiIzsVQ+iw
 J/WWePFfTSVhNRex7A6Md93xZRkZBumZ5YfrNtN1WDFoht29imtFihm6tQXTe3MssIE8dCnLc
 EPSocTivgRh7uAGFPB7ca2B4HemtcN2E4vcIoZWMmdVfW2as5DN9BHeH/kfugIUTzwJxnGxED
 F7Hs4tWWzY35LGtJZa5LYbBLLlHH6Ii4WWxRssKe/UzLslYSI6obwkce0QwOqXcVrlpp4yawK
 xLJrrBx350O2hYDo8VxlsFlTMIqhsFAOtDB3ZmsML5D/xC11GnEylcMtJimnneKiDh3wGVL8+
 2xohepwTstC/q/4ZCGQFvRwxt/GGBxPZhKnj54oowtXMcBX8cQoZUgZDOpK7l9sDirXEV0cAo
 pmvRjjvuMXLNs8UpB/wbKDzHGrgQ0atCGcdjhjXO8S8ODIc7QPPuT52PmUlSt1upry61SyRmN
 U5N7ZaaELMh0Y2k1JjpMTnWR1KJdGygP6CLaMsUv0CtxI=



=E5=9C=A8 2024/7/12 06:48, Boris Burkov =E5=86=99=E9=81=93:
> The documentation lists -q as the flag for enabling simple quotas, but
> the actual parsing only handles --enable-simple-quota. Update the
> documentation string.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

I didn't find the man page entry for simple quota in the latest devel
branch.

Is it missing or still experimental?

Otherwise the change itself is good.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tune/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tune/main.c b/tune/main.c
> index bec896907..cb93d2cb3 100644
> --- a/tune/main.c
> +++ b/tune/main.c
> @@ -103,7 +103,7 @@ static const char * const tune_usage[] =3D {
>   	OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metad=
ata)"),
>   	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficien=
t sparse file representation)"),
>   	OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
> -	OPTLINE("-q", "enable simple quotas on the file system. (mkfs: squota)=
"),
> +	OPTLINE("--enable-simple-quota", "enable simple quotas on the file sys=
tem. (mkfs: squota)"),
>   	OPTLINE("--convert-to-block-group-tree", "convert filesystem to track=
 block groups in "
>   			"the separate block-group-tree instead of extent tree (sets the inc=
ompat bit)"),
>   	OPTLINE("--convert-from-block-group-tree",

