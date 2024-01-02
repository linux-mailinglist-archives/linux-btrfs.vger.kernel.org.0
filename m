Return-Path: <linux-btrfs+bounces-1198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA78224C7
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 23:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8064E1C22D8B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 22:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1B6171D7;
	Tue,  2 Jan 2024 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cN/xq2oT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039F18028;
	Tue,  2 Jan 2024 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704234772; x=1704839572; i=quwenruo.btrfs@gmx.com;
	bh=7JK2tgr2QMIo2rxPSt5WKMo4YMClV2H9bTS9r5aDFos=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=cN/xq2oTx7PlNW+oeEJtbo7FeCfU4xfH06FgKUFlwJQeeacHbwM+YPi6udDu/EdY
	 psi1RmDb1miB/NU1YLkVcoXZKwrpWSny27+M4vdvDbHbedgbeP53DWpYbKrfd5Kvv
	 Ga/9FBi5WHHIkM/UPXeB6Cll6ErbFQ9cRYsjNbt69q4w4T5kNFl4O+RqAD9srVXPT
	 ++DK2p85SaDOpTFHO6E0Jdy2bLQnM+0/oWERGwx1ji05L+6btfxE7B6FB77Eey+C5
	 0x+q+HL18MM+GOpAy2c/OA8gSqP1N2soWv9Id7AIJn+n/PYTpGK7LcJtCYPeyZn3B
	 U+sFqIaePjbrjgLQwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU0q-1qkM6R0EDc-00aRk0; Tue, 02
 Jan 2024 23:32:51 +0100
Message-ID: <ee1896b4-c79d-409d-8388-6cc53d171740@gmx.com>
Date: Wed, 3 Jan 2024 09:02:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [btrfs] 8d99361835:
 stress-ng.link.ops_per_sec -18.0% regression
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, David Sterba <dsterba@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, Qu Wenruo <wqu@suse.com>,
 oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
References: <202312221750.571925bd-oliver.sang@intel.com>
 <20240102162620.GA15380@twin.jikos.cz>
 <ZZSLpjttJec+t1CQ@casper.infradead.org>
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
In-Reply-To: <ZZSLpjttJec+t1CQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aYCCCTzqg8KC08BLLVflbEP9lMV2qQDIMcB/Bg2LpuF8hul6mCK
 kLBhvUlDnFQflHju+Y2CT+288w1sORQSVw03d3HoKMZX+btA+mf+AKL+zyGu5Z4rrVHMtpu
 /jO9ilP1/xUh8EzzsFiaSQBHHtGKwflGDYIzZxO799L7nprpx0RBJz01nrNFVpypi6Mno6o
 WdwO+gCqBBVlZP99vx6OA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dMa/WWrnHEg=;DlB/JXL2eTbU4aPQIkWbKaD2wYY
 qsLIzulCXkY8A7U5Uv9e3XbYUFzb2T44QBb2lBR97sD/87LeptyoMv1oOjgBqgILDJvgDjCU+
 QCqC397I+PhVw8IVFKt4Fs5Cu8u7h79VeiWI8hQgRLMTML+WpbesWhQ+GRx2/auutR53m1pDo
 IMAcJ/XFuH4X6EI4hGhJGZ2cRGq9Cog24uPXws9Qi1QIZ440r4jiYZAp5uOeUUvLtSJNBj6Qu
 55kORAw0iRTCmzpui+oD5x69U+RwT23ctXOi93SAlf1ZgN2NEC+NVqYTb2KhNVduwRjbXKX0M
 A/oBGxZdHHobntrgeoUB32ngLmR4Kz0Uqji0w1GiO3Yhbd15UleXYr9KSgYCgTQaC/X9Rz7mn
 dkpzinWhUXNkhr2BBJNN3Xu8hTBTmHqbFoJyqRn9vOrBnGvG7lEWqWOAzTmwP0Vp+vZUxSZtj
 sQRcOEQTw7w1tOAcig1bEiZtj4aDKVO1Vj0hXvuF2REP+N0drKDQv6IndPBNZ3aSc/OVS70da
 QGzqFvAgCgxbE7hEQrPZKQX5eOve722+wIkqgeWfryeVlo5hYbooB99FEh38qTXkzY1kkMyCF
 hfWaBNJ3KqmJqFlBDck+cguk17Cjtr5OX0suwlKnhhqzrC/ogzJxCc5kEu2X7oxLaJ2zy98CP
 5DkikphY/eQffzl3KHol/EkFd3T3u64/RaR9xD4JjvfafiwBMaq+0rX/bNI+lJ92i1dHO8492
 fQ4csV+mTen2c6jnyhGol6CluWtYU3SCAxr8py8eDH0YiM4D7Bqi7ejff84lCA7A4oU9HZKoo
 XH4pa87y40GiCXj5uFa/avLovG3BK1aAqIeJuN2KivK0eNDTBB0cdX0+mb4qWIdrMzpHANNWg
 HKOGyDjzxoBQFUaTmHEiVcq3g0ed49lfqPo2P/FAmdgoFsFSPnoMKca9XsUAc2Um2bbA8NcaN
 ehQLKf3b2E1jWTP3T1CNzDj3mBc=



On 2024/1/3 08:48, Matthew Wilcox wrote:
> On Tue, Jan 02, 2024 at 05:26:20PM +0100, David Sterba wrote:
>> On Fri, Dec 22, 2023 at 05:59:34PM +0800, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed a -18.0% regression of stress-ng.link.ops_pe=
r_sec on:
>>>
>>>
>>> commit: 8d993618350c86da11cb408ba529c13e83d09527 ("btrfs: migrate get_=
eb_page_index() and get_eb_offset_in_page() to folios")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git maste=
r
>>
>> Unfortunatelly the conversion to folios adds a lot of assembly code and
>> we can't rely on constants like PAGE_SIZE anymore. The calculations in
>> extent buffer members are therefore slower, 18% is a lot but within my
>> expected range for metadta-only operations.
>>
>> This could be improved by caching some values, like folio_size, so it's
>> a dereference and not a calculation of "PAGE_SIZE << folio_order" with
>> conditionals around.
>
> You're in the unfortunate position of paying all the costs of a variable
> folio size while not getting the benefit of variable folio sizes ...

No worry, IIRC the -next branch does NOT include the patch to enable
larger folios, just to shake out bugs during the conversion.

We're getting higher improvement already in previous -next branches
which included something reflecting larger folios (not exactly the same
behavior, but using vm_map).

>
> There's no space in struct folio to cache folio_size().  It's an
> loff_t, so potentially huge.  Also there are people who have designs
> on the remaining space in struct folio for a variety of purposes.
> Would it be better to be PAGE_SIZE * folio_nr_pages(), which is cached?
> That's at least dereference, then shift-variable-by-constant, rather
> than dereference, shift-constant-by-variable.
>

The cache would be in btrfs' specific structure, extent_buffer, so no
affect on MM layer at all.

My plan is to cache a u8 for shift (which can be fitted into some hole),
and u32 for the folio size (which is only 1.5% increase in the size of
extent_buffer).

Thanks,
Qu

