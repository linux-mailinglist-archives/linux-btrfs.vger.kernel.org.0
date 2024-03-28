Return-Path: <linux-btrfs+bounces-3694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44188F54C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 03:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D07F1F2B26D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE23A1AB;
	Thu, 28 Mar 2024 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GEt4AnPl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A939AE7
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592569; cv=none; b=lLbhz8gqJAQsgO7islxO/cKdydfTM6/74tBBv6N9kCZUea7JPTcO0h71EVbrNb8k9JABxU3Osi/fAuyR9rI3ayhX53wh9mc6GArRbKikMOBm2bgbDsaDNFcrf/0gs9UnW8Xlhme/nkyMzwu3sQk/uaN6KW1I1L/A6QPdA99XH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592569; c=relaxed/simple;
	bh=I+0xNAEnZAE2e8ytDXOjqvSGv4JLuL5g7okJAHTBbsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJHvGJwJIKHbAuggpUJHTGG4XCkbgDjTcYIQotoKyt06bRI37a+iG+OlvRMwvGkWsTXP6lOqJMWwK+3fJk92LLnlC9qfE528RxYOb1ST969EzeG7BRN4tDZDpMW42CsE89o6bONCWCmI4bQU/aJdGt6f4EzLLBCdBtgcRzwrMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GEt4AnPl; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711592563; x=1712197363; i=quwenruo.btrfs@gmx.com;
	bh=+1/ixRFuqyJTXaMpAYLIGuw/meaWtU4nsHCviANBXuQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=GEt4AnPlm1h2vEIAo3raB4zj6ZbFfS8sKvYH5/0KKp/TJajrQ2ByXpJiJXK/kqor
	 BeSXESc2ATsviQTuqV+QgoYUfXSoICOM/RMK8fMmDSubcmQSUrBzSIuv77jrq7H3V
	 dbhPP6L83NZutNEpgp5IX61HKtrvr5lYtNBuGfElJYWNIzuX36jGnhHcNEriAs/g8
	 PjEmMGGYUCiotScczD0jMhKbnzbqV4L5dNUOG/4rLnNK5kw5YgzGhABUn5m4Nj1Ua
	 iud7S0/2Y9TrfSPSh52fosQXkwIQ0MFKgEj+GtPn+luohaGWphxAdt0Kd5a1oIOmQ
	 Qg/zwO4J5vAG9d+lJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fii-1srIeA3WlU-011wQ1; Thu, 28
 Mar 2024 03:22:43 +0100
Message-ID: <750c6ff1-8d33-4470-b914-be8e10a9e678@gmx.com>
Date: Thu, 28 Mar 2024 12:52:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] btrfs: compression: migrate to folio interfaces
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1706521511.git.wqu@suse.com>
 <20240326233335.GV14596@twin.jikos.cz>
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
In-Reply-To: <20240326233335.GV14596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2DEoeH7ZN8q+NZOVbC+PlI/gaQKZdflUHUJ5ECrsL92BVgT6UB0
 QjdGrefNuSqWROgZPIRl0udbMz1HG3MRKn1VuYnWkbpU4zbl0bEngbUkwfPOq+o4tejDv0D
 /OhHtS9c0ISeix8bxiy0R1VHeUd5yRPq0c1l8frNDym255HMTpiE6GA4ix85dMiDVvDNTmD
 ujrbd5l1wd+LR1SvXvr7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rzVBQmLX9js=;BAUScCJNc/CP8ciCAiRaiuo9GsJ
 FjKz5DwaGzqbo+bpkr/IbhqeuOyIhTV5mOS0UISv3lgq1zj6muEzOb74o6ZBN0dR/p/gNj8qn
 xiyD8vZYBreufXE0gmjECZfOio6Zug968qrlMxpp1ei1Y50K/TqGZqnZDBWFw+Unvn+mbA6Zk
 MECe7uMoIHJczrlSki0KWsp9t6ooUzVQIxjBlvP9flrEf6+8xI8t0UfuGfXFVx1Rqa3IyB/RR
 GXpm9vsq3heO5pIoMPjWsv5dg3r28S+W+DiAO+0I6fP/V2j0PxAXrhrwXv3PNnLcekdnLZ6sg
 kKA/JhonU0Zw9zgfMSPaP+iLA3iYO0wxzua5VRJMg/YIAl/G9N5uPGLiu8kjijTd7cDAlojxC
 7jU0oyWohygfUv4O6eo1b6KZDFZKoB4VEZwUAkWpKjM72ntC/Tb3KikRM4VJWgi+SgkGD0hTs
 1skbPI9lcM3nKoxzoVRPtyh2lnHtkkFoqsQ3I3ByR8T//pVNeCdoGPeTw9kuLgqMbQKa9UW0b
 r/YabvlkBvMpnPOlmEdblbGrRfkxghR2ST9WyHZzjtUNtb36yVXSRLp4JUSDcni3fVleWi3wo
 iNqc95tG4guGmfa0b+qEK3aHFkpZwOTbjz4q4jDNgMtd/Rm8OprpTHeWQd0RF4JpnRYgrYuOo
 un+zma9hWXAdXiL3XUgaagzGqvGE73p9NPf2v/wehUcvgXRJBtOvgqQT9cJSpCqD8yzqiRQO7
 kQi4fC0XWGcTGHpoaKSC0koWcutV0ebAy1BS/4d3hf9PWpqG2Pk4QRnLPCot53TSk6UPvv6iS
 CSZAaxhiG2LRf5zgZfBC21qXJTypepwzM2UisQcyRxsMk=



