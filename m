Return-Path: <linux-btrfs+bounces-14518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97544ACFBAF
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 05:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000453AD28D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 03:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE81BF33F;
	Fri,  6 Jun 2025 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="idsrmvLq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B6D4A0A
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 03:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749181260; cv=none; b=DYNbQjoN81GReEbRLo3LZ3dDx+rIAxWV34y7XCYMzNQdj4vhIIqaNPqF9sb9ZbDUATK1hIvfIZJHLtV1Q19MHvCq2ZWwEhtTSlVBKBQgqx2p3DiuuBTVkbaPOEdHyhnswSGeBbiXR5slsIf4AKEsNwPTaYwWNCA5mCEAv7Wvbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749181260; c=relaxed/simple;
	bh=2u/wlD9R0lP/89iRSTJ3LHLzm6q1RarR8LaWTIC4+EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eycFh53UezXEWxhhijY4mS6gkgUX3h9z3/Lz1dFkVCjIfxXVjv1pbhvS+EphTw2YTMtj4q3JafMh0jMyWCX3FD6vs5tp4bhPHIXQ+na9UeF0hn5o0jXoapZkja2UqN3YhG/w8qsJUFv7Ai0gQCEk8w8sEPqLpNTbE0N1U4CTMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=idsrmvLq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749181255; x=1749786055; i=quwenruo.btrfs@gmx.com;
	bh=H0XcLCwmW1nZ3SV3EW0cDam03mbRh25edRDYopDoVY0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=idsrmvLqqJ8N3jGz9GJy8g2ypXRCTEQ31svlI9ak2VZJJu1urVvkDyfKC3FP2elN
	 zu/FY6yiZVVoAv3wGx+VerN1QCvNOMG6My6MznrC8RAX4fU9QO2pJhtr6ZXrMBWI1
	 UxjMuG9itKkWXO8FtXyT9BnXXeQH7mYAL1OrO0/HRL/lqNWNOilEKxhyEnWsmus7M
	 zJzE+fgbDyZRaEkIB9LB/YXGCGyG1ETPM11+HHaKo4U10tmCk7eP6/qDlabsiuAyJ
	 22T1sVozH9notzse0lwuFyyPoxT5VVnbL//ZgcjDnDypltq/rs5k3Bp1nPmq4IFvE
	 dyTESmKWTz0xe2jHnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbIx-1uVs8m3eVP-00FxoG; Fri, 06
 Jun 2025 05:40:52 +0200
Message-ID: <f2799f7e-1a5c-4f8e-adc6-02fc06f33d68@gmx.com>
Date: Fri, 6 Jun 2025 13:10:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: enable experimental large data folio support
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <899362450597548e37a52bba61f0157e929eb901.1749025117.git.wqu@suse.com>
 <20250605214226.GW4037@twin.jikos.cz>
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
In-Reply-To: <20250605214226.GW4037@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zmhz8Avh5IzzYg7WGShRJLCgM6U4qSQou48VJFFBMTNW1PfsZyO
 7GvAb2Fl788hlA/2v4kXnDaqCymKvsU1lZqpmxXr4XLW6ez9Mn0yzEN71Wx1VLmx4zLV13r
 J9r37Yc93xZSTkhapUl8VJTSQVky0i8zMc9D0UyOlgvhhxK0RO6ti7TryA0Da/KQUxptjUU
 p/b6C9jukL+H4geeF+j7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lboYkZ0v+ew=;nESycVMLQoqd9TWfEw5S+hfNWxu
 mvi7zN/ahxOKhXIJWtl8c6wNOtXBmglMmLA7Rms59i18tObxaAU9EFjEoyug+DKz8aQcqZSPq
 uw+wLqbAggUTCliaGYJ0dfQpCrfLaDHj5DeZbrveZYFBOOIS20WgbF0S6p6/Lhx4EL75ZTQSJ
 c+vbXghlV1tFGoGwJ+IX7iW/mTyfdHzZFq9586HRWdIzbSkbzkGs9AQG/jfHF40689n83M7Bm
 ITemz+mKHlThDFanygUKT9+s+aYh/BQaig4+h+NlzYT4plFaMCPLDySJFgkYPpR/TRiWUOeB9
 MnmDQAc2/axMdeYNhEaIU/cwUsRyJnY1ju9WSe8l2aPNioP+TAiQpVHr90xeugbhyOtOcdEsp
 e8ve1E+WG08YdOs/zyh1PFpp1wwqA/oTotJ+oaWGsHUveSabIYjD8D/XITJ8FKJoP0lNMyOpG
 RbvEkYzcNuqR+5V8EZlkMQMHIKvhuKWISvA1Bz7XpTAmplp9/esCa8qYdA4lTWB1RSdN6Kgs5
 KuH42QGnN9kPnahBZ5DAH++HBQn/iv1dRKFkwng1FwIdYjyBd89gTltDntA9ujBwwWo3VJvgb
 dvMVCiLelfXSaKZALVUOzckZgSsjsKwVI4o7atfsojXNoMpyxQGz4YBn9ifel+HcdbFiXSsvb
 S9H5JHiztSa8w/csQgqyHFkN9wNYKUSrEGBpQeBjirVJPqRq6XKqQgxfF1kqsc4J8HsnNMXCM
 25E+mz+ojJ5reeQwyF+29SNEGhbsb3dUt3bzZWLcmv+atWQg17LZd9qcPXTkDz+4jeGOYVK8U
 b3GFnpRJclTuxZb6Nsz0YStWwj+5J1MJr/MQYPZhJgwQWuD0eDis8NiPV4+Wto+0AXGAzeGTu
 ZSHKBd7Wm4HNGSH+kX2EAv14LDWWVcAPxWQu7aqoCBHK6podJt2ipplYk8CFfZKVNWYqMAhWe
 bvnRRmPGWSe8do44yRe5uPb/snR3XFOSexNcX6FQorux+fJQwVnMv1UmroiqUXHA//kyoMFpm
 OB98zSXghYnJhAY8P9WOga2K2Z4hgVvbnOLY1lrwGpml/vbOwfV80FKN1Gnhpe8Au/UDP5ZlX
 sHgzB2fKFu9kj6FvR9EFSE1wLo3As0qvE+mmTCL1pglNNc3UH6Tx+WcCA7zQqDKsxg1fInrO3
 O0XITJ36z8QS9E7dvBb9oeDWwvYUbfDxhqF0NqQJ/glFM95uv9z5KgkBYhxPhKzSbk/aRtw8J
 7dRHoQ0zIcPODQ0efAR8gZ88iIIGrG0FLntjV0bUHwdfULBOAXLaYwqafoivaQ2pyPQ3PH7/e
 H44nDRhXKkIkQ/Ju69ImlBuKKECuF6fcN5I7p20GdeHbg39fGAkEvoN6KyOx7RXXJbdt4K+Sn
 7K1fEMzKhMZeN7ZFAzQ+bAV42RVyVlWkPzBJVvvy2DmNdG2vRFAQeD8ePLpR7B421YYi60I4c
 fWAf1ZKvLaG8GxHfV8ejmLWDLdsWk8M5SdIunz4p1SBMraQsblgHP8tLuSR5BL/HsXcPXNug+
 Yk7gB++kgIuG81VJJ45Ni1XInbE+7PHN5mXZdp0gjvfsVe/djyZ7XzwiTBgQDWzk7CfwwpckG
 jfTmxI4pq1nwBpXhTZfSdcaQYjUeQmXz6eh4dcEnE+bzESjJUlKm0+CiGMMrMl5Vv8aGTLgck
 c6G4ziYv2k/X9KLSKU3naL



