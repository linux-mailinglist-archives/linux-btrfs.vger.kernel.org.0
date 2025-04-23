Return-Path: <linux-btrfs+bounces-13286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF5A985CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 11:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14E07A98AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BCA242D61;
	Wed, 23 Apr 2025 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NNQBn5Zc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3B262FC2;
	Wed, 23 Apr 2025 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401224; cv=none; b=PK2TGZ/X7/NAkupeT0i5W+0/tJ9SVSMhi0wix7zUn+6im2BUr+Yr43Le3rZKkMBz+gZTYcCJQkGSHsWF2zNOlD8XEXQMvwbvB/4NojNMxkzwbFStZ1kpgFcG5zhvSWOvyAPhOAUZ53GUwpF5v92sr20VA3ZlEHX6vN7x6lZdrtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401224; c=relaxed/simple;
	bh=JzKCzSjUnIoCXgwwd/OzD77S8a2DTLwoIPm20vLrLtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvwSDvDJVpdkPsJsDd9N/0LAkomG1KZHfyjC2KTlv9IxhJyTXFiErfg1HqOGY4GxuSbdpqDW0WofXzQS+w2OWIBDKKRwWV7yLe0ZV8LsHGfF03ND4PIsioNOioRzXrxSG782nB7ql9na7WiQYjfiO1E0k/Dr/B1fDIvDR10l+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NNQBn5Zc; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745401217; x=1746006017; i=quwenruo.btrfs@gmx.com;
	bh=JzKCzSjUnIoCXgwwd/OzD77S8a2DTLwoIPm20vLrLtw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NNQBn5ZcrkcRvPllP4AxTh91rGP/tfLRqmV9G1ciZP7QJULvN46z2BLCYrKXzfhu
	 0Oyf38mUieZmDww7/0A1to4Mq7W+Bb0b98vRHtDkkCwnSstxU8H9AwqedhNwf4GgS
	 7N03aVyMnz2kMCvZ6sF5U0Y0mDSd0RieqDlhJOIu1pxAWEy1zYv4HxWUbh5hK1Ede
	 vUMSRJFa250IuT+tGTeB6UQcy48Cb/nwgcF+2HSfV+b5r9WJFEGpG7mbeN78zUkT5
	 r5Dw3/LvUBCgn77+87hYBpCvKxZVeB1MZJlr6HKlN6Cg+Ohkrg4UK2yxOWuPnve7a
	 u7Xiio7zpmy4Jk7SbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MV67y-1uZbbK3pFG-00VkiD; Wed, 23
 Apr 2025 11:40:17 +0200
Message-ID: <290a2979-4fea-4b17-bb82-1d26d0217037@gmx.com>
Date: Wed, 23 Apr 2025 19:10:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] btrfs: raid56: store a physical address in
 structure sector_ptr
To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <cover.1745024799.git.wqu@suse.com>
 <03dbeaa8ac424885402a6590e393a15d5ae67c82.1745024799.git.wqu@suse.com>
 <20250421114416.GA23431@lst.de> <20250422113157.GC3659@twin.jikos.cz>
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
In-Reply-To: <20250422113157.GC3659@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7H/Y6tbRgcbq2Ln3O+CRzeKJ2DPptB5VJg43huBgVti+zC78sbc
 nYXHQVXxj+xePTD4WW5w3ToYxrMyeMdx3KheVu12qLGmxCPV+QMhJGCKSqq7pDzQP5gZirH
 ILBt12xBoqy3ubYCGGtTn/SHGpsOBWQZahdhZPWzat2O7Quhpu42nm3qbPJJO/oMmTGpHp7
 pCFVo6dEzENn6Vj21ta4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lkJQ67Db3qk=;8+PWF2A7WC7r0YUqbSSer7MB1uL
 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
 A==



=E5=9C=A8 2025/4/22 21:01, David Sterba =E5=86=99=E9=81=93:
> On Mon, Apr 21, 2025 at 01:44:16PM +0200, Christoph Hellwig wrote:
>> On Sat, Apr 19, 2025 at 04:47:13PM +0930, Qu Wenruo wrote:
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> [ Use physical addresses instead to handle highmem. ]
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> I think you should take full credit and authorship here as this is quit=
e
>> different from what I posted.
>>
>> The changes look good to me, though:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>=20
> For the record, Qu added the patches to for-next with you as the author,
> so I'll change it and mention it's based on your patches instead.
>=20

I'm OK with this author change, but to be honest, I didn't dig deep=20
enough into the page frame number/physical/virtual address things=20
before, and all the existing bio_add_folio/page() interfaces require=20
page/folio with an offset thus I never considered anything else.

Thus although this one patch changed a lot, without HCH's initial patch=20
the bulb will never be lit.

So I do not care that much who the author is, especially I'm mostly for=20
the patch 3 to prepare for large folios support.

Thanks,
Qu

