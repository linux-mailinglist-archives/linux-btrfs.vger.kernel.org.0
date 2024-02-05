Return-Path: <linux-btrfs+bounces-2098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4584984937C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 06:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38481F2309B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 05:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4EBE47;
	Mon,  5 Feb 2024 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uOJ+fQ7h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB625BA30
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707111786; cv=none; b=ddqG8iNj4OJbiWTwMt24a5pu80cHasps+fngbp9kasguM8183+UVzmNa935aDr4eweypcqrgGg2zYhlKArjiIpzniiW846NHt9cF3RvWIVe4M9VMg3Lc9HHlUxvUYGs3253dP1lSFOODNVO7PqonIA7xf3c0DIKadjxM0Ngu30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707111786; c=relaxed/simple;
	bh=/RUkVWtzPSaqTcz4GT8WNg4nRWnkk/rbx+7bDfuMaIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bet6B2Xhel1VbebUCLAZLcQhXNaXxuIp5wev1xn/BoeDAzANIjjiEF7Pi+J8qr7+6OZBfHvXMrmnyhRz9lTlcxLtTPUWi1fphyfeLzZxvnS7td8BkQTbEbOZ5kGIulY2aRtt6G2aSAXqwN7gWvFLHFWF8UvT4+8LjC2SGOp6zpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uOJ+fQ7h; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707111781; x=1707716581; i=quwenruo.btrfs@gmx.com;
	bh=/RUkVWtzPSaqTcz4GT8WNg4nRWnkk/rbx+7bDfuMaIM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=uOJ+fQ7hbC1eBnlOaLC9aOloezrWJZ8rejhKsL4t9UNh5VZ5HMXfg9jtIGkJogm6
	 oUJaDwiLCEuKGAD4E0m4hYDQhA4Lmj9ckYdsHoLzvSNvs3WSBZsCZma92mUarS1+s
	 lv6l3qZRpWJWU6fAChWexwQW/eoJ9ZRf/S1Ma10Hz9mvPdxnOZcNsRbGXPEaKS033
	 /SbcfTQiyWTgEVLr/0CUcDWR1Z1azCTteM2oh268HmljC+aZlG+ggW6GjRhK9B78j
	 PS/XRpGUwbPHqHawPkK6b8n12RQfXsobAGSzx6HHPWl32VX44fB+JMXucG/ajyqpF
	 MOCiX4TQeuUwL1Jv6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXpK-1rNxm11J0S-00QQmd; Mon, 05
 Feb 2024 06:43:01 +0100
Message-ID: <45d5ad09-5d22-4a93-8b54-8ac1c61f15f5@gmx.com>
Date: Mon, 5 Feb 2024 16:12:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
Content-Language: en-US
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs@vger.kernel.org
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <c6fcbd44c7ecb06c92f6062e6843a1d106b5799a.camel@scientia.org>
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
In-Reply-To: <c6fcbd44c7ecb06c92f6062e6843a1d106b5799a.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:natnSvbFk0cdFDA27zPzHuSReTnE1gNPW9w42vEOA85sxHoP9y1
 vDe6EbolvmP3U+DT9SAOxjQvJLKn/njzw66VdK3AkNdiY+vfp+pb2q+QNK08EIfuVupd3En
 nA3GWE4uZ/zokStAxBUTMx4wp9fZyzpfzrvsWHikhmhKwTS4cVOeeJrfGy8G2ficlxrGsI7
 TjSg8Uoev+iOori97pmzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KPhjEjIjBAw=;DSpm+UM0a37/P9E5nnc84nzD4W9
 zNyu+bAfd+QGtHzveMliECl6J9W0T4DfHVo488IKTWMzFBw7TUUXomrtqsxAMfORK1HRGK/9/
 Qw/6kA4gbkSQ+28ADdYLIiEAFcUGO0auXPgIiFD0M577kujb7LyylnxvhV5hUIxJIp5lc1WP+
 nfYOgaKbNOn6j4ELebxyLhQxMORecLdQalHdqvzvBykJ3Yx8YhZBG5nwJBTBUmeOGdsMCQ97m
 OiiM1NOzYdUv6TJgtjH8lnGYrdK2DGcT4w5sw6GeSr3FYMJecbgdCo1sVao1eJO4zKOWaarq/
 u5qYxz6EnD2C27gsDQZR0iNmmO8VGEInBkm/qpci5e5jlAm5UqoZdPPY5s9BQkjxaI0zPnp6W
 jQrJtX/Lhwz7w8SItISq13IAGWFJexIDhHdAFXWa/hz4pIQcDi5PDccVdHgHnwniVZBfxCLdm
 JkmBZcoObBjiIRy/GD2LpcfJ5QeFLYCN4bVXZ4fLboJrgnS2GQ8n1sibAMKEc6+TFBWr9kOhH
 MaqAagHBn2F9P5pBZbibSwB0jdpeOFTOODWUERozditRURuIk7yLzV//0UVuJe/4jONdPYRZV
 CZGR0MxgKOEmzL8RZpoud8Y1voUs4esAnrlkJ6ZoN/cmO5hND58Gc4ehnyqYiBvqGVfsp17qS
 +YpenibSXCRSLQr2Zv6UjkQBzAvkxakz4izJT9jdi7ELxQNsDW8AmtbQG8OhmbMM8klrwLBu2
 XK+RmsJojBeOp7cBWLs0r8AtEzOC6r11yTQ7sHMo6/7bPYhfflMabzXUZfcSFWjjpGe9Ud+Gt
 gTI2FV02g/TpyEzEWQol7aV6XVbNhlEp9q9bIsT6SdZNs=



On 2024/2/5 16:09, Christoph Anton Mitterer wrote:
> Hey there.
>
> Is that patch still under consideration?
>
> The filesystems on my 6.1 kernel regularly run full because of these IO
> patterns... and AFAICS the patch hasn't been merged to master or
> backported to the stables yet.
>
>
> Any ideas how to proceed?
> I mean if btrfs just break with that specific kind of IO patterns and
> there will be no fix,... fine,... but then please tell so that I can
> witch to something else for that use case :-)

Thanks for reminding me to update the patch.

I'll try to address the comments in the next version and hopes we can
push the next version into the kernel.

Thanks,
Qu
>
>
> Cheers,
> Chris.
>

