Return-Path: <linux-btrfs+bounces-14474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F850ACE957
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 07:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE3E1898732
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 05:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FCE1A76D4;
	Thu,  5 Jun 2025 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SzpmWEEt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33D1DDC0F
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749101375; cv=none; b=JTsL/dBVa5BvJRvVQ7dcBF0m3JLWsPYPVmC1ZsGUkNdbjbQxmRz48qFvguBiW6Q7gWEGWtTE9PIK8O4LXBebERhuQSZ/DXbZrrrpaCE3CV0lbokT/Ebtp0GLpg+2H0TSWZ5RjFyT2pzyWv1GUZ6C0rprFNhVJPuwc8sjldYUUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749101375; c=relaxed/simple;
	bh=7fOQlfvmY8N4+PDb6Qvz7Hdo5ugd+1PTiztvNLlTT6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxbygD1U9SaA3ARIBfS/jV/3W5IOdMydaPnSo/8B2mhV6ATC7noYTUBtBKJCsjbE7pm8/pQlCWQdvvvEu5qC4ox0nd+q7tqsmAxNsoA1z+SG8QLad+8LXEZKmH2gNer2VpMhlSLO8WCNmE/aX5nn8tqBPZfyEighO46vOzd7+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SzpmWEEt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749101371; x=1749706171; i=quwenruo.btrfs@gmx.com;
	bh=7fOQlfvmY8N4+PDb6Qvz7Hdo5ugd+1PTiztvNLlTT6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SzpmWEEtNeG30ee35b0rzritm4wPrx+MoLck1ohgblm9qaCn9xWFbDKbFZxCSSow
	 iu/kuL0e0Iq1DTQ5itC/irm1wIx9IYKR9oNLPIu2pQByMXTeJ5dOgBlN/Bs7zqPop
	 Wrms5h+6DxUkZkGEaCKRp6S8H2wCq4G8DLi/Qi5c5xkSVqy5kLvfZJCkJPX9FS4eK
	 F14pgSFSPiRoFuqDR6S6pZVMZFVxQWNlsOt6cKPiVRK4V585zAjSbGTmF7LnaWmDW
	 li8AdaVrLhUW9lrTfRvOXp7JW1/9vDHUgvo5Zt+0wB8TRIqIWSklcLBqXKuVlCnlD
	 ziweDcjOb/d2SxArSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Md6Mt-1uwepl44ln-00l95O; Thu, 05
 Jun 2025 07:29:31 +0200
Message-ID: <08d37392-a7a5-4c43-87ce-86146e58323f@gmx.com>
Date: Thu, 5 Jun 2025 14:59:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Portable HDD Keeps Going Read Only
To: Matthew Jurgens <btrfs@edcint.co.nz>, Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <83a43be7-7058-4099-80d9-07749cf77a8d@edcint.co.nz>
 <CAPjX3FcqJ-cNMjVia_gYmBZwDhQVxPEOhYYQUzL31m7momByEQ@mail.gmail.com>
 <5de3840d-70c5-48cb-a7c0-7db17e789e95@edcint.co.nz>
 <ffbd0c96-313d-4524-9b6e-b24437fc0347@gmx.com>
 <b2dbfdb5-4cce-459c-8d30-01ac6124d9ad@edcint.co.nz>
 <bdfe67ea-8668-4768-8102-42d78e9537f9@edcint.co.nz>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <bdfe67ea-8668-4768-8102-42d78e9537f9@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tnAzktSHX6X5a4K/I3lBTDRZGxUfyOsxt2BWr75dPMlDv7h6Xjw
 CX6sKyBW8sYaUdtzqAhqM+qnC7OVgOi2d3BE6FcK7TEqoekB7YtAOg1UnRyDpdKw0evqTvO
 G5hJZ2XRNdyavaZWzYZOUC0iINSDkAIf7EmVkUAPcQHhEs1nIqLENj80bax/cvzi35yTFTR
 cvRnGocpNjJaSrQ/u06vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r4pZebpxhP8=;zDrXL+iI5yDWNtjwZhWuakKD6hQ
 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



=E5=9C=A8 2025/6/5 13:22, Matthew Jurgens =E5=86=99=E9=81=93:
>> 2 more rounds of mem test passed
>>
>> Output of=C2=A0"btrfs check --mode=3Dlowmem" below
>>
>> Let me know if this is worth pursuing (for the sake or btrfs) or if I=
=20
>> should be recreate it
>>
> And another 2 mem tests passed as well.
>=20
> If there is nothing here that might help the btrfs team then I will=20
> rebuild the drive.
>=20
> Please let me know if you want any more info before I rebuild the drive.

Feel free to rebuild the fs.

I can't find any obvious clue from the fsck output.

Thanks,
Qu

>=20
> Thanks
>=20
>=20


