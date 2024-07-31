Return-Path: <linux-btrfs+bounces-6937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A9943964
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 01:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C1281CF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412816DC11;
	Wed, 31 Jul 2024 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="biNblVls"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE616C695;
	Wed, 31 Jul 2024 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722468580; cv=none; b=sOjuZbZtbMsh4qnsYay7SaAlauavmK+wVNvR3OWvQN3C/TFMSG5MZrkHq09hwoasxstxLMsHXVra0uI/e02aAmMlJYkNMPRY6fi78m42kpP1IucshfH5TOxT8qz0BPLHYyXx9HE27qRT09TP/UJ6Fa5aVeoaG0iaoMb6YRxb3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722468580; c=relaxed/simple;
	bh=dDH4GBhsOsYyygZaBz4Dgi14TpZytnE7QFjmZhXLvG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDqge4IkWGIHQPRx4MFlqA6dTKUcjnMoyt+43jTPfkKXs9mi4g4fYf4gftfOwkEhO9LI2RMZxqVWZF3H5HT7JNVCqFYMKBU1+eemtfU8kKbPdM1CgrIjeH9gllfvBWScocbdSJZ43mJL05QZUnSVzMhsM61qP5X74bY20mz1lpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=biNblVls; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722468568; x=1723073368; i=quwenruo.btrfs@gmx.com;
	bh=aZqcxE32r/81KW/vg/EhD2T5X4WtQ9uqiXFvGLjLsQE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=biNblVlsl7Pk/N434EEaFa06mqo15Vcht8TLJzzUGBH/AxG+V227w1rfiBgRRzxd
	 W9+RiPdKfU1XKUq10Cz1z8ku9NTNaPzaKjoKaGYTh5B7E+s2qwKYHJB610rf8Vk+/
	 jUpEGo5Eeqct3oRH879FqYSEorU/UzzrwHp80sY0AKwNnFxmE9My8McozS1EM3yz/
	 KGlqdDL80O6/D95BaNGFl7RHoSJAsSVluX6OrpiGB6JRnRwrD+RdZO6BkIIg4kl4C
	 TB3lWc/rHeiLcQd1jewqd2gh0g0LjDFNX+BFit9iPYRUchEAcvopH2xRIAaTx7ay4
	 4YTi6A/5jI6WqKJimw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6lpM-1sc4Aw0s9O-000LTN; Thu, 01
 Aug 2024 01:29:28 +0200
Message-ID: <4bcf1b73-e59f-41fb-9d47-9454db59363c@gmx.com>
Date: Thu, 1 Aug 2024 08:59:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/019: redirect fsstress output to log file instead
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <0fdc35fdbc53f739fce1cb46ede8af97829aea11.1722441479.git.fdmanana@suse.com>
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
In-Reply-To: <0fdc35fdbc53f739fce1cb46ede8af97829aea11.1722441479.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5Gq4X5uCTk9ig89Wbxho6IyN/4PrLFw+g3jk8diUoo1hxTaSJG
 gVqkMNGXdVOk4h/zFK6wgYXTs+GNIOpB32o9ia5vFZ3cECA44K4iS1vhqV5bhPy5oP407aS
 +exl8VT8kd8JcjRaAGc1dcMwwZtSrNEty+vc0rdWkluOuG4gGHoMi40HwAOsRFJO9tn4s4E
 C0hsPGBtpIPbL5nJ2VhSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OHKdkwERAGI=;/NY4188oha0kgcbvSd3rzHKUoP0
 3ymb51vsg2yuKk5kx26k/hi70mkOHPbPynlcXc+zkVCpLp30GAFM6Pj/55VEQB91ofe1yvYkx
 cVhwG2ZE1qQfC76t5ZlXOT8Olr/VsaSG0G52F7uHypl8p6//fXJmmIkIFLD+H361QqhHOxpBz
 Oc4o6bWmpOZ8u8mckfCROVClNCKTmIWM54AnzyRcBP6UJGB4z+htkQk9zkFdleaTQrDR/HVEB
 1hd8nIxoigj0GkJEZXBRdkUL7soN9U0/wJqGwfxunyp6Os4Y8PR9Sb4Dr8Fm2xs7tsXqIda2B
 aHuVIypC7zaXGEmaMHv3s+5xU6G9+IjXKoWJu9D3diLvyEFP9XJ/RZXfe1ZhKXFp/mUnGs7Sp
 d0nfYOe3mVic/n8j5W7+pWIOPt2NoPqT7At5r8Yplz79y7eUhJgNIz2RKU2yu1qVR1IkZDWUk
 N+Q+U3PCqkbw3M0lyAEc3wOPtFx7yH5z0RG8t4jdgHlAvUi+/uwdMlrbDTCGfaWFQC851YXbA
 nPY/JtCUvlWUlEAahQ2rs+IEkfzOGABl7py8fH/lL0VajbQo/0CU2Uy/kOxIMGEjK+IFBLgro
 59hgAdyvkLRQsQP+jxaLJLthf6SsZQiMX2nnNyok5LM01J71XD+qImsmJMoor/fjnEb4Lwpp4
 2T5vEdVligYE0srgeUcgd29PHDwznpOol81hrvkq9/Q2OnijhiB/Sdfgo05Rg/f2ARv19uXlP
 uQuyfyPw81aUHI1JIieIeeN4Q1SEvdtYvEsf1YYQDbIl/ToqgvM/O+SuOrvBNjZ3CiBE0Ub2A
 hLEE9co/i+4Za3MwHubPesDwrARu3SvbdTx51tj38Tknc=



=E5=9C=A8 2024/8/1 01:29, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently we are redirecting stdout and stderr of fsstress to /dev/null.
> In case we have a test failure, it's useful to know the seed that
> fsstress was using because it might be helpful to run it again with that
> same seed in the hope of being able to reproduce the failure.
>
> So redirect stdout/stderr to the log file $seqres.full instead, so
> that we'll see a line like this after running the test:
>
>      seed =3D 1722389488
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/generic/019 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/generic/019 b/tests/generic/019
> index 26108be4..fe117ac8 100755
> --- a/tests/generic/019
> +++ b/tests/generic/019
> @@ -90,7 +90,7 @@ _workout()
>   	echo "Start fsstress.."
>   	echo ""
>   	echo "fsstress $args" >> $seqres.full
> -	$FSSTRESS_PROG $args > /dev/null 2>&1 &
> +	$FSSTRESS_PROG $args >> $seqres.full 2>&1 &
>   	fs_pid=3D$!
>   	echo "Start fio.."
>   	cat $fio_config >>  $seqres.full

