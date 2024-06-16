Return-Path: <linux-btrfs+bounces-5747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B6290A082
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 00:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D43C1C20B8D
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2024 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115186FE07;
	Sun, 16 Jun 2024 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MEmlmqA2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940691C2AF
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Jun 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718576996; cv=none; b=Pqtg7BqiQHWnBboFskUC8o1cq6FV1EDnfwlF3aTzl6ebpI+z2CTjejQuI5qxVVcgtvA2Z37MCgAOKLR40SdTxHr1TXb9Qit71NQ4n6ANuzsLG5kQmycshI2oqfcyQa6rVXtvPVGGwcXtyTZNoXKcvxWctsC34anH13kzo4GDDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718576996; c=relaxed/simple;
	bh=QfsaTUH3B/9f9AHcj+5NJuWxkw+TO3NdoFIxt434VzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZlG5lscNQSplLO3jHxtGBSe8f/7SuulO+fCWOZ1Itmy1dBF7hqZMWGd782jEJr905KmByMmIGsVHs9VuFg34wdTVraaXCggb6Aib18DQtkXt9+Gd7nuly7LcIiHS1ZY5z3vcPH8TZotSj0hfHILqdqV25z9Ci0ATYTZ9QJvkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MEmlmqA2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718576983; x=1719181783; i=quwenruo.btrfs@gmx.com;
	bh=QfsaTUH3B/9f9AHcj+5NJuWxkw+TO3NdoFIxt434VzM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MEmlmqA2ntebDWzR+XSyaCzUhgAzJupbJteVDN04PrEdmnJEA3LwikR84m4WSWmq
	 DcWoYpdrL4Utvjb6mZmWxOjW3LiPibHJzvOAysa+MqrBcmbu3L8m9nOY14odvbQqI
	 qIrztC9ELLdd8HbTnFBgJyR0/s53BvHiq+PYmcQg9ybXXVYQxpnOdED5DYwe9sf9+
	 Sjhki0WhQvq0djFJ2S9wDpOJOF9vCrMFl9S5BPaJAULeL2qAyMo4vmwm4781Snjbm
	 E2peWpFAEJ2uSeAahYDSDZ0YrysOBS2AQDCO2sM3Ac2wYDmDeKAEASy2xXF9l+eA0
	 35al3ATOIKSHmX7XtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7R1J-1sSeVe06ST-015iCY; Mon, 17
 Jun 2024 00:29:43 +0200
Message-ID: <82010e94-f2c0-4f38-980e-6b99d5e75eed@gmx.com>
Date: Mon, 17 Jun 2024 07:59:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] btrfs: scrub: don't call calc_sector_number on failed
 bios
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Qu Wenruo
 <wqu@suse.com>, Johannes Thumshirn <jth@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
References: <20240610144229.26373-1-jth@kernel.org>
 <16516c00-845c-4cb8-9bb5-6e5e38bc71c3@suse.com>
 <a04c6fb6-bd77-400e-a80b-178dd2e6c582@wdc.com>
 <cfa1ca63-0bbe-4287-b941-0b064fa0a489@gmx.com>
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
In-Reply-To: <cfa1ca63-0bbe-4287-b941-0b064fa0a489@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:doFf3SqY6VWHiCIKmHW2fOEf+EGVkdUWsowJX2eTrlCcXa3UpFS
 d0krAQIrTNRZSJslxhgx+YDPCaQdZ9jZAdA1x1NZSogUsK+s9WcVdfF5W6RVNDf0Vb337jw
 k6bULVf9gbh0PkqEYO0TnaQCojsn7RUVZIXla2JEG1nhgCiiEQ5niihydhmTdbvezdSmklr
 G6puMPEyHTW27Hga65vDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cfCTbTPruJM=;Yu16GTOJvhterRhNdPxnW+3DzIt
 LQ1RRVBk20371dfRUEYyCY1/V9NOecVj+Ml9FO8CuKcnWisq+Eb666k0OATtY7/9hqiviRYDV
 5b4euXGub28zUfT2AOMhTlQTaxukzI2RRs2fOJH76LBLeeDwKSDnfIxJqBywgN2ya9tEWgk/Q
 Lv1tvUQUZpR9L7GneumcH3YEq7WGUQ8KttlHWZdjZlwqYxoh81c+MFrZ8IXieeoS/iKpmShKx
 JT1aR3urM5SGs7laQ5qqLjY43P0cqvZa/soaNHHR0jpKwTz6xdofm7DZVqwhBiPyQnKlbyidY
 h7l+nuf96rP2feHaPxQ17YZ0AqXJdBXmDuZpuvdKKUMDi6Zh6qgUxG5Nv91TD2xh1UTTeaai3
 kHbf3oc/mZHHVTvV/U9w67PMuBhz6XLQYJ6eETOEzZ/eOGtjVHTF3UGuBq8faPAcRQZ7mwhBQ
 SIAhHawRMGPb1J+zS5//xoyR93iKnDF3MBNSzwelICKqJcDnfLS7sH7t6mi5/X9b9iBEnNkEF
 JvqAAz+JJEyaC752LV4LreMMGJPCf0Vr92/xxb7AD4LnEq8daa24TMqSQBkMT1ElOHTD3NiOr
 89/Giq6ni0CIlG4tA6q38ngzA9y9qHI+27JA1v0pI1ZQkokjW3PI1t+184p/r9LDQnqF/hIME
 r6C56N60JIAymFUEXeiHFHWkvwSpNtacIzgESruXydFuCJsH5QSV4HI6fGB33/G6spprw0TJ6
 jmM3PmpI4dt13pZBnwtd+F+XJN7CGLAIRNi2D0RLASKksWhAJ5cvtkOVOJFgswGhi2RmiCDYL
 ERALrxFXI9SZ208AiFXx7AFAxQhuepFaCk0y+TV7dc280=



