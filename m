Return-Path: <linux-btrfs+bounces-17830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD706BDDC83
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B183BF158
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4F731A560;
	Wed, 15 Oct 2025 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HjnuzStp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873E31985C
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520550; cv=none; b=KIQ5nPjn1iho0ljiOFn2VjzhLdO3f2VfmzCfOqRMEVTPOUfoupa7r8D6/m98VbUT7k3/ehOaIJQI0GhyRB+a/hr903W880Q+yQjucAzdqDKlt79LlONTJiwIri2sDl5wfjmbp+1RoJRP5cAWujAYFUV79tNuPEuqATkPD9nMtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520550; c=relaxed/simple;
	bh=sG9RMLl2ZlRT1MEAfKkqTsDnUhZE9cW911wky37nerg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aE+eQXJF3VFsitYSYrYQw6O1hzxv8X1euCsDXqTL2s07xyPymffX877pGyC9AxRwwUT/OjntBDNAlSM/tF3750IbfMgXdz5BPtig36d9UBiFx+Lv/AEnuJk7NAeNiNzHSBNKAdHKgYbqm2yATXEZ0gusf0lu8XQjwEW9aYsbP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HjnuzStp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760520544; x=1761125344; i=quwenruo.btrfs@gmx.com;
	bh=sG9RMLl2ZlRT1MEAfKkqTsDnUhZE9cW911wky37nerg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HjnuzStpCpPKkRyIblF8WfUKOurKVCZS2aiyC5O2KGgaS5DGrDD9TXfh87qILH/s
	 IjrT+iNpc9Mi1EVqfuu+DKrFgCoFCQF4rRLNx3XYiwVBgcoL+g6O9jiTmEUbDTPEZ
	 ivkysB9TjTjuJjV21ccx3tN0q1gwQGkbCg1w0y0VDDfpF0X2FTslX2Faa34LTRyf+
	 Cs1FYCLF7cTVeQqLaP6sf+ptej8ChaP3XHfIuKn9y8mkDdO46UYZ1VVJDb6ZQ6LEj
	 4BFKY1/ZvgShNNgmtRA5HgWJFBgFYkFOgaVj8ncDVucF++CB/3Lahs3rroxcbIbPs
	 +oJJoRihq6IBbgePog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dsb-1uCRoY2ONJ-014Apb; Wed, 15
 Oct 2025 11:29:04 +0200
Message-ID: <de799203-d008-4539-a4cd-a4bf67457924@gmx.com>
Date: Wed, 15 Oct 2025 19:59:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] btrfs: add shutdown() and remove_bdev() callback
To: Anand Jain <anajain.sg@gmail.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1760312845.git.wqu@suse.com>
 <95520026-f663-427b-b65b-73c8bbfeff3f@gmail.com>
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
In-Reply-To: <95520026-f663-427b-b65b-73c8bbfeff3f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aj5/qNfN5GelspqYIps6JOHiRtjok2Qcd5vBjU46J6qMp+hXSMs
 8MAgCahZ5Isy5fhN6CEhVmnQg5f58ewXi+f3tohW0Wm0ODL4SwP9KnJJzH9Y4Osw+ZFc7eI
 xFs9sIxG3hg4RNi0XpksyiXJq2/i+SYu2tlpzSw3r+zGq1ViprHEsEfN369qcgRzM2L7aSY
 W56TuqG6cib7WH6UzHUaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wWq8iGvVuxQ=;2kadUmE7tFbLu1h55+PLAp3EajP
 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



=E5=9C=A8 2025/10/15 19:55, Anand Jain =E5=86=99=E9=81=93:
>=20
> For the patch-set.
>=20
> Reviewed-by: Anand Jain <asj@kernel.org>
> Tested-by: Anand Jain <asj@kernel.org>
>=20
>=20
> Some distros might need the btrfs_remove_bdev() function
> for backporting so older kernels can handle disappearing
> or failing devices more gracefully. The function itself
> is backportable, but the call stack that uses it doesn't
> exist in older kernels.

New features will not be backported, at least to stable kernels.

For vendor maintained kernels, it's vendor's responsibility to=20
maintain/backport/test/etc.

>=20
> I'm a bit concerned, devices can disappear for all
> kinds of reasons.
>=20

That's a valid concern, but considering all existing single-device-ish=20
filesystems are already implementing the shutdown behavior, and we even=20
have the ability to auto-degrade, it should not be any worse than all=20
those tried-and-true fses.

