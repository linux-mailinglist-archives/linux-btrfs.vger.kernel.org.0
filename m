Return-Path: <linux-btrfs+bounces-2181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9384BFFF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 23:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E4F1F23DB1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8FA1BF47;
	Tue,  6 Feb 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JQ1MgHMa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6EC1BF24
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258397; cv=none; b=gNmEp5TLP5rHe6T1K8ch+Vzpd8ObpGG16j88sPDnm1xp69t5l/ZIQO2yEk9hOc1uWVPJGy2nqeFD/FRl0+puSnyZ4v6CN6Y0NXM/cO+tB1wVhgkKhLllnICg2HsCaZsTgvG/V5WUPGOV/w8AEUrUSwFVQarJDUesKc9QQUG/BXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258397; c=relaxed/simple;
	bh=XLRqn3q3SrhIlwKmwh9WhLknyNYkVNhPkFEz/tM+9iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/DZNpNUHUrMI8/dvX+oCiUx7S4XZmY6eBvf5pfEcRSXy3p1SktSkwS1kOUYTl2BftvGVWZaX4oXa3QnfbDC2dt2e5d7QIhv0be6hxO5jiPXzCBt00YJAy279H+Ngs9yzeP7pOSLjHW9hGSQ4AM/6M4MRJ2Un2OIycCjLdrp28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JQ1MgHMa; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707258388; x=1707863188; i=quwenruo.btrfs@gmx.com;
	bh=XLRqn3q3SrhIlwKmwh9WhLknyNYkVNhPkFEz/tM+9iI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JQ1MgHMa3LRSguuX1Su9umqfxBD3M5vPfHzqU46baA0qT9yR8nRSEA35nkIjTcra
	 jSmM2JSqPq1d8IXgbpEyCD30dghF/BxL6xa6+2mnvcaYEzVOoS9Qew/zh23BXjFT1
	 edekBeXqzo99h7MUrtcpRBbT1FuSewwjaCD5+xoMrKQ/8ZnxH6IV5dZPCvLwJiOmy
	 ly22PPkj+MqEeGPG9+6GgHLZhnQ+bLhR+SsmqJ/87uxzO/ntlm/wAErUxs3KCl5tk
	 r3tCiW1TzA+GeGOvdtFOH2GrmAi6aFrgINLahTdkNsGdnSY0n768z4oDWsP3vHh8p
	 R6o33guYhXfRFC6MKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QWA-1rbrbn1yfw-004PlQ; Tue, 06
 Feb 2024 23:26:27 +0100
Message-ID: <ffd42e62-b506-40ac-aeb4-c84edf0e5365@gmx.com>
Date: Wed, 7 Feb 2024 08:56:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: defrag: add under utilized extent to defrag
 target list
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 Christoph Anton Mitterer <calestyo@scientia.org>
References: <cover.1707172743.git.wqu@suse.com>
 <2188d9521696a2c5f9bbb81479c6c94ea827a0aa.1707172743.git.wqu@suse.com>
 <CAL3q7H72pQ=3wPZpN9zow8+G4xnhSP5UKH1ev808Y5GYYB2BQw@mail.gmail.com>
 <54a1bb50-7fd2-440f-8563-a82c54bb2179@gmx.com>
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
In-Reply-To: <54a1bb50-7fd2-440f-8563-a82c54bb2179@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FldGzY6JZdGOIh8DG1v/Bxb4HhbyHKjicu0n9a6o6PtojU7hliQ
 MJ9y93xhXhes2tX0JfLluS2pVoq5Dr0JkAnheROqzGByWsPdEHsNlLJAxjcN8sV+97AnOQv
 SOoP3eFzC6soiq1XMpaE+8GNk3+4foT1Vtv9OGqiugK05Et49h149ESn0qyPUHiwLzOSDZa
 HDB5Yi/HAd2APB2lcLdUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mXpXzSLZxHc=;Dyk92LD+uSbacB8QVns78wfV+xC
 GScf27OkzUit1mRYyzf9KJpPt9XQfsfjhj+IVNi33DJoEjp9+xksg5ghJCwAvkvwNEL5MGzoS
 0wWLLLaN8ziVyv0IS8kCBh5WvnJLDvErd3rXQC6iQceqa2WjQLaqT49/qCbQzIzTmUM79n9IP
 MQZah9CVrjXFTtPXgoglxuOXB9Nku2nyxfX3Drr+m09Pk4IwvjoegLZeO2u7jjzk3CHXNkEWU
 UW5RmKg0UXlPgr+IKednUy33k50OXbDycaYEna8YtDypZ5l8q9fFTrGzQ1VCkt7k9yX1MizXo
 2oziNZ4nSdGZGC/fSvWjLw5DJdeeB7u5aIiRVgbzv6UxHI97W7TAH/Jn4nLOJlC8tkTJZJjy+
 Wr4qpvUFiJFRg/gBKMK098ut9jR3l2ZcX6+oiCi50/DwW3XkBmWdk8TaRe8LptwABUOUVrBf1
 bkATTVTErJXo06Rc8YNJkPhc9jUwEGvzBQGT3FRtjFeEji+icWJHjigyyJU03w3wrf+QbVTA2
 0ywMuiq/JbHCQzWMLsaLu4hfCggrbELYSP86rVwP9Ebf29B5PCxd45dWw/jbL3f3dGrvQRRpw
 wql7F+RWentPq0iBkNpoEJyZq7X9+kFNMeVV2vRGRo7S2PGGI47EFG9AwO6JfryHj9ybpJy5P
 06pNkGqdMZ5Y/U3wZDlxqEQg5PCOc/rqkLglkDAHjA4lJv2sPzk0DiCV3nhGXuPfxu7w/PInm
 lRcgLJNjAUylTj73dmNFIM2C9olB85SMq9u8ZDX/JJVp9WK45q66k4d9KUp5PVcuP5X5HgejO
 TDKPoUVGdausfBPN56sxKhMGaFMHJqiMdQz4NN8JaEa2s=



On 2024/2/7 07:11, Qu Wenruo wrote:
[...]
>>
>> item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
>> generation 7 type 1 (regular)
>> extent data disk byte 1104150528 nr 134217728
>> extent data offset 0 nr 8650752 ram 134217728
>> extent compression 0 (none)
>> item 7 key (257 EXTENT_DATA 8650752) itemoff 15757 itemsize 53
>> generation 8 type 1 (regular)
>> extent data disk byte 1238368256 nr 33292288
>> extent data offset 0 nr 33292288 ram 33292288
>> extent compression 0 (none)
>
> This behavior is unexpected, as we should redirty the whole 40M, but the
> first 8.25M didn't got re-dirtied is a big problem to me.
> Will look into the situation.
>

Got the cause.

The problem is related to a check in the existing code:

	range_len =3D em->len - (cur - em->start);

	/* Skip too large extent */
	if (range_len >=3D extent_thresh)
		goto next;

Since the range_len is to the end of the extent, thus at the beginning
8MiB it's always larger than the 32M extent threshold.

But at around 8M, we no longer meet the 32M extent threshold thus begin
to defrag the remaining 32M.

To me, the check itself is not correct, it should go em->len instead.

But on the other hand, that "goto next" would skip our wasted
ratio/bytes checks.

At least with that fixed, we won't make the situation worse though.

I'll submit a fix for it with a test case.

Thanks for exposing the bug,
Qu

