Return-Path: <linux-btrfs+bounces-15303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B2AFC06A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 04:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345E8426485
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 02:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC29225414;
	Tue,  8 Jul 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k1WdjkXu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068362253BA
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940115; cv=none; b=PZ7Nq657AhGWzA1NJIdHxjNd/vhoE15ufPMTQ6YVdbu2/DooZxXI3SOLM+2p95f2tRDDuYpmXLETgaUpKh0Tlwe7GMBjFcEO1evINNRzZM/qOjeC9YOWToIiHUO/pXjqkMGDwWyRVkBIX+20f+K+ZtjA88k2RCZMsPeteZBDQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940115; c=relaxed/simple;
	bh=3B6QDc0MrPw6BJFt9R2lHYq2CKnF/3cTqDPuLPCqi0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+sh1VQEqKwcCJNNUFdnpy2AMshMlQQ6tOtGq67W1ymhL5UR8HtfpF7+ynifb56eG+/PbQRIzIWfjvrEMAgHRsJJ3Z1PUjwTPART35zoNo5H43uos8oZRNF6g/iKCoClERxLscqSrnVupTFKTTKYzTV94TLazrWdPMy9t7+1kFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k1WdjkXu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751940102; x=1752544902; i=quwenruo.btrfs@gmx.com;
	bh=3B6QDc0MrPw6BJFt9R2lHYq2CKnF/3cTqDPuLPCqi0s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k1WdjkXuqaqyKSkH5x5OM0Bi9xt65kKd/AyacyLXfaf64hEQ+3kraQ7EMlyhCw5i
	 g4U8j/2Bu41LPmYQkzZlgRM2KnHXZa95s+pRSnwYed8VfCrGodSxqMFXj0Ndq5EA0
	 MJMc0OPknKZQI/re4ZdFBU/YonDodcER1pFSER/hYDpGwUZ9Ry7OoF0g/lEr66wHI
	 s5eGSi9JTYrj+Awdu5VTDC/bWBSjCBqk0hdYtQft0TpYRjIopotR0jlzlaGDIdLnK
	 xdqG1GsZk+SyfOWJE/FiV5D1NayfeZJryiE7SzLB0rG8rLRY8tFrM89+dT5yAG7JG
	 ODSLmj6nV37HKWFhGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1uq4rT31K2-0135JP; Tue, 08
 Jul 2025 04:01:42 +0200
Message-ID: <283624a8-dc79-4dd0-b6e5-9d5e83e31648@gmx.com>
Date: Tue, 8 Jul 2025 11:31:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Increased reports since 6.15.3 of corruption within the log tree
To: Peter Jung <ptr1337@cachyos.org>, linux-btrfs@vger.kernel.org,
 dave@jikos.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dnaim@cachyos.org
References: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
 <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com>
 <f6d53293-3d55-4ccd-a213-c877dc22935a@cachyos.org>
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
In-Reply-To: <f6d53293-3d55-4ccd-a213-c877dc22935a@cachyos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g5ORfrhqPr5lTLfEW+uvO6vhZEnEFjyMt7/9wrZytnfj96SyujG
 LV7JG9HHzwQgIm0xCbozFyed4KVBV6Yq/me5O9488LWcmgosgBkdUQuLuPKtZHEVLfYNVc/
 cmqrvFQkBOfCwCpy3ekc3/WUtt5bKoxNvNDc580qoiBXgzi3c2RTF/eKG9IW49/LUxv/q+q
 ZgHmgp9zM0cNgEv3wsYaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GwPsLRlIXbM=;IxNv4RtYKo8M6sCAg7g44mKqxEN
 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



=E5=9C=A8 2025/7/7 20:42, Peter Jung =E5=86=99=E9=81=93:
>=20
>=20
> On 7/7/25 13:00, Qu Wenruo wrote:
>> Unfortunately none of those comment is helpful.
>>
>> They do not provide the dmesg of the mount failure, and that's the=20
>> most important info.
>>
>> If you got any new reports, please ask for the dmesg of inside the=20
>> emergency shell.
>>
>> Thanks,
>> Qu
>=20
> Thanks for your answer - but how it would work saving the logs in the=20
> emergency shell, specially if the root partitions can not be mounted?

Just run "dmesg | tail -n 20" and use a phone to take a photo, just like=
=20
all the reporters are already doing.

Thanks,
Qu

>=20
> Best,
>=20
> Peter
>=20