=E5=9C=A8 2024/3/27 10:03, David Sterba =E5=86=99=E9=81=93:
> On Mon, Jan 29, 2024 at 08:16:05PM +1030, Qu Wenruo wrote:
>> This is the conversion for btrfs compression paths to use folio
>> interfaces.
>>
>> For now, it's a pure intrefaces change, just with some variable names
>> also changed from "page" to "folio".
>>
>> There is no utilization of possible larger folio size yet, thus we're
>> still using a lot of PAGE_SIZE/PAGE_SHIFT in the existing code.
>>
>> But it's still a good first step towards large folio for btrfs data.
>>
>> The first patch is in fact independent from the series, to slightly
>> enhance the page cache missing error handling, but all later patches
>> relies on it, to make later folio change a little smoother.
>>
>> The third patch is also a good cleanup, as it allows we to pass a singl=
e
>> page to inline creation path.
>> Although during tests, it turns out that under heavy race we can try to
>> insert an empty inline extent, but since the old code can handle it
>> well, I just added one comment for it.
>>
>> The remaining but the last one are some preparation before the final
>> conversion.
>>
>> And the final patch is the core conversion, as we have several structur=
e
>> relying on page array, it's impossible to just convert one algorithm to
>> folio meanwhile keep all the other using pages.
>>
>>
>> Qu Wenruo (6):
>>    btrfs: compression: add error handling for missed page cache
>>    btrfs: compression: convert page allocation to folio interfaces
>>    btrfs: make insert_inline_extent() to accept one page directly
>>    btrfs: migrate insert_inline_extent() to folio interfaces
>>    btrfs: introduce btrfs_alloc_folio_array()
>>    btrfs: compression: migrate compression/decompression paths to folio=
s
>
> I added this patchset to my misc-next and it was in linux-next until
> now. The bug that was a blocker for folio conversions is now fixed,
> also thanks to you, so we can continue with the conversions. As this
> patchset is 2 months old I'm not sure if it would be helpful to start
> commenting and do the normal iteration round, I did a review and style
> fixup round and moved it to for-next. Please have a look and let me know
> if you find something wrong. I did mostly whitespace changes, though I
> did remove the ASSERT(0), if there's btrfs_crit message it's quite
> noticeable, and removed the local variable for fs_info in the first one.
>
> The conversions are all direct and seem safe to me, we won't do
> multi-page folios yet, so the intemediate steps are the right way to go.
> Thanks.
>

Well, since I'm reading through all the commits in misc-next, I found
some typos from myself:

- btrfs: prefer to allocate larger folio for metadata
   * No longer no smaller, must be an exact fit.
     No larger no smaller, ...

   * So here we go a different workaround, allocate a order 2 folio first
                                       ... allocate an order 2 ...

And these patches must be dropped:

- btrfs: defrag: prepare defrag for larger data folio size
- btrfs: introduce cached folio size

   These two introduced and utilize fs_info->folio_shift, for filemap
   code, which is completely wrong. As filemap always expect an index
   with PAGE_SHIFT.

Otherwise the commits look fine to me.

Thanks,
Qu

