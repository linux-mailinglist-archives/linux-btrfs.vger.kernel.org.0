Return-Path: <linux-btrfs+bounces-8161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABCF97E6F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 09:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBDAB211EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E24F602;
	Mon, 23 Sep 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UvKpf2ko"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F1228EB;
	Mon, 23 Sep 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078219; cv=none; b=O3QdeC5xNVQjavAoIpPvfqQM/gMonA9xbOa1WcUIOw88zFyfruswaZk4GQcjJltGNZzAJ34fC4kOfKpfyr7bpYWGqJLREjJlA7txxlRgV3epd5yA9lB3gSeaSWsJGT5EocZm3Kn0ar16n/NjltPjBC6cPT+bH0tKtV6PcDmT3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078219; c=relaxed/simple;
	bh=Su2WmshY2e3A+7fydRk9PHuyo5vEM2ukkwuEF+Ht7T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJ/afz4UoZHYIKxa2zKcZI6G8SuCPk6Z5W+7AUngDLixywlm0YA8iprtyy84ujntEiYtDy6u85CY+m9RZyep9+8+Lmtf69jRtbhQaFCIGcue7mtTUzo5sNtRp3qraNMfGe6uJbMaJG6ZZRPQCcyka2qz3XDQWzcC5wt56L8vV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UvKpf2ko; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727078204; x=1727683004; i=quwenruo.btrfs@gmx.com;
	bh=Su2WmshY2e3A+7fydRk9PHuyo5vEM2ukkwuEF+Ht7T4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UvKpf2koNuKYQbktePJ8potVdCuK4hyFD+QrfXBAHBH4cGQNYoOdLzmeRpUmk4Ua
	 Eu6yeYRFekHr87jG9MCjDHL0tXS9SQTwxoACM0SXI9cOt4HPceyompsYIliytXPhi
	 4aPafIqRuET+o3Ygo4Y36g6Z9aKQRa0HG9T1Q03NEEqadr+1EgcYH2pExArAFCKRf
	 rE6JYLz8uM7niR94KiaU7CAsJQimWyBMB+Q1AqwNIqzJzjya8EixR0NLD169kfYU6
	 MmHr4esLI/hOFHp5hoLmT1Wyv+37Q+w+MgJhcvr8Rpq0Cc503IopgWLKKTyAkfmRg
	 7xD5U5CsjhmLyLdTcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCbB-1sNefq375t-00PVP5; Mon, 23
 Sep 2024 09:56:44 +0200
Message-ID: <d42756f6-d5a8-4f44-a6f0-6056f5c1015b@gmx.com>
Date: Mon, 23 Sep 2024 17:26:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: WenRuo Qu <wqu@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20240923064549.14224-1-jth@kernel.org>
 <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
 <3c0c8517-a642-4e7b-bbcd-ef0022c49c3f@wdc.com>
Content-Language: en-US
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
In-Reply-To: <3c0c8517-a642-4e7b-bbcd-ef0022c49c3f@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hsD5XpYaxNhax9UezdSx8UAJ6ImiyjHWp/foLZC3hKCqGJqql/5
 Djy75fz6SwtFPiA5LH0FxZxP9GDYaUEvXM2IlsBCsAoFxmQC/qHNhbYEExifQ7HwRaZ1PpC
 kjS6roT4yZSre0sojoui/K44gf6GUAako6cfd5N65KCjfOgBu4ZLXfT+QXsYAl3wze4rvqw
 ACbt6zndOpa7Mn9/HY8wA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+t+2uznXwX0=;Q8G9cdSPF8oLTQJMmR3HsLtnhZP
 2bj3szvJIBoAdctwkyT3NQDlAeZm/WEH25eqrcx8iIDS+a8apmC75gCAZ2gbvhezKY/3T3rkX
 THcB0/UHD5r36Xt5hMrdLGy1/tiMFiUG5K3dErIRm71/P7Krak/uYOXL/ZlFWw6xturQGwyi9
 /7SGo/cX8IYRGodoVO8Sr2KxzRE9otmTYj8U6pQBzI7+/B61JwRdFT2lgwBBk1MVt5kuC6bPV
 S5C2eU3OnoLqM8WbT8orCkK+Xpq8CLPhW6OVw86gQlygJLLUuezyci5bVelCDr1XmBdKURLMX
 L+KIkc1wMPtKFBoYbWX27omrggL1qCwGzjiZKXKGSLQ1YHnMB1jTSypA5y75nFaLVgU/kzPT+
 x6iVXQDItDWAsNBQ8AefysnVqCyR9JKw3D7RGr4DfP1ZqIBTaaTWvspPIKfJ0V5+tDbrzicR7
 VcMblUcGCjED6qakAtoALZskcw96Y+izZt/4DdNKHyVK+nTe/pBnVbbdNEROF/2QH1soeo2t3
 WwxGeMS0SWLB9XXKMGwSIUKV0rl6VFatVvVmdEgH5emhZJr5mL1EFVsRk0h323b8Sk6iGuRfB
 Aj+7t7rvPJtlGS9VTUQUnqEWbs2wMb5nsFNvblQKvnYurLSXw0D6+hUwvpYo1RpYD2Cdr1chp
 Arf8dVyvIJyn0TFAskVk/o8eHJKRy+hfrPlgtUF3vPl/VzXEAuTRZnIK1PuTgE9xNn5Y563Kp
 FriME5Mz87iZk11uvD39Q15lMSH+JLUQxD2yvZDZbjpj8lSO3ou9/i3ajHlDe205uZ2soeSnh
 Llz33dyVESGNt5DDtA71m+Gw==



=E5=9C=A8 2024/9/23 17:10, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 23.09.24 09:28, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/9/23 16:15, Johannes Thumshirn =E5=86=99=E9=81=93:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> NOCOW writes do not generate stripe_extent entries in the RAID stripe
>>> tree, as the RAID stripe-tree feature initially was designed with a
>>> zoned filesystem in mind and on a zoned filesystem, we do not allow NO=
COW
>>> writes. But the RAID stripe-tree feature is independent from the zoned
>>> feature, so we must also allow NOCOW writes for zoned filesystems.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> Sorry I'm going to repeat myself again, I still believe if we insert an
>> RST entry at falloc() time, it will be more consistent with the non-RST
>> code.
>>
>> Yes, I known preallocated space will not need any read nor search RST
>> entry, and we just fill the page cache with zero at read time.
>>
>> But the point of proper (not just dummy) RST entry for the whole
>> preallocated space is, we do not need to touch the RST entry anymore fo=
r
>> NOCOW/PREALLOCATED write at all.
>>
>> This makes the RST NOCOW/PREALLOC writes behavior to align with the
>> non-RST code, which doesn't update any extent item, but only modify the
>> file extent for PREALLOC writes.
>
> Please re-read the patch. This is not a dummy RST entry but a real RST
> entry for NOCOW writes.
>
I know, but my point is, if the RST entry for preallocated range is
already a regular one, you won't even need to insert/update the RST tree
at all.

Just like we do not need to update the extent tree for
NOCOW/PREALLOCATED writes.

Thanks,
Qu