=E5=9C=A8 2024/6/17 07:44, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/6/11 15:56, Johannes Thumshirn =E5=86=99=E9=81=93:
>> On 10.06.24 23:24, Qu Wenruo wrote:
>>>
>>> =E5=9C=A8 2024/6/11 00:12, Johannes Thumshirn =E5=86=99=E9=81=93:
> [...]
>>> I'm more interested in why we got a bi_vec with all zeros.
>>
>> Yes me too, hence the RFC. TBH I was hoping you had an idea :D
>>
>>> Especially if the bv_len is 0, we won't update the error bitmap at all=
.
>>>
>>> So it's not simply ignore it if the IO failed.
>>>
>>> To me it looks more like at some stage (RST layer?) the bio is
>>> reseted/modified unexpected?
>>
>> Most probably. But btrfs_submit_bio() will only split a bio if it's
>> needed (due to i.e. RST stripe crossing, etc).
>
> I guess I got the direct cause, but not yet to the root cause.
>
> [DIRECT CAUSE]
> It turns out it's not RST layer, but the RST handling inside scrub
> causing the empty bbio.
>
> In `scrub_submit_extent_sector_read()`, everytime we allocated a new
> bbio we call `btrfs_map_block()` to do a scrub specific map lookup.
>
> But if that `btrfs_map_block()` failed, the bbio is still empty, but we
> call `btrfs_bio_end_io()` on it, resulting such problem.
>
> The problem is happening because there is no other error path inside
> scrub that can lead to such empty bbio.
> All other paths go `btrfs_alloc_bio()` then immediately add pages into
> it (either the whole stripe or a simple sector).
>
> [PROPER FIX]
> So for the fix, I'd prefer to do a 0 length check first.
> If it's 0 length, we do not need to get the sector nr and error out
> immediately.
> If it's not zero length, go the regular routine to mark error bitmaps.
>
> Meanwhile the RFC fix has the side effect that, if a non-RST read scrub
> bbio ended with error, we can wrongly updated the error bitmap (since
> the sector_nr is set to 0).
>
> [UNCERTAIN ROOT CAUSE]
> Then let's talk about the ugly part, why `btrfs_map_block()` failed?
> In the dump, it shows there is no such RST entry found for the target
> bytenr.
> Meanwhile at `fill_one_extent_info()` we fill `extent_sector_bitmap`
> correctly using commit extent root.
>
> This means, by somehow the extent commit root desync with rst commit roo=
t.
> My current guess is, between we do the extent commit root search and do
> the rst commit root search, a commit transaction happened.

My bad, this is impossible and during transaction commit scrub would be
intentionally paused to avoid such commit roots mismatch.

So it is something different.

Thanks,
Qu
>
> This is not a problem for non RST case because we only did the extent
> root search once, and in one go, so there is no transaction commit
> happening between.
>
> But for RST-routine, the RST lookup happens much later than
> scrub_find_fill_first_stripe(), thus it could happen a transaction
> committed, updating RST.
>
> My current plan is to do the RST lookup inside
> scrub_find_fill_first_stripe too, so everything can happen at the same
> transaction.
> But I'll need to do extra debugging to confirm the guess.
>
> Thanks,
> Qu
>

