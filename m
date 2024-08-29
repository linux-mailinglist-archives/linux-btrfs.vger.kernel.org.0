Return-Path: <linux-btrfs+bounces-7672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A2096522F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4974C287086
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298521BA863;
	Thu, 29 Aug 2024 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UTiIUCOM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1528685
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967634; cv=none; b=gl6r4Y3Wf0sjWtqF94BtICaCerkOGhWPXYcV+ZLtBKmdBR62B12Mkvt4Ar/kB0fHxLu6XHauE0Z/gg7FcFA43paNE18SlQgVzSjZVsbeYw4+QNJCsC9ZZ5YDuC7slD9b3vNbUtvP+t7k/d1UHKk+S3UDAN6/iDwgz2OJXZbfqkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967634; c=relaxed/simple;
	bh=9j4iHyKCcRsMvb0mfO3vtseiVFUWioJsYbivVcNTOYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCyOekOAaRoZHizaMmQwTTPh7wyrNBcggxHdddmTDe2yCJPKlQtRYyrRB3mF0I4fFD4AK+XN5xVvwmDsgaF+grC2XOi2iA7UHKX6sEu+u2Z/9zpHtY/T/IkCC3emCLWX0zGmJiJqsXVsoM7uUlSKpADmpdPBXETVOnvW89a0vBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UTiIUCOM; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724967629; x=1725572429; i=quwenruo.btrfs@gmx.com;
	bh=SBVnOcLDCFWUi86d5V71pSQ3xAa23ox+AKj/29ux+FQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UTiIUCOMHzO2KGqjrvy9wjk40yciAdBp1Ig1cc+iz5iIg4sjENcgK+bM0A7wqfbR
	 e2LqD5PeHi2aTgoMF+l+vpuMI5aqfxSMH3Fkel+f+86LOd6W3c1nidml4XueUNy4x
	 ymEOjoJX/o5RE8BYgCDKOKcUOTBBe5hrpKaI2B42uj+MHIzSg1JxTPqD9cEUN0+tv
	 3y77tEG5eTR7JKujut2fuIsari45AYYtdKyuVavzt0SQQgwNaDzwpsu2dn8bmD7/E
	 JDRC0OJ5LO5yhhvmZ+LNdzhBXBDhwEzvTBDdlJHuQIrMd/NLiU+30UxLG010rF5vi
	 aK0OfJtiPpgYb0r7Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mg6Zw-1s9ud82EUo-00fy7V; Thu, 29
 Aug 2024 23:40:29 +0200
Message-ID: <242d783e-90f8-4ec9-96b7-b77fee13cb94@gmx.com>
Date: Fri, 30 Aug 2024 07:10:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: reduce extent map lookup overhead for data
 write
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1723096922.git.wqu@suse.com>
 <20240829180009.GP25962@twin.jikos.cz>
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
In-Reply-To: <20240829180009.GP25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vRAwYycg7/syC38TzsmPpiJIqdCqAcusG4+n8vucs/jyiYmpY5m
 z86v5tiJTvZijtabMwixTTMFC08qot3S4dEmd+k7nwhjgo3SB0M7ALhTa0xG93c2KDuVvt5
 fst5qO8Ri4W78RwFN/3fleEfy9MQQPQ3AOGWXokMThOZpBvlTqci4Frq6459dEcnNpdBT4i
 b3InS1ekMwCPYHFt9JAqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DlZLu55AhS4=;/MVSx4ILEu+NaojAw6ViIoz4/WS
 iZ2yyhDVNGI3SPXGu/8AG0K7rAV6EbhYifAaihIy0hoOBEdOtdVN+EbxXDtY7EHvn+BFi3Svr
 mtsm0fcAuBiGRDJ5dvAXKDg2dlrvc/Txav/vNiUpRMM+eHtdV32ZB6drOTXGjHX3UWV4wIHWp
 WKgZl8LCmvUQmmzD4dCouTxQd253FcI2A4YiBWTUu9fIraGnWYSYF7id9c6XEG51JRkM06Ref
 33UnEVelYy73gLRXXGDBPr3MbXmPHMUIVTHTwSoZQZjmxlh346bZE4GDO/7AIvf/VrNfPidQM
 nLMnlX9Wc+apnlTS7yzeVtpDGmcjNs/pl8t9B4fRR+EOIgFvEeQgiCNHrLpjI8yNGkZImSAYX
 8v8u2kHeUg8rodCudvjWDiYxV5w4xtz6G2FW5Rc6V/7F4XEvjVNiTqh5FG0xOgaNpuUr/zgHH
 tRc2uO9SMl/pRwdcK5UjaW63/UYe3RdbZ7W/Lj+PUMbcx2+FMpzYZFRgNRSOs37qBhBMOKXmp
 ZhV3/wsJzeL8BKYEDLY/eZCaxHeDNAAQkJxegTeXdlK98XF5i0se2bcUZI4km96oejHGI5AX+
 9SGhq5LXz1qWiAI8cHj9ED3hL1wQCpZTGQAnpbNjH7iPukL0om+RM91WOYNS173ovTle06V3L
 JrdRpf0vWiCQnIAI3JMcU0jnwt9RTHYCivIsQtPITbcX/XlEJQ8wHd6r/l84hKCbVpKljpqsu
 vYRW5OKyy2dkcfM3TIdP9CA7yw8XEG0QzFDfjlj6bkiQfVdvR5NmaHGfFmuXspM2gup7UShCY
 vyBo7uTBNMAzYLvbQ/wwaDrg==



=E5=9C=A8 2024/8/30 03:30, David Sterba =E5=86=99=E9=81=93:
> On Thu, Aug 08, 2024 at 03:35:58PM +0930, Qu Wenruo wrote:
>> Unlike data read path, which use cached extent map to reduce overhead,
>> data write path always do the extent map lookup no matter what.
>>
>> So this patchset will improve the situation by:
>>
>> - Move em_cached into bio_ctrl
>>    Since the lifespan of them is the same, it's a perfect match.
>>
>> - Make data write path to use bio_ctrl::em_cached
>>
>> Unfortunately since my last relocation, I no longer have any dedicated
>> storage attached to my VMs (my laptop only has one NVME slot, and my ma=
in
>> workhorse aarch64 board only has one NVME attached either).
>>
>> So no benchmark yet, and any extra benchmark would be very appreciated.
>>
>> Qu Wenruo (2):
>>    btrfs: introduce extent_map::em_cached member
>>    btrfs: utilize cached extent map for data writeback
>
> This looks like a good optimization, we're approaching code freeze (next
> week) so it would be good to get it merged by then. As it's an
> optimization we can also postpone it if you're busy with other things.
>

I'd like to postpone this one.

The biggest problem is, this is not working the last time I
micro-benchmarked the whole thing.

It turns out that, with the new code the latency to lookup an extent map
is in fact larger than the existing code.

Maybe related to the extent map shrinker which is doing a too good job.

I'll refresh this series when the em shrinker get stable and I can
re-benchmark the result to see if it's still worthy.

Thanks,
Qu