=E5=9C=A8 2025/6/6 07:12, David Sterba =E5=86=99=E9=81=93:
> On Wed, Jun 04, 2025 at 05:49:37PM +0930, Qu Wenruo wrote:
>> With all the preparation patches already merged, it's pretty easy to
>> enable large data folios:
>>
>> - Remove the ASSERT() on folio size in btrfs_end_repair_bio()
>>
>> - Add a helper to properly set the max folio order
>>    Currently due to several call sites are fetching the bitmap content
>>    directly into an unsigned long, we can only support BITS_PER_LONG
>>    blocks for each bitmap.
>>
>> - Call the helper when reading/creating an inode
>>
>> The support has the following limits:
>>
>> - No large folios for data reloc inode
>>    The relocation code still requires page sized folio.
>>    But it's not that hot nor common compared to regular buffered ios.
>>
>>    Will be improved in the future.
>>
>> - Requires CONFIG_BTRFS_EXPERIMENTAL
>>
>> Unfortunately I do not have a physical machine for performance test, bu=
t
>> if everything goes like XFS/EXT4, it should mostly bring single digits
>> percentage performance improvement in the real world.
>>
>> Although I believe there are still quite some optimizations to be done,
>> let's focus on testing the current large data folio support first.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix a warning when CONFIG_BTRFS_EXPERIMENTAL is not enabled
>>    The @fs_info is only utilized when CONFIG_BTRFS_EXPERIMENTAL is
>>    enabled.
>>    Fix it by remove the @fs_info declaration and grab it manually
>>    inside the CONFIG_BTRFS_EXPERIMENTAL branch.
>=20
> With all the code ready for the switch I think it's time to do it. Right
> now there are no other changes pending that could collide with large
> folios. Feel free to add this patch to for-next as you see fit.

Now pushed to for-next, with Johannes suggestion to use=20
btrfs_is_data_reloc_root().

Thanks,
Qu

>=20
> We'll have the whole development cycle for testing. It's still under
> experimental so we don't need to revert it even if some serious problems
> pop up, we'll be able to fix everything in time.
>=20
> Thank you very much for working on this. As the struct page is the
> foundation of any data transfer in the filesystem it's critical to get
> it right. The folios are a memory management abstraction taking it to
> another level where the individual page state handling can be simplified
> but it's still not gone and has to be done properly.  I hope we took
> enough caution in the preparation works and incremental development that
> there should be no big surprises.
>=20
> There are claimed performance improvements when using large folios,
> which is of course nice to have, but we'll be always first concerned
> about the correctness.
>=20


