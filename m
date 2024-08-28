Return-Path: <linux-btrfs+bounces-7606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833019622F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 11:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A081F24EB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D56915D5CA;
	Wed, 28 Aug 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Y9TfoX4h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD215CD58
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835989; cv=none; b=SSpqf/mZV0CE05kGrAfc/4JOsKgT3IbYp6g9JCwfsgjsU0W4kM07mClhdfuKP/DqoJrWqAiV4sE6hebIm0nSsFbDLUg6JcVKWmvei2CWID7YTZfLMvEPncG6VR4BN8dL0MELDmK8k5tHegtxnTbRkEY6Lf0CnKRNrqcbwBWemh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835989; c=relaxed/simple;
	bh=HRkMT277tDNvQh1mW7ks3IBAgN0T4UQmcDvbtWIpDiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XZe0uw8q4oBzayp4vt2i4MUvIyPI/8ZXz08PDW3MSd/dQyOFDJ6RsLEP9/8ZKwfnK3NNnIs1xZjRYoIv5Z0h0oWWt55IeO88gYuC9cPb4kyIr8QZaqhwdc2oxheRBN4Tps5StWrPhupwdwG4Fwh81AiTiNpf1i/Y0wlT0CgS3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Y9TfoX4h; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724835984; x=1725440784; i=quwenruo.btrfs@gmx.com;
	bh=HRkMT277tDNvQh1mW7ks3IBAgN0T4UQmcDvbtWIpDiw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y9TfoX4h4qRqMxB1IBPLmfOZVjZ2kuTXXaYfION2QBkoSRwCRBf6JEEhVxHBFIRR
	 2GlXcSVgKYSOHCanOYEv4xjy1bB63CRroGdWRRgc4K6tQXXjwSpoq7d8RvdcVnu4w
	 Vnc8Mf4VbEPUDytX4uOKKZjblGLv5u/ETP+3z0HYv1MOSjeAsxC58q1WpxrCtx0g9
	 G/59ufaCeZWYasAU6/IdDmF8uJGfnGZXkSm/eBZFZ8u1McdA+TUzY8ynA6IeHHhfO
	 k9++bffm1e5YdrDPAJeNw956xFcPYIUWg2YI7mlTbmzOtKPKnU3LQqoDjTTTclVYr
	 TTUwZNjj7X1SsWR25Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1ssZ6X3Hfa-009g0Q; Wed, 28
 Aug 2024 11:06:24 +0200
Message-ID: <e4713bf6-7c52-4ab4-b2d8-567391e67f1d@gmx.com>
Date: Wed, 28 Aug 2024 18:36:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
To: Pieter P <pieter.p.dev@outlook.com>, linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6d90baa9-ffc1-4c9d-87b2-4ba89983bef1@gmx.com>
 <AS8P250MB08869C932AF99C5C087F1B408F8B2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <012717c6-4e7e-44e9-9906-5f13e4273c35@gmx.com>
 <AS8P250MB08866EFCC85A9CCCAF99E65E8F942@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6f7117dd-a9ba-4c0a-be4b-6adae1be98d3@gmx.com>
 <bc8701ab-0054-48c7-88d9-6fd9e856cde7@gmx.com>
 <c29529ca-e6b5-4979-a25a-b254a4d800d0@gmx.com>
 <AS8P250MB0886524C03F0508E132BCF7E8F952@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
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
In-Reply-To: <AS8P250MB0886524C03F0508E132BCF7E8F952@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WclegnyJOTl7ixAAlhSBWLBANGCkzrSMTVelqosWkjBaxq1+2Sd
 lbvdGHJcG2bwg/5w/odVcRpV5JgXG1dJqO5aKFxrjmCu0dMGOSfY5KqOCXURnAZ+RLJmorQ
 u3R3HMIpJlDaRHGcQN0sevVP3R8Uu2b0zi/WhmQeWwDvMkdeKJWjAKP+uxGkc4m25JMTciv
 SqoYxAMuuVWfUgqw+K1VA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1Xdv/gcVNuc=;8ywsPo8sPse+kgd7FlXlXKfYt99
 jWp8Dxiu9WcyKFKV8pQXvQ4oH57yvfEXu/4Z7FCRP38yc5ac3QgTAg3xbUlBI+ghVsvlwAses
 4BLDEMcLCL0SgVWihhbclj3j7WFO8u7I5l4P1VaqtGLAaXUYNRBwHzodIQuEt/HUWjrmWDs6s
 F+9i1klxVo3ZMPS0oItzSnrep5I9BuoMZW/k2i2iS+fCN7hoLi293mhZD7Qc56fHqt/n3IjTM
 9yMJFVem2dP43QDzsGbjq0JmW3NcN6MG9siaoIPYjDU0y4nn5swzhyj2TTOG6U2Fv9QGT0SyA
 KXuXGozYcxwW87RqtbNVPgL0Gz1HC/fcwCY1suskREC5fYy2kqNAHYDrhVmcqDVDkwLAStcMY
 pSzthz6aCuqolKTyTY04bPZcb8NZI4KmDU6End4H2e1vQ036NeX3nl09JZ6OUjtz+wBgcCyAs
 xvQ9/AbuXV91UsVKb09ewV39UZR00nVnC9GGLB2BKBY9ShHpyoILpsdHAXdv7dUYljUNVoNzX
 cGgzE+51i0Zjfpvzgx8bPWpXKPE7tQ0B1x+YxzVAoxN7KHRs1mzCn6YZQiR80nFF+qFbHfZpU
 wnTI8xVV4r3uZ/cxa04wt4fGtwjSwFxFqgSrFQuvYDmPtEZ52O2oUOG19JCutlKjpW3IkJwKd
 r4jBFLVvupaTMC861WqDyOCs/eFCRfh49fXvYLs25m5mDuRrPwMad0+fwaLqhsu8fPLs232Fo
 xnlso5Xb9ketFGqYcO0NKTJCpsOy4llQ+xRDZyS0EZOJyqbu8Z/7G2uh9L1Y9IWpFPIyJDP9L
 o5VwSwASJ73EcSAOB4+job538IR37RkVaF7TO4EmVs9XM=



=E5=9C=A8 2024/8/28 18:19, Pieter P =E5=86=99=E9=81=93:
> Thanks, I really appreciate the help!
>
> On 27/08/2024 11:33, Qu Wenruo wrote:
>> And it's better to run "btrfs check --readonly" after a successful run
>> (the successful should result no output), and paste the output of the
>> btrfs-check.
>>
>> If there is something wrong, the program should output something and
>> please paste it here.
> btrfs_search_slot did not seem to like the combination of trans=3DNULL a=
nd
> cow=3D1, so I tried both btrfs_search_slot(NULL, root, &key, &path, 0, 0=
)
> and btrfs_search_slot(trans, root, &key, &path, 0, 1), and the latter
> fixed the issue (see attachment).

My bad, forgot to pass trans handler.

Thanks a lot for fixing my mistake.

>
> I no longer get any errors from btrfs check, and I've verified the
> contents of the file system against an older backup, all important data
> is still intact, and everything seems to be okay now.
>
> Thank you very much for taking the time to help resolve this issue!
> Pieter

No problem, great that your fs got a full recovery.

Thanks,
Qu

