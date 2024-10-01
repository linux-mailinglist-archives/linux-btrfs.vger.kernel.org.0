Return-Path: <linux-btrfs+bounces-8404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B198C75D
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 23:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21E71C2144C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 21:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB6A1C1AC9;
	Tue,  1 Oct 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VftekPou"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CF2B9A5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817126; cv=none; b=uWwyWKrMs4RbOX/aEd0x9mc1k1go4Dc4bE+mc6DvFq7f3cesF/l+VbSSK91fphyNgS6L2MNdtXG9qZz1poU1QcaYGqStt83X1r1Z1m0D0pfyhqxKaE1YPkKDqhzhyJMJFOF4cATzE3J7rH93qEtfLqZWCJEos5xVNZ3E9f78pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817126; c=relaxed/simple;
	bh=sDLfGFKBXvkXUQ1hT6u/iEwnFS1MUIFLo8kf1qlLRwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1ycTbPcKMBx9HJMSGRZX8g9W62ESMk9/Qu8G33tEw/ZwvPlURp4t1C4yj8gDd2nrYcK6VB6rFty2IIzXtCKykeLSE5KQPiizAPwKdN9yYbzQLO9tuNQdr8oYmvaQxTNo8aQKJGWqGUf305SKNjDa5N5+f6dFn2c+ZXkfduMbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VftekPou; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727817122; x=1728421922; i=quwenruo.btrfs@gmx.com;
	bh=gbFZFHH6qDAQtD9dTtmf9OpEXeho71GkD/0yzI3T8kY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VftekPou/1LFvAFudmyBSoKjgv70Q0VB4BK/2VRJlfbqT+nmdIylddgrEUmQAzlu
	 bE+c5goi72AZOVN14+7UQSuhcyTXRkfjyB+R+k7a+JDYfZTOPosIgJzt0RWE0s+wc
	 wHvuGFBY9UQv+D5W26/Z1EctRXcKad+KYH56yXUegQBNVBbb/H18xMhFO2tRCYUa+
	 TER9w5cMLF0TyKxCFuPagVzsmrYZ4zIUizRHGCCzjK5oMqOf63rIV6po6OH5yaUGv
	 gzFw8r2FhOSxzbpAOlO+1TXOfB0gakBMUn+5jpGZLM9gOyY+0Au+/pVoYVgeQPp4Z
	 LIBAkwfqZ4n8Q8kuzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTAFb-1sSlyg1Urf-00YIy6; Tue, 01
 Oct 2024 23:12:01 +0200
Message-ID: <f6721e0c-efce-48e2-9bea-4d023d633ed0@gmx.com>
Date: Wed, 2 Oct 2024 06:41:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: simplify the page uptodate preparation for
 prepare_pages()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1727736323.git.wqu@suse.com>
 <51064f30d856c1529d47d70dfb4f3cad46a42187.1727736323.git.wqu@suse.com>
 <20241001153045.GE28777@twin.jikos.cz>
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
In-Reply-To: <20241001153045.GE28777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xMuPSEnjfQm386YKXXiUkJMMwamDHJZXXKd1Spw0pTgcVLslVdH
 vpHBYd4rJPotEFR+PeLiy8ejYp3hNWb726KSkCjRMDJZIOl0tpfjkH/PSKQzkD6KPlalP36
 OcDd9UQ1LwkDkus4xgyLVijWXe4/CD7uoSUde6px2/5REtGd1HtfPuggPVDOSNIur95Wg+a
 c326+7M4bYDutxuzajQwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cNJ5RoR3qpc=;0dWQKPZWJz3TqKtq9t7EUJQxtQF
 K6WzldjCvf11CFoNtXsrHAUyNEwvXs0bENKzjF/N5YtskdgfINsmH4WiAhJFqIq1DF/2nnYgJ
 UlZutbV+vOGrk6zeTSkqYlH/mggxs73c3t4wL30OmgJa60YFgB5F80kRaSQymeUHzBdv88ca9
 u2zbhU4s5EEPDxnTQG4MwkDIVw2k242rtIiTzCc+tiRc+Ri3kARqi5JR3K4Cc6vY/Hc7puCyY
 YGib6Ooa/T72HD9TW7G9TTgORuKiLA/QxzhTdxdYa2lgHXuLsO6FJ99A54VqJP8ajOZ7kRtDh
 5R55//ZYQy7G7jcKVgutCryTAIHjPpeAH0N4uGVnzhXS49c7RlW4UFG3Qsj7W4DUWWbyZsB+c
 ck3g7h/lbJTtFgDQ183aCXyS9W/d9tbEQHH4BiTyhsIwBwEe0SC+mmSdul34RXu+m/W16jSYO
 O86P5dYHEYVp9+AbgnJcv+r0j/Dx29L6RteP4X+EFOXj6f5wbREncbuVeM65iZoMvlyFiObqf
 Ei4Q49fyElaINj0cRD4jegNt5nh20c1c1HRSkYzU4EcXl0+6/FG3i5R0vpemF74Wdq2eFzTcr
 RkZXby5plEjPZfjVOOaOfMaY8r6avqE7biP6OEeeIUvWHQ0b8a6wihxsyu5XJe2d6EqgRGl3h
 QzG2BVrabCVGq5xnffdr/AfkIHCPZepW9A7xwyIWx5hyeA3WSPg9SA1J1mET/fjJdL4RuU2Y7
 8NBScx5ImMgg0Cfcvp6HRiKXU6cD2E5VVtWLB6GU6l7cRv145qZas4+GqX+rolFV+Gwyzmx7g
 39vB6fogWf/feMthzqVvLq0Q==



=E5=9C=A8 2024/10/2 01:00, David Sterba =E5=86=99=E9=81=93:
> On Tue, Oct 01, 2024 at 08:17:11AM +0930, Qu Wenruo wrote:
>> +	if (force_uptodate)
>> +		goto read;
>> +
>> +	/* The dirty range fully cover the page, no need to read it out. */
>> +	if (IS_ALIGNED(clamp_start, PAGE_SIZE) &&
>> +	    IS_ALIGNED(clamp_end, PAGE_SIZE))
>> +		return 0;
>> +read:
>
> I've commented under v1 and will repeat it here so it does not get lost,
> this if and goto is not necessary here and can be a normal if () { ...  =
}
>

This is not that simple.

If @force_uptodate we need to read the folio no matter what, meanwhile
if the range is not aligned, we also need to read the folio.

And the @force_uptodate check should go before the alignment check, thus
I'm wondering if there is any better alternative.

Thanks,
Qu

