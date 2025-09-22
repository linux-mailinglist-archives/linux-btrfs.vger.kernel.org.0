Return-Path: <linux-btrfs+bounces-17040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7B1B8F516
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 09:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAA83BF600
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF6B2F619B;
	Mon, 22 Sep 2025 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MnP44K1m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6792F6169
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526874; cv=none; b=D1SkPjOYtGnKpmY1BlLlqWXmDJ3TLDq1TleKWAdlt/8ze/aVYkYhEJeuHdI9GOcXYeP3nDmwbyAY3UqHMvaCvzz5PFx0JyFOhv7eFA3wdZT+SisE6buQwC63X/5KFlnsRuC2NQycbJxDkpU8HYKaXoZr4yf2jCYjR5r3mNAs1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526874; c=relaxed/simple;
	bh=6alPg3KM+Ctk+TBnMRkI+zk5GP8Bbg39Gbne2wsy218=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XXF5eBzkRo/DveIMRYaRAl/5Oop97jubWB0Bpj8t7l1uVvJ5xyrQRwPADupevxTWRZPO0lb8b2iUZfnPv1G3LhZ46SXh6BQqrXu8SJUtsWjF0Ud7cw/DhnSXQir0xQlrxngD8BbXRSwQttEMFsYZbajYK+lUcuRhDGZypYwxcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MnP44K1m; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758526868; x=1759131668; i=quwenruo.btrfs@gmx.com;
	bh=6alPg3KM+Ctk+TBnMRkI+zk5GP8Bbg39Gbne2wsy218=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MnP44K1mWrgPdA6clXA4AEF/4f4dkoIT9/wjcStmYsv8Xy2dt3e59IXdE++SvXGV
	 9T7x54hDbVr3tmT7KNnSXlJyQEBZraEmYAU+6nIc9dDha4z1wbfyw4N/zn4NmGIyz
	 BTymokHq2V8VIbfHjiKZVF0C4mt0jJAhlnyc8Jk81XKpEC3RVfdUkHIuq7DnRRDBH
	 KEhkgufZPPQ/WgfdzYv6m9gkPTWXL9qnGvuQ3tKsXmCHywYBnVgM/w8GfaIuHRY4D
	 xT0qUmHbcvJgjd8nP+kbP7kjG5cNUaaeWE7WRbxIsY+fDK53xP67y6VuGq60NUync
	 UR877ZbdIG/2IB3l+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1uZAiH1n01-00qht5; Mon, 22
 Sep 2025 09:41:08 +0200
Message-ID: <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
Date: Mon, 22 Sep 2025 17:11:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
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
In-Reply-To: <20250922070956.GA2624931@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Amo+Vp2iAgUb6ZwQS9FNMdC7n6A9CddSpNY/ybfpqtnANMDFBz
 e4QFWjwZGK5meyUEKqKUSJONa0/nmXvYL3SKFHATw2WRIkZNnDCYrLiJLmysBsCQOmvN+Zi
 SUu/V0Y/p1pbydk3K2AOVu+ufBVFDun6AGD5DNqyNzXYXldQtcw19YXs08WH4tCnWZFy17x
 G/S+YjUqksOfye8llTstQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wavqXqq2mDo=;qMBpqEPW5NfCPph5k+cIpmdYwdg
 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
 ztE18UU=



=E5=9C=A8 2025/9/22 16:39, Ulli Horlacher =E5=86=99=E9=81=93:
>=20
> I have 4 x 4 TB SAS SSD (from a deactivated Netapp system) which I want =
to
> recycle in my workstation PC (Ubuntu 24 with kernel 6.14).
>=20
> Is btrfs RAID5 ready for production usage or shall I use non-RAID btrfs =
on
> top of a md RAID5?

Neither is perfect.

Btrfs RAID56 has no journal to protect against write hole. But has the=20
ability to properly detect and rebuild corrupted data using data checksum.

Meanwhile MD raid56 has journal to protect against wirte hole, but has=20
no checksum to know which data is correct or not.

>=20
> What is the current status?
>=20

No extra work is done for btrfs RAID56 write hole for a while.

The experimental raid-stripe-tree has some potential to address the=20
problem, but that feature doesn't support RAID56 yet.


Another solution is something like RAIDZ, which requires block size >=20
page size support, and extra RAID56 changes (mostly much smaller stripe=20
length, 4K instead of the current 64K).

The bs > ps support is not even merged, and submitted patchset lacks=20
certain features (RAID56 ironically).
And no formal RAIDZ support is even considered.

So you either run RAID5 for data only and ran full scrub after every=20
unexpected power loss (slow, and no further writes until scrub is done,=20
which is further maintanance burden).
Or just don't use RAID5 at all.

Thanks,
Qu

