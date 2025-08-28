Return-Path: <linux-btrfs+bounces-16516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B421B3AE9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 01:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F5F1C27D18
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1172DF6F4;
	Thu, 28 Aug 2025 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HNu3vUlu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF32DE71B
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425023; cv=none; b=cJ7kMhInMIXgjjsa1qYFmgHleqAfpGDpX/FNHEtTXpZCxOEq/uHexX9BXWLK4Ueo7ck6muO+wjX/lHLKQ8fJ17B1ktBI+SaiGKNViNEd8Fp3tZYPkp0ylu4556hrf79zGi3E2bsgrFR7qPPWMd9Vzg8ffRsiKbvyQE85IpNfqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425023; c=relaxed/simple;
	bh=vENI+rALztHLviDvuVBmrQ3jH6dUFSisW76kmilWqxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYG9wDGeRuOTEZHXFtZh9cCN9ofhSl7H6OF5PEEkyDqC8Ga68CZtjAOuZmi12TPSvRu3pW+nJWQ2DzyT4+nPBBmIedDPNrz3h+XLtpN4T/Z7/1q2inyx0A13QTE7NhLhPRYR7TGO0g8tbBUnfs3vonA8hXzI9JIZBsG5ZEJciTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HNu3vUlu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756425017; x=1757029817; i=quwenruo.btrfs@gmx.com;
	bh=vENI+rALztHLviDvuVBmrQ3jH6dUFSisW76kmilWqxc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HNu3vUlup7ieyKwPdFR2H4BQ8/KYBGV6Ha/sfH6ykkOkE6XBnsGE97dhi1rLJXYp
	 7T/tu0hJ/pLLMV5RatqlEajtT6qRD/07x7AVPDj2zU8xRV62+2O/gb0DXk0nYEG/0
	 PUZB39oHxFh3McLpCdnP7iMnAzJa7+BfB9nWDDK7ScO18aPyE3FTxmlrW10lwYsMT
	 k9ngGlCpTyHzW59XYLzuCrXOkVAhv8XHI/4Hhd4GwZ1uYoGd8WA6IYmSj5Bo323Gr
	 PCARM+lj3Xj5RJdFmucIviGxEnGK+s/yWjZzlJ3GBLIn34Sj6ys7a1OLGOSgMvaeg
	 MP86gvDW88pNprW0Sw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1uUR882VMi-00yBF5; Fri, 29
 Aug 2025 01:50:17 +0200
Message-ID: <48b9874a-2139-47cf-81f5-3af8ecfa8dc7@gmx.com>
Date: Fri, 29 Aug 2025 09:20:13 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: add 16K and 64K slabs for extent buffers
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1756417687.git.dsterba@suse.com>
 <8c448bf2fcf0c2e7b52c05234d420b78cfe4b1d7.1756417687.git.dsterba@suse.com>
 <e776e393-896c-4d96-89bb-dd8b18042caa@gmx.com>
 <20250828233011.GE29826@twin.jikos.cz>
 <5a261aae-d172-4481-bde2-633184f285f2@suse.com>
 <20250828234542.GG29826@twin.jikos.cz>
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
In-Reply-To: <20250828234542.GG29826@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cQp3fZ9b2shETIkrVLvCy3XIh5z1NQtmQpDRWhVEUYaMJ8AhcOf
 WS9Ki1WuZDg3WfJ6Tth2KTqGvtllC3ZfYbS5kNbe1k/Wfe7N1M2emPh0ovoOh+ozsN0ORq2
 Av5SWEzkeEBBEtdC4QADjy7N3mFafZhr7woHpRyTzlYHI9y6CR2c7Iw/gke6cHGCdiHGXs5
 eioGPIwMwskbEQyvyb3nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eQKMhFHq0PA=;cFocJVoAW2YU2GJzjpEy2IwV9sW
 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



=E5=9C=A8 2025/8/29 09:15, David Sterba =E5=86=99=E9=81=93:
> On Fri, Aug 29, 2025 at 09:04:01AM +0930, Qu Wenruo wrote:
>>>>> There are 5 node sizes supported in total, but not all of them are u=
sed.
>>>>> Create slabs only for 2 sizes where 16K is for the default size on
>>>>> x86_64 and 64K. The one that contains the node size will be used,
>>>>> possibly with some slack space.
>>>>
>>>> I'm not a fan of two magic numbers.
>>>
>>> It's not magic rather than optimizing for the most common case which i=
s
>>> default of 16k and a fallback. It does not make sense to create a slab
>>> for each supported node size while only 16k would be in use.
>>
>> It is. And all the two magic numbers are all based on 4K page sized sys=
tems.
>=20
> No, it's based on default nodesize in mkfs.btrfs 16k.
>=20
>> This doesn't look good for anything with larger page sizes.
>=20
> Which is either 16k on macs and mayb ARMs or 64K on ARMs and Powerpcs.
>=20
>> E.g. on 64K page size systmes, the 16K makes no sense and will not
>> allocate any space for the folios[] array.
>>
>> That's why I hate this two magic numbers based solution.
>=20
> On 16k page systems the array will have one entry, similar to what we
> have now with 64k page systems because of how INLINE_EXTENT_BUFFER_PAGES
> is calculated as BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE
>=20

It still doesn't work well for 64K page sized systems. As I mentioned,=20
the 16K cachep will have no space for any folio entry, and only 64K one=20
makes sense.

If you really want to use kmem_cache infrastructure with variable sized=20
array, please move the extent buffer cache to a per-fs basis, so we=20
don't need all those weird "optimization", just a single eb cache no=20
matter the page size/node size.

And also, please fix the size calculation to use round_up() to handle=20
large page size more correctly.

Thanks,
Qu

