Return-Path: <linux-btrfs+bounces-19580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ADFCAE276
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 21:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F2FF304111E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FF32C2368;
	Mon,  8 Dec 2025 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MUtZNRzl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CC1A9FA8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765225615; cv=none; b=jfB4ttTTgA0n6Ciowt1CwkeJGHdCW/FuOe8Q6B/of1OhHTL6zAcLcgwScwVfdGrIAnpwwiVWckwJWCXJZ1gj9H0UaXLNfxBLNHIWNx1bzd4dmfq6tF8ZlvwxUQBaPzmWjCVTczSJCjKCAM/KwJX137HCs9cVV7U/IpZq8NWMonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765225615; c=relaxed/simple;
	bh=unowFCT+S+eege1c3CX0C5EXxO7A803osv/bp1mReJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTf3O52+tr79et72XB6uXOP/5aabFjstQ8HPMCAzj5B7Dg6ssiP3HbppdKHKHrSiBo2JEbDm0eZBDL/+pkvmYHVjoa9+SUyHMCM2DIeB2BnVckHRZW0RID/8ReQGzTmO8XuCdyvrz2UHB0u46+TX25vPmcbXM1QvbCNOtpSnmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MUtZNRzl; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765225610; x=1765830410; i=quwenruo.btrfs@gmx.com;
	bh=eU7HqGYI4N9/xIH0VAxPMMvuP7yug9KsVkYnylS5tM0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MUtZNRzly+cSQYAo1nyXV8dey9G5AjLLP8m88GFLD6aF6cNbnl84R4f+OUxFl5K9
	 sEjHMdjyKqlRLEAJKcsceIA21tBXJXy/aA3eMrLrdHIWcnTIJEfrzF1Kf91vUjIb0
	 lTfAlxi1nvjvbhPcDMHh1LTevoOLhqJKw9Cr0SBp0parOjBRjf65l1OL75dyvTT7M
	 UfjX6/64VqeLe9rejl0XZWs28020x79OafpIeiMtfof9Jvku7UKLZZKhPsmojr8OW
	 CYKeT4Pq7k4HkiSIM+TROr60F1bzpzGIFtFq5to6nqtCd7Eo4x1+3xyujLdNiEVUF
	 7PXwpBTOn0mseFcGVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbAcs-1w4FUY1BE0-00jXak; Mon, 08
 Dec 2025 21:26:50 +0100
Message-ID: <3bbfc8bc-0b15-461b-90a4-a59d2b7fd97e@gmx.com>
Date: Tue, 9 Dec 2025 06:56:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: shrink the size of btrfs_bio
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <7ef5de8f907f74520338f0ce46f36f1335dc6e2f.1764921800.git.wqu@suse.com>
 <20251208191903.GA4859@twin.jikos.cz>
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
In-Reply-To: <20251208191903.GA4859@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vfm4NB9e3Nl3wwoMNnmM7Cbgf5YfL+MUwkTTFdeP+/WnYpyEU3P
 Im+EC82aFJi0H32V76HUdJr37YsKP1bxl8azMPcDFMsF6LvboYEYgzvhPAblcIRTtErzmSn
 ZY/rb5O0VabIVXy11J8zKkKnSBkVqF2DJ3seOGTn2sQOm1lMNCwW665WO7ldEQpqInUcBVL
 I1XTiQaTsnTkSNyfV0A1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BSDjClYf3aw=;izJus8jG2iHABxO2SZ07uORiFIX
 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
 8A2U5LcCUAcTZslkU=



=E5=9C=A8 2025/12/9 05:49, David Sterba =E5=86=99=E9=81=93:
> On Fri, Dec 05, 2025 at 06:34:30PM +1030, Qu Wenruo wrote:
>> This is done by:
>>
>> - Shrink the size of btrfs_bio::mirror_num
>>    From 32 bits unsigned int to 8 bits u8.
>=20
> What is the explanation for this? IIRC the mirror num on raid56 refers
> to the device index,

You're right, u8 can not cut the max number of devices for RAID6.
(RAID5 only has two mirrors, mirror 0 meaning reading from data stripes,=
=20
mirror 1 means rebuild using other data and P stripe)

BTRFS_MAX_DEVICES() is around 500 for the default 16K node size, which=20
is already beyond 255.

Although in the real world it can hardly go that extreme, but without a=20
proper rejection/sanity checks, we can not do the shrink now.

I'd like to limit the device number to something more realistic.
Would the device limit of 32 cut for both RAID5 and RAID6?
(And maybe apply this limit to RAID10/RAID0 too?)

Or someone would prefer more devices?

Thanks,
Qu

> the type width should not be too narrow. But if
> the semantics are different we can reduce the mirror num in other
> structures as well.
>=20


