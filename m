Return-Path: <linux-btrfs+bounces-16136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD49B2B3A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 23:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10F91BA214D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895B1E51F6;
	Mon, 18 Aug 2025 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Sk1r0Tmp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF31624FE
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553658; cv=none; b=ivziUcXqNYSWJJl6T44aTqbQhVQZqu8lk0I2ut1IPNiVwWh1cujShUOiu0lH77n5VUtojqKdVQKMHHCbr0Uf1pDrCsVaaiHv2AKDZqDq09BaLpYEPXG976RrcfVdWfFUFzcj3UFqw00L+++9DYCo2f/KM2y9W2UtEZ8yZTtVXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553658; c=relaxed/simple;
	bh=0qUrSPt5O60k7nX+tImhrRexeXt3TcnhgZQEWgq3eaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSLMoRh5uo49ZweCcBJ3k98tKxXjDG0wrz6BxT4VjKmTGPBxVGH9xBgdO86ItE+dNO+JlzBLZgy+yT8PbPPhBb5k1QpqqZU/80yMC38zUoytnexbdt5jgG4affIsriKv0bavVv2Jam/0tac2TJLYvodGJ+wd4HxPHK3Ckz5RN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Sk1r0Tmp; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1755553653; x=1756158453; i=quwenruo.btrfs@gmx.com;
	bh=2d0CcqDBIxJqvA7M+R4KxUDdknQfI5bVhG5Vk9OE5cA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sk1r0Tmp0hCJir1/K6hwgzcUm4PbSZS3bg0+yHoHvGN309/YgAMlrS+hFZig+e0U
	 KG8kJMI8WvYDGWRJaDHZmvwGp8qV262wFh3mFSPSKE8kzpIyWRmgFx8LB19LxuoSr
	 Hh80CKER9GIIsle+fRVg7MExaDf1fTuaGqRJlNs6p9IHJxaQsLsYxTmicWKmiFc9/
	 xLlmD4powcjzB20vxuK+Uo5YjtPsINpwU02ek9KyDERteQ9R8qq7F7PRgmxALJRC0
	 HOlu5sE32qs538wHRKOF5ndmvsnUS+dJudsJeBfgN5N+SELX3Phx9zWRUebXJCpf/
	 KTbIuqZ8YOSavMdQkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQgC-1uaq2O3sw4-016xJy; Mon, 18
 Aug 2025 23:47:33 +0200
Message-ID: <afd0e356-973c-4007-9603-88d690bb23aa@gmx.com>
Date: Tue, 19 Aug 2025 07:17:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] btrfs: btrfs: fix possible race between error
 handling and writeback
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1753687685.git.wqu@suse.com>
 <20250818154812.GO22430@twin.jikos.cz>
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
In-Reply-To: <20250818154812.GO22430@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sUro9yfNXnvdcHymRkWK9v7pEq01cbWYfUJQ+vrOHJMw+z/F3mR
 wHhvXZ8OUyorTFSwmZPYSGosbzXeN6kleitPM1AgeXHkNK7dFQyH+GVcY3/zJvBxsWdd7Y2
 HA+Xl3Veivkye/46EyK56CZ0Fn55geLVLh9wU0BW9YiCu/gi8a0YleH/zSbvJtyEVINEhuG
 QsWpxZbppPryFR0WtfBqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Werk7gZe0vs=;S9o7LMgIBVBj76g/Q361TVGTxP3
 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
 7RB6RL9LUxeRfT9k=



=E5=9C=A8 2025/8/19 01:18, David Sterba =E5=86=99=E9=81=93:
> On Mon, Jul 28, 2025 at 05:57:53PM +0930, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2:
>> - Add a new patch to explain the error handling better
>>    This makes the later nocow_one_range() error handling change easier =
to explain.
>>
>> There are some rare kernel warning for experimental btrfs builds that
>> the DEBUG_WARN() can be triggered from btrfs_writepage_cow_fixup(),
>> mostly after some delalloc range failure.
>>
>> The root cause is explained the the last patch, the TL;DR is we
>> shouldn't call btrfs_cleanup_ordered_extents() on folios that are
>> already unlocked.
>>
>> Those unlocked folios can be under writeback, and if we cleared the
>> order flag just before the writeback thread entering
>> btrfs_writepage_cow_fixup(), we will trigger the warning.
>>
>> The first patch enhance the error handling of run_delalloc_nocow(), wit=
h
>> proper comments and charts explaining the cleanup range.
>>
>> The second patch is a small enhancement to the error messages, which
>> helps debugging.
>>
>> The third patch is to make nocow_one_range() to do proper cleanup,
>> aligning itself to cow_file_range().
>>
>> The last one is to fix the race window by keep folios of successful
>> ranges locked, so that we either unlock them manually at the end of
>> run_delalloc_nocow(), or get btrfs_cleanup_ordered_extents() called on
>> locked folios for error handling.
>>
>>
>> Qu Wenruo (4):
>>    btrfs: rework the error handling of run_delalloc_nocow()
>>    btrfs: enhance error messages for delalloc range failure
>>    btrfs: make nocow_one_range() to do cleanup on error
>>    btrfs: keep folios locked inside run_delalloc_nocow()
>=20
> The patches have been in linux-next for some time, feel free to add them
> to for-next proper so they can be merged. Related to that, you can
> remove the cow fixup code in this development cycle if you want.
>=20

Unfortunately even with this series applies, I'm still hitting COW fixup=
=20
warning at a very low chance for g/475.

So I'm afraid we're not yet done about all the possible error paths,=20
thus no removal of cow fixup yet.

Thanks,
Qu

