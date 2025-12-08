Return-Path: <linux-btrfs+bounces-19582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A7CAE2D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 21:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2122304D0D1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B22F0C70;
	Mon,  8 Dec 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aH+659wd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDD2836AF
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765227245; cv=none; b=Cj4uc9yID5gCgq42a8RSRqEk5/Eopa/1AcJrAnohoiUxyQlDNDeTpVdMNqethcphEUjRToZjQLJlRyvZaCR8rraeLweLCh8i3ZimEQxgHatcMHaX2u8e+jDSdYa7TGEiDlRHGlh5IhGITTAiJ76WiMXjaJ0gC6bFO6el5kmiJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765227245; c=relaxed/simple;
	bh=TmDTyUzSj8j7t9MSpJmPw5tTWqymNSPFNIjUWWgXsT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rr7z+VYT2qs6m2S7VH3SZcdb+Y5KhkZdrs5bpsNOw0iZy66D6V2PlaRLFG3xm6rN79SPxDJhmnah3AtyLzFGCdkg18Prq1OWIDBMnUEHeV/caXDFstO9ZmGeggL24HhIQwVkoPtGIrWEqaggABxtxUv7mapVldqO2bq2EO+a40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aH+659wd; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765227238; x=1765832038; i=quwenruo.btrfs@gmx.com;
	bh=VJsUNqTqi5pDBVHVnQYQFK7+UJnR8YvxeMDo5GLzaSo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aH+659wdYArP1wYaff2h2WjkOdtOiQYaQiUngJqL5GDHm4wdAXEg3oQlC8F4iEXH
	 lVqDlVfv0uEnyNhuPpSigAyk+z4Dcw7SPFYzBjlD19t0aEMvx2G+7kxRimpT1tji7
	 cy2dxQ3lmMRQNhnjWaOF6BZu/BHd6XunFS/Bw2b/WScR19BHMhUHtwmMJyYtDowLa
	 UAgDmCdDA8g1/B7B4/oDtYFgRhzqIX5b3CY56r1muoErgffxsM+RWOEUnNEGFs4ss
	 +qVNAOokKQTMiEGN72aReJYIIHz+VFxbfW5uAOHadlNnlq9rxpu4e4w5phwgCQEE8
	 cvxE8npX8MCrdwJ+vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuUj2-1wJA8d1cHK-013wtJ; Mon, 08
 Dec 2025 21:53:57 +0100
Message-ID: <b77a5a1f-3c8c-4a43-bd1a-bc392baeecee@gmx.com>
Date: Tue, 9 Dec 2025 07:23:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: shrink the size of btrfs_bio
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <7ef5de8f907f74520338f0ce46f36f1335dc6e2f.1764921800.git.wqu@suse.com>
 <20251208191903.GA4859@twin.jikos.cz>
 <3bbfc8bc-0b15-461b-90a4-a59d2b7fd97e@gmx.com>
 <20251208204420.GD4859@twin.jikos.cz>
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
In-Reply-To: <20251208204420.GD4859@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jnUI80sB0JdVYe0ZF4Fx9juwP27gYszS52tlxS2RXsj8noeZjn4
 41pJ7u0OfFJ9csyPoHYAirEv97XcoLaV/EGF7WZQrFtqk1NlWeGjVsAPAR5SSANLdKmLbnl
 n6s0y96fRnS5d960pWbcEFytsGjz407X/0EuSWFSx4aSSwuRxW7UobhXVQ4/JNfzNSyZEgU
 J9F9Xz6C4iFqzz6ctAWtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k9d2r3/vA+Q=;NlUyKMsLiKgE8LnssKZ9J1ty6nR
 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
 TKi4CXgKfz2I/O8z0=



=E5=9C=A8 2025/12/9 07:14, David Sterba =E5=86=99=E9=81=93:
> On Tue, Dec 09, 2025 at 06:56:47AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/12/9 05:49, David Sterba =E5=86=99=E9=81=93:
>>> On Fri, Dec 05, 2025 at 06:34:30PM +1030, Qu Wenruo wrote:
>>>> This is done by:
>>>>
>>>> - Shrink the size of btrfs_bio::mirror_num
>>>>     From 32 bits unsigned int to 8 bits u8.
>>>
>>> What is the explanation for this? IIRC the mirror num on raid56 refers
>>> to the device index,
>>
>> You're right, u8 can not cut the max number of devices for RAID6.
>> (RAID5 only has two mirrors, mirror 0 meaning reading from data stripes=
,
>> mirror 1 means rebuild using other data and P stripe)
>>
>> BTRFS_MAX_DEVICES() is around 500 for the default 16K node size, which
>> is already beyond 255.
>>
>> Although in the real world it can hardly go that extreme, but without a
>> proper rejection/sanity checks, we can not do the shrink now.
>>
>> I'd like to limit the device number to something more realistic.
>> Would the device limit of 32 cut for both RAID5 and RAID6?
>> (And maybe apply this limit to RAID10/RAID0 too?)
>>
>> Or someone would prefer more devices?
>=20
> I'd rather not add such artificial limit, I find 32 to small anyway.
> Using say 200+ devices will likely hit other boundaries like fitting
> items into some structures or performance reasons, but this does not
> justify setting some data structure to u8/1 byte.

By limiting I mean limiting the number of devices for a chunk, not the=20
number of total devices.

We can still have whatever number of devices (no real limit), but a=20
RAID0/RAID10/RAID5/RAID6 chunk shouldn't have that many devices anyway.

With that limit, things will work like this:

  The fs has 64/128 or whatever number of devices, but when allocating a
  RAID0/5/6 chunk, only 32 devices can be added to that chunk.

This should not make any difference, as 32 devices is already too large=20
to make RAID0 to have any real difference.

>=20
> With u16 and 16K devices this sounds future proof enough and we may use
> u16 in the sructures to save bytes (although it generates a bit worse
> code).

16K is already impossible for the device number of a chunk. I'm fine=20
with u16, but I really prefer more sane default limits.

Thanks,
Qu


